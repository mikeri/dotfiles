#!/bin/sh
# Vibe coded port of rifle.py from ranger to posix sh

verbose=0
if [ "${1:-}" = "--verbose" ]; then
    verbose=1
    shift
fi

vlog() {
    if [ "$verbose" -eq 1 ]; then
        printf 'rifle-sh: %s\n' "$1" >&2
    fi
}

trim() {
    s=$1
    while :; do
        case "$s" in
            ' '*) s=${s#' '} ;;
            '	'*) s=${s#'	'} ;;
            *) break ;;
        esac
    done
    while :; do
        case "$s" in
            *' ') s=${s% } ;;
            *'	') s=${s%	} ;;
            *) break ;;
        esac
    done
    printf '%s' "$s"
}

lower() {
    printf '%s' "$1" | tr '[:upper:]' '[:lower:]'
}

shell_quote() {
    printf "'%s'" "$(printf '%s' "$1" | sed "s/'/'\"'\"'/g")"
}

regex_match() {
    printf '%s\n' "$1" | grep -E -- "$2" >/dev/null 2>&1
}

find_config() {
    if [ -n "${RIFLE_CONF:-}" ] && [ -f "$RIFLE_CONF" ]; then
        printf '%s\n' "$RIFLE_CONF"
        return 0
    fi

    config_home=${XDG_CONFIG_HOME:-"$HOME/.config"}
    for candidate in \
        "$config_home/lf/rifle.conf" \
        "$config_home/ranger/rifle.conf" \
        "$config_home/rifle.conf"
        do
            if [ -f "$candidate" ]; then
                printf '%s\n' "$candidate"
                return 0
            fi
        done

        if [ -f "./rifle.conf" ]; then
            printf '%s\n' "./rifle.conf"
            return 0
        fi

        case "$0" in
            */*)
                script_dir=$(
                (
                cd "${0%/*}" 2>/dev/null && pwd
                ) || printf ''
            )
            if [ -n "$script_dir" ] && [ -f "$script_dir/rifle.conf" ]; then
                printf '%s\n' "$script_dir/rifle.conf"
                return 0
            fi
            ;;
    esac

    return 1
}

mime_ready=0
mime_value=

get_mime() {
    if [ "$mime_ready" -eq 0 ]; then
        if command -v file >/dev/null 2>&1; then
            vlog "mime lookup via file(1) for $first"
            mime_value=$(file -b --mime-type -- "$first" 2>/dev/null || printf '')
        else
            mime_value=
        fi
        mime_ready=1
    fi
}

run_command() {
    command_part=$1
    flags=$2
    full_command="$files_set_cmd; $command_part"

    if [ -z "${PAGER:-}" ]; then
        PAGER=${DEFAULT_PAGER:-less}
        export PAGER
    fi
    if [ -z "${EDITOR:-}" ]; then
        if [ -n "${VISUAL:-}" ]; then
            EDITOR=$VISUAL
        else
            EDITOR=${DEFAULT_EDITOR:-vim}
        fi
        export EDITOR
    fi

    background=0
    case "$flags" in *F*) background=0 ;; esac
        case "$flags" in *f*) background=1 ;; esac

        vlog "exec: $command_part (flags: $flags, background=$background)"

        if [ "$background" -eq 1 ]; then
            if command -v setsid >/dev/null 2>&1; then
                setsid sh -c "$full_command" >/dev/null 2>&1 &
            else
                sh -c "$full_command" >/dev/null 2>&1 &
            fi
            exit 0
        else
            sh -c "$full_command"
            exit $?
        fi
    }

    evaluate_line() {
        line=$1
        phase=$2

        cond_part=${line%%=*}
        command_part=${line#*=}
        cond_part=$(trim "$cond_part")
        command_part=$(trim "$command_part")

        if [ -z "$cond_part" ] || [ -z "$command_part" ] || [ "$command_part" = "ask" ]; then
            return 1
        fi

        has_mime_cond=0
        has_positive_mime=0
        has_negative_mime=0
        positive_ext_present=0
        positive_ext_matched=1

        remaining=$cond_part
        while [ -n "$remaining" ]; do
            cond=$remaining
            if [ "$remaining" != "${remaining#*,}" ]; then
                cond=${remaining%%,*}
                remaining=${remaining#*,}
            else
                remaining=
            fi
            cond=$(trim "$cond")
            [ -n "$cond" ] || continue

            neg=0
            while [ "${cond#'!'}" != "$cond" ]; do
                neg=$((neg + 1))
                cond=$(trim "${cond#'!'}")
            done
            [ -n "$cond" ] || continue

            cond_name=$cond
            case "$cond" in
                *[![:space:]]*)
                    cond_name=${cond%%[[:space:]]*}
                    ;;
            esac
            cond_arg=
            if [ "$cond" != "$cond_name" ]; then
                cond_arg=$(trim "${cond#"$cond_name"}")
            fi

            if [ "$cond_name" = "mime" ]; then
                has_mime_cond=1
                if [ $((neg % 2)) -eq 0 ]; then
                    has_positive_mime=1
                else
                    has_negative_mime=1
                fi
            fi

            if [ "$cond_name" != "ext" ]; then
                continue
            fi

            if [ $((neg % 2)) -eq 1 ]; then
                ext_is_positive=0
            else
                ext_is_positive=1
                positive_ext_present=1
            fi

            cond_ok=yes
            value=$first_ext_lc
            pattern=$(lower "$cond_arg")
            if [ -n "$value" ] && regex_match "$value" "$pattern"; then
                cond_ok=yes
            else
                cond_ok=no
            fi

            if [ $((neg % 2)) -eq 1 ]; then
                if [ "$cond_ok" = yes ]; then
                    cond_ok=no
                else
                    cond_ok=yes
                fi
            fi

            if [ "$cond_ok" != yes ]; then
                if [ "$ext_is_positive" -eq 1 ]; then
                    positive_ext_matched=0
                    continue
                else
                    return 1
                fi
            fi
        done

        require_mime_phase=0
        if [ "$has_mime_cond" -eq 1 ]; then
            require_mime_phase=1
        fi

        if [ "$positive_ext_present" -eq 1 ] && [ "$positive_ext_matched" -eq 1 ] && [ "$has_negative_mime" -eq 0 ]; then
            require_mime_phase=0
        fi

        if [ "$positive_ext_present" -eq 1 ] && [ "$positive_ext_matched" -eq 0 ]; then
            if [ "$has_positive_mime" -eq 1 ]; then
                require_mime_phase=1
            else
                return 1
            fi
        fi

        if [ "$phase" -eq 2 ] && [ "$require_mime_phase" -eq 0 ]; then
            return 3
        fi

        flags_local=
        needs_mime_deferred=0
        remaining=$cond_part
        while [ -n "$remaining" ]; do
            cond=$remaining
            if [ "$remaining" != "${remaining#*,}" ]; then
                cond=${remaining%%,*}
                remaining=${remaining#*,}
            else
                remaining=
            fi
            cond=$(trim "$cond")
            [ -n "$cond" ] || continue

            neg=0
            while [ "${cond#'!'}" != "$cond" ]; do
                neg=$((neg + 1))
                cond=$(trim "${cond#'!'}")
            done
            [ -n "$cond" ] || continue

            cond_name=$cond
            case "$cond" in
                *[![:space:]]*)
                    cond_name=${cond%%[[:space:]]*}
                    ;;
            esac
            cond_arg=
            if [ "$cond" != "$cond_name" ]; then
                cond_arg=$(trim "${cond#"$cond_name"}")
            fi

            if [ "$cond_name" = "mime" ]; then
                if [ "$phase" -eq 1 ]; then
                    if [ "$require_mime_phase" -eq 0 ]; then
                        continue
                    fi
                    needs_mime_deferred=1
                    continue
                fi
                if [ "$require_mime_phase" -eq 0 ]; then
                    continue
                fi
            fi

            if [ "$cond_name" = "ext" ]; then
                continue
            fi

            if [ "$cond_name" = "flag" ]; then
                cond_arg=$(printf '%s' "$cond_arg" | tr -d '[:space:]')
                flags_local="$flags_local$cond_arg"
                continue
            fi
            if [ "$cond_name" = "label" ] || [ "$cond_name" = "number" ]; then
                continue
            fi

            cond_ok=yes
            case "$cond_name" in
                ext)
                    cond_ok=yes
                    ;;
                name)
                    if regex_match "$first_name" "$cond_arg"; then
                        cond_ok=yes
                    else
                        cond_ok=no
                    fi
                    ;;
                match)
                    if regex_match "$first" "$cond_arg"; then
                        cond_ok=yes
                    else
                        cond_ok=no
                    fi
                    ;;
                path)
                    if regex_match "$first_abs" "$cond_arg"; then
                        cond_ok=yes
                    else
                        cond_ok=no
                    fi
                    ;;
                mime)
                    get_mime
                    if [ -n "$mime_value" ] && regex_match "$mime_value" "$cond_arg"; then
                        cond_ok=yes
                    else
                        cond_ok=no
                    fi
                    ;;
                has)
                    if [ "${cond_arg#\$}" != "$cond_arg" ]; then
                        var=${cond_arg#\$}
                        var_value=$(eval "printf '%s' \"\${$var-}\"")
                        if [ -n "$var_value" ] && command -v "$var_value" >/dev/null 2>&1; then
                            cond_ok=yes
                        else
                            cond_ok=no
                        fi
                    elif command -v "$cond_arg" >/dev/null 2>&1; then
                        cond_ok=yes
                    else
                        cond_ok=no
                    fi
                    ;;
                file)
                    if [ "$first_is_file" -eq 1 ]; then cond_ok=yes; else cond_ok=no; fi
                    ;;
                directory)
                    if [ "$first_is_dir" -eq 1 ]; then cond_ok=yes; else cond_ok=no; fi
                    ;;
                terminal)
                    if [ "$terminal_connected" -eq 1 ]; then cond_ok=yes; else cond_ok=no; fi
                    ;;
                X)
                    if [ "$have_display" -eq 1 ]; then cond_ok=yes; else cond_ok=no; fi
                    ;;
                else)
                    cond_ok=yes
                    ;;
                *)
                    cond_ok=no
                    ;;
            esac

            if [ $((neg % 2)) -eq 1 ]; then
                if [ "$cond_ok" = yes ]; then
                    cond_ok=no
                else
                    cond_ok=yes
                fi
            fi

            if [ "$cond_ok" != yes ]; then
                return 1
            fi
        done

        if [ "$needs_mime_deferred" -eq 1 ]; then
            return 3
        fi

        vlog "matched rule -> $command_part"
        run_command "$command_part" "$flags_local"
        return 0
    }

    if [ $# -eq 0 ]; then
        exit 0
    fi

    config=$(find_config) || {
        printf 'rifle-sh: no rifle.conf found (set RIFLE_CONF)\n' >&2
            exit 1
        }

        vlog "using config: $config"

        first=$1
        case "$first" in
            /*) first_abs=$first ;;
            *) first_abs=$PWD/$first ;;
        esac
        first_name=$(basename "$first")
        case "$first_name" in
            *.*) first_ext=${first_name##*.} ;;
            *) first_ext= ;;
        esac
        first_ext_lc=$(lower "$first_ext")

        if [ -f "$first" ]; then first_is_file=1; else first_is_file=0; fi
        if [ -d "$first" ]; then first_is_dir=1; else first_is_dir=0; fi

        if [ -t 0 ] && [ -t 1 ] && [ -t 2 ]; then
            terminal_connected=1
        else
            terminal_connected=0
        fi

        if [ -n "${DISPLAY:-}" ] || [ -n "${WAYLAND_DISPLAY:-}" ]; then
            have_display=1
        else
            have_display=0
        fi

        files_set_cmd='set --'
        for path in "$@"; do
            files_set_cmd="$files_set_cmd $(shell_quote "$path")"
        done

        vlog "phase 1: non-mime rules"
        while IFS= read -r raw_line || [ -n "$raw_line" ]; do
            line=$(trim "$raw_line")
            case "$line" in ''|'#'*) continue ;; esac
            evaluate_line "$line" 1
            status=$?
            if [ "$status" -eq 0 ]; then
                exit 0
            fi
        done < "$config"

        vlog "phase 2: mime rules (if needed)"
        while IFS= read -r raw_line || [ -n "$raw_line" ]; do
            line=$(trim "$raw_line")
            case "$line" in ''|'#'*) continue ;; esac
            evaluate_line "$line" 2
            status=$?
            if [ "$status" -eq 0 ]; then
                exit 0
            fi
        done < "$config"

        printf 'rifle-sh: no rule matched for %s\n' "$first" >&2
        exit 1

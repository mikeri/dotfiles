palette.update({
                "header": ("h255", "h245", "standout"),

            # {{{ variables view
            "variables": ("h235", "h233"),
            "variable separator": ("h23", "h252"),

            "var label": ("h111", "h233"),
            "var value": ("h255", "h233"),
            "focused var label": ("h192", "h24"),
            "focused var value": ("h192", "h24"),

            "highlighted var label": ("h252", "h22"),
            "highlighted var value": ("h255", "h22"),
            "focused highlighted var label": ("h252", "h64"),
            "focused highlighted var value": ("h255", "h64"),

            "return label": ("h113", "h233"),
            "return value": ("h113", "h233"),
            "focused return label": (add_setting("h192", "bold"), "h24"),
            "focused return value": ("h192", "h24"),
            # }}}

            # {{{ stack view
            "stack": ("h235", "h233"),

            "frame name": ("h192", "h233"),
            "focused frame name": ("h192", "h124"),
            "frame class": ("h111", "h233"),
            "focused frame class": ("h192", "h24"),
            "frame location": ("h252", "h233"),
            "focused frame location": ("h192", "h24"),

            "current frame name": ("h255", "h22"),
            "focused current frame name": ("h255", "h64"),
            "current frame class": ("h111", "h22"),
            "focused current frame class": ("h255", "h64"),
            "current frame location": ("h252", "h22"),
            "focused current frame location": ("h255", "h64"),
            # }}}

            # {{{ breakpoint view
            "breakpoint": ("h80", "h233"),
            "focused breakpoint": ("h192", "h24"),
            "current breakpoint": (add_setting("h255", "bold"), "h22"),
            "focused current breakpoint": (add_setting("h255", "bold"), "h64"),
            # }}}

            # {{{ ui widgets

            "selectable": ("h252", "h235"),
            "focused selectable": ("h235", "h249"),

            "button": ("h252", "h235"),
            "focused button": ("h245", "h249"),

            "background": ("h249", "h236"),
            "hotkey": (add_setting("h250", "underline"), "h236", "underline"),
            "focused sidebar": ("h23", "h252", "standout"),

            "warning": (add_setting("h255", "bold"), "h124", "standout"),

            "label": ("h235", "h245"),
            "value": ("h255", "h235"),
            "fixed value": ("h252", "h235"),
            "group head": (add_setting("h215", "bold"), "h236"),

            "search box": ("h255", "h235"),
            "search not found": ("h255", "h124"),

            "dialog title": (add_setting("h255", "bold"), "h235"),

            # }}}

            # {{{ source view
            "breakpoint marker": ("h160", "h235"),

            "breakpoint source": ("h252", "h124"),
            "breakpoint focused source": ("h192", "h124"),
            "current breakpoint source": ("h192", "h124"),
            "current breakpoint focused source": (add_setting("h192", "bold"), "h124"),
            # }}}

            # {{{ highlighting
            "source": ("h255", "h235"),
            "focused source": ("h192", "h24"),
            "highlighted source": ("h252", "h22"),
            "current source": (add_setting("h252", "bold"), "h23"),
            "current focused source": (add_setting("h192", "bold"), "h23"),
            "current highlighted source": ("h255", "h22"),

            "line number": ("h241", "h235"),
            "keyword": ("h111", "h235"),

            "literal": ("h173", "h235"),
            "string": ("h113", "h235"),
            "doublestring": ("h113", "h235"),
            "singlestring": ("h113", "h235"),
            "docstring": ("h113", "h235"),

            "name": ("h192", "h235"),
            "punctuation": ("h223", "h235"),
            "comment": ("h242", "h235"),

            # }}}

            # {{{ shell
            "command line edit": ("h255", "h233"),
            "command line prompt": (add_setting("h192", "bold"), "h233"),

            "command line output": ("h80", "h233"),
            "command line input": ("h255", "h233"),
            "command line error": ("h160", "h233"),

            "focused command line output": (add_setting("h192", "bold"), "h24"),
            "focused command line input": ("h255", "h24"),
            "focused command line error": ("h235", "h24"),

            "command line clear button": (add_setting("h255", "bold"), "h233"),
            "command line focused button": ("h255", "h24"),
        })


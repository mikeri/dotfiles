c.TerminalInteractiveShell.confirm_exit = False
c.TerminalIPythonApp.display_banner = False
c.InteractiveShell.colors = "linux"
c.TerminalInteractiveShell.highlighting_style = "zenburn"
c.TerminalInteractiveShell.editing_mode = "vi"

from IPython.core import ultratb
ultratb.VerboseTB._tb_highlight = "bg:#722 #ff0"

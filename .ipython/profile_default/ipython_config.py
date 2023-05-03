from IPython.core import ultratb
import logging

logging.getLogger('parso.cache').disabled=True
logging.getLogger('parso.python.diff').disabled=True
logging.getLogger('parso.cache.pickle').disabled=True

c.TerminalInteractiveShell.confirm_exit = False
c.TerminalIPythonApp.display_banner = False
c.InteractiveShell.colors = "linux"
c.TerminalInteractiveShell.highlighting_style = "zenburn"
c.TerminalInteractiveShell.editing_mode = "vi"

ultratb.VerboseTB._tb_highlight = "bg:#722 #ff0"

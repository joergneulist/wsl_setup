import os

c.ExtensionApp.open_browser = True
c.LabServerApp.open_browser = True
c.LabApp.open_browser = True
c.ServerApp.use_redirect_file = False
c.ServerApp.root_dir = os.environ['HOME'] + '/jupyter/'

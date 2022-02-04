from subprocess import run
from datetime import date
from jinja2 import Environment, FileSystemLoader

from pydrive2.auth import GoogleAuth
from pydrive2.drive import GoogleDrive

def upload_drive(user,file_route,folder_id):
    credentials = user
    drive_file = credentials.CreateFile({'parents':[{'kind':'drive#fileLink', 'id':folder_id}]})
    drive_file['title'] = file_route.split('/')[-1]
    drive_file.SetContentFile(file_route)
    drive_file.Upload()

# Jinja2 #
file_loader = FileSystemLoader('.')
env = Environment(loader=file_loader,
    comment_start_string = '{{',
    comment_end_string = '}}',
    variable_start_string = '{|',
    variable_end_string = '|}'
)

template = env.get_template('main.tex')

# Pydrive2 #
credentials_route = 'credentials_module.json'
folder_lab = '1gupZRyrHfVZK9h7RZ46ZqkEzjLRbkp4e'

gauth = GoogleAuth()
gauth.LoadCredentialsFile(credentials_route)
if gauth.access_token_expired:
    gauth.Refresh()
    gauth.SaveCredentialsFile(credentials_route)
else:
    gauth.Authorize()
amado = GoogleDrive(gauth)

run('git pull', shell=True)
for var in ['astro','epidemiologia','machinelearning','profesores']:
    output = template.render(filename='\\input{Logs/' + var + '}')
    tex_name = f'output/{var}_complete.tex'
    with open(tex_name,'w') as tex_file:
        tex_file.write(output)
    run(f'pdflatex -shell-escape {tex_name}',shell=True)
    run(f'mv {var}_complete.pdf output/', shell=True)
    upload_drive(amado, f'output/{var}_complete.pdf', folder_lab)
    run(f'rm {tex_name}',shell=True)
run('rm *.log', shell=True)
run('rm *.aux', shell=True)
run('open output/', shell=True)
run('git add .', shell=True)
run('git commit -m "autocommit"', shell=True)
run('git push', shell=True)




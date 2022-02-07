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

def update_drive(user,file_route,file_id):
    credentials = user
    drive_file = credentials.CreateFile({'id':file_id})
    drive_file['title'] = file_route.split('/')[-1]
    drive_file.SetContentFile(file_route)
    drive_file.Upload()


# Jinja2 #
file_loader = FileSystemLoader('.')
env = Environment(loader=file_loader,
    comment_start_string = '{{',
    comment_end_string = '}}',
    variable_start_string = '%>',
    variable_end_string = '<%'
)

template = env.get_template('main.tex')
##

# Pydrive2 #
credentials_route = 'credentials_module.json'
folder_lab = '1gupZRyrHfVZK9h7RZ46ZqkEzjLRbkp4e'
files_ids = {'astro':'1ingfjfTnBjrSVwXtB0gRXQEGm71L334L',
    'epidemiologia':'1LBXfpps-A0XCS7QIammQsMQwXD5Y4-x2',
    'machinelearning':'1R_RGpTTX4eByqvQhm5rQTFkSeDIp5oBw',
    'profesores':'1pOzvkp5mTwPCMpYSQ4OaX9H2HYQ_qcJi'}

gauth = GoogleAuth()
gauth.LoadCredentialsFile(credentials_route)
if gauth.access_token_expired:
    gauth.Refresh()
    gauth.SaveCredentialsFile(credentials_route)
else:
    gauth.Authorize()
amado = GoogleDrive(gauth)
##

# Main execution #
run('git pull', shell=True)
for var in ['astro','epidemiologia','machinelearning','profesores']:
    output = template.render(filename='\\input{../Logs/' + var + '}')
    tex_name = f'{var}_complete'
    print(output)
    input()
    with open(f'output/{tex_name}.tex','w') as tex_file:
        tex_file.write(output)
    run(f'. main.sh && Lcompile {tex_name}.tex',shell=True)
    #upload_drive(amado, f'output/{tex_name}.pdf', folder_lab)
    update_drive(amado, f'output/{tex_name}.pdf', files_ids[var])
run('. main.sh && updateG', shell=True)



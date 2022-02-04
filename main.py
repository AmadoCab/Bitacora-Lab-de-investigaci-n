from subprocess import run
from datetime import date
from jinja2 import Environment, FileSystemLoader

file_loader = FileSystemLoader('.')
env = Environment(loader=file_loader,
    comment_start_string = '{{',
    comment_end_string = '}}',
    variable_start_string = '{|',
    variable_end_string = '|}'
)

template = env.get_template('main.tex')

for var in ['Logs/astro','Logs/epidemiologia','Logs/machinelearning','Logs/profesores']:
    output = template.render(filename=f'\\input{var}')
    print(output)


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


run('git pull', shell=True)
for var in ['astro','epidemiologia','machinelearning','profesores']:
    output = template.render(filename='\\input{Logs/' + var + '}')
    tex_name = f'output/{var}_complete.tex'
    with open(tex_name,'w') as tex_file:
        tex_file.write(output)
    run(f'pdflatex -shell-escape {tex_name}',shell=True)
    run(f'mv {var}_complete.pdf output/', shell=True)
    run(f'rm {tex_name}',shell=True)
run('rm *.log', shell=True)
run('rm *.aux', shell=True)
run('open output/', shell=True)
run('git add .', shell=True)
run('git commit -m "autocommit"', shell=True)
run('git push', shell=True)


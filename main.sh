#!/usr/bin/env bash

Lcompile() {
    cd output/;
    pdflatex -shell-escape $1 && clear || echo "Error en LaTeX 1";
    pdflatex -shell-escape $1 && clear || echo "Error en LaTeX 2";
    rm $1;
    cd ../;
}

updateG() {
    git add .;
    git commit -m "autocommit";
    git push;
    clear;
    open output/;
}


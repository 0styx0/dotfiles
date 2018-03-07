!#/bin/bash

# install dein for vim
if [ -d "$HOME/.vim/dein" ]; then
    echo "dein plugin manager already installed"
else
    echo "Installing dein plugin manager"
    sh ./dein-installer.sh ~/.vim/dein
fi

echo "Now run the following to get better linting/completion:"
echo "npm install -g javascript-typescript-langserver htmlhint tslint eslint"

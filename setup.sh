BASEDIR=$(cd $(dirname $0) && pwd)

ln -sf $BASEDIR/nvim/init.vim ~/.config/nvim/init.vim
ln -sf $BASEDIR/tmux.conf ~/.tmux.conf

if [ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
  curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

ln -sf $BASEDIR/sh/zshrc ~/.zshrc
ln -sf $BASEDIR/sh/p10k.zsh ~/.p10k.zsh

git clone https://github.com/junegunn/fzf ~/.fzf
~/.fzf/install --all

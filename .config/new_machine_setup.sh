# Set homes for config and cache files
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# pull dotfiles
git clone --bare https://github.com/kthakk4/ubuntu-dotfiles.git $HOME/dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
mkdir -p .config-backup && dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no

# install zsh 
sudo apt install zsh

# install zsh packages
cho 'deb http://download.opensuse.org/repositories/shells:/zsh-users:/zsh-syntax-highlighting/xUbuntu_22.04/ /' | sudo tee /etc/apt/sources.list.d/shells:zsh-users:zsh-syntax-highlighting.list
curl -fsSL https://download.opensuse.org/repositories/shells:zsh-users:zsh-syntax-highlighting/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_zsh-users_zsh-syntax-highlighting.gpg > /dev/null
sudo apt update
sudo apt install zsh-syntax-highlighting

# Create conda environment, download packages
conda create -n -y default python=3.10
conda activate default
conda install -y jupyter matplotlib numpy pandas scipy scikit-learn pytorch torchvision torchinfo

# set zsh to be the default shell
sudo usermod -s $(which zsh) $(whoami)
exit

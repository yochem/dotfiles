# download pip from website
curl https://bootstrap.pypa.io/get-pip.py > get-pip.py

# install pip
python get-pip.py

# delete install file
rm get-pip.py

pip install -U pip

pip_apps=(
  checkpy
  click
  colorama
  cookiecutter
  dropbox
  httplib2
  pandoc
  pandoc-shortcaption
  pandocfilters
  pipsi
  pydrive
  pygments
  zerorpc
)

pip install "${pip_apps[@]}"

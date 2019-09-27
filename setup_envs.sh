# echo ""
# echo "Creating useful environment variables..."
# export MYVAR=$MYVAR
# export MYVAR2=$MYVAR2
# echo "Finished creating useful environment variables!"

echo ""
echo "Adding jupyterlab extensions..."
mkdir /home/jovyan/work/extensions

# Great extension by calpoly for better markdown formatting in cells: https://github.com/jupytercalpoly/jupyterlab-richtext-mode
git clone https://github.com/jupytercalpoly/jupyterlab-richtext-mode.git /home/jovyan/work/extensions/jupyter-scribe && \
cd /home/jovyan/work/extensions/jupyter-scribe && \
npm install && \
npm run build && \
jupyter labextension link .

# Rebuild to get extensions to work
jlpm build
jupyter lab build
echo "Added jupyterlab extensions!"

echo ""
echo "Creating kernel py37..."
conda create -n py37 python=3.7.4 pip -y
echo "Finished creating kernel py37!"

# Install packages with pip, otherwise conda's "auto-checking compatibility" algo freaks out (with certain versions of conda)
echo ""
echo "Installing packages in py37..."
source activate py37 && \
pip install ipykernel && \
pip install pandas && \
pip install numpy && \
pip install scipy && \
pip install matplotlib && \
pip install seaborn && \
echo "Finished installing packages in py37!"

echo ""
echo "Connecting env to kernel..."
source activate py37 && python -m ipykernel install --user --name py37 --display-name "py37"
source activate py37 # must activate/deactivate once to have changes displayed
source activate base
echo "Connected env to kernel!"

cat << "EOF"

WELCOME!

     ██╗██╗   ██╗██████╗ ██╗   ██╗████████╗███████╗██████╗
     ██║██║   ██║██╔══██╗╚██╗ ██╔╝╚══██╔══╝██╔════╝██╔══██╗
     ██║██║   ██║██████╔╝ ╚████╔╝    ██║   █████╗  ██████╔╝
██   ██║██║   ██║██╔═══╝   ╚██╔╝     ██║   ██╔══╝  ██╔══██╗
╚█████╔╝╚██████╔╝██║        ██║      ██║   ███████╗██║  ██║
 ╚════╝  ╚═════╝ ╚═╝        ╚═╝      ╚═╝   ╚══════╝╚═╝  ╚═╝

Take it from here...

EOF

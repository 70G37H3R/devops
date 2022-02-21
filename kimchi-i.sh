mkdir -p kimchi-wok-install/
cd kimchi-wok-install/

apt install -y python3-pip gcc make autoconf automake git python3-pip python3-requests \
python3-mock gettext pkgconf xsltproc python3-dev pep8 pyflakes python3-yaml systemd \
logrotate python3-psutil python3-ldap python3-lxml python3-websockify python3-jsonschema \
openssl nginx python3-cherrypy3 python3-pam python-m2crypto gettext python3-openssl \
python3-configobj python3-lxml python3-magic python3-paramiko python3-ldap spice-html5 \
novnc qemu-kvm python3-libvirt python3-parted python3-guestfs python3-pil python3-cherrypy3 \
libvirt0 libvirt-daemon-system libvirt-clients nfs-common sosreport open-iscsi libguestfs-tools \
libnl-route-3-dev

pip3 install distro
pip3 install cheetah3

wget https://github.com/kimchi-project/wok/archive/3.0.0.tar.gz
tar xfzv 3.0.0.tar.gz

cd wok-3.0.0
sudo ./autogen.sh --system

make
sudo make install
make deb

sudo dpkg -i wok-3.0.0-0.ubuntu.noarch.deb

pip3 install -r requirements-dev.txt

cd ../

wget https://github.com/kimchi-project/kimchi/archive/3.0.0.tar.gz
tar xfzv 3.0.0.tar.gz

cd kimchi-3.0.0
sudo ./autogen.sh --system

make
sudo make install
make deb

sudo dpkg -i kimchi-3.0.0-0.noarch.deb

pip3 install -r requirements-dev.txt
pip3 install -r requirements-UBUNTU.txt

cd ../

sudo systemctl daemon-reload
sudo systemctl enable wokd
sudo systemctl restart wokd

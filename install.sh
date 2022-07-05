!/bin/bash


###### Update System ######

sudo apt-get update
sudo apt-get upgrade -y
############################


######## security #########
sudo apt-get install openssh-server fail2ban
############################


####### install pip3 #######
sudo apt-get install -y python3-pip
############################



######## libraries ########
sudo apt-get install git python-dev python3-dev libxml2-dev libxslt1-dev \
                     zlib1g-dev libsasl2-dev libldap2-dev build-essential \ 
                     libssl-dev libffi-dev libmysqlclient-dev libjpeg-dev \
                     libpq-dev libjpeg8-dev liblcms2-dev libblas-dev libatlas-base-dev -y
############################


 
######### WEB Need #########
sudo apt-get install -y npm
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo npm install -g less less-plugin-clean-css
sudo apt-get install -y node-less
############################



######## postgresql ########
sudo apt-get install postgresql
sudo su - postgres
createuser --createdb --username postgres --no-createrole --no-superuser --pwprompt odoo15
# psql
# ALTER USER odoo15 WITH SUPERUSER;
############################


######### ADD USER #########
# sudo adduser -system -home=/opt/odoo -group odoo
sudo adduser --system --home=/opt/odoo --group odoo
sudo su - odoo -s /bin/bash
############################



####### Download odoo #####
git clone https://www.github.com/odoo/odoo --depth 1 --branch 15.0 --single-branch .
###########################



##### Required Python #####
sudo pip3 install -r /opt/odoo/requirements.txt
###########################




####### Wkhtmltopdf #######
sudo wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
sudo dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb
sudo apt install -f
###########################




##### Setup Conf file #####


sudo cp /opt/odoo/debian/odoo.conf /etc/odoo.conf
sudo nano /etc/odoo.conf

# [options]
#    ; This is the password that allows database operations:
#    admin_passwd = admin
#    db_host = False
#    db_port = False
#    db_user = odoo15
#    db_password = False
#    addons_path = /opt/odoo/addons
#    logfile = /var/log/odoo/odoo.log


sudo chown odoo: /etc/odoo.conf
sudo chmod 640 /etc/odoo.conf


sudo mkdir /var/log/odoo
sudo chown odoo:root /var/log/odoo

###########################



#### Odoo service file ####

sudo nano /etc/systemd/system/odoo.service



# [Unit]
#    Description=Odoo
#    Documentation=http://www.odoo.com
#    [Service]
#    # Ubuntu/Debian convention:
#    Type=simple
#    User=odoo
#    ExecStart=/opt/odoo/odoo-bin -c /etc/odoo.conf
#    [Install]
#    WantedBy=default.target

sudo chmod 755 /etc/systemd/system/odoo.service
sudo chown root: /etc/systemd/system/odoo.service


sudo systemctl start odoo.service
sudo systemctl status odoo.service
sudo systemctl enable odoo.service


###########################






##### Source ######
# https://www.cybrosys.com/blog/how-to-install-odoo-15-on-ubuntu-2004-lts-server
# https://www.youtube.com/watch?v=mlvJCfxNKDE&ab_channel=CybrosysTechnologies
###################




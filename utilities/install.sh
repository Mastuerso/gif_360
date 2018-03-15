#!/bin/bash
sudo apt-get update
sudo apt-get install dconf-editor dconf-cli -y
sudo apt-get install filezilla -y
sudo apt-get install ffmpeg
sudo apt-get install gphoto2
sudo apt-get install inotify-tools
sudo apt-get install dconf-editor
sudo apt install python-pip
sudo apt-get install libxml2-dev libxslt-dev  python-dev  python-setuptools
sudo -H pip install lxml
sudo -H pip install setuptools
sudo -H pip install -U pip
sudo -H pip install opencv-python
sudo -H pip install Pillow
sudo -H pip install pyserial
sudo -H pip install -U scikit-image
sudo -H pip install imutils
sudo apt-get install apache2
sudo ufw app list
sudo ufw app info "Apache Full"
sudo ufw allow in "Apache Full"
sudo apt-get install mysql-server
sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql
sudo chmod -R a+rw /var/www/html
rm /var/www/html/index.html
dirIndexFile=$(echo -e "<IfModule mod_dir.c>\n    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm\n</IfModule>")
sudo echo "${dirIndexFile}" > /etc/apache2/mods-enabled/dir.conf
sudo systemctl restart apache2
#sudo systemctl status apache2
sudo apt-get install php-cli
#phpTestFile=$(echo -e "<?php\n    phpinfo();\n?>")
#sudo echo "${phpTestFile}" > /var/www/html/info.php
userName=$(whoami)
sudo usermod -aG dialout "${userName}"
sudo adduser "${userName}" www-data
#firefox localhost/info.php
#remember to rm info.php in /var/www/html/
cp -r gif_360 /home/${userName}/
cp -r gif_360_web /var/www/html/
sleep 5s
sudo chmod a+x /home/${userName}/gif_360/main/*.sh
sudo chmod a+x /home/${userName}/gif_360/main/*.py
sudo chmod a+rw /home/${userName}/gif_360/main/*.txt
sudo chmod a+rw /home/${userName}/gif_360/main/*.flag
sudo chmod a+rw /home/${userName}/gif_360/main/*.list
sudo chmod a+rw /home/${userName}/gif_360/main/*.config
sudo cp /home/${userName}/gif_360/gif_creator.service /etc/systemd/system/gif_creator.service
sudo systemctl enable gif_creator.service
#sudo systemctl restart gif_creator.service
sudo rm /var/www/html/index.html
sudo chmod a+x /var/www/html/gif_360_web/gui/*.php
sudo chmod a+x /var/www/html/gif_360_web/server/*.php
#installing composer
cd
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
cd /var/www/html
composer require phpmailer/phpmailer
composer require facebook/graph-sdk


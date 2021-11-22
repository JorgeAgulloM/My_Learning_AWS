#!/bin/bash

#Restingir permisos del archivo .pem
chmod 400 keypairScript2.pem

#Conectar al a instancia para instalar httpd y crear y dar permisos a las carpetas necesarias
echo "Conectando a la instancia e instalando httpd y carpetas necesarias..."
ssh -i keypairScript2.pem ec2-user@ec2-52-87-217-51.compute-1.amazonaws.com 'sudo yum -y install httpd;
sudo mkdir /var/www/dev;
sudo chmod -R 777 /var/www/dev;
sudo chmod -R 777 /etc/httpd/conf;
sudo chmod -R 777 /var/www;
sudo cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd_old.conf';

#Enviar los archivos del prollevato y configuración de httpd
echo "Enviando el proyecto a la instancia aws...";
scp -i keypairScript2.pem index.html ec2-user@ec2-52-87-217-51.compute-1.amazonaws.com:/var/www/dev/;

#Conectar para desplegar los archivos del proyecto y ejecutar el servicio de httpd
echo "Desplagando el proyecto en la instancia...";
ssh -i keypairScript2.pem ec2-user@ec2-52-87-217-51.compute-1.amazonaws.com 'sudo cp /var/www/dev/index.html /var/www/;
sudo sed -i '"'"'s|DocumentRoot "/var/www/html"|DocumentRoot "/var/www"|'"'"' /etc/httpd/conf/httpd.conf;
sudo chmod -R 755 /var/www/dev;
sudo chmod -R 755 /etc/httpd/conf;
sudo chmod -R 755 /var/www;
sudo service httpd start';

echo "Despliegue finalizado";




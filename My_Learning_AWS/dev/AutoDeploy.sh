#!/bin/bash

#Restingir permisos del archivo .pem
chmod 400 keypairEJ02.pem

#Conectar al a instancia para instalar httpd y crear y dar permisos a las carpetas necesarias
echo "Conectando a la instancia e instalando httpd y carpetas necesarias..."
ssh -i KeyPairScript.pem ec2-user@ec2-3-88-249-109.compute-1.amazonaws.com 'sudo yum -y install httpd;
sudo mkdir /var/www/dev
sudo chmod -R 777 /var/www/dev;
sudo chmod -R 777 /etc/httpd/conf;
sudo chmod -R 777 /var/www;
sudo mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd_old.conf';

#Enviar los archivos del prollevato y configuración de httpd
echo "Enviando el proyecto a instancia aws...";
scp -i KeyPairScript.pem index.html httpd.conf AutoDeploy.sh ec2-user@ec2-3-88-249-109.compute-1.amazonaws.com:/var/www/dev/;

#Conectar para desplegar los archivos del proyecto y ejecutar el servicio de httpd
echo "Desplagando el proyecto en la instancia...";
ssh -i KeyPairScript.pem ec2-user@ec2-3-88-249-109.compute-1.amazonaws.com 'sudo cp /var/www/dev/index.html /var/www/;
sudo cp /var/www/dev/httpd.conf /etc/httpd/conf/;
sudo service httpd start';

echo "Despliegue finalizado";




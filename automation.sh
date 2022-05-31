#Varible for s3_bucket
s3_bucket=upgrad-kartik

#Variable for my_name
myname=Kartik

#Updating system and running apache2 service

echo "updating your system"
sudo  apt update -y
echo "Running apache2 service"
sudo apt-get install apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "apache2 is enabled"

#Creating tar archiev of log files to tmp directory

timestamp=$(date "+%d%m%Y-%H%M%S")
cd /var/log/apache2/
tar -cvf *.log > /tmp/${myname}-httpd-logs-${timestamp}.tar 

echo "Copying tar archives to the created bucket"
aws s3 cp  /tmp/${myname}-httpd-logs-${timestamp}.tar s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar 
echo "Files copied to $s3_bucket successfully"

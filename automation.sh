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

if [ -e /var/www/html/inventory.html ]
then
        echo "inventory.html is already there"
else 
        touch /var/www/html/inventory.html
        {
        echo "<head>"
        echo "<h1>cat /var/www/html/inventory.html</h1>"
        echo "</head>"
        echo "<b/>Log Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date Created&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbspType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Size" 
        } >> /var/www/html/inventory.html
fi

echo "<br>httpd-logs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${timestamp}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; du -sh /var/www/html/inventory.html | awk '{print $1}' " >> /var/www/html/inventory.html

#creating cronjob

sudo service cron start
sudo systemctl enable cron
touch /etc/cron.d/automation
chmod +x /etc/cron.d/automation
echo "0 0 * * * root /root/Automation_Project/automation.sh" > /etc/cron.d/automation

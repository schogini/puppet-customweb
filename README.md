# A Recipe to Create a Custom Website in Puppet
Puppet-Docker CustomWeb
```
mkdir customweb
# Copy the custom website to the above folder
docker network create puppet
docker run -ti --rm --net puppet --name puppet  -p :8090:80 --hostname puppet -v $PWD/customweb:/customweb schogini/docker-puppetserver-ubuntu
docker run -ti --rm --net puppet --name puppetnode1 -p :8091:80 --hostname puppetnode1 schogini/docker-puppetnode-ubuntu
```
##SERVER
service puppetserver start

##CLIENT
puppet agent -t

##SERVER 
```
puppet cert list
puppet cert sign puppetnode1
cd /etc/puppetlabs/code/environments/production/modules/
puppet module generate --skip-interview sree-simpleweb
cp /customweb/manifests/init.pp ./customweb/manifests/init.pp
cp -r /customweb/templates ./customweb/
cp -r /customweb/files ./customweb/
puppet apply -e "include customweb"
curl localhost
```
BROWSER: http://0.0.0.0:8090/

##SERVER
nano ../manifests/site.pp
node 'puppetnode1' {
 include motd
 include customweb
}
node 'puppet' {
 include motd
 include customweb
}
```
##CLIENT
puppet agent -t
curl localhost
BROWSER: http://0.0.0.0:8091/

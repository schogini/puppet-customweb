# A Module to Create a Custom Website in Puppet
Puppet-Docker CustomWeb
```
git clone https://github.com/schogini/puppet-customweb.git mylocalfolder
docker network create puppet
docker run -ti --rm --network puppet --name puppet -p 8090:80 --hostname puppet -v $PWD/mylocalfolder/customweb:/etc/puppetlabs/code/environments/production/modules/customweb schogini/docker-puppetserver-ubuntu
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

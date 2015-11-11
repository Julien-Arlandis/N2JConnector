N2JConnector Readme
===================

Version 0.1  
N2JConnector is a set of Perl-scripts to feed JNTP Server.  
http://news.nemoweb.net/

Copyright
---------

Copyright (C) 2013-2015
    Julien Arlandis <julien.arlandis_at_gmail.com>

License
-------

http://www.gnu.org/licenses/agpl.txt

Requirements
------------

* Perl (with JSON module)
* INN

Support
-------

See reference about server support forums under \<news:nemo.dev.serveur\>  

Installation
------

In the INN's newsfeeds file, you need to have a channel feed:

 	N2JConnector!:!*:Ac,Tc,Wnm*:<pathbin>/N2JConnector.pl

and a site for each of the various jntp site you're feeding,
such as

 	news.nemoweb.net/from-jntp:!*,local.*:Ap,Tm:N2JConnector!

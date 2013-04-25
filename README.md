vagrant-lamp
============

A lamp stack for vagrant. The box will install with Apache, MySQL, MongoDb and PHP.

Installation
------------

There are 2 things that need installing:

* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://www.vagrantup.com/)

Setup
-----

These are the setup you need to follow to get this vagrant box up and running:

1. Clone this repo

    ```bash
    $ git clone git://github.com/DaMitchell/vagrant-lamp.git
    ```

2. This repo has a submodule that contains the puppet setup that is used to provision the vagrant box, so run these 2 commands

    ```bash
    $ git submodule init
    ```

    ```bash
    $ git submodule update
    ```

3. Next we have to cd into the "puppet" folder because this submodule has further submodules.

    ```bash
    $ cd puppet
    ```

4. Now we run the same submodule commands as in step 2 to pull down all the puppet modules required.

    ```bash
    $ git submodule init
    ```

    ```bash
    $ git submodule update
    ```

5. Finally we can cd back to the repo root and run the vagrant command to get the box running.
   This command will automatically download the Ubuntu vagrant box.


    ```bash
    $ vagrant up
    ```

Post Installation
-----------------

You should be able to go to http://localhost:8080/phpinfo.php and see the the phpinfo(); page of the vagrant box.
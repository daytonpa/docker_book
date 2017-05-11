# docker_book

#### Description
This cookbook will install and configure Docker.  This is also still in development, but more is to come!

#### Supported platforms
 - ubuntu 16.04
 - centos 7.2

#### Cookbook dependencies
 - docker
 - apt
 - yum

#### Usage
There are a few attributes you can set that will install Docker.  By default, the attribute ```node['docker_book']['installation_method']``` is set to ```'package'```.  If you would like to install Docker via downloading the repository, change that attribute to ```'repo'```.

#### Recipes
 - ```install_docker```: Updates the caches, installs the required 3rd-party packages for running Docker, installs Docker via ```package``` or ```apt_repository```/```yum_repository``` resources depending on desired installation method and operating system.  Once installed, it will start and enable the Docker service.

#### Unit Tests
All unit tests are performed by ChefSpec on each recipe.

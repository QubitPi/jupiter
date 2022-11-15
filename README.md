[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/chef-recipe-local-test)
[![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/Chef%20Recipe%20Local%20Test%20CI/chef-recipe-local-test?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/chef-recipe-local-test-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/chef-recipe-local-test?logo=github&style=for-the-badge)

Chef Recipe Testing in Local Mode
=================================

![CHEF Logo](https://user-images.githubusercontent.com/16126939/176977885-e750fd30-12ca-45af-b517-30c486b06992.png)


Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/chef-recipe-local-test/):

    docker pull jack20191124/chef-recipe-local-test

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/chef-recipe-local-test/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout chef-recipe-local-test
    docker build -t jack20191124/chef-recipe-local-test .


Starting a Container using Pseudo-TTY
-------------------------------------

Pseudo-TTYs are used to run commands inside a container. To start a pseudo-TTY session with the container, we can use
the `-t` flag. The container will not exit until the session ends. If we want to interact with the container, we can
couple this with the `-i` flag. This will allow us to run commands in the container using our terminal. Here's an
example of the command:

```bash
docker run --name chef-recipe-local-test -it jack20191124/chef-recipe-local-test bash
```

Executing the command above will spin up the container and takes us directly into the container shell, which we
[conduct some recipe tests inside](#use-container-to-manually-test-any-chef-recipes).


Use Container to Manually Test Any Chef Recipes
-----------------------------------------------

The [`chef_repo_path`](https://docs.chef.io/ctl_chef_client/#run-in-local-mode) is **~/cookbooks** inside container: 

```bash
root@df3r670rf23r:/# cd ~
root@df3r670rf23r:~# ls
cookbooks
```

There has already been a cookbook named "test-cookbook":

```bash
root@df3r670rf23r:~/cookbooks# ls
test-cookbook
```

Load the tested recipe (let's name it `test-recipe.rb`) into `test-cookbook/recipes/` directory and test the recipe using

```bash
cd ~
chef-client -z -o 'recipe[test-cookbook::test-recipe]'
```


License
-------

The use and distribution terms for [Jupiter](https://qubitpi.github.io/jupiter/) are covered by the
[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).

<div align="center">
    <a href="https://opensource.org/licenses">
        <img align="center" width="50%" alt="License Illustration" src="https://github.com/QubitPi/QubitPi/blob/master/img/apache-2.png?raw=true">
    </a>
</div>

This documentation describes high-level approach to creating Waldur downstream forks.
It may be of interest to developers who may want to integrate their tools with Waldur.

## System requirements

- Linux (CentOS 7 and Ubuntu 14.04 tested) or OS X.
- At least 2 GB of RAM, more is better.
- Docker and git should be installed and running.

## Image building instructions

```bash
# Clone current repository
mkdir -p ~/repos
cd ~/repos
git clone git@code.opennodecloud.com:waldur/waldur-downstream.git

# Enable Waldur scripts
export PATH="${PATH}:~/repos/waldur-downstream/scripts"

# Build all Docker images
cd waldur-downstream/images
cd waldur-mastermind-build && ./build.sh && cd ../
cd waldur-mastermind-test && ./build.sh && cd ../
cd waldur-homeport-build && ./build.sh && cd ../
```

## Clone source code repositories

Example for Waldur Core:
```bash
cd ~/repos
git clone https://github.com/opennode/waldur-core.git
```

Example for Waldur MasterMind:
```bash
cd ~/repos
git clone https://github.com/opennode/waldur-mastermind.git
```

Example for Waldur HomePort:
```bash
cd ~/repos
git clone https://github.com/opennode/waldur-homeport.git
```

## Testing instructions 

Example for Waldur Core:
```bash
cd ~/repos/waldur-core
waldur-core-test
```

Example for Waldur MasterMind:
```bash
cd ~/repos/waldur-mastermind
waldur-mastermind-test
```

Example for Waldur HomePort:
```bash
cd ~/repos/waldur-homeport
waldur-homeport-test
```

## RPM building instructions
The same script is used for all components. 
After script is executed successfully, RPM file is created in the local directory.
Please don't forget to move or delete it before subsequent run is executed.

```bash
waldur-build-rpm
```

## Release instructions
waldur-release script modifies RPM spec, package.json and setup.py so that new
version is specified consistently in all these files.

In order to omit blocking of development branch while release process is in progress,
usually release is executed in three steps:

1. Start phase - new branch corresponding to release is created;
2. Tests are executed in new branch;
3. If all tests have passed, release is finished, ie changes from release branch are 
propagated to the master branch, and release branch is deleted.

For example:
```bash
cd ~/repos/waldur-homeport
waldur-release start 3.0.0
waldur-homeport-test
waldur-release finish 3.0.0
```

## Implementing plugins

Waldur is composed of backend server, also known as Waldur MasterMind,
and fronted client, known as Waldur HomePort.

In order to implement backend plugin, you should use [Waldur plugin for cookiecutter](https://github.com/opennode/cookiecutter-waldur-plugin).
In order to implement frontend plugin, you should fork Waldur HomePort, and place all your plugins in [app/scripts/plugins directory](https://github.com/opennode/waldur-homeport/blob/develop/docs/plugins.md).

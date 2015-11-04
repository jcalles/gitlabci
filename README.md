# gitlabci

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with gitlabci](#setup)
    * [What gitlabci affects](#what-gitlabci-affects)
    * [Beginning with gitlabci](#beginning-with-gitlabci)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## 1. Overview
PUppet module to install gitlab ci multi-runner from [Gitlab](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/linux-manually.md "")
## 2. Module Description
This module create user gitlab-runner, download and confiure 
## 3. Setup
```bash
sudo puppet apply --modulepath=/path/to/modules/ -e "class {'gitlabci':}"
```

## Requirements
this module require https://travis-ci.org/justinclayton/puppet-module-sudo

## 4. Contact:
javiercalles@gmail.com
tecnologia@4geeks.co

=============
Dirty Sandbox
=============

Terraform and Saltstack to create a dirty network for testing ASV scans.

Getting Started
===============

You will need:

* terraform https://www.terraform.io/downloads.html
* make
* ssh-keygen 
* A POSIX-like shell (bash or zsh work)
* an AWS account
   - a user with AdministratorAccess
     (or otherwise the ability to create most types of resources in your chosen region)
   - the AWS Access Key and AWS Secret Key for that account

To get started::

    cd terraform 
    cp examples/* ./
    $EDITOR variables.tf
    $EDITOR secrets.tf
    make apply  # not yet implemented!

TODO
====

Lots.

#!/bin/bash

terraform taint 'digitalocean_droplet.bootstrap'
terraform taint 'digitalocean_droplet.master[0]'
terraform taint 'digitalocean_droplet.master[1]'
terraform taint 'digitalocean_droplet.master[2]'
terraform taint 'digitalocean_droplet.worker[0]'
terraform taint 'digitalocean_droplet.worker[1]'
terraform taint 'digitalocean_droplet.worker[2]'

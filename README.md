# Docker engine, an Ansible role

This role uses the get.docker.com script to install and configure Docker.

## Licence

MIT

## Requirements

This role requires Ansible 2.0 or above. See [requirments](./meta/requirements.txt) for full details.

## Example playbook

```
- hosts: all
  roles:
  	- role: "dankempster.docker-engine"
```

## Credits

[DanKempster](https://github.com/dankempster)

Special thanks to [clayman74](https://github.com/clayman74) and
[ansible-docker](https://github.com/clayman74/ansible-docker) where
I copied [certs.yml](./tasks/certs.yml) from.

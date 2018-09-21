# salt-pillars
This repository contains environmet/role assignments and host- or
service-specific configuration data, which the Salt master (server)
sends to Salt minions (clients) access via
[Pillar](http://docs.saltstack.com/en/latest/ref/pillar/index.html).
Because Salt minions do not cache Pillar data, and because they can
only access Pillar data sent to them by the master, Pillar can be used
safely to deploy secrets such as passwords or private keys.

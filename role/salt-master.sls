#### ROLE.SALT-MASTER --- Role-specific configuration for My Test Salt Masters

### This contains configuration items common to all Salt Master

role: salt-master

####
#### FIREWALLD-FORMULA
####

firewalld:
  zones:
    public:
      services:
        - mosh
        - ssh
        - salt-master

####
#### SALT-FORMULA
####

salt:
  master:
    gather_job_timeout: 300
    timeout: 300
    presence_events: True
    ping_on_rotate: True

    fileserver_backend:         # applied in order, last match "wins"
      - git                     # Salt states/state formulas
  ##    - s3fs                    # large files (e.g., installers)
      - roots                   # temporary overrides of above

    gitfs_provider: gitpython
    gitfs_remotes:
      - git@github.com:ibrsp/salt-states.git

   
    file_roots:
      base:
        - /srv/salt
      dev:
        - /srv/salt             # hack to make winrepo work
      prod:
        - /srv/salt             # hack to make winrepo work

    ext_pillar:
      - git:
          - ssh://git@github.com/rkimera/salt-pillars.git
  ##        - https://github.com/rkimera/salt-pillars.git


  gitfs:
    gitpython:
      install_from_source:
        False

salt_formulas:
  git_opts:
    default:
      baseurl: git@github.com:rkimera
      update: True
  list:
    dev: &saltformulas
      - apache-formula
      - firewalld-formula
      - letsencrypt-formula
      - openssh-formula

####
#### USERS-FORMULA
####
gitfs_remotes:
  - ssh://git@github.com/rkimera/salt-states.git:
    - pubkey: /root/.ssh/my.pub
    - privkey: /root/.ssh/my
    - mountpoint: salt:///srv/salt/salt-states
### The salt-master service runs as the root user by default.  This
### configures SSH public key authentication for use with GitHub.





#### ROLE.SALT-MASTER ends here.

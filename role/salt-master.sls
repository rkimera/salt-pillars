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
      - s3fs                    # large files (e.g., installers)
      - roots                   # temporary overrides of above

    gitfs_provider: gitpython
    gitfs_remotes:
      - git@github.com:ibrsp/salt-states.git

    s3.https_enable: True       # force accessing S3 over HTTPS
    s3.location: us-west-2
    s3.service_url:
      s3-us-west-2.amazonaws.com
    s3.buckets:
      - rkimera-salt-states

    file_roots:
      base:
        - /srv/salt
      dev:
        - /srv/salt             # hack to make winrepo work
      prod:
        - /srv/salt             # hack to make winrepo work

    ext_pillar:
      - git:
##          - ssh://git@github.com/rkimera/salt-pillars.git
          - https://github.com/rkimera/salt-pillars.git

  ##  winrepo_remotes:            # legacy
  ##    - git@github.com:ibrsp/salt-winrepo.git
  ##  winrepo_remotes_ng:
  ##    - git@github.com:ibrsp/salt-winrepo-ng.git
  ##    - git@github.com:ibrsp/salt-winrepo-private.git

 ##   reactors:
 ##     - 'certbot/deploy/*':
 ##         - /etc/salt/reactors/certbot-deploy.sls

  ## workaround a bug in salt-formula's defaults.yaml/map.jinja dict
  ## merge code
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
##      - comanage-formula
##      - certbot-formula
##      - docker-formula
##      - epel-formula
      ## TODO
      # - fail2ban-formula
      - firewalld-formula
      - letsencrypt-formula
  ##    - mysql-formula
  ##    - ntp-formula
  ##    - nux-formula
  ##    - openldap-formula
      - openssh-formula
  ##    - php-formula
  ##    - pip-formula
      ## TODO
      # - postfix-formula
  ##    - postgres-formula
      - salt-formula
  ##    - shibboleth-formula
  ##    - snmp-formula
  ##    - sudoers-formula
  ##    - tomcat-formula
  ##    - users-formula
  ##  production: *saltformulas
  ##  satosa_wsgi: *saltformulas

####
#### USERS-FORMULA
####

### The salt-master service runs as the root user by default.  This
### configures SSH public key authentication for use with GitHub.

users:
 root:
    ssh_keys_pillar:
      id_rsa: users_root_ssh_keys
    ssh_config:
      github:
        hostname: github.com
        options:
          - IdentityFile ~/.ssh/id_rsa
          - StrictHostKeyChecking no

{%- import_text "role/salt-master-github.pub" as salt_master_github_pub %}
{%- import_text "role/salt-master-github.key" as salt_master_github_key %}

users_root_ssh_keys:
  id_rsa:
    pubkey: {{ salt_master_github_pub|yaml_encode }}
    privkey: {{ salt_master_github_key|yaml_encode }} 

###
#### CERTBOT-FORMULA
####

### Note that Salt Masters must provide values for `certbot:email` and
### `certbot:certificates`.

##certbot:
 ## packages:
  ##  - certbot
   ## - python2-certbot-dns-route53 # DNS-01 DCV plugin
   ## - jq                          # used by the send-event deploy hook
   ## - python2-futures             # work around CentOS/EPEL packaging bug
  ##agree-tos: True
 ## authenticator: dns-route53

#### ROLE.SALT-MASTER ends here.

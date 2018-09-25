base:
  '*':
    - users
    - pkg
    - environment.development
    
{%- set minion_id = salt['grains.get']('id') %}

  'E@(?i)ip-172-31-26-84.us-west-2.compute.internal': [role.salt-master]

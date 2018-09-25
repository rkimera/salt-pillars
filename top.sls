base:
  '*':
    - users
    - pkg
    - environment.development
    
{%- set minion_id = salt['grains.get']('id') %}
{%- set domain_name = minion_id.partition('.')[2] %}

  'E@(?i)ip-172-31-26-84.us-west-2.compute.internal': [role.salt-master]

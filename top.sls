base:
  '*':
    - users
    - pkg

{%- set minion_id = salt['grains.get']('id') %}
{%- set domain_name = minion_id.partition('.')[2] %}
{%- if domain_name %}  

  'E@(?i)ip-172-31-26-84.us-west-2.compute.internal': [role.salt-master]

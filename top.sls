base:
  '*':
    - users
    
{%- set minion_id = salt['grains.get']('id') %}
{%- set domain_name = minion_id.partition('.')[2] %}
{%- if domain_name %}

  ## domain-specific settings
  {{ '*.%s'|format(domain_name)|yaml_encode }}:
    - ignore_missing: True
    - {{ domain_name|lower|yaml_encode }}

{%- endif %}

  'ip-172-31-26-84.us-west-2.compute.internal':
    - role.salt-master

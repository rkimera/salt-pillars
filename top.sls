base:
  '*':
    - environment.base
    - users
   
{% set id = salt['grains.get']('id', '') %}

{%- if domain_name %}


    - ignore_missing: True


{%- endif %}
    
 ## 'E@(?i)ip-172-31-26-84.us-west-2.compute.internal': [role.salt-master]

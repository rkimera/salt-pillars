base:
  'ip-172-31-26-84.us-west-2.compute.internal':
    - base

{% set id = salt['grains.get']('id', '') %}
    
 ## 'E@(?i)ip-172-31-26-84.us-west-2.compute.internal': [role.salt-master]

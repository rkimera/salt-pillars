base:
  'ip-172-31-26-84.us-west-2.compute.internal':
    - pkg

{% set id = salt['grains.get']('id', '') %}
    
 ## 'E@(?i)ip-172-31-26-84.us-west-2.compute.internal': [role.salt-master]

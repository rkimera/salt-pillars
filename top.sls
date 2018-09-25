base:
  '*':
    - users
    - pkg

  'E@(?i)ip-172-31-26-84.us-west-2.compute.internal': [role.salt-master]
  
  
 ## Finally, assign an optional host-specific Pillar SLS.
  {{ minion_id|yaml_encode }}:
    - ignore_missing: True
    - {{ minion_id|lower|yaml_encode }}

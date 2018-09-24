base:
  '*':
    - defaults
 ##   - environment.dev


  ## role assignments
  ##'E@(?i)ip-172-31-26-84.us-west-2.compute.internal':  [role.salt-master]
  ##'E@(?i)ip-172-31-23-195':     [role.aceug]
  ##'E@(?i)ip-172-31-28-38.us-west-2.compute.internal': [role.network-tools]

 

  ## Finally, assign an optional host-specific Pillar SLS.
##  {{ minion_id|yaml_encode }}:
##    - ignore_missing: True
##- {{ minion_id|lower|yaml_encode }}

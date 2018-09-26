base:
  '*':
    - users

## Assign Roles to minions
  'E@(?i)ip-172-31-26-84.us-west-2.compute.internal': 
    - role.salt-master

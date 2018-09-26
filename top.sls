base:
  '*':
    - users
  '*users*'
  {% set role = salt['grains.get']('role',[]) -%} 
  {% for role in role -%} 
  'roles:{{ role }}':
    - match: grain
    - role.{{ role }}
  {% endfor -%} 
## Assign Roles to minions
  'E@(?i)ip-172-31-26-84.us-west-2.compute.internal': 
    - role.users



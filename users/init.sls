{% for name, user in pillar.get('users', {}).items() if user.absent is not defined or not user.absent %}
{%- if user == None -%}
{%- set user = {} -%}
{%- endif -%}
{%- set user_files = salt['pillar.get'](('users:' ~ name ~ ':user_files'), {'enabled': False}) -%}
{%- set home = user.get('home', "/home/%s" %name) -%}
{%- set user_group = name -%}


{% endfor %}

{% for user, args in pillar['users'].iteritems() %}
{{ user }}:
  user.present:
    - home: /home/{{ user }}
    - shell: {{ pillar.get('unprivileged_shell', '/bin/bash') }}
    - uid: {{ args['uid'] }}
    - gid: {{ args['gid'] }}
    - fullname: {{ args['fullname'] }}
{% if not 'unprivileged_keep_password' in pillar %}
    - password: '!'
{% endif %}
{% if 'unprivileged_groups' in pillar %}
    - groups: {{ pillar.unprivileged_groups }}
{% endif %}

{% if 'ssh_auth' in args %}
/home/{{ user }}/.ssh:
  file.directory:
    - user: {{ user }}
    - group: {{ args['group'] }}
    - mode: 700
    - require:
      - user: {{ user }}

/home/{{ user }}/.ssh/authorized_keys:
  file.managed:
    - user: {{ user }}
    - group: {{ args['group'] }}
    - mode: 600
    - require:
      - file: /home/{{ user }}/.ssh

{{ args['ssh_auth']['key'] }}:
  ssh_auth.present:
    - user: {{ user }}
    - comment: {{ args['ssh_auth']['comment'] }}
    - require:
      - file: /home/{{ user }}/.ssh/authorized_keys
{% endif %}
{% endfor %}

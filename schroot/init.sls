include:
  - schroot.prereq

{% from 'schroot/state.jinja' import schroot_state_loop %}
{{ schroot_state_loop() }}

/etc/default/schroot:
  file.managed:
    - source: salt://schroot/default
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - sls: schroot.prereq

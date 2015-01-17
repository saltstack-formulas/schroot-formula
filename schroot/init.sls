include:
  - schroot.prereq

{% from 'schroot/state.jinja' import schroot_state_loop %}
{{ schroot_state_loop() }}

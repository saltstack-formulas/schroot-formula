{% from 'schroot/state.jinja' import schroot_basedir %}

# Ensure we have debootstrap/cdebootstrap
include:
  - debootstrap.prereq

# And schroot
schroot:
  pkg.installed

# And the basedir hosting all chroots
schroot_basedir:
  file.directory:
    - name: {{ schroot_basedir() }}
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

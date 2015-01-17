# Ensure we have debootstrap/cdebootsrap
include:
  - debootstrap.pkg

# And schroot
schroot:
  pkg.installed

# And the basedir hosting all chroots
{{ salt['pillar.get']('schroot:basedir', '/srv/chroots') }}:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

=======
schroot
=======

This formula makes it easy to configure schroot. It relies on
debootstrap-formula to setup the underlying chroot and registers
them in ``/etc/schroot/chroot.d/``.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``schroot``
-----------

Create chroots described in pillar data below ``schroot:chroots``. The
chroot description is an extension of the pillar data used by
``debootstrap-formula`` (check its documentation to learn the basics)
with the following changes:

- The chroot name (as registered in schroot) is generated with the
  ``<identifier>-<architecture>`` template (where identifier is the
  name of the top-level key).
- You can use the ``architectures`` parameter (as a list) to create
  the same chroot for multiple architectures (assuming they are compatible
  with your CPU and kernel).
- You can set the ``test_alias`` paramater to true to register the same
  chroot twice: the chroot with the usual name will have persistent changes, 
  but there will also be a ``<identifier>-<architecture>-test`` chroot
  configured to use a temporary overlay (with union-type=aufs) too. Very
  practical to do some quick and dirty tests.
- You can add/override arbitrary parameters of the generated schroot
  configuration file in ``schroot.conf``.
- By default, the state will add an alias ``<identifier>`` (i.e. without
  the architecture suffix) to the chroot matching the host architecture.
  You can disable this by setting ``short_alias`` to False.
- You can set ``dist_aliases`` to True if you want to add aliases based
  on alternate names of the distribution (e.g. you get "unstable-amd64"
  and "unstable" for a Debian chroot based on "sid". This is interesting
  for sbuild users for example).
- You can add supplementary aliases in ``extra_aliases``. This is useful
  to give supplementary names to the chroot, possibly based on the name
  of extra repositories that you enabled in the chroot.

Here's a quick sample::

    debootstrap:
      basedir: /srv/chroots
    schroot:
      schroot.conf:
        groups: root,rhertzog
      chroots:
        sid:                          # a chroot identifier
          vendor: debian              # the name of the vendor
          dist: sid                   # codename of the release to bootstrap
          architectures:
            - amd64
            - i386
          schroot.conf:
            profile: desktop
          test_alias: True
          short_alias: True           # Generate "" alias
          dist_aliases: False
          extra_aliases:
            - experimental
          # You can also put parameters used by debootstrap-formula
          extra_dists:                # supplementary APT repositories to 
            - experimental            # enable
          with_source: True           # include source repositories too
        another-chroot:
          ...

``schroot.prereq``
------------------

Ensure that schroot is installed and that the base directory hosting
chroots exists. In general, there's no reason to use this state directly.
The fact that it is separated from ``schroot`` is only due to an implementation
detail.

``Configuration``
=================
See the pillar.example file to have an idea of everything that can
be customized in this formula.

``Extending``
=============
You can build your own schroot-based formula by reusing some of the macros
in ``schroot/state.jinja``. sbuild-formula builds on this possibility if you
want an example.

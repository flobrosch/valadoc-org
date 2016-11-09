# The valadoc.org repo has moved [here](https://github.com/valadoc/valadoc-org)

Valadoc-org
===========

Stays crunchy, even in milk.

This package contains build-tools used to generate valadoc.org and ideally shouldn't be used to
generate other pages.


Building
========

In order to build the docs you will need the following:
* `valadoc` past [this](https://git.gnome.org/browse/valadoc/commit/?id=f5b61201cc434cdb55d363d318e45ae423aada28) commit
* `php`
* 4 GB of free space

On elementary OS or Ubuntu run:
```bash
sudo add-apt-repository ppa:vala-team;
sudo apt update;
sudo apt install valac valadoc libvaladoc-dev unzip;
```

Arch or derivatives run:
```bash
yaourt -S valadoc-git php
```

After you have `valadoc` installed, you can move to building the documentation. Simply run:
```bash
make serve
```

and grab yourself a cup of coffee, or:

```bash
make serve-mini
```

for a minimal test version. This will take a bit of time. If you
encounter an error at this step, please see the [common pitfalls](#common-pitfalls) section. After
you completed building, you should see a `valadoc.org` folder.

To access the documentation navigate your browser to http://localhost:7777.


Add New Packages
================

Open `documentation/packages.xml` and add a new package-entry.

Use `<external-package>` to create external links:

```xml
<external-package name="package-name" link="http://path/to/docs">
  short description
</external-package>
```

Use `<package>` to build and include documentation for vapi files:

```xml
<package name="gdl-1.0">
  short description
</package>
```

The following attributes are supported:

| Name              | Description                                        |
|-------------------|----------------------------------------------------|
| name              | The vapi name                                      |
| deprecated        | Set it to '"true"' to mark a package as deprecated |
| maintainers       | List of binding maintainers                        |
| gir               | The GIR file used to extract documentation from    |
| c-docs            | Link to C documentation                            |
| ignore            | Do not build documentation for this entry          |
| home              | Homepage link                                      |
| flags             | Additional vala flags (Missing dependencies, ...)  |
| gallery	        | Link to a GTK-Doc widget gallery                   |
| vapi-image-source | Source to download images from                     |


Referenced GIR and vapi-files have to be part of one of the following repositories:
- [vala](http://vala-project.org/)
- [vala-girs](https://github.com/nemequ/vala-girs)
- [vala-extra-vapis](https://github.com/nemequ/vala-extra-vapis)


Add New Source Code Examples
============================

Copy your examples to `examples/<vapi-name>/` and add a new entry to `examples/<vapi-name>/<vapi-name>.valadoc.examples`:

```xml
<example>
  <title>Example Title</title>
  <image>optional-screenshot.png</image>
  <file>file-name-1.vala</file>
  <file>file-name-2.vala</file>
  <compile>valac file-name1.vala file-name-2.vala ...</compile>
  <node>Associated.Symbol.name1</node>
  <node>Associated.Symbol.name2</node>
</example>
```

Add Handwritten Documentation
=============================

Create a new file called `<vapi-name>.valadoc` in `documentation/<vapi-name>/`:

```
...

/**
 * My valadoc comment
 */
c::c_symbol_name
```

```
...

/**
 * My valadoc comment
 */
Vala.Symbol.Name
```

Tool Overview
==============

- *generator:* Parses `packages.xml` files describing all packages. It is responsible for building
  up the page. It fetches resources such as images from specified sources, computes valadoc-calls,
  builds documentation for specified packages and puts-together the whole page. (`make serve`, `make serve-mini`)
- *configgen:* Used to generate configuration files for our search index.
- *valadoc-example-gen:* Internally used to generate example listings.
- *valadoc-example-tester:* Compiles and checks all registered examples. (`make test-examples`)


Common Pitfalls
===============

`Uncaught Error: Class 'mysqli' not found`
- Uncomment `extension=mysqli.so` in your OS's php.ini (`find /etc -name php.ini`)

`error: failed to load driver`
- Your valadoc version does not support the requested vala version. Install a recent vala version and
  recompile valadoc.
- Change `VALAC_VERSION` in Makefile.

Other errors:
- Check `LOG` in the root of this repo for more information
- Have you run out of disk space?


Contact And Help
=================

- [Homepage](http://www.valadoc.org), [GIT](https://github.com/flobrosch/valadoc-org)
- [Issue Tracker, valadoc.org](https://github.com/flobrosch/valadoc-org/issues)
- [Issue Tracker, valadoc](https://bugzilla.gnome.org/page.cgi?id=browse.html&product=valadoc)
- IRC: irc.gnome.org, #vala (flo, UTC+01:00)
- Mail: flo.brosch@gmail.com

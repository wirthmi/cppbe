cpp-be
======

Smart GNU Make based build environment for C++.

### Features

  * It **works out of the box** without any need of complex configuration.

  * Project's **header and source files are automatically hooked up** into the
  building process. No user's interaction is required.

  * Building process is fully **parallelized** and **based only on truly
  affected files**. Hence building and rebuilding are as fast as possible.

  * Building process is also at most automatized and whole is **invokable by
  a single command**. Though partial builds are still possible.

  * Almost all project's functionality is being **built into a static
  library** because of easy linking from other projects.

  * Integrates really easy to get started **unit testing** framework
  [Catch](https://github.com/philsquared/Catch).

  * But also allows to easily write any kind of **stand-alone tests**.

  * Simplifies **automatic code styling** via
  [Artistic Style](http://astyle.sourceforge.net/) a.k.a. astyle.

  * Contains an initial [Doxygen](http://www.doxygen.org/) setup for
  automatically **generated project's documentation**.


### Requirements

For a maximum functionality of the build environment you will need the
following software.

  * [GNU core utilities](http://www.gnu.org/software/coreutils/)
  (make, cat, sed, find, nproc etc.)

  * [GCC](http://gcc.gnu.org/) or [Clang](http://clang.llvm.org/)
  C++ compiler

  * [Artistic Style](http://astyle.sourceforge.net/) tool

  * [Doxygen](http://www.doxygen.org/) with
  [Graphviz](http://www.graphviz.org/) toolkit


### Usage

At first you may need to make some configuration changes of the build
environment in the `.be/config.mk` file. Commented values are defaults.
Everything is nicely explained.

After that you can add all your header and source files into the `src/`
directory. They will be hooked up automatically.

For launching the building (or rebuilding) process run simply a `make build`
command. After that all created binaries will be placed into the `build/`
directory.

Command `make doc` will create a generated documentation into the `doc/`
directory.

For styling your header and source files according to your code style config
run command `make style` inside the `src/` directory.

All your tests should be placed within one of the `test/` subdirectories and
named with `test_` prefix. Each of stand-alone tests must implement own
`main()` function and you have to run them on your own because they are not
intended to have some common interface. On the other hand unit tests should
be launched all at once via `make run` command inside the `test/unit/`
directory.

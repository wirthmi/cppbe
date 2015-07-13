cppbe
=====

Smart GNU Make based build environment for C++.

### Features

  * It **works out of the box** without any need of complex initial configuration.

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
following software (sorted by their importance).

  * [GNU core utilities](http://www.gnu.org/software/coreutils/)
  (make, cat, sed, awk, find, nproc etc.)

  * [GCC](http://gcc.gnu.org/) or [Clang](http://clang.llvm.org/)
  C++ compiler

  * [Artistic Style](http://astyle.sourceforge.net/) tool

  * [Doxygen](http://www.doxygen.org/) with
  [Graphviz](http://www.graphviz.org/) toolkit

  * [Vim](http://www.vim.org/) editor


### Usage

At first you may need to make some configuration changes of the build
environment. You can do it by running `make config` which opens your preferred
text editor (see `echo $VISUAL` or `echo $EDITOR`) or
[Vim](http://www.vim.org/) if you don't have any preferred one. Same thing can
be achieved by direct editation of the `.be/config.mk` file. All commented
values are defaults.

After that you can start adding your header and source files into the `src/`
directory. They will be hooked up into the building process automatically.

For launching the building (or rebuilding) process run simply a `make build` or
`cd build/; make` command. After that all created binaries will be placed
within the `build/` directory.

Command `make doc` or `cd doc/; make` will create a generated documentation via
[Doxygen](http://www.doxygen.org/) into the `doc/` directory.

Run command `cd src/; make style` for styling your header and source files
using the [Artistic Style](http://astyle.sourceforge.net/) according to your
code style configuration.

All your tests should be placed within one of the `test/` subdirectories and
named with `test_` prefix. Each of standalone tests must implement own
`main()` function and you have to run them on your own because they are not
intended to have some common interface. On the other hand unit tests should
be launched all at once via `cd test/unit/; make run` command.


###### Create Repository Example

Using the following set of commands you can create a new GitHub repository
for your project and integrate the build environment into it. The advantage
is that the build environment itself is easily updatable from upstream.
Actually this is the way I use it.

```shell
# create a GitHub repository with some README.md
firefox https://github.com/new

# clone created repository and add cppbe remote (or use HTTPS variants)
git clone git@github.com:wirthmi/project.git
git remote add cppbe git@github.com:wirthmi/cppbe.git
git remote set-url --push cppbe no_push_url

# this one fetches latest stable build environment, use this also for fetching
# new versions later, before commit some conflicts may have to be resolved
git fetch cppbe --no-tags
git merge --squash cppbe/master
git commit -m "get latest build environment"

# edit build environment configuration
vim .be/config.mk
git commit -m "change build environment config" .be/config.mk

# name project in Doxygen configuration
vim doc/doxygen.conf
git commit -m "change doxygen config" doc/doxygen.conf

# push the master branch
git push

# create and push a develop branch
git checkout -b develop
git push --set-upstream origin develop
```


### Known Issues

  * The build environment currently doesn't support source files using
  white-space characters in their names. This is my personal decision but may
  be it will be handled properly in the future. Currently I consider such kind
  of names as a bad habit and IMHO they go against any good coding standard.
  Handling these names properly would result into less readable code of the
  build environment itself and readability is more important for me in this
  case.

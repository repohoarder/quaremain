# Quaremain

Manage your basic survival resources like food and water
for preparation of emergency times. Keep track of costs and food
calories.

Spend and stock wisely for the unexpected with Quaremain.


Available on GNU/Linux Ubuntu 20.04 as a graphical desktop application.


## Version



## Status

Unstable

## Downloads
### Executables
- Self contained executable for Ubuntu 20.04 and Xubuntu 20.04.
- For Kubuntu and other
  Ubuntu 20.04 flavors (run apt install libwebkit2gtk-4.0-dev first)

- https://github.com/momozor/quaremain/releases/tag/0.6.0

## Building

### Dependencies

#### OpenSUSE Tumbleweed (as in 2020/04/12)

For server

- sbcl (or ccl from Clozure Common Lisp official website)
- quicklisp (manually install and download from Quicklisp's official website)
- sqlite3-devel
- zlib-devel

For client

- gcc
- make
- pkg-config
- webkit2gtk3-devel

#### Ubuntu 20.04

For server

- sbcl (or ccl from Clozure Common Lisp official website)
- quicklisp (manually install and download from Quicklisp's official website)
- libsqlite3-dev
- zlib1g-dev

For client

- build-essential (for most make and C compilers dependencies)
- pkg-config
- libwebkit2gtk-4.0-dev


##### Build And Run

By default, Quaremain uses SBCL compiler to build a small sized
self-contained executable with the trade off of high-memory usage.

If you prefer lower memory usage, use CCL (Clozure implementation) to build,
but with the result of bigger executable.

Deployment tarball size shouldn't really matter,
if you distribute it as a compressed archive.

By default, uses SBCL to compile.

Replace with make LISP=lx86cl64 to use CCL.

`$ make`

To make the launcher as an executable.

`$ chmod a+x ./Quaremain`

Run.

`$ ./Quaremain`

## Testing

`$ make test`

## Distributing For End Users

Currently, Quaremain is tested on OpenSUSE Tumbleweed and
Ubuntu 20.04 (Focal Fossa). You must build on similar target platform
to make a working distributable self-contained executable tarball archive.

In a nutshell, if you want to distribute a run-out-of-the box Quaremain
software for Ubuntu 20.04, you must build Quaremain on Ubuntu 20.04. Same
for OpenSUSE Tumbleweed.

To simplify this process, run:

- `$ make ubuntu20.04-tarball` if you want to build for Ubuntu 20.04

or

- `$ make opensusetumbleweed-tarball`

if you want to build for OpenSUSE Tumbleweed.

## Known Issues

1. Server build with Clozure Common Lisp implementation [Version 1.11.5/v1.11.5
(LinuxX8664)] quitting phase ends up in the debugger instead of actually exiting
program.

2. Smaller client window (if resized) will likely hide the navigation toolbars.
Maybe set a minimal default size to fix this issue?

3. You always need to (slime-cd) in SLIME to the project directory. This
should be resolved soon since it seems Deploy handles the relative
path for the end executable automatically. We can go back to
use merge-pathnames and current project directory if my
assumption about Deploy is correct.

4. Memory usage of SBCL's built executable is unnecesarily high.
I tried it with CCL and it uses around 20-30MB+ compared to
SBCL's 100MB+ for the same version of the program.
It seems this issue caused by the SBCL garbage
collector type usage (sacrificing memory for
the excellent execution speed, I believe?).

Will certainly make CCL as the default implementation
but it's not possible currently due to issue 1.


## Contributing and reporting issues

If you want to report a bug, to discuss features,
to ask questions, or to send improvement patches,
please open an issue or pull request
at https://github.com/momozor/quaremain

If you don't prefer to use Github, consider email
me your questions or patches directly to
skelic3@gmail.com or momozor4@gmail.com

Quaremain uses git as the primary version
control system.


## Author

[Momozor](https://github.com/momozor) <skelic3@gmail.com, momozor4@gmail.com>


## License

This software is released under the GPL-3.0 or any later version.
Please see COPYING file for more details.

For JQuery, Bootstrap, PopperJS, and Sweetalert code licenses, see 
COPYING.jquery, COPYING.bootstrap, COPYING.popper, and COPYING.sweetalert in 
static/js directory.

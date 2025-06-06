# Shell Login

## Enabling Shell Logins

NuttShell sessions can be protected by requiring that the user supply
username and password credentials at the beginning of the session.
Logins can be enabled for standard USB or serial consoles with:

    CONFIG_NSH_CONSOLE_LOGIN=y

Logins for Telnet sessions can be enabled separately with:

    CONFIG_NSH_TELNET_LOGIN=y

Logins can be enabled for either or both session types. On a successful
login, the user will have access to the NSH session:

    login: admin
    password:
    User Logged-in!
    
    NuttShell (NSH)
    nsh>

After each failed login attempt, a delay can be set up. The purpose of
this delay is to discourage attempts to crack the password by brute
force. That delay is configured with:

    CONFIG_NSH_LOGIN_FAILDELAY=0

This setting provides the login failure delay in units of milliseconds.
The system will pause this amount of time after each failed login
attempt. After a certain number of failed login attempts, the session
will be closed. That number is controlled by:

    CONFIG_NSH_LOGIN_FAILCOUNT=3

## Verification of Credentials

There are three ways that NSH can be configured to verify user
credentials at login time:

> 1.  The simplest implementation simply uses fixed login credentials
>     and is selected with:
>     
>         CONFIG_NSH_LOGIN_FIXED=y
>     
>     The fixed login credentials are selected via:
>     
>         CONFIG_NSH_LOGIN_USERNAME=admin
>         CONFIG_NSH_LOGIN_PASSWORD="Administrator"
>     
>     This is not very flexible since there can be only one user and the
>     password is fixed in the FLASH image. This option is also not very
>     secure because a malicious user could get the password by just
>     looking at the `.text` strings in the flash image.
> 
> 2.  NSH can also be configured to defer the entire user credential
>     verification to platform-specific logic with this setting:
>     
>         CONFIG_NSH_LOGIN_PLATFORM=y
>     
>     In this case, NSH will call a platform-specific function to
>     perform the verification of user credentials. The
>     platform-specific logic must provide a function with the following
>     prototype:
>     
>     ``` c
>     int platform_user_verify(FAR const char *username, FAR const char *password);
>     ```
>     
>     which is prototyped an described in `apps/include/nsh.h` and which
>     may be included like:
>     
>     ``` c
>     #include <apps/nsh.h>
>     ```
>     
>     An appropriate place to implement this function might be in the
>     directory `apps/platform/<board>`.
> 
> 3.  A final option is to use a password file contained encrypted
>     password information. This final option is selected with the
>     following and described in more detail in the following paragraph:
>     
>         CONFIG_NSH_LOGIN_PASSWD=y

## Password Files

NuttX can also be configured to support a password file, by default at
`/etc/passwd`. This option enables support for a password file:

    CONFIG_NSH_LOGIN_PASSWD=y

This options requires that you have selected `CONFIG_FSUTILS_PASSWD=y`
to enable the access methods of `apps/fsutils/passwd`:

    CONFIG_FSUTILS_PASSWD=y

And this determines the location of the password file in a mounted
volume:

    CONFIG_FSUTILS_PASSWD_PATH="/etc/passwd"

`/etc/passwd` is a *standard* location, but you will need to locate the
password where ever you have a mounted volume.

The password file can be a fixed list of users in a ROMFS file system or
a modifiable list maintained in a file in some writable file system. If
the password file lies in a read-only file system like ROMFS, then you
should also indicate that the password file is read-only.

> CONFIG\_FSUTILS\_PASSWD\_READONLY=y

If the password file is writable, then additional NSH commands will be
enabled to modify the password file: `` `useradd ``
\<\#cmduseradd\><span class="title-ref">\_\_, </span>`userdel`
\<\#cmduserdel\><span class="title-ref">\_\_, and </span>`passwd`
\<\#cmdpasswd\>\`\_\_. If you do not wish you have these commands
available, then they should be specifically disabled.

The password file logic requires a few additional settings:

> 1.  The size of dynamically allocated and freed buffer that is used
>     for file access:
>     
>         CONFIG_FSUTILS_PASSWD_IOBUFFER_SIZE=512
> 
> 2.  And the 128-bit encryption key. The password file currently uses
>     the Tiny Encryption Algorithm (TEA), but could be extended to use
>     something more powerful.
>     
>     > CONFIG\_FSUTILS\_PASSWD\_KEY1=0x12345678
>     > CONFIG\_FSUTILS\_PASSWD\_KEY2=0x9abcdef0
>     > CONFIG\_FSUTILS\_PASSWD\_KEY3=0x12345678
>     > CONFIG\_FSUTILS\_PASSWD\_KEY4=0x9abcdef0

Password can only be decrypted with access to this key. Note that this
key could potentially be fished out of your FLASH image, but without any
symbolic information, that would be a difficult job since the TEA KEY is
binary data and not distinguishable from other binary data in the FLASH
image.

If the password file is enabled (`CONFIG_NSH_LOGIN_PASSWD=y`), then the
fixed user credentials will not be used for the NSH session login.
Instead, the password file will be consulted to verify the user
credentials.

## Creating a Password File for a ROMFS File System

What we want to accomplish is a ROMFS file system, mounted at `/etc` and
containing the password file, `passwd` like:

    NuttShell (NSH)
    nsh> ls -Rl /etc
    /etc:
     dr-xr-xr-x       0 .
     dr-xr-xr-x       0 init.d/
     -r--r--r--      39 passwd
    /etc/init.d:
     dr-xr-xr-x       0 ..
     -r--r--r--     110 rcS
     -r--r--r--     110 rc.sysinit
    nsh>

Where `/etc/init.d/rc.sysinit` is the system init script and
`/etc/init.d/rcS` is the start-up script; `/etc/passwd` is a the
password file. Note that here we assume that you are already using a
start-up script. We can then piggyback the passwd file into the `/etc`
file system already mounted for the NSH start up file as described above
[above](#custinit).

I use the sim/nsh configuration to create a new password file, but other
configurations could also be used. That configuration already supports a
ROMFS file system, passwords, and login prompts. First, I make these
changes to that configuration.

> 1.  Disable logins:
> 
> > 
> > 
> > ``` diff
> > - CONFIG_NSH_CONSOLE_LOGIN=y
> > + # CONFIG_NSH_CONSOLE_LOGIN is not set
> >   # CONFIG_NSH_TELNET_LOGIN is not set
> > ```
> 
> 1.  Move the password file to a write-able file system:
> 
> > 
> > 
> > ``` diff
> > - CONFIG_FSUTILS_PASSWD_PATH="/etc/passwd"
> > + CONFIG_FSUTILS_PASSWD_PATH="/tmp/passwd"
> > ```
> 
> 1.  Make the password file modifiable
> 
> > 
> > 
> > ``` diff
> > - CONFIG_FSUTILS_PASSWD_READONLY=y
> > # CONFIG_FSUTILS_PASSWD_READONLY is not set
> > ```

Now rebuild the simulation. No login should be required to enter the
shell and you should find the `` `useradd ``
\<\#cmduseradd\><span class="title-ref">\_\_, </span>`userdel`
\<\#cmduserdel\><span class="title-ref">\_\_, and </span>`passwd`
\<\#cmdpasswd\><span class="title-ref">\_\_ commands available in the
help summary, provided that they are enabled. Make certain that the
</span><span class="title-ref">useradd</span>\` command is not disabled:

    # CONFIG_NSH_DISABLE_USERADD is not set

Use the NSH `` `useradd `` \<\#cmduseradd\>\`\_\_ command to add new
uses with new user passwords like:

    nsh> useradd <username> <password>

Do this as many times as you would like. Each time that you do this a
new entry with an encrypted password will be added to the `passwd` file
at `/tmp/passwd`. You can see the content of the password file like:

    nsh> cat /tmp/passwd

When you are finished, you can simply copy the `/tmp/passwd` content
from the `cat` command and paste it into an editor. Make sure to remove
any carriage returns that may have ended up on the file if you are using
Windows.

Then create/re-create the `nsh_romfsimg.h` file as described below.

> 1.  The content on the `nsh_romfsimg.h` header file is generated from
>     a template directory structure. Create the directory structure:
>     
>         mkdir etc
>         mkdir etc/init.d
>     
>     And copy your existing startup script into `etc/init.c` as `rcS`.
> 
> 2.  Save your new password file in the `etc/` directory as `passwd`.
> 
> 3.  Create the new ROMFS image:
>     
>         genromfs -f romfs_img -d etc -V MyVolName
> 
> 4.  Convert the ROMFS image to a C header file:
>     
>         xxd -i romfs_img >nsh_romfsimg.h
> 
> 5.  Edit `nsh_romfsimg.h`: Mark both data definitions as `const` so
>     that the data will be stored in FLASH.
> 
> 6.  Edit nsh\_romfsimg.h, mark both data definitions as `const` so
>     that that will be stored in FLASH.

There is a good example of how to do this in the NSH simulation
configuration at
[boards/sim/sim/sim/configs/nsh](https://github.com/apache/nuttx/blob/master/boards/sim/sim/sim/configs/nsh/).
The ROMFS support files are provided at
[boards/sim/include](https://github.com/apache/nuttx/blob/master/boards/sim/sim/sim/include/)
and the
\[<span class="title-ref">/platform\](</span>/platform.md)s/sim/sim/boards/sim/index\`
page provides detailed information about creating and modifying the
ROMFS file system.

Configuration Settings
======================

The availability of the above commands depends upon features that may or
may not be enabled in the NuttX configuration file. The following
`cmdtable <cmddependencies>`{.interpreted-text role="ref"} indicates the
dependency of each command on NuttX configuration settings. General
configuration settings are discussed in the NuttX Porting Guide.
Configuration settings specific to NSH as discussed at the
`cmdbottom <nshconfiguration>`{.interpreted-text role="ref"} of this
document.

Note that in addition to general NuttX configuration settings, each NSH
command can be individually disabled via the settings in the rightmost
column. All of these settings make the configuration of NSH potentially
complex but also allow it to squeeze into very small memory footprints.

Command Dependencies on Configuration Settings {#cmddependencies}
----------------------------------------------

+----------------------+----------------------+----------------------+
| Command              | Depends on           | Can Be Disabled with |
|                      | Configuration        |                      |
+======================+======================+======================+
| `[`                  | !                    | `CONF                |
|                      | `CONFI               | IG_NSH_DISABLE_TEST` |
|                      | G_NSH_DISABLESCRIPT` |                      |
+----------------------+----------------------+----------------------+
| `cmdaddrout          | `CONFIG_NET` &&      | `CONFIG_N            |
| e`{.interpreted-text | `CONFIG_NET_ROUTE`   | SH_DISABLE_ADDROUTE` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdar               | `CONFIG_NET` &&      | `CON                 |
| p`{.interpreted-text | `CONFIG_NET_ARP`     | FIG_NSH_DISABLE_ARP` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdbase64de         | `CON                 | `CONFIG_NS           |
| c`{.interpreted-text | FIG_NETUTILS_CODECS` | H_DISABLE_BASE64DEC` |
| role="ref"}          | &&                   |                      |
|                      | `C                   |                      |
|                      | ONFIG_CODECS_BASE64` |                      |
+----------------------+----------------------+----------------------+
| `cmdbase64en         | `CON                 | `CONFIG_NS           |
| c`{.interpreted-text | FIG_NETUTILS_CODECS` | H_DISABLE_BASE64ENC` |
| role="ref"}          | &&                   |                      |
|                      | `C                   |                      |
|                      | ONFIG_CODECS_BASE64` |                      |
+----------------------+----------------------+----------------------+
| `cmdbasenam          | .                    | `CONFIG_N            |
| e`{.interpreted-text |                      | SH_DISABLE_BASENAME` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdbrea             | !                    | .                    |
| k`{.interpreted-text | `CONFI               |                      |
| role="ref"}          | G_NSH_DISABLESCRIPT` |                      |
|                      | && !                 |                      |
|                      | `CONFI               |                      |
|                      | G_NSH_DISABLE_LOOPS` |                      |
|                      |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdca               | `CON                 | .                    |
| t`{.interpreted-text | FIG_NSH_DISABLE_CAT` |                      |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdc                | !                    | `CO                  |
| d`{.interpreted-text | `CON                 | NFIG_NSH_DISABLE_CD` |
| role="ref"}          | FIG_DISABLE_ENVIRON` |                      |
+----------------------+----------------------+----------------------+
| `cmdcm               | `CON                 | .                    |
| p`{.interpreted-text | FIG_NSH_DISABLE_CMP` |                      |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdc                | `CO                  | .                    |
| p`{.interpreted-text | NFIG_NSH_DISABLE_CP` |                      |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmddat              | `CONF                | .                    |
| e`{.interpreted-text | IG_NSH_DISABLE_DATE` |                      |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmddelrout          | `CONFIG_NET` &&      | `CONFIG_N            |
| e`{.interpreted-text | `CONFIG_NET_ROUTE`   | SH_DISABLE_DELROUTE` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdd                | !                    | `CO                  |
| f`{.interpreted-text | `CONFIG              | NFIG_NSH_DISABLE_DF` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
+----------------------+----------------------+----------------------+
| `cmddirnam           | `CONFIG_             | .                    |
| e`{.interpreted-text | NSH_DISABLE_DIRNAME` |                      |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmddmes             | `C                   | `CONFI               |
| g`{.interpreted-text | ONFIG_RAMLOG_SYSLOG` | G_NSH_DISABLE_DMESG` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdech              | `CONF                | .                    |
| o`{.interpreted-text | IG_NSH_DISABLE_ECHO` |                      |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmden               | `CONFIG_FS_PROCFS`   | `CON                 |
| v`{.interpreted-text | && !                 | FIG_NSH_DISABLE_ENV` |
| role="ref"}          | `CON                 |                      |
|                      | FIG_DISABLE_ENVIRON` |                      |
|                      | && !                 |                      |
|                      | `CONFIG_PRO          |                      |
|                      | CFS_EXCLUDE_ENVIRON` |                      |
+----------------------+----------------------+----------------------+
| `cmdexe              | `CONF                | .                    |
| c`{.interpreted-text | IG_NSH_DISABLE_EXEC` |                      |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdexi              | `CONF                | .                    |
| t`{.interpreted-text | IG_NSH_DISABLE_EXIT` |                      |
| role="ref"}          | `CONFIG_NSH_VARS` && | `CONFIG              |
| `cmdexpor            | !                    | _NSH_DISABLE_EXPORT` |
| t`{.interpreted-text | `CON                 |                      |
| role="ref"}          | FIG_DISABLE_ENVIRON` |                      |
+----------------------+----------------------+----------------------+
| `cmdfre              | `CONF                | .                    |
| e`{.interpreted-text | IG_NSH_DISABLE_FREE` |                      |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdge               | `CONFIG_NET` &&      | > `CON               |
| t`{.interpreted-text | `CONFIG_NET_UDP` &&  | FIG_NSH_DISABLE_GET` |
| role="ref"}          | *MTU* \>= 58[^5]     |                      |
+----------------------+----------------------+----------------------+
| `cmdhel              | `CONF                | .                    |
| p`{.interpreted-text | IG_NSH_DISABLE_HELP` |                      |
| role="ref"}[^6]      |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdhexdum           | `CONFIG_             | .                    |
| p`{.interpreted-text | NSH_DISABLE_HEXDUMP` |                      |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdifconfi          | `CONFIG_NET` &&      | > `CONFIG_N          |
| g`{.interpreted-text | `CONFIG_FS_PROCFS`   | SH_DISABLE_IFCONFIG` |
| role="ref"}          | && !                 |                      |
|                      | `CONFIG_FS           |                      |
|                      | _PROCFS_EXCLUDE_NET` |                      |
+----------------------+----------------------+----------------------+
| `cmdifdow            | `CONFIG_NET` &&      | `CONFIG_N            |
| n`{.interpreted-text | `CONFIG_FS_PROCFS`   | SH_DISABLE_IFUPDOWN` |
| role="ref"}          | && !                 |                      |
|                      | `CONFIG_FS           | `CONFIG_N            |
| `cmdifu              | _PROCFS_EXCLUDE_NET` | SH_DISABLE_IFUPDOWN` |
| p`{.interpreted-text | `CONFIG_NET` &&      |                      |
| role="ref"}          | `CONFIG_FS_PROCFS`   |                      |
|                      | && !                 |                      |
|                      | `CONFIG_FS           |                      |
|                      | _PROCFS_EXCLUDE_NET` |                      |
+----------------------+----------------------+----------------------+
| `cmdinsmo            | `CONFIG_MODULE`      | `CONFIG_             |
| d`{.interpreted-text |                      | NSH_DISABLE_MODCMDS` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdirqinf           | !                    | .                    |
| o`{.interpreted-text | `CONFIG              |                      |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
|                      | &&                   |                      |
|                      | `CONFIG_FS_PROCFS`   |                      |
|                      | &&                   |                      |
|                      | `CONF                |                      |
|                      | IG_SCHED_IRQMONITOR` |                      |
+----------------------+----------------------+----------------------+
| `cmdkil              | `CONF                | .                    |
| l`{.interpreted-text | IG_NSH_DISABLE_KILL` |                      |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdlosetu           | !                    | `CONFIG_             |
| p`{.interpreted-text | `CONFIG              | NSH_DISABLE_LOSETUP` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
|                      | && `CONFIG_DEV_LOOP` |                      |
+----------------------+----------------------+----------------------+
| `cmdl                | `CONFIG              | `CO                  |
| n`{.interpreted-text | _PSEUDOFS_SOFTLINKS` | NFIG_NSH_DISABLE_LN` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdl                | `CO                  | .                    |
| s`{.interpreted-text | NFIG_NSH_DISABLE_LS` |                      |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdlsmo             | `CONFIG_MODULE` &&   | `CONFIG_             |
| d`{.interpreted-text | `CONFIG_FS_PROCFS`   | NSH_DISABLE_MODCMDS` |
| role="ref"}          | && !                 |                      |
|                      | `CONFIG_FS_PR        |                      |
|                      | OCFS_EXCLUDE_MODULE` |                      |
+----------------------+----------------------+----------------------+
| `cmdmd               | `CON                 | `CON                 |
| 5`{.interpreted-text | FIG_NETUTILS_CODECS` | FIG_NSH_DISABLE_MD5` |
| role="ref"}          | &&                   |                      |
|                      | `CON                 |                      |
|                      | FIG_CODECS_HASH_MD5` |                      |
+----------------------+----------------------+----------------------+
| `cmdm                | .                    | `CON                 |
| x`{.interpreted-text |                      | FIG_NSH_DISABLE_MB`, |
| role="ref"}          |                      | `CON                 |
|                      |                      | FIG_NSH_DISABLE_MH`, |
|                      |                      | `CO                  |
|                      |                      | NFIG_NSH_DISABLE_MW` |
+----------------------+----------------------+----------------------+
| `cmdmkdi             | (!                   | `CONFI               |
| r`{.interpreted-text | `CONFIG              | G_NSH_DISABLE_MKDIR` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
|                      | \|\| !               |                      |
|                      | `CONFIG_DISABLE_P    |                      |
|                      | SEUDOFS_OPERATIONS`) |                      |
+----------------------+----------------------+----------------------+
| `cmdmkfatf           | !                    | `CONFIG_             |
| s`{.interpreted-text | `CONFIG              | NSH_DISABLE_MKFATFS` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
|                      | &&                   |                      |
|                      | `CON                 |                      |
|                      | FIG_FSUTILS_MKFATFS` |                      |
+----------------------+----------------------+----------------------+
| `cmdmkfif            | `CONFIG_PIPES` &&    | `CONFIG              |
| o`{.interpreted-text | `C                   | _NSH_DISABLE_MKFIFO` |
| role="ref"}          | ONFIG_DEV_FIFO_SIZE` |                      |
|                      | \> 0                 |                      |
+----------------------+----------------------+----------------------+
| `cmdmkr              | !                    | `CONF                |
| d`{.interpreted-text | `CONFIG              | IG_NSH_DISABLE_MKRD` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
+----------------------+----------------------+----------------------+
| `cmdmoun             | !                    | `CONFI               |
| t`{.interpreted-text | `CONFIG              | G_NSH_DISABLE_MOUNT` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
+----------------------+----------------------+----------------------+
| `cmdm                | !                    | `CO                  |
| v`{.interpreted-text | `CONFIG              | NFIG_NSH_DISABLE_MV` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
|                      | \|\| !               |                      |
|                      | `CONFIG_DISABLE_     |                      |
|                      | PSEUDOFS_OPERATIONS` |                      |
+----------------------+----------------------+----------------------+
| `cmdnfsmoun          | !                    | `CONFIG_N            |
| t`{.interpreted-text | `CONFIG              | SH_DISABLE_NFSMOUNT` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
|                      | && `CONFIG_NET` &&   |                      |
|                      | `CONFIG_NFS`         |                      |
+----------------------+----------------------+----------------------+
| `cmdnslooku          | `CONFIG_LIBC_NETDB`  | `CONFIG_N            |
| p`{.interpreted-text | &&                   | SH_DISABLE_NSLOOKUP` |
| role="ref"}          | `CON                 |                      |
|                      | FIG_NETDB_DNSCLIENT` |                      |
+----------------------+----------------------+----------------------+
| `cmdpassw            | !                    | `CONFIG              |
| d`{.interpreted-text | `CONFIG              | _NSH_DISABLE_PASSWD` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
|                      | &&                   |                      |
|                      | `CONF                |                      |
|                      | IG_NSH_LOGIN_PASSWD` |                      |
+----------------------+----------------------+----------------------+
| `cmdpmconfi          | `CONFIG_PM`          | `CONFIG_N            |
| g`{.interpreted-text |                      | SH_DISABLE_PMCONFIG` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdpowerof          | `CONFI               | `CONFIG_N            |
| f`{.interpreted-text | G_BOARDCTL_POWEROFF` | SH_DISABLE_POWEROFF` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdp                | `CONFIG_FS_PROCFS`   | `CO                  |
| s`{.interpreted-text | && !                 | NFIG_NSH_DISABLE_PS` |
| role="ref"}          | `CONFIG_FS_          |                      |
|                      | PROCFS_EXCLUDE_PROC` |                      |
+----------------------+----------------------+----------------------+
| `cmdpu               | `CONFIG_NET` &&      | `CON                 |
| t`{.interpreted-text | `CONFIG_NET_UDP` &&  | FIG_NSH_DISABLE_PUT` |
| role="ref"}          | `                    |                      |
|                      | MTU >= 558`[^7],[^8] |                      |
+----------------------+----------------------+----------------------+
| `cmdpw               | !                    | `CON                 |
| d`{.interpreted-text | `CON                 | FIG_NSH_DISABLE_PWD` |
| role="ref"}          | FIG_DISABLE_ENVIRON` |                      |
+----------------------+----------------------+----------------------+
| `cmdreadlin          | `CONFIG              | `CONFIG_N            |
| k`{.interpreted-text | _PSEUDOFS_SOFTLINKS` | SH_DISABLE_READLINK` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdreboo            | `CONFIG_BOARD_RESET` | `CONFIG              |
| t`{.interpreted-text |                      | _NSH_DISABLE_REBOOT` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdr                | !                    | `CO                  |
| m`{.interpreted-text | `CONFIG              | NFIG_NSH_DISABLE_RM` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
|                      | \|\| !               | `CONFI               |
| `cmdrmdi             | `CONFIG_DISABLE_     | G_NSH_DISABLE_RMDIR` |
| r`{.interpreted-text | PSEUDOFS_OPERATIONS` |                      |
| role="ref"}          | !                    |                      |
|                      | `CONFIG              |                      |
|                      | _DISABLE_MOUNTPOINT` |                      |
|                      | \|!                  |                      |
|                      | `CONFIG_DISABLE_     |                      |
|                      | PSEUDOFS_OPERATIONS` |                      |
+----------------------+----------------------+----------------------+
| `cmdrmmo             | `CONFIG_MODULE`      | `CONFIG_             |
| d`{.interpreted-text |                      | NSH_DISABLE_MODCMDS` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdrout             | `CONFIG_FS_PROCFS`   | `CONFI               |
| e`{.interpreted-text | &&                   | G_NSH_DISABLE_ROUTE` |
| role="ref"}          | `CONFIG_FS           |                      |
|                      | _PROCFS_EXCLUDE_NET` |                      |
|                      | && !                 |                      |
|                      | `CONFIG_FS_P         |                      |
|                      | ROCFS_EXCLUDE_ROUTE` |                      |
|                      | &&                   |                      |
|                      | `CONFIG_NET_ROUTE`   |                      |
|                      | && !                 |                      |
|                      | `CONFI               |                      |
|                      | G_NSH_DISABLE_ROUTE` |                      |
|                      | &&                   |                      |
|                      | (`CONFIG_NET_IPv4`   |                      |
|                      | \|`CONFIG_NET_IPv6`) |                      |
+----------------------+----------------------+----------------------+
| `cmdrptu             | `CONFIG_RPTUN`       | `CONFI               |
| n`{.interpreted-text |                      | G_NSH_DISABLE_RPTUN` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdse               | `CONFIG_NSH_VARS`    | `CON                 |
| t`{.interpreted-text | \|\| !               | FIG_NSH_DISABLE_SET` |
| role="ref"}          | `CON                 |                      |
|                      | FIG_DISABLE_ENVIRON` |                      |
+----------------------+----------------------+----------------------+
| `cmdshutdow          | `CONFI               | `CONFIG_N            |
| n`{.interpreted-text | G_BOARDCTL_POWEROFF` | SH_DISABLE_SHUTDOWN` |
| role="ref"}          | \|\|                 |                      |
|                      | `CONFIG_BOARD_RESET` |                      |
+----------------------+----------------------+----------------------+
| `cmdslee             | .                    | `CONFI               |
| p`{.interpreted-text |                      | G_NSH_DISABLE_SLEEP` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdsource`          | `CONFIG_FILE_STREAM` | `CONFIG              |
|                      | && !                 | _NSH_DISABLE_SOURCE` |
| `cmdtelnet           | `CONFI               |                      |
| d`{.interpreted-text | G_NSH_DISABLESCRIPT` |                      |
| role="ref"}          | `CONFIG_NSH_TELNET`  |                      |
|                      | &&                   |                      |
|                      | `CO                  |                      |
|                      | NFIG_SYSTEM_TELNETD` |                      |
+----------------------+----------------------+----------------------+
| `cmdtes              | !                    | `CONF                |
| t`{.interpreted-text | `CONFI               | IG_NSH_DISABLE_TEST` |
| role="ref"}          | G_NSH_DISABLESCRIPT` |                      |
+----------------------+----------------------+----------------------+
| `cmdtim              | .                    | `CONF                |
| e`{.interpreted-text |                      | IG_NSH_DISABLE_TIME` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdtruncat          | !                    | `CONFIG_N            |
| e`{.interpreted-text | `CONFIG              | SH_DISABLE_TRUNCATE` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
+----------------------+----------------------+----------------------+
| `cmdumoun            | !                    | `CONFIG              |
| t`{.interpreted-text | `CONFIG              | _NSH_DISABLE_UMOUNT` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
+----------------------+----------------------+----------------------+
| `cmdunam             | .                    | `CONFI               |
| e`{.interpreted-text |                      | G_NSH_DISABLE_UNAME` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdunse             | `CONFIG_NSH_VARS`    | `CONFI               |
| t`{.interpreted-text | \|\| !               | G_NSH_DISABLE_UNSET` |
| role="ref"}          | `CON                 |                      |
|                      | FIG_DISABLE_ENVIRON` |                      |
+----------------------+----------------------+----------------------+
| `cmdurldecod         | !                    | `CONFIG_NS           |
| e`{.interpreted-text | `CON                 | H_DISABLE_URLDECODE` |
| role="ref"}          | FIG_NETUTILS_CODECS` |                      |
|                      | &&                   |                      |
|                      | `CO                  |                      |
|                      | NFIG_CODECS_URLCODE` |                      |
+----------------------+----------------------+----------------------+
| `cmdurlencod         | !                    | `CONFIG_NS           |
| e`{.interpreted-text | `CON                 | H_DISABLE_URLENCODE` |
| role="ref"}          | FIG_NETUTILS_CODECS` |                      |
|                      | &&                   |                      |
|                      | `CO                  |                      |
|                      | NFIG_CODECS_URLCODE` |                      |
+----------------------+----------------------+----------------------+
| `cmduserad           | !                    | `CONFIG_             |
| d`{.interpreted-text | `CONFIG              | NSH_DISABLE_USERADD` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
|                      | &&                   |                      |
|                      | `CONF                |                      |
|                      | IG_NSH_LOGIN_PASSWD` |                      |
+----------------------+----------------------+----------------------+
| `cmduserde           | !                    | `CONFIG_             |
| l`{.interpreted-text | `CONFIG              | NSH_DISABLE_USERDEL` |
| role="ref"}          | _DISABLE_MOUNTPOINT` |                      |
|                      | &&                   |                      |
|                      | `CONF                |                      |
|                      | IG_NSH_LOGIN_PASSWD` |                      |
+----------------------+----------------------+----------------------+
| `cmduslee            | .                    | `CONFIG              |
| p`{.interpreted-text |                      | _NSH_DISABLE_USLEEP` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdwge              | `CONFIG_NET` &&      | `CONF                |
| t`{.interpreted-text | `CONFIG_NET_TCP`     | IG_NSH_DISABLE_WGET` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+
| `cmdx                | .                    | `CO                  |
| d`{.interpreted-text |                      | NFIG_NSH_DISABLE_XD` |
| role="ref"}          |                      |                      |
+----------------------+----------------------+----------------------+

Built-In Command Dependencies on Configuration Settings
-------------------------------------------------------

All built-in applications require that support for NSH built-in
applications has been enabled. This support is enabled with
`CONFIG_BUILTIN=y` and `CONFIG_NSH_BUILTIN_APPS=y`.

  Command   Depends on Configuration
  --------- --------------------------------------------------------------------------------------------
  `ping`    `CONFIG_NET` && `CONFIG_NET_ICMP` && `CONFIG_NET_ICMP_SOCKET` && `CONFIG_SYSTEM_PING`
  `ping6`   `CONFIG_NET` && `CONFIG_NET_ICMPv6` && `CONFIG_NET_ICMPv6_SOCKET` && `CONFIG_SYSTEM_PING6`

NSH-Specific Configuration Settings {#nshconfiguration}
-----------------------------------

The behavior of NSH can be modified with the following settings in the
`boards/<arch>/<chip>/<board>/defconfig` file:

+----------------------------------+----------------------------------+
| Configuration                    | Description                      |
+==================================+==================================+
| > `CONFIG_NSH_READLINE`          | Selects the minimal              |
|                                  | implementation of `readline()`.  |
|                                  | This minimal implementation      |
|                                  | provides on backspace for        |
|                                  | command line editing. It expects |
|                                  | some minimal VT100 command       |
|                                  | support from the terminal.       |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_CLE`               | Selects the more extensive,      |
|                                  | EMACS-like command line editor.  |
|                                  | Select this option only if (1)   |
|                                  | you don\'t mind a modest         |
|                                  | increase in the FLASH footprint, |
|                                  | and (2) you work with a terminal |
|                                  | that supports extensive VT100    |
|                                  | editing commands. Selecting this |
|                                  | option will add probably 1.5-2KB |
|                                  | to the FLASH footprint.          |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_BUILTIN_APPS`      | Support external registered,     |
|                                  | \"builtin\" applications that    |
|                                  | can be executed from the NSH     |
|                                  | command line (see                |
|                                  | apps/README.txt for more         |
|                                  | information). This required      |
|                                  | `CONFIG_BUILTIN` to enable NuttX |
|                                  | support for \"builtin\"          |
|                                  | applications.                    |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_FILEIOSIZE`        | Size of a static I/O buffer used |
|                                  | for file access (ignored if      |
|                                  | there is no file system).        |
|                                  | Default is 1024.                 |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_STRERROR`          | `strerror(errno)` makes more     |
|                                  | readable output but `strerror()` |
|                                  | is very large and will not be    |
|                                  | used unless this setting is *y*. |
|                                  | This setting depends upon the    |
|                                  | `strerror()` having been enabled |
|                                  | with `CONFIG_LIBC_STRERROR`.     |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_DISABLE_SEMICOLON` | By default, you can enter        |
|                                  | multiple NSH commands on a line  |
|                                  | with each command separated by a |
|                                  | semicolon. You can disable this  |
|                                  | feature to save a little memory  |
|                                  | on FLASH challenged platforms.   |
|                                  | Default: n                       |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_CMDPARMS`          | If selected, then the output     |
|                                  | from commands, from file         |
|                                  | applications, and from NSH       |
|                                  | built-in commands can be used as |
|                                  | arguments to other commands. The |
|                                  | entity to be executed is         |
|                                  | identified by enclosing the      |
|                                  | command line in back quotes. For |
|                                  | example:                         |
|                                  |                                  |
|                                  |     set FOO `myprogram $BAR`     |
|                                  |                                  |
|                                  | will execute the program named   |
|                                  | `myprogram` passing it the value |
|                                  | of the environment variable      |
|                                  | `BAR`. The value of the          |
|                                  | environment variable `FOO` is    |
|                                  | then set output of `myprogram`   |
|                                  | on `stdout`. Because this        |
|                                  | feature commits significant      |
|                                  | resources, it is disabled by     |
|                                  | default. The                     |
|                                  | `CONFIG_NSH_CMDPARMS` interim    |
|                                  | output will be retained in a     |
|                                  | temporary file. Full path to a   |
|                                  | directory where temporary files  |
|                                  | can be created is taken from     |
|                                  | `CONFIG_LIBC_TMPDIR` and it      |
|                                  | defaults to `/tmp` if            |
|                                  | `CONFIG_LIBC_TMPDIR` is not set. |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_MAXARGUMENTS`      | The maximum number of NSH        |
|                                  | command arguments. Default: 6    |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_ARGCAT`            | Support concatenation of strings |
|                                  | with environment variables or    |
|                                  | command output. For example:     |
|                                  |                                  |
|                                  |     set FOO XYZ                  |
|                                  |     set BAR 123                  |
|                                  |     set FOOBAR ABC_${FOO}_${BAR} |
|                                  |                                  |
|                                  | would set the environment        |
|                                  | variable `FOO` to `XYZ`, `BAR`   |
|                                  | to `123` and `FOOBAR` to         |
|                                  | `ABC_XYZ_123`. If                |
|                                  | `CONFIG_NSH_ARGCAT` is not       |
|                                  | selected, then a slightly small  |
|                                  | FLASH footprint results but then |
|                                  | also only simple environment     |
|                                  | variables like `$FOO` can be     |
|                                  | used on the command line.        |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_VARS`              | By default, there are no         |
|                                  | internal NSH variables. NSH will |
|                                  | use OS environment variables for |
|                                  | all variable storage. If this    |
|                                  | option, NSH will also support    |
|                                  | local NSH variables. These       |
|                                  | variables are, for the most      |
|                                  | part, transparent and work just  |
|                                  | like the OS environment          |
|                                  | variables. The difference is     |
|                                  | that when you create new tasks,  |
|                                  | all of environment variables are |
|                                  | inherited by the created tasks.  |
|                                  | NSH local variables are not. If  |
|                                  | this option is enabled (and      |
|                                  | `CONFIG_DISABLE_ENVIRON` is      |
|                                  | not), then a new command called  |
|                                  | \'export\' is enabled. The       |
|                                  | export command works very must   |
|                                  | like the set command except that |
|                                  | is operates on environment       |
|                                  | variables. When                  |
|                                  | CONFIG\_NSH\_VARS is enabled,    |
|                                  | there are changes in the         |
|                                  | behavior of certain commands.    |
|                                  | See following                    |
|                                  | `cmdtable <ns                    |
|                                  | h_vars_table>`{.interpreted-text |
|                                  | role="ref"}.                     |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_QUOTE`             | Enables back-slash quoting of    |
|                                  | certain characters within the    |
|                                  | command. This option is useful   |
|                                  | for the case where an NSH script |
|                                  | is used to dynamically generate  |
|                                  | a new NSH script. In that case,  |
|                                  | commands must be treated as      |
|                                  | simple text strings without      |
|                                  | interpretation of any special    |
|                                  | characters. Special characters   |
|                                  | such as `$`, `` \` ``, `"`, and  |
|                                  | others must be retained intact   |
|                                  | as part of the test string. This |
|                                  | option is currently only         |
|                                  | available is `CONFIG_NSH_ARGCAT` |
|                                  | is also selected.                |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_NESTDEPTH`         | The maximum number of nested     |
|                                  | `if-then[-else]-fi`              |
|                                  | \<\#conditional\>\`\_\_          |
|                                  | sequences that are permissible.  |
|                                  | Default: 3                       |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_DISABLESCRIPT`     | This can be set to *y* to        |
|                                  | suppress support for scripting.  |
|                                  | This setting disables the        |
|                                  | `` `sh `` \<\#cmdsh\>[\_\_,      |
|                                  | ]{.title-ref}`test`              |
|                                  | \<\#cmdtest\>[\_\_, and          |
|                                  | ]{.title-ref}`[`                 |
|                                  | \<\#cmtest\>[\_\_ commands and   |
|                                  | the                              |
|                                  | ]{.title-ref}`if-then[-else]-fi` |
|                                  | \<\#conditional\>\`\_\_          |
|                                  | construct. This would only be    |
|                                  | set on systems where a minimal   |
|                                  | footprint is a necessity and     |
|                                  | scripting is not.                |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_DISABLE_ITEF`      | If scripting is enabled, then    |
|                                  | then this option can be selected |
|                                  | to suppress support for          |
|                                  | `if-then-else-fi` sequences in   |
|                                  | scripts. This would only be set  |
|                                  | on systems where some minimal    |
|                                  | scripting is required but        |
|                                  | `if-then-else-fi` is not.        |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_DISABLE_LOOPS`     | If scripting is enabled, then    |
|                                  | then this option can be selected |
|                                  | suppress support                 |
|                                  | `for while-do-done` and          |
|                                  | `until-do-done` sequences in     |
|                                  | scripts. This would only be set  |
|                                  | on systems where some minimal    |
|                                  | scripting is required but        |
|                                  | looping is not.                  |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_DISABLEBG`         | This can be set to *y* to        |
|                                  | suppress support for background  |
|                                  | commands. This setting disables  |
|                                  | the `` `nice ``                  |
|                                  | \<\#cmdoverview\>[\_\_ command   |
|                                  | prefix and the ]{.title-ref}`&`  |
|                                  | \<\#cmdoverview\>\`\_\_ command  |
|                                  | suffix. This would only be set   |
|                                  | on systems where a minimal       |
|                                  | footprint is a necessity and     |
|                                  | background command execution is  |
|                                  | not.                             |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_MMCSDMINOR`        | If the architecture supports an  |
|                                  | MMC/SD slot and if the NSH       |
|                                  | architecture specific logic is   |
|                                  | present, this option will        |
|                                  | provide the MMC/SD minor number, |
|                                  | i.e., the MMC/SD block driver    |
|                                  | will be registered as            |
|                                  | `/dev/mmcsd`*N* where *N* is the |
|                                  | minor number. Default is zero.   |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_CONSOLE`           | If `CONFIG_NSH_CONSOLE` is set   |
|                                  | to *y*, then a serial console    |
|                                  | front-end is selected.           |
|                                  |                                  |
|                                  | Normally, the serial console     |
|                                  | device is a UART and RS-232      |
|                                  | interface. However, if           |
|                                  | `CONFIG_USBDEV` is defined, then |
|                                  | a USB serial device may,         |
|                                  | instead, be used if the one of   |
|                                  | the following are defined:       |
|                                  |                                  |
|                                  | -   `CONFIG_PL2303` and          |
|                                  |     `CONFIG_PL2303_CONSOLE`.     |
|                                  |     Sets up the Prolifics PL2303 |
|                                  |     emulation as a console       |
|                                  |     device at `/dev/console`.    |
|                                  |                                  |
|                                  | -   `CONFIG_CDCACM` and          |
|                                  |     `CONFIG_CDCACM_CONSOLE`.     |
|                                  |     Sets up the CDC/ACM serial   |
|                                  |     device as a console device   |
|                                  |     at `/dev/console`.           |
|                                  |                                  |
|                                  | -   `CONFIG_NSH_USBCONSOLE`. If  |
|                                  |     defined, then an arbitrary   |
|                                  |     USB device may be used to as |
|                                  |     the NSH console. In this     |
|                                  |     case, `CONFIG_NSH_USBCONDEV` |
|                                  |     must be defined to indicate  |
|                                  |     which USB device to use as   |
|                                  |     the console. The advantage   |
|                                  |     of using a device other that |
|                                  |     `/dev/console` is that       |
|                                  |     normal debug output can then |
|                                  |     use `/dev/console` while NSH |
|                                  |     uses `CONFIG_NSH_USBCONDEV`. |
|                                  |                                  |
|                                  |     `CONFIG_NSH_USBCONDEV`. If   |
|                                  |     `CONFIG_NSH_USBCONSOLE` is   |
|                                  |     set to \'y\', then           |
|                                  |     `CONFIG_NSH_USBCONDEV` must  |
|                                  |     also be set to select the    |
|                                  |     USB device used to support   |
|                                  |     the NSH console. This should |
|                                  |     be set to the quoted name of |
|                                  |     a readable/write-able USB    |
|                                  |     driver such as:              |
|                                  |     `CONFI                       |
|                                  | G_NSH_USBCONDEV="/dev/ttyACM0"`. |
|                                  |                                  |
|                                  | If there are more than one USB   |
|                                  | slots, then a USB device minor   |
|                                  | number may also need to be       |
|                                  | provided:                        |
|                                  |                                  |
|                                  | -   `CONFIG_NSH_UBSDEV_MINOR`:   |
|                                  |     The minor device number of   |
|                                  |     the USB device. Default: 0   |
|                                  |                                  |
|                                  | If USB tracing is enabled        |
|                                  | (`CONFIG_USBDEV_TRACE`), then    |
|                                  | NSH will initialize USB tracing  |
|                                  | as requested by the following.   |
|                                  | Default: Only USB errors are     |
|                                  | traced.                          |
|                                  |                                  |
|                                  | -                                |
|                                  |   `CONFIG_NSH_USBDEV_TRACEINIT`: |
|                                  |     Show initialization events   |
|                                  | -                                |
|                                  |  `CONFIG_NSH_USBDEV_TRACECLASS`: |
|                                  |     Show class driver events     |
|                                  | -   `CO                          |
|                                  | NFIG_NSH_USBDEV_TRACETRANSFERS`: |
|                                  |     Show data transfer events    |
|                                  | -   `CON                         |
|                                  | FIG_NSH_USBDEV_TRACECONTROLLER`: |
|                                  |     Show controller events       |
|                                  | -   `CON                         |
|                                  | FIG_NSH_USBDEV_TRACEINTERRUPTS`: |
|                                  |     Show interrupt-related       |
|                                  |     events.                      |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_ALTCONDEV` and     | If `CONFIG_NSH_CONSOLE` is set   |
|                                  | `CONFIG_NSH_CONDEV` to *y*, then |
|                                  | `CONFIG_NSH_ALTCONDEV` may also  |
|                                  | be selected to enable use of an  |
|                                  | alternate character device to    |
|                                  | support the NSH console. If      |
|                                  | `CONFIG_NSH_ALTCONDEV` is        |
|                                  | selected, then                   |
|                                  | `CONFIG_NSH_CONDEV` holds the    |
|                                  | quoted name of a                 |
|                                  | readable/write-able character    |
|                                  | driver such as:                  |
|                                  | `                                |
|                                  | CONFIG_NSH_CONDEV="/dev/ttyS1"`. |
|                                  | This is useful, for example, to  |
|                                  | separate the NSH command line    |
|                                  | from the system console when the |
|                                  | system console is used to        |
|                                  | provide debug output. Default:   |
|                                  | `stdin` and `stdout` (probably   |
|                                  | \"`/dev/console`\")              |
|                                  |                                  |
|                                  | -   **NOTE 1:** When any other   |
|                                  |     device other than            |
|                                  |     `/dev/console` is used for a |
|                                  |     user interface, (1)          |
|                                  |     linefeeds (`\n`) will not be |
|                                  |     expanded to carriage return  |
|                                  |     / linefeeds (`\r\n`). You    |
|                                  |     will need to configure your  |
|                                  |     terminal program to account  |
|                                  |     for this. And (2) input is   |
|                                  |     not automatically echoed so  |
|                                  |     you will have to turn local  |
|                                  |     echo on.                     |
|                                  | -   **NOTE 2:** This option      |
|                                  |     forces the console of all    |
|                                  |     sessions to use NSH\_CONDEV. |
|                                  |     Hence, this option only      |
|                                  |     makes sense for a system     |
|                                  |     that supports only a single  |
|                                  |     session. This option is, in  |
|                                  |     particular, incompatible     |
|                                  |     with Telnet sessions because |
|                                  |     each Telnet session must use |
|                                  |     a different console device.  |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_TELNET`            | If `CONFIG_NSH_TELNET` is set to |
|                                  | *y*, then a TELNET server        |
|                                  | front-end is selected. When this |
|                                  | option is provided, you may log  |
|                                  | into NuttX remotely using telnet |
|                                  | in order to access NSH.          |
+----------------------------------+----------------------------------+
| > `CONFIG_NSH_ARCHINIT`          | Set `CONFIG_NSH_ARCHINIT` if     |
|                                  | your board provides architecture |
|                                  | specific initialization via the  |
|                                  | board-specific function          |
|                                  | `board_app_initialize()`. This   |
|                                  | function will be called early in |
|                                  | NSH initialization to allow      |
|                                  | board logic to do such things as |
|                                  | configure MMC/SD slots.          |
+----------------------------------+----------------------------------+

::: {#nsh_vars_table}
  CMD                w/o `CONFIG_NSH_VARS`                     w/`CONFIG_NSH_VARS`
  ------------------ ----------------------------------------- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
  `set <a> <b>`      Set environment variable \<a\> to \<b\>   Set NSH variable \<a\> to \<b\> (Unless the NSH variable has been *promoted* via `export`, in which case the env ironment variable of the same name is set to \<b\>).
  `set`              Causes an error.                          Lists all NSH variables.
  `unset <a>`        Unsets environment variable \<a\>         Unsets both environment variable *and* NSH variable with and name \<a\>
  `export <a> <b>`   Causes an error,                          Unsets NSH variable \<a\>. Sets environment variable \<a\> to \<b\>.
  `export <a>`       Causes an error.                          Sets environment variable \<a\> to the value of NSH variable \<a\> (or \"\" if the NSH variable has not been set). Unsets NSH local variable \<a\>.
  `env`              Lists all environment variables           Lists all environment variables (*only*)
:::

If Telnet is selected for the NSH console, then we must configure the
resources used by the Telnet daemon and by the Telnet clients.

  Configuration                               Description
  ------------------------------------------- ------------------------------------------------------------------------------------
  `CONFIG_SYSTEM_TELNETD_PORT`                The telnet daemon will listen on this TCP port number for connections. Default: 23
  `CONFIG_SYSTEM_TELNETD_PRIORITY`            Priority of the Telnet daemon. Default: `SCHED_PRIORITY_DEFAULT`
  `CONFIG_SYSTEM_TELNETD_STACKSIZE`           Stack size allocated for the Telnet daemon. Default: 2048
  `CONFIG_SYSTEM_TELNETD_SESSION_PRIORITY`    Priority of the Telnet client. Default: `SCHED_PRIORITY_DEFAULT`
  `CONFIG_SYSTEM_TELNETD_SESSION_STACKSIZE`   Stack size allocated for the Telnet client. Default: 2048

One or both of `CONFIG_NSH_CONSOLE` and `CONFIG_NSH_TELNET` must be
defined. If `CONFIG_NSH_TELNET` is selected, then there some other
configuration settings that apply:

  Configuration                Description
  ---------------------------- -------------------------------------------------------------------------------------------------------------------------------------
  `CONFIG_NET=y`               Of course, networking must be enabled.
  `CONFIG_NET_TCP=y`           TCP/IP support is required for telnet (as well as various other TCP-related configuration settings).
  `CONFIG_NSH_DHCPC`           Obtain the IP address via DHCP.
  `CONFIG_NSH_IPADDR`          If `CONFIG_NSH_DHCPC` is NOT set, then the static IP address must be provided.
  `CONFIG_NSH_DRIPADDR`        Default router IP address
  `CONFIG_NSH_NETMASK`         Network mask
  `CONFIG_NSH_NOMAC`           Set if your Ethernet hardware has no built-in MAC address. If set, a bogus MAC will be assigned.
  `CONFIG_NSH_MAX_ROUNDTRIP`   This is the maximum round trip for a response to a ICMP ECHO request. It is in units of deciseconds. The default is 20 (2 seconds).

If you use DHCPC, then some special configuration network options are
required. These include:

  Configuration                              Description
  ------------------------------------------ --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  `CONFIG_NET=y`                             Of course, networking must be enabled.
  `CONFIG_NET_UDP=y`                         UDP support is required for DHCP (as well as various other UDP-related configuration settings).
  `CONFIG_NET_BROADCAST=y`                   UDP broadcast support is needed.
  `CONFIG_NET_ETH_PKTSIZE=650` (or larger)   Per RFC2131 (p. 9), the DHCP client must be prepared to receive DHCP messages of up to 576 bytes (excluding Ethernet, IP, or UDP headers and FCS). NOTE: Note that the actual MTU setting will depend upon the specific link protocol. Here Ethernet is indicated.

If `CONFIG_ETC_ROMFS` is selected, then the following additional
configuration setting apply:

  Configuration                Description
  ---------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  `CONFIG_NSH_SYSINITSCRIPT`   This is the relative path to the system init script within the mountpoint. The default is `"init.d/rc.sysinit"`. This is a relative path and must not start with \'`/`\' but must be enclosed in quotes.
  `CONFIG_NSH_INITSCRIPT`      This is the relative path to the startup script within the mountpoint. The default is `"init.d/rcS"`. This is a relative path and must not start with \'`/`\' but must be enclosed in quotes.

Common Problems
---------------

Problem:

    The function 'readline' is undefined.

Usual Cause:

-   The following is missing from your [defconfig]{.title-ref} file:

        CONFIG_SYSTEM_READLINE=y

[^1]: Because of hardware padding, the actual required packet size may
    be larger

[^2]: Verbose help output can be suppressed by defining
    `CONFIG_NSH_HELP_TERSE`. In that case, the help command is still
    available but will be slightly smaller.

[^3]: Because of hardware padding, the actual required packet size may
    be larger

[^4]: Special TFTP server start-up options will probably be required to
    permit creation of files for the correct operation of the `put`
    command.

[^5]: Because of hardware padding, the actual required packet size may
    be larger

[^6]: Verbose help output can be suppressed by defining
    `CONFIG_NSH_HELP_TERSE`. In that case, the help command is still
    available but will be slightly smaller.

[^7]: Because of hardware padding, the actual required packet size may
    be larger

[^8]: Special TFTP server start-up options will probably be required to
    permit creation of files for the correct operation of the `put`
    command.

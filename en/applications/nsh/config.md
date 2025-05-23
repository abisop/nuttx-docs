# Configuration Settings

The availability of the above commands depends upon features that may or
may not be enabled in the NuttX configuration file. The following
`cmdtable <cmddependencies>` indicates the dependency of each command on
NuttX configuration settings. General configuration settings are
discussed in the NuttX Porting Guide. Configuration settings specific to
NSH as discussed at the `cmdbottom <nshconfiguration>` of this document.

Note that in addition to general NuttX configuration settings, each NSH
command can be individually disabled via the settings in the rightmost
column. All of these settings make the configuration of NSH potentially
complex but also allow it to squeeze into very small memory footprints.

## Command Dependencies on Configuration Settings

<table>
<thead>
<tr class="header">
<th>Command</th>
<th>Depends on Configuration</th>
<th>Can Be Disabled with</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>[</code></td>
<td>! <code>CONFIG_NSH_DISABLESCRIPT</code></td>
<td><code>CONFIG_NSH_DISABLE_TEST</code></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdaddroute</code></td>
<td><code>CONFIG_NET</code> &amp;&amp; <code>CONFIG_NET_ROUTE</code></td>
<td><code>CONFIG_NSH_DISABLE_ADDROUTE</code></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdarp</code></td>
<td><code>CONFIG_NET</code> &amp;&amp; <code>CONFIG_NET_ARP</code></td>
<td><code>CONFIG_NSH_DISABLE_ARP</code></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdbase64dec</code></p></td>
<td><p><code>CONFIG_NETUTILS_CODECS</code> &amp;&amp; <code>CONFIG_CODECS_BASE64</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_BASE64DEC</code></p></td>
</tr>
<tr class="odd">
<td><p><code class="interpreted-text" role="ref">cmdbase64enc</code></p></td>
<td><p><code>CONFIG_NETUTILS_CODECS</code> &amp;&amp; <code>CONFIG_CODECS_BASE64</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_BASE64ENC</code></p></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdbasename</code></td>
<td>.</td>
<td><code>CONFIG_NSH_DISABLE_BASENAME</code></td>
</tr>
<tr class="odd">
<td><p><code class="interpreted-text" role="ref">cmdbreak</code></p></td>
<td><p>! <code>CONFIG_NSH_DISABLESCRIPT</code> &amp;&amp; ! <code>CONFIG_NSH_DISABLE_LOOPS</code>  </p></td>
<td><p>.</p></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdcat</code></td>
<td><code>CONFIG_NSH_DISABLE_CAT</code></td>
<td>.</td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdcd</code></td>
<td>! <code>CONFIG_DISABLE_ENVIRON</code></td>
<td><code>CONFIG_NSH_DISABLE_CD</code></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdcmp</code></td>
<td><code>CONFIG_NSH_DISABLE_CMP</code></td>
<td>.</td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdcp</code></td>
<td><code>CONFIG_NSH_DISABLE_CP</code></td>
<td>.</td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmddate</code></td>
<td><code>CONFIG_NSH_DISABLE_DATE</code></td>
<td>.</td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmddelroute</code></td>
<td><code>CONFIG_NET</code> &amp;&amp; <code>CONFIG_NET_ROUTE</code></td>
<td><code>CONFIG_NSH_DISABLE_DELROUTE</code></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmddf</code></td>
<td>! <code>CONFIG_DISABLE_MOUNTPOINT</code></td>
<td><code>CONFIG_NSH_DISABLE_DF</code></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmddirname</code></td>
<td><code>CONFIG_NSH_DISABLE_DIRNAME</code></td>
<td>.</td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmddmesg</code></td>
<td><code>CONFIG_RAMLOG_SYSLOG</code></td>
<td><code>CONFIG_NSH_DISABLE_DMESG</code></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdecho</code></td>
<td><code>CONFIG_NSH_DISABLE_ECHO</code></td>
<td>.</td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdenv</code></p></td>
<td><p><code>CONFIG_FS_PROCFS</code> &amp;&amp; ! <code>CONFIG_DISABLE_ENVIRON</code> &amp;&amp; ! <code>CONFIG_PROCFS_EXCLUDE_ENVIRON</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_ENV</code></p></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdexec</code></td>
<td><code>CONFIG_NSH_DISABLE_EXEC</code></td>
<td>.</td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdexit</code> <code class="interpreted-text" role="ref">cmdexport</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_EXIT</code> <code>CONFIG_NSH_VARS</code> &amp;&amp; ! <code>CONFIG_DISABLE_ENVIRON</code></p></td>
<td><p>.</p>
<p><code>CONFIG_NSH_DISABLE_EXPORT</code></p></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdfree</code></td>
<td><code>CONFIG_NSH_DISABLE_FREE</code></td>
<td>.</td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdget</code></p></td>
<td><p><code>CONFIG_NET</code> &amp;&amp; <code>CONFIG_NET_UDP</code> &amp;&amp; <em>MTU</em> &gt;= 58[1]</p></td>
<td><blockquote>
<p><code>CONFIG_NSH_DISABLE_GET</code></p>
</blockquote></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdhelp</code>[2]</td>
<td><code>CONFIG_NSH_DISABLE_HELP</code></td>
<td>.</td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdhexdump</code></td>
<td><code>CONFIG_NSH_DISABLE_HEXDUMP</code></td>
<td>.</td>
</tr>
<tr class="odd">
<td><p><code class="interpreted-text" role="ref">cmdifconfig</code></p></td>
<td><p><code>CONFIG_NET</code> &amp;&amp; <code>CONFIG_FS_PROCFS</code> &amp;&amp; ! <code>CONFIG_FS_PROCFS_EXCLUDE_NET</code></p></td>
<td><blockquote>
<p><code>CONFIG_NSH_DISABLE_IFCONFIG</code></p>
</blockquote></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdifdown</code></p>
<p><code class="interpreted-text" role="ref">cmdifup</code></p></td>
<td><p><code>CONFIG_NET</code> &amp;&amp; <code>CONFIG_FS_PROCFS</code> &amp;&amp; ! <code>CONFIG_FS_PROCFS_EXCLUDE_NET</code> <code>CONFIG_NET</code> &amp;&amp; <code>CONFIG_FS_PROCFS</code> &amp;&amp; ! <code>CONFIG_FS_PROCFS_EXCLUDE_NET</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_IFUPDOWN</code></p>
<p><code>CONFIG_NSH_DISABLE_IFUPDOWN</code></p></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdinsmod</code></td>
<td><code>CONFIG_MODULE</code></td>
<td><code>CONFIG_NSH_DISABLE_MODCMDS</code></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdirqinfo</code></p></td>
<td><p>! <code>CONFIG_DISABLE_MOUNTPOINT</code> &amp;&amp; <code>CONFIG_FS_PROCFS</code> &amp;&amp; <code>CONFIG_SCHED_IRQMONITOR</code></p></td>
<td><p>.</p></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdkill</code></td>
<td><code>CONFIG_NSH_DISABLE_KILL</code></td>
<td>.</td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdlosetup</code></p></td>
<td><p>! <code>CONFIG_DISABLE_MOUNTPOINT</code> &amp;&amp; <code>CONFIG_DEV_LOOP</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_LOSETUP</code></p></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdln</code></td>
<td><code>CONFIG_PSEUDOFS_SOFTLINKS</code></td>
<td><code>CONFIG_NSH_DISABLE_LN</code></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdls</code></td>
<td><code>CONFIG_NSH_DISABLE_LS</code></td>
<td>.</td>
</tr>
<tr class="odd">
<td><p><code class="interpreted-text" role="ref">cmdlsmod</code></p></td>
<td><p><code>CONFIG_MODULE</code> &amp;&amp; <code>CONFIG_FS_PROCFS</code> &amp;&amp; ! <code>CONFIG_FS_PROCFS_EXCLUDE_MODULE</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_MODCMDS</code></p></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdmd5</code></p></td>
<td><p><code>CONFIG_NETUTILS_CODECS</code> &amp;&amp; <code>CONFIG_CODECS_HASH_MD5</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_MD5</code></p></td>
</tr>
<tr class="odd">
<td><p><code class="interpreted-text" role="ref">cmdmx</code></p></td>
<td><p>.</p></td>
<td><p><code>CONFIG_NSH_DISABLE_MB</code>, <code>CONFIG_NSH_DISABLE_MH</code>, <code>CONFIG_NSH_DISABLE_MW</code></p></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdmkdir</code></p></td>
<td><p>(! <code>CONFIG_DISABLE_MOUNTPOINT</code> || ! <code>CONFIG_DISABLE_PSEUDOFS_OPERATIONS</code>)</p></td>
<td><p><code>CONFIG_NSH_DISABLE_MKDIR</code></p></td>
</tr>
<tr class="odd">
<td><p><code class="interpreted-text" role="ref">cmdmkfatfs</code></p></td>
<td><p>! <code>CONFIG_DISABLE_MOUNTPOINT</code> &amp;&amp; <code>CONFIG_FSUTILS_MKFATFS</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_MKFATFS</code></p></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdmkfifo</code></p></td>
<td><p><code>CONFIG_PIPES</code> &amp;&amp; <code>CONFIG_DEV_FIFO_SIZE</code> &gt; 0</p></td>
<td><p><code>CONFIG_NSH_DISABLE_MKFIFO</code></p></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdmkrd</code></td>
<td>! <code>CONFIG_DISABLE_MOUNTPOINT</code></td>
<td><code>CONFIG_NSH_DISABLE_MKRD</code></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdmount</code></td>
<td>! <code>CONFIG_DISABLE_MOUNTPOINT</code></td>
<td><code>CONFIG_NSH_DISABLE_MOUNT</code></td>
</tr>
<tr class="odd">
<td><p><code class="interpreted-text" role="ref">cmdmv</code></p></td>
<td><p>! <code>CONFIG_DISABLE_MOUNTPOINT</code> || ! <code>CONFIG_DISABLE_PSEUDOFS_OPERATIONS</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_MV</code></p></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdnfsmount</code></p></td>
<td><p>! <code>CONFIG_DISABLE_MOUNTPOINT</code> &amp;&amp; <code>CONFIG_NET</code> &amp;&amp; <code>CONFIG_NFS</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_NFSMOUNT</code></p></td>
</tr>
<tr class="odd">
<td><p><code class="interpreted-text" role="ref">cmdnslookup</code></p></td>
<td><p><code>CONFIG_LIBC_NETDB</code> &amp;&amp; <code>CONFIG_NETDB_DNSCLIENT</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_NSLOOKUP</code></p></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdpasswd</code></p></td>
<td><p>! <code>CONFIG_DISABLE_MOUNTPOINT</code> &amp;&amp; <code>CONFIG_NSH_LOGIN_PASSWD</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_PASSWD</code></p></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdpmconfig</code></td>
<td><code>CONFIG_PM</code></td>
<td><code>CONFIG_NSH_DISABLE_PMCONFIG</code></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdpoweroff</code></td>
<td><code>CONFIG_BOARDCTL_POWEROFF</code></td>
<td><code>CONFIG_NSH_DISABLE_POWEROFF</code></td>
</tr>
<tr class="odd">
<td><p><code class="interpreted-text" role="ref">cmdps</code></p></td>
<td><p><code>CONFIG_FS_PROCFS</code> &amp;&amp; ! <code>CONFIG_FS_PROCFS_EXCLUDE_PROC</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_PS</code></p></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdput</code></p></td>
<td><p><code>CONFIG_NET</code> &amp;&amp; <code>CONFIG_NET_UDP</code> &amp;&amp; <code>MTU &gt;= 558</code>[3],[4]</p></td>
<td><p><code>CONFIG_NSH_DISABLE_PUT</code></p></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdpwd</code></td>
<td>! <code>CONFIG_DISABLE_ENVIRON</code></td>
<td><code>CONFIG_NSH_DISABLE_PWD</code></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdreadlink</code></td>
<td><code>CONFIG_PSEUDOFS_SOFTLINKS</code></td>
<td><code>CONFIG_NSH_DISABLE_READLINK</code></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdreboot</code></td>
<td><code>CONFIG_BOARD_RESET</code></td>
<td><code>CONFIG_NSH_DISABLE_REBOOT</code></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdrm</code></p>
<p><code class="interpreted-text" role="ref">cmdrmdir</code></p></td>
<td><p>! <code>CONFIG_DISABLE_MOUNTPOINT</code> || ! <code>CONFIG_DISABLE_PSEUDOFS_OPERATIONS</code> ! <code>CONFIG_DISABLE_MOUNTPOINT</code> |! <code>CONFIG_DISABLE_PSEUDOFS_OPERATIONS</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_RM</code></p>
<p><code>CONFIG_NSH_DISABLE_RMDIR</code></p></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdrmmod</code></td>
<td><code>CONFIG_MODULE</code></td>
<td><code>CONFIG_NSH_DISABLE_MODCMDS</code></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdroute</code></p></td>
<td><p><code>CONFIG_FS_PROCFS</code> &amp;&amp; <code>CONFIG_FS_PROCFS_EXCLUDE_NET</code> &amp;&amp; ! <code>CONFIG_FS_PROCFS_EXCLUDE_ROUTE</code> &amp;&amp; <code>CONFIG_NET_ROUTE</code> &amp;&amp; ! <code>CONFIG_NSH_DISABLE_ROUTE</code> &amp;&amp; (<code>CONFIG_NET_IPv4</code> |<code>CONFIG_NET_IPv6</code>)</p></td>
<td><p><code>CONFIG_NSH_DISABLE_ROUTE</code></p></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdrptun</code></td>
<td><code>CONFIG_RPTUN</code></td>
<td><code>CONFIG_NSH_DISABLE_RPTUN</code></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdset</code></p></td>
<td><p><code>CONFIG_NSH_VARS</code> || ! <code>CONFIG_DISABLE_ENVIRON</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_SET</code></p></td>
</tr>
<tr class="odd">
<td><p><code class="interpreted-text" role="ref">cmdshutdown</code></p></td>
<td><p><code>CONFIG_BOARDCTL_POWEROFF</code> || <code>CONFIG_BOARD_RESET</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_SHUTDOWN</code></p></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdsleep</code></td>
<td>.</td>
<td><code>CONFIG_NSH_DISABLE_SLEEP</code></td>
</tr>
<tr class="odd">
<td><p><code>cmdsource</code></p>
<p><code class="interpreted-text" role="ref">cmdtelnetd</code></p></td>
<td><p><code>CONFIG_FILE_STREAM</code> &amp;&amp; ! <code>CONFIG_NSH_DISABLESCRIPT</code> <code>CONFIG_NSH_TELNET</code> &amp;&amp; <code>CONFIG_SYSTEM_TELNETD</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_SOURCE</code></p></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdtest</code></td>
<td>! <code>CONFIG_NSH_DISABLESCRIPT</code></td>
<td><code>CONFIG_NSH_DISABLE_TEST</code></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdtime</code></td>
<td>.</td>
<td><code>CONFIG_NSH_DISABLE_TIME</code></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdtruncate</code></td>
<td>! <code>CONFIG_DISABLE_MOUNTPOINT</code></td>
<td><code>CONFIG_NSH_DISABLE_TRUNCATE</code></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdumount</code></td>
<td>! <code>CONFIG_DISABLE_MOUNTPOINT</code></td>
<td><code>CONFIG_NSH_DISABLE_UMOUNT</code></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmduname</code></td>
<td>.</td>
<td><code>CONFIG_NSH_DISABLE_UNAME</code></td>
</tr>
<tr class="odd">
<td><p><code class="interpreted-text" role="ref">cmdunset</code></p></td>
<td><p><code>CONFIG_NSH_VARS</code> || ! <code>CONFIG_DISABLE_ENVIRON</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_UNSET</code></p></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmdurldecode</code></p></td>
<td><p>! <code>CONFIG_NETUTILS_CODECS</code> &amp;&amp; <code>CONFIG_CODECS_URLCODE</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_URLDECODE</code></p></td>
</tr>
<tr class="odd">
<td><p><code class="interpreted-text" role="ref">cmdurlencode</code></p></td>
<td><p>! <code>CONFIG_NETUTILS_CODECS</code> &amp;&amp; <code>CONFIG_CODECS_URLCODE</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_URLENCODE</code></p></td>
</tr>
<tr class="even">
<td><p><code class="interpreted-text" role="ref">cmduseradd</code></p></td>
<td><p>! <code>CONFIG_DISABLE_MOUNTPOINT</code> &amp;&amp; <code>CONFIG_NSH_LOGIN_PASSWD</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_USERADD</code></p></td>
</tr>
<tr class="odd">
<td><p><code class="interpreted-text" role="ref">cmduserdel</code></p></td>
<td><p>! <code>CONFIG_DISABLE_MOUNTPOINT</code> &amp;&amp; <code>CONFIG_NSH_LOGIN_PASSWD</code></p></td>
<td><p><code>CONFIG_NSH_DISABLE_USERDEL</code></p></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdusleep</code></td>
<td>.</td>
<td><code>CONFIG_NSH_DISABLE_USLEEP</code></td>
</tr>
<tr class="odd">
<td><code class="interpreted-text" role="ref">cmdwget</code></td>
<td><code>CONFIG_NET</code> &amp;&amp; <code>CONFIG_NET_TCP</code></td>
<td><code>CONFIG_NSH_DISABLE_WGET</code></td>
</tr>
<tr class="even">
<td><code class="interpreted-text" role="ref">cmdxd</code></td>
<td>.</td>
<td><code>CONFIG_NSH_DISABLE_XD</code></td>
</tr>
</tbody>
</table>

## Built-In Command Dependencies on Configuration Settings

All built-in applications require that support for NSH built-in
applications has been enabled. This support is enabled with
`CONFIG_BUILTIN=y` and `CONFIG_NSH_BUILTIN_APPS=y`.

| Command | Depends on Configuration                                                                   |
| ------- | ------------------------------------------------------------------------------------------ |
| `ping`  | `CONFIG_NET` && `CONFIG_NET_ICMP` && `CONFIG_NET_ICMP_SOCKET` && `CONFIG_SYSTEM_PING`      |
| `ping6` | `CONFIG_NET` && `CONFIG_NET_ICMPv6` && `CONFIG_NET_ICMPv6_SOCKET` && `CONFIG_SYSTEM_PING6` |

## NSH-Specific Configuration Settings

The behavior of NSH can be modified with the following settings in the
`boards/<arch>/<chip>/<board>/defconfig` file:

<table>
<thead>
<tr class="header">
<th>Configuration</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><blockquote>
<p><code>CONFIG_NSH_READLINE</code></p>
</blockquote></td>
<td><p>Selects the minimal implementation of <code>readline()</code>. This minimal implementation provides on backspace for command line editing. It expects some minimal VT100 command support from the terminal.</p></td>
</tr>
<tr class="even">
<td><blockquote>
<p><code>CONFIG_NSH_CLE</code></p>
</blockquote></td>
<td><p>Selects the more extensive, EMACS-like command line editor. Select this option only if (1) you don't mind a modest increase in the FLASH footprint, and (2) you work with a terminal that supports extensive VT100 editing commands. Selecting this option will add probably 1.5-2KB to the FLASH footprint.</p></td>
</tr>
<tr class="odd">
<td><blockquote>
<p><code>CONFIG_NSH_BUILTIN_APPS</code></p>
</blockquote></td>
<td><p>Support external registered, "builtin" applications that can be executed from the NSH command line (see apps/README.txt for more information). This required <code>CONFIG_BUILTIN</code> to enable NuttX support for "builtin" applications.</p></td>
</tr>
<tr class="even">
<td><blockquote>
<p><code>CONFIG_NSH_FILEIOSIZE</code></p>
</blockquote></td>
<td><p>Size of a static I/O buffer used for file access (ignored if there is no file system). Default is 1024.</p></td>
</tr>
<tr class="odd">
<td><blockquote>
<p><code>CONFIG_NSH_STRERROR</code></p>
</blockquote></td>
<td><p><code>strerror(errno)</code> makes more readable output but <code>strerror()</code> is very large and will not be used unless this setting is <em>y</em>. This setting depends upon the <code>strerror()</code> having been enabled with <code>CONFIG_LIBC_STRERROR</code>.</p></td>
</tr>
<tr class="even">
<td><blockquote>
<p><code>CONFIG_NSH_DISABLE_SEMICOLON</code></p>
</blockquote></td>
<td><p>By default, you can enter multiple NSH commands on a line with each command separated by a semicolon. You can disable this feature to save a little memory on FLASH challenged platforms. Default: n</p></td>
</tr>
<tr class="odd">
<td><blockquote>
<p><code>CONFIG_NSH_CMDPARMS</code></p>
</blockquote></td>
<td><p>If selected, then the output from commands, from file applications, and from NSH built-in commands can be used as arguments to other commands. The entity to be executed is identified by enclosing the command line in back quotes. For example:</p>
<pre><code>set FOO `myprogram BAR`</code></pre>
<p>will execute the program named <code>myprogram</code> passing it the value of the environment variable <code>BAR</code>. The value of the environment variable <code>FOO</code> is then set output of <code>myprogram</code> on <code>stdout</code>. Because this feature commits significant resources, it is disabled by default. The <code>CONFIG_NSH_CMDPARMS</code> interim output will be retained in a temporary file. Full path to a directory where temporary files can be created is taken from <code>CONFIG_LIBC_TMPDIR</code> and it defaults to <code>/tmp</code> if <code>CONFIG_LIBC_TMPDIR</code> is not set.</p></td>
</tr>
<tr class="even">
<td><blockquote>
<p><code>CONFIG_NSH_MAXARGUMENTS</code></p>
</blockquote></td>
<td><p>The maximum number of NSH command arguments. Default: 6</p></td>
</tr>
<tr class="odd">
<td><blockquote>
<p><code>CONFIG_NSH_ARGCAT</code></p>
</blockquote></td>
<td><p>Support concatenation of strings with environment variables or command output. For example:</p>
<pre><code>set FOO XYZ
set BAR 123
set FOOBAR ABC_{FOO}_{BAR}</code></pre>
<p>would set the environment variable <code>FOO</code> to <code>XYZ</code>, <code>BAR</code> to <code>123</code> and <code>FOOBAR</code> to <code>ABC_XYZ_123</code>. If <code>CONFIG_NSH_ARGCAT</code> is not selected, then a slightly small FLASH footprint results but then also only simple environment variables like <code>FOO</code> can be used on the command line.</p></td>
</tr>
<tr class="even">
<td><blockquote>
<p><code>CONFIG_NSH_VARS</code></p>
</blockquote></td>
<td><p>By default, there are no internal NSH variables. NSH will use OS environment variables for all variable storage. If this option, NSH will also support local NSH variables. These variables are, for the most part, transparent and work just like the OS environment variables. The difference is that when you create new tasks, all of environment variables are inherited by the created tasks. NSH local variables are not. If this option is enabled (and <code>CONFIG_DISABLE_ENVIRON</code> is not), then a new command called 'export' is enabled. The export command works very must like the set command except that is operates on environment variables. When CONFIG_NSH_VARS is enabled, there are changes in the behavior of certain commands. See following <code class="interpreted-text" role="ref">cmdtable &lt;nsh_vars_table&gt;</code>.</p></td>
</tr>
<tr class="odd">
<td><blockquote>
<p><code>CONFIG_NSH_QUOTE</code></p>
</blockquote></td>
<td><p>Enables back-slash quoting of certain characters within the command. This option is useful for the case where an NSH script is used to dynamically generate a new NSH script. In that case, commands must be treated as simple text strings without interpretation of any special characters. Special characters such as <code></code>, <code>\`</code>, <code>"</code>, and others must be retained intact as part of the test string. This option is currently only available is <code>CONFIG_NSH_ARGCAT</code> is also selected.</p></td>
</tr>
<tr class="even">
<td><blockquote>
<p><code>CONFIG_NSH_NESTDEPTH</code></p>
</blockquote></td>
<td><p>The maximum number of nested <code>if-then[-else]-fi</code> &lt;#conditional&gt;`__ sequences that are permissible. Default: 3</p></td>
</tr>
<tr class="odd">
<td><blockquote>
<p><code>CONFIG_NSH_DISABLESCRIPT</code></p>
</blockquote></td>
<td><p>This can be set to <em>y</em> to suppress support for scripting. This setting disables the <code>`sh</code> &lt;#cmdsh&gt;<span class="title-ref">__, </span><code>test</code> &lt;#cmdtest&gt;<span class="title-ref">__, and </span><code>[</code> &lt;#cmtest&gt;<span class="title-ref">__ commands and the </span><code>if-then[-else]-fi</code> &lt;#conditional&gt;`__ construct. This would only be set on systems where a minimal footprint is a necessity and scripting is not.</p></td>
</tr>
<tr class="even">
<td><blockquote>
<p><code>CONFIG_NSH_DISABLE_ITEF</code></p>
</blockquote></td>
<td><p>If scripting is enabled, then then this option can be selected to suppress support for <code>if-then-else-fi</code> sequences in scripts. This would only be set on systems where some minimal scripting is required but <code>if-then-else-fi</code> is not.</p></td>
</tr>
<tr class="odd">
<td><blockquote>
<p><code>CONFIG_NSH_DISABLE_LOOPS</code></p>
</blockquote></td>
<td><p>If scripting is enabled, then then this option can be selected suppress support <code>for while-do-done</code> and <code>until-do-done</code> sequences in scripts. This would only be set on systems where some minimal scripting is required but looping is not.</p></td>
</tr>
<tr class="even">
<td><blockquote>
<p><code>CONFIG_NSH_DISABLEBG</code></p>
</blockquote></td>
<td><p>This can be set to <em>y</em> to suppress support for background commands. This setting disables the <code>`nice</code> &lt;#cmdoverview&gt;<span class="title-ref">__ command prefix and the </span><code>&amp;</code> &lt;#cmdoverview&gt;`__ command suffix. This would only be set on systems where a minimal footprint is a necessity and background command execution is not.</p></td>
</tr>
<tr class="odd">
<td><blockquote>
<p><code>CONFIG_NSH_MMCSDMINOR</code></p>
</blockquote></td>
<td><p>If the architecture supports an MMC/SD slot and if the NSH architecture specific logic is present, this option will provide the MMC/SD minor number, i.e., the MMC/SD block driver will be registered as <code>/dev/mmcsd</code><em>N</em> where <em>N</em> is the minor number. Default is zero.</p></td>
</tr>
<tr class="even">
<td><blockquote>
<p><code>CONFIG_NSH_CONSOLE</code></p>
</blockquote></td>
<td><p>If <code>CONFIG_NSH_CONSOLE</code> is set to <em>y</em>, then a serial console front-end is selected.</p>
<p>Normally, the serial console device is a UART and RS-232 interface. However, if <code>CONFIG_USBDEV</code> is defined, then a USB serial device may, instead, be used if the one of the following are defined:</p>
<ul>
<li><p><code>CONFIG_PL2303</code> and <code>CONFIG_PL2303_CONSOLE</code>. Sets up the Prolifics PL2303 emulation as a console device at <code>/dev/console</code>.</p></li>
<li><p><code>CONFIG_CDCACM</code> and <code>CONFIG_CDCACM_CONSOLE</code>. Sets up the CDC/ACM serial device as a console device at <code>/dev/console</code>.</p></li>
<li><p><code>CONFIG_NSH_USBCONSOLE</code>. If defined, then an arbitrary USB device may be used to as the NSH console. In this case, <code>CONFIG_NSH_USBCONDEV</code> must be defined to indicate which USB device to use as the console. The advantage of using a device other that <code>/dev/console</code> is that normal debug output can then use <code>/dev/console</code> while NSH uses <code>CONFIG_NSH_USBCONDEV</code>.</p>
<p><code>CONFIG_NSH_USBCONDEV</code>. If <code>CONFIG_NSH_USBCONSOLE</code> is set to 'y', then <code>CONFIG_NSH_USBCONDEV</code> must also be set to select the USB device used to support the NSH console. This should be set to the quoted name of a readable/write-able USB driver such as: <code>CONFIG_NSH_USBCONDEV="/dev/ttyACM0"</code>.</p></li>
</ul>
<p>If there are more than one USB slots, then a USB device minor number may also need to be provided:</p>
<ul>
<li><code>CONFIG_NSH_UBSDEV_MINOR</code>: The minor device number of the USB device. Default: 0</li>
</ul>
<p>If USB tracing is enabled (<code>CONFIG_USBDEV_TRACE</code>), then NSH will initialize USB tracing as requested by the following. Default: Only USB errors are traced.</p>
<ul>
<li><code>CONFIG_NSH_USBDEV_TRACEINIT</code>: Show initialization events</li>
<li><code>CONFIG_NSH_USBDEV_TRACECLASS</code>: Show class driver events</li>
<li><code>CONFIG_NSH_USBDEV_TRACETRANSFERS</code>: Show data transfer events</li>
<li><code>CONFIG_NSH_USBDEV_TRACECONTROLLER</code>: Show controller events</li>
<li><code>CONFIG_NSH_USBDEV_TRACEINTERRUPTS</code>: Show interrupt-related events.</li>
</ul></td>
</tr>
<tr class="odd">
<td><blockquote>
<p><code>CONFIG_NSH_ALTCONDEV</code> and</p>
</blockquote></td>
<td><p>If <code>CONFIG_NSH_CONSOLE</code> is set <code>CONFIG_NSH_CONDEV</code> to <em>y</em>, then <code>CONFIG_NSH_ALTCONDEV</code> may also be selected to enable use of an alternate character device to support the NSH console. If <code>CONFIG_NSH_ALTCONDEV</code> is selected, then <code>CONFIG_NSH_CONDEV</code> holds the quoted name of a readable/write-able character driver such as: <code>CONFIG_NSH_CONDEV="/dev/ttyS1"</code>. This is useful, for example, to separate the NSH command line from the system console when the system console is used to provide debug output. Default: <code>stdin</code> and <code>stdout</code> (probably "<code>/dev/console</code>")</p>
<ul>
<li><strong>NOTE 1:</strong> When any other device other than <code>/dev/console</code> is used for a user interface, (1) linefeeds (<code>\n</code>) will not be expanded to carriage return / linefeeds (<code>\r\n</code>). You will need to configure your terminal program to account for this. And (2) input is not automatically echoed so you will have to turn local echo on.</li>
<li><strong>NOTE 2:</strong> This option forces the console of all sessions to use NSH_CONDEV. Hence, this option only makes sense for a system that supports only a single session. This option is, in particular, incompatible with Telnet sessions because each Telnet session must use a different console device.</li>
</ul></td>
</tr>
<tr class="even">
<td><blockquote>
<p><code>CONFIG_NSH_TELNET</code></p>
</blockquote></td>
<td><p>If <code>CONFIG_NSH_TELNET</code> is set to <em>y</em>, then a TELNET server front-end is selected. When this option is provided, you may log into NuttX remotely using telnet in order to access NSH.</p></td>
</tr>
<tr class="odd">
<td><blockquote>
<p><code>CONFIG_NSH_ARCHINIT</code></p>
</blockquote></td>
<td><p>Set <code>CONFIG_NSH_ARCHINIT</code> if your board provides architecture specific initialization via the board-specific function <code>board_app_initialize()</code>. This function will be called early in NSH initialization to allow board logic to do such things as configure MMC/SD slots.</p></td>
</tr>
</tbody>
</table>

| CMD              | w/o `CONFIG_NSH_VARS`                   | w/`CONFIG_NSH_VARS`                                                                                                                                                   |
| ---------------- | --------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `set <a> <b>`    | Set environment variable \<a\> to \<b\> | Set NSH variable \<a\> to \<b\> (Unless the NSH variable has been *promoted* via `export`, in which case the env ironment variable of the same name is set to \<b\>). |
| `set`            | Causes an error.                        | Lists all NSH variables.                                                                                                                                              |
| `unset <a>`      | Unsets environment variable \<a\>       | Unsets both environment variable *and* NSH variable with and name \<a\>                                                                                               |
| `export <a> <b>` | Causes an error,                        | Unsets NSH variable \<a\>. Sets environment variable \<a\> to \<b\>.                                                                                                  |
| `export <a>`     | Causes an error.                        | Sets environment variable \<a\> to the value of NSH variable \<a\> (or "" if the NSH variable has not been set). Unsets NSH local variable \<a\>.                     |
| `env`            | Lists all environment variables         | Lists all environment variables (*only*)                                                                                                                              |

If Telnet is selected for the NSH console, then we must configure the
resources used by the Telnet daemon and by the Telnet clients.

| Configuration                             | Description                                                                        |
| ----------------------------------------- | ---------------------------------------------------------------------------------- |
| `CONFIG_SYSTEM_TELNETD_PORT`              | The telnet daemon will listen on this TCP port number for connections. Default: 23 |
| `CONFIG_SYSTEM_TELNETD_PRIORITY`          | Priority of the Telnet daemon. Default: `SCHED_PRIORITY_DEFAULT`                   |
| `CONFIG_SYSTEM_TELNETD_STACKSIZE`         | Stack size allocated for the Telnet daemon. Default: 2048                          |
| `CONFIG_SYSTEM_TELNETD_SESSION_PRIORITY`  | Priority of the Telnet client. Default: `SCHED_PRIORITY_DEFAULT`                   |
| `CONFIG_SYSTEM_TELNETD_SESSION_STACKSIZE` | Stack size allocated for the Telnet client. Default: 2048                          |

One or both of `CONFIG_NSH_CONSOLE` and `CONFIG_NSH_TELNET` must be
defined. If `CONFIG_NSH_TELNET` is selected, then there some other
configuration settings that apply:

| Configuration              | Description                                                                                                                         |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `CONFIG_NET=y`             | Of course, networking must be enabled.                                                                                              |
| `CONFIG_NET_TCP=y`         | TCP/IP support is required for telnet (as well as various other TCP-related configuration settings).                                |
| `CONFIG_NSH_DHCPC`         | Obtain the IP address via DHCP.                                                                                                     |
| `CONFIG_NSH_IPADDR`        | If `CONFIG_NSH_DHCPC` is NOT set, then the static IP address must be provided.                                                      |
| `CONFIG_NSH_DRIPADDR`      | Default router IP address                                                                                                           |
| `CONFIG_NSH_NETMASK`       | Network mask                                                                                                                        |
| `CONFIG_NSH_NOMAC`         | Set if your Ethernet hardware has no built-in MAC address. If set, a bogus MAC will be assigned.                                    |
| `CONFIG_NSH_MAX_ROUNDTRIP` | This is the maximum round trip for a response to a ICMP ECHO request. It is in units of deciseconds. The default is 20 (2 seconds). |

If you use DHCPC, then some special configuration network options are
required. These include:

| Configuration                            | Description                                                                                                                                                                                                                                                        |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `CONFIG_NET=y`                           | Of course, networking must be enabled.                                                                                                                                                                                                                             |
| `CONFIG_NET_UDP=y`                       | UDP support is required for DHCP (as well as various other UDP-related configuration settings).                                                                                                                                                                    |
| `CONFIG_NET_BROADCAST=y`                 | UDP broadcast support is needed.                                                                                                                                                                                                                                   |
| `CONFIG_NET_ETH_PKTSIZE=650` (or larger) | Per RFC2131 (p. 9), the DHCP client must be prepared to receive DHCP messages of up to 576 bytes (excluding Ethernet, IP, or UDP headers and FCS). NOTE: Note that the actual MTU setting will depend upon the specific link protocol. Here Ethernet is indicated. |

If `CONFIG_ETC_ROMFS` is selected, then the following additional
configuration setting apply:

| Configuration              | Description                                                                                                                                                                                            |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `CONFIG_NSH_SYSINITSCRIPT` | This is the relative path to the system init script within the mountpoint. The default is `"init.d/rc.sysinit"`. This is a relative path and must not start with '`/`' but must be enclosed in quotes. |
| `CONFIG_NSH_INITSCRIPT`    | This is the relative path to the startup script within the mountpoint. The default is `"init.d/rcS"`. This is a relative path and must not start with '`/`' but must be enclosed in quotes.            |

## Common Problems

Problem:

    The function 'readline' is undefined.

Usual Cause:

  - The following is missing from your
    <span class="title-ref">defconfig</span> file:
    
        CONFIG_SYSTEM_READLINE=y

<!-- end list -->

1.  Because of hardware padding, the actual required packet size may be
    larger

2.  Verbose help output can be suppressed by defining
    `CONFIG_NSH_HELP_TERSE`. In that case, the help command is still
    available but will be slightly smaller.

3.  Because of hardware padding, the actual required packet size may be
    larger

4.  Special TFTP server start-up options will probably be required to
    permit creation of files for the correct operation of the `put`
    command.

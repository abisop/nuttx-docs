# Configuration Settings

The availability of the above commands depends upon features that may or
may not be enabled in the NuttX configuration file. The following
`cmdtable <nxdiagcmddependencies>` indicates the dependency of each
command on NuttX configuration settings. General configuration settings
are discussed in the NuttX Porting Guide. Configuration settings
specific to Nxdiag as discussed at the `cmdbottom <nxdiagconfiguration>`
of this document.

Note that the `--vendor-specific` or `-v` option will generate
vendor-specific information and checks. The output of this option will
depend on the selected vendors in the NuttX configuration file. For
example, if the `CONFIG_SYSTEM_NXDIAG_ESPRESSIF` configuration setting
is enabled, then this option will provide custom information and checks
for Espressif devices. Multiple vendors may be selected at the same
time.

## Option Dependencies on Configuration Settings

| Option                                               | Depends on Configuration             |
| ---------------------------------------------------- | ------------------------------------ |
| `--help, -h` `--nuttx, -n`                           |                                      |
| `--flags, -f`                                        | `CONFIG_SYSTEM_NXDIAG_COMP_FLAGS`    |
| `--config, -c` `--host-os, -o`                       | `CONFIG_SYSTEM_NXDIAG_CONF`          |
| `--host-path, -p`                                    | `CONFIG_SYSTEM_NXDIAG_HOST_PATH`     |
| `--host-packages, -k`                                | `CONFIG_SYSTEM_NXDIAG_HOST_PACKAGES` |
| `--host-modules, -m` `--vendor-specific, -v` `--all` | `CONFIG_SYSTEM_NXDIAG_HOST_MODULES`  |

## Nxdiag-Specific Configuration Settings

The behavior of Nxdiag can be modified with the following settings in
the `boards/<arch>/<chip>/<board>/defconfig` file:

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
<p><code>CONFIG_SYSTEM_NXDIAG_COMP_FLAGS</code></p>
</blockquote></td>
<td><p>Enable the nxdiag application to list the NuttX compilation flags. This is useful for debugging the host and target systems. Enables the <code>-f</code> and <code>--nuttx-flags</code> options.</p></td>
</tr>
<tr class="even">
<td><blockquote>
<p><code>CONFIG_SYSTEM_NXDIAG_CONF</code></p>
</blockquote></td>
<td><p>Enable the nxdiag application to list the configuration options used to compile NuttX. This is useful for debugging the host and target systems. Enables the <code>-c</code> and <code>--nuttx-config</code> options.</p></td>
</tr>
<tr class="odd">
<td><blockquote>
<p><code>CONFIG_SYSTEM_NXDIAG_HOST_PATH</code></p>
</blockquote></td>
<td><p>Enable the nxdiag application to list the host system PATH variable. This is useful for debugging the host system. Enables the <code>-p</code> and <code>--host-path</code> options.</p></td>
</tr>
<tr class="even">
<td><blockquote>
<p><code>CONFIG_SYSTEM_NXDIAG_HOST_PACKAGES</code></p>
</blockquote></td>
<td><p>Enable the nxdiag application to list the installed packages on the host system. This is useful for debugging the host system. Enables the <code>-k</code> and <code>--host-packages</code> options.</p></td>
</tr>
<tr class="odd">
<td><blockquote>
<p><code>CONFIG_SYSTEM_NXDIAG_HOST_MODULES</code></p>
</blockquote></td>
<td><p>Enable the nxdiag application to list the installed Python modules on the host system. This is useful for debugging the host system. Enables the <code>-m</code> and <code>--host-modules</code> options.</p></td>
</tr>
<tr class="even">
<td><blockquote>
<p><code>CONFIG_SYSTEM_NXDIAG_ESPRESSIF</code></p>
</blockquote></td>
<td><p>Enable Espressif-specific information and checks.</p></td>
</tr>
</tbody>
</table>

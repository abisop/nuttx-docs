Logging
=======

NuttX provides the SYSLOG for application and OS logging, which can be
configured in various ways to select how these messages are displayed
(see details \[[here \</component\](\`here
\</component.md)s/drivers/special/syslog\>]{.title-ref}).

Applications can emit logging messages using the standard
:c`syslog`{.interpreted-text role="func"} interface.

Note

The standard :c`openlog`{.interpreted-text role="func"} and
:c`closelog`{.interpreted-text role="func"} are not currently supported.

Priority Levels
---------------

The following levels are defined:

  Priority (macro)   Description
  ------------------ ------------------------------------
  `LOG_EMERG`        System is unusable
  `LOG_ALERT`        Action must be taken immediately
  `LOG_CRIT`         Critical conditions
  `LOG_ERR`          Error conditions
  `LOG_WARNING`      Warning conditions
  `LOG_NOTICE`       Normal, but significant, condition
  `LOG_INFO`         Informational message
  `LOG_DEBUG`        Debug-level message

Priority mask
-------------

The following macros can be used with :c`setlogmask`{.interpreted-text
role="func"}:

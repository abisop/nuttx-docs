SPIFFS
======

Creating an image
-----------------

This implementation is supposed to be compatible with images generated
by the following tools:

-   [mkspiffs](https://github.com/igrr/mkspiffs)
-   ESP-IDF
    [spiffsgen.py](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/storage/spiffs.html#spiffsgen-py)

Note: please ensure the following NuttX configs to be compatible with
these tools:

-   `CONFIG_SPIFFS_COMPAT_OLD_NUTTX` is disabled
-   `CONFIG_SPIFFS_LEADING_SLASH=y`

### mkspiffs

-   Specify `CONFIG_SPIFFS_NAME_MAX + 1` for `SPIFFS_OBJ_NAME_LEN`.
-   Specify 0 for `SPIFFS_OBJ_META_LEN`.

### ESP-IDF `spiffsgen.py`

-   Specify `CONFIG_SPIFFS_NAME_MAX + 1` for the `--obj-name-len`
    option.
-   Specify 0 for the `--meta-len` option.

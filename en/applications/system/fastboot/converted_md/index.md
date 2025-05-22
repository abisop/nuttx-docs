`fastboot` fastbootd
====================

Prepare
-------

-   Check fastboot tool(Host): `fastboot --version`
-   Download fastboot tool and install(Host):
    [platform-tools](https://developer.android.com/tools/releases/platform-tools)
-   Enable the fastbootd application(Device): `CONFIG_USBFASTBOOT=y` and
    `CONFIG_SYSTEM_FASTBOOTD=y`
-   Start fastbootd(Device): `fastbootd &`

Commands
--------

-   `fastboot reboot [FLAG]`: Reboot the device, more details for
    `[FLAG]`:
    [g\_resetflag](https://github.com/apache/nuttx-apps/blob/master/nshlib/nsh_syscmds.c#L114)
    and
    [boardioc\_softreset\_subreason\_e](https://github.com/apache/nuttx/blob/master/include/sys/boardctl.h#L458)

-   `fastboot flash <PARTITION> <FILENAME>`: Flash partition
    `<PARTITION>` using the given `<FILENAME>`

-   `fastboot erase <PARTITION>`: Erase given partition

-   

    Get Variables

    :   -   `fastboot getvar product`: Get product name
        -   `fastboot getvar kernel`: Get kernel name
        -   `fastboot getvar version`: Get OS version string
        -   `fastboot getvar slot-count`: Get slot count
        -   `fastboot getvar max-download-size`: Get max download size

-   

    OEM

    :   -   `fastboot oem filedump <PARTITION> [OFFSET] [LENGTH]`: Get
            `<LENGTH>` (full by default) bytes of `<PARTITION>` from
            `<OFFSET>` (zero by default)
        -   `fastboot oem memdump <ADDRESS> <LENGTH>`: Dump `<LENGTH>`
            bytes memory from address `<ADDRESS>`
        -   `fastboot oem shell <COMMAND>`: Execute custom commands.
            e.g. \"oem shell ps\", \"oem shell ls /dev/\"

-   `fastboot get_staged <OUT_FILE>`: Writes data staged by the last
    command to file `<OUT_FILE>`. e.g. \"oem filedump\" and \"oem
    memdump\"

Examples
--------

-   Exit fastboot mode: `fastboot reboot`
-   Flash app.bin to partition /dev/app: `fastboot flash app ./app.bin`
-   Erase partition /dev/userdata: `fastboot erase userdata`
-   Dump partition /dev/app: `fastboot filedump /dev/app` and then
    `fastboot get_staged ./dump_app.bin`
-   Dump memory from 0x44000000 to 0x440b6c00:
    `fastboot oem memdump 0x44000000 0xb6c00` and then
    `fastboot get_staged ./mem_44000000_440b6c00.bin`
-   Create RAM disk \"/dev/ram10\" of size 320KB:
    `fastboot oem shell "mkrd -m 10 -s 512 640"`

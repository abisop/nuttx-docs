# Configuring a Wireless Network

`wapi` is used to connect to an Access Point by setting its parameters.

<div class="note">

<div class="title">

Note

</div>

Usually, one single wireless interface refers to an operational mode:
Station Mode (STA) or SoftAP. For instance, `wlan0` may refer to the STA
mode and `wlan1`. Setting the passphrase and the ESSID of a STA-enabled
interface would make it connect to a wireless network while setting the
same parameters for a SoftAP-enabled interface would provide a network
wireless with these connection parameters. Please check `ESP32 Wi-Fi
Station Mode (wlan0) <esp32_wi-fi_sta>` and `ESP32 Wi-Fi SoftAP Mode
(wlan1) <esp32_wi-fi_softap>` sections.

</div>

## Setting the Passphrase

`wapi psk` command is used for setting the AP authentication security.
Its arguments are:

    wapi psk <ifname> <passphrase> <index/flag> [wpa]

  - `<ifname>` is the name of the interface set as Station Mode (STA);
  - `<passphrase>` is the password. Its length depends on the
    authentication algorithm. Please note that `wapi psk` command is
    also used to set auth as open, but this parameter comes next, so it
    may be necessary to set a "dummy" passphrase just to set auth to
    none;
  - `<index/flag>` can be set numerically or textually, as follows:

>   - \[0\] WPA\_ALG\_NONE - to connect to an open AP;
>   - \[1\] WPA\_ALG\_WEP - to connect to a WEP-secured AP (not
>     recommended);
>   - \[2\] WPA\_ALG\_TKIP - to use TKIP algorithm (not recommended);
>   - \[3\] WPA\_ALG\_CCMP - to use CCMP algorithm (recommended);

  - `[wpa]` sets the WPA version (if applicable):

>   - \[0\] WPA\_VER\_NONE;
>   - \[1\] WPA\_VER\_1;
>   - \[2\] WPA\_VER\_2 (default, if not selected otherwise);
>   - \[3\] WPA\_VER\_3;

## Setting the Network Name (ESSID)

The name of the Wireless Network can be set using `wapi essid` command:

    wapi essid <ifname> <essid> <index/flag>

  - `<ifname>` is the name of the interface set as Station Mode (STA);
  - `<essid>` is the name of the Wireless Network;
  - `<index/flag>` selects whether to connect to the AP or not:

>   - \[0\] WAPI\_ESSID\_OFF - Don't connect to the AP;
>   - \[1\] WAPI\_ESSID\_ON - Connect to the AP indicated by the
>     provided ESSID;
>   - \[2\] WAPI\_ESSID\_DELAY\_ON - Delay AP connection;

## Examples

### Connecting to an Open Network

    wapi psk wlan0 mypasswd WPA_ALG_NONE
    wapi essid wlan0 myssid WAPI_ESSID_ON

or, equivalently

    wapi psk wlan0 mypasswd 0
    wapi essid wlan0 myssid 1

### Connecting to a WPA2-PSK Network

    wapi psk wlan0 mypasswd WPA_ALG_CCMP 
    wapi essid wlan0 myssid WAPI_ESSID_ON

or, equivalently:

> 
> 
>     wapi psk wlan0 mypasswd 3
>     wapi essid wlan0 myssid 1

### Connecting to a WPA3-SAE Network

    wapi psk wlan0 mypasswd WPA_ALG_CCMP WPA_VER_3
    wapi essid wlan0 myssid WAPI_ESSID_ON

or, equivalently:

    wapi psk wlan0 mypasswd 3 3
    wapi essid wlan0 myssid 1

### Connecting to a Hidden (WPA2-PSK) Network

    wapi psk wlan0 mypasswd WPA_ALG_CCMP 
    wapi essid wlan0 myssid WAPI_ESSID_DELAY_ON
    wapi ap wlan0 aa:bb:cc:dd:dd:ff

or, equivalently:

    wapi psk wlan0 mypasswd 3
    wapi essid wlan0 myssid 2
    wapi ap wlan0 aa:bb:cc:dd:dd:ff

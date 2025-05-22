Sensor Drivers
==============

Currently in NuttX we have 3 different approaches to sensor interfaces:

::: {.toctree maxdepth="1"}
sensors/sensors\_uorb.rst sensors/sensors\_legacy.rst
sensors/sensors\_cluster.rst
:::

The preferred way for implementing new sensors is the
`New sensor framework <new_sensor_framework>`{.interpreted-text
role="ref"}, which provides the most general interface.

::: {.toctree hidden=""}
sensors/adt7320.rst sensors/adxl345.rst sensors/adxl362.rst
sensors/adxl372.rst sensors/aht10.rst sensors/ak09912.rst
sensors/lsm330.rst sensors/mcp9600.rst sensors/mpl115a.rst
sensors/nau7802.rst sensors/sht4x.rst sensors/lsm6dso32.rst
sensors/lis2mdl.rst
:::

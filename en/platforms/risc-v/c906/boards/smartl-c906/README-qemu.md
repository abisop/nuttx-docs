1.  Download and install toolchain

https://occ.t-head.cn/community/download

2.  Download and install qemu

https://occ.t-head.cn/community/download

3.  Modify defconfig

CONFIG\_C906\_WITH\_QEMU=y

4.  Configure and build NuttX

\$ make distclean \$ ./tools/configure.sh smartl-c906:nsh \$ make -j

5.  Run the nuttx with qemu

Modify the soc config file "smarth\_906\_cfg.xml", enlarge the RAM size.
-
`<mem name="smart_inst_mem" addr="0x0" size ="0x00020000" attr ="MEM_RAM">`{=html}`</mem>`{=html}
+
`<mem name="smart_inst_mem" addr="0x0" size ="0x00400000" attr ="MEM_RAM">`{=html}`</mem>`{=html}
... - smart\_inst\_mem, Start: 0x0, Length: 0x20000 + smart\_inst\_mem,
Start: 0x0, Length: 0x400000

Then launch QEMU: \$ ./cskysim -soc
\$PATH\_TO\_SOCCFG/smarth\_906\_cfg.xml -nographic -kernel
\$PATH\_TO\_NUTTX\_BUILD\_DIR/nuttx

6.  TODO

Support protect mode via PMP Support RISC-V User mode

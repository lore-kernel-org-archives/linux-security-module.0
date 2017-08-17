From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 17 Aug 2017 08:00:28 +0800
Subject: [integrity:next-log-iversion 10/11]
	drivers/net/irda/donauboe.c:192:1: note: in expansion of macro
	'MODULE_DEVICE_TABLE'
Message-ID: <201708170821.DyDtNQsU%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-log-iversion
head:   5bb9c12032ed1b6bfc148cd8bf24e64996793553
commit: 6acf0ef6e57fb7f665049dbde14d9932826ba46c [10/11] security: define a new LSM sb_post_remount hook
config: i386-randconfig-x001-201733 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 6acf0ef6e57fb7f665049dbde14d9932826ba46c
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

                              ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/pci.h:20:0,
                    from drivers/net/irda/donauboe.c:156:
   include/linux/mod_devicetable.h:16:20: warning: excess elements in scalar initializer
    #define PCI_ANY_ID (~0)
                       ^
   drivers/net/irda/donauboe.c:188:49: note: in expansion of macro 'PCI_ANY_ID'
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIR701, PCI_ANY_ID, PCI_ANY_ID, },
                                                    ^~~~~~~~~~
   include/linux/mod_devicetable.h:16:20: note: (near initialization for 'toshoboe_pci_tbl')
    #define PCI_ANY_ID (~0)
                       ^
   drivers/net/irda/donauboe.c:188:49: note: in expansion of macro 'PCI_ANY_ID'
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIR701, PCI_ANY_ID, PCI_ANY_ID, },
                                                    ^~~~~~~~~~
   include/linux/mod_devicetable.h:16:20: warning: excess elements in scalar initializer
    #define PCI_ANY_ID (~0)
                       ^
   drivers/net/irda/donauboe.c:188:61: note: in expansion of macro 'PCI_ANY_ID'
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIR701, PCI_ANY_ID, PCI_ANY_ID, },
                                                                ^~~~~~~~~~
   include/linux/mod_devicetable.h:16:20: note: (near initialization for 'toshoboe_pci_tbl')
    #define PCI_ANY_ID (~0)
                       ^
   drivers/net/irda/donauboe.c:188:61: note: in expansion of macro 'PCI_ANY_ID'
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIR701, PCI_ANY_ID, PCI_ANY_ID, },
                                                                ^~~~~~~~~~
   drivers/net/irda/donauboe.c:189:2: warning: braces around scalar initializer
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
     ^
   drivers/net/irda/donauboe.c:189:2: note: (near initialization for 'toshoboe_pci_tbl')
   In file included from include/linux/pci.h:36:0,
                    from drivers/net/irda/donauboe.c:156:
   include/linux/pci_ids.h:1568:32: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
    #define PCI_VENDOR_ID_TOSHIBA  0x1179
                                   ^
   drivers/net/irda/donauboe.c:189:4: note: in expansion of macro 'PCI_VENDOR_ID_TOSHIBA'
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
       ^~~~~~~~~~~~~~~~~~~~~
   include/linux/pci_ids.h:1568:32: note: (near initialization for 'toshoboe_pci_tbl')
    #define PCI_VENDOR_ID_TOSHIBA  0x1179
                                   ^
   drivers/net/irda/donauboe.c:189:4: note: in expansion of macro 'PCI_VENDOR_ID_TOSHIBA'
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
       ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/irda/donauboe.c:168:0:
   drivers/net/irda/donauboe.h:266:31: warning: excess elements in scalar initializer
    #define PCI_DEVICE_ID_FIRD01  0x0d01
                                  ^
   drivers/net/irda/donauboe.c:189:27: note: in expansion of macro 'PCI_DEVICE_ID_FIRD01'
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
                              ^~~~~~~~~~~~~~~~~~~~
   drivers/net/irda/donauboe.h:266:31: note: (near initialization for 'toshoboe_pci_tbl')
    #define PCI_DEVICE_ID_FIRD01  0x0d01
                                  ^
   drivers/net/irda/donauboe.c:189:27: note: in expansion of macro 'PCI_DEVICE_ID_FIRD01'
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
                              ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/pci.h:20:0,
                    from drivers/net/irda/donauboe.c:156:
   include/linux/mod_devicetable.h:16:20: warning: excess elements in scalar initializer
    #define PCI_ANY_ID (~0)
                       ^
   drivers/net/irda/donauboe.c:189:49: note: in expansion of macro 'PCI_ANY_ID'
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
                                                    ^~~~~~~~~~
   include/linux/mod_devicetable.h:16:20: note: (near initialization for 'toshoboe_pci_tbl')
    #define PCI_ANY_ID (~0)
                       ^
   drivers/net/irda/donauboe.c:189:49: note: in expansion of macro 'PCI_ANY_ID'
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
                                                    ^~~~~~~~~~
   include/linux/mod_devicetable.h:16:20: warning: excess elements in scalar initializer
    #define PCI_ANY_ID (~0)
                       ^
   drivers/net/irda/donauboe.c:189:61: note: in expansion of macro 'PCI_ANY_ID'
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
                                                                ^~~~~~~~~~
   include/linux/mod_devicetable.h:16:20: note: (near initialization for 'toshoboe_pci_tbl')
    #define PCI_ANY_ID (~0)
                       ^
   drivers/net/irda/donauboe.c:189:61: note: in expansion of macro 'PCI_ANY_ID'
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
                                                                ^~~~~~~~~~
   drivers/net/irda/donauboe.c:189:2: warning: excess elements in scalar initializer
     { PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
     ^
   drivers/net/irda/donauboe.c:189:2: note: (near initialization for 'toshoboe_pci_tbl')
   drivers/net/irda/donauboe.c:190:2: warning: braces around scalar initializer
     { }   /* Terminating entry */
     ^
   drivers/net/irda/donauboe.c:190:2: note: (near initialization for 'toshoboe_pci_tbl')
   drivers/net/irda/donauboe.c:190:2: error: empty scalar initializer
   drivers/net/irda/donauboe.c:190:2: note: (near initialization for 'toshoboe_pci_tbl')
   drivers/net/irda/donauboe.c:190:2: warning: excess elements in scalar initializer
   drivers/net/irda/donauboe.c:190:2: note: (near initialization for 'toshoboe_pci_tbl')
   In file included from drivers/net/irda/donauboe.c:145:0:
   include/linux/module.h:212:27: error: storage class specified for parameter '__mod_pci__toshoboe_pci_tbl_device_table'
    extern const typeof(name) __mod_##type##__##name##_device_table  \
                              ^
>> drivers/net/irda/donauboe.c:192:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
    MODULE_DEVICE_TABLE(pci, toshoboe_pci_tbl);
    ^~~~~~~~~~~~~~~~~~~
>> drivers/net/irda/donauboe.c:192:1: warning: 'alias' attribute ignored [-Wattributes]
   drivers/net/irda/donauboe.c:195:14: error: storage class specified for parameter 'driver_name'
    static char *driver_name = DRIVER_NAME;
                 ^~~~~~~~~~~
   drivers/net/irda/donauboe.c:195:1: error: parameter 'driver_name' is initialized
    static char *driver_name = DRIVER_NAME;
    ^~~~~~
   drivers/net/irda/donauboe.c:197:12: error: storage class specified for parameter 'max_baud'
    static int max_baud = 4000000;
               ^~~~~~~~
   drivers/net/irda/donauboe.c:197:1: error: parameter 'max_baud' is initialized
    static int max_baud = 4000000;
    ^~~~~~
   drivers/net/irda/donauboe.c:206:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:292:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:303:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:333:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:343:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:478:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:485:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:506:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:519:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:541:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:597:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:602:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:621:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:960:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'toshoboe_hard_xmit'
    toshoboe_hard_xmit (struct sk_buff *skb, struct net_device *dev)
    ^~~~~~~~~~~~~~~~~~
   drivers/net/irda/donauboe.c:1136:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:1324:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:1362:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   drivers/net/irda/donauboe.c:1396:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from drivers/net/irda/donauboe.c:145:
   include/linux/compiler-gcc.h:188:45: error: storage class specified for parameter '__UNIQUE_ID_description22'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                                ^
   include/linux/compiler.h:52:23: note: in definition of macro '___PASTE'
    #define ___PASTE(a,b) a##b
                          ^
   include/linux/compiler-gcc.h:188:29: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                ^~~~~~~
   include/linux/compiler.h:53:22: note: in expansion of macro '___PASTE'
    #define __PASTE(a,b) ___PASTE(a,b)
                         ^~~~~~~~
   include/linux/compiler-gcc.h:188:37: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                        ^~~~~~~
   include/linux/moduleparam.h:21:19: note: in expansion of macro '__UNIQUE_ID'
    static const char __UNIQUE_ID(name)[]       \
                      ^~~~~~~~~~~
   include/linux/module.h:160:32: note: in expansion of macro '__MODULE_INFO'
    #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
                                   ^~~~~~~~~~~~~
   include/linux/module.h:207:42: note: in expansion of macro 'MODULE_INFO'
    #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
                                             ^~~~~~~~~~~
   drivers/net/irda/donauboe.c:1457:1: note: in expansion of macro 'MODULE_DESCRIPTION'
    MODULE_DESCRIPTION("Toshiba OBOE IrDA Device Driver");
    ^~~~~~~~~~~~~~~~~~
   drivers/net/irda/donauboe.c:1457:1: error: parameter '__UNIQUE_ID_description22' is initialized
>> drivers/net/irda/donauboe.c:1457:1: warning: '__used__' attribute ignored [-Wattributes]
   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from drivers/net/irda/donauboe.c:145:
   include/linux/compiler-gcc.h:188:45: error: section attribute not allowed for '__UNIQUE_ID_description22'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                                ^
   include/linux/compiler.h:52:23: note: in definition of macro '___PASTE'
    #define ___PASTE(a,b) a##b
                          ^
   include/linux/compiler-gcc.h:188:29: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                ^~~~~~~
   include/linux/compiler.h:53:22: note: in expansion of macro '___PASTE'
    #define __PASTE(a,b) ___PASTE(a,b)
                         ^~~~~~~~
   include/linux/compiler-gcc.h:188:37: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                        ^~~~~~~
   include/linux/moduleparam.h:21:19: note: in expansion of macro '__UNIQUE_ID'
    static const char __UNIQUE_ID(name)[]       \
                      ^~~~~~~~~~~
   include/linux/module.h:160:32: note: in expansion of macro '__MODULE_INFO'
    #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
                                   ^~~~~~~~~~~~~
   include/linux/module.h:207:42: note: in expansion of macro 'MODULE_INFO'
    #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
                                             ^~~~~~~~~~~
   drivers/net/irda/donauboe.c:1457:1: note: in expansion of macro 'MODULE_DESCRIPTION'
    MODULE_DESCRIPTION("Toshiba OBOE IrDA Device Driver");
    ^~~~~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:188:45: error: alignment may not be specified for '__UNIQUE_ID_description22'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                                ^
   include/linux/compiler.h:52:23: note: in definition of macro '___PASTE'
    #define ___PASTE(a,b) a##b
                          ^
   include/linux/compiler-gcc.h:188:29: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                ^~~~~~~
   include/linux/compiler.h:53:22: note: in expansion of macro '___PASTE'
    #define __PASTE(a,b) ___PASTE(a,b)
                         ^~~~~~~~
   include/linux/compiler-gcc.h:188:37: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                        ^~~~~~~
   include/linux/moduleparam.h:21:19: note: in expansion of macro '__UNIQUE_ID'
    static const char __UNIQUE_ID(name)[]       \
                      ^~~~~~~~~~~
   include/linux/module.h:160:32: note: in expansion of macro '__MODULE_INFO'
    #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
                                   ^~~~~~~~~~~~~
   include/linux/module.h:207:42: note: in expansion of macro 'MODULE_INFO'
    #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
                                             ^~~~~~~~~~~
   drivers/net/irda/donauboe.c:1457:1: note: in expansion of macro 'MODULE_DESCRIPTION'
    MODULE_DESCRIPTION("Toshiba OBOE IrDA Device Driver");
    ^~~~~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:188:45: error: storage class specified for parameter '__UNIQUE_ID_author23'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                                ^
   include/linux/compiler.h:52:23: note: in definition of macro '___PASTE'
    #define ___PASTE(a,b) a##b
                          ^
   include/linux/compiler-gcc.h:188:29: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                ^~~~~~~
   include/linux/compiler.h:53:22: note: in expansion of macro '___PASTE'
    #define __PASTE(a,b) ___PASTE(a,b)
                         ^~~~~~~~
   include/linux/compiler-gcc.h:188:37: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                        ^~~~~~~
   include/linux/moduleparam.h:21:19: note: in expansion of macro '__UNIQUE_ID'
    static const char __UNIQUE_ID(name)[]       \
                      ^~~~~~~~~~~
   include/linux/module.h:160:32: note: in expansion of macro '__MODULE_INFO'
    #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
                                   ^~~~~~~~~~~~~
   include/linux/module.h:204:32: note: in expansion of macro 'MODULE_INFO'
    #define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)
                                   ^~~~~~~~~~~
   drivers/net/irda/donauboe.c:1458:1: note: in expansion of macro 'MODULE_AUTHOR'
    MODULE_AUTHOR("James McKenzie <james@fishsoup.dhs.org>");
    ^~~~~~~~~~~~~
   drivers/net/irda/donauboe.c:1458:1: error: parameter '__UNIQUE_ID_author23' is initialized
   drivers/net/irda/donauboe.c:1458:1: warning: '__used__' attribute ignored [-Wattributes]
   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from drivers/net/irda/donauboe.c:145:
   include/linux/compiler-gcc.h:188:45: error: section attribute not allowed for '__UNIQUE_ID_author23'

vim +/MODULE_DEVICE_TABLE +192 drivers/net/irda/donauboe.c

^1da177e Linus Torvalds 2005-04-16  186  
9baa3c34 Benoit Taine   2014-08-08  187  static const struct pci_device_id toshoboe_pci_tbl[] = {
^1da177e Linus Torvalds 2005-04-16  188  	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIR701, PCI_ANY_ID, PCI_ANY_ID, },
^1da177e Linus Torvalds 2005-04-16  189  	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
^1da177e Linus Torvalds 2005-04-16 @190  	{ }			/* Terminating entry */
^1da177e Linus Torvalds 2005-04-16  191  };
^1da177e Linus Torvalds 2005-04-16 @192  MODULE_DEVICE_TABLE(pci, toshoboe_pci_tbl);
^1da177e Linus Torvalds 2005-04-16  193  

:::::: The code at line 192 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

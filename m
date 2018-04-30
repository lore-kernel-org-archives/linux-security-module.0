From: lkp@intel.com (kbuild test robot)
Date: Mon, 30 Apr 2018 10:14:01 +0800
Subject: [PATCH 3/3] genalloc: selftest
In-Reply-To: <20180429024542.19475-4-igor.stoppa@huawei.com>
References: <20180429024542.19475-4-igor.stoppa@huawei.com>
Message-ID: <201804300700.8VbFINLs%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc3 next-20180426]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/linux-next-mm-hardening-Track-genalloc-allocations/20180430-064850
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> init/main.c:94:10: fatal error: linux/test_genalloc.h: No such file or directory
    #include <linux/test_genalloc.h>
             ^~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +94 init/main.c

    13	
    14	#include <linux/types.h>
    15	#include <linux/extable.h>
    16	#include <linux/module.h>
    17	#include <linux/proc_fs.h>
    18	#include <linux/binfmts.h>
    19	#include <linux/kernel.h>
    20	#include <linux/syscalls.h>
    21	#include <linux/stackprotector.h>
    22	#include <linux/string.h>
    23	#include <linux/ctype.h>
    24	#include <linux/delay.h>
    25	#include <linux/ioport.h>
    26	#include <linux/init.h>
    27	#include <linux/initrd.h>
    28	#include <linux/bootmem.h>
    29	#include <linux/acpi.h>
    30	#include <linux/console.h>
    31	#include <linux/nmi.h>
    32	#include <linux/percpu.h>
    33	#include <linux/kmod.h>
    34	#include <linux/vmalloc.h>
    35	#include <linux/kernel_stat.h>
    36	#include <linux/start_kernel.h>
    37	#include <linux/security.h>
    38	#include <linux/smp.h>
    39	#include <linux/profile.h>
    40	#include <linux/rcupdate.h>
    41	#include <linux/moduleparam.h>
    42	#include <linux/kallsyms.h>
    43	#include <linux/writeback.h>
    44	#include <linux/cpu.h>
    45	#include <linux/cpuset.h>
    46	#include <linux/cgroup.h>
    47	#include <linux/efi.h>
    48	#include <linux/tick.h>
    49	#include <linux/sched/isolation.h>
    50	#include <linux/interrupt.h>
    51	#include <linux/taskstats_kern.h>
    52	#include <linux/delayacct.h>
    53	#include <linux/unistd.h>
    54	#include <linux/utsname.h>
    55	#include <linux/rmap.h>
    56	#include <linux/mempolicy.h>
    57	#include <linux/key.h>
    58	#include <linux/buffer_head.h>
    59	#include <linux/page_ext.h>
    60	#include <linux/debug_locks.h>
    61	#include <linux/debugobjects.h>
    62	#include <linux/lockdep.h>
    63	#include <linux/kmemleak.h>
    64	#include <linux/pid_namespace.h>
    65	#include <linux/device.h>
    66	#include <linux/kthread.h>
    67	#include <linux/sched.h>
    68	#include <linux/sched/init.h>
    69	#include <linux/signal.h>
    70	#include <linux/idr.h>
    71	#include <linux/kgdb.h>
    72	#include <linux/ftrace.h>
    73	#include <linux/async.h>
    74	#include <linux/sfi.h>
    75	#include <linux/shmem_fs.h>
    76	#include <linux/slab.h>
    77	#include <linux/perf_event.h>
    78	#include <linux/ptrace.h>
    79	#include <linux/pti.h>
    80	#include <linux/blkdev.h>
    81	#include <linux/elevator.h>
    82	#include <linux/sched_clock.h>
    83	#include <linux/sched/task.h>
    84	#include <linux/sched/task_stack.h>
    85	#include <linux/context_tracking.h>
    86	#include <linux/random.h>
    87	#include <linux/list.h>
    88	#include <linux/integrity.h>
    89	#include <linux/proc_ns.h>
    90	#include <linux/io.h>
    91	#include <linux/cache.h>
    92	#include <linux/rodata_test.h>
    93	#include <linux/jump_label.h>
  > 94	#include <linux/test_genalloc.h>
    95	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

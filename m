From: lkp@intel.com (kbuild test robot)
Date: Sun, 20 May 2018 15:53:50 +0800
Subject: [PATCH v5 3/7] proc: add helpers to set and get proc hidepid and
	gid mount options
In-Reply-To: <20180511093528.GA1250@comp-core-i7-2640m-0182e6>
References: <20180511093528.GA1250@comp-core-i7-2640m-0182e6>
Message-ID: <201805201557.rhcitUVX%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Djalal,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc5]
[cannot apply to next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexey-Gladkov/proc-add-proc_fs_info-struct-to-store-proc-information/20180512-002936
config: xtensa-allnoconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   init/do_mounts.o: In function `proc_fs_pid_gid':
>> do_mounts.c:(.text+0x3c): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   arch/xtensa/kernel/setup.o: In function `proc_fs_pid_gid':
   setup.c:(.text+0x0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/fork.o: In function `proc_fs_pid_gid':
   fork.c:(.text+0x2a8): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/exec_domain.o: In function `proc_fs_pid_gid':
   exec_domain.c:(.text+0x0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/cpu.o: In function `proc_fs_pid_gid':
   cpu.c:(.text+0xf0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/exit.o: In function `proc_fs_pid_gid':
   exit.c:(.text+0x188): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/resource.o: In function `proc_fs_pid_gid':
   resource.c:(.text+0x344): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/sysctl.o: In function `proc_fs_pid_gid':
   sysctl.c:(.text+0x0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/pid.o: In function `proc_fs_pid_gid':
   pid.c:(.text+0x0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/sched/core.o: In function `proc_fs_pid_gid':
   core.c:(.text+0x6c8): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/sched/loadavg.o: In function `proc_fs_pid_gid':
   loadavg.c:(.text+0x0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/sched/clock.o: In function `proc_fs_pid_gid':
   clock.c:(.text+0x0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/sched/cputime.o: In function `proc_fs_pid_gid':
   cputime.c:(.text+0x0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/sched/idle.o: In function `proc_fs_pid_gid':
   idle.c:(.text+0x98): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/sched/fair.o: In function `proc_fs_pid_gid':
   fair.c:(.text+0xac0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/sched/rt.o: In function `proc_fs_pid_gid':
   rt.c:(.text+0x734): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/sched/deadline.o: In function `proc_fs_pid_gid':
   deadline.c:(.text+0x10b0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/sched/wait.o: In function `proc_fs_pid_gid':
   wait.c:(.text+0x120): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/sched/wait_bit.o: In function `proc_fs_pid_gid':
   wait_bit.c:(.text+0x78): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/sched/swait.o: In function `proc_fs_pid_gid':
   swait.c:(.text+0x24): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/sched/completion.o: In function `proc_fs_pid_gid':
   completion.c:(.text+0x0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   kernel/time/timer_list.o: In function `proc_fs_pid_gid':
   timer_list.c:(.text+0x1c): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   mm/vmstat.o: In function `proc_fs_pid_gid':
   vmstat.c:(.text+0x0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   mm/slab_common.o: In function `proc_fs_pid_gid':
   slab_common.c:(.text+0x0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   mm/vmalloc.o: In function `proc_fs_pid_gid':
   vmalloc.c:(.text+0x514): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   mm/slub.o: In function `proc_fs_pid_gid':
   slub.c:(.text+0x8a4): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   fs/filesystems.o: In function `proc_fs_pid_gid':
   filesystems.c:(.text+0x44): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here
   drivers/char/misc.o: In function `proc_fs_pid_gid':
   misc.c:(.text+0xe0): multiple definition of `proc_fs_pid_gid'
   init/main.o:main.c:(.text+0x30): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

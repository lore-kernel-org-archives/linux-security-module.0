From: lkp@intel.com (kbuild test robot)
Date: Wed, 29 Mar 2017 23:18:49 +0800
Subject: [PATCH net-next v6 04/11] landlock: Add LSM hooks related to
	filesystem
In-Reply-To: <20170328234650.19695-5-mic@digikod.net>
Message-ID: <201703292304.6B7Ybpau%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Micka?l,

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Micka-l-Sala-n/Landlock-LSM-Toward-unprivileged-sandboxing/20170329-211258
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from security/landlock/hooks.c:12:0:
   security/landlock/hooks.c: In function 'landlock_decide':
>> arch/x86/include/asm/processor.h:824:39: error: implicit declaration of function 'task_stack_page' [-Werror=implicit-function-declaration]
     unsigned long __ptr = (unsigned long)task_stack_page(task); \
                                          ^
>> security/landlock/hooks.c:107:41: note: in expansion of macro 'task_pt_regs'
      .syscall_nr = syscall_get_nr(current, task_pt_regs(current)),
                                            ^~~~~~~~~~~~
   security/landlock/hooks.c:104:26: warning: unused variable 'ctx' [-Wunused-variable]
     struct landlock_context ctx = {
                             ^~~
   security/landlock/hooks.c:102:6: warning: unused variable 'event_idx' [-Wunused-variable]
     u32 event_idx = get_index(event);
         ^~~~~~~~~
   cc1: some warnings being treated as errors

vim +/task_stack_page +824 arch/x86/include/asm/processor.h

2f66dcc9 include/asm-x86/processor.h      Glauber de Oliveira Costa 2008-01-30  818   * Therefore beware: accessing the ss/esp fields of the
2f66dcc9 include/asm-x86/processor.h      Glauber de Oliveira Costa 2008-01-30  819   * "struct pt_regs" is possible, but they may contain the
2f66dcc9 include/asm-x86/processor.h      Glauber de Oliveira Costa 2008-01-30  820   * completely wrong values.
2f66dcc9 include/asm-x86/processor.h      Glauber de Oliveira Costa 2008-01-30  821   */
2f66dcc9 include/asm-x86/processor.h      Glauber de Oliveira Costa 2008-01-30  822  #define task_pt_regs(task) \
2f66dcc9 include/asm-x86/processor.h      Glauber de Oliveira Costa 2008-01-30  823  ({									\
5c39403e arch/x86/include/asm/processor.h Denys Vlasenko            2015-03-13 @824  	unsigned long __ptr = (unsigned long)task_stack_page(task);	\
5c39403e arch/x86/include/asm/processor.h Denys Vlasenko            2015-03-13  825  	__ptr += THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;		\
5c39403e arch/x86/include/asm/processor.h Denys Vlasenko            2015-03-13  826  	((struct pt_regs *)__ptr) - 1;					\
2f66dcc9 include/asm-x86/processor.h      Glauber de Oliveira Costa 2008-01-30  827  })

:::::: The code at line 824 was first introduced by commit
:::::: 5c39403e004bec75ce0c549541be5479595d6ad0 x86/asm/entry: Simplify task_pt_regs() macro definition

:::::: TO: Denys Vlasenko <dvlasenk@redhat.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59015 bytes
Desc: not available
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170329/97b0f943/attachment.bin>

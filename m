From: lkp@intel.com (kbuild test robot)
Date: Wed, 11 Oct 2017 05:30:09 +0800
Subject: [PATCH net-next v2 4/5] selinux: bpf: Add selinux check for eBPF
	syscall operations
In-Reply-To: <20171009222028.13096-5-chenbofeng.kernel@gmail.com>
Message-ID: <201710110541.YJ9FcYLq%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Chenbo,

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Chenbo-Feng/bpf-security-New-file-mode-and-LSM-hooks-for-eBPF-object-permission-control/20171011-010349
config: x86_64-randconfig-u0-10110310 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/init.h:4:0,
                    from security/selinux/hooks.c:27:
   security/selinux/hooks.c: In function 'bpf_map_fmode_to_av':
   security/selinux/hooks.c:6284:6: error: 'f_mode' undeclared (first use in this function)
     if (f_mode & FMODE_READ)
         ^
   include/linux/compiler.h:156:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> security/selinux/hooks.c:6284:2: note: in expansion of macro 'if'
     if (f_mode & FMODE_READ)
     ^~
   security/selinux/hooks.c:6284:6: note: each undeclared identifier is reported only once for each function it appears in
     if (f_mode & FMODE_READ)
         ^
   include/linux/compiler.h:156:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> security/selinux/hooks.c:6284:2: note: in expansion of macro 'if'
     if (f_mode & FMODE_READ)
     ^~

vim +/if +6284 security/selinux/hooks.c

  6279	
  6280	static u32 bpf_map_fmode_to_av(fmode_t fmode)
  6281	{
  6282		u32 av = 0;
  6283	
> 6284		if (f_mode & FMODE_READ)
  6285			av |= BPF_MAP__READ;
  6286		if (f_mode & FMODE_WRITE)
  6287			av |= BPF_MAP__WRITE;
  6288		return av;
  6289	}
  6290	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

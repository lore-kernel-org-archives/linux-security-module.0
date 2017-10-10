From: lkp@intel.com (kbuild test robot)
Date: Wed, 11 Oct 2017 01:59:21 +0800
Subject: [PATCH net-next v2 4/5] selinux: bpf: Add selinux check for eBPF
	syscall operations
In-Reply-To: <20171009222028.13096-5-chenbofeng.kernel@gmail.com>
Message-ID: <201710110112.0cqduzfz%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Chenbo,

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Chenbo-Feng/bpf-security-New-file-mode-and-LSM-hooks-for-eBPF-object-permission-control/20171011-010349
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   security//selinux/hooks.c: In function 'bpf_map_fmode_to_av':
>> security//selinux/hooks.c:6284:6: error: 'f_mode' undeclared (first use in this function)
     if (f_mode & FMODE_READ)
         ^
   security//selinux/hooks.c:6284:6: note: each undeclared identifier is reported only once for each function it appears in

vim +/f_mode +6284 security//selinux/hooks.c

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

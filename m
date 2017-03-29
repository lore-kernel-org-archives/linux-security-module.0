From: lkp@intel.com (kbuild test robot)
Date: Wed, 29 Mar 2017 21:48:01 +0800
Subject: [PATCH net-next v6 01/11] bpf: Add eBPF program subtype and
	is_valid_subtype() verifier
In-Reply-To: <20170328234650.19695-2-mic@digikod.net>
Message-ID: <201703292120.wrm0eHSI%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Micka?l,

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Micka-l-Sala-n/Landlock-LSM-Toward-unprivileged-sandboxing/20170329-211258
config: i386-randconfig-x002-201713 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'bpf_prog_load':
>> kernel/bpf/syscall.c:886:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      size = check_user_buf((void __user *)attr->prog_subtype,
                            ^

vim +886 kernel/bpf/syscall.c

   870	
   871		prog->orig_prog = NULL;
   872		prog->jited = 0;
   873	
   874		atomic_set(&prog->aux->refcnt, 1);
   875		prog->gpl_compatible = is_gpl ? 1 : 0;
   876	
   877		/* find program type: socket_filter vs tracing_filter */
   878		err = find_prog_type(type, prog);
   879		if (err < 0)
   880			goto free_prog;
   881	
   882		/* copy eBPF program subtype from user space */
   883		if (attr->prog_subtype) {
   884			__u32 size;
   885	
 > 886			size = check_user_buf((void __user *)attr->prog_subtype,
   887					      attr->prog_subtype_size,
   888					      sizeof(prog->subtype));
   889			if (size < 0) {
   890				err = size;
   891				goto free_prog;
   892			}
   893			/* prog->subtype is __GFP_ZERO */
   894			if (copy_from_user(&prog->subtype,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23016 bytes
Desc: not available
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170329/49d3bfb9/attachment.bin>

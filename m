From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 14 Mar 2018 01:42:24 +0800
Subject: [linux-next:master 6699/7643]
	security/integrity/evm/evm_crypto.c:40:6: sparse: symbol 'evm_hmac' was
	not declared. Should it be static?
Message-ID: <201803140150.bfjQDiL5%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   872c90b2c71859eb7283d670b9e70226fb40c9ea
commit: c49fc264be98724c8bf84366f3dd8f1785aabe76 [6699/7643] evm: Move evm_hmac and evm_hash from evm_main.c to evm_crypto.c
reproduce:
        # apt-get install sparse
        git checkout c49fc264be98724c8bf84366f3dd8f1785aabe76
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/init.h:134:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/init.h:135:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/init.h:268:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/init.h:269:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/printk.h:200:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:32:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:34:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:37:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:38:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:40:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:42:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:43:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:45:5: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:46:5: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:49:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/qspinlock.h:53:32: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/workqueue.h:646:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/workqueue.h:647:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/memory_hotplug.h:221:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/numa.h:34:12: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/numa.h:35:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/numa.h:62:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/vmalloc.h:64:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/vmalloc.h:173:8: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/vmalloc.h:174:8: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:174:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:176:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:178:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:180:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/apic.h:254:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/apic.h:430:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/io_apic.h:184:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mmzone.h:1292:15: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/smp.h:113:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/smp.h:125:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/smp.h:126:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:110:33: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:112:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:114:12: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:118:12: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:126:12: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/vdso.h:44:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/kmemleak.h:29:33: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/kasan.h:29:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/kasan.h:30:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/pgtable.h:28:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/slab.h:135:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/slab.h:716:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/hrtimer.h:497:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/wait_bit.h:41:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:63:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:64:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:65:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:66:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:2423:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:2424:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:3331:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/integrity.h:28:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:1753:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:1941:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:2083:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:2671:6: sparse: attribute 'indirect_branch': unknown attribute
   security/integrity/evm/../integrity.h:152:5: sparse: attribute 'indirect_branch': unknown attribute
   security/integrity/evm/../integrity.h:153:5: sparse: attribute 'indirect_branch': unknown attribute
   security/integrity/evm/../integrity.h:181:6: sparse: attribute 'indirect_branch': unknown attribute
   security/integrity/evm/../integrity.h:189:6: sparse: attribute 'indirect_branch': unknown attribute
>> security/integrity/evm/evm_crypto.c:40:6: sparse: symbol 'evm_hmac' was not declared. Should it be static?
>> security/integrity/evm/evm_crypto.c:41:6: sparse: symbol 'evm_hash' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

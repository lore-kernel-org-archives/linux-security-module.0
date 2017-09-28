From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 28 Sep 2017 13:45:22 +0800
Subject: [integrity:next-read-iter 8/10]
	drivers/staging/android/ashmem.c:824:15: error: initialization from
	incompatible pointer type
Message-ID: <201709281318.VDQFJcwN%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-read-iter
head:   ae08ec95103a8a397c1b7d937ae385da9a39e0ae
commit: fd2fa4dd802ceeda33de39b5212fa0f5e1ccc534 [8/10] fs: define new read_iter rwf flag
config: x86_64-acpi-redef (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout fd2fa4dd802ceeda33de39b5212fa0f5e1ccc534
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> drivers/staging/android/ashmem.c:824:15: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .read_iter = ashmem_read_iter,
                  ^~~~~~~~~~~~~~~~
   drivers/staging/android/ashmem.c:824:15: note: (near initialization for 'ashmem_fops.read_iter')
   cc1: some warnings being treated as errors

vim +824 drivers/staging/android/ashmem.c

e9f5b814 Serban Constantinescu 2013-03-05  819  
aa5af974 Tracey Dent           2012-01-22  820  static const struct file_operations ashmem_fops = {
11980c2a Robert Love           2011-12-20  821  	.owner = THIS_MODULE,
11980c2a Robert Love           2011-12-20  822  	.open = ashmem_open,
11980c2a Robert Love           2011-12-20  823  	.release = ashmem_release,
8a2af064 Christoph Hellwig     2017-09-01 @824  	.read_iter = ashmem_read_iter,
5154b93b Bjorn Bringert        2011-12-20  825  	.llseek = ashmem_llseek,
11980c2a Robert Love           2011-12-20  826  	.mmap = ashmem_mmap,
11980c2a Robert Love           2011-12-20  827  	.unlocked_ioctl = ashmem_ioctl,
e9f5b814 Serban Constantinescu 2013-03-05  828  #ifdef CONFIG_COMPAT
e9f5b814 Serban Constantinescu 2013-03-05  829  	.compat_ioctl = compat_ashmem_ioctl,
e9f5b814 Serban Constantinescu 2013-03-05  830  #endif
11980c2a Robert Love           2011-12-20  831  };
11980c2a Robert Love           2011-12-20  832  

:::::: The code at line 824 was first introduced by commit
:::::: 8a2af06415ef0fc922162503dd18da0d9be7771f ashmem: switch to ->read_iter

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

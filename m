From: lkp@intel.com (kbuild test robot)
Date: Fri, 16 Jun 2017 07:49:25 +0800
Subject: [PATCH 1/4] ima: use fs method to read integrity data
In-Reply-To: <1497031364-19949-2-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <201706160704.Yq17eRie%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Christoph,

[auto build test WARNING on security/next]
[also build test WARNING on v4.12-rc5 next-20170615]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mimi-Zohar/ima-use-fs-method-to-read-integrity-data/20170611-062655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> security//integrity/iint.c:189:42: sparse: incorrect type in initializer (different address spaces)
   security//integrity/iint.c:189:42:    expected void [noderef] <asn:1>*iov_base
   security//integrity/iint.c:189:42:    got char *addr

vim +189 security//integrity/iint.c

   173	}
   174	security_initcall(integrity_iintcache_init);
   175	
   176	
   177	/*
   178	 * integrity_kernel_read - read data from the file
   179	 *
   180	 * This is a function for reading file content instead of kernel_read().
   181	 * It does not perform locking checks to ensure it cannot be blocked.
   182	 * It does not perform security checks because it is irrelevant for IMA.
   183	 *
   184	 */
   185	int integrity_kernel_read(struct file *file, loff_t offset,
   186				  char *addr, unsigned long count)
   187	{
   188		struct inode *inode = file_inode(file);
 > 189		struct iovec iov = { .iov_base = addr, .iov_len = count };
   190		struct kiocb kiocb;
   191		struct iov_iter iter;
   192		ssize_t ret;
   193	
   194		lockdep_assert_held(&inode->i_rwsem);
   195	
   196		if (!(file->f_mode & FMODE_READ))
   197			return -EBADF;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

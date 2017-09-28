From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 28 Sep 2017 13:43:41 +0800
Subject: [integrity:next-read-iter 8/10] drivers//vhost/net.c:1348:9: error:
	too many arguments to function 'vhost_chr_read_iter'
Message-ID: <201709281307.cU8bUZ2f%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-read-iter
head:   ae08ec95103a8a397c1b7d937ae385da9a39e0ae
commit: fd2fa4dd802ceeda33de39b5212fa0f5e1ccc534 [8/10] fs: define new read_iter rwf flag
config: i386-randconfig-x076-201739 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout fd2fa4dd802ceeda33de39b5212fa0f5e1ccc534
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers//vhost/net.c: In function 'vhost_net_chr_read_iter':
>> drivers//vhost/net.c:1348:9: error: too many arguments to function 'vhost_chr_read_iter'
     return vhost_chr_read_iter(dev, to, noblock, rwf);
            ^~~~~~~~~~~~~~~~~~~
   In file included from drivers//vhost/net.c:36:0:
   drivers//vhost/vhost.h:221:9: note: declared here
    ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
            ^~~~~~~~~~~~~~~~~~~

vim +/vhost_chr_read_iter +1348 drivers//vhost/net.c

  1339	
  1340	static ssize_t vhost_net_chr_read_iter(struct kiocb *iocb, struct iov_iter *to,
  1341					       bool rwf)
  1342	{
  1343		struct file *file = iocb->ki_filp;
  1344		struct vhost_net *n = file->private_data;
  1345		struct vhost_dev *dev = &n->dev;
  1346		int noblock = file->f_flags & O_NONBLOCK;
  1347	
> 1348		return vhost_chr_read_iter(dev, to, noblock, rwf);
  1349	}
  1350	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

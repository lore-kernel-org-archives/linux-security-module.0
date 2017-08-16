From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 17 Aug 2017 02:11:44 +0800
Subject: [integrity:next-log-iversion 8/11] fs/namespace.c:2472:3: error:
	implicit declaration of function 'security_sb_post_new_mount'
Message-ID: <201708170239.mbv653IE%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-log-iversion
head:   5873cd8f629e0306acdc40d3a9142eb50ae70c2d
commit: 28449c1b5aea9dc632c13206cadd1087cd9a3f23 [8/11] security: define new LSM sb_post_new_mount hook
config: i386-tinyconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 28449c1b5aea9dc632c13206cadd1087cd9a3f23
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the integrity/next-log-iversion HEAD 5873cd8f629e0306acdc40d3a9142eb50ae70c2d builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   fs/namespace.c: In function 'do_new_mount':
>> fs/namespace.c:2472:3: error: implicit declaration of function 'security_sb_post_new_mount' [-Werror=implicit-function-declaration]
      security_sb_post_new_mount(mnt, path);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/security_sb_post_new_mount +2472 fs/namespace.c

  2435	
  2436	/*
  2437	 * create a new mount for userspace and request it to be added into the
  2438	 * namespace's tree
  2439	 */
  2440	static int do_new_mount(struct path *path, const char *fstype, int flags,
  2441				int mnt_flags, const char *name, void *data)
  2442	{
  2443		struct file_system_type *type;
  2444		struct vfsmount *mnt;
  2445		int err;
  2446	
  2447		if (!fstype)
  2448			return -EINVAL;
  2449	
  2450		type = get_fs_type(fstype);
  2451		if (!type)
  2452			return -ENODEV;
  2453	
  2454		mnt = vfs_kern_mount(type, flags, name, data);
  2455		if (!IS_ERR(mnt) && (type->fs_flags & FS_HAS_SUBTYPE) &&
  2456		    !mnt->mnt_sb->s_subtype)
  2457			mnt = fs_set_subtype(mnt, fstype);
  2458	
  2459		put_filesystem(type);
  2460		if (IS_ERR(mnt))
  2461			return PTR_ERR(mnt);
  2462	
  2463		if (mount_too_revealing(mnt, &mnt_flags)) {
  2464			mntput(mnt);
  2465			return -EPERM;
  2466		}
  2467	
  2468		err = do_add_mount(real_mount(mnt), path, mnt_flags);
  2469		if (err)
  2470			mntput(mnt);
  2471		else
> 2472			security_sb_post_new_mount(mnt, path);
  2473		return err;
  2474	}
  2475	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

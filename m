Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793673785;
	b=nL+SxxPpZt+klpVcr2NXyni2QTZA6Wuudu9P8jtQVNRNdkkXtd4U3UHCbBs/l2UBNS28
	 aCqMrEim5GMnpKb5UZ/+MKpYTQuuUdoKNKbELPeoxwQKmI3Jrrot+mqvEDVWmikCPXgcM
	 6bFAKZq1PfVJSDqkrCAMUIQmDN5EJYknfinby+MARZQo2yT0mcD+N524s7mylt4lyNyex
	 v2mOoFnffOaQHdnDqXQcHisMady8bsnMPfDWI4Nl8aSNl8K9jk6fKfgIgW2s2pMB3qvYL
	 JxPIYQ5aWnEoHq02PPeDm9xLaQSmy64CUEkGqyf0S94eD43sXj95ZafFPfSBD6B1qrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673785;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=GHRb85n1Foh7KgznphB1XwN4hpwluA6wCCK9oDJFt+0=;
	b=AAPtqTuiZNrDVlACfhUcVFVvMU2N37E79igbHi7yWNQFUGtetUCKetwxJ0IjUgKlUG9J
	 utGpbJir53+UGKBG5hV1V+1uqrGm1JF6Gg+aqFSYRilu0fE21mA2BET2ensbHjLi4UDEg
	 GpTbPrmwthqrNaXq2mov98Q6xmzhIQzw357y30BlJhxeZ7wmR4VfUOn6DNxscEUu4Qy00
	 JtAbhGtsEUuQiAigvSOZYuLhasex2bOr1XIaLse49y4sM4bRWKENv5WJ4xCOwLtgXMPYe
	 Qe2gBC3pB1gM+o8Jh7RYFCrYDmDl/Rfq1CmnrcEPN5KNIY3Pk2XTt+szKWJuWgrdPbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hhn1ZKeT;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B9606A326;
	Tue,  3 Nov 2026 02:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 921B9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hhn1ZKeT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793673783; x=1825209783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iESoaevwqTMSuhIUPaAMKfLpXgQKRSiqlSV8Jn8HSos=;
  b=Hhn1ZKeTm189WkThts+MO5iKAtLd7YssKxrMA9soBKkGYg4A5XbtENoE
   nuyhy/UHSlonKGT/X5CXK+aY30Y3HjFY+WHjlxWAFC3W5gNTY8YiAz4rJ
   1P20Q2z/DpSG+LpYIJNuA0kTRz3MgvtWv9dcZh+GLkEvmVO7GJdO0IurM
   NmIE5Vbtp9+LX3MFA6VbthFUSyus+VFKS7+m5YHe30kCLUauzvD+0lve/
   jNt2bfMRmW2LEdDWcpz4eExj+JowrT2Rm6j7M4x14PkBPMbwhNWF9mmdX
   CyNmw3txlHrU5y2c7k4/2PUN+LleKiMj1fHfkAKdxKTAf7TDmtb5qiHI6
   Q==;
X-CSE-ConnectionGUID: VUO1SCRdT3+GaitKaYTw6g==
X-CSE-MsgGUID: e3b+St7cRGKVH11+ZcNejQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2264642"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2264642"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 18:43:03 -0800
X-CSE-ConnectionGUID: GY5dtudzRe+l1yJICGtbMg==
X-CSE-MsgGUID: M0Qwd2mOQqi1UUrelqyqBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6619852"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 02 Nov 2026 18:43:00 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xO4UD-00000000iCu-19Sb;
	Tue, 03 Nov 2026 02:42:57 +0000
Date: Tue, 3 Nov 2026 10:42:35 +0800
From: kernel test robot <lkp@intel.com>
To: Oxana Kharitonova <webprosto@gmail.com>, mic@digikod.net,
	brauner@kernel.org, viro@zeniv.linux.org.uk, gnoack@google.com,
	utilityemal77@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, webprosto@gmail.com,
	landlock@lists.linux.dev
Subject: Re: [PATCH v2 2/4] Landlock: Enforce MAKE_REG for POSIX message
 queue creation
Message-ID: <202611031036.3r5EL9TN-lkp@intel.com>
References: <20261102144708.920232-3-webprosto@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102144708.920232-3-webprosto@gmail.com>

Hi Oxana,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on linus/master next-20261030]
[cannot apply to shuah-kselftest/fixes trace/for-next brauner-vfs/vfs.all v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oxana-Kharitonova/ipc-Move-MQUEUE_MAGIC-to-a-shared-header/20261102-144557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20261102144708.920232-3-webprosto%40gmail.com
patch subject: [PATCH v2 2/4] Landlock: Enforce MAKE_REG for POSIX message queue creation
config: s390-defconfig (https://download.01.org/0day-ci/archive/20261103/202611031036.3r5EL9TN-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611031036.3r5EL9TN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611031036.3r5EL9TN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/landlock/fs.c:1686:51: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
    1686 |                              struct dentry *const dentry, const umode_t)
         |                                                                        ^
   security/landlock/fs.c:2117:30: error: incompatible function pointer types initializing 'int (*)(const struct mnt_idmap *, struct inode *, struct dentry *, umode_t)' (aka 'int (*)(const struct mnt_idmap *, struct inode *, struct dentry *, unsigned short)') with an expression of type 'int (struct inode *const, struct dentry *const, const umode_t)' (aka 'int (struct inode *const, struct dentry *const, const unsigned short)') [-Wincompatible-function-pointer-types]
    2117 |         LSM_HOOK_INIT(inode_create, hook_inode_create),
         |                                     ^~~~~~~~~~~~~~~~~
   include/linux/lsm_hooks.h:141:21: note: expanded from macro 'LSM_HOOK_INIT'
     141 |                 .hook = { .NAME = HOOK }                \
         |                                   ^~~~
   1 warning and 1 error generated.


vim +1686 security/landlock/fs.c

  1679	
  1680	/*
  1681	 * Unlike regular file creation, mq_open(2) calls vfs_mkobj() directly and
  1682	 * therefore does not trigger the path_mknod hook.  Use the mqueuefs mount
  1683	 * associated with the current IPC namespace to recover the parent path.
  1684	 */
  1685	static int hook_inode_create(struct inode *const dir,
> 1686				     struct dentry *const dentry, const umode_t)
  1687	{
  1688		struct ipc_namespace *ipc_ns;
  1689		struct vfsmount *mnt;
  1690		struct path parent;
  1691	
  1692		if (!landlock_is_posix_mqueue_fs(dir))
  1693			return 0;
  1694	
  1695		if (!current->nsproxy)
  1696			return 0;
  1697		ipc_ns = current->nsproxy->ipc_ns;
  1698		if (!ipc_ns)
  1699			return 0;
  1700		mnt = ipc_ns->mq_mnt;
  1701		if (WARN_ON_ONCE(!mnt || mnt->mnt_sb != dir->i_sb))
  1702			return 0;
  1703	
  1704		parent.mnt = mnt;
  1705		parent.dentry = dentry->d_parent;
  1706		return current_check_access_path(&parent, LANDLOCK_ACCESS_FS_MAKE_REG);
  1707	}
  1708	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

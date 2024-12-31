Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099FB15A848;
	Tue, 31 Dec 2024 05:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735622998; cv=none; b=eZ3nnpxF3joVbUKpXmWo6p1pcLwRHjI9mEup+kCYMfbcSp1+hAMfnXdg4X8UbegOjFOF9+b4274CCWAHM8r6yKujLsLQz6hTdwc/eUslgiXgwAtEK/OjlBS1/GrVTMoNax/ucMuot6aQmCGQmfv1v4m0y5B54Bbl8YlppVTAC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735622998; c=relaxed/simple;
	bh=JXjNPOUWo6llxAHjOnawwWCRzvFQjkJg8AXsIhrI1SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULigOH+SHqFyOxtwjhmzvldziYiRCvBX3e4bRC1irRhMCHDMJddkHJx9wk5AmoThum4eNTy/WAulr0ECTA6ihbFCzIaeFMHieDLfuSc3FgpWUxWKGP/LTd1dFeElQT+n9zb7LJ/l4/fHk+ccBsTxnQ+9EC1sQ1Eq6P8LZgTIfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhLtIn1r; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhLtIn1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735622997; x=1767158997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JXjNPOUWo6llxAHjOnawwWCRzvFQjkJg8AXsIhrI1SI=;
  b=GhLtIn1rTc1lJMCvNAtpQej2XbAVgOb215FwbBDJowhQgIXIF249cSxk
   mBX+5H62hq4GTd1fodk0IAikiPpTMdigFTC0IW0pYctmRiNJVWhDQsIZs
   Om7sfKSGgGarsVEdddAsO32hCKuWWTp5a5cxRFS+HyjohqL5k0XpMpxiS
   ggNn8926M6T/W+Cp5LHK7yuXVg0/A1naxmYv1QS+q71w99d85LlkKxF+Q
   1H317yR3yAv8gAjiEox7ZkwTF/6AivvHD7JjWVwelDyrZk3BeCCr+1wwn
   djzrd5a/px6WiwTzSSr2tkFqtyKAh+VPu2/squMzEN9Bjn/n6xKSFOZ7D
   A==;
X-CSE-ConnectionGUID: lkgZpe0VS9KRoXSBJwQsyQ==
X-CSE-MsgGUID: 5VK6AQJVQ9aoiN7/H2oPKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11301"; a="53449955"
X-IronPort-AV: E=Sophos;i="6.12,278,1728975600"; 
   d="scan'208";a="53449955"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2024 21:29:56 -0800
X-CSE-ConnectionGUID: uH6UoX5TTnujz6o39jC6Ew==
X-CSE-MsgGUID: OPAZhILIS3yiAWKZVJuTXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105971468"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 30 Dec 2024 21:29:52 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tSUpC-0006nH-0w;
	Tue, 31 Dec 2024 05:29:50 +0000
Date: Tue, 31 Dec 2024 13:28:53 +0800
From: kernel test robot <lkp@intel.com>
To: Shervin Oloumi <enlightened@chromium.org>, mic@digikod.net,
	viro@zeniv.linux.org.uk
Cc: oe-kbuild-all@lists.linux.dev, brauner@kernel.org, jack@suse.cz,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	gnoack@google.com, shuah@kernel.org, jorgelo@chromium.org,
	allenwebb@chromium.org, Shervin Oloumi <enlightened@chromium.org>
Subject: Re: [PATCH 1/2] fs: add loopback/bind mount specific security hook
Message-ID: <202412311303.Cb16SNL3-lkp@intel.com>
References: <20241231014632.589049-1-enlightened@chromium.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231014632.589049-1-enlightened@chromium.org>

Hi Shervin,

kernel test robot noticed the following build errors:

[auto build test ERROR on fc033cf25e612e840e545f8d5ad2edd6ba613ed5]

url:    https://github.com/intel-lab-lkp/linux/commits/Shervin-Oloumi/landlock-add-support-for-private-bind-mount/20241231-094806
base:   fc033cf25e612e840e545f8d5ad2edd6ba613ed5
patch link:    https://lore.kernel.org/r/20241231014632.589049-1-enlightened%40chromium.org
patch subject: [PATCH 1/2] fs: add loopback/bind mount specific security hook
config: sparc-randconfig-002-20241231 (https://download.01.org/0day-ci/archive/20241231/202412311303.Cb16SNL3-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241231/202412311303.Cb16SNL3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412311303.Cb16SNL3-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/namespace.c: In function 'do_loopback':
>> fs/namespace.c:2768:15: error: implicit declaration of function 'security_sb_bindmount'; did you mean 'security_sb_umount'? [-Wimplicit-function-declaration]
    2768 |         err = security_sb_bindmount(&old_path, path);
         |               ^~~~~~~~~~~~~~~~~~~~~
         |               security_sb_umount


vim +2768 fs/namespace.c

  2751	
  2752	/*
  2753	 * do loopback mount.
  2754	 */
  2755	static int do_loopback(struct path *path, const char *old_name,
  2756					int recurse)
  2757	{
  2758		struct path old_path;
  2759		struct mount *mnt = NULL, *parent;
  2760		struct mountpoint *mp;
  2761		int err;
  2762		if (!old_name || !*old_name)
  2763			return -EINVAL;
  2764		err = kern_path(old_name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &old_path);
  2765		if (err)
  2766			return err;
  2767	
> 2768		err = security_sb_bindmount(&old_path, path);
  2769		if (err)
  2770			goto out;
  2771	
  2772		err = -EINVAL;
  2773		if (mnt_ns_loop(old_path.dentry))
  2774			goto out;
  2775	
  2776		mp = lock_mount(path);
  2777		if (IS_ERR(mp)) {
  2778			err = PTR_ERR(mp);
  2779			goto out;
  2780		}
  2781	
  2782		parent = real_mount(path->mnt);
  2783		if (!check_mnt(parent))
  2784			goto out2;
  2785	
  2786		mnt = __do_loopback(&old_path, recurse);
  2787		if (IS_ERR(mnt)) {
  2788			err = PTR_ERR(mnt);
  2789			goto out2;
  2790		}
  2791	
  2792		err = graft_tree(mnt, parent, mp);
  2793		if (err) {
  2794			lock_mount_hash();
  2795			umount_tree(mnt, UMOUNT_SYNC);
  2796			unlock_mount_hash();
  2797		}
  2798	out2:
  2799		unlock_mount(mp);
  2800	out:
  2801		path_put(&old_path);
  2802		return err;
  2803	}
  2804	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

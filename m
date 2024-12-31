Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A206C1547CC;
	Tue, 31 Dec 2024 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735624982; cv=none; b=t0Xz2g9F50suA2JF3fy0DaLOCR/8kf5M/7kSavZN+pljQ8KxdtWJp5+rn2o+3NrQTz4EV9HdhMn5zup72P+T+HFR+3NMz2+hngluz3PbsxUWAjd6FX8NXxmaTmbta63S44S7RpF8mhwSj1XBCVXR8vuy60F+tidd8z1ii7kG0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735624982; c=relaxed/simple;
	bh=YcnXuO7iHKmJdqPb9BnkF7onhOBNqoZYcDE/yprJUfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCXQ7DGKTcO8bYvVB1lJ1NuwDNRQYYXQ4TPshINJknfsygWXm92NUOhhWepmEB3fX6TKEsYsrBXwNutC+zvczUM3MM9gfxxS4Ofd/Wc+hi2q7WGgkGigL4k0re7bRp05nDhHQOMxsbmja+yk5dxDE74ukgWdn5//AxsYo3SzROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAF4qIKv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAF4qIKv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735624981; x=1767160981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YcnXuO7iHKmJdqPb9BnkF7onhOBNqoZYcDE/yprJUfg=;
  b=YAF4qIKvM8VXHWl5qwBOygiecJimOlwqIGL5L24RjycKlUjCFLWU9mOr
   Qe5qjacgwUSCQpakJ86ZV31BYBvakZRaFA0rmW33DS3jvs+673sTNqQVV
   d0nr/DM2tyMFBEDefmu+eXkcPvXEUJZfnra1OIUAKjX7LPwFE6vPly1/n
   q0u80rCmkdh58pIkXStLwPotEzaJAoxuMe/1RbgZBuao2QbYWWgFPZYF1
   N2vtiXHoqLuAEadHwK4vfmeMPGq0uWMNaJobstPa0pENDKlBPn3PdD2SD
   WelKyKHE8qyQZHoaNTmocofwOp3qzFsyWufAanFVlJzeqe7xKAfITfwA6
   g==;
X-CSE-ConnectionGUID: FsGLo+TsS0WYlPX1zql8jw==
X-CSE-MsgGUID: Kqr7Sct6RBmADOAARTqBqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11301"; a="46399018"
X-IronPort-AV: E=Sophos;i="6.12,278,1728975600"; 
   d="scan'208";a="46399018"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2024 22:03:00 -0800
X-CSE-ConnectionGUID: aG9EFMEvTda4oslupSCMzQ==
X-CSE-MsgGUID: IdVyz2JETJCj+ot39c0n4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,278,1728975600"; 
   d="scan'208";a="101088930"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Dec 2024 22:02:56 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tSVLC-0006pT-1B;
	Tue, 31 Dec 2024 06:02:54 +0000
Date: Tue, 31 Dec 2024 14:01:57 +0800
From: kernel test robot <lkp@intel.com>
To: Shervin Oloumi <enlightened@chromium.org>, mic@digikod.net,
	viro@zeniv.linux.org.uk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, brauner@kernel.org,
	jack@suse.cz, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, gnoack@google.com,
	shuah@kernel.org, jorgelo@chromium.org, allenwebb@chromium.org,
	Shervin Oloumi <enlightened@chromium.org>
Subject: Re: [PATCH 1/2] fs: add loopback/bind mount specific security hook
Message-ID: <202412311322.DkS3TbED-lkp@intel.com>
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
config: um-randconfig-001-20241231 (https://download.01.org/0day-ci/archive/20241231/202412311322.DkS3TbED-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 319b89197348b7cad1215e235bdc7b5ec8f9b72c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241231/202412311322.DkS3TbED-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412311322.DkS3TbED-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/namespace.c:2768:8: error: call to undeclared function 'security_sb_bindmount'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2768 |         err = security_sb_bindmount(&old_path, path);
         |               ^
   1 error generated.


vim +/security_sb_bindmount +2768 fs/namespace.c

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

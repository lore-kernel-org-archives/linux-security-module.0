Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0B1A316E;
	Mon, 28 Jul 2025 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753740349; cv=none; b=k+WwbrEqo9cLbAsVjz5f02qBC66IXeJdLYxIeqfeemVRnV8vyucHEV3HWL17TSHf51ypErlhcU4r0L5V8rlJBdzkqNME0zA85/djayA2kHfVv1SO3MbE/D56kXhqZkqAP2R8+oMvY8vZKWtxYkLZ+IT0aRwEHfjKerMGTyM4FzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753740349; c=relaxed/simple;
	bh=kJsi3IgGKmtRibPIrWNWaBJJCyE8e9J8FoD/26+TC1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJVWAiJ25z70INE8LAricB61CI8hjE2EskATfdP8gzP0lgzaSWJHwVAHkzCT1rtQi4V98Mnum0M7GmmZjSnxCkYU/hvyyro4VuIi9an7HfO4UAGXypVuyGM29fQLhJqTlgjgJlqGeaTKY8rvJLAopzouLn0NqppD/4nGCXyI52w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MaeEw8qt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaeEw8qt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753740348; x=1785276348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kJsi3IgGKmtRibPIrWNWaBJJCyE8e9J8FoD/26+TC1w=;
  b=MaeEw8qtmZY1BjUA/CZhgBtpp1yL+lADIPiF8VGIbNYf3cKSgssicrOi
   Q+ZcIkQTK+2w69y4/jOT/hS54tHpXACkp4mbYzhAKZusLclMF7JbereRO
   JqoOEGSUWb8BJte2QYW0IJyIjMcJ07I09Iy8VrCh76h9ACnrAqNIhxOp8
   rCUrqC8vPjTGf/0LCMyQM6rWY1i/icxqYRAAaas5+zIkLT/xJiAVnWc4v
   7VJ4luXmsQLbtlocmsZCR+7LUZg6cTkGT0cgd9Upum5wYAw7191wsh5Re
   DbH8z82eEsi/y2JSkjW8nudPijwrGZYssO3ELaMvguAcqqjv7Ydh0CTRY
   w==;
X-CSE-ConnectionGUID: my7CTukZROWEbHa1Nq/ydw==
X-CSE-MsgGUID: BWP3vUgDSyqkaD0A5UzWiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67083340"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="67083340"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 15:05:47 -0700
X-CSE-ConnectionGUID: eLd5rzdARqS1sDBQP5aHgQ==
X-CSE-MsgGUID: pPEcEzuGT+eVmeOMHzKIyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166778407"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 Jul 2025 15:05:44 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugVyY-0000nF-0q;
	Mon, 28 Jul 2025 22:05:42 +0000
Date: Tue, 29 Jul 2025 06:04:45 +0800
From: kernel test robot <lkp@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>,
	linux-security-module@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com,
	jmorris@namei.org, dan.j.williams@intel.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH v2 2/3] lockdown/kunit: Introduce kunit tests
Message-ID: <202507290540.9IANrMED-lkp@intel.com>
References: <20250728111517.134116-3-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728111517.134116-3-nik.borisov@suse.com>

Hi Nikolay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16 next-20250728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikolay-Borisov/lockdown-Switch-implementation-to-using-bitmap/20250728-191807
base:   linus/master
patch link:    https://lore.kernel.org/r/20250728111517.134116-3-nik.borisov%40suse.com
patch subject: [PATCH v2 2/3] lockdown/kunit: Introduce kunit tests
config: arm-randconfig-004-20250729 (https://download.01.org/0day-ci/archive/20250729/202507290540.9IANrMED-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 1b4db78d2eaa070b3f364a2d2b2b826a5439b892)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507290540.9IANrMED-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507290540.9IANrMED-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/lockdown/lockdown.c:31:5: warning: no previous prototype for function 'lock_kernel_down' [-Wmissing-prototypes]
      31 | int lock_kernel_down(const char *where, enum lockdown_reason level)
         |     ^
   security/lockdown/lockdown.c:31:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      31 | int lock_kernel_down(const char *where, enum lockdown_reason level)
         | ^
         | static 
   1 warning generated.


vim +/lock_kernel_down +31 security/lockdown/lockdown.c

    20	
    21	static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
    22							 LOCKDOWN_INTEGRITY_MAX,
    23							 LOCKDOWN_CONFIDENTIALITY_MAX};
    24	
    25	/*
    26	 * Put the kernel into lock-down mode.
    27	 */
    28	#if !IS_ENABLED(CONFIG_KUNIT)
    29	static
    30	#endif
  > 31	int lock_kernel_down(const char *where, enum lockdown_reason level)
    32	{
    33	
    34		if (level > LOCKDOWN_CONFIDENTIALITY_MAX)
    35			return -EINVAL;
    36	
    37		if (level == LOCKDOWN_INTEGRITY_MAX || level == LOCKDOWN_CONFIDENTIALITY_MAX)
    38			bitmap_set(kernel_locked_down, 1, level);
    39		else
    40			bitmap_set(kernel_locked_down, level, 1);
    41	
    42		pr_notice("Kernel is locked down from %s; see man kernel_lockdown.7\n",
    43			  where);
    44		return 0;
    45	}
    46	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

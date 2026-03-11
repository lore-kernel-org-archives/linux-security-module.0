Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273D3A169E;
	Wed, 11 Mar 2026 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270806; cv=none; b=GMLLW0oYOJYaZO+kiQB7OWg2dS0qnhShJ4NZIxTMJLOsa/D2ysVYnCLhMYMq+ZhBny8b49SxOgGEsblJJDOtq72bksmRKx4FOQX3Rzw+/kjQWhHISWUkDRnp7oCGkoc05c8tmmsrlxjOUsqi7jb8jgISM89lgGDtCDhdmr5Hs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270806; c=relaxed/simple;
	bh=lu1VpTkh4FR0BHokv5InMIMcjOcfFFQgXviWv9LDeZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE+j2iM2Iek12GvEL70AYs7VMUFjtai/uqT3Hk7fZjlhOx3BLCDLshhtlCT6cM72lXzhdAKc73/CR9rEMAAqxmkgU4loXGSuBKxXw1XHZVruMW6qpay+ApcstEvu5qnDpgWobNXH7XLHvwjCXRSVnfopLRDkSfGbkIPbdBE9uwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPUJwa7B; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPUJwa7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773270805; x=1804806805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lu1VpTkh4FR0BHokv5InMIMcjOcfFFQgXviWv9LDeZw=;
  b=FPUJwa7BGPoLo18t6kgc0w/WAN6otmcs7V8pisrPQHWYwLzXRAjFx6gs
   w7xMr0n+81G+eH89YltfUmKYZZ0g+JuEWM+HtVdHbui/iMQ7a36qA3NTJ
   i/yHGlkGU7XxCJarTcp//AGwXADF2NjwGXk0gsb74WEhrLL5xaK0ftWy4
   oHbKfw4yFr0+MXQvNV0lE65iGQDmPWdyve94UIfHC1Ef1kKAqrvUNsfzr
   ZZwIUgL8cLFHpbWmyPwSkJsc3nYDeR9N4WectvmlM5dyOFR+f/2F4jKNx
   kQskAog0L3o0aOhpgE9vD4QFBUXGlTJYZpo3XsF1bQW3a8Rqx3U0sIZUG
   w==;
X-CSE-ConnectionGUID: T30gqjqKQfee3/lJKzO8ug==
X-CSE-MsgGUID: MFgRaPkwQ8KSaweSGnRK8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="91734936"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="91734936"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 16:13:23 -0700
X-CSE-ConnectionGUID: KBENLqCLR/ypuR+Dl2pk7g==
X-CSE-MsgGUID: iEV3TUzjSoeRDtEno4WRoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="243645768"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Mar 2026 16:13:21 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0Sju-000000001nj-2Iv1;
	Wed, 11 Mar 2026 23:13:18 +0000
Date: Thu, 12 Mar 2026 07:13:08 +0800
From: kernel test robot <lkp@intel.com>
To: Jamie Lindsey <jamie@matrixforgelabs.com>,
	rust-for-linux@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, ojeda@kernel.org,
	paul@paul-moore.com, aliceryhl@google.com, jmorris@namei.org,
	serge@hallyn.com, jamie@matrixforgelabs.com
Subject: Re: [PATCH v2 2/5] rust: helpers: add C shims for LSM hook
 initialisation
Message-ID: <202603120739.yWj1J5Hv-lkp@intel.com>
References: <0102019cdb4c6a42-a28bbebb-3664-4792-966f-4036c94ac19c-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102019cdb4c6a42-a28bbebb-3664-4792-966f-4036c94ac19c-000000@eu-west-1.amazonses.com>

Hi Jamie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rust/rust-next]
[also build test WARNING on linus/master v7.0-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jamie-Lindsey/rust-helpers-add-C-shims-for-LSM-hook-initialisation/20260311-131258
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/0102019cdb4c6a42-a28bbebb-3664-4792-966f-4036c94ac19c-000000%40eu-west-1.amazonses.com
patch subject: [PATCH v2 2/5] rust: helpers: add C shims for LSM hook initialisation
config: um-randconfig-002-20260311 (https://download.01.org/0day-ci/archive/20260312/202603120739.yWj1J5Hv-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260312/202603120739.yWj1J5Hv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603120739.yWj1J5Hv-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: rust_helper_security_add_hooks: EXPORT_SYMBOL used for init symbol. Remove __init or EXPORT_SYMBOL.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

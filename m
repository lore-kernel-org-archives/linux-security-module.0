Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0E918BBB0;
	Tue, 31 Dec 2024 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735679028; cv=none; b=G4KYJ0mR30G4Q1Dg8jfn/Tt2+wIuklYiVYrw4KEJ3QfQTRMDjGLRfFJE+3QVPOymC3pDChPJA/xO0bN5TKJNtqyF+0jTaOduTMZRa5EWyoBRu0y5L9eOCzu0g17UDpg42QToRTuQu3mByIEL6/uNSzRdt95poJCUumw41oUIgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735679028; c=relaxed/simple;
	bh=FUwKTnVY4HYxxQ6MSdoUHSg1+VePv0z0vvCf3A7k+YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mwh2hVxsa0O3y2hOiWPTe9TzRJwGG3odyYGSVqMaEQxQT+WSi4MUskeZyPSWa9mr44uVeOPS8F3UuWSxlRkQg7KXLhyY0MMFfK3YbRiKg9P4/hMXiG2rWBy1HRXByHKhAa7S6I7NgEgKDDEzwZ1zD2eterJaS+ui4lBof3/2wZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abs3mLAR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abs3mLAR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735679026; x=1767215026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FUwKTnVY4HYxxQ6MSdoUHSg1+VePv0z0vvCf3A7k+YA=;
  b=abs3mLAR2cAUw7SwzBuHZDXmHXRKirPmOuZZPKvJtS7BSzCpSWeVgvMP
   INyuF0PosZnQNzCKygxe6NfWsR+iNd8+47E9Pbi/o2QAUq9sVnSHdPHsY
   GSgNqz3CpKQwhA1bRsHeT9OhvFCguLLBna9IbvxKdgkQbfNMNqpeogliC
   FTfWYQ4lfAIYaPnuGD4GXG4HnaX2XBCYmcHDZSJvu6vii9cLvjVmJqI8Z
   dP/6yReAMa6X4NPbp7AbD9hr0JYkjzHMjyx6KUAAiVoxD3UD7kJSyb7Ue
   Rk8Xz+RprO8zPqO8rBO/TAokABxzsTCSM5ieI1d+Elg/esruxCaZDINSo
   w==;
X-CSE-ConnectionGUID: Vgsy3iwnS6GwcgsO2NTjeA==
X-CSE-MsgGUID: vcFBEE5ZSfS85/aUEKgXNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="39724469"
X-IronPort-AV: E=Sophos;i="6.12,280,1728975600"; 
   d="scan'208";a="39724469"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 13:03:45 -0800
X-CSE-ConnectionGUID: /BecopT6SZSWmQBV8OOLPg==
X-CSE-MsgGUID: dMTzNUw0QKW4aDrYu3khJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101609784"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 31 Dec 2024 13:03:42 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tSjOu-0007Rb-0K;
	Tue, 31 Dec 2024 21:03:40 +0000
Date: Wed, 1 Jan 2025 05:03:14 +0800
From: kernel test robot <lkp@intel.com>
To: Shervin Oloumi <enlightened@chromium.org>, mic@digikod.net,
	viro@zeniv.linux.org.uk
Cc: oe-kbuild-all@lists.linux.dev, brauner@kernel.org, jack@suse.cz,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	gnoack@google.com, shuah@kernel.org, jorgelo@chromium.org,
	allenwebb@chromium.org, Shervin Oloumi <enlightened@chromium.org>
Subject: Re: [PATCH 2/2] landlock: add support for private bind mount
Message-ID: <202501010450.vIVxrod1-lkp@intel.com>
References: <20241231014632.589049-2-enlightened@chromium.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231014632.589049-2-enlightened@chromium.org>

Hi Shervin,

kernel test robot noticed the following build errors:

[auto build test ERROR on fc033cf25e612e840e545f8d5ad2edd6ba613ed5]

url:    https://github.com/intel-lab-lkp/linux/commits/Shervin-Oloumi/landlock-add-support-for-private-bind-mount/20241231-094806
base:   fc033cf25e612e840e545f8d5ad2edd6ba613ed5
patch link:    https://lore.kernel.org/r/20241231014632.589049-2-enlightened%40chromium.org
patch subject: [PATCH 2/2] landlock: add support for private bind mount
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20250101/202501010450.vIVxrod1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250101/202501010450.vIVxrod1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501010450.vIVxrod1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/init.h:5,
                    from security/landlock/setup.c:9:
>> include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(typeof_member(union access_masks_all, masks)) == sizeof(typeof_member(union access_masks_all, all))"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   security/landlock/ruleset.h:57:1: note: in expansion of macro 'static_assert'
      57 | static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
         | ^~~~~~~~~~~~~


vim +78 include/linux/build_bug.h

bc6245e5efd70c4 Ian Abbott       2017-07-10  60  
6bab69c65013bed Rasmus Villemoes 2019-03-07  61  /**
6bab69c65013bed Rasmus Villemoes 2019-03-07  62   * static_assert - check integer constant expression at build time
6bab69c65013bed Rasmus Villemoes 2019-03-07  63   *
6bab69c65013bed Rasmus Villemoes 2019-03-07  64   * static_assert() is a wrapper for the C11 _Static_assert, with a
6bab69c65013bed Rasmus Villemoes 2019-03-07  65   * little macro magic to make the message optional (defaulting to the
6bab69c65013bed Rasmus Villemoes 2019-03-07  66   * stringification of the tested expression).
6bab69c65013bed Rasmus Villemoes 2019-03-07  67   *
6bab69c65013bed Rasmus Villemoes 2019-03-07  68   * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
6bab69c65013bed Rasmus Villemoes 2019-03-07  69   * scope, but requires the expression to be an integer constant
6bab69c65013bed Rasmus Villemoes 2019-03-07  70   * expression (i.e., it is not enough that __builtin_constant_p() is
6bab69c65013bed Rasmus Villemoes 2019-03-07  71   * true for expr).
6bab69c65013bed Rasmus Villemoes 2019-03-07  72   *
6bab69c65013bed Rasmus Villemoes 2019-03-07  73   * Also note that BUILD_BUG_ON() fails the build if the condition is
6bab69c65013bed Rasmus Villemoes 2019-03-07  74   * true, while static_assert() fails the build if the expression is
6bab69c65013bed Rasmus Villemoes 2019-03-07  75   * false.
6bab69c65013bed Rasmus Villemoes 2019-03-07  76   */
6bab69c65013bed Rasmus Villemoes 2019-03-07  77  #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
6bab69c65013bed Rasmus Villemoes 2019-03-07 @78  #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
6bab69c65013bed Rasmus Villemoes 2019-03-07  79  
07a368b3f55a79d Maxim Levitsky   2022-10-25  80  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

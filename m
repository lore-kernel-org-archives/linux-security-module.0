Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE332C94A;
	Fri, 12 Jun 2026 06:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245061; cv=none; b=dQ5ZyZaTZqFdcuCO50IZzqSwQj45AIBHvoDP6Bu4axy2fu/oM2zsa/wS9s9Z0cVZNUztMCZDwN5bLm9oBycyAl7LGecK3sCKrj4q7H+HuOpv3eAieni8o+QR0wM11NWqx9FaF67J+XJP9O7qq5msCSGEta/DTHm1iliFBOob75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245061; c=relaxed/simple;
	bh=UrUuv+1gy9sm5hjgnZOwk1bV1HIdJUe49L2wujlrtcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxDA4cFECVVwJ6EjZjVXHzhqEEfuuA0AqKqQURbpAdQm2fbZSrfHJCerGHmgjCTKiGLJS771uKQO8+4qsEOM2khEuoh+HWERuFCuVW9y/+dAwzdE+V9FGbHPgYdxfrOX0XNSjg1RDY/jHNM5+KSDGFmCSUV48wDypXFixep7k6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmYwyszG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmYwyszG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781245059; x=1812781059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UrUuv+1gy9sm5hjgnZOwk1bV1HIdJUe49L2wujlrtcA=;
  b=DmYwyszGe7lpKxv9bEO2mwEF32/CmE3S/b3MBADvr+qovY2Dk2Djtp8V
   1xSedHqfXxs1SqjFYdLPLBUzVFK1Sv6exfyzgXBHI1z8ZBpmE0oElSZQK
   f58Bm90GK3tcc2+3Qt7x0pPB5ToHlLx6+bCqWwdLT9OdVOX/E2DZYrxMW
   F/eb7aD94fA7JnZgPr+DwtMOlBWZauexgPhOOdU6Q5/sJypObIWUNicQa
   qZRoKGNum1vOskAMf4gmWuPhNW5M3gElCtCcyVyiKv4VtGNZAZYk13QZJ
   044sn4JdpGqRMbm6iIY3Tj7MSdvBIk+zVy4Ava1IEalATRfMOybCq1Wu+
   w==;
X-CSE-ConnectionGUID: Wn1ooLNZQQ2Bg7uAx/70jw==
X-CSE-MsgGUID: BfeAj1oHSkCH4ZbKr0tkfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82056495"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="82056495"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 23:17:38 -0700
X-CSE-ConnectionGUID: GE3Y+wr0Sgmv9QnKDuU5PA==
X-CSE-MsgGUID: zNSZIJi2SrOZA6OpndBU8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="251685497"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Jun 2026 23:17:35 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXvCu-00000000OOv-3sQV;
	Fri, 12 Jun 2026 06:17:32 +0000
Date: Fri, 12 Jun 2026 14:17:00 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Roberts via B4 Relay <devnull+alex.roberts109.outlook.com@kernel.org>,
	Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Alex Roberts <alex.roberts109@outlook.com>
Subject: Re: [PATCH] Add LoadPin support for eBPF program loading
Message-ID: <202606121426.NrJtdO3K-lkp@intel.com>
References: <20260611-b4-rfc-loadpin-ebpf-v1-1-11a6c8e6170d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-b4-rfc-loadpin-ebpf-v1-1-11a6c8e6170d@outlook.com>

Hi Alex,

kernel test robot noticed the following build errors:

[auto build test ERROR on 122b52f0bab007ebeb414c8280c1def17b9ed1f4]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Roberts-via-B4-Relay/Add-LoadPin-support-for-eBPF-program-loading/20260612-031559
base:   122b52f0bab007ebeb414c8280c1def17b9ed1f4
patch link:    https://lore.kernel.org/r/20260611-b4-rfc-loadpin-ebpf-v1-1-11a6c8e6170d%40outlook.com
patch subject: [PATCH] Add LoadPin support for eBPF program loading
config: nios2-randconfig-002-20260612 (https://download.01.org/0day-ci/archive/20260612/202606121426.NrJtdO3K-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260612/202606121426.NrJtdO3K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606121426.NrJtdO3K-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   security/selinux/hooks.c: In function 'selinux_kernel_read_file':
>> include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_916' declared with attribute error: New kernel_read_file_id introduced; update SELinux!
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:680:25: note: in definition of macro '__compiletime_assert'
     680 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   security/selinux/hooks.c:4412:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
    4412 |         BUILD_BUG_ON_MSG(READING_MAX_ID > 8,
         |         ^~~~~~~~~~~~~~~~
   security/selinux/hooks.c: In function 'selinux_kernel_load_data':
>> include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_917' declared with attribute error: New kernel_load_data_id introduced; update SELinux!
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:680:25: note: in definition of macro '__compiletime_assert'
     680 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   security/selinux/hooks.c:4449:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
    4449 |         BUILD_BUG_ON_MSG(LOADING_MAX_ID > 8,
         |         ^~~~~~~~~~~~~~~~


vim +/__compiletime_assert_916 +699 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  685  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  686  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  687  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  688  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  689  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  690   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  691   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  692   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  693   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  694   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  695   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  696   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  697   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  698  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @699  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  700  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

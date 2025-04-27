Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34279F2;
	Sun, 27 Apr 2025 06:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745733924; cv=none; b=ob0+vUdMO17UAigq/rB/P/3zoza5lTNrQFnqp3xxBqn7eUckkhAr7ctgoy3igk/Bs9u2tjUkE1x2ATr5CgRsEWGkZIP/v3KYSZv5dNYFoJ4N5bteDnA70itGsNDt7151TnLedGW9VcYTS52uHpAmZEF48PCN7PMNt6zOJKglLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745733924; c=relaxed/simple;
	bh=ZldK3+fSlzSjRsOdQzFFyxV4omaUhKTuFH+wBprq+/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/PEc0ihH+gh+JAZMce0H8qeDnxY8Fid4hDkn5T/cNqJcef9lFnfhH+oNw0ypz1Wh+zriBfl8wx8LEO/2nxHXgbxBt/AKPQVAb9wYTI9kQafpoJLH9WkcwecCHTFmXwNaEGrBiitXpGYHEVrVEqWgJMF5jBFAESX5xk7MH1Ys2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHd7jJ3x; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHd7jJ3x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745733922; x=1777269922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZldK3+fSlzSjRsOdQzFFyxV4omaUhKTuFH+wBprq+/w=;
  b=nHd7jJ3xh+vh/iD5R5F5hNAsH5WQshmbLagXe1YxsIvP+t6SZnwEKR6G
   8Fos7BLjm912xG+wf97xi/AhIb2AMZ6rYvh44tlPiuk4Wd2YKrfXDaFBo
   rhLsSZNbt5oHwuMqCTVHZUqBMUyOp84URwdWVwT9I5JWBeZtHRbWgw7PB
   DP4BLguoT7qGJKCHlqVpUL36VzR40JcZ/KuxkZTs37452L1zAXU3fm7g2
   h5dy1DvZcyZntr+OKz40sUPxn9jp1Naqx6cPM/yoKA8DGmxKahdtRqfR2
   iJMOKxbQbazuWV3ZEpJMXbmMudOAZejotyHnQj2Na5S87mcBRaEV6F/Y0
   A==;
X-CSE-ConnectionGUID: uCMwUXDuRZqwCXIccuukyA==
X-CSE-MsgGUID: Gx/hY6jCTdWH9YMEQrx6rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="58706655"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="58706655"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 23:05:22 -0700
X-CSE-ConnectionGUID: QYM4ZrilT4G7I63yKlDDFQ==
X-CSE-MsgGUID: KSzi8iNSQUqg49j/SDdZVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="164295196"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Apr 2025 23:05:16 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8v8b-00068j-2a;
	Sun, 27 Apr 2025 06:05:13 +0000
Date: Sun, 27 Apr 2025 14:04:51 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>, Tamir Duberstein <tamird@gmail.com>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Mark Brown <broonie@kernel.org>, WangYuli <wangyuli@uniontech.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/3] lib/tests: Add randstruct KUnit test
Message-ID: <202504271552.T3fbs0XC-lkp@intel.com>
References: <20250427013836.877214-2-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427013836.877214-2-kees@kernel.org>

Hi Kees,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/hardening]
[also build test WARNING on linus/master v6.15-rc3 next-20250424]
[cannot apply to akpm-mm/mm-nonmm-unstable soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/randstruct-gcc-plugin-Remove-bogus-void-member/20250427-093946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/20250427013836.877214-2-kees%40kernel.org
patch subject: [PATCH 2/3] lib/tests: Add randstruct KUnit test
config: powerpc64-randconfig-002-20250427 (https://download.01.org/0day-ci/archive/20250427/202504271552.T3fbs0XC-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250427/202504271552.T3fbs0XC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504271552.T3fbs0XC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/tests/randstruct_kunit.c:36:36: warning: '_Static_assert' with no message is a C2x extension [-Wc2x-extensions]
      36 | _Static_assert(MEMBER_NAME_MAX == 8);
         |                                    ^
         |                                    , ""
   1 warning generated.


vim +/_Static_assert +36 lib/tests/randstruct_kunit.c

    19	
    20	#define DO_MANY_MEMBERS(macro, args...)	\
    21		macro(a, args)			\
    22		macro(b, args)			\
    23		macro(c, args)			\
    24		macro(d, args)			\
    25		macro(e, args)			\
    26		macro(f, args)			\
    27		macro(g, args)			\
    28		macro(h, args)
    29	
    30	#define do_enum(x, ignored)	MEMBER_NAME_ ## x,
    31	enum randstruct_member_names {
    32		DO_MANY_MEMBERS(do_enum)
    33		MEMBER_NAME_MAX,
    34	};
    35	/* Make sure the macros are working: want 8 test members. */
  > 36	_Static_assert(MEMBER_NAME_MAX == 8);
    37	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

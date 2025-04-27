Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD8D1F153C;
	Sun, 27 Apr 2025 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745725694; cv=none; b=QqqFBsacDLLW8IubU6m3BltGL9rqPpCjy8Ne9TRrNvPEzc/aVfFZ65r5xRQnwnK/OKcyev/uvcP6XPv5YWTw/QZ1mHAEp/8ZShWOZcbjs0uGt2Q9hVOpdCdnEpmxWbNpngok7dXd0AKpR80byTUl7h2fvWY8WbEHruanDNAxrtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745725694; c=relaxed/simple;
	bh=lBmXeDlzn316KuvU6HlwzsHEiQoDo8E+Wv2X6jtZfIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9/IXTC0d3ZfTJd/oDSjAVEnqI0X2KmS6tHd9y+XFGClurHyRFzv+XyE9XY7/g9cymiQxH7C+duWwm5oQz6+PoUvTdejz+HGkpZqo1L1fR/DyyFoDV9guS3PwLor7qUHfCaIg7nUOVTLC+r9xUxExKm9AF1kFdRqV+4XYTcHr5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IN4c6iB+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IN4c6iB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745725693; x=1777261693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lBmXeDlzn316KuvU6HlwzsHEiQoDo8E+Wv2X6jtZfIA=;
  b=IN4c6iB+jWYfPGmdGQR0pNiudB6sYN7cNvXt8K0pKx/vdujwxPzEJhpV
   M4mQ2hYY2fYNjTb++0zHajg58yg2G4bZ/S3wH0bFHfD977h3GpaRCGp0N
   ESm7sfy1GVMH+SiJdI2nL+QCmQq/772r5BJFgfbYQVaDjuS9V0WbV6OGk
   r3X9l33gSmLQLbN9XvfdjD1qQpnOb/TwkanqYCUTTsZJziiSiZGKXRgT7
   I0zqs24QDo1a/9aSKtz98pDzJu36BU7f9QmvRI2gFqxpbbpWlKGXse9VI
   +OzYQ9cZEWr/uC/dqqXVHoWuzbSdEybXFQJObI1b5E2jvFo+oZCPV6iOE
   w==;
X-CSE-ConnectionGUID: Sgn1t+mgTJ6eVAeP7PffQQ==
X-CSE-MsgGUID: OFdjn7t8Q5G8Y1uaTxXlTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="49991474"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="49991474"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 20:48:12 -0700
X-CSE-ConnectionGUID: 3y2kNYXWQNiosUNwxBgi+Q==
X-CSE-MsgGUID: DWG7E8X3T2OVC9Ghu5xJJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="164278800"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Apr 2025 20:48:06 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8szs-00066H-0Z;
	Sun, 27 Apr 2025 03:48:04 +0000
Date: Sun, 27 Apr 2025 11:47:18 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, Kees Cook <kees@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>, Tamir Duberstein <tamird@gmail.com>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>, llvm@lists.linux.dev,
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
Message-ID: <202504271124.gDNKq7ZN-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/hardening]
[also build test ERROR on linus/master v6.15-rc3 next-20250424]
[cannot apply to akpm-mm/mm-nonmm-unstable soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/randstruct-gcc-plugin-Remove-bogus-void-member/20250427-093946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/20250427013836.877214-2-kees%40kernel.org
patch subject: [PATCH 2/3] lib/tests: Add randstruct KUnit test
config: s390-randconfig-002-20250427 (https://download.01.org/0day-ci/archive/20250427/202504271124.gDNKq7ZN-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250427/202504271124.gDNKq7ZN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504271124.gDNKq7ZN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/tests/randstruct_kunit.c:36:36: error: expected ',' before ')' token
    _Static_assert(MEMBER_NAME_MAX == 8);
                                       ^
                                       ,
   cc1: warning: unrecognized command line option '-Wno-unterminated-string-initialization'


vim +36 lib/tests/randstruct_kunit.c

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

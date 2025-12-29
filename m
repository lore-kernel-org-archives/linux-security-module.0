Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0869C2B9B9;
	Mon, 29 Dec 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016631; cv=none; b=osP45l+wbWjZErjx//YPVOBDRmIaMg6D0MtQzr2E4YTw1rpnXKG+vRus/NfgiYxIOTraSudJjg8cQ12sDqDudCLEF0IEgBx60pgOb60DR+tC2j50ACIIg1sGYEkZBA0cRdRf9accRWM48VGNLJ50JMz1QUSoJiWnXKOeZH78Y5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016631; c=relaxed/simple;
	bh=5QOQ0tMzetOqYgx3rFaw3xk+KGNbbRVip63qsJkiNM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTY3ShIcpFUDbkU+FuFvSaOzRscXy41Piv/fkA5zM6xIk8MNiZmG9S2rfd+/ydyCJm+EYEUCGPsOL0HsD9QU2Nt6aeCg+496PI+o76PCTfpBcFmrROX5zBQOy9Hwb2RXRhL6RJaGpSQaGgnUTnRyYNybegOoNqKKPAyNyHz9d0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BC9OiSDI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BC9OiSDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767016630; x=1798552630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5QOQ0tMzetOqYgx3rFaw3xk+KGNbbRVip63qsJkiNM8=;
  b=BC9OiSDIaH/5YlVGWNtVaRgVn3Hd5WVB412ATC+epL5QzTlnYNCPueMe
   OzYIZwdk5hQ0ClDI/PJJnI7HK55mJdX15/gaZ9VaiTfJH39h1+pMq26Gr
   4/tdr7EqbtzQpIVSK7bnnmHYXY1fEtib/oFB23wteuG4Ui9UWCE5o0LYG
   +PzD3uOB4r8kgLar+Iz7QIxL1ZUJPeK6XcuTlYaw2G+lO472DlV6tIqR6
   bPSKyMA19sVqplzq8ucUvqnWRvIFoNERWpoItPAx+piY8sg3/jFr9wQUH
   X1ymrQn4jU6BUETbeO/WvHaHVx8KuwI8gR9QRA3hP1Sin+DXW4bWP1wKC
   g==;
X-CSE-ConnectionGUID: kKEQn0JhRQme7Q7yVrrYtg==
X-CSE-MsgGUID: mBJ/DPX+TaSbllK7dkCI6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="71208500"
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="71208500"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 05:57:09 -0800
X-CSE-ConnectionGUID: DB/kz/r2RYuyqzk7mZkNrg==
X-CSE-MsgGUID: PtD6w8jUSs6zqi+uIhaZYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="200547858"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 29 Dec 2025 05:57:07 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vaDk1-000000007GT-2x6e;
	Mon, 29 Dec 2025 13:57:00 +0000
Date: Mon, 29 Dec 2025 21:56:34 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Foster <foster.ryan.r@gmail.com>,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, serge@hallyn.com,
	Ryan Foster <foster.ryan.r@gmail.com>
Subject: Re: [PATCH v4] security: Add KUnit tests for kuid_root_in_ns and
 vfsuid_root_in_currentns
Message-ID: <202512292101.U530Lg4A-lkp@intel.com>
References: <20251228194838.32214-2-foster.ryan.r@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251228194838.32214-2-foster.ryan.r@gmail.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on pcmoore-selinux/next]
[also build test ERROR on linus/master v6.19-rc3 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Foster/security-Add-KUnit-tests-for-kuid_root_in_ns-and-vfsuid_root_in_currentns/20251229-035056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20251228194838.32214-2-foster.ryan.r%40gmail.com
patch subject: [PATCH v4] security: Add KUnit tests for kuid_root_in_ns and vfsuid_root_in_currentns
config: i386-randconfig-011-20251229 (https://download.01.org/0day-ci/archive/20251229/202512292101.U530Lg4A-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251229/202512292101.U530Lg4A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512292101.U530Lg4A-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: security/commoncap.o: in function `kunit_kmalloc':
>> include/kunit/test.h:501:(.text+0xb59): undefined reference to `kunit_kmalloc_array'
   ld: security/commoncap.o: in function `test_kuid_root_in_ns_init_ns_nonzero':
>> security/commoncap_test.c:121:(.text+0x109c): undefined reference to `kunit_unary_assert_format'
>> ld: security/commoncap_test.c:121:(.text+0x10aa): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap.o: in function `test_kuid_root_in_ns_init_ns_uid0':
   security/commoncap_test.c:101:(.text+0x1101): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:101:(.text+0x110f): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap.o: in function `test_vfsuid_root_in_currentns_nonzero':
   security/commoncap_test.c:80:(.text+0x14aa): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:80:(.text+0x14b8): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap.o: in function `test_vfsuid_root_in_currentns_init_ns':
   security/commoncap_test.c:42:(.text+0x1544): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:42:(.text+0x1552): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap.o: in function `test_kuid_root_in_ns_with_mapping':
   security/commoncap_test.c:219:(.text+0x166a): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:219:(.text+0x1678): undefined reference to `__kunit_do_failed_assertion'
>> ld: security/commoncap_test.c:220:(.text+0x16ca): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:220:(.text+0x16d8): undefined reference to `__kunit_do_failed_assertion'
>> ld: security/commoncap_test.c:210:(.text+0x16f8): undefined reference to `kunit_ptr_not_err_assert_format'
   ld: security/commoncap_test.c:210:(.text+0x1706): undefined reference to `__kunit_do_failed_assertion'
>> ld: security/commoncap_test.c:210:(.text+0x170d): undefined reference to `__kunit_abort'
   ld: security/commoncap_test.c:213:(.text+0x172c): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:213:(.text+0x173a): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap_test.c:216:(.text+0x175c): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:216:(.text+0x176a): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap.o: in function `test_kuid_root_in_ns_with_different_mappings':
   security/commoncap_test.c:254:(.text+0x18fa): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:254:(.text+0x1908): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap_test.c:259:(.text+0x19da): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:259:(.text+0x19e8): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap_test.c:267:(.text+0x1af2): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:267:(.text+0x1b00): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap_test.c:241:(.text+0x1b20): undefined reference to `kunit_ptr_not_err_assert_format'
   ld: security/commoncap_test.c:241:(.text+0x1b2e): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap_test.c:241:(.text+0x1b35): undefined reference to `__kunit_abort'
   ld: security/commoncap_test.c:245:(.text+0x1b50): undefined reference to `kunit_ptr_not_err_assert_format'
   ld: security/commoncap_test.c:245:(.text+0x1b61): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap_test.c:245:(.text+0x1b68): undefined reference to `__kunit_abort'
   ld: security/commoncap_test.c:249:(.text+0x1b80): undefined reference to `kunit_ptr_not_err_assert_format'
   ld: security/commoncap_test.c:249:(.text+0x1b8e): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap_test.c:249:(.text+0x1b95): undefined reference to `__kunit_abort'
   ld: security/commoncap_test.c:252:(.text+0x1bb4): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:252:(.text+0x1bc5): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap_test.c:266:(.text+0x1bec): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:266:(.text+0x1bfa): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap_test.c:265:(.text+0x1c1c): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:265:(.text+0x1c2a): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap_test.c:264:(.text+0x1c4c): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:264:(.text+0x1c5a): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap_test.c:253:(.text+0x1c7c): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:253:(.text+0x1c8d): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap_test.c:258:(.text+0x1cb4): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:258:(.text+0x1cc2): undefined reference to `__kunit_do_failed_assertion'
   ld: security/commoncap_test.c:257:(.text+0x1ce4): undefined reference to `kunit_unary_assert_format'
   ld: security/commoncap_test.c:257:(.text+0x1cf2): undefined reference to `__kunit_do_failed_assertion'


vim +501 include/kunit/test.h

7122debb4367ee Daniel Latypov  2021-05-03  487  
7122debb4367ee Daniel Latypov  2021-05-03  488  /**
7122debb4367ee Daniel Latypov  2021-05-03  489   * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
7122debb4367ee Daniel Latypov  2021-05-03  490   * @test: The test context object.
7122debb4367ee Daniel Latypov  2021-05-03  491   * @size: The size in bytes of the desired memory.
7122debb4367ee Daniel Latypov  2021-05-03  492   * @gfp: flags passed to underlying kmalloc().
7122debb4367ee Daniel Latypov  2021-05-03  493   *
7122debb4367ee Daniel Latypov  2021-05-03  494   * See kmalloc() and kunit_kmalloc_array() for more information.
57e3cded99e9c8 David Gow       2023-05-25  495   *
57e3cded99e9c8 David Gow       2023-05-25  496   * Note that some internal context data is also allocated with GFP_KERNEL,
57e3cded99e9c8 David Gow       2023-05-25  497   * regardless of the gfp passed in.
7122debb4367ee Daniel Latypov  2021-05-03  498   */
7122debb4367ee Daniel Latypov  2021-05-03  499  static inline void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
7122debb4367ee Daniel Latypov  2021-05-03  500  {
7122debb4367ee Daniel Latypov  2021-05-03 @501  	return kunit_kmalloc_array(test, 1, size, gfp);
7122debb4367ee Daniel Latypov  2021-05-03  502  }
0a756853586ce1 Brendan Higgins 2019-09-23  503  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

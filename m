Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3B330D35;
	Mon, 29 Dec 2025 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033325; cv=none; b=VW+LL2oBieZvNjijW93wBFGhgKh4IVzR5aWsbbNWvrUsZi59gPj5yWf/tkH7c1yF3Yw3ef8G1QLqs2SonCO+AlGRPZQu0QsAw2J9xjG6iqPbK8gDVA9j2IlZM8AxKcQE9ej275AP0loVmOw9YZJwp49LkMV4B1Z5hIFJOJc3raw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033325; c=relaxed/simple;
	bh=ZgCT2xZJ+03QLzvNojY+TrqaWJjvvHFrRZmcQ5OqM+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6JyMi+GMX2Ue/d3wo8wVazW8Ptij2R6R8wtk35fARiV820fRTGSyLPwBW+O+bjdG8SKtYsbvq0NW55I6GXYlcMLGlZjg6e3H4K6qyMvrcxOk7epeT3om8qnRR77ONUuzXT/opcTL6du2Yv1nLFcr/bNEH9RBjG8SUyzfnn1hNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMg/dyra; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMg/dyra"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767033322; x=1798569322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZgCT2xZJ+03QLzvNojY+TrqaWJjvvHFrRZmcQ5OqM+4=;
  b=HMg/dyrax/vkd+MKWEIVOTJjVw7CZjvLEkmOkMpEt0xB3P7wuJeK+Ag4
   YjJ/h4hlPT0PJXEH8gCNXcZ/5WRIN2k5CtGzRxLgnaGG8R42sSx6Mj4Yf
   +QkOa1g7eDFdzWwuRkeJLc/3+IEufmBq4YNca3RXHE58B4c8wE88H+5Pw
   KBgBjRvLTppzqWPN9+A3p2QiJXedmNiCR3zTP/EBuIJZ+aADVjBMEFxYX
   ZYS3W55djzmGTgSKnGJA21Pt+X7DSXDvOexAz9ac76e1BRoHhq3iX8wno
   7XEJAmjcUeytncbIdjDKsSBdMXCmMAL/WlfqFMqZSAZ+NcxBi0IQgnzN1
   A==;
X-CSE-ConnectionGUID: ijwzdIuRR9C13qr62AtTAQ==
X-CSE-MsgGUID: H5VK4Rw/S36xmF2Q47xV9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="78946386"
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="78946386"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 10:35:22 -0800
X-CSE-ConnectionGUID: 6ShMmTK5T9SvjGBff0tYsA==
X-CSE-MsgGUID: aU3o33YQRnORt0Y0XRYFGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="200946841"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 29 Dec 2025 10:35:19 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vaI5N-000000007u1-1WfJ;
	Mon, 29 Dec 2025 18:35:17 +0000
Date: Tue, 30 Dec 2025 02:35:04 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Foster <foster.ryan.r@gmail.com>,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, serge@hallyn.com,
	Ryan Foster <foster.ryan.r@gmail.com>
Subject: Re: [PATCH v4] security: Add KUnit tests for kuid_root_in_ns and
 vfsuid_root_in_currentns
Message-ID: <202512292252.1PPODroH-lkp@intel.com>
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
[also build test ERROR on linus/master v6.19-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Foster/security-Add-KUnit-tests-for-kuid_root_in_ns-and-vfsuid_root_in_currentns/20251229-035056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20251228194838.32214-2-foster.ryan.r%40gmail.com
patch subject: [PATCH v4] security: Add KUnit tests for kuid_root_in_ns and vfsuid_root_in_currentns
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20251229/202512292252.1PPODroH-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251229/202512292252.1PPODroH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512292252.1PPODroH-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: security/commoncap.o: in function `create_test_user_ns_with_mapping':
   commoncap.c:(.text+0xa3c): undefined reference to `kunit_kmalloc_array'
>> commoncap.c:(.text+0xa3c): relocation truncated to fit: R_NIOS2_CALL26 against `kunit_kmalloc_array'
   nios2-linux-ld: security/commoncap.o: in function `test_kuid_root_in_ns_init_ns_uid0':
>> commoncap.c:(.text+0x1020): undefined reference to `kunit_unary_assert_format'
>> nios2-linux-ld: commoncap.c:(.text+0x102c): undefined reference to `kunit_unary_assert_format'
>> nios2-linux-ld: commoncap.c:(.text+0x1058): undefined reference to `__kunit_do_failed_assertion'
>> commoncap.c:(.text+0x1058): relocation truncated to fit: R_NIOS2_CALL26 against `__kunit_do_failed_assertion'
   nios2-linux-ld: security/commoncap.o: in function `test_kuid_root_in_ns_init_ns_nonzero':
   commoncap.c:(.text+0x10bc): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x10c4): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x10f0): undefined reference to `__kunit_do_failed_assertion'
   commoncap.c:(.text+0x10f0): relocation truncated to fit: R_NIOS2_CALL26 against `__kunit_do_failed_assertion'
   nios2-linux-ld: security/commoncap.o: in function `test_vfsuid_root_in_currentns_nonzero':
   commoncap.c:(.text+0x14c8): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x14d0): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x14fc): undefined reference to `__kunit_do_failed_assertion'
   commoncap.c:(.text+0x14fc): relocation truncated to fit: R_NIOS2_CALL26 against `__kunit_do_failed_assertion'
   nios2-linux-ld: security/commoncap.o: in function `test_vfsuid_root_in_currentns_init_ns':
   commoncap.c:(.text+0x1594): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x15a0): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x15cc): undefined reference to `__kunit_do_failed_assertion'
   commoncap.c:(.text+0x15cc): relocation truncated to fit: R_NIOS2_CALL26 against `__kunit_do_failed_assertion'
   nios2-linux-ld: security/commoncap.o: in function `test_kuid_root_in_ns_with_mapping':
   commoncap.c:(.text+0x170c): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1710): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1740): undefined reference to `__kunit_do_failed_assertion'
   commoncap.c:(.text+0x1740): relocation truncated to fit: R_NIOS2_CALL26 against `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1748): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x174c): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x177c): undefined reference to `__kunit_do_failed_assertion'
   commoncap.c:(.text+0x177c): relocation truncated to fit: R_NIOS2_CALL26 against `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1784): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x178c): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x17bc): undefined reference to `__kunit_do_failed_assertion'
   commoncap.c:(.text+0x17bc): relocation truncated to fit: R_NIOS2_CALL26 against `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x17c4): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x17cc): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x17fc): undefined reference to `__kunit_do_failed_assertion'
   commoncap.c:(.text+0x17fc): relocation truncated to fit: R_NIOS2_CALL26 against `__kunit_do_failed_assertion'
>> nios2-linux-ld: commoncap.c:(.text+0x1820): undefined reference to `kunit_ptr_not_err_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1824): undefined reference to `kunit_ptr_not_err_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1854): undefined reference to `__kunit_do_failed_assertion'
   commoncap.c:(.text+0x1854): relocation truncated to fit: R_NIOS2_CALL26 against `__kunit_do_failed_assertion'
>> nios2-linux-ld: commoncap.c:(.text+0x185c): undefined reference to `__kunit_abort'
   commoncap.c:(.text+0x185c): additional relocation overflows omitted from the output
   nios2-linux-ld: security/commoncap.o: in function `test_kuid_root_in_ns_with_different_mappings':
   commoncap.c:(.text+0x1aec): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1af0): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1b20): undefined reference to `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1b28): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1b30): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1b60): undefined reference to `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1b68): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1b70): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1ba0): undefined reference to `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1ba8): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1bb0): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1be0): undefined reference to `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1be8): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1bec): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1c1c): undefined reference to `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1c24): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1c2c): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1c5c): undefined reference to `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1c64): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1c6c): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1c9c): undefined reference to `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1ca4): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1ca8): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1cd8): undefined reference to `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1ce0): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1ce8): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1d18): undefined reference to `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1d20): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1d28): undefined reference to `kunit_unary_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1d58): undefined reference to `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1d60): undefined reference to `kunit_ptr_not_err_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1d64): undefined reference to `kunit_ptr_not_err_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1d94): undefined reference to `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1d9c): undefined reference to `__kunit_abort'
   nios2-linux-ld: commoncap.c:(.text+0x1dbc): undefined reference to `kunit_ptr_not_err_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1dc0): undefined reference to `kunit_ptr_not_err_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1df0): undefined reference to `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1df8): undefined reference to `__kunit_abort'
   nios2-linux-ld: commoncap.c:(.text+0x1e50): undefined reference to `kunit_ptr_not_err_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1e54): undefined reference to `kunit_ptr_not_err_assert_format'
   nios2-linux-ld: commoncap.c:(.text+0x1e84): undefined reference to `__kunit_do_failed_assertion'
   nios2-linux-ld: commoncap.c:(.text+0x1e8c): undefined reference to `__kunit_abort'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

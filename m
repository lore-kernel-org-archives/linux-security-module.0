Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C351D63D2;
	Sun,  2 Feb 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738494701; cv=none; b=p+QfDG9tNXjeZ1EYh8uwtFnN2B196IWHNpOiBV0jNMt4kv7HMpXfeUtGYSzOLbmcpo2Q+ToFbLsBUS2cCtymdIIX70YPWPfH6/M5qKugjzRwqSkcyjaeyMy8HFHzaIfNBJx066FdchPEWAg+RHDhMabSKbURL1OSMr4Uk91jPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738494701; c=relaxed/simple;
	bh=jz3MqgGH5E5HKEsnRKw2zBT4wqE3A51XYO9CnVtLyy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0Yq61HrkKV+CmFpfsloZHXdHxQH16+i/Bq5JBlI0tzDGlTCzyKAn+DOUOPsWuKhPE386unufE+B45jZQaDcdUnm09deZZrxy1/aP9ey97esQhiBgh+jjby3Q0VBuLwTm7PazJtr5EqVD91f/JHAIhB7cuj0+mPfQ8qakx1sOWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ug7MiW4r; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ug7MiW4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738494698; x=1770030698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jz3MqgGH5E5HKEsnRKw2zBT4wqE3A51XYO9CnVtLyy0=;
  b=Ug7MiW4r8xzqm2q1ORyarsLVyyZXhPOyeCg65vOPsm2+lRfD1njjMmp+
   464nV4KNFwojaVUj3IakTvFT2xpuE6X8z1KPIQV7hBxH4Yj1lphZWr9Uu
   EBZlwvwGfsJLsTnzbBUJnzKRvHJjBiBaeoByPpy/oLgC46MYGUIOVIP7c
   faeizCO9/k4ixeLTCYxWyhCuac/f+KVV7VYoRzQfcVtbV2CTmZxZWs8/z
   1mV3tfnraCQ2jxoLeAACQiLlmWpgzdHl8/lTxYJpThqTR6vbFaaXv76y8
   CmBTYUwDC9FYPlgGZhkF8zucyucoclONpOqpwB+B2YX0YqPOdJ4er1wjo
   g==;
X-CSE-ConnectionGUID: QiSvMv8JTMWdOvU2MEjeUQ==
X-CSE-MsgGUID: TrqME7ZRSBuOz5yIravqOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11333"; a="49663963"
X-IronPort-AV: E=Sophos;i="6.13,253,1732608000"; 
   d="scan'208";a="49663963"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2025 03:11:38 -0800
X-CSE-ConnectionGUID: AiCiN+YdRe69qT+ilPyNUQ==
X-CSE-MsgGUID: fvqwam5BT6ORCsDBQpOHDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110478693"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 02 Feb 2025 03:11:35 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1teXsy-000pbT-1m;
	Sun, 02 Feb 2025 11:11:32 +0000
Date: Sun, 2 Feb 2025 19:10:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ricardo B. Marliere" <rbm@suse.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 2/2] LoadPin: Make sysctl table const
Message-ID: <202502021853.d0nqHvPc-lkp@intel.com>
References: <20250123-sysctl-kees-v1-2-533359e74d66@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123-sysctl-kees-v1-2-533359e74d66@suse.com>

Hi Ricardo,

kernel test robot noticed the following build errors:

[auto build test ERROR on a9a5e0bdc5a77a7c662ad4be0ad661f0b0d5e99d]

url:    https://github.com/intel-lab-lkp/linux/commits/Ricardo-B-Marliere/yama-Make-sysctl-table-const/20250124-033808
base:   a9a5e0bdc5a77a7c662ad4be0ad661f0b0d5e99d
patch link:    https://lore.kernel.org/r/20250123-sysctl-kees-v1-2-533359e74d66%40suse.com
patch subject: [PATCH 2/2] LoadPin: Make sysctl table const
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20250202/202502021853.d0nqHvPc-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250202/202502021853.d0nqHvPc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502021853.d0nqHvPc-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/loadpin/loadpin.c:75:34: error: cannot assign to variable 'loadpin_sysctl_table' with const-qualified type 'const struct ctl_table[1]'
      75 |                 loadpin_sysctl_table[0].extra1 = SYSCTL_ZERO;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   security/loadpin/loadpin.c:56:31: note: variable 'loadpin_sysctl_table' declared const here
      56 | static const struct ctl_table loadpin_sysctl_table[] = {
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
      57 |         {
         |         ~
      58 |                 .procname       = "enforce",
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      59 |                 .data           = &enforce,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
      60 |                 .maxlen         = sizeof(int),
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      61 |                 .mode           = 0644,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~
      62 |                 .proc_handler   = proc_dointvec_minmax,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      63 |                 .extra1         = SYSCTL_ONE,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      64 |                 .extra2         = SYSCTL_ONE,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      65 |         },
         |         ~~
      66 | };
         | ~
   security/loadpin/loadpin.c:77:34: error: cannot assign to variable 'loadpin_sysctl_table' with const-qualified type 'const struct ctl_table[1]'
      77 |                 loadpin_sysctl_table[0].extra1 = SYSCTL_ONE;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   security/loadpin/loadpin.c:56:31: note: variable 'loadpin_sysctl_table' declared const here
      56 | static const struct ctl_table loadpin_sysctl_table[] = {
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
      57 |         {
         |         ~
      58 |                 .procname       = "enforce",
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      59 |                 .data           = &enforce,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
      60 |                 .maxlen         = sizeof(int),
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      61 |                 .mode           = 0644,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~
      62 |                 .proc_handler   = proc_dointvec_minmax,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      63 |                 .extra1         = SYSCTL_ONE,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      64 |                 .extra2         = SYSCTL_ONE,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      65 |         },
         |         ~~
      66 | };
         | ~
   2 errors generated.


vim +75 security/loadpin/loadpin.c

9b091556a073a9 Kees Cook 2016-04-20  67  
60ba1028fc7b73 Kees Cook 2022-12-09  68  static void set_sysctl(bool is_writable)
9b091556a073a9 Kees Cook 2016-04-20  69  {
9b091556a073a9 Kees Cook 2016-04-20  70  	/*
9b091556a073a9 Kees Cook 2016-04-20  71  	 * If load pinning is not enforced via a read-only block
9b091556a073a9 Kees Cook 2016-04-20  72  	 * device, allow sysctl to change modes for testing.
9b091556a073a9 Kees Cook 2016-04-20  73  	 */
60ba1028fc7b73 Kees Cook 2022-12-09  74  	if (is_writable)
60ba1028fc7b73 Kees Cook 2022-12-09 @75  		loadpin_sysctl_table[0].extra1 = SYSCTL_ZERO;
60ba1028fc7b73 Kees Cook 2022-12-09  76  	else
60ba1028fc7b73 Kees Cook 2022-12-09  77  		loadpin_sysctl_table[0].extra1 = SYSCTL_ONE;
60ba1028fc7b73 Kees Cook 2022-12-09  78  }
60ba1028fc7b73 Kees Cook 2022-12-09  79  #else
60ba1028fc7b73 Kees Cook 2022-12-09  80  static inline void set_sysctl(bool is_writable) { }
60ba1028fc7b73 Kees Cook 2022-12-09  81  #endif
60ba1028fc7b73 Kees Cook 2022-12-09  82  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

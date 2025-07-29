Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31D1B412A;
	Tue, 29 Jul 2025 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774254; cv=none; b=SsEt/d7UGRFwEN5zmgZF4FBGWILlKao8mhGh1vOXppB/AAZDv3hGa346zNX3JxpYR9Me3c4eViZX3f7vWB32VjL98pS6n3vkYZfmcYX7DJRWbGMgeKlthkeSPCdl067h+g7w9daaVRincU8tGhHfdwJsKUP3jqW5/aFg1cJdb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774254; c=relaxed/simple;
	bh=lUhap1EjQHUB+qogjc7azCKG++yvozXP/Rs6ISomUxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPp+DUpJ1HPqPyjPwEnf/IxGpJlvoJXhlSw41zKZKLHrW52NGskapPlSzDx7mmpcrjLK5hpUswdWMEE1MHIerFo2G4TBXzzny1lyVRD3xzGIFTKuJdyBZx+DuJ/Ay7+s979bdAeL2mo5m4J23u6QXp405bwML6jo9wWGwiDlbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYpHpmfE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYpHpmfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753774253; x=1785310253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lUhap1EjQHUB+qogjc7azCKG++yvozXP/Rs6ISomUxY=;
  b=VYpHpmfE+jNS7RqM7Jw1skI3Cs6Tgek2LImFoFZliup2StzAniKu5Geo
   cpaawqvYg5ZmRgZF5cabcXH8gmczcPI3Sl2KH+pqIV8wK2+W8qJYNm/th
   YIHPX2MWiJIpWOl7xg6NmOsaE6xGeCQImZ6lq64byCZNYfxekbV8U3+Zh
   DE8wRmxSDOsKpdGsuU4PQPbR96b8bnJUXNnROD0/pS8A1PYh5/gHfDjcK
   ghlM0S8y7cCuhcIsLjXiKnO3pvmJP2brhlMK2QNveqi/BDsDtQsgeU++k
   mNzPhqvHRuyNFyGc7X4X6ihzjxWvPwdG8BmMCeksiEZKgTwYyYE3WvmAu
   Q==;
X-CSE-ConnectionGUID: eLAgfC7BR4Gu3RTKuYgJoA==
X-CSE-MsgGUID: KQAXVqGxQbWWaKzPTWs2WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55972153"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="55972153"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 00:30:52 -0700
X-CSE-ConnectionGUID: p2ftCgCOSTeYFQQAfJfzWA==
X-CSE-MsgGUID: XqI/ZmteQXy4E8WlMJVolw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="162666154"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 29 Jul 2025 00:30:49 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugenP-00015X-25;
	Tue, 29 Jul 2025 07:30:47 +0000
Date: Tue, 29 Jul 2025 15:30:26 +0800
From: kernel test robot <lkp@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, serge@hallyn.com, jmorris@namei.org,
	dan.j.williams@intel.com, Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH v2 2/3] lockdown/kunit: Introduce kunit tests
Message-ID: <202507291419.PQ4uKtRo-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.16 next-20250728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikolay-Borisov/lockdown-Switch-implementation-to-using-bitmap/20250728-191807
base:   linus/master
patch link:    https://lore.kernel.org/r/20250728111517.134116-3-nik.borisov%40suse.com
patch subject: [PATCH v2 2/3] lockdown/kunit: Introduce kunit tests
config: i386-randconfig-004-20250729 (https://download.01.org/0day-ci/archive/20250729/202507291419.PQ4uKtRo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507291419.PQ4uKtRo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507291419.PQ4uKtRo-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in security/lockdown/lockdown_test.o
>> ERROR: modpost: "lock_kernel_down" [security/lockdown/lockdown_test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A8422258C;
	Fri, 14 Nov 2025 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763162215; cv=none; b=YgF4KmvQlcFuGaQRzUtbslOB4azjcIcXIog6ofbcZR18s99H0hhhZa+rllUlXaf9OjYeiHcFT4KKOF88qK/1o9B1YXzzOK5kou8kQgM7CAQ0nQu0+FRg8U58YMCbgZcWlRhjzaHUxIC67oTwmLTPWrNoms3blPrv05rFBs/KpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763162215; c=relaxed/simple;
	bh=F2EHZ+hqE6nsl4ZciNXIieERQa/Lr/R0Qft+DEhqscQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih/Z3lpfEMaMMyh1Nuf/QIZoq3BN18AddD3UgSghrTtUK+b/BQHQ5ZQJLJveQPD/JkcC+BG45umQzQ1CEv8b3R1l5c+ojl7XdteU8xmBP17bK8Ewf+mV/ScKWUwOBReM6/0XGe+HPCtXu6X/J0BzIfAeh8BsxppmIbAH8bEq1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4yJggPg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4yJggPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763162214; x=1794698214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F2EHZ+hqE6nsl4ZciNXIieERQa/Lr/R0Qft+DEhqscQ=;
  b=P4yJggPgkWxe2aFKj7Mbw0iu4DKOnpBBpb8YY8B7WYYv7Bb8KGRgfv51
   zBFFoMmLHndHEcyiZkjAdGiw2jgue3mKwfqTQBXcEQXTBTu9rgbqn+5yQ
   2f4N07wYliiwVKPdtdsA4EOSHuw9oqxCMEwjSJAK9UELY+f9UYythdChi
   yskmsmHnBg88djO45vPOTvei2L+5dsgHrCQ6A1M/AKFuxfAlTLYkMbBPb
   BGswKRBNYFygrMltjbUm4VK3mFJl0ZMx9eoKD/MaQ7K91hYmlidmlQiX9
   hbv9Y7ONzGZukdXh/MhDkeVDnA55cigg//nMtjAvWLxmU7OJpQtPXxF5H
   A==;
X-CSE-ConnectionGUID: IMkJ1OW8QO6kgS148QvDJQ==
X-CSE-MsgGUID: 6fBSKEyrSDecRMTFCZWvMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65198286"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65198286"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 15:16:49 -0800
X-CSE-ConnectionGUID: wnDs+MomQ6mPtKT9sniHwQ==
X-CSE-MsgGUID: 40I+XVvLSkioWmu5KbzDRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="220774355"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Nov 2025 15:16:45 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vK322-0007Pz-39;
	Fri, 14 Nov 2025 23:16:42 +0000
Date: Sat, 15 Nov 2025 07:16:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Serge E. Hallyn" <serge@hallyn.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Clarify the rootid_owns_currentns
Message-ID: <202511150644.EXaXOsVc-lkp@intel.com>
References: <aRegH8P4cPlzzlX9@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRegH8P4cPlzzlX9@mail.hallyn.com>

Hi Serge,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on brauner-vfs/vfs.all v6.18-rc5 next-20251114]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-E-Hallyn/Clarify-the-rootid_owns_currentns/20251115-053655
base:   linus/master
patch link:    https://lore.kernel.org/r/aRegH8P4cPlzzlX9%40mail.hallyn.com
patch subject: [PATCH] Clarify the rootid_owns_currentns
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20251115/202511150644.EXaXOsVc-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251115/202511150644.EXaXOsVc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511150644.EXaXOsVc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: security/commoncap.c:369 function parameter 'kuid' not described in 'kuid_root_in_ns'
>> Warning: security/commoncap.c:369 function parameter 'ns' not described in 'kuid_root_in_ns'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

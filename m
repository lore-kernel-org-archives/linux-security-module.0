Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4672263F2E;
	Fri, 14 Feb 2025 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548481; cv=none; b=NQOw3CEZQm/27zi1+AC1ZB9jj594Jocer29asM48Ur1bjDfM/GHHLq4J+5TlTSC+rAOjm8ySX7sKieF1a8LIW6nhd+4ZV4dLElUIkRvSVNvDJC8x9qZ3vx3IYvaH++/YzL23EdS/iTnE4lKCCq6JeFFwXvS8BwG3msNR9Kea/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548481; c=relaxed/simple;
	bh=D7BUq1W64bg7fk5DTnUp5Q47NWeZX2l+s2B5ADRDdq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpmsupETSE38JynY8n+HOobYJdB1sJMWJT1fMQb8urBtxaEodCmFrKkTvrvhQVH+fqxfzVDgwPyIgXpTLbk38bEsN5sduViQX+4WyDHugcnB9TuFXaEDvzz4ytAb6zbnM+2k82L8OSTiz37eyeV7OfemWLrhtInfXsLIT55JFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGMxNAV7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGMxNAV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739548480; x=1771084480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D7BUq1W64bg7fk5DTnUp5Q47NWeZX2l+s2B5ADRDdq0=;
  b=bGMxNAV7MJSvGipi2f7Jx8HjOv9I+xa2slkFrtFLvouIuz1cU1AFoYLr
   oV7B/FQ15KiHGi3HrgJW8U39C9aDKXFA9x648Ykhk1/Mm0UeY7Pu1eoJV
   4brs7NWR0XEG5xh1NZj/+VdNLHTIt+eywEti7YEnij2ss5MKnyCn0Y+/1
   uOnqCz42rnEIZQF9x3EpeA2tNHDPnERZeza8aLFUmHjeU66GO6N2b8O16
   +CVB3kTFYisN7Xep4T9C1ASGg5Vvj6Ete3/YBSyDAHRdAZzix0/vXnHg3
   PksPQJ4+JQki8ucry0eNcKMX/q16d24gzNOSicD/So5LD2NpfU0FJn8Rr
   g==;
X-CSE-ConnectionGUID: rOO8FB1mSnOLSPPAmVQNog==
X-CSE-MsgGUID: jtUqfanlQqW+hu0fUSocOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="43139592"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="43139592"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 07:54:39 -0800
X-CSE-ConnectionGUID: DsxNw1+kTkmNVTVesm7Ocw==
X-CSE-MsgGUID: fUvLz0MPQa+L4F1DE+UP3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="144344402"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Feb 2025 07:54:37 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiy1S-0019oR-0L;
	Fri, 14 Feb 2025 15:54:34 +0000
Date: Fri, 14 Feb 2025 23:54:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <rbm@suse.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 2/2] LoadPin: Make sysctl table const
Message-ID: <202502142320.sf6WGiJs-lkp@intel.com>
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
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20250214/202502142320.sf6WGiJs-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502142320.sf6WGiJs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502142320.sf6WGiJs-lkp@intel.com/

All errors (new ones prefixed by >>):

   security/loadpin/loadpin.c: In function 'set_sysctl':
>> security/loadpin/loadpin.c:75:48: error: assignment of member 'extra1' in read-only object
      75 |                 loadpin_sysctl_table[0].extra1 = SYSCTL_ZERO;
         |                                                ^
   security/loadpin/loadpin.c:77:48: error: assignment of member 'extra1' in read-only object
      77 |                 loadpin_sysctl_table[0].extra1 = SYSCTL_ONE;
         |                                                ^


vim +/extra1 +75 security/loadpin/loadpin.c

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

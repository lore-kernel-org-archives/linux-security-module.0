Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670C41F4E5C;
	Fri, 31 Jan 2025 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355355; cv=none; b=XoBqdN8DSHQx0OhA4Ma3qvJ4EkFH5u/Pktcb/hZyvvnS+CTpfSupToYln1dyfizhTXhIUyiiaDgjor9LPEQlLpjnyUU+642QvLv3gSWPp/TZzMyF0BucLw20LJY5CQp7Pna2HhDqEbNjsVMtyVvsOqH9YFWOXY1KAfJ9G/B/vsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355355; c=relaxed/simple;
	bh=RSCX9rg3pxhLk0LNvz+k/K/VMw4qWttV4lsGMD5jWLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3wiwNI5cCwgBObVCVUmCFTBUhP9L6OQ3RIQDDJ9bZh3mvqIGUk4hopNpbbdSsfzo0e299UMH2mnKsPQeulYpcruGqDSRvnxmvt/kmW1iKNFxm3ZE3xRNLgWpvQFqq1sZeld02eC0avo7Xe87O6eBcIJ8NVxYFxRQtUNgrCd05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eb2py1lw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eb2py1lw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738355353; x=1769891353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RSCX9rg3pxhLk0LNvz+k/K/VMw4qWttV4lsGMD5jWLw=;
  b=eb2py1lwvd6D7d4nw7UOx+enir8iDreHoM3lOqb2crFbILyzQj27Dm1O
   EY+4rRB0lLfZxpJcEdLeRnGaWiK1XQk17Ed7fWwS6eqFnCPP1ym0UH3fV
   AzAzOUQBc9Jr406Uxg5zjYewpHi5gDfznjMUn4TcSgemC9mP3EgZPbs3s
   qegfIk9FuAWJQvpbQ7ktfBnO7HVtmgt628mPUR+VwPQyHSGeZaLacOfSH
   fH7cJMVpCBjbYgXrsdPFRtjgIgNOK5ca/Zmwmb8EK1pukfeT/6M++cQ3V
   OzR8Crlof8dULAO4kbvIRCSXq07VdclV17pDE8gmT66HhHJCV5ODSnMVQ
   Q==;
X-CSE-ConnectionGUID: mZnDs7BnS5SZQzpPk6RHTw==
X-CSE-MsgGUID: OJFMXltfSbqgNjqyRMoVNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="49193198"
X-IronPort-AV: E=Sophos;i="6.13,249,1732608000"; 
   d="scan'208";a="49193198"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 12:29:12 -0800
X-CSE-ConnectionGUID: iOJJo52WQAGwXT5CZt+awQ==
X-CSE-MsgGUID: XKt/0b3EST+OplvXHxy8FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113740721"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 31 Jan 2025 12:29:06 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tdxdQ-000n5t-1e;
	Fri, 31 Jan 2025 20:29:04 +0000
Date: Sat, 1 Feb 2025 04:28:07 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: oe-kbuild-all@lists.linux.dev,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 17/24] landlock: Add
 LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS
Message-ID: <202502010411.lOcXpnOG-lkp@intel.com>
References: <20250131163059.1139617-18-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250131163059.1139617-18-mic@digikod.net>

Hi Mickaël,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 69e858e0b8b2ea07759e995aa383e8780d9d140c]

url:    https://github.com/intel-lab-lkp/linux/commits/Micka-l-Sala-n/lsm-Add-audit_log_lsm_data-helper/20250201-004434
base:   69e858e0b8b2ea07759e995aa383e8780d9d140c
patch link:    https://lore.kernel.org/r/20250131163059.1139617-18-mic%40digikod.net
patch subject: [PATCH v5 17/24] landlock: Add LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS
config: x86_64-buildonly-randconfig-002-20250201 (https://download.01.org/0day-ci/archive/20250201/202502010411.lOcXpnOG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250201/202502010411.lOcXpnOG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502010411.lOcXpnOG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   security/landlock/syscalls.c: In function '__do_sys_landlock_restrict_self':
>> security/landlock/syscalls.c:469:24: warning: variable 'is_quiet_subdomains' set but not used [-Wunused-but-set-variable]
     469 |         bool is_quiet, is_quiet_subdomains,
         |                        ^~~~~~~~~~~~~~~~~~~
   security/landlock/syscalls.c:469:14: warning: variable 'is_quiet' set but not used [-Wunused-but-set-variable]
     469 |         bool is_quiet, is_quiet_subdomains,
         |              ^~~~~~~~


vim +/is_quiet_subdomains +469 security/landlock/syscalls.c

   435	
   436	/**
   437	 * sys_landlock_restrict_self - Enforce a ruleset on the calling thread
   438	 *
   439	 * @ruleset_fd: File descriptor tied to the ruleset to merge with the target.
   440	 * @flags: Supported values:
   441	 *
   442	 * - %LANDLOCK_RESTRICT_SELF_QUIET
   443	 * - %LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS
   444	 *
   445	 * This system call enables to enforce a Landlock ruleset on the current
   446	 * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
   447	 * namespace or is running with no_new_privs.  This avoids scenarios where
   448	 * unprivileged tasks can affect the behavior of privileged children.
   449	 *
   450	 * Possible returned errors are:
   451	 *
   452	 * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
   453	 * - %EINVAL: @flags contains an unknown bit.
   454	 * - %EBADF: @ruleset_fd is not a file descriptor for the current thread;
   455	 * - %EBADFD: @ruleset_fd is not a ruleset file descriptor;
   456	 * - %EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
   457	 *   current thread is not running with no_new_privs, or it doesn't have
   458	 *   %CAP_SYS_ADMIN in its namespace.
   459	 * - %E2BIG: The maximum number of stacked rulesets is reached for the current
   460	 *   thread.
   461	 */
   462	SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
   463			flags)
   464	{
   465		struct landlock_ruleset *new_dom,
   466			*ruleset __free(landlock_put_ruleset) = NULL;
   467		struct cred *new_cred;
   468		struct landlock_cred_security *new_llcred;
 > 469		bool is_quiet, is_quiet_subdomains,
   470			__maybe_unused inherits_quiet_subdomains;
   471	
   472		if (!is_initialized())
   473			return -EOPNOTSUPP;
   474	
   475		/*
   476		 * Similar checks as for seccomp(2), except that an -EPERM may be
   477		 * returned.
   478		 */
   479		if (!task_no_new_privs(current) &&
   480		    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
   481			return -EPERM;
   482	
   483		if ((flags | LANDLOCK_MASK_RESTRICT_SELF) !=
   484		    LANDLOCK_MASK_RESTRICT_SELF)
   485			return -EINVAL;
   486	
   487		is_quiet = !!(flags & LANDLOCK_RESTRICT_SELF_QUIET);
   488		is_quiet_subdomains =
   489			!!(flags & LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS);
   490	
   491		/* Gets and checks the ruleset. */
   492		ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
   493		if (IS_ERR(ruleset))
   494			return PTR_ERR(ruleset);
   495	
   496		/* Prepares new credentials. */
   497		new_cred = prepare_creds();
   498		if (!new_cred)
   499			return -ENOMEM;
   500	
   501		new_llcred = landlock_cred(new_cred);
   502	
   503		/*
   504		 * There is no possible race condition while copying and manipulating
   505		 * the current credentials because they are dedicated per thread.
   506		 */
   507		new_dom = landlock_merge_ruleset(new_llcred->domain, ruleset);
   508		if (IS_ERR(new_dom)) {
   509			abort_creds(new_cred);
   510			return PTR_ERR(new_dom);
   511		}
   512	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

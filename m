Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E710212D9E;
	Fri,  7 Mar 2025 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343556; cv=none; b=J5RZVtaeeH6lZTM0Thv0WU3ZuCaIt8zzHQ+2HGl9fDMnml6jh970Ypv/lPAwTKXXIa+hmsQI9y8lPqwUsW6xmh5N1igfJoMKMFE8YK0ohxU/FRsIPkBTtXkYAoKQhlHnW0bEIWNQndyIS4uxoE/wi+BBnKJgk/76XvqGJe5cfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343556; c=relaxed/simple;
	bh=eaFXM5ndfzcSejieQgyRUMqCp/DYjdcvdOcHWt4mbqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RN0+toRod4soHC5nY1R9JEVDxF2tpm34Rb2Eo6UJ99DdaSPA+Gm5R+xG3b+R72p4uHRMKtkIJtnYlvdNp6g2QbrifX3A+WxSeyHXcuIukIZ6H09JN8dKjUdVT5vbgpxO9xGQJLQid25JHlkbFCIyEXPW62lCOEvOZmCxrXNyEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhkRhXrI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhkRhXrI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741343554; x=1772879554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eaFXM5ndfzcSejieQgyRUMqCp/DYjdcvdOcHWt4mbqA=;
  b=AhkRhXrINTsEbCMqNiN4yFC31JdFwVb2eHsOt1k4Ty4eHZGBpiePPqhR
   3DtNyoLIIjWPR/4ZZojwBs//cyCLCLZNVjp/4azVifGKFYjsWi0J9K9aN
   H9COqt54Yub9EzoQGLQuOpbS42o21YGb9nVIzC0RlbPCUqKPHMq8mkPLw
   fWzLI2wlc8MbbSuhi7e8BW6rXVpvwhHTsAutaUghIZxF0gSrGJ6oyB6P+
   iC17JYY/qTsDOInn4o/yq8KzHfVtzjFJ316GeWC6pXKyD3gfDeBQxI+nT
   23EznovhfQMiEGDwLt067r1zZnM9ES1n/E529ucH4Rxnn+CKWZEDvSEdT
   w==;
X-CSE-ConnectionGUID: WszuDZ7SQmSCaPVEwIXZtw==
X-CSE-MsgGUID: qRXUyq91QU2C6RRECqDJeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53023630"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="53023630"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 02:32:34 -0800
X-CSE-ConnectionGUID: fIAv12/HSamVvCAGlF+p9A==
X-CSE-MsgGUID: n3eYZvM/Qzy8b6cjiZJCfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="119117900"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 07 Mar 2025 02:32:32 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqV0A-0000Jf-1P;
	Fri, 07 Mar 2025 10:32:23 +0000
Date: Fri, 7 Mar 2025 18:32:04 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, serge@hallyn.com,
	paul@paul-moore.com, jmorris@namei.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH] security/commoncap: don't assume "setid" if all ids are
 identical
Message-ID: <202503071808.FE4vwUc4-lkp@intel.com>
References: <20250306082615.174777-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306082615.174777-1-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pcmoore-selinux/next]
[also build test WARNING on linus/master v6.14-rc5 next-20250306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/security-commoncap-don-t-assume-setid-if-all-ids-are-identical/20250306-162826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20250306082615.174777-1-max.kellermann%40ionos.com
patch subject: [PATCH] security/commoncap: don't assume "setid" if all ids are identical
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20250307/202503071808.FE4vwUc4-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503071808.FE4vwUc4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503071808.FE4vwUc4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/commoncap.c:865: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Are all user/group ids in both cred instances identical?


vim +865 security/commoncap.c

   863	
   864	/**
 > 865	 * Are all user/group ids in both cred instances identical?
   866	 *
   867	 * It can be used after __is_setuid() / __is_setgid() to check whether
   868	 * this is really a set*id operation or whether both processes just
   869	 * have differing real/effective ids.  It is safe to keep differing
   870	 * real/effective ids in "unsafe" program execution.
   871	 */
   872	static bool has_identical_uids_gids(const struct cred *a, const struct cred *b)
   873	{
   874		return uid_eq(a->uid, b->uid) &&
   875			gid_eq(a->gid, b->gid) &&
   876			uid_eq(a->suid, b->suid) &&
   877			gid_eq(a->sgid, b->sgid) &&
   878			uid_eq(a->euid, b->euid) &&
   879			gid_eq(a->egid, b->egid) &&
   880			uid_eq(a->fsuid, b->fsuid) &&
   881			gid_eq(a->fsgid, b->fsgid);
   882	}
   883	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

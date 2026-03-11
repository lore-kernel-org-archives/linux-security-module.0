Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C96399351;
	Wed, 11 Mar 2026 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269955; cv=none; b=k+dWh2+eIFcICln6WDgAvlWyrERZxUTLbexy7yNevtvPxfQj2W28TIs2sWKpdpQzQParVzy0ZFoYgNbxhN60ivi/5k+yWz67VZ3eff7ppKP/zyLyd0inFD75EqwEn4A43Y35UOxziX/OeHWlhkC+TD+sn6izVInB28zR8U3sVrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269955; c=relaxed/simple;
	bh=LdDfjKM5xdtNNb47NSd1OkfYPktd1pYlbjrXP+Pjqos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AffR6pMhVLlgFN5uphAq39PpsmvSMQBZrBr2v6nRlqulKhrYCDSyyxtXq3gTsaHKPLoQSfSiDUvlDy2TlOGbdpc3d0LyiXNHfkWcV4+kmQYNNlHXRIGRIejoHCPxTMT6NAwXlK+7BBjqK9IK7aURqW8dMWqTPfGtvR9/stsNIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJE8BYrz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJE8BYrz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773269952; x=1804805952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LdDfjKM5xdtNNb47NSd1OkfYPktd1pYlbjrXP+Pjqos=;
  b=iJE8BYrzNaI/oASBMwlc7eWeFRXTZsuIfBVpw4l6MUf/y7Zd36cvPuOe
   w+/996kP7awJgHb8Ac/TRTmLJEkIgVXHpgmo0yJpiltIF2Icys0fXp3Vh
   ncfZH9nB2OfBvOw0rR4dMRTbr2hOnMb6iHFDUI6O24yzVnt/wQLkWoKrb
   TKDjvexCo3uT5AoSZnwjS1ngeVpEjUxZtC2ysSVMRWs6BjSTUE4eiHWPx
   9td+slw9jACcPkODaqRMRaHG/HX4doQ0XprPdLghUvD6qOLFJ5o1IfIpY
   lLkL9tdJMFBToj/TQpDqCRELTH6GlDfBfqwhYvvaPr7C8avI/w4JJ0zA3
   Q==;
X-CSE-ConnectionGUID: A92cg3oUTeGxMWrurw1MMQ==
X-CSE-MsgGUID: nimZQbJJRaa38p848W4dYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="91733928"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="91733928"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 15:59:12 -0700
X-CSE-ConnectionGUID: ROUf1J18RVSxm9LAgxnLEw==
X-CSE-MsgGUID: Q3YfRIKSTw++gwR9PsPKyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="243641634"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Mar 2026 15:59:09 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0SWA-000000001nH-0qGV;
	Wed, 11 Mar 2026 22:59:06 +0000
Date: Thu, 12 Mar 2026 06:58:50 +0800
From: kernel test robot <lkp@intel.com>
To: Jamie Lindsey <jamie@matrixforgelabs.com>,
	rust-for-linux@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, ojeda@kernel.org,
	paul@paul-moore.com, aliceryhl@google.com, jmorris@namei.org,
	serge@hallyn.com, jamie@matrixforgelabs.com
Subject: Re: [PATCH v2 3/5] rust: kernel: add LSM abstraction layer
Message-ID: <202603120654.DWidINbR-lkp@intel.com>
References: <0102019cdb4c705e-7d46b4f3-5cbb-4a6a-b315-e10f182fa987-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102019cdb4c705e-7d46b4f3-5cbb-4a6a-b315-e10f182fa987-000000@eu-west-1.amazonses.com>

Hi Jamie,

kernel test robot noticed the following build errors:

[auto build test ERROR on rust/rust-next]
[also build test ERROR on linus/master v7.0-rc3 next-20260311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jamie-Lindsey/rust-helpers-add-C-shims-for-LSM-hook-initialisation/20260311-131258
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/0102019cdb4c705e-7d46b4f3-5cbb-4a6a-b315-e10f182fa987-000000%40eu-west-1.amazonses.com
patch subject: [PATCH v2 3/5] rust: kernel: add LSM abstraction layer
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260312/202603120654.DWidINbR-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260312/202603120654.DWidINbR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603120654.DWidINbR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0433]: failed to resolve: use of unresolved module or unlinked crate `bindings`
   --> rust/doctests_kernel_generated.rs:8845:40
   |
   8845 | kernel::define_lsm!(MyLsm, "my_lsm\0", bindings::LSM_ID_UNDEF as u64);
   |                                        ^^^^^^^^ use of unresolved module or unlinked crate `bindings`
   |
   = help: you might be missing a crate named `bindings`
   = help: consider importing this crate:
   kernel::bindings
--
>> error[E0412]: cannot find type `MyLsm` in this scope
   --> rust/doctests_kernel_generated.rs:8845:21
   |
   8845 | kernel::define_lsm!(MyLsm, "my_lsm\0", bindings::LSM_ID_UNDEF as u64);
   |                     ^^^^^ not found in this scope
--
>> error[E0433]: failed to resolve: use of unresolved module or unlinked crate `bindings`
   --> rust/doctests_kernel_generated.rs:8898:44
   |
   8898 | kernel::define_lsm!(MyLsmType, "my_lsm\0", bindings::LSM_ID_UNDEF as u64);
   |                                            ^^^^^^^^ use of unresolved module or unlinked crate `bindings`
   |
   = help: you might be missing a crate named `bindings`
   = help: consider importing this crate:
   kernel::bindings
--
>> error[E0412]: cannot find type `MyLsmType` in this scope
   --> rust/doctests_kernel_generated.rs:8898:21
   |
   8898 | kernel::define_lsm!(MyLsmType, "my_lsm\0", bindings::LSM_ID_UNDEF as u64);
   |                     ^^^^^^^^^ not found in this scope

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

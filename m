Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413C42314F;
	Wed, 13 May 2026 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676872; cv=none; b=Y/SD9aOrI/gJBMX1gydW+zyYNEz8fosL1/shkjjnzQF8xUf2TNlG37RtNn9+ojUehZwoAztM8SrKKTUdwpRz56Xq5+vx5A6ydJtMMzosLplp2fmAtXHFJjJavuPS+NsclmIcSGNV9yAnN0KsCoJaS0Tc9toopxuMv17F+9Hz0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676872; c=relaxed/simple;
	bh=CHoEEWTlL/dVcJyq7sL/SMMTKJ2L2HLLtpbVlyUn0KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFkyG6nLVrBB/k3s3jJjzwhPM7IjuDo9Q/jPoQZAQUmK9rGSyg5qmdYRnciZ+UWaKK3u3ypiVljIGRza2GTmWAtsjYhwSxmFkWi+gHNvl1i+BqVSRQgtildTyp2C/cWXYl1cZGsS2iiQ4Rkw4rC0UPx+kjA3LgIX+MQeaFSHbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RN8hWMV7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RN8hWMV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778676871; x=1810212871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CHoEEWTlL/dVcJyq7sL/SMMTKJ2L2HLLtpbVlyUn0KE=;
  b=RN8hWMV7C5SIAxO1ANACXgj/wRTgsVoIbTjFvtUUJNPOpSZcUy7E9Kle
   2aEbPTPRlupQAauP7DR30LkbI/rqyGDPkkMK5TURydTUZW7cfwGEqffQU
   V295j3mS2lNK9v509CjbcbZ7/MbTU91W86tW6lgTmYL92zUhid1Ogs5CF
   W37iqVzdzNQgG2J8JcJlH9ISkBWQ11+DwJhH+Yzwlib+S9LdoNeepuLOI
   5ovwCO0xnvrrX20KCcdANA0lYJY9YqqGfogg1y37k9/HvbOFkeMpvCULW
   CtRwm+snAwmRaKVy/azAUeH3SMn7heAZhWnzLpiJM6U/kQeVMKgqckqQ+
   A==;
X-CSE-ConnectionGUID: nRjrzBCIQI+FxX5Fg6YAyA==
X-CSE-MsgGUID: /iB9GssOSaGiu7b5wEoYDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83217387"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="83217387"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 05:54:31 -0700
X-CSE-ConnectionGUID: 54HrI0MMS660LvNFaK4QVQ==
X-CSE-MsgGUID: B5P8kFPIRKuOAlJ3avJBuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="233807073"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 May 2026 05:54:26 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wN96V-0000000047L-3yLL;
	Wed, 13 May 2026 12:54:23 +0000
Date: Wed, 13 May 2026 20:53:39 +0800
From: kernel test robot <lkp@intel.com>
To: Arnav Sharma <arnav4324@gmail.com>, ojeda@kernel.org,
	paul@paul-moore.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Arnav Sharma <arnav4324@gmail.com>,
	Serge Hallyn <sergeh@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-security-module@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: cred: add safe abstractions for capable() and
 ns_capable()
Message-ID: <202605132018.249x1thF-lkp@intel.com>
References: <20260506204913.26022-1-arnav4324@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506204913.26022-1-arnav4324@gmail.com>

Hi Arnav,

kernel test robot noticed the following build errors:

[auto build test ERROR on rust/rust-next]
[also build test ERROR on linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnav-Sharma/rust-cred-add-safe-abstractions-for-capable-and-ns_capable/20260513-154340
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/20260506204913.26022-1-arnav4324%40gmail.com
patch subject: [PATCH] rust: cred: add safe abstractions for capable() and ns_capable()
config: loongarch-randconfig-001 (https://download.01.org/0day-ci/archive/20260513/202605132018.249x1thF-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605132018.249x1thF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605132018.249x1thF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find function `capable` in crate `bindings`
   --> rust/kernel/cred.rs:133:24
   |
   133 |     unsafe { bindings::capable(cap as i32) }
   |                        ^^^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `ns_capable` in crate `bindings`
   --> rust/kernel/cred.rs:169:24
   |
   169    |       unsafe { bindings::ns_capable(ns, cap as i32) }
   |                          ^^^^^^^^^^ help: a function with a similar name exists: `cap_capable`
   |
   ::: rust/bindings/bindings_generated.rs:107518:5
   |
   107518 | /     pub fn cap_capable(
   107519 | |         cred: *const cred,
   107520 | |         ns: *mut user_namespace,
   107521 | |         cap: ffi::c_int,
   107522 | |         opts: ffi::c_uint,
   107523 | |     ) -> ffi::c_int;
   | |____________________- similarly named function `cap_capable` defined here

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

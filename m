Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF087429831;
	Wed, 13 May 2026 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686849; cv=none; b=tobOR3UFw/BFWgkBdVmoMI4S+j0zTotNcB8MqVg4LegA2n5BEx7RIfOZrAM4EQtO6qOpz1JyymIA5nRPG0dN0G7X6O/U8wMukee4YYt+S/PyOIst5UmSkCXIlf0Aq4/kUm1KRMOrZ2St8vVI00sJs1cQSmm6AM1R/pfw376TtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686849; c=relaxed/simple;
	bh=wo5C+2xZzhw8VcUkpdZeDHv9USz6c+kDxkR+x31Bfzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN+e4Z5DK6XL4ka/OtcXc1LO4otDc6NWaxwi0DRdCXNgmipqrkUQUD0slZRPrBSyrIgY0jdyUuJ3BY3e9RWlWR9i6URVl7LG0Eb16og/2nTtT6EDJNWCamyBrJyCAEyEkA2yZN/10QSXXW2VFRYT8X7l428mS6DpDVG79erfRsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nk+pzxGg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nk+pzxGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778686847; x=1810222847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wo5C+2xZzhw8VcUkpdZeDHv9USz6c+kDxkR+x31Bfzg=;
  b=Nk+pzxGgrjr49PxwwG0NnBuUQjYdhQzfR4ebqdQOc7xEqzAQVmE9eBdA
   AYWENjBld5ERokqbFyZz5cbC/9MoKauRHlmEaPk51q+Ee3Sjdopllcv4p
   3y1gbCmXv3zAZF0z+SyRnNkUE6bqenqoNcqWcofyC3E5BXS1ZfDW1DaiG
   tCELwwsKK1Z0OTyf8mPDWZWbLtlNfMMlTl/brJk60zf++a8E4e4hspoXa
   6kLomb9P1l5dnh2JkhIVp0vsETZLUGa49kTDfWmnD2YIuHtBUHX10sPLH
   aJuksbkKL+RVeTjsQGOpuf0tLmc/DPMCA/PzD27x2FeCqlzgXILS8RevB
   g==;
X-CSE-ConnectionGUID: kxIJuMPORmy5lY38LTfYaw==
X-CSE-MsgGUID: uRLuc32vQVykAf20N5F0Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83231335"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="83231335"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:40:47 -0700
X-CSE-ConnectionGUID: PmjlhOTpT5ePkzrqqjg1tw==
X-CSE-MsgGUID: pDAHxIbmQtSwxFJbIiGiKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="242122923"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa003.jf.intel.com with ESMTP; 13 May 2026 08:40:44 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNBhR-000000008Zd-3Fow;
	Wed, 13 May 2026 15:40:41 +0000
Date: Wed, 13 May 2026 17:39:41 +0200
From: kernel test robot <lkp@intel.com>
To: Arnav Sharma <arnav4324@gmail.com>, ojeda@kernel.org,
	paul@paul-moore.com
Cc: oe-kbuild-all@lists.linux.dev, Arnav Sharma <arnav4324@gmail.com>,
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
Message-ID: <202605131729.NXF18q0f-lkp@intel.com>
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
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260513/202605131729.NXF18q0f-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605131729.NXF18q0f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605131729.NXF18q0f-lkp@intel.com/

All errors (new ones prefixed by >>):

   PATH=/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.88.0-bindgen-0.72.1/cargo/bin:/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS=\ -fno-crash-diagnostics\ -Wno-error=return-type\ -Wreturn-type\ -funsigned-char\ -Wundef\ -falign-functions=64 W=1 --keep-going LLVM=1 -j384 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck 
   make: Entering directory '/kbuild/src'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>> Diff in rust/kernel/cred.rs:168:
        // the specified capability is granted.
        unsafe { bindings::ns_capable(ns, cap as i32) }
    }
   -
    
>> Diff in rust/kernel/cred.rs:168:
        // the specified capability is granted.
        unsafe { bindings::ns_capable(ns, cap as i32) }
    }
   -
    
   make[2]: *** [Makefile:1954: rustfmt] Error 123
   make[2]: Target 'rustfmtcheck' not remade because of errors.
   make[1]: Leaving directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'rustfmtcheck' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'rustfmtcheck' not remade because of errors.
   make: Leaving directory '/kbuild/src'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

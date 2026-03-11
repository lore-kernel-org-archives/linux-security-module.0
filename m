Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8E3DE43D;
	Wed, 11 Mar 2026 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230884; cv=none; b=ebMxxpfINV3ZkNtcZJaIgwijRgd3/m3IdQmFnDlgXbc2qoOcqDirOKt6GyH8SQflZy9EzQQbQbp/lGtOl8fA+oCKTw0FGhDm43G+CM8A3gjk3tRcrEUCe53jfG2o2MqN6HW1Om0iODRXEJXTOAkbjNPEWiBrj6RZsrbJN2T5P1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230884; c=relaxed/simple;
	bh=79iJSC+zsY6oYwpI58ah9mdZsHaOdnaOazbfan4YyLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDzR2ddFFOZWyn55dvR1qXs1b8Q4kz/OuneLbRmTSmO4oYPNwVsMnYQaqnRPJ400XHidwK1o1iypb0sI8D6snq1gy9gOT+GikPDaFM9PPE0EnbSnOK8Rep/8lBGQlvIVjMZLCZ46OctRVLm1z2FvWUZzIGagZh+iexyNPj20/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IanUOk5G; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IanUOk5G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773230877; x=1804766877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=79iJSC+zsY6oYwpI58ah9mdZsHaOdnaOazbfan4YyLQ=;
  b=IanUOk5GI5kM/Zkt/bePFBO3Ebkgl/0fU8OPjIypCArPNCx/fGOYW6D7
   EC0n8V+/B9p9iccwzO0X/t+qzTqol9erRcp03OX3roWFEKZ7EvH6uVYah
   Yqq2awm5pC9DHiypcwtL4iRlPE2ngldYswbwUosIOAPNckFOHY3TKbkr+
   /VRn+SAf+FdHt+8vpxYlssr59BPUBhlyt5BMmXS1BJdpGUbxGiDgJOP7C
   wczNfgmBY5e5cU74OHuLywVJwU9aWkt2xnwZb0e1LbnXBksW40RzrkWFD
   qxRGJo2OvVIH1Omy1aEgMpd8/Q+QdM8x08atDY+fvmXQUQ3cqkKlgH161
   A==;
X-CSE-ConnectionGUID: T76HipIlSeywunUVDex/Fw==
X-CSE-MsgGUID: JAVIqyaQQuimbvDilv5XBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85383085"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85383085"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:07:56 -0700
X-CSE-ConnectionGUID: 6PKgAvB5QUaJC7zgdKiiyA==
X-CSE-MsgGUID: lqsr3qDxRyeGakYN4mO7QQ==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 11 Mar 2026 05:07:54 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0ILv-000000003K1-2unU;
	Wed, 11 Mar 2026 12:07:51 +0000
Date: Wed, 11 Mar 2026 13:07:04 +0100
From: kernel test robot <lkp@intel.com>
To: Jamie Lindsey <jamie@matrixforgelabs.com>,
	rust-for-linux@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ojeda@kernel.org, paul@paul-moore.com,
	aliceryhl@google.com, jmorris@namei.org, serge@hallyn.com,
	jamie@matrixforgelabs.com
Subject: Re: [PATCH v2 3/5] rust: kernel: add LSM abstraction layer
Message-ID: <202603111327.ZxGK7MvE-lkp@intel.com>
References: <0102019cdb4c705e-7d46b4f3-5cbb-4a6a-b315-e10f182fa987-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0102019cdb4c705e-7d46b4f3-5cbb-4a6a-b315-e10f182fa987-000000@eu-west-1.amazonses.com>

Hi Jamie,

kernel test robot noticed the following build errors:

[auto build test ERROR on rust/rust-next]
[also build test ERROR on linus/master v7.0-rc3 next-20260310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jamie-Lindsey/rust-helpers-add-C-shims-for-LSM-hook-initialisation/20260311-131258
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/0102019cdb4c705e-7d46b4f3-5cbb-4a6a-b315-e10f182fa987-000000%40eu-west-1.amazonses.com
patch subject: [PATCH v2 3/5] rust: kernel: add LSM abstraction layer
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260311/202603111327.ZxGK7MvE-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260311/202603111327.ZxGK7MvE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603111327.ZxGK7MvE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> warning: unresolved link to `define_lsm`
   --> rust/kernel/lsm.rs:7:46
   |
   7 | //! registers itself at boot time with the [`define_lsm!`] macro.
   |                                              ^^^^^^^^^^^ no item named `define_lsm` in scope
   |
   = note: `macro_rules` named `define_lsm` exists in this crate, but it is not in scope at this link's location
   = note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default
--
   PATH=/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.88.0-bindgen-0.72.1/cargo/bin:/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS=\ -fno-crash-diagnostics\ -Wno-error=return-type\ -Wreturn-type\ -funsigned-char\ -Wundef\ -falign-functions=64 W=1 --keep-going LLVM=1 -j32 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck 
   make: Entering directory '/kbuild/src/consumer'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>> Diff in rust/kernel/lsm.rs:120:
        /// `file` must be a valid, non-null pointer to a `struct file` that
        /// remains valid for the duration of this call.  Called only by the
        /// LSM framework.
   -    pub unsafe extern "C" fn file_open(
   -        file: *mut bindings::file,
   -    ) -> core::ffi::c_int {
   +    pub unsafe extern "C" fn file_open(file: *mut bindings::file) -> core::ffi::c_int {
            // SAFETY: The LSM framework guarantees `file` is valid and non-null
            // for the duration of this call.
            let file_ref = unsafe { File::from_raw_file(file.cast_const()) };
   Diff in rust/kernel/lsm.rs:190:
        // SAFETY: `bindings::lsm_info` is a C struct.  Zero-initialisation
        // gives valid zero/null values for every optional field.  The caller
        // is responsible for providing a valid `id` and `init`.
   -    let mut info: bindings::lsm_info =
   -        unsafe { MaybeUninit::zeroed().assume_init() };
   +    let mut info: bindings::lsm_info = unsafe { MaybeUninit::zeroed().assume_init() };
        info.id = id;
        info.init = init;
        LsmInfo(info)
   Diff in rust/kernel/lsm.rs:230:
                // The LSM identity — must be 'static because the static-call
                // table holds a back-pointer to it via security_hook_list.lsmid.
                // LsmId wraps lsm_id with `unsafe impl Sync` so it can be `static`.
   -            static __LSM_ID: $crate::lsm::LsmId =
   -                $crate::lsm::LsmId($crate::bindings::lsm_id {
   -                    name: $name.as_ptr().cast(),
   -                    id: $id,
   -                });
   +            static __LSM_ID: $crate::lsm::LsmId = $crate::lsm::LsmId($crate::bindings::lsm_id {
   +                name: $name.as_ptr().cast(),
   +                id: $id,
   +            });
    
                // The hook list array.  MaybeUninit avoids needing security_hook_list
                // to implement a const-initialiser; the C shims fill each slot in
   Diff in rust/kernel/lsm.rs:242:
                //
                // SAFETY: This array must be 'static — the static-call table holds
                // back-pointers (scall->hl) into it after registration.
   -            static mut __LSM_HOOKS: [
   -                ::core::mem::MaybeUninit<$crate::bindings::security_hook_list>;
   -                3
   -            ] = [::core::mem::MaybeUninit::zeroed(); 3];
   +            static mut __LSM_HOOKS: [::core::mem::MaybeUninit<
   +                $crate::bindings::security_hook_list,
   +            >; 3] = [::core::mem::MaybeUninit::zeroed(); 3];
    
                // The init function stored in lsm_info.init.  Called once by
                // security_init() in single-threaded boot context.
   Diff in rust/kernel/lsm.rs:283:
                #[link_section = ".lsm_info.init"]
                static __LSM_INFO: $crate::lsm::LsmInfo = {
                    // SAFETY: __LSM_ID and __lsm_init have 'static lifetime.
   -                unsafe {
   -                    $crate::lsm::new_lsm_info(
   -                        &raw const __LSM_ID.0,
   -                        Some(__lsm_init),
   -                    )
   -                }
   +                unsafe { $crate::lsm::new_lsm_info(&raw const __LSM_ID.0, Some(__lsm_init)) }
                };
            }
        };
>> Diff in rust/kernel/lsm.rs:120:
        /// `file` must be a valid, non-null pointer to a `struct file` that
        /// remains valid for the duration of this call.  Called only by the
        /// LSM framework.
   -    pub unsafe extern "C" fn file_open(
   -        file: *mut bindings::file,
   -    ) -> core::ffi::c_int {
   +    pub unsafe extern "C" fn file_open(file: *mut bindings::file) -> core::ffi::c_int {
            // SAFETY: The LSM framework guarantees `file` is valid and non-null
            // for the duration of this call.
            let file_ref = unsafe { File::from_raw_file(file.cast_const()) };
   Diff in rust/kernel/lsm.rs:190:
        // SAFETY: `bindings::lsm_info` is a C struct.  Zero-initialisation
        // gives valid zero/null values for every optional field.  The caller
        // is responsible for providing a valid `id` and `init`.
   -    let mut info: bindings::lsm_info =
   -        unsafe { MaybeUninit::zeroed().assume_init() };
   +    let mut info: bindings::lsm_info = unsafe { MaybeUninit::zeroed().assume_init() };
        info.id = id;
        info.init = init;
        LsmInfo(info)
   Diff in rust/kernel/lsm.rs:230:
                // The LSM identity — must be 'static because the static-call
                // table holds a back-pointer to it via security_hook_list.lsmid.
                // LsmId wraps lsm_id with `unsafe impl Sync` so it can be `static`.
   -            static __LSM_ID: $crate::lsm::LsmId =
   -                $crate::lsm::LsmId($crate::bindings::lsm_id {
   -                    name: $name.as_ptr().cast(),
   -                    id: $id,
   -                });
   +            static __LSM_ID: $crate::lsm::LsmId = $crate::lsm::LsmId($crate::bindings::lsm_id {
   +                name: $name.as_ptr().cast(),
   +                id: $id,
   +            });
    
                // The hook list array.  MaybeUninit avoids needing security_hook_list
                // to implement a const-initialiser; the C shims fill each slot in
   Diff in rust/kernel/lsm.rs:242:
                //
                // SAFETY: This array must be 'static — the static-call table holds
                // back-pointers (scall->hl) into it after registration.
   -            static mut __LSM_HOOKS: [
   -                ::core::mem::MaybeUninit<$crate::bindings::security_hook_list>;
   -                3
   -            ] = [::core::mem::MaybeUninit::zeroed(); 3];
   +            static mut __LSM_HOOKS: [::core::mem::MaybeUninit<
   +                $crate::bindings::security_hook_list,
   +            >; 3] = [::core::mem::MaybeUninit::zeroed(); 3];
    
                // The init function stored in lsm_info.init.  Called once by
                // security_init() in single-threaded boot context.
   Diff in rust/kernel/lsm.rs:283:
                #[link_section = ".lsm_info.init"]
                static __LSM_INFO: $crate::lsm::LsmInfo = {
                    // SAFETY: __LSM_ID and __lsm_init have 'static lifetime.
   -                unsafe {
   -                    $crate::lsm::new_lsm_info(
   -                        &raw const __LSM_ID.0,
   -                        Some(__lsm_init),
   -                    )
   -                }
   +                unsafe { $crate::lsm::new_lsm_info(&raw const __LSM_ID.0, Some(__lsm_init)) }
                };
            }
        };
   make[1]: Leaving directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'rustfmtcheck' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make[2]: *** [Makefile:1912: rustfmt] Error 123
   make: Target 'rustfmtcheck' not remade because of errors.
   make[2]: Target 'rustfmtcheck' not remade because of errors.
   make: Leaving directory '/kbuild/src/consumer'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

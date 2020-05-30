Return-Path: <SRS0=vtOa=7M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB153C433E0
	for <linux-security-module@archiver.kernel.org>; Sat, 30 May 2020 17:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0B32077D
	for <linux-security-module@archiver.kernel.org>; Sat, 30 May 2020 17:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NcDvenTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgE3RbC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 30 May 2020 13:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3RbB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 30 May 2020 13:31:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680CEC08C5C9
        for <linux-security-module@vger.kernel.org>; Sat, 30 May 2020 10:31:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f3so1373536pfd.11
        for <linux-security-module@vger.kernel.org>; Sat, 30 May 2020 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jPHQQSCP51cGkFJo8bfZa15z37GswJuwTn/le7SylYU=;
        b=NcDvenTzIUA/BlQTQo1nYfs7LYvRYIe7ehSI8QgDnUTwlkaB3wxPeOae1Q2pGzUar7
         TZ2lYi1+3j6GN0vmXsjTHfW7FZ4yjZ0Y7V37N6qp4jV/vAezfB8BBU/RSRHp6Lhw8/wR
         IoT5xfto+VY2pTxKlWUW1mp40XNsM/9+4RTt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jPHQQSCP51cGkFJo8bfZa15z37GswJuwTn/le7SylYU=;
        b=n2AuLCYvlfpuV04ZCevGYC1jO4YlCIOuiH86LAb0VI6B5Lmof/4oeqb78PSPIDFsc1
         8l696AGcEid+ZMs4EQoql+yus+wRl6CU8gqU862efhUO9pGudCyyF+3acVGZDMqyHO6/
         0VCO1BT/w4yZrKo1fLo3GUUY2ZKKW12MJs93UfyiH+cfr62Fzg6lE/V8vMtP9DqWPX0A
         85BiKq+7Ty1fhDp81BxPiX1+IP6nrlUfQekS+IK7bTMaQjMEexpCaFZnt9nTND3vlI1Y
         5Quj0OO7NA8yyc/XCZ6CQHCvcivsLSG52Z8YFPfbFJjButUYmObF3rRitcQ8/PcqVoWo
         7FAg==
X-Gm-Message-State: AOAM5309L7PyO4DOfriYryLScEWcacIP77AwAcvhjVZBmFiLkmC9Yw99
        iAxH9L70DaFqi6Px+jIZ93yL+w==
X-Google-Smtp-Source: ABdhPJyAnjhczssUcGe0J2dpA0nHZjMDdFDg5X8MuZj4xiOAvzcNX5gH8XXQcuUzB8NccHe7cB0SFQ==
X-Received: by 2002:a05:6a00:1510:: with SMTP id q16mr13446701pfu.311.1590859859638;
        Sat, 30 May 2020 10:30:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 192sm9648362pfz.198.2020.05.30.10.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 10:30:58 -0700 (PDT)
Date:   Sat, 30 May 2020 10:30:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Gofman <gofmanp@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory
 areas
Message-ID: <202005300923.B245392C@keescook>
References: <20200530055953.817666-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530055953.817666-1-krisman@collabora.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, May 30, 2020 at 01:59:53AM -0400, Gabriel Krisman Bertazi wrote:
> Modern Windows applications are executing system call instructions
> directly from the application's code without going through the WinAPI.
> This breaks Wine emulation, because it doesn't have a chance to
> intercept and emulate these syscalls before they are submitted to Linux.
> 
> In addition, we cannot simply trap every system call of the application
> to userspace using PTRACE_SYSEMU, because performance would suffer,
> since our main use case is to run Windows games over Linux.  Therefore,
> we need some in-kernel filtering to decide whether the syscall was
> issued by the wine code or by the windows application.

Interesting use-case! It seems like you're in the position of needing to
invert the assumption about syscalls: before you knew everything going
through WinAPI needed emulation, and now you need to assume everything
not going through a native library needs emulation. Oof.

Is it possible to disassemble and instrument the Windows code to insert
breakpoints (or emulation calls) at all the Windows syscall points?

> [...]
> * Why not SECCOMP_MODE_FILTER?
> 
> We experimented with dynamically generating BPF filters for whitelisted
> memory regions and using SECCOMP_MODE_FILTER, but there are a few
> reasons why it isn't enough nor a good idea for our use case:
> 
> 1. We cannot set the filters at program initialization time and forget
> about it, since there is no way of knowing which modules will be loaded,
> whether native and windows.  Filter would need a way to be updated
> frequently during game execution.
> 
> 2. We cannot predict which Linux libraries will issue syscalls directly.
> Most of the time, whitelisting libc and a few other libraries is enough,
> but there are no guarantees other Linux libraries won't issue syscalls
> directly and break the execution.  Adding every linux library that is
> loaded also has a large performance cost due to the large resulting
> filter.

Just so I can understand the expected use: given the dynamic nature of
the library loading, how would Wine be marking the VMAs?

> 3. As I mentioned before, performance is critical.  In our testing with
> just a single memory segment blacklisted/whitelisted, the minimum size
> of a bpf filter would be 4 instructions.  In that scenario,
> SECCOMP_MODE_FILTER added an average overhead of 10% to the execution
> time of sysinfo(2) in comparison to seccomp disabled, while the impact
> of SECCOMP_MODE_MEMMAP was averaged around 1.5%.

Was the BPF JIT enabled? I was recently examining filter performance too:
https://lore.kernel.org/linux-security-module/202005291043.A63D910A8@keescook/

> Indeed, points 1 and 2 could be worked around with some userspace work
> and improved SECCOMP_MODE_FILTER support, but at a high performance and
> some stability cost, to obtain the semantics we want.  Still, the
> performance would suffer, and SECCOMP_MODE_MEMMAP is non intrusive
> enough that I believe it should be considered as an upstream solution.

It looks like you're using SECCOMP_RET_TRAP for this? Signal handling
can be pretty slow. Did you try SECCOMP_RET_USER_NOTIF?

> Sending as an RFC for now to get the discussion started.  In particular:
> 
> 1) Would this design be acceptable?

Maybe? I want to spend a little time exploring alternatives first. :)

> 2) I'm not comfortable with using the high part of vm_flags, though I'm
> not sure where else it would fit.  Suggestions?

I don't know this area very well. Hopefully some of the mm folks can
comment on it. It seems like there needs to be a more dynamic way mark
VMAs for arbitrary purposes (since this isn't _actually_ a PROT* flag,
it's just a marking for seccomp to check).

Regardless, here's a review of the specifics of patch, without regard to
the design question above. :)

> 
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Will Drewry <wad@chromium.org>
> CC: H. Peter Anvin <hpa@zytor.com>
> CC: Paul Gofman <gofmanp@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  arch/Kconfig                           | 21 +++++++++
>  arch/x86/Kconfig                       |  1 +
>  include/linux/mm.h                     |  8 ++++
>  include/linux/mman.h                   |  4 +-
>  include/uapi/asm-generic/mman-common.h |  2 +
>  include/uapi/linux/seccomp.h           |  2 +
>  kernel/seccomp.c                       | 59 ++++++++++++++++++++++++++
>  mm/mprotect.c                          |  2 +-
>  8 files changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 786a85d4ad40..e5c10231c9c2 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -471,6 +471,27 @@ config SECCOMP_FILTER
>  
>  	  See Documentation/userspace-api/seccomp_filter.rst for details.
>  
> +config HAVE_ARCH_SECCOMP_MEMMAP
> +	bool
> +	help
> +	  An arch should select this symbol if it provides all of these things:
> +	  - syscall_get_arch()
> +	  - syscall_get_arguments()
> +	  - syscall_rollback()
> +	  - syscall_set_return_value()
> +	  - SIGSYS siginfo_t support
> +	  - secure_computing is called from a ptrace_event()-safe context
> +	  - secure_computing return value is checked and a return value of -1
> +	    results in the system call being skipped immediately.
> +	  - seccomp syscall wired up
> +
> +config SECCOMP_MEMMAP
> +	def_bool y
> +	depends on HAVE_ARCH_SECCOMP_MEMMAP && SECCOMP
> +	help
> +	  Enable tasks to trap syscalls based on the page that triggered
> +	  the syscall.
> +

Since I don't see anything distinct in the requirements for
SECCOMP_MEMMAP, so I don't think it needs a separate CONFIG: it is almost
entirely built on the SECCOMP_FILTER infrastructure. I'd just drop the
CONFIGs.

>  config HAVE_ARCH_STACKLEAK
>  	bool
>  	help
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2d3f963fd6f1..70998b01c533 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -145,6 +145,7 @@ config X86
>  	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
>  	select HAVE_ARCH_PREL32_RELOCATIONS
>  	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_SECCOMP_MEMMAP

(and it's not arch-specific)

>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_STACKLEAK
>  	select HAVE_ARCH_TRACEHOOK
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5a323422d783..6271fb7fd5bc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -294,11 +294,13 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
> +#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
>  #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
>  #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
>  #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
>  #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
> +#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
>  #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
>  
>  #ifdef CONFIG_ARCH_HAS_PKEYS
> @@ -340,6 +342,12 @@ extern unsigned int kobjsize(const void *objp);
>  # define VM_GROWSUP	VM_NONE
>  #endif
>  
> +#if defined(CONFIG_X86)
> +# define VM_NOSYSCALL	VM_HIGH_ARCH_5
> +#else
> +# define VM_NOSYSCALL	VM_NONE
> +#endif
> +
>  /* Bits set in the VMA until the stack is in its final location */
>  #define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
>  

I have no idea what the correct way to mark VMAs would be. As you
mentioned, this seems ... wrong. :)

> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 4b08e9c9c538..a5ca42eb685a 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -94,7 +94,8 @@ static inline void vm_unacct_memory(long pages)
>   */
>  static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
>  {
> -	return (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM)) == 0;
> +	return (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM
> +			 | PROT_NOSYSCALL)) == 0;
>  }
>  #define arch_validate_prot arch_validate_prot
>  #endif
> @@ -119,6 +120,7 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
>  	return _calc_vm_trans(prot, PROT_READ,  VM_READ ) |
>  	       _calc_vm_trans(prot, PROT_WRITE, VM_WRITE) |
>  	       _calc_vm_trans(prot, PROT_EXEC,  VM_EXEC) |
> +	       _calc_vm_trans(prot, PROT_NOSYSCALL, VM_NOSYSCALL) |
>  	       arch_calc_vm_prot_bits(prot, pkey);
>  }
>  
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index f94f65d429be..4eafbaa3f4bc 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -13,6 +13,8 @@
>  #define PROT_SEM	0x8		/* page may be used for atomic ops */
>  /*			0x10		   reserved for arch-specific use */
>  /*			0x20		   reserved for arch-specific use */
> +#define PROT_NOSYSCALL	0x40		/* page cannot trigger syscalls */
> +
>  #define PROT_NONE	0x0		/* page can not be accessed */
>  #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
>  #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */

AIUI, all of the above is to plumb the VMA marking through an mprotect()
call. I wonder if perhaps madvise() would be better? I'm not sure how
tight we are on new flags there, but I think it would be cleaner to use
that interface. Take a look at MADV_WIPEONFORK / VM_WIPEONFORK.

> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index c1735455bc53..c7d042a409e7 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -10,12 +10,14 @@
>  #define SECCOMP_MODE_DISABLED	0 /* seccomp is not in use. */
>  #define SECCOMP_MODE_STRICT	1 /* uses hard-coded filter. */
>  #define SECCOMP_MODE_FILTER	2 /* uses user-supplied filter. */
> +#define SECCOMP_MODE_MEMMAP	3 /* Lock syscalls per memory region. */

Making this incompatible with FILTER might cause problems for the future
(more and more process launchers are starting to set filters).

So this would, perhaps, be a new flag for struct seccomp, rather than a
new operating mode.

>  
>  /* Valid operations for seccomp syscall. */
>  #define SECCOMP_SET_MODE_STRICT		0
>  #define SECCOMP_SET_MODE_FILTER		1
>  #define SECCOMP_GET_ACTION_AVAIL	2
>  #define SECCOMP_GET_NOTIF_SIZES		3
> +#define SECCOMP_SET_MODE_MEMMAP		4
>  
>  /* Valid flags for SECCOMP_SET_MODE_FILTER */
>  #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 55a6184f5990..ebf09b02db8d 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -930,6 +930,55 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>  }
>  #endif
>  
> +#ifdef CONFIG_SECCOMP_MEMMAP
> +static int __seccomp_memmap(int this_syscall, const struct seccomp_data *sd)
> +{
> +	struct vm_area_struct *vma = find_vma(current->mm,
> +					      sd->instruction_pointer);
> +	if (!vma)
> +		BUG();

No new kernel code should use BUG:
https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on

I would maybe pr_warn_once(), but then treat it as if it was marked with
VM_NOSYSCALL.

> +
> +	if (!(vma->vm_flags & VM_NOSYSCALL))
> +		return 0;
> +
> +	syscall_rollback(current, task_pt_regs(current));
> +	seccomp_send_sigsys(this_syscall, 0);
> +
> +	seccomp_log(this_syscall, SIGSYS, SECCOMP_RET_TRAP, true);
> +
> +	return -1;
> +}

This really just looks like an ip_address filter, but I get what you
mean about stacking filters, etc. This may finally be the day we turn to
eBPF in seccomp, since that would give you access to using a map lookup
on ip_address, and the map could be updated externally (removing the
need for the madvise() changes).

> +
> +static long seccomp_set_mode_memmap(unsigned int flags)
> +{
> +	const unsigned long seccomp_mode = SECCOMP_MODE_MEMMAP;
> +	long ret = 0;
> +
> +	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
> +		return -EINVAL;

This should just test for any bits in flags. TSYNC + memmap should be
avoided, IMO.

> +
> +	spin_lock_irq(&current->sighand->siglock);
> +
> +	if (seccomp_may_assign_mode(seccomp_mode))
> +		seccomp_assign_mode(current, seccomp_mode, flags);
> +	else
> +		ret = -EINVAL;
> +
> +	spin_unlock_irq(&current->sighand->siglock);
> +
> +	return ret;
> +}
> +#else
> +static int __seccomp_memmap(int this_syscall, const struct seccomp_data *sd)
> +{
> +	BUG();
> +}
> +static long seccomp_set_mode_memmap(unsigned int flags)
> +{
> +	return -EINVAL;
> +}
> +#endif /* CONFIG_SECCOMP_MEMMAP */
> +
>  int __secure_computing(const struct seccomp_data *sd)
>  {
>  	int mode = current->seccomp.mode;
> @@ -948,6 +997,8 @@ int __secure_computing(const struct seccomp_data *sd)
>  		return 0;
>  	case SECCOMP_MODE_FILTER:
>  		return __seccomp_filter(this_syscall, sd, false);
> +	case SECCOMP_MODE_MEMMAP:
> +		return __seccomp_memmap(this_syscall, sd);
>  	default:
>  		BUG();
>  	}
> @@ -1425,6 +1476,10 @@ static long do_seccomp(unsigned int op, unsigned int flags,
>  			return -EINVAL;
>  
>  		return seccomp_get_notif_sizes(uargs);
> +	case SECCOMP_SET_MODE_MEMMAP:
> +		if (uargs != NULL)
> +			return -EINVAL;
> +		return seccomp_set_mode_memmap(flags);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1462,6 +1517,10 @@ long prctl_set_seccomp(unsigned long seccomp_mode, void __user *filter)
>  		op = SECCOMP_SET_MODE_FILTER;
>  		uargs = filter;
>  		break;
> +	case SECCOMP_MODE_MEMMAP:
> +		op = SECCOMP_SET_MODE_MEMMAP;
> +		uargs = NULL;
> +		break;

The prctl() interface is deprecated, so no new features should be added
there.

>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 494192ca954b..6b5c00e8bbdc 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -591,7 +591,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  		 * cleared from the VMA.
>  		 */
>  		mask_off_old_flags = VM_READ | VM_WRITE | VM_EXEC |
> -					VM_FLAGS_CLEAR;
> +			VM_NOSYSCALL | VM_FLAGS_CLEAR;
>  
>  		new_vma_pkey = arch_override_mprotect_pkey(vma, prot, pkey);
>  		newflags = calc_vm_prot_bits(prot, new_vma_pkey);
> -- 
> 2.27.0.rc2
> 

So, yes, interesting. I'll continue to think about how this could work
best. Can you share what your filters looked like when you were
originally trying those?

Thanks!

-Kees

-- 
Kees Cook

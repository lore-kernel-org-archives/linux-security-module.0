Return-Path: <SRS0=UHBo=7N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C03C433DF
	for <linux-security-module@archiver.kernel.org>; Sun, 31 May 2020 05:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131FA20723
	for <linux-security-module@archiver.kernel.org>; Sun, 31 May 2020 05:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgEaF43 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 31 May 2020 01:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaF43 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 31 May 2020 01:56:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81442C05BD43;
        Sat, 30 May 2020 22:56:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 105B32A34F1
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Gofman <gofmanp@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
Organization: Collabora
References: <20200530055953.817666-1-krisman@collabora.com>
        <202005300923.B245392C@keescook>
Date:   Sun, 31 May 2020 01:56:22 -0400
In-Reply-To: <202005300923.B245392C@keescook> (Kees Cook's message of "Sat, 30
        May 2020 10:30:57 -0700")
Message-ID: <851rn0ejg9.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Kees Cook <keescook@chromium.org> writes:

> On Sat, May 30, 2020 at 01:59:53AM -0400, Gabriel Krisman Bertazi wrote:
>> Modern Windows applications are executing system call instructions
>> directly from the application's code without going through the WinAPI.
>> This breaks Wine emulation, because it doesn't have a chance to
>> intercept and emulate these syscalls before they are submitted to Linux.
>> 
>> In addition, we cannot simply trap every system call of the application
>> to userspace using PTRACE_SYSEMU, because performance would suffer,
>> since our main use case is to run Windows games over Linux.  Therefore,
>> we need some in-kernel filtering to decide whether the syscall was
>> issued by the wine code or by the windows application.
>
> Interesting use-case! It seems like you're in the position of needing to
> invert the assumption about syscalls: before you knew everything going
> through WinAPI needed emulation, and now you need to assume everything
> not going through a native library needs emulation. Oof.
>
> Is it possible to disassemble and instrument the Windows code to insert
> breakpoints (or emulation calls) at all the Windows syscall points?

Hi Kees,

I considered instrumenting the syscall instructions with calls to some
wrapper, but I was told that modifying the game in memory or on disk
will trigger all sorts of anti-cheating mechanisms (my main use case are
windows games).

>> [...]
>> * Why not SECCOMP_MODE_FILTER?
>> 
>> We experimented with dynamically generating BPF filters for whitelisted
>> memory regions and using SECCOMP_MODE_FILTER, but there are a few
>> reasons why it isn't enough nor a good idea for our use case:
>> 
>> 1. We cannot set the filters at program initialization time and forget
>> about it, since there is no way of knowing which modules will be loaded,
>> whether native and windows.  Filter would need a way to be updated
>> frequently during game execution.
>> 
>> 2. We cannot predict which Linux libraries will issue syscalls directly.
>> Most of the time, whitelisting libc and a few other libraries is enough,
>> but there are no guarantees other Linux libraries won't issue syscalls
>> directly and break the execution.  Adding every linux library that is
>> loaded also has a large performance cost due to the large resulting
>> filter.
>
> Just so I can understand the expected use: given the dynamic nature of
> the library loading, how would Wine be marking the VMAs?

Paul (cc'ed) is the wine expert, but my understanding is that memory
allocation and initial program load of the emulated binary will go
through wine.  It does the allocation and mark the vma accordingly
before returning the allocated range to the windows application.

>> 3. As I mentioned before, performance is critical.  In our testing with
>> just a single memory segment blacklisted/whitelisted, the minimum size
>> of a bpf filter would be 4 instructions.  In that scenario,
>> SECCOMP_MODE_FILTER added an average overhead of 10% to the execution
>> time of sysinfo(2) in comparison to seccomp disabled, while the impact
>> of SECCOMP_MODE_MEMMAP was averaged around 1.5%.
>
> Was the BPF JIT enabled? I was recently examining filter performance too:
> https://lore.kernel.org/linux-security-module/202005291043.A63D910A8@keescook/

yes:

root@dilma:~# sysctl -a | grep -i jit
net.core.bpf_jit_enable = 1
net.core.bpf_jit_harden = 0

>
>> Indeed, points 1 and 2 could be worked around with some userspace work
>> and improved SECCOMP_MODE_FILTER support, but at a high performance and
>> some stability cost, to obtain the semantics we want.  Still, the
>> performance would suffer, and SECCOMP_MODE_MEMMAP is non intrusive
>> enough that I believe it should be considered as an upstream solution.
>
> It looks like you're using SECCOMP_RET_TRAP for this? Signal handling
> can be pretty slow. Did you try SECCOMP_RET_USER_NOTIF?

I experimented with SECCOMP_RET_TRAP and SECCOMP_RET_TRACE, but I hadn't
consider USER_NOTIF.  It seems to be a quite recent feature and I wasn't
aware of it.  I will try it and let you know.

>> diff --git a/include/linux/mman.h b/include/linux/mman.h
>> index 4b08e9c9c538..a5ca42eb685a 100644
>> --- a/include/linux/mman.h
>> +++ b/include/linux/mman.h
>> @@ -94,7 +94,8 @@ static inline void vm_unacct_memory(long pages)
>>   */
>>  static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
>>  {
>> -	return (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM)) == 0;
>> +	return (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM
>> +			 | PROT_NOSYSCALL)) == 0;
>>  }
>>  #define arch_validate_prot arch_validate_prot
>>  #endif
>> @@ -119,6 +120,7 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
>>  	return _calc_vm_trans(prot, PROT_READ,  VM_READ ) |
>>  	       _calc_vm_trans(prot, PROT_WRITE, VM_WRITE) |
>>  	       _calc_vm_trans(prot, PROT_EXEC,  VM_EXEC) |
>> +	       _calc_vm_trans(prot, PROT_NOSYSCALL, VM_NOSYSCALL) |
>>  	       arch_calc_vm_prot_bits(prot, pkey);
>>  }
>>  
>> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
>> index f94f65d429be..4eafbaa3f4bc 100644
>> --- a/include/uapi/asm-generic/mman-common.h
>> +++ b/include/uapi/asm-generic/mman-common.h
>> @@ -13,6 +13,8 @@
>>  #define PROT_SEM	0x8		/* page may be used for atomic ops */
>>  /*			0x10		   reserved for arch-specific use */
>>  /*			0x20		   reserved for arch-specific use */
>> +#define PROT_NOSYSCALL	0x40		/* page cannot trigger syscalls */
>> +
>>  #define PROT_NONE	0x0		/* page can not be accessed */
>>  #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
>>  #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
>
> AIUI, all of the above is to plumb the VMA marking through an mprotect()
> call. I wonder if perhaps madvise() would be better? I'm not sure how
> tight we are on new flags there, but I think it would be cleaner to use
> that interface. Take a look at MADV_WIPEONFORK / VM_WIPEONFORK.

Right, will do.  I considered it, but wasn't sure if madvise semantics
gave any guarantees of the result, but is seems to be the case for at
least for WIPEONFORK.  it is important to have it configurable on mmap
too, to avoid the extra syscall.  Plumbing through the mmap flags
argument shouldn't be a problem.

>> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
>> index c1735455bc53..c7d042a409e7 100644
>> --- a/include/uapi/linux/seccomp.h
>> +++ b/include/uapi/linux/seccomp.h
>> @@ -10,12 +10,14 @@
>>  #define SECCOMP_MODE_DISABLED	0 /* seccomp is not in use. */
>>  #define SECCOMP_MODE_STRICT	1 /* uses hard-coded filter. */
>>  #define SECCOMP_MODE_FILTER	2 /* uses user-supplied filter. */
>> +#define SECCOMP_MODE_MEMMAP	3 /* Lock syscalls per memory region. */
>
> Making this incompatible with FILTER might cause problems for the future
> (more and more process launchers are starting to set filters).
>
> So this would, perhaps, be a new flag for struct seccomp, rather than a
> new operating mode.

Yes, agreed.  I guess it would be a real scenario, even for us, to have
isolation against malicious syscalls (MODE_FILTER) combined
with region protection (MEMAP) for emulation.

>
>>  
>>  /* Valid operations for seccomp syscall. */
>>  #define SECCOMP_SET_MODE_STRICT		0
>>  #define SECCOMP_SET_MODE_FILTER		1
>>  #define SECCOMP_GET_ACTION_AVAIL	2
>>  #define SECCOMP_GET_NOTIF_SIZES		3
>> +#define SECCOMP_SET_MODE_MEMMAP		4
>>  
>>  /* Valid flags for SECCOMP_SET_MODE_FILTER */
>>  #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
>> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>> index 55a6184f5990..ebf09b02db8d 100644
>> --- a/kernel/seccomp.c
>> +++ b/kernel/seccomp.c
>> @@ -930,6 +930,55 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_SECCOMP_MEMMAP
>> +static int __seccomp_memmap(int this_syscall, const struct seccomp_data *sd)
>> +{
>> +	struct vm_area_struct *vma = find_vma(current->mm,
>> +					      sd->instruction_pointer);
>> +	if (!vma)
>> +		BUG();
>
> No new kernel code should use BUG:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on
>
> I would maybe pr_warn_once(), but then treat it as if it was marked with
> VM_NOSYSCALL.
>
>> +
>> +	if (!(vma->vm_flags & VM_NOSYSCALL))
>> +		return 0;
>> +
>> +	syscall_rollback(current, task_pt_regs(current));
>> +	seccomp_send_sigsys(this_syscall, 0);
>> +
>> +	seccomp_log(this_syscall, SIGSYS, SECCOMP_RET_TRAP, true);
>> +
>> +	return -1;
>> +}
>
> This really just looks like an ip_address filter, but I get what you
> mean about stacking filters, etc. This may finally be the day we turn to
> eBPF in seccomp, since that would give you access to using a map lookup
> on ip_address, and the map could be updated externally (removing the
> need for the madvise() changes).

And 64-bit comparisons :)

that would be a good solution, we'd still need to look at some details,
like disabling/updating filters at runtime when some new library is
loaded, but since we can update externally, I think it covers it.

From the wine side, it should be enough to get the semantics we want,
but I don't know about performance.

>> +
>> +static long seccomp_set_mode_memmap(unsigned int flags)
>> +{
>> +	const unsigned long seccomp_mode = SECCOMP_MODE_MEMMAP;
>> +	long ret = 0;
>> +
>> +	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
>> +		return -EINVAL;
>
> This should just test for any bits in flags. TSYNC + memmap should be
> avoided, IMO.

Maybe it is worth to expose SECCOMP_FILTER_FLAG_LOG?

>>  	default:
>>  		return -EINVAL;
>>  	}
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index 494192ca954b..6b5c00e8bbdc 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -591,7 +591,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>>  		 * cleared from the VMA.
>>  		 */
>>  		mask_off_old_flags = VM_READ | VM_WRITE | VM_EXEC |
>> -					VM_FLAGS_CLEAR;
>> +			VM_NOSYSCALL | VM_FLAGS_CLEAR;
>>  
>>  		new_vma_pkey = arch_override_mprotect_pkey(vma, prot, pkey);
>>  		newflags = calc_vm_prot_bits(prot, new_vma_pkey);
>> -- 
>> 2.27.0.rc2
>> 
>
> So, yes, interesting. I'll continue to think about how this could work
> best. Can you share what your filters looked like when you were
> originally trying those?

The results I shared in the previous email had the following filter:

  BPF_STMT(BPF_LD | BPF_W | BPF_ABS, (offsetof(struct seccomp_data, nr))),
  BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 0xf000, 0, 1),
  BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_TRAP),
  BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),

Which is much much simpler than the real thing.  I also had a small
filter generator that generated segments like the following ( ip_HW and
ip_LW are the high and low part of the instruction pointer):

  0007: BPF_STMT(BPF_LD | BPF_W | BPF_ABS, ip_HW)
  0008: BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, EH, 0, REL_ADDR(next))
  0009: BPF_STMT(BPF_LD | BPF_W | BPF_ABS, ip_LW)
  000a: BPF_JUMP(BPF_JMP | BPF_JGT | BPF_K, EL, REL_ADDR(next), 0)
  000b: BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, SL, REL_ADDR(filter->jump_allow_target), REL_ADDR(next))
  000c: next:

Thanks,

-- 
Gabriel Krisman Bertazi

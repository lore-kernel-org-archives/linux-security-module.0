Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C320F062;
	Thu,  6 Mar 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276269; cv=none; b=PKFmiKHd7cMoZZybJMQ8OxDw2pCKM7ViiGqewCWY+fBozz0gQTkd97Rk+eMmcqpnJoy9hchy1w35xMxd+cbEfU1PVvYGGZt0RGYSvjMXyiDXu23G1jk45TOeTecO5GZfFjBqic1XPoOI6RAJr1CDJUNHoP6vZ8quj32zVLDU2LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276269; c=relaxed/simple;
	bh=LkNiB8ssIQSLhvWf7RP2EKdzX+m6cmepuOT5ISHD+lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hutx/w+y1ttu1syinTJClGiWXsVNo3fNRk1dQ6Vr47/bUEAM+qaU1pUQUOwLzSGdCKwy8E4jxfaRTNeBinKsqq0Den/QACOaw6aw1aRXqQR6i+7HAHcSDIfz8HUVIFJDoSagBExXOej6oUg6Ujx0lLE9xVwpDBr+JuBRB/+09Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=SjbrnTyx; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="SjbrnTyx"
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526FUYBE014596;
	Thu, 6 Mar 2025 15:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=OoAB8oc0l5H+OAcNL9iABMt
	w26VE67WxQGMg8Q73atI=; b=SjbrnTyxvUee/xdT3azUfd11rsHOpoiuqicSyc7
	u0ePWYZembeOLP2in0c0UZKSBcllSwRF6Id6gPJN3nMXsZsaRE0X2fD5MuBmshUI
	KEQpGYs10+p4PfxMo2vbPQiYtk0UDZFRWGdCuDa96HeuMg8V5wtTYrBHDAMet7i+
	eE7uDrkSyzlQ35fGF8pVbPhZQyykqVIIb5Q6hOs/MOreylA6YdAUM7e/05JvYykN
	jfDc/DXWZLho8bgAKz+wvSnvUhLECg0jcT2M5k3twYxDd+7WY7u3FN56lItX8cL3
	sIc/fAkOaB9rdy5uL7pUmPhQTJXg1YOVEc55pV3Hh3cKaCA==
Received: from iadlppfpol2.lenovo.com ([104.232.228.81])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 4577w59yty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 15:50:26 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (unknown [100.65.83.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by iadlppfpol2.lenovo.com (Postfix) with ESMTPS id 4Z7v576JLHzYkjd6;
	Thu,  6 Mar 2025 15:50:19 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.11.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4Z7v5F3V1Dz3npb4;
	Thu,  6 Mar 2025 15:50:25 +0000 (UTC)
Date: Thu, 6 Mar 2025 09:50:25 -0600
From: Maxwell Bland <mbland@motorola.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Wheeler <awheeler@motorola.com>,
        Sammy BS2 Que <quebs2@motorola.com>
Subject: Re: [RFC] Type-Partitioned vmalloc (with sample *.ko code)
Message-ID: <2wf4kmoqqmod6njviaq33lbxbx6gvdqbksljxykgltwnxo6ruy@7ueumwmxxh72>
References: <uqgb234tm4svoz2yvbamzal2srxnjnwrj2coiimvuz5bzblbia@pfabobbxo2jf>
 <202503030942.307489FC8@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503030942.307489FC8@keescook>
X-Proofpoint-ORIG-GUID: HRZjjx0ILBM6uUJ8hcPhdyQ0lopKtMRV
X-Authority-Analysis: v=2.4 cv=BKdJrEQG c=1 sm=1 tr=0 ts=67c9c442 cx=c_pps a=Bzw+04pMMuzJwu0RtP1G/Q==:117 a=Bzw+04pMMuzJwu0RtP1G/Q==:17 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=xy62-MGwAAAA:8 a=1XWaLZrsAAAA:8
 a=JfrnYn6hAAAA:8 a=cNpgnZFxEaXsCvOYhScA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=GnfvfRyZ3owwWl8_2aAi:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: HRZjjx0ILBM6uUJ8hcPhdyQ0lopKtMRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060120

On Mon, Mar 03, 2025 at 10:26:16AM -0800, Kees Cook wrote:
> On Fri, Feb 28, 2025 at 02:57:40PM -0600, Maxwell Bland wrote:
> > Summarizing, there are thousands of dynamic data structures alloc'd and
> > free'd in the kernel all the time, for files, for processes, and so
> > forth, and it is elementary to manipulate any instance of data, but hard
> > to protect every single one of them. These range from trng device
> > pointers to kworker queues---everything passing through vmalloc.
> > 
> > - Reorganizing allocations of those structures so that they are on
> > the same 2MB hugepage, adjacently, as otherwise existing hardware
> > support to prevent their mutation (PTE flags) will trigger for unrelated
> > data allocated adjacently.
> 
> This sounds like the "write rarely" proposal:
> https://github.com/KSPP/linux/issues/130
> 
> which isolates chosen data structures into immutable memory, except for
> specific helpers which are allowed to write to the memory. This is
> needed most, by far, for page tables:
> https://lore.kernel.org/lkml/20250203101839.1223008-1-kevin.brodsky@arm.com/

Thank you for this pointer and the others below. I spent a lot of time
the past two days thinking about your email and the links.

> It looks from your example at the end that you're depending on a
> hypervisor to perform the memory protection and fault handling? Or maybe
> I'm misunderstanding where the protection is happening?

Correct. I use the fault handler, proper, though, and optimize it
through careful management of protected vs. unprotected resources, which
pushes me up against the problem of determining specific policies for
each type of kmalloc.

> 
> > - Writing a handler to ensure non-malicious modifications, e.g.  keeping
> > "const" fields const, ensuring modifications to other fields happen at
> > the right physical PC values and the right pages, handling atomic
> > updates so that the exception fault on these values maintains ordering
> > under race conditions (maybe "doubling up" on atomic assembly operations
> > due to certain microarch issues at the chipset level, see below), and so
> > on, and so forth.
> 
> As I understand it, this depends on avoiding ROP attacks that will hijack
> those PC values. (This is generally true for the entire concept of
> "write rarely", though -- nothing specific to this implementation.)

I think a more general solution to this problem, leveraging the POE
mechanism (or just stage-2 translation tables), is to build something on
top of or around CFI.  This is natural since the protections already
assume CFI for the data tagging. I can imagine some GCC plugin or
compiler pass for functions, which can appropriately inject
unlock/relock calls around "critical" functions (part of the paciasp
instrumentation).

In fact, I rewrote the QCOM SMC handler to ensure the lock/unlock
semantics were inlined into the specific data operation context, to
prevent creation of a privilege escalation callgate given a CFI bypass.
I attached the code for this at the end.

I will bring this and some other points up to Kevin.

> The current proposals use a method of gaining temporary write permission
> during the execution path of an approved writer (rather than doing it
> via the fault handler, which tends to be very expensive).

I've not found the fault handler approach to be too expensive, at least
for a system matching all current guarantees. Once we begin talking
about struct file's f_lock and every kmalloc, I am inclined to agree.

I think a fault handler based solution can still get a lot of distance
if frequently updated fields of structs were indirected through pointers
(and separate kmalloc calls).

One issue with the POE and other solutions I see is also a lack of
infrastructure for applying specific policies to updates on data
structures: it's one thing to lock the page table outside of
set_memory_rw, but another to ensure the arguments to that API are
not corrupted, e.g. overwriting plt->target here?

arch/arm64/net/bpf_jit_comp.c
2417:		if (set_memory_rw(PAGE_MASK & ((uintptr_t)&plt->target),

> > I demonstrated something similar previously to prevent the intermixed
> > allocation of SECCOMP BPF code pages with data on ARM64's Android Kernel
> > here (with which you may be familiar):
> > 
> > https://lore.kernel.org/all/20240423095843.446565600-1-mbland@motorola.com/
> 
> Did this v4 go any further? I see earlier versions had some discussion
> around it.

No response, so I did not stress the issue (should I have?) I ended up
just hacking around Google's GKI, so upstreaming was no longer
necessary.

> in here... Do you mean to make a distinction between the allocators?
> Linux has 3 allocators: page(buddy), kmalloc(kmem), and vmalloc(vmap).

I guess so, though the vmalloc cases for swap and bpf are important:

void __always_inline patch_jump_to_handler(void *faddr, void *helper)
{
	u32 insn;
	insn = aarch64_insn_gen_branch_imm_ind((unsigned long)faddr,
					       (unsigned long)helper,
					       AARCH64_INSN_BRANCH_NOLINK);
	aarch64_insn_patch_text_nosync_ind(faddr, insn);
}

...

/* This works since even though it is "inline", the function is not
 * inlined, so we can kallsyms reference it and patch it */
void bpf_jit_binary_lock_ro_injector(struct bpf_binary_header *hdr)
{
	/* set_vm_flush_reset_perms(hdr); */
	struct vm_struct *vm = find_vm_area_ind((void *)hdr);

	if (vm)
		vm->flags |= VM_FLUSH_RESET_PERMS;

	if (run_CVE_2021_33909) {
		hdr->image[8] = 0x13;
		hdr->image[9] = 0x37;
		hdr->image[10] = 0x13;
		hdr->image[11] = 0x37;
		pr_info("LOCK RO HERE!\n");
		run_CVE_2021_33909 = 0;
	}

	set_mem_ro((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
	set_mem_x((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
}

> A dedicated kmem cache should live in its own page, so I don't think
> anything special is needed for things already using kmem_cache_create(),
> except that they must not be aliased with same-sized allocations. (i.e.
> include the SLAB_NO_MERGE flag.)

Hmm, I thought the write faults on allocated pages were from other types
of data, but maybe I made a mistake here, and it was actually other
`struct file`. This is good to know if true, thank you.

> Doing this automatically requires compiler support to provide a way to
> distinguish types from the lvalue of an expression:
> 
> // kmalloc has no idea what type it will provide an allocation for
> struct whatever *p = kmalloc(...);
> 
> Or, for the allocation system in the kernel to be totally rearranged to
> pass the variable into a helper so the type (and things like alignment)
> can be introspected. I proposed doing that here:
> https://lore.kernel.org/all/20240822231324.make.666-kees@kernel.org/
> 
> It's unclear if this approach will be successful, and I've been waiting
> for compiler support of "counted_by" to be more widely usable.
> 
> An alternative is to separate allocations by call site (rather than
> type). This has some performance benefits too, and requires no special
> compiler support. I proposed that here:
> https://lore.kernel.org/all/20240809072532.work.266-kees@kernel.org/
> 
> With this in place, simple Use-After-Free type confusion is blocked,
> but not cross-cache attacks. To defend against cross-cache UAF attacks,
> full separation of the virtual memory spaces ("memory allocation pinning")
> is needed. SLAB_VIRTUAL has been proposed here:
> https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/

The above were super valuable! One insight that I've had, related to the
third link above is that if you do have a lock/unlock tracking based on
allocation/deallocation (the second link, or my file tracking from the
last email), you can get a KASAN-like UAF tracking, since if you see a
fault from a PC on a resource which has already trapped into the "free"
handler (and no corresponding alloc), then this can trip a fault.

Essentially, a hashmap tracking each page and associating it to the
current kmalloc type... but I think SLAB_VIRTUAL also achieves this by
preventing te reuse of that virtual page.

> > Please let me know if you've seen anything else discussing this problem,
> > particularly anything that might save me from having to rewrite the
> > virtual memory allocator in our OS to prevent these attacks.
> 
> Hopefully some (all) of the proposals above should provide you with the
> desired coverage, though if you're doing this on arm64 you'll need to
> implement the arch-specific portions of SLAB_VIRTUAL on arm64.

Absolutely, from the above, I still have some concerns and see some
limits to these approaches, but your insight that alloc_tag.h can be
used for type tracking and security is valuable, and maybe I can see if
Google can enable it for Android 16 (if they have not already).

> > The patches/discussions here:
> > https://lore.kernel.org/all/rsk6wtj2ibtl5yygkxlwq3ibngtt5mwpnpjqsh6vz57lino6rs@rcohctmqugn3/
> > https://lore.kernel.org/all/994dce8b-08cb-474d-a3eb-3970028752e6@infradead.org/
> 
> Has this moved forward? This got to a v5...

Similar case to the other patches, I didn't see much response, so did
not think I should really petition too hard for the changes, though they
are valuable for PXNTable enforcement.

I suppose no response to a patch does not mean it is dead.

> > https://lore.kernel.org/all/puj3euv5eafwcx5usqostpohmxgdeq3iout4hqnyk7yt5hcsux@gpiamodhfr54/
> 
> I think Peter Zijlstra solved all the BPF KCFI interactions? See commit
> 4f9087f16651 ("x86/cfi,bpf: Fix BPF JIT call")

Only x86. I supposed the BPF maintainers would integrate my ARM change
coalescing via other means. I have not checked back, but will ping the
BPF list again if there's still the *_handler CFI bypasses in more
recent kernels.

Cheers and thanks,
Maxwell Bland

Appendix 1. Rewritten QCOM SMCs

/* calls the appropriate smc to associate an smc call location labeled by
 * smc_call_tag_idiom with a tag in the hypervisor. QCOM won't let moto
 * do atomic calls, BTW )-: */
#define add_el2_smc_tag(smc_label_name, tagtype)                           \
	{                                                                  \
		__asm__("mrs x0, daif\n"                                   \
			"orr x0, x0, #0xF\n"                               \
			"msr daif, x0\n"                                   \
			"mov x3, x0\n"                                     \
			"sub x0, x0, x0\n"                                 \
			"movk x0, #0x0007\n"                               \
			"movk x0, #0x" SMC_TYPE_NONATOMIC "300, lsl #16\n" \
			"mov x1, 0\n"                                      \
			"adr x2, " #smc_label_name "\n"                    \
			"mov x3, %0\n"                                     \
			"smc #0\n"                                         \
			"msr daif, x3\n"                                   \
			:                                                  \
			: "r"((uint64_t)tagtype)                           \
			: "x0", "x1", "x2", "x3");                         \
	}

/*
 * Importantly, this idiom, and surrounding code, MUST INLINE to
 * the function in question, otherwise we run the risk of tag
 * allocation/deallocation being run via a CFI exploit. When
 * it is introduced into the function in question itself, then
 * it becomes possible to guarantee the surrounding code is
 * valid, and we are not deallocating outside of the rest of
 * the active kernel context.
 *
 * This makes it much harder for an adversary to "break" the
 * system because they cannot just forge a function pointer
 * to an arbitrary "unallocate tag" function, but must instead
 * forge a function pointer/CFI tag using xxhash to the
 * specific kernel operation being protected, and this
 * should lead to a myriad of adjacent consequences and
 * sanity checks.
 *
 * For example, in file_free_rcu, this means we have a strong
 * guarantee that the SMC call will be followed by a call to
 * put_cred, further cementing the necessary context for
 * free'ing the file struct.
 */
#define smc_call_tag_idiom(smc_type, smc_tag, smcid, res, arg, size)   \
	{                                                              \
		__asm__ __volatile__( \
				     "movz    x0, #0x000" smcid "\n"   \
				     "movk    x0, #0x" smc_type        \
				     "300, lsl #16\n"                  \
				     "mov     x1, 0\n"                 \
				     "mov     x2, %1\n"                \
				     "mov     x3, %2\n"                \
				     "stp     x29, x30, [sp, #-16]!\n" \
				     "mov     x29, sp\n" smc_tag ":\n" \
				     "smc     #0\n"                    \
				     "ldp     x29, x30, [sp], #16\n"   \
				     "mov     %0, x0\n"                \
				     : "=r"(res)                       \
				     : "r"(arg), "r"(size)             \
				     : "x0", "x1", "x2", "x3");  \
	}

static void __always_inline depreempt_sleep(void)
{
	uint64_t preempt_count_val = preempt_count();
	preempt_count_sub(preempt_count_val);
	msleep(30);
	preempt_count_add(preempt_count_val);
}

/* TODO: these need proper synchronization, not just msleep */
#define qcom_smc_waitloop(smc_tag, smcid_tag, arg, size)                   \
	{                                                                  \
		uint64_t smc_res = 0;                                      \
		do {                                                       \
			if (smc_res) \
				depreempt_sleep(); \
			smc_call_tag_idiom(SMC_TYPE_NONATOMIC, smc_tag,    \
					   smcid_tag, smc_res, arg, size); \
		} while (smc_res);                             \
		__asm__ __volatile__("dmb sy; dsb sy; isb;");              \
	}

#define qcom_smc_waitloop_nosleep(smc_tag, smcid_tag, arg, size)           \
	{                                                                  \
		uint64_t smc_res = 0;                                      \
		do {                                                       \
			if (smc_res) \
				mdelay(30); \
			smc_call_tag_idiom(SMC_TYPE_NONATOMIC, smc_tag,    \
					   smcid_tag, smc_res, arg, size); \
		} while (smc_res);                             \
		__asm__ __volatile__("dmb sy; dsb sy; isb;");              \
	}


#define qcom_smc_waitloop_mayfail(smc_tag, smcid_tag, arg, size)           \
	{                                                                  \
		uint64_t smc_res = 0;                                      \
		smc_call_tag_idiom(SMC_TYPE_NONATOMIC, smc_tag,    \
					smcid_tag, smc_res, arg, size); \
		__asm__ __volatile__("dmb sy; dsb sy; isb;");              \
	}


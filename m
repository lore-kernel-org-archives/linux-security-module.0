Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794978598;
	b=Pmd68wbbO+NE/HM2zXyb7N5YTCpA8B9d+YJCHICjeGy9A8KkwiMxLF6fgp4yXplIduMS
	 PIynsmMmuGsH0EWDXrv7Z4gVWY23bpwOqNy3zp8vqDvtHcD1hZhKGLyLAZmWL1PEz7if3
	 7mVvTinGDOmAjE2cvFBS01sGUGhUCD/kid81Bxe8wrSjargqq+PLQXDmJcwC4DIvA2D2f
	 rNiirWehjzRfdLzY8Xd8gjk+jNSOk2y5fSbzoOuAevTNew3eX7APMmTgsPBZLtjgXF0NW
	 ximadrxsCQkmzf5Lndq1MSnQ/h5ZLjFQbE5VVGwTOZFP539kTLYnLSF+0QHnLTxX4mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794978598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=94w7zfoHb1h/5IU62GWa+RuGhpaQ8snNzNZNBGJzn/0=;
	b=UJQTdYlOWQ05a+CIP6PNiNx4+DbF4XVzt2plJksq2Ux/JWPcKfiOQaeUTNET0sCXZSUY
	 jClQyCLCuWIBfBvwZCXZoPUE9IUAYn8PJOyd9oQlpJ1REQrzLiMxSC7/k2WP2nJTrR90v
	 97zoxclieKjcG69hscoAwYZYIMIgU4kXm0BHVZCVoosppEWTrzVLSCrBWn4np1f9Gx7ny
	 /xfQ1pcfQVQEb9DIVmoyswrl9EaIydgzkpXDidcJ1AhyGc5cHpxQgEnEkZBedZqwIrH2M
	 yFCYnRtXu/hQQ6Yhtv8ZKsAZrulSyi2WxkeLUL0P9TMTWLqX/ydG8+HwEJH1Eq97+WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=il2Fkdoj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC44606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=il2Fkdoj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEE71F000C4;
	Wed, 18 Nov 2026 05:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794978598;
	bh=94w7zfoHb1h/5IU62GWa+RuGhpaQ8snNzNZNBGJzn/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=il2Fkdojk1/zmSFyXaKxGS9NKV9ZALe7oON28kTxvqYTT5bQfco0oDmfx4NVilxCp
	 te8e1xuYk8UMetjUJWIA3EnT131pseDPjxlwfZVIcxYg8CQwP0q3kXQ34jWcKnnHH2
	 VAjWXk+e6IEzYGEL93Ee/NC2Y7MsMjvIFG6QBCnWkixZRk1+CF1mOCxxQ5MpWsh+p+
	 W/cZS6ZtHiX8hr7J46L+yZJiqN+QibsWpLITNmmStChVIIG+nsztwUu6QmXSWNMtSS
	 o4eo79N68MAD7/MJJLQ4xCndBuoEa02KgAiBHjZjmjfNtDrSh6KDthZU0zAm3cwo/q
	 EovNSXKSMNLgA==
Message-ID: <sashiko-outbox-220145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 10/13] arch: Wire up rootns system calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andrew Morton" <akpm@linux-foundation.org>, "Ben
 Segall" <bsegall@google.com>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Howells" <dhowells@redhat.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, "Dietmar Eggemann" <dietmar.eggemann@arm.com>, "Ingo
 Molnar" <mingo@redhat.com>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Juri
 Lelli" <juri.lelli@redhat.com>, "Kees Cook" <kees@kernel.org>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Manfred Spraul" <manfred@colorfullife.com>, "Mel
 Gorman" <mgorman@suse.de>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Neal
 Gompa" <neal@gompa.dev>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Peter Zijlstra" <peterz@infradead.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Valentin Schneider" <vschneid@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Vlastimil Babka" <vbabka@kernel.org>
In-Reply-To: <20261117050841.3289652-11-jarkko@kernel.org>
References: <20261117050841.3289652-1-jarkko@kernel.org>
 <20261117050841.3289652-11-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 05:09:56 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] arch: missing fork wrappers and copy_thread() handling for
  rootns_enter()
- [Medium] powerpc: syscalls: mark rootns syscalls as nospu instead of
  common
--

commit 6e1db5e1442ac6454b78c4391c7f17751ffafb5b
Author: Jarkko Sakkinen <jarkko@kernel.org>

arch: Wire up rootns system calls

This commit wires up the rootns_create(), rootns_wait(), rootns_kill(), and
rootns_enter() system calls across the architecture syscall tables and
asm-generic/unistd.h.

> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index 52e3538cc7df4..a945b15abe6dd 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -512,3 +512,7 @@
>  580	common	listns				sys_listns
>  581	common	rseq_slice_yield		sys_rseq_slice_yield
>  582	common	fchroot				sys_fchroot
> +583	common	rootns_create			sys_rootns_create
> +584	common	rootns_wait			sys_rootns_wait
> +585	common	rootns_kill			sys_rootns_kill
> +586	common	rootns_enter			sys_rootns_enter

[Severity: High]
Does wiring rootns_enter directly to sys_rootns_enter corrupt the child
process's user registers and leak kernel stack contents on architectures th=
at
require a fork-like entry wrapper?

sys_rootns_enter() calls kernel_clone() -> copy_process() -> copy_thread().
On Alpha, normal syscall entry (entSys) pops struct switch_stack before
calling the C handler, whereas fork, vfork, clone, and clone3 use fork_like
wrappers (alpha_clone3, etc.) to push struct switch_stack and call
__save_fpu().  Without that wrapper, copy_thread() copies
((struct switch_stack *)regs) - 1, which holds sys_rootns_enter()'s C stack
frame, into childstack and restores kernel stack words into the child's
r9-r15 registers in ret_from_fork.

The same issue affects the other architectures in this patch whose normal
syscall entry does not save callee-saved registers or register windows befo=
re
copy_thread():
- m68k needs a SAVE_SWITCH_STACK wrapper like __sys_clone3 so copy_thread()
  does not populate the child's switch_stack (d6-d7, a3-a6) from the C fram=
e.
- MIPS (o32, n32, n64) needs save_static_function() so s0-s8 are saved into
  struct pt_regs before copy_thread().
- PA-RISC needs a fork_like wrapper like sys_clone3_wrapper to save r3-r18
  and cr27 into task->thread.regs.
- SPARC (32-bit and 64-bit) needs an assembly wrapper like __sys_clone3 /
  sparc_clone3 to flush register windows and call synchronize_user_stack(),
  and copy_thread() in process_32.c and process_64.c needs to check for
  __NR_rootns_enter alongside __NR_clone3 so it does not apply SunOS fork()
  return conventions (which set the child's %o0 to current->pid instead of 0
  and clobber %o1).
- ARC, Nios II, and OpenRISC (via include/uapi/asm-generic/unistd.h and
  scripts/syscall.tbl) likewise require their callee-saved register /
  switch_stack wrappers before calling sys_rootns_enter().

[ ... ]

> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kern=
el/syscalls/syscall.tbl
> index cfbb70039ff00..610ceedd1a14c 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -563,3 +563,7 @@
>  470	common	listns				sys_listns
>  471	nospu	rseq_slice_yield		sys_rseq_slice_yield
>  472	common	fchroot				sys_fchroot
> +473	common	rootns_create			sys_rootns_create
> +474	common	rootns_wait			sys_rootns_wait			compat_sys_rootns_wait
> +475	common	rootns_kill			sys_rootns_kill
> +476	common	rootns_enter			sys_rootns_enter

[Severity: Medium]
Should the rootns syscalls, especially rootns_enter, be marked nospu instead
of common on PowerPC?

Entries marked common are included in spu_syscall_table[] and can be invoked
by a Cell SPU program via spu_process_callback() -> spu_sys_callback() while
the host PowerPC thread is inside spufs_run_spu().  Process creation and wa=
it
syscalls (fork, vfork, clone, clone3, waitid) are marked nospu so an SPU
context cannot clone the host PPE thread from inside sys_spu_run().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117050841.3289=
652-1-jarkko@kernel.org?part=3D10

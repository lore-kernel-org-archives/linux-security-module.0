Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214683;
	b=1+Q+7Dp5D3fSTrC9y2agSH7LGxCIEOm9p3MilaMj/mJoEPN5XTaoJ7rtGnG9IUXXY6Zb
	 NIWPaY58khTsKj1R9YLRUlan8Bj2TsUBiVKJT2kq14sRxpGhehXqRHPlo2pvXlURm5RUw
	 RMOv3TUIVc/R8E77qUyg0qmY5wNWmZblph/kceTff7+lTr0WbtWHVIJpacs9NGLYVOqBH
	 tS4y32h9J19wAMCNVH0oxv7UJQbcTOpHf+bkm1tuMC/Qb9i+HJeQlR2GXPqdipE2/rSJ4
	 CCI9L9EzuHFWSJlx/ef4QeS+Mx9nYbu+HClPqyfbJJ+cWgVzKZgoM0iWhtNJ2nJxQRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214683;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GDJBVsAd6JtWMDQ/ABjrxTbwcVxlwsrHr9o1YDsX7iE=;
	b=Nq8+IcvIwLvS7gbavQrHPGD6TRnuRveOwB3Gx0pCu7o0xLAISl526ZhtJ4btWqAhhjIg
	 iVZxgOCvlJmangcXSRW2i7JOkj0/MNqC/GQuUOaQijdUkifTBXgxa/oaEqacJmAfKs2fh
	 IXP1b5nHzEdWrvZK2f4n7XQoQAlaXyNqsS4A0/pLuCW46RMMydChDtPkPtXE708t58CLU
	 YiBwmoaQovZQugh96oJwUvMcT0Lrim+lFN6EdlwM+WW4m7seDgna0hcZzQhK4porHuv2Y
	 8CvZN7KM2TlsfFzUn33XUR0lZZgoZ6J1U2/qTt/mmIKXfL3RSLYTFxsHeR9pOqxIfHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzyVXU3J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA3606A696
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzyVXU3J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0081F000C4;
	Fri, 20 Nov 2026 22:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795214682;
	bh=GDJBVsAd6JtWMDQ/ABjrxTbwcVxlwsrHr9o1YDsX7iE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TzyVXU3JZKz+G6iv26QMl86cOJH4T6cdW67UKDT+sTicT4bpZ6PRxigNNzsBN9Weg
	 dX1wwwNonGIGAN79xQ294YlLIuJT5rNbXi0+x5jRleU4eSxz+RXrhhpS/n4gs/jMaj
	 +E3rHJRAZQb4eS8x/aTfUrPfVUTT4z5RjsRJR+Ocjb8IfGW/gWqmliKG1zXAPCgUiP
	 cgnsUESY+O2XpbIVy7OubMMFC+xjfg6+8+zrG/HWj0uuUkfN03o05o6qTNtxXEw8m6
	 Mt2SaFlA+pIK9rxe3QoyDzdB16Mk/5+nIee49ePPRYUKoepHhzTZ14y968juTU3las
	 bI1nF98MdMgbg==
Message-ID: <sashiko-outbox-226299@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 07/14] fork: Support CLONE_INTO_ROOTNS in
 clone3()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Andreas Larsson" <andreas@gaisler.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Andy Lutomirski" <luto@amacapital.net>, "Andy
 Lutomirski" <luto@kernel.org>, "Anna-Maria Behnsen" <anna-maria@linutronix.de>, "Arnd
 Bergmann" <arnd@arndb.de>, "Ben Segall" <bsegall@google.com>, "Borislav
 Petkov" <bp@alien8.de>, "Casey Schaufler" <casey@schaufler-ca.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Christian
 Brauner" <brauner@kernel.org>, =?utf-8?b?Q2hyaXN0b3BoZSBMZXJveSAoQ1Mg?=
 =?utf-8?b?R1JPVVAp?= <chleroy@kernel.org>, "Chris Zankel" <chris@zankel.net>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "David Hildenbrand" <david@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Davidlohr Bueso" <dave@stgolabs.net>, "David
 S. Miller" <davem@davemloft.net>, "Dietmar Eggemann" <dietmar.eggemann@arm.com>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Hallgrimur
 H. Gunnarsson" <halg@google.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Helge
 Deller" <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>, "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Jan Kara" <jack@suse.cz>, "John
 Johansen" <john.johansen@canonical.com>, "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Jonathan
 Corbet" <corbet@lwn.net>, "Josef Bacik" <josef@toxicpanda.com>, "Juri Lelli" <juri.lelli@redhat.com>, "Kees
 Cook" <kees@kernel.org>, "K Prateek Nayak" <kprateek.nayak@amd.com>, "Liam
 R. Howlett" <liam@infradead.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Magnus Lindholm" <linmag7@gmail.com>, "Manfred
 Spraul" <manfred@colorfullife.com>, "Mark Rutland" <mark.rutland@arm.com>, "Matt
 Turner" <mattst88@gmail.com>, "Max Filippov" <jcmvbkbc@gmail.com>, "Mel
 Gorman" <mgorman@suse.de>, "Michael Ellerman" <mpe@ellerman.id.au>, "Michal
 Hocko" <mhocko@suse.com>, "Michal Simek" <monstr@monstr.eu>, "Mike Rapoport" <rppt@kernel.org>, "Neal
 Gompa" <neal@gompa.dev>, "Nicholas Piggin" <npiggin@gmail.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Paul Moore" <paul@paul-moore.com>, "Paul
 Walmsley" <pjw@kernel.org>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Rich Felker" <dalias@libc.org>,
 =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>, "Russell
 King" <linux@armlinux.org.uk>, "Serge Hallyn" <sergeh@kernel.org>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Suren Baghdasaryan" <surenb@google.com>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Thomas
 Gleixner" <tglx@kernel.org>, "Valentin Schneider" <vschneid@redhat.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Will
 Deacon" <will@kernel.org>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261119224312.1037966-8-jarkko@kernel.org>
References: <20261119224312.1037966-1-jarkko@kernel.org>
 <20261119224312.1037966-8-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:44:37 +0000
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
- [Medium] rootns: rootns_finish_fork() rewrites copy_process() -EINVAL
  to -EBUSY
- [Low] rootns: unreachable PIDNS_ADDING check in rootns_prepare_fork()
--

commit 1820863b7d5dcd4fd4778d2d64f24adcb966cc47
Author: Jarkko Sakkinen <jarkko@kernel.org>

fork: Support CLONE_INTO_ROOTNS in clone3()

This commit adds CLONE_INTO_ROOTNS and struct clone_args.rootns to spawn a
child process directly into a target root namespace via clone3().

> diff --git a/kernel/rootns.c b/kernel/rootns.c
> index ce012a07e9828..865689eed69cb 100644
> --- a/kernel/rootns.c
> +++ b/kernel/rootns.c
> @@ -423,3 +424,138 @@ SYSCALL_DEFINE1(rootns, unsigned int, flags)
>  	return fd;
>  }

[ ... ]

> +int rootns_prepare_fork(struct kernel_clone_args *args)
> +{

[ ... ]

> +	for (;;) {
> +		bool wait =3D false;
> +
> +		scoped_guard(spinlock, &rootns->lock) {
> +			switch (rootns->state) {
> +			case ROOTNS_INIT:
> +				if (READ_ONCE(pid_ns->child_reaper))
> +					return -EBUSY;
> +				if (!(READ_ONCE(pid_ns->pid_allocated) & PIDNS_ADDING))
> +					return -ESRCH;

[Severity: Low]
Can the PIDNS_ADDING check under ROOTNS_INIT ever be reached?

PIDNS_ADDING is only cleared by disable_pid_allocation() in
zap_pid_ns_processes() when the PID namespace's init process exits, and
pid_ns->child_reaper is never reset to NULL afterwards.  Because
pid_ns->child_reaper is non-NULL whenever PIDNS_ADDING is cleared, testing
child_reaper first always returns -EBUSY here instead of -ESRCH.

> +				WRITE_ONCE(rootns->state, ROOTNS_FORKING);
> +				bootstrapping =3D true;
> +				break;

[ ... ]

> +int rootns_finish_fork(struct kernel_clone_args *args, struct task_struc=
t *p)
> +{
> +	struct file *file __free(fput) =3D args->rootns_file;
> +	struct rootns *rootns =3D args->rootns;
> +	struct pid_namespace *pid_ns =3D rootns->ns->pid_ns_for_children;
> +	int ret;
> +
> +	args->rootns_file =3D NULL;
> +	args->rootns =3D NULL;
> +	if (!IS_ERR(p)) {
> +		if (current->nsproxy->time_ns !=3D rootns->ns->time_ns)
> +			timens_commit(p, rootns->ns->time_ns);
> +		return 0;
> +	}
> +
> +	ret =3D PTR_ERR(p);
> +	if (args->rootns_bootstrapping) {
> +		scoped_guard(spinlock, &rootns->lock) {
> +			if (rootns->state =3D=3D ROOTNS_FORKING)
> +				WRITE_ONCE(rootns->state, ROOTNS_INIT);
> +		}
> +		wake_up_all(&rootns->waitq);
> +		if (ret =3D=3D -EINVAL && !args->set_tid_size)
> +			ret =3D -EBUSY;
> +	}

[Severity: Medium]
Does this rewrite argument validation failures in copy_process() from
-EINVAL to -EBUSY during bootstrap?

rootns_prepare_fork() runs before copy_process(), where companion flags
allowed by CLONE_INTO_ROOTNS_FLAGS (such as CLONE_PIDFD_AUTOKILL without
CLONE_PIDFD, or CLONE_AUTOREAP with a non-zero exit_signal) and
copy_thread() are validated:

kernel/fork.c:copy_process() {
    ...
	if (clone_flags & CLONE_AUTOREAP) {
		if (clone_flags & CLONE_THREAD)
			return ERR_PTR(-EINVAL);
		if (clone_flags & CLONE_PARENT)
			return ERR_PTR(-EINVAL);
		if (args->exit_signal)
			return ERR_PTR(-EINVAL);
	}
    ...
}

When the initial bootstrap clone3(CLONE_INTO_ROOTNS) call with
set_tid_size =3D=3D 0 fails one of those checks with -EINVAL,
rootns_finish_fork() treats it as an alloc_pid() collision and returns
-EBUSY to userspace instead of -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119224312.1037=
966-1-jarkko@kernel.org?part=3D7

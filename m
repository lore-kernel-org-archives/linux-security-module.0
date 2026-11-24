Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500683;
	b=z6rX7gWPF6GAiVo0DUFcnL86hnlYbEro3Du3zaRX8718xR2ZX0gqCOpHBZK22JNg8J1r
	 vV6zVi+WJTDjpmpeIlk+M5D4rJHAHXgGmq3889tAacVqUhODXGXveNqeBerTOotzsx59b
	 hXvNsuPmVijyVo4j7ugxzo3MRFkGmqKrjGzTj0IslnjNWFMRaosgvai4qPH7uieuFfhtZ
	 3HdpKJFhR7nk2sAsPZqu/GD8iV2HscFFJKtqDBBoZc9e/weFuJ3x6A0dRxzCR6ytlDtfa
	 2O3aTfaY2mk6W0Z0pG1OqOLNKkSiJ9G/ovT8uBbNHANyn5LmJqBG4W7Ac+qHd4d+HMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500683;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iVWYT+ReEjp92DC/COPfTT4+iY+7/LKwunieQrCYZRs=;
	b=KLwW7cO6LVgM735WycMNa51b5eBHJUXTe+dKrdQq2UsaaKurCoxbA9DnAAvDNU+GBvCk
	 C5W4WfFSCixdXPDMlM++oT6+P4j9kkStdpmaDysu+MviLg9y2mtMWlyoiwkW1VLZQymAp
	 vVe1v6B1/L9RpLeJgnsSpEdNNulJaSoC3tHyuGWc0L5v1lRNUHGGpTGyEd/nJWPKt2EpR
	 xNfDeV1Gfpt8mF1FzLjAnChTPGVmDm8m42FH7NJ1yy1GOj4e6y3l3adSVOY6Dnp7qdn5v
	 K4p2JGZsTgXV4rTeZDiNaD/zsUt2I85y9FxYeKCAkbjoWAjq5wP0KyC2OepusvhJXJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ldk6v/fq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C64606A31E;
	Tue, 24 Nov 2026 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ldk6v/fq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B185E1F000C0;
	Tue, 24 Nov 2026 06:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795500682;
	bh=iVWYT+ReEjp92DC/COPfTT4+iY+7/LKwunieQrCYZRs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ldk6v/fqGLh4UU8tyr0PpPqolMjgBCj1T7glBs4eAhEz/xhfnabHBUoRM+Xxx0H6O
	 4oEqnAilstUOj6rCrwYUKygfuPefnAW/XBSrh7AaGArHULVLbo/+N+r1hGzMOFqfvg
	 nC9l5eUyNRZJmlkLOmA8aGTfVOZTkO0uUMPdKugb8XCblH79BPQkvxtDSry5P3nFKN
	 mAfFxbHWRjA/kAPD1wLnHCO0WJXPKfG9gl2CtHAU2TX+fbT0Z0kyW6oyU8M9qEgQCl
	 Tv2SWu36VsR8tP2AlgQ4ZwnU7nAQ+x20Eo7p9I13nlZNwJYEgC8rYaZpCJx0e4vwaw
	 5Di63bjNpeCNA==
Message-ID: <sashiko-outbox-230577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: net: act_gate bug. was: [syzbot] [tomoyo?] [mm?] INFO: rcu
 detected stall in security_file_ioctl (9)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, syzbot <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com>, akpm@linux-foundation.org, andrii@kernel.org, bpf@vger.kernel.org, brauner@kernel.org, daniel@iogearbox.net, jack@suse.cz, jmorris@namei.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, paul@paul-moore.com, penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, jhs@mojatatu.com, viro@zeniv.linux.org.uk
In-Reply-To: <DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com>
References: <6b051681.58b41460.7037.0590.GAE@google.com>
 <DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 06:11:20 +0000
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
- [High] net/sched: act_gate: missing Signed-off-by trailer in commit
  message
- [Low] net/sched: act_gate: missing Fixes trailer in commit message
--

commit 1dfca74c316eb54b3672929b3411874232eb4ee7
Author: Alexei Starovoitov <ast@kernel.org>

> net: act_gate bug. was: [syzbot] [tomoyo?] [mm?] INFO: rcu detected stall=
 in security_file_ioctl (9)
>
> On Mon, Nov 23, 2026 at 08:45 PM syzbot <syzbot+b6f8640465bdf47ca708@syzk=
aller.appspotmail.com> wrote:
> > rcu:           hardirqs   softirqs   csw/system
> > rcu:   number:     5264          0            0
> > rcu:  cputime:      138      52351           25   =3D=3D> 52490(ms)
>
> It's not tomoyo, mm or bpf. Looks like act_gate.
> Zero new softirqs in 52 sec, so one hrtimer_run_softirq() doesn't return.
>
> > RBP: ffff88807ed35538 R08: ffffffff91be1bbf R09: 1ffffffff237c377
> > R10: dffffc0000000000 R11: fffffbfff237c378 R12: ffff8880b8228600
> > R13: ffffffff89fd0480 R14: ffff8880b8228600 R15: 1ffff1101704514a
>
> The registers with lockdep struct sizes:
>
>   reg       value             points to
>   --------  ----------------  --------------------------------------
>   R14       ffff8880b8228600  cpu_base
>   R15 << 3  ffff8880b8228a50  clock_base[HRTIMER_BASE_TAI_SOFT].seq
>   RBP       ffff88807ed35538  kmalloc-512 + 0x138, tcf_gate->hitimer
>
> act_gate has the only soft hrtimer that can be on CLOCK_TAI.
> bpf_timer_init() rejects that clock.
>
> TCA_GATE_CYCLE_TIME is an unchecked u64. In gate_timer_func():
>
>   n =3D div64_u64(ktime_sub_ns(now, base), cycle);
>   close_time =3D ktime_add_ns(base, (n + 1) * cycle);
>
> With base =3D 0 and cycle =3D U64_MAX, n is 0 and close_time is -1.
> The timer restarts in the past and __hrtimer_run_queues() runs it again.
> It's there since
> commit a51c328df310 ("net: qos: introduce a gate control flow action").
>
> Jamal,
> taprio's INT_MAX limit doesn't fit. tdc uses cycle-time of 600 sec.
> The diff saturates the sum instead.
> Here is a potential fix:

[Severity: High]
The commit message is missing a Signed-off-by: trailer.

[Severity: Low]
Since this fixes an infinite softirq loop when TCA_GATE_CYCLE_TIME overflows
the timer expiration timestamp, should this include a Fixes: trailer?

  Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/DN37NBGPJJG9.2DSVDC=
KS3UYTV@gmail.com?part=3D1

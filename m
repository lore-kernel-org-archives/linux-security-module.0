Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793203166;
	b=AfOX8eTxaPVSdSLaYXPmq8c5cpjBX/VsbQnlqMZ83BxuNJeZDHiu/uk/5U3mLsE93pd/
	 L7Pb2mbpHhSmSL0ZPNE/WfzPjvd/kzjs/OvuV8kDqu0TyOEWorYX909uoycEkNlSQG5Qp
	 vCseRqS9p55F6DGR0f4bopG8895MJm4/nmGrMc9Q1w7QJqhGvop/3ZMC8rL4XgNbIzFt2
	 ucOzLzK9P9DJlYnsAowYG+9ZWLOH383LLb5W4NKJiLLhbxDvkg44l3s0K9LZmNm3IR2Ir
	 hXKKhQzAX/evg/DIJ2nB2JwOHU4VKMfssndoDoxbIpbYsdh/IhZg3DraUbiNsClotig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Dc4rW2+COMGPVHylYkAJkFpZ/yamBpz19LqtcOFzV+Y=;
	b=mOPmvcf1hY7Xn/eaVQa3GIfIpzMjDE0e0sn8YE3YUSWVCevcY6y+xTY429POtumW+KRV
	 sQn7ulIQEtmB92otMydt5ow7K5N6ZfjI9au58YhURPO2cMV7STIfY0yPsGux1qfYmddt2
	 Nqq5xFldXkV9wTSVgWEgT/3JaUgPL7fb2cBMOOak/uu9AucPswgBwn1FtlK/WLe3HvEdx
	 mDMNDupWMOyPjNvkkVtAKkurq3mSFwaT0abkqPfJltMVJh5l0KtkYR6pbMt9Wm5Jfk+wA
	 Wd0WujT0ceviZGQ1+5Jd7rMUuwDFpd7rsxG0U8K829jMEVZZdDnLzOI8umcFqOUN8iA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Xde8kH+c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41060A2602
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 15:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD41060A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Xde8kH+c
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso484036b3a.2
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 08:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793203164; cv=none;
        d=google.com; s=arc-20260327;
        b=s32d+jh+S+OGhpFSzsLZJDQ7q3aeAn1j2YmrLRgMTCo9XJlkCiqxTDoUBNjkAMFPxr
         mVzNk3O34UeMd0i/LpgQfa86dYk/y3/d7+V3wx+MLnO7eXymHfnolq0mbYaJH0r1tw0g
         fhoWaB/bvTv9YE1I9qI3mYZ5eDlkrqkEaaIFhocRXTJVFix7iZoTqpwWvO2Ml3FYNxB4
         SsExCSBqksqcpJuEQ/DgwIaw4comCpc+o8Bt4B+Czg6ULSibzWOwR5pRxDQC3coBRNmZ
         GBGwUC5RrldGxy7Bfbg186PFYof29/oR6w3inXkgFOKDfsXAriAzFSiIXVrlRpRPIt3e
         g6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dc4rW2+COMGPVHylYkAJkFpZ/yamBpz19LqtcOFzV+Y=;
        fh=qSo6V0+toGNzBVXKmv/msVydgPvp+QIoC9sgtmqLqvM=;
        b=bawOrciozaujztoFJbDoc1WUXWHhxy7npFL9vlg0VhFOQiihS6Cya9Y8X68ZpRNvI2
         +mOXQkckjuXlscLSH4qLOG1BtcTU71+FHuy5wzdKaO6L3b/4GLl3ufKzHckLdn6Uw5p0
         tmKdAxPdLjsDrECEl6mL3Gq6mCumRhraTdrMFVNlt2ZG9Dw2Oa4cEdwvzTz+3la4ywmR
         w4yWo3wfq3KwwbOEtOe21kZI5srTvN6XDyeFYZRRUq/3Tv08wphYw93fRZpLk32QXOUe
         JNg8Dbmm81n+eXAyFKsx1/G0TMg/bhynZL3TeupQUEDiOE/8st0B2iasfi8hjEqQb+uR
         N0kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793203164; x=1793807964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dc4rW2+COMGPVHylYkAJkFpZ/yamBpz19LqtcOFzV+Y=;
        b=Xde8kH+cqlVOr/NMR7Wf2JCxAomM8iaA+yOKnEWQdervZ/w503T0qYZZ6aOIBygAsC
         qij7djXE5tgEJO6Fg3dvN+llLaU0wfp5K3TXaIKEKfXug0iTHDU8r1pyoHvQ8B8Z6qgt
         UeXRTBxIPcUoikJFSeVCrlsd1QdQ1PIEIALNNtqalm4GbfnAzTbkILoS8EoRXI+ENlGT
         pCWcFvtvfNhYIGcmjkVaouZPomu9dr/9De7n53N+UKBzQxVuhbAHnVl9cFD2L8k5xutY
         S8PhqXCysvqF5qkcIRiApTxBmbXvToeiuo/7lzQYkr6Titoid+3/IYz90R+gzsrC9Oe+
         jeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203164; x=1793807964;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dc4rW2+COMGPVHylYkAJkFpZ/yamBpz19LqtcOFzV+Y=;
        b=h3mcrQR+6q6stMcJFvUTeBwRlaMw+cSfpIO8YxfJI2cVmLX/zH23r6rGoMihqfpxIe
         hPzTU7AM14t9VBsQ/ZMNEY3kef0umuAtWQVsjIca3RDs+EImayl7Zzdh9Thpa9P39M8V
         7LUOTxLXkKc7/pDeTEdESa3cg4iruHZ4IvvCYwAhgDhQnpcCBAVl5tWQoHA5CkOnu8D5
         +MFMu9HapYwXi3upn9sVtGR9ntNQoGmUi9NZeu9p9jahL+DU0qprFI9DwAIQf6untiHR
         wF1n9ieHz+HgktQ6OM7Az/XiKsj9q9h/koJ/OF9dLE5WrHN2PzJ0GC+1ZJKgCA+OG6X3
         3e8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwZHKChNE+HsDSKDJwNhK7xSzrSxjHi/PUF96jzVRUNs7vCXPiHRQJl5Q93te9PQEXWx9rXhN4QoA2FlN3exVURHTYtMeU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKB5ohIvwf9ddn4AQHaw5xQxprIEZ9tAGPndzKMDD4ZJLoj8otP
	Ud0nwzCquzjKljcUVDR6HLiqNlwQgumOjIoVq/ycxloXYDdyko5h87ZAUBrGpjJa5SpSEeb4ova
	E1DvnFSocdcf7TVgVZiTfLRaJFj00vmr0jjsEkP3l
X-Gm-Gg: AYBFou1TL41f5+HRYW9oTThPOLVq0Tcdu12M9KlxIstXpEhFoLkTBzKjPRjK2IUPACV
	HXkpuN5zQLscUy2hwEz3SsqVT7oMAlh6cfk33eGPljX/i7+hgQRvzqB0+Dk/XO0VtHImBxMZL5e
	2d16iiaY3oY/MLhPXOi6+WGY5sSMPBFN3c2N0XR0+TRKCknUwSAcpBFzcPHJH18fdxczS7z7IHD
	tmL2kABtZFmZ84UYi9zkH3H0afFGmmXGuT1Hh9pBErLi3FUZ2FkmxEnkRxPt28bXmUsUm1hMfBK
	y0ONhyHpbc/HaHJP0UD3RnXr+jBydrbrdRyTnf2MK+Dl6cLlOjl+iQBDm58vy+ioi//OFN9ZWal
	SGRYWMjhidpBffuHSewrcU5ISEnPRFAOKtWvDtNqDCJZSwp6HROB256es9pYdevaoLwmTCfFee5
	ZIG37fx7tuoKw6xQ==
X-Received: by 2002:a05:6a21:6f16:b0:3e2:1823:2b4a with SMTP id
 adf61e73a8af0-3e901e829e8mr2186510637.0.1793203163924; Wed, 28 Oct 2026
 08:59:23 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <CAHC9VhR4rMydWiD-RFv-ABiYSG_txJuyrtdaowEXPY=CHEvFXA@mail.gmail.com>
 <20261027-heckklappe-halbmarathon-vorsorgen-849ffdc42aac@brauner>
 <CAHC9VhSJMPOY4X78ENEkAiNeVTCpvP76PgVDqTQfwaYfwnYwAQ@mail.gmail.com> <20261028-treiben-probanden-nachkam-e986afed3902@brauner>
In-Reply-To: <20261028-treiben-probanden-nachkam-e986afed3902@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 28 Oct 2026 11:59:12 -0400
X-Gm-Features: AclHuK-yJIwoCb3oIYP-IBqXnljTJgelOwPOEoH9t42fOb1qZ8AgXGe1E7dzuKE
Message-ID: <CAHC9VhQm+swDGvP31aNefwx6qCCy2mk-CjD4i=4kE74eA+e2zQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, netdev@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 6:45=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Tue, Oct 27, 2026 at 06:37:43PM -0400, Paul Moore wrote:
> > The hooks were merged into the LSM tree on August 31st, and due to
> > timing I'm guessing they appeared in linux-next the next day,
> > September 1st.  Considering the merge window opened on October
> > 18th/19th, that's conservatively a month and a half during which
> > testing could have uncovered this issue and the behavior of the hook
> > could have been changed to accommodate your use-case.
>
> That's what the rc cycle is for.

I believe the understanding is that basic functional testing occurs
before the RC cycle.  Considering the NULL check causing problems for
your use case was present in your first RFC posting back in February,
it's unlikely that you, or anyone in the BPF LSM space, tested this
prior to the merge window.

> I'm not asking for changes to behavior
> of the hooks to accommodate anything.

The LSM changes in this patchset do change the behavior, that's the
point.  The security_namespace_free() hook does not call into the
individual LSM callbacks if no LSM blobs have been requested; what you
are proposing now is that we change the hook so that the callback is
always called, regardless of the LSM blob state.

> > I know the
> > Landlock folks were testing the hooks for their usage, but I've gone
> > back through my inbox and I don't see any reports of BPF LSM failures
> > using these new hooks in v7.4 until you posted this patchset during
> > the merge window.
>
> Because I sent fixes instead of a bug report.

... which you sent *after* the merge window opened.  Once again, I see
no indication that the use case you are concerned about was ever
tested prior to the merge window.

> > The LSM namespace hooks are new to Linux v7.4, they did not exist in
> > Linus' tree prior to this merge window which is why I consider both
> > the BPF LSM and Landlock usage of these hooks to be "new".
>
> Yes, they're new. That's the argument for fixing them now. Not against
> it. No released kernel has these hooks. Once v7.4 is out every one of
> these fixes is a behavior change in a released kernel, needs a stable
> backport that by your own rules doesn't qualify.
>
> And on top of that nonsense, userspace has to probe for it forever.

It's a one line change in kernel/bpf/bpf_lsm.c to add the
security_namespace_free() to the existing list of disabled BPF LSM
callbacks.  No need for a patchset spanning 16 files and over 350
lines of changes; the BPF LSM callback can be enabled in Linux v7.5
after it has been properly tested.

It is probably also worth mentioning again to casual observers that
the LSM hooks, and their associated callbacks, are intentionally not a
stable API.  LSMs are advised to implement abstractions before
exposing the hook/callback API directly to user-visible interfaces
such as configuration policy, policy as code, etc.

> > As mentioned previously, I'm pretty consistent about what goes up to
> > Linus once the merge window opens: there is the initial pull-request
> > with the changes from the last development cycle and then after that
> > I'm pretty strict about only serious bugs/panics and regressions.
>
> Your README says "serious problems", not panics.

Are we really going to argue about how one defines "serious problems"
and "panics"?  You'll notice that I've used "serious problems" and
"panic" somewhat loosely in this email thread because the distinction
doesn't really apply to our discussion.  The issue you've brought up
is that a use case that was never tested prior to the merge window
doesn't work like you want it to work.  There is no kernel panic nor
any functional regression from previous kernel releases (user visible
or otherwise).  We'll change how the security_namespace_free() LSM
hook works for the next release which should give you plenty of time
to test that it works properly.

> A hook that is
> exported to bpf as an attach point and never called is a serious
> problem for an API.

I'll repeat myself again, a little louder for those in the back: the
LSM hooks and callbacks are not a stable API, if an individual LSM
needs a stable API to expose to userspace it needs to provide its own
abstraction layer.

> And it's not how you've handled this before: lsm_get_self_attr() was new
> in v6.8 and got fixed for apparmor and selinux at v6.8-rc7 (cf. [2]).
> v7.1-rc5 took Stephen's cred_guard_mutex change for lsm_set_self_attr()
> without a crash see (cf. [3]).

There is an important difference between those issues and the one
you've identified with this patchset: lsm_get_self_attr() and
lsm_set_self_attr() are syscalls while security_namespace_free() is a
LSM hook.  Linux syscalls are subject to the Linux kernel stable API,
LSM hooks are not.  Linux syscalls are directly accessible from
userspace, LSM hooks are not.  We could dive into other minutiae about
the differences between those issues, but the distinction between
syscalls and LSM hooks is really the only one that should matter here.

> > Disabling the BPF LSM support for the new hooks in Linux v7.4 should
> > be relatively easy, much simpler than this patchset, and eliminate any
> > claimed harm.
>
> No. That's a change to kernel/bpf/bpf_lsm.c which you don't maintain
> and the people who do have acked the fixes and asked for the whole
> series in v7.4.

 :D

Instead you're asking someone else to accept your changes in a
subsystem you don't maintain and when they push back due to lack of
testing and existing conventions you decide the proper approach is to
bully them and force the issue with Linus?  I'm used to dealing with
hypocrisy but this is truly something else ...

> You're proposing to rip working functionality out of someone else's code
> so you don't have to take a three line deletion. namespace_init and
> namespace_install work fine for bpf.
>
> It's also not simpler. The LSM part of this series is deleting three
> lines I wrote in security.c. The rest is my code and bpf's code with
> acks. Your version needs a revert in v7.5 so it's two cross-tree changes
> instead of one.

Adding security_namespace_free() the the disabled BPF LSM hook list
should be a one line change in Linux v7.4 (maybe three if you need a
Kconfig conditional for something) and then a one (maybe three) line
change in Linux v7.5 to allow it again.  Two patches, each at most
three lines, all contained within the BPF subsystem.

> > Also, as the ongoing friction between the LSM and BPF developers was
> > brought up, I want to point out that SELinux support for the new LSM
> > namespace hooks was delayed to Linux v7.5 due to issues uncovered with
> > these new hooks during the Linux v7.4 development cycle (well before
> > the merge window opened).
>
> That's not what happened. Stephen posted the fix on September 16, v3 on
> September 18. I reviewed it on September 25 and offered to carry it in
> the namespace tree for v7.4.
>
> On September 29 you said you'd rather take it through lsm/dev. It's not
> in lsm/dev. It's not in v7.4. A reviewed fix that was ready three weeks
> before the merge window didn't get applied. That's the same decision
> you're making now and it's not a precedent for it.

If you look at that thread, you'll notice I ended my last mail with a
"Are we all okay with that for this patch?" because I wanted to make
sure everyone was okay with the patch, and the process before merging
it.  Stephen answered that he was okay with the approach and you never
responded; I held the patch back exactly because you never explicitly
okay'd the approach.  I suspect one could make a lot of interesting
observations both about how that patch was handled, and how that
handling is now viewed from different perspectives.

> > I told you "next merge window", which is far from "no".
>
> For v7.4 it is "no". That's the release these hooks go out in. It means
> v7.4 ships with a namespace_free hook that never fires and v7.4.y stays
> that way because by your own rules the fix doesn't qualify for stable.
>
> > I'll admit to finding it odd that you seem to keep inserting yourself
> > into that friction point
>
> A large portion of code where new security functionality is added or
> modified all of the time is maintained by me and others.

... and when it suits you, or the BPF developers, you override or
otherwise steal ownership from the LSM space.  We obviously see things
different here, but if you're trying to convince me that you are doing
the Right Thing by inserting yourself into some of these discussions,
e.g. the recent LSM kfunc discussion, you are wasting your time.  To
borrow a phrase from Alexei's last email on that subject, "I don't
feel we will converge here".

> You're objection is noted and I'll mention it to Linus and then he can
> decide.

Please CC the LSM list and me.  I would also encourage you to disclose
the lack of testing you have done prior to the merge window as well as
your insistence that the LSM hooks become a stable API; if Linus is
going to change any of these policies it would be good to know.

--
paul-moore.com

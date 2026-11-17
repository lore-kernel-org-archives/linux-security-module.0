Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794948842;
	b=GkZ6FHMf3dCNl7PMVwJRCpeJZFI9+Lkk4DCZ/iehducDMoQg8sjVQuszeLarADd2PULB
	 8KH4ruzonOEqTOs2dkLlbOckOoYRugx1fQ2O+ka6PfS+LFNQHpWsLR3cg61aGT9I+YMmN
	 Ap9fXQIVfzt7IjzcZd3IVt/B7FHhtLumdPCseFhsHk/6Lpt/OfpTxiaeqd47Dy/4gRB2f
	 eBbtt4bUR5RvussdiDrKnMXcbFc2MAE/nLKdvmCuD0gNP2Z4BPrrdefZCIogDxg9xHANP
	 gCLX0D5srqPZzAq7QA0qr1XDElqbAUhy1iuoS8k80mQa3QqVW7j+tMC4R+u/+kxh6cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lxMCjoGZWG4QAWp+HpCFavF1sxg7OOCbkVFjQuSNzhA=;
	b=aaxfHuo2CaJzyqSs7mgrLg9mPDUWx8dy3y1ZTIBtv/mmxU/vBohqYkYukhP3fk6kuA7V
	 TGsZK0qWn3sRhKupaEh2NW+rfjSdhuVTvLBogk0NTKbzeYBCO5bf9L4rhNfg2fbT86Wp4
	 xZ8gk1RU7xJmFg2N6mpBymtAyZSUUOmeQvUirTTP5snCJzsAu0mxyKwUd2knC4B36udrn
	 LDrIcr1RWz7G/S/s7P5IEWwkZFxcW/8iGD1SpmHhtZ+RuTdIFw8YpeFHAqIeJltwAaNLi
	 ztCB1Hngy4pQbefNx7niZs0hLjywUUb7LuXR3o5YaD08Kp73AtCc45jQ0jKqGyr5RNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LslQjUmg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A7606A331
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 20:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 638A7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LslQjUmg
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c14f3dab66so148876e87.0
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 12:54:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794948840; cv=none;
        d=google.com; s=arc-20260327;
        b=k1LmS0Ar1F8mk1VNWGvPxhmpAmJcWZ/juwLmoXok2nwYzZH/DQm6ijCIq2MOo/CfxG
         G9T7uSQ9+o0GLDKbH20WyaxUQa1SNZZRnbPvIwLTn850ZOU/h0HV7EdPb1hczFV0SKh4
         jK9s/LU2fx7okqxZ9auEKS/If2xTiZhRxeg5KjRjuUXp1i7uAYlxRAx9q8KqEbRb0zZg
         Q70fR5ZDYQxGDr4rwgPUlS/ibzPcRnqXPZ0gY3JZorL1c0xHaPla57XkeGHhbbIEfdV5
         RUJX1nKmKtrn5ki/8mHtjQYrwcriUDiVHE9DUAqN7sd/fOSVMXslduoKRren8lIfo+g9
         Z5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lxMCjoGZWG4QAWp+HpCFavF1sxg7OOCbkVFjQuSNzhA=;
        fh=LWooPMkamjZbnm1QREQPLrovzqmv+4WAB5iQlro92s4=;
        b=pw+vEQjytzfuYPOAMZQd6BKvQ2O2rmgljrTrD6DEUU+wiOZvXMQXjiCGGtkcrZE83L
         Cj7bM4q1Vl2ZaUxPU9Kna5ZdwS++AE0mcRxOLVt39NFNSCKQ5S04KgvoeLyggZQkjZ8w
         hevEXuAYakj7BlmF+f5ogdO1s2/+y6ZuvbniY0j4S2Dh3wnLq4uAktPboDNPcyW2PsY/
         ZZKSxlPxQtERI4YEVfbexXEfVjFWc4Zhl7xkQHU0aYn6/9NcUKrumqFubYtua2KpYATg
         pXvsBdXzcpLVcNfkCiCx+voWLUMaEwQz920o8cCP88FEjbX9qpxk4Y65TVa85uHK8AbG
         jdpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1794948840; x=1795553640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lxMCjoGZWG4QAWp+HpCFavF1sxg7OOCbkVFjQuSNzhA=;
        b=LslQjUmgXp7ppoB5z9C6lIh34ojfvcQ8nzfZ/Bus0FFDGG0DUi+QbKakM0fZFVIykq
         5mE0e/s/CpUqdx5hmSPPf4ZqfdbbG/4eR1cdypM9sQ7xLq3NiWuooniPj3c+oOnP/Gs/
         9eulqTIqNDLgU092uHWrXSQFQOUQ0Ybq8I+KARDSFo99l3A76mmdMOP5EIWjKF4SsU8k
         CLRnBvH95KDC8joQwrmPsfza+TxJts5K4ekF1BkXcERhq9o5i5YAd+8YKoGtExZnN7ex
         +BuNP6j+NU8hBGd6crUPCUF5Rx+iT4Q8fvcxMfppbSleGXT6F0Sca+oO5jRTOaHafzSk
         UZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794948840; x=1795553640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxMCjoGZWG4QAWp+HpCFavF1sxg7OOCbkVFjQuSNzhA=;
        b=NMLEPotVWjIhzk3lm/YAJX14TL5wcN8X4vsxJYuQ37QkP1aFZbqH+HMo06CQ7dgHgd
         5pJt1gpovwmhgq03NQYu9ZtdmrolCjq8n71Pan3zwq247419sbcjLRBgajMLv9hbwc5Z
         73K+hN7fulnsMBtSdWjL6QFx7gxNa2HM6EObAEM/ek3HU7t47RQYTYsuJs/JLuZ+vidr
         glMCnAUaM44zVo94FKjTN6LcYeg9jQ9AYkJkn6ilQZFBpFG9OylnGIywM+3KqbOyZj2P
         vEAMhDyCQPtDkIyZ6lfhJZKiyg7lVV9l85Ldzwi4FVsEtWJ5YBcRNgIIQt7w+2Sc7mF+
         bbBA==
X-Forwarded-Encrypted: i=1; AL+hErGT+6n7W4hY4yadCZdzZt3mv4ncH7KIWVq379YDGNKD/SYog7rX40eKgnJ9t1CqkWMgKzXHZzi0rYzXZIQwIVOFDNvOGLM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DCuSj394J47HKL4MatSEH2Mxn9PwRj2v4ZONMWJnvVYlA1FQO
	2EfGTIFqn9H5jD/uQ05bUgYH/rSMFy5G+moSgBJ7zaw2dpcq6CRZtwDXVc5k1zfQc5Tb7q24pd2
	nMACLZRhG5qEY/+vAAMyPnUBj2/EC0juf6uz7d3t0
X-Gm-Gg: AYBFou1CLmwSgmE9oZxamuMv7y9RX+Rk7uLYrzOBYfpy9BRN5hJKg5nS5o9CxK+Z1Jo
	scy/2INveDh6iCJYrTeUSf0M9PBkBIRzAdxIcdXeC8w6bneZpgNeuVd5NmJ3RkwkyoJBjMRB6g5
	x4zMTbF341MkH+Ex2B8qcneoiBvv3TLM/QIZJvfoXF1Oy25njXUwcukFvsxrRv/UUiQ+NN9sizw
	CBZU5RAxL4EQ5PP3/X14NYlShFfRGk4oUkr3kI4lJQlVWjyJL1dSdJHlgTn9CkcYZ/6BLrPviss
	jkC204N4nrCC+sZr2Hhf4+bhhwgs0laEuI0OF0tKsSKR1b4oKYtJYXj77RS8c2PffFHMIqLPdSe
	j5S2Us90eoVG1/ZuBA5HYt43foC3gUJetbw==
X-Received: by 2002:a05:6512:224e:b0:5bf:b96b:89f4 with SMTP id
 2adb3069b0e04-5c1a0f1b8e2mr1319677e87.19.1794948840370; Tue, 17 Nov 2026
 12:54:00 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117050841.3289652-1-jarkko@kernel.org> <20261117050841.3289652-8-jarkko@kernel.org>
 <CALCETrWtbUFQGDOCHkxAN9O4i29ixfL5KKF1Cqw2-CjxKwC6gQ@mail.gmail.com> <avyzFnKQrNOid25y@kernel.org>
In-Reply-To: <avyzFnKQrNOid25y@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 17 Nov 2026 12:53:48 -0800
X-Gm-Features: Aa3M54qx88-je4c1jdCxPXUBmX_p3qTxglmaltFgKplV78kiTxOHsj4XFF6xQaI
Message-ID: <CALCETrWHxjrQvRC66d1fvkZw1e8_+38BdzmjSYHmqRjXZnD8nw@mail.gmail.com>
Subject: Re: [RFC PATCH 07/13] rootns: Add rootns_enter() system call
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Ben Segall <bsegall@google.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, David Howells <dhowells@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Juri Lelli <juri.lelli@redhat.com>, Kees Cook <kees@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Manfred Spraul <manfred@colorfullife.com>, Mel Gorman <mgorman@suse.de>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Paul Moore <paul@paul-moore.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Serge Hallyn <sergeh@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vlastimil Babka <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 12:03=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Tue, Nov 17, 2026 at 09:42:26AM -0800, Andy Lutomirski wrote:
> > On Mon, Nov 16, 2026 at 9:09=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.=
org> wrote:
> > >
> > > Multithreaded userspace daemons cannot call setns(CLONE_NEWUSER) or
> > > safely mutate process-wide filesystem state in place before spawning =
a
> > > child into a target namespace set.
> > >
> > > Add the rootns_enter() system call to fork a child process directly i=
nto
> > > a rootns whose root mount has been installed. Transition the rootns f=
rom
> > > ROOTNS_READY through ROOTNS_FORKING to ROOTNS_RUNNING for the first
> > > process so it becomes PID 1, serialize concurrent entrants on waitq
> > > until bootstrap resolves, and admit subsequent callers into the runni=
ng
> > > PID namespace until teardown begins.
> > >
> > > Require CAP_SYS_ADMIN in the target user namespace, forbid credential=
 or
> > > PR_SET_NO_NEW_PRIVS privilege escalation
> >
> > Why are you disallowing this if no_new_privs?
>
> For no any good reason at all apparently: no_new_privs is inherited by
> the child and only restricts privilege gain across execve(), whereas
> user_namespace transitions are allowed under it.
>
> So yeah, it's a spurious check, and thus I'll drop it.
>
> > This isn't necessarily a showstopper, but fork() is really quite slow
> > in many cases.  It would be nice to have a more spawn-like API
> > available.  I assume it's possible to open a file in the target's
> > mountns by some sane API even without entering that mountns, as a side
> > effect of how the fsopen / move_mount mechanism works.
>
>
> If the caller retains the O_PATH fd returned by fsmount() for "/", it is
> able to open files inside the target mount tree via openat2(...,
> RESOLVE_IN_ROOT) w/o entering the mount namespace, and pass the
> resulting fd to execveat().
>
> For avoiding full fork(), there are (at least) two options:
>
> 1. A rootns flag in clone3() (e.g., CLONE_INTO_ROOTNS) and a rootns fd
>    in struct clone_args (disallowing incompatible CLONE_NEW*, CLONE_FS,
>    CLONE_THREAD, ...), and callers can pair it with CLONE_VM | CLONE_VFOR=
K.
> 2. A flags parameter in rootns_enter() (e.g., ROOTNS_ENTER_VFORK), which
>    would map directly to CLONE_VM | CLONE_VFORK.

There's also been some work on using a pidfd-like object to build and
spawn a subprocess.  Supporting that would make sense, but I don't
know to what extent these projects should block each other.

--=20
Andy Lutomirski
AMA Capital Management, LLC

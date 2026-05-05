Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDFB282F13
	for <linux-security-module@vger.kernel.org>; Tue,  5 May 2026 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946719; cv=pass; b=QWauVAInFzfVWPFKXyJy+NjStdbKt+S+VY500btynb73m3w4vskaZAGntV853XDK1ubUZ2wWJJSnhGhdHqAiOgqElkpS9K/d/SbYwnfxpqZyOcdCS2/Irr3kO5mQ7D8P4LPXSqW2WEzJFiRDPV9+zQ+QFEM6GFFLgBjQFBm07h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946719; c=relaxed/simple;
	bh=gvTcP/QSZduWlO+YM2pkz7nb/ZWzyRFB9ciWkWgUHB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJn7nYZrYJcNmyBq+BCdtkrvPvZ6+biRTg/xDOUIdqUUP825HNGz5DB0K6xLRB/r7Ch866xjDiYmwojIXhzLaUNrpcmDV641Ng4TWxQoLsMQbGZtnzmpC8gqFGFm/fhCHx88oYxODcllapqlRw7fM3SiH0ZPUB9Dplye41PyD90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Iu4pHGTE; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Iu4pHGTE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3651fa24c6bso1628675a91.2
        for <linux-security-module@vger.kernel.org>; Mon, 04 May 2026 19:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777946717; cv=none;
        d=google.com; s=arc-20240605;
        b=iAtpHDMFvo7EpVqjyEX4UONQYN3Q+kJtdI2+duLXCD8XosUbgQXhUADfPBbEpvTqlH
         P+cU+H6YZldYOOPyTbzli69E/c1kWFHXU4goHRx3KJ8fo9ltuFucQjHbdGMciK/maB2r
         BWs2UejSX7gczZ2Ucm7r2xCHd4qjfQpGWxSyYsnn0+jwMnH4kpwBPTU9OdmJFKKLwfGt
         qUEdZ0Oua//m2HQl1e0Upa72xVCPKnbB3zGHOkXOMXVbXu23gsbUNYpXa86vEmspyyv1
         0L3grzwGvXfb+qyhugYctFsY4sIOkKKMELGpEJmritvMoL/Yoooljo3qibpBPgMrN758
         iA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ds8VPZ8XGFRCMSYoTIFK4J9AmphYV1vVpSWFXmoaOPI=;
        fh=NBK8bSNM7di5EcwYZy7bf1tTwhlaQFh8G717RKqIbpU=;
        b=TXfMXU/80k/TflKXjJ3WVDv5yqO33LaCrxusk3oQaZnN2hL4/qdYpVkVfgN6HIk+ms
         CD5B7qj82/RrMYMGeEC+eJjifQEyxYFkcSXOfVF0bxeZX7CbUb4UtrC9t28N+8wgilFT
         HyMVKT6Q6afiasBp1ds0XSUwea0yy92RSPpnmfA3D+DAny7KG/NWLdNmRPrvdRXbiZ+c
         yKlhn/5GNOpoFPco542hNeZJwe+ZB7CRTagqzDi+XWg3ZMev69wBV5HDrhHFlcBPBKsw
         hfj4//s/Wk1Vy5hDcJKumUIyR6MlrY5ZZjCMykOHHcwoWVksRHsNXpMoSMj+5LpciGvB
         vIdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777946717; x=1778551517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds8VPZ8XGFRCMSYoTIFK4J9AmphYV1vVpSWFXmoaOPI=;
        b=Iu4pHGTEUaOLJwNoK6YkG3q0ITunicSOQ9GLJSqAZshyOtEqzWrx20esi7hYXfWjLS
         Ku7ucBmg80OyUDoA4XpZjPwA2+U33YY71h0OKr1hkn0n0eWGJWPw7vRTo9pNEkeUUy32
         W87BEB2psIcxaVJNpzgC+PUsNMKSKZ56NTumpArcoKSPLlj5tzHG6FrLVoyHjP6Qzfim
         8e6LE7bCXySDpMs23fKlu6L3bUasxX0AhJCPo1b6EAyXhne/WRGl0RwqTGRm9wycbohN
         53MU5QDes5YHyYQSiwfbTdSd4gG0kf/iFWA8IWJXM1lrA4sUmSmmK5DDJHCi/4jXt/ya
         50Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777946717; x=1778551517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ds8VPZ8XGFRCMSYoTIFK4J9AmphYV1vVpSWFXmoaOPI=;
        b=BpEISjCIfm0jTKYTX6JZ39sSUqOTQk3LEy5HsqkENKdG4AXSKTXbbKrlqThx3zlhuC
         n0Jw0s992GY79uCNESctduBI8SQUw9NwUui2w/jlqMu2zca2jCW+QUCex1akb4Zu1Kxt
         tq29KJopZP7D6ZW/AcN0dnoPykoZctZLLjYAw0fbdJmvDICMk/AqLqZRB+PBJBWRbH/H
         rNv/xndNTKNgmay5KiAipxj+D7+FgY0XUfbI8CCTGMs7tloJMzuWZ3OOAec31cQBUJVX
         wjRe4FnkbqZ7GOq5HkM1GkYUPtq9kUANydkkmsYk9DK4hlwH7tmt5NbRoYx4CdaLAdme
         vzOg==
X-Forwarded-Encrypted: i=1; AFNElJ+KL40nHG/395zCD2rUaihs622iEQ0jJe2VCXuWs6K74i4T6iLQrkru96xBveXiJGsgTkSUXfg4AYArDEqW3N0HGQ5P3XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQuc4119Njq6XgHfxmYcqKZkqHroxk1AwGh0/WdKO9N07VCeq4
	TxAo6384ueReYBQguXfr3WKfgaVmsiImfkVZ+Nw624pAWNiPs8NI5H7z+Bz7Yjs4LNbj8ZjRIXT
	754M5V4m3soIxoFYxr9cB569h5EPUTBlFXFimwfGp
X-Gm-Gg: AeBDiev/Pv8D5ttQFbFkSxyp6VqijjpZg0/Zc6kcejLAsyJH9Tl4qa3a00CqSpToBHL
	BaUYwWy8uWMGoGZKxo/Xaedw/WoEFi2bT3v3OggNK4KI9jn5JBZ4akWpv942X2IDVZw1WDziD5w
	hZX1iRKCJrzgB0QCEv1zt+/w3XjhODIgrworlFsTIDCQRVgg00LnHWf79zVYKPiYUNTKW22QOJe
	Gs/CbH/mzZiQo4kxxNhsEW6ov/ycdYYzXwgzeptAHxUlUVmpyXys4tNLltVYCjswWqdlRZs5Hwa
	JTJoz68PDoXQKK8jMwnrBCeuJeNs
X-Received: by 2002:a17:90b:578b:b0:35b:e51a:ec77 with SMTP id
 98e67ed59e1d1-3657747c6b0mr1240269a91.16.1777946717425; Mon, 04 May 2026
 19:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
 <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
 <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com> <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com>
In-Reply-To: <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 22:05:04 -0400
X-Gm-Features: AVHnY4IXddbw6Xna7rtOXW0Z3iNQtqb02aaSWmZldIVvVUPK0DOCzTg7J5JMJqs
Message-ID: <CAHC9VhSkBsUDKoQArjyPLTgSfc4GVinphyJmNv=-UwnQp97qCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 10:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> > On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > [...]
> > > > > Perhaps I'm simply not seeing it, but is there a check to ensure =
that
> > > > > there is only one BPF LSM calling into security_inode_init_securi=
ty()
> > > > > at any given time?  With the BPF LSM only reserving a single xatt=
r
> > > > > slot, multiple loaded BPF LSM programs providing
> > > > > security_inode_init_security() callbacks will be a problem.
> > > >
> > > > I don't think there is such a check. Also, a single BPF LSM functio=
n
> > > > may call the kfunc multiple times, which is also problematic.
> > > >
> > > > I think we will need to make the default bigger, and also introduce
> > > > some realloc mechanism for the worst case scenario. This should
> > > > work, but the code might be a bit messy.
> > >
> > > Thanks for the clarification, that is what I was afraid of when
> > > looking at the code, but I was hoping I was just missing it.
> > >
> > > Increasing the default is an option, but I don't think we want to
> > > support a dynamic reallocation scheme for the xattr slots, that will
> > > likely get extremely messy with synchronization between the LSM
> > > framework and BPF LSM hook registrations as well as special code to
> > > handle inodes with lifetimes that are disjoint from the BPF LSM
> > > programs ... I suppose there may be a way to do it, but it will surel=
y
> > > be ugly and come at a cost.
> >
> > BPF trampoline already handles all the synchronizations, such as
> > add hook, remove hook, etc. properly. So this is not that hard.
>
> How do you plan to handle the issue of disjoint lifetimes?
>
> > All we really need is to allocate a new array, copy pointers, and free
> > the old array. And we only really need this in the worst case
> > scenarios.
>
> Oh, is that all? :D
>
> Keep in mind that the code must also handle arbitrary ordering of
> LSMs; in other words, you must handle a BPF LSM that isn't at the end
> of the LSM order.  While a BPF LSM at the end of the LSM list is the
> most common, and recommended ordering for the vast majority of users,
> we've been working to make the ordering as generalized as possible.

I just realized I probably wasn't as clear as I should have been ... I
really don't like telling people not to go experiment with things and
play with the code as that feels wrong for many reasons, but I do want
to warn you that if the code to handle this ends up looking like I
think it will, I'm not going to want to support it in the LSM
framework.

--=20
paul-moore.com

Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D87C14A
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jun 2026 00:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531495; cv=pass; b=P4oWsx+d7WYKaT7lUplgBqXoAbz1RJiO+l++90p2tNToyWdvAc6MfW+XyqR9WtTGXh3gk5dypqzPceNmPsEXqsysq7y5bqnTEigOaqc7CBKgiDDKw45Rd+d2n/1HIzmsuaVMotnSl4Zco6/KAgyFMUo2/4xAAxxWLh6neQP0gFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531495; c=relaxed/simple;
	bh=8gLkhsCYt/EbyDOL8oOaoehbmrqMGROQA7+3J8nc+jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZL4H8c/TymXr9gpzFLc+on9e1r1guS7PBr+zLgXAL8IKmbQlK/UqeKSImHzA4v/KlCF3Hqc+iNV8X4J8YsXH9LXy1741HRP8KWVMCeGF5UAFkwyiqtLH9ojEIqEQZsfF5bjTwu50VM2wvLqvdMMNZpbyiTOOaLY+BRqEtGa5wwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DBzyQEnP; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DBzyQEnP"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84234c83142so33408b3a.1
        for <linux-security-module@vger.kernel.org>; Wed, 03 Jun 2026 17:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780531493; cv=none;
        d=google.com; s=arc-20240605;
        b=B61WPiHwwfHBe1vO6AnW0UcXqfBmaILuuciYZX58hwAJgLxAtaF3vop13RWz8HrR3N
         daunz+AqOXxv5YYkhfTbaDjS4aqtcO1FvGgBaccbLSh9ZckX6rRJ439Y3EpGKSIvKsh8
         rDUfwYijXf5jItcBt9xw0BHggMxJiS6tzkK0INb8xCO8GxY+vWDO3/gcyOZp44WMQVE+
         hnQfRyht4Xb0Dfgt+WQ5bTROvIOJhxNJky8G2Nl938yv+f/n0Dxdw5Z8DvcMk6uYwQll
         EEP7QLx39SqsEvUhKKwxrryfC/ztWADH6PupkZ9mFPMHsWE42TZ+A48NVNd2K8JQ+W8y
         8xpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w2kRTTiGEA9fSwm4VcnJewLOTBIpuhWKQa3sVuOIwjo=;
        fh=/xaH0XAXfxmZ3p4tN06SRmUz9b0W7YCNeLuwhGO5uVM=;
        b=fBARnT8iHHQjLoxTCU0TvwqROpamNpS1hg8jJUGMLRxhfl2u+LHrUnHqc7JQ+zXkys
         EzidGlZs1m5ecWGnP8xcF6bg6EB3lt2g2SGfQZWI+cbOz/ymdANkv8H4Jlzid0HJVyoY
         Esg2jPgZZ8ZPC7oou6bhwKyubNOVMypFN1dBWbqJUP5RF33eMcJANyrfZd+E+1JEi+hr
         L/xN2OZ0hvTko1lMcvrmFSXID+Gi5I1/LQfo/8ZP90WAe6nb64B7VLikaOyIQ1hX4WQl
         xWmFKG/cpCP/UzxvCsOqSfFYmaSpUe09d+nZk5oDXpYylfpP+ZAk209v1IWnb5xs/6tB
         0FlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780531493; x=1781136293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2kRTTiGEA9fSwm4VcnJewLOTBIpuhWKQa3sVuOIwjo=;
        b=DBzyQEnPbqMER4P8taw7BIErjwO43/oQVlQjII2JQmeeAAwKZSla5VEB+bHZYSw6Pv
         Cp+tFLhbyWfEuGrmYflTqA6LNz+Cty/jkPy+7+Svnd8KKyaznRhxD8PK0QzG7TfWTW7m
         Zlm1FAYY7WmKbN7f65ZsK4SFhSw+/gz+fk8PIogfPJn0iYYSi3gg7Gu3sNoVchf4Xv2d
         OJ5x3ufTyrescPH1oASv6ja+c/czGMKwUEWCagbv+hiA3cdiQ6YU0Fx7b6/wIfN3YYLT
         w8u2hhWRqlWHJsWAGT/0jm3VEdRvzSSXR7bIAJeBadG7rxcQHuS7JHpA2sfTgt7HyY/h
         YiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531493; x=1781136293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w2kRTTiGEA9fSwm4VcnJewLOTBIpuhWKQa3sVuOIwjo=;
        b=Wi+xHFjfUHrbLPkGlHkmH6zQetAuvjWlLmCZU55YPKILLd0wEm+4wpC+UmIS4ok+8t
         oY0twOXAP1+HpZIBnlMtnE2EqBk1EmQ/OTruCWV26x8tvqWyS9zRsmhNgOpyHFoFWwpx
         Q34el3JGCdSzSwzTQs2ODoP4O2IY5q3IEXOQnlDEwrdWuEjcHnxqZBd5p8DBnWYKKCoT
         z23JEBybi54AWntBhdcPvLKndt31WHRbDenkhjxcmgR4fbmImAEhTJfsLTC+ZAt3PxFf
         sYSoPZluDt8kvUg6UdvhvLYKooHVh0sYecRtKFAlC1aua5WVHMech9fhX22qSaZjmmt+
         dhPw==
X-Gm-Message-State: AOJu0Yw7pYyV1baT6lAqwS+tyyePelZghIICFeNqiSwjilgf/1gCRlr/
	4pxkRxUbFWKX2s/VPpcnjCRhyLT3GIo8hExZJLa4S+YmTWGO+8UyfzFa//v5Q9KG9xlJAGJy+8V
	BoLnedCUCheO8IevSi1/54MSqe43AeP/SA93f8iz+
X-Gm-Gg: Acq92OFtFKiqNx9gd9eviyh+XR8N84jM+1+aU3xF489wI2a1hZM1ro+JVrd8y71cADW
	zxZfJ6MsrREs8nB6KbhKudNSv++VFJo9perjAPuvZ5z92NiJ+uGtTm7KZqEG+XjWi0d8PFWOZ/a
	RoDUSmDWKacsUiZJDmh/NL22oL/7mAjgskyB6/tNE17O7ND32MMZ7EDBxo6r04UzUKcR2L0b6CB
	VHT1S4khVT/vSEHc23Qe5JhDn+FZrTE/1COqq/2uNr7+LiSdfDF1pDeSF4xsXRWQIFInSXkWhkd
	YkAZ7ByPb7jTm2KSfA==
X-Received: by 2002:a05:6a00:2d20:b0:842:7476:236e with SMTP id
 d2e1a72fcca58-84284f4c05fmr5480130b3a.41.1780531493481; Wed, 03 Jun 2026
 17:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83f77b2b-8c00-424d-b6f9-b044e7ea1ee7@sirena.org.uk> <CAHk-=wj6CtZS9hbwFjQcoNkPwQLoyKmk8czaBF6=bBOCYuXEUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj6CtZS9hbwFjQcoNkPwQLoyKmk8czaBF6=bBOCYuXEUQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Jun 2026 20:04:41 -0400
X-Gm-Features: AVHnY4KaJ8WCn01L0UzL3_uET6QLUt3oIjUBay34hOt2VgXCAmRWl97braE7GJw
Message-ID: <CAHC9VhRX1=tx4+arzuH76kirYFFJozexa5L=41Bb2QbgWZXOkQ@mail.gmail.com>
Subject: Re: -next status as at v7.1-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-next@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:20=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 1 Jun 2026 at 11:22, Mark Brown <broonie@kernel.org> wrote:
> >
> > We're reaching the peak of conflicts for this release cycle but
> > fundamentally everything is pretty quiet at the minute.
>
> So the "Hornet" LSM thing needs to bve removed from linux-next.
>
> I'm not ever going to pull it - it has been NAK'ed by the developers
> of the actual BPF code, and now it apparently causes merge problems
> too.

It's worth mentioning that resolving the merge issue was relatively
straightforward and we had a tested patch ready in a few hours; I was
in the process of merging it when your mail hit my inbox.  We see
cross-subsystem issues like this every couple of months. The good news
is that the linux-next process works well and we are usually able to
resolve the problems quickly.

I'll touch on the NACK below.

> The LSM people need to realize that they cannot override the people
> who actually write the real code.
>
> The security layer is not boss in the relationship. It's the
> subservient party. Security is important, but LSM's are not.

[NOTE: adding the LSM list to the CC line since I just realized you
didn't include it]

At this point I believe we are all aware of your dislike of LSMs, but
I once again feel compelled to speak out against the disrespect you
have shown towards the LSM developers and users.  Most (all?) of the
major Linux distributions rely on at least one LSM to meet the needs
of their users.  We've seen the importance of LSMs to Android, and the
real impact they have had on defending against vulnerabilities.  We
also know, oddly enough in this particular case, the importance of the
LSM framework to the BPF ecosystem; the BPF LSM attach points are
critical for many BPF use cases.

LSMs may not be important to you, but they are very important for a
very large number of Linux users.

> When the maintainer of a codebase NAK's a security model, and explains
> that the code has different needs and different security models, the
> LSM people don't just ignore that and go do their thing despite the
> NAK.

I think there may be some confusion about how Hornet works and
interacts with the existing BPF subsystem.  Hornet does not touch any
code inside the BPF subsystem, and outside of some minor PKCS7 patches
to enable some things from the PKCS specs, it doesn't touch any code
outside of security/.  Hornet's design criteria required it to work
within the existing LSM hooks and remain compatible with the existing
BPF signature verification code.  Hornet follows the traditional LSM
design pattern: it works within the LSM framework, building upon the
security functionality in other subsystems to satisfy user security
needs that have otherwise been ignored.

A BPF light skeleton signed with the Hornet tools passes both the
existing BPF signature verification code and Hornet's verification.
Hornet allows signature verification using arbitrary keys/keyrings,
just like the existing BPF signature code, enabling support for
dynamically generated/signed BPF programs.  In mixed environments,
Hornet can verify the loader portion of BPF light skeletons signed
with the existing BPF signing tools, distinguishing between existing
Alexei/KP signatures and a full Hornet signature.  Hornet also
supports unsigned BPF programs when needed.

As an LSM, Hornet can be enabled/disabled at build time, kernel boot,
and at runtime (subject to the LSM providing enforcement).  If a user
is required to run a specific kernel build, e.g. an "enterprise" Linux
distro support situation, the admin has multiple ways to disable
Hornet if it is not desired.  Any Hornet signed BPF light skeletons
will load without issue on a system without Hornet and Hornet's
presence does not block the existing BPF signature verification
mechanisms.

The BPF developers will quickly point out, if they haven't mentioned
it to you already, that Hornet calls into a 'bpf_map_ops' function.
This is true, Hornet calls the map_get_hash() method to get the hash
of a BPF map so it can be verified.  The BPF devs will argue this
presents a layering violation, but I would counter that several users
in the networking stack go much further than Hornet in their use of
'bpf_map_ops'; I find it difficult to see 'bpf_map_ops' as a private
API at this point.  It is also important to mention that Hornet does
not manipulate or modify the BPF program or map state in any way
beyond storing some state in a Hornet specific LSM blob, similar to
what other LSMs have done.

We've done this work, and tried collaborating with the BPF devs for
over a year, because we believe the kernel should verify the integrity
of both the BPF light skeleton loader and the associated maps.  While
the existing BPF signature verification scheme verifies the light
skeleton loader, it requires the loader to self-verify its associated
maps.  Relying on the loader to self-verify maps is problematic
because it adds an additional burden on system builders and admins who
must now also manage and verify the signature verification in every
BPF light skeleton loader on the system (how does one know if a
specific light skeleton loader suffers from a verification bug? what
additional steps need to be added to the deployment of third-party,
binary only BPF light skeletons?).  At the very least Hornet can
ensure the integrity of both the BPF light skeleton loader and the
signed maps without requiring prior analysis of the light skeleton
loader.  That is a big win for admins who care about what code is
loaded into their kernel.

Hornet lives entirely within the LSM framework, adds no additional LSM
hooks, remains compatible with the existing BPF signature verification
code, can be disabled in multiple ways if required, provides the
verification flexibility needed to support the existing BPF ecosystem,
and helps satisfy the needs of real users.  Why can't we support
Hornet alongside the existing BPF signature verification code and let
the users employ the mechanism that works best for them?

--
paul-moore.com

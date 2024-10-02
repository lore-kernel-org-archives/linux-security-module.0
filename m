Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D161CFEA3
	for <linux-security-module@vger.kernel.org>; Wed,  2 Oct 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879771; cv=none; b=BINcdHGLEjTmAl71GsO2poCR6UfJesIyEsofSoCDrHJN9cEMLDuAqDW5Nd8p1VipsvyjSo91651/lf1m1Ph4mosy0NscZNoB+GWct75c1h1cE/LGLEVJv0DUxCQ7O4Py/i9LjyJinUC+VN0411mIKoD6IlJ8+TBtvL51/yDMfU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879771; c=relaxed/simple;
	bh=3mBoeSyNwhDnb0OD4tPGjkrgPKxANJzQYcQNkIR4BC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcl+sSY6sBNImoXRzrL9x0Uae4s9/xAsPUifpalRIAU7VuW9GOblYDl1AwwVJgwMHMb0+gq1vKO6bw9iOw6Q7Fs8iQiwLM+3WnrbbR8kDeyo7SspxTBOpK2mBL/DrmePOVi/naK3tInXkRcSbm8+9aTkozpWULytWkvYrJNUIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bPHHuOCm; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bPHHuOCm"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1651f48c31so6690666276.0
        for <linux-security-module@vger.kernel.org>; Wed, 02 Oct 2024 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727879769; x=1728484569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNqDOG+2O8fGOeia4gWBFtj98yzUokIMYqbafLn3Ic8=;
        b=bPHHuOCmpRtoMm2jjlO80A5BbefVERFuv+1Lj4KS2cTrRMzEI3gbd9PkE++SjnVf1Q
         y15nscoubOgirvGi6Res+/iiMHdHfPy0OyGggmD6y2eO3JgK98ZUBX04fZOvXnaMf7Ia
         0q9r13eH4G4Ht3JW/+EKBKNs4Ro2QntzmuKSnb4zWrgcASeIMBq938N7q+BQtHwEPMPk
         9bhNLgGaFDRdMNQy0nGhvm78Cp2RJCIL1zTCZmOkdfTJ4U/rJnkEJ1Sx2LhdLNGVZ+6E
         WC1gsh+xLL/iwaLeLoFijxI9aLxUfmP/EPkXXMdBIDxPClXVcsz9E29f2spH7gl5xelh
         81Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879769; x=1728484569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNqDOG+2O8fGOeia4gWBFtj98yzUokIMYqbafLn3Ic8=;
        b=ZkK4oE32wPMVsj2Q0hgKjb4yRtGzdYy4KNBvHx2npmJSVFWpVRbl15OMoNcgEv2jKw
         CxL5zE+x/v483F+k+UYlp+qA4lEJIKrie6HWBnM5Q+yh7m7rGn0mucsp6tAwCIs/fI2i
         KL96e4LEaw72fkGCdlehoUNPjnCRm3aZCee+3nboGqX5L+t8czHdUO1b7euCB29LdVXR
         Xruh2U1RlRcBab3KrIU7PdNlvtpC6qQ9lh37UB17A5i/UuTJ03cza7u0yPdkDaVTk63X
         M4sm9hfmRt/Cqc00UtmmyiHTeT0xbKkcRHkz4YcSCliJKXFP4YWaFgsP3njdXSNYOQT0
         TA1g==
X-Forwarded-Encrypted: i=1; AJvYcCVEANjdCY/tZTCQ1W2DwCHM6vsv1Mey4+Y7gFQT60UKwfySWFh+Ym1j0CyllOieXflNGsT4YDUR7BDwufbFH0xSHjv2yaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN1/rkRD/LTuynuMGj5y9t3mhlKIezJvh2NUWksvqKwe/gLkka
	ZxPryIntjP2ELUV3nsSmkwCxSGgOrIbenJlyuEQ9eMhC5yGJvfc6oaDzokzD1utZ14bYPVU8ekP
	0TsaRz2a3jZChhwmBYnMhzOvc5S1h6jk1Z19X
X-Google-Smtp-Source: AGHT+IEPkyOk7U4HBqCCCOVTdHby4ocUbqpE/7AFDNr0WhYZ6AP/JEE2v4AKcnZY2FDm1Q/TTCtEYbsUhiI1CiH6ESg=
X-Received: by 2002:a05:690c:660f:b0:6d3:d842:5733 with SMTP id
 00721157ae682-6e2a306e268mr31691737b3.35.1727879768856; Wed, 02 Oct 2024
 07:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com> <20241002103830.GA22253@wind.enjellic.com>
In-Reply-To: <20241002103830.GA22253@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Oct 2024 10:35:58 -0400
Message-ID: <CAHC9VhRjq4B4Ub7kbD8uLZxL_CKSm=z+poCXBMmcfs=8ETHj3Q@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: "Dr. Greg" <greg@enjellic.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 6:38=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote:
> On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:
> > On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > Linus, it's unclear if you're still following this thread after the
> > > pull, but can you provide a little insight on your thoughts here?
>
> > I absolutely hate the whole "security people keep arguing", and I
> > cannot personally find it in myself to care about tomoyo.  I don't
> > even know where it is used - certainly not in Fedora, which is the
> > only distro I can check quickly.
> >
> > If the consensus is that we should revert, I'll happily revert. This
> > was all inside of the tomoyo subdirectory, so I didn't see it as
> > some kind of sidestepping, and treated the pull request as a regular
> > "another odd security subsystem update".
>
> I see that Paul Moore has further responded with commentary about the
> 'LSM community' responding to this issue.  I wanted, on behalf of our
> project and in support of Tetsuo's concerns, to register directly with
> you a sense of jaded skepticism about the notion of a community
> response.
>
> Fixing Tetsuo's issue, at least to the extent it can be fixed,
> requires technical improvements in the Linux security architecture.
> Currently, potential technical improvements in this venue are
> struggling to receive any kind of acknowledgement or review, to the
> ultimate detriment of enhancements that Linux should be bringing
> forward to address, not only this issue, but the security industry
> writ-large.

I've believe the LSM developer community is interesting in that it is
much smaller than many other kernel subsystems, despite the
substantial technical scope when one considers the LSM's reach within
the kernel.  This brings about a number of challenges, the largest
being that reviewing ideas, documents, and code changes takes time.
Everyone always wants their personal patchset to land "right now!",
but it's important that the changes are given the proper review and
testing.  You don't have to look any further than the recent static
call changes to see a perfect example of how overly aggressive
attitudes toward merging would have resulted in a number of real world
failures.  I agree that a quicker pace would be nice, but I'm not
willing to trade off reliability or correctness so people's favorite
feature can land in Linus' tree a bit quicker.

Independent of everything above, it is important to note that the pace
of changes in the LSM framework over the past two years has increased
significantly.  Even ignoring some of the administrative improvements,
e.g. process documentation, since 2022 the LSM community has been
merging code at a pace much higher than we've seen during the entirety
of the "git age":

[NOTE: using 'security/security.c' to be representative of LSM
framework specific changes seems reasonable for a quick metric]

# previous two years (reference)
% git log --after=3D"2022" --before=3D"2024" \
  --oneline security/security.c | wc -l
141

% git log --after=3D"2020" --before=3D"2022" ...
50
% git log --after=3D"2018" --before=3D"2020" ...
82
% git log --after=3D"2016" --before=3D"2018" ...
43
% git log --after=3D"2014" --before=3D"2016" ...
47
% git log --after=3D"2012" --before=3D"2014" ...
25
% git log --after=3D"2010" --before=3D"2012" ...
62
% git log --after=3D"2008" --before=3D"2010" ...
56
% git log --after=3D"2006" --before=3D"2008" ...
36
% git log --after=3D"2004" --before=3D"2006" ...
4
% git log --after=3D"2002" --before=3D"2004" ...
0

> We have made multiple submissions of technology, that can at least
> positively impact Tetsuo's concerns, and in the process perhaps
> improve the opportunity for security innovation in Linux.  After 20
> months of doing so we have yet to receive anything that would resemble
> substantive technical review [1].

I disagree.  I've personally reviewed two of your LSM revisions,
providing feedback on both.  Unfortunately both times I've not made it
past the documentation as there have been rather significant issues
which I didn't believe were properly addressed from one revision to
the next.  From what I've seen on the mailing list, others have
identified similarly serious concerns which in my opinion have not
received adequate responses.

The TSEM LSM is still queued for review, but based on prior reviews it
currently sits at a lower priority.  I realize this is frustrating,
but I have to prioritize work based on impact and perceived quality.

--=20
paul-moore.com

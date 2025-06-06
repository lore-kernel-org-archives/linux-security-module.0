Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F3020DD49
	for <linux-security-module@vger.kernel.org>; Fri,  6 Jun 2025 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246600; cv=none; b=pynyhAnTmfPJRSZR9z4DcmX8/lUlGeYZEZfx3FGx7SaUQ9e56tKg6gr9ELb2+U9HzhBxxO2JkfoR+9MfmZgHVlGKdo9PgLM50icY+XAuWV/zjxDey8I94Cx28lPZMfSE3GDFC72rcOHImCDvwkuzn0A0eX0015Y9Bmz+5z3NzIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246600; c=relaxed/simple;
	bh=+1Nw+TyZJ4TDFBc5uB8Kaff4ZPrVuFvYgy+0NOwMiQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NE/Lj9yphWUYRawcdFCscSWCwnhgdpugIr6TKFu8oy4oZviGOG5jY/jrUg9M8zjaZ2v/tJHgyMy5D0dqZeqz0PS0hKkOA92nQ6fuAtEeEP9jjFJwS1H+fKYhfFYSVvDyvjjoip1s56YK4+KUr84fKKJgyh03P5/vKQJNH62tfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYuTB8Jv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYuTB8Jv"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad51ef2424bso500845866b.0
        for <linux-security-module@vger.kernel.org>; Fri, 06 Jun 2025 14:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749246597; x=1749851397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAwnA42bcx8mfGt9sfzcC0fgUncFmk4wwB3OG1Jf+2c=;
        b=eYuTB8JvgMSMyIFvH0ouxCQXE94sUnMyxf5f/cwwr3U9TZj63tAr1OxctA0tk+YrdJ
         zD2s1AEG+ZzDJPUsvv14ydXpQMPuPXUA+IFGrUZ7TM/fsy61GuhigOSpAppWIT3JVjH0
         EqrLkOuGwIBDm0J/Qpm8TMMSEpDtqX6qXMrEQKEZvINeReSg7sBvTod5LuNYycWwOGT3
         znBhxD6EihhRogljbg546h9Khig+Lp/kziAayLBfyVBytXr2hTF7E1kyFaZFJF+sKVHd
         1bJQ43FVxFCCnFiiMNoaMNe4NQ87PUwIZVRY8Ucvykb4AhQryke5TdTchtlnLMBAwJV2
         SMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246597; x=1749851397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAwnA42bcx8mfGt9sfzcC0fgUncFmk4wwB3OG1Jf+2c=;
        b=tJoSRJ/c/B/+U+iWTwGreqscfu3JpJOAVtSmlTsMao35eqyL8SzCCvXiCZOqzkkQtM
         Wyddx7HqYK/2fKNuuCNrpv/f8rzdBUVVdBMP9Cu2Ud+paMkdC8VEk/+kaCBNuCk3amhs
         vcTaN0MSM8F4yEA594eS+kW0s5H/b0/GAIsUNBAsh3+sdfMmdQav9HWCTAGkujOpCgOO
         llk+KCuBv86ine2aE1Y/C0g7v9Q+mlCF2R0o1w+zSWYgrTeG52IW3qlaY074cdVEfKko
         aanRcYZzBQYHIoeUHkzG3DlDQiZi7QQpjYbfsVDdLM75XgnU1UQ3+jCFLleQHSPiMs2M
         JN6w==
X-Gm-Message-State: AOJu0YyATIa0vdEpZCn9YCqjBrX2lpmI77FmYCvG2QhaORpDN7QfPCF/
	tn0GKBJ9sqXfxj8r9DEC60lGHklQ6eHsYUqaFMPAPOQPj7NkBLZCNkbpKI0cLHQhceUeQBVCGhf
	JKYnJVFVDIW+tU6Jifc3F4UBJOZITjXbWSnAnJ0d6SoAbnYTqZsTysDId
X-Gm-Gg: ASbGncskmNYwEbnGs9Ciwi3uC+P97ZEsb/ADOVLbZwS/kaommyiUx0kUkB8YDQyborY
	+jx/I3FU16sPy80jtEnwQcahwrFOiMWYi+yMJq99Hw1kCGmmEneGG+EbA4AVe2D+IUvJWO6RMYu
	NmPkhKQGUAG6VqmVL0oRg3QQCKK4dOeHA9EBrhxVDAC3UJH2hM8eI4xRAq/eiTMIQpsy+aIlo=
X-Google-Smtp-Source: AGHT+IGApFPqU4Wt1QOk/QXzfXzbMGccnrir6W/Cc1Dywxlmqei5pw1qHZ+dZyJYfRS6FFWh+eLtKgaCAZQutEgOXc8=
X-Received: by 2002:a17:907:7247:b0:add:ee2c:730d with SMTP id
 a640c23a62f3a-ade1aa06c7fmr450167466b.44.1749246596556; Fri, 06 Jun 2025
 14:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA25o9TqH3LNWy8F2tXO7P6AdQk0x+boWiPhy+CKL=wDouKODw@mail.gmail.com>
 <b1bf0aaf-0290-41a3-8bbc-a61c6c8b2e74@schaufler-ca.com> <CAA25o9T3AQJ-zNcb3VuhCwbKQGSFtSBbeN_BRYv0L8M-pQKugA@mail.gmail.com>
 <e6058692-de6f-4206-89cb-af6bb70dd800@schaufler-ca.com>
In-Reply-To: <e6058692-de6f-4206-89cb-af6bb70dd800@schaufler-ca.com>
From: Luigi Semenzato <semenzato@google.com>
Date: Fri, 6 Jun 2025 14:49:45 -0700
X-Gm-Features: AX0GCFvMuAIZxVALKSMsMIzrAA_oU20VsGIE-XjGX5etOHA1_A3T8czaSQQEeAo
Message-ID: <CAA25o9RZUGerfq4a7nLRVyuuGkJduH+apfM1ZKCq1XWD=zLBRQ@mail.gmail.com>
Subject: Re: adding CAP_RESERVED_# bits
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 1:42=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 6/6/2025 1:11 PM, Luigi Semenzato wrote:
> > On Fri, Jun 6, 2025 at 11:32=E2=80=AFAM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 6/6/2025 10:57 AM, Luigi Semenzato wrote:
> >>> Recently I inquired about the decision process for adding a CAP_DRM
> >>> bit to capability.h (to become DRM master).  It occurred to me that
> >>> the process for adding ANY bit would be fraught with controversies (t=
o
> >>> say the least).
> >>>
> >>> So I looked into maintaining a patch in our own kernel sources, but
> >>> that was surprisingly messy due to the build-time dependencies of
> >>> capability.h and the way we maintain and share sources internally for
> >>> multiple kernel versions.  This would have been quite simple if there
> >>> were a few reserved bits, such as CAP_RESERVED_0, ..,
> >>> CAP_RESERVED_<N-1> with, say, N=3D3.
> >>>
> >>> Would this also be controversial?
> >> Imagine that there was a CAP_RESERVED_0, and that Fedora used it
> >> for DRM master control, Ubuntu used it for unsigned module loading,
> >> an android used it to control making the battery explode. How could
> >> you write applications so that their use of CAP_RESERVED_0 could be
> >> considered safe?
> >
> > Sorry, I neglected to mention that I am thinking of embedded systems
> > where the vendor provides both the OS and the executables, with no
> > provision for installing additional executables.  ChromeOS is like that=
.
>
> I have worked on embedded systems, and don't believe that the problem is
> any less serious for them. One aspect of embedded system development is
> that kernel versions don't change for years, and then take huge version
> updates. That will often require updates to applications and libraries,
> which have also evolved over time. We saw this with the introduction of
> systemd, where the model for launching privileged services changed radica=
lly.
> Any assumptions about the use of "reserved" capabilities would be dangero=
us
> when the eventual upgrade occurs. Especially if the vendor of the embedde=
d
> system has a different set of developers than they did for the previous
> release.

I agree with your assessment of danger, but then the choice is between
maintaining a set of patches reliably, or not being able to do this at all
(when all bits are exhausted).

I can't say if in this case protecting developers from self-hanging
trumps the convenience of the feature.  I would say no, because
developers who maintain kernel patches for their product already
have infinitely many self-hanging opportunities.  But it's subjective.

> >
> > I agree that major general-purpose distributions would not benefit
> > from this.  So the question is whether it is worth sacrificing those
> > bits for easier security setups on embedded systems (and being
> > able to do it at all when eventually all bits are assigned).
> >
> >>> Thanks!
> >>>

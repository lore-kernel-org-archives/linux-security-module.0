Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BA2E7BBD
	for <linux-security-module@vger.kernel.org>; Fri, 18 Jul 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857057; cv=none; b=Y4+D9FjTcVCv63h2SX4KeLI9zJqh2k5NEuKMTBhcS/s2g7sy0n8S73aHCtvJgFfl+nNdvqH0+kYbXnt/4X3loRAYuMs6hjxj8AZzIfnozdQxfQF2YAfjcpAnT4dYwC/ijEv8HezPwuIt7KhfZDGA1JjmQEz8d3Ym5Uchivetmec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857057; c=relaxed/simple;
	bh=CjXVboOD7jqFsvDghr8v4qIw9uJof1firp6NqKPVwxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKoN61GzXUyzy5IuDmSjBlKWxmk/pmGIohQ6hikxCmZ/LWrDIbMWe1j3kbokF5xd9U50Re/NLFNEARirnLkw1fVf8hhxN6xpcDonDpjghvDK0dCazI26mqbN3urBO0stjoWZVv+DulyAKDcSoBLV53NMI9gcE6oqL3uAbqQyU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vEPL2M+U; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vEPL2M+U"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4562b2d98bcso335e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 18 Jul 2025 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752857052; x=1753461852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYyOeEuwNocsHdGNCsBfI8Qe4KQ4QZ4n9Q1Dj/3rQ6Y=;
        b=vEPL2M+U4NlkFiH8vw9Mi0q0YwQy7SCstLVL0r5OCYmK548HpmG3Zl/xALUvgL+pYl
         VTCPaY2AIlcOkXusskFuOLDQEiS4As2qyZpYeqSso8fgKivA1LN7apYF/DJcrP525Bda
         htNhX/ZuEix8J+BAH+nCAnLCATtBCbvbj5AmOJMg7WMdqqF/a4HlPKiXCKlKFv2SgFPh
         B5+z+pJg4Pc4gFZkj6iCEDJ5anafmrYVkGrev9SdStvLYPLQ+D+Hix3UKf+8OkyjyHhc
         SVxOMWDT9u6cq4hUBS/9SaovcYMmOxOe2agNv0cm2AkkUX5iF+3Jwr724k9Q/P1aGKOQ
         Sfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857052; x=1753461852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYyOeEuwNocsHdGNCsBfI8Qe4KQ4QZ4n9Q1Dj/3rQ6Y=;
        b=jWb4GSGmuiGpr027DSlFSDgH7fsnc0v1htits3eLAsGUZ6YLiEYpQqchPDtDd0cGnu
         wZ7nlk+06gPCKK27Vua1Caqun+4b+inJHr8ZGlwXOG+gvnysT+2u2IDsPsmIW1YjQLnb
         yArObTsSGcNL2BcHGAd9v2ZAhpbntuc52y8PSmMmF0fhTqtJ34pdQTyJs92BcXyAblEx
         6qvgNgQK5I0hhMwHNdaNwgmb65yTd/OX8ksDWfMbEVaBAx2PODKnoWSf2X5m9IfoyNC4
         pxjq/bBuELBHDLRpcL6ZcCLwTYErZkL3I5PfjzmcdLlq98415vpMtdj1T6ow4xV31Ew8
         /eSg==
X-Forwarded-Encrypted: i=1; AJvYcCUOTX9O6bVCVRKWlzA+zCRy0N8ol7OUcWw66Mcc+1FrR6Xw8pvBUmeVhC+fId02cl+QDF9OhWV0A5Y1rLjBj9UkqI5c5mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZqnF3ZGDLC5y7/A3Sx14GEVuRMFaY2hKeGIxHi8uJ1V7kjf5
	ccnEXGfbpG1KFwixmg5115gOmWnKGMbs2Slj+WqdG/esgj8P/5He6OrZ2rfNENhHe48YdBHhjmB
	56LO+jL7Me7l/cXJRxhQnFoCld92gF9QyU2hT4SYc
X-Gm-Gg: ASbGncuqlXi+4LWTU+Cxlume3Ck62N5o3l0uXarStsBtq2xkUB3n6BpNU2d4CtKRwfd
	OkWIqp7ykza+gAV1KApcp7cM9LEXHtfKGxTGCz+5eijHwKd301ICD4xEaS77rSirywkoua4btbK
	3sqecFiOoDveuBNfQ57Gj9qxDPtk/Luk5V07I9cukHgUW7MsXLJ0NNKCD980VG79TLt0X5TK/DU
	ZFy7bl5ZAINK7NHDDhmmJHftVm2QW2RS1tsyrMevtLdKg==
X-Google-Smtp-Source: AGHT+IGfFvKzY08YuywrQMEICEvAuGeTVE+YW6Kb55R7MDhzINiZnoYDjpVLaeSISZL79sgVvYJwp63L+LUq6vf/bhs=
X-Received: by 2002:a05:600c:35d5:b0:453:65f4:f4c8 with SMTP id
 5b1f17b1804b1-4563a7821f9mr2358065e9.3.1752857052166; Fri, 18 Jul 2025
 09:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718-yama_fix-v1-1-a51455359e67@ssi.gouv.fr>
 <CAG48ez23HLtb9GJ-BbSXaWFhdPjXyFNED9fbuyaNP5EXJ_Wv8w@mail.gmail.com> <cehkmvl3y3u6qugobjo2h4yez6h5uw5pffqcr3mfjuki3sb32t@nr7nxkk3bdsg>
In-Reply-To: <cehkmvl3y3u6qugobjo2h4yez6h5uw5pffqcr3mfjuki3sb32t@nr7nxkk3bdsg>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Jul 2025 18:43:35 +0200
X-Gm-Features: Ac12FXzUGFJ7pnOjsyrzSLeBgsD9Po9gE2spiaKDjwY_YHbiT_yMwuF9Rp53xNw
Message-ID: <CAG48ez2rKDc_OPFYYaHahAdZWYTYwnF-cQBYf28=_5aAjYy2UA@mail.gmail.com>
Subject: Re: [PATCH] lsm: yama: Check for PTRACE_MODE_READ_FSCREDS access
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Cc: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:55=E2=80=AFPM Nicolas Bouchinet
<nicolas.bouchinet@oss.cyber.gouv.fr> wrote:
> On Fri, Jul 18, 2025 at 04:52:51PM +0200, Jann Horn wrote:
> > On Fri, Jul 18, 2025 at 10:47=E2=80=AFAM <nicolas.bouchinet@oss.cyber.g=
ouv.fr> wrote:
> > > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > >
> > > Currently, yama only checks if the `PTRACE_MODE_ATTACH` mode is set
> > > during the `yama_ptrace_access_check()` LSM hook implementation.
> > >
> > > In cases of call with the `PTRACE_MODE_READ_FSCREDS` mode, nothing
> > > happens. Thus, yama does not interact properly with the
> > > "hidepid=3Dptraceable" option.
> > >
> > > hidepid's "ptraceable" option being documented as follow :
> > >
> > > - hidepid=3Dptraceable or hidepid=3D4 means that procfs should only c=
ontain
> > >   `/proc/<pid>/` directories that the caller can ptrace.
> > >
> > > This patch simply add yama a `PTRACE_MODE_READ_FSCREDS` mode check to
> > > enable an interaction with "hidepid=3Dptraceable".
> >
> > Please note that PTRACE_MODE_READ_FSCREDS is actually a combination of
> > two flags, and the intention is that the PTRACE_MODE_REALCREDS /
> > PTRACE_MODE_FSCREDS part of the flags should basically only be used to
> > determine where to read the caller's credentials from:
> >
> > /* shorthands for READ/ATTACH and FSCREDS/REALCREDS combinations */
> > #define PTRACE_MODE_READ_FSCREDS (PTRACE_MODE_READ | PTRACE_MODE_FSCRED=
S)
> > #define PTRACE_MODE_READ_REALCREDS (PTRACE_MODE_READ | PTRACE_MODE_REAL=
CREDS)
> > #define PTRACE_MODE_ATTACH_FSCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_FS=
CREDS)
> > #define PTRACE_MODE_ATTACH_REALCREDS (PTRACE_MODE_ATTACH |
> > PTRACE_MODE_REALCREDS)
> >
>
> Yes my bad, I should have sent the hidepid [1] patch in the same batch.
> The idea here is to take "hidepid=3Dptraceable" into account. Which
> already calls yama with `PTRACE_MODE_READ_FSCREDS`.

To be clearer: "if (mode & (PTRACE_MODE_ATTACH |
PTRACE_MODE_READ_FSCREDS))" does not make sense, because it expands to
"if (mode & (PTRACE_MODE_ATTACH | PTRACE_MODE_READ |
PTRACE_MODE_FSCREDS))", which is always true.

Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AADF1A8F71
	for <linux-security-module@vger.kernel.org>; Mon, 17 Feb 2025 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739833761; cv=none; b=dzPacDOMMnZexmyx+8SbumuFaEll12oq70MIjsIr8BaFbXvOuDSK3w9M0IjUL42lpEx3qZRfXU22+CCG85rlWm6WWosQgTS/IBvMHPsY9ZaKTHHeJ2QvIc3xbNnsam8rMC+pf14RSI7r+hoXHW6EA5fcZ5h3XujRfubnTSrlXVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739833761; c=relaxed/simple;
	bh=BwNPS53w4xF3ql72DmGgygVOWK2VK8uL8CyO12d8Opw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuwMjikOe7XyNhHxtaxA6Cxz5Dx/JUq0Du4+N8mRfLsu+A5DeecwThQjK0BMI3SqmTU/TcXacvmjQXeS9lKYN/ZXjD9I9IUM0Migv9F9lA3yZcB02YybU22X8k3pUalAyG59d1Wb2zmXLrriOBhEXr9NNf7dl/9XgjJcv9tDVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GSCJoeKW; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GSCJoeKW"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef7c9e9592so36973517b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 17 Feb 2025 15:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1739833758; x=1740438558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+QIhhbHlQHwTRjyCuWMiGSUjUUNNx/rbC2zutM+tv4=;
        b=GSCJoeKW/J/OzHGK6d81crM4Hf3Pgg9cTDiSWUspUjFqfSiTpv/1tqAiM1nPbqrFvg
         hEj83r8H4FR3kef/XLywzGMEAdMwpCoAOgRQHB51yGjX8zqGc9XUXvt9uHK5O4mMuVaX
         Uoh+OPXZdayk984XkJcMS/EoVG8f84YvDzw0dS5a8mVIn7IT4ccIDeCPIKiphDdh+KXy
         wmahLIFk7ekLc6fvQSWgncYANgWca3ha8Xa8CEd74FRcpN3XSp4x8bboJllHxjrWobmD
         KzTUU9MOF4Sikc3En1RMrNCD9v0PtMORfrCzMHD+Jqc550gQ8GHuJyRs7+TokwsZS18K
         0JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739833758; x=1740438558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+QIhhbHlQHwTRjyCuWMiGSUjUUNNx/rbC2zutM+tv4=;
        b=kSa0N7fFtgG/rTLy/AI/H196XeGIadYYFzv9L0YrN75KEuIVCFtFPx7hRmVQ53m6su
         l5YSw98Nv6eFo9I/PACz+cYu2NJ0/zLlLdxhAEbVWG4pkie/Y85EPHk1Role70W44uI6
         8I97SZLAAPmdIOVUSBNGArVwYCYIPQE50aOP/X6BuwiXNlWDiEv42Z5XWzHmm52JbbJA
         MO5TaVA6SFSSMhi9j92dH1OQQsW6DD5ZCtLY6AgsTvXHxBzl+zZzJVqHwJ8egFAVMZUd
         HDtJCdZIen2rnXU3u3VgLmMD1pPEcWvt7A6KkMJQ8gnjwiQZaZK5mEMtKNhC/Rom9sZb
         56Dg==
X-Gm-Message-State: AOJu0YzGG9Yxx8kLqvpTKCmdC9M9j1khG7S7hhWhSRA34qM+jfd2HqLc
	5u78UBxGcDiWTfYSXmw13njSRDSI3YnpKbt4nvWY/UhLCxrcJLY+WmMZGSmeukZPFaaGUQAkEVa
	hgEyLHGDPb/Wy80FNCrTP86q4T7lMUQ1emdtV
X-Gm-Gg: ASbGnct8nc6ASMGlptTN2dKuQ8xtX29qiJt/WffZC8GV9+zxp5k839/HEjBfYbmwj5X
	3A1HkiRb2sId2xIs5UK3LQgMT8B1jMmRJXpfUT/IguavZ/Q1jhC4o2eCYTyqbYjGMSMZD3rm3
X-Google-Smtp-Source: AGHT+IFfzUdHvXZltLiZdcP5irnNHzde58g8jKTvV59iWKN2XJh6XKB+iiHFvnwY7rBq3M+QXAkvQMFIiCvdcSL6hLE=
X-Received: by 2002:a05:690c:4c0a:b0:6f9:b189:3cc7 with SMTP id
 00721157ae682-6fb582b757emr93667787b3.18.1739833758239; Mon, 17 Feb 2025
 15:09:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826103728.3378-3-greg@enjellic.com> <8642afa96650e02f50709aa3361b62c4@paul-moore.com>
 <20250205120026.GA15809@wind.enjellic.com> <CAHC9VhRq0PrH=0n6okkvfed=8QQOfv-ERA60NNWvLXetgrB_2w@mail.gmail.com>
 <20250207102024.GA6415@wind.enjellic.com> <CAHC9VhSd-5Lm4+DPWG-V5eav5k-Q1evh3oVHxgB7in2o+XMMEg@mail.gmail.com>
 <20250217125325.GA11696@wind.enjellic.com>
In-Reply-To: <20250217125325.GA11696@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 17 Feb 2025 18:09:06 -0500
X-Gm-Features: AWEUYZnkc2mEsqeaY7vuZ3eTb4_LlXRnKNWXs9DjpYSUNKE9nCD1iZ7DdErZPyU
Message-ID: <CAHC9VhQRz2ofH_HgUGw=voNyP8nYKQZwJGg_wb+hgGfXHex00Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
To: "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jmorris@namei.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 7:53=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote:
> On Fri, Feb 07, 2025 at 07:29:58PM -0500, Paul Moore wrote:
> > On Fri, Feb 7, 2025 at 5:20???AM Dr. Greg <greg@enjellic.com> wrote:
> > > On Thu, Feb 06, 2025 at 10:48:57AM -0500, Paul Moore wrote:
> > > > On Wed, Feb 5, 2025 at 7:01???AM Dr. Greg <greg@enjellic.com> wrote=
:
> > > > > On Tue, Jan 28, 2025 at 05:23:52PM -0500, Paul Moore wrote:
> > > > >
> > > > > > I believe the LSM can support both the enforcement of security =
policy
> > > > > > and the observation of security relevant events on a system.  I=
n fact
> > > > > > most of the existing LSMs do both, at least to some extent.
> > > > > >
> > > > > > However, while logging of security events likely needs to be
> > > > > > asynchronous for performance reasons, enforcement of security p=
olicy
> > > > > > likely needs to be synchronous to have any reasonable level of
> > > > > > assurance.  You are welcome to propose LSMs which provide
> > > > > > observability functionality that is either sync, async, or some
> > > > > > combination of both (? it would need to make sense to do both ?=
), but
> > > > > > I'm not currently interested in accepting LSMs that provide
> > > > > > asynchronous enforcement as I don't view that as a "reasonable"
> > > > > > enforcement mechanism.
> > > > >
> > > > > This is an artificial distinction that will prove limiting to the
> > > > > security that Linux will be able to deliver in the future.
> > > > >
> > > > > Based on your response, is it your stated position as Linux secur=
ity
> > > > > maintainer, that you consider modern Endpoint Detection and Respo=
nse
> > > > > Systems (EDRS) lacking with respect to their ability to implement=
 a
> > > > > "reasonable" enforcement and assurance mechanism?
> > >
> > > > As stated previously: "I'm not currently interested in accepting
> > > > LSMs that provide asynchronous enforcement as I don't view that as =
a
> > > > reasonable enforcement mechanism."
> > >
> > > You personally don't, the IT and security compliance industry does, i=
t
> > > seems to leave Linux security infrastructure in an interesting
> > > conundrum.
>
> > Your concern over the state of the LSM has been previously noted, and
> > I assure you I've rolled my eyes at each reference since.
>
> Addressed at the end of this e-mail.
>
> You can also see our reply to James Morris and the announcement of the
> Linux Security Summit in Denver this summer.

I did.  As Casey already mentioned, you are free to submit a proposal.
I believe most of the program committee will remember you from your
previous presentation.

> > > For the record, just to be very clear as to what an LSM is allowed to
> > > do under your administration, for our benefit and the benefit of
> > > others ...
>
> > I've repeated my position once already, if any current or aspiring LSM
> > developers are unsure about some aspect of this, they are welcome to
> > bring their specific concerns to the list and we can discuss them.
>
> For the record, we did bring a specific concern to the list for
> discussion, you removed the question and example we raised from your
> reply.

I routinely trim replies to improve readability, especially in the
case of large emails, and since mailing lists are archived no data is
lost.  As far as answering questions regarding hypothetical LSMs, I
see no reason to do so given the nature of your on-list comments of
late.  I've provided feedback on the specifics of the TSEM approach as
well as general feedback on async enforcement and that will have to be
sufficient for now.

--=20
paul-moore.com

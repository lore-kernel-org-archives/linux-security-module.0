Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF72EC296
	for <linux-security-module@vger.kernel.org>; Mon,  5 May 2025 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486628; cv=none; b=dotsyyzDIOApt+i45QZ33dICOKrg9kS0INYjKQSnvH+iCvP4bZsDu12Qh1+fDNdqJfQraiprVB/+zm+eCu49oEgwgMxQiS9bX1fGUC4SuleynLCmK8wjI8MWYCTJrQ3dkgPiUC9V/GYMyXzruHrKl/L9CN2sHTHWcgt3DbPiGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486628; c=relaxed/simple;
	bh=qVIMucWYhQQmrnIUsqayfxBL3PJvgg54V5ALqD74x/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3btnju39xrePo9uUSNw2xBW36DqCrtr0azWkdCEkIdk3Th8Izkd0CRpv+9igl242TnngkjklxVWWS7E/d3YAiaQz4tV12ScWF73WAWLPvXVYBpHWGUHHOD/UXRvHgNX3Zov8N/RpW8ifv8wDI56u2+2Dy2qaPm+Q4nukQIe3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a0zT1a8J; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a0zT1a8J"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7080dd5f9f1so35073737b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 05 May 2025 16:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746486625; x=1747091425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+iVBEAosxLKnwNp7EYrSMpmSACK+QXajCsOY9mjAfs=;
        b=a0zT1a8JJ1MV4sMcfxfSF0WpoatTHGnp0PGS3lu4gjy6zr4fD56Ot+/ZEkoS9hAANX
         c46aCT+bZf//Hr7RhdUXm5MnSP+Fv1TyElwojdk4JOmKwz8/RxLKw4ZZNq0A0G49oiJk
         w0xUjW+5PWES0ZQGlfejhbwAqbNkuCgRYp+RQYpkAdnSJxdv8L5uU+/3Q7xMq/Y177N5
         nY9maGbailSJx2uEe27SpgmBKCdnRpzgZDSAwryMPkKRgK2Xy7QLsbXsNFyJwE+fnnvb
         Z+1ZW9wEWqkOgr8JPWsVTD1Aj4wKEM1tgrh0t+9IfPum9BObSsrshFD0ER1ElNf23HuL
         A8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746486625; x=1747091425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+iVBEAosxLKnwNp7EYrSMpmSACK+QXajCsOY9mjAfs=;
        b=eByD51/Wyfbq8CMpod8kicJSrwp3T62zCCVbpcItpmmD77GVgI1Faak7bttJpmkai9
         7CkvAe1lCOWPFNsAXee+MA2u3kfUlE8APPJ0LP1HO4Mk8fUCnY1G2MJ8yW/3+8PoQB2U
         GqFgGgFuqfiu2Ly76en8jyi01X0kKJX8e98LVd24fO1CVM0gnPbQsspPSqihkYK/vkhD
         NfvKusNXTgR2WB5LocjqMGFpaCV1Vv0E/Tcp0H1TmemMQOYBFuggjt5jyFqdLWyqYBwt
         nPkKMPYME0JyIoX2Wx/xGK69qjdYosPLQ1RPEDAJMoG67DP/unA1xVumNLvh9CMzCZev
         s53A==
X-Forwarded-Encrypted: i=1; AJvYcCXxm3PAj7/5qsU8VL4VtNGSuLi0LZ5QkPccSWEuZ932Bd8f8QPC8PfKojAcq8fQUQ3emB4T7qXsJmQWQGu+BU4s01G59D0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6QHqcqo2eFq5Ay3lhKWtr7XWdJ2wSlWl7+ob/27H8blJpS5wl
	SuR1V409RB7Npz8D3MYNriAfYNlSQHvP0IyZ9EI0zFSB1vfgyJ99ZTNFbiFBKv2NOQUiQdFG/kS
	RWG8PF/N/bTldS82uLYSIju0mAfOCszs8lkRR
X-Gm-Gg: ASbGncs/flHRq+wyPrRvDCsbWVcGVui7c23td/8qbx9usJluyZwX1+yHPKTLmjb2KqI
	G6dDPo5lQOi8VgUYkPH2bSgyeL8wHzGz55jHPfijCKHcPAdheG2aEkCqnTvOsWX/QbKfE1yDqso
	Vfp8mWHykUHRns0MR03TqMPw==
X-Google-Smtp-Source: AGHT+IEWl5HCP40+DrWUKQ1DcVZEc7DP/II33BnnMjYnBIZa26h2fSxE1b87Sz5ITwYa3akEE4pXieesqPi3FtoSt7M=
X-Received: by 2002:a05:690c:893:b0:6ff:1c8c:b670 with SMTP id
 00721157ae682-708cf033d01mr199251387b3.14.1746486624598; Mon, 05 May 2025
 16:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
 <295201ef-5299-4bf0-b0ee-6e1e2a74174b@I-love.SAKURA.ne.jp> <CAPhsuW4U5ULtOQ9ucucs3bs+jw+EbBzrCfhAuvOCO=1g5aWAHg@mail.gmail.com>
In-Reply-To: <CAPhsuW4U5ULtOQ9ucucs3bs+jw+EbBzrCfhAuvOCO=1g5aWAHg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 May 2025 19:10:13 -0400
X-Gm-Features: ATxdqUHSNszAMBd0E5lZHm66zOiqlvGAK6weuYsqN4hjictp2ivgQdwRnohGHic
Message-ID: <CAHC9VhRBkqzEkJLyZ2gbdyfU6C3grGSOQUY40G2zA5+HnQZ2hw@mail.gmail.com>
Subject: Re: [RFC] LSM deprecation / removal policies
To: Song Liu <song@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-security-module@vger.kernel.org, Fan Wu <wufan@linux.microsoft.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 5:54=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Sat, May 3, 2025 at 4:47=E2=80=AFAM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > On 2025/05/03 5:01, Paul Moore wrote:
> > > ## Removing LSM Hooks
> > >
> > > If a LSM hook is no longer used by any in-kernel LSMs, there is no on=
going work
> > > in progress involving the hook, and no expectation of future work tha=
t will use
> > > the hook, the LSM community may consider removal of the LSM hook.  Th=
e decision
> > > to ultimately remove the LSM hook should balance ongoing maintenance =
and
> > > performance concerns with the social challenges of reintroducing the =
hook if
> > > it is needed at a later date.
> >
> > What about BPF-based LSM users? Since BPF-based LSMs cannot be in-kerne=
l LSMs,
> > it will be difficult for users of BPF-based LSMs to respond (that someo=
ne wants
> > some to-be-removed LSM hook) when removal of an LSM hook is proposed.
>
> If a LSM hook is important for an out-of-tree BPF LSM solution, the owner=
 can
> add a BPF selftest for this specific hook. This does not guarantee the ho=
ok will
> stay, but it can most likely detect unintentional removal of LSM hooks.

Sure, however, like you said, we aren't going to keep a LSM hook
simply because it is used by a selftest.

--=20
paul-moore.com

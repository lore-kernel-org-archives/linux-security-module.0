Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DD253350
	for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743757; cv=none; b=oHKLuOf5PywWQJGEJuybE1oYM5DauAvRoguKS8d1X/OQ3WWFX0BOnokB2uCbuccIwM75Wl9t8qBH6/RkffXB8lHouzUUPBSqEw4FGT+cTE4W+bOS3erncjzmJZszK6J4lm6e17sFIc+Sr1MA23zzRCBuotTDDHl5uKTSDbb0gcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743757; c=relaxed/simple;
	bh=UMOe/4Z4kVuf/7QpZR3sg7y8Stw+4YrPdcDaFHTRHjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWePDk6KwzL9xvqLMEjxoPIs5VGm26GfEAaCaYf0MDHlmWYY0VhnQoiCRBm7kisl0/pKb+wh3UQ852xlXkacRv9RIFA95Gc6rpPLNtSLyKfx5cGG/DyFMWvJnNmdSUjh1wGulKtv3ECdn8r28gcI6UnQwbxkiYx6ykLWRFXRCOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CdilRHQU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CdilRHQU"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-324e6daaa39so504202a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 20 Aug 2025 19:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755743754; x=1756348554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POzxLiaahI/jDhOTSERUZBDU94mQ+lLR+a/gmK+XrKI=;
        b=CdilRHQUnaCCMfQueLF7h81iX84zNNVoAchqmp1Bf0fB+byDYXCKdySimK10j14tCS
         GYOvyS6GoiWepYOWKuNwQ87F212KAJuFTRaLJxuXAUHvlTjKQ0GUdFoTjiEKP1d7YNe9
         3esq8g/9uazsvPnB5YUpx7AhZOD1w4YBzcIs60jdaS+hu7no+3grqcGc/lKskQBg6cuS
         PJcsCETL0FDISuJSobfmoWTvfai46e48AcRsLQKBES4pRbHe7sp77hPbmcSMRd2pCZ6N
         Nyt2FKLN298qrWtq0ONGZ8/xCaiSeyW0oNsR5N4hldx9rALnEhSnSBlg33UJCvwGzLMk
         PKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755743754; x=1756348554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POzxLiaahI/jDhOTSERUZBDU94mQ+lLR+a/gmK+XrKI=;
        b=af3xMI7YMeoF7lPoyzfK4fWJ3TzZ2Wn2MMt2z45CkdvVkWHxo6G5Lv/CAvAfRm+X13
         +9y0BuR5lrVeMk5XeRVy1IeDItehIDojnGBP6wKi9MQr5rSSAREZ8ePltJ9JZO053zqF
         A6aHosNa0PLN9sdY0zGRHEN0zC4p+3h+G+Wz42y7kaaJmV2yTThY3uBnH+Bo76nxoYZy
         2marouX68YCKDMb1b3TDBpqfIUd4+20KK66gRvPLQY83Qe6a03qr1z+LSguWHrZ7xty/
         wzvbjaTwWZEr8A2kEqHEENMtfSjEF+PidW1xWQ4Y9Jnz8WJAgqonPai4uLJ57jGq2fJf
         7IEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2DWDRG4emEEDlToHXkQUS9M5ckahjeNoDOJNT8Lafdo762Ox6s4IeoNK4QsQ+9j9Sx7sbtpcjyvjikNg/oeGp8u2bqhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGnqNBb8Q6QJKLvPF5KFbg1y/Mso5vjzjSLLXkXdFaJsomAbKt
	rZCZptdWaezp7MyhUNGb5jxSTa9RZrm5V38/FpKRvAevD+BqdSfHOVWw9o7zp194ldy/ZNdpnmG
	BNNZhIbQrQi280HK2e4Lvuu4ZbWxMYGDCVNorciNIA+tQebgz/po=
X-Gm-Gg: ASbGncstsHs0lHqplxiqv33hKLydpIB8EGR7InrZWx2s0AkKA+lyoMYMODHvRtxDNYX
	Xw4t+ulWL4d3e89iXt1J2QPBaf5wGi9q+xDIgEtEyadLUpy9Bm9oEJWEaaM6KzM1MKjXOsynIC9
	Yz3t8jZhYInVNju/6ccBC3ZyJTyTldSBuYZ+XQZfqYOL/b64e/5EJDqmN/ttd+zKqRikM3rMVVu
	Y4En3k=
X-Google-Smtp-Source: AGHT+IHZWyVzY/UjsBpvZTte6OxIdjh2zc/c0qTR4//IKIQvlO2fWpMcIjsD8BgdPJVG/P+E26865bz9jdnRUnE20ro=
X-Received: by 2002:a17:90b:4ac6:b0:31f:20a:b549 with SMTP id
 98e67ed59e1d1-324ed069184mr1241774a91.7.1755743754243; Wed, 20 Aug 2025
 19:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com> <aKZ+2NMx+ZQhpySY@mail.hallyn.com>
In-Reply-To: <aKZ+2NMx+ZQhpySY@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Aug 2025 22:35:42 -0400
X-Gm-Features: Ac12FXy-Gm-jBci81Eg4G3npbBJYpla6vOiWCIIr-aWGTY0zNy59UZ5_APaALqE
Message-ID: <CAHC9VhR-5Rwg132UsLdpJgM0c51HYBrBDivBinw3YcYqe0QTKA@mail.gmail.com>
Subject: Re: LSM namespacing API
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 10:05=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Tue, Aug 19, 2025 at 02:51:00PM -0400, Paul Moore wrote:
> > On Tue, Aug 19, 2025 at 1:47=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:

...

> > > Serge pointed out that we also will need an API to attach to an
> > > existing SELinux namespace, which I captured here:
> > > https://github.com/stephensmalley/selinuxns/issues/19
> > > This is handled for other Linux namespaces by opening a pseudo file
> > > under /proc/pid/ns and invoking setns(2), so not sure how we want to
> > > do it.
> >
> > One option would be to have a the LSM framework return a LSM namespace
> > "handle" for a given LSM using lsm_get_self_attr(2) and then do a
> > setns(2)-esque operation using lsm_set_self_attr(2) with that
> > "handle".  We would need to figure out what would constitute a
> > "handle" but let's just mark that as TBD for now with this approach (I
> > think better options are available).
>
> The use case which would be complicated (not blocked) by this, is
>
> * a runtime creates a process p1
>   * p1 unshares its lsm namespace
> * runtime forks a debug/admin process p2
>   * p2 wants to enter p1's namespace
>
> Of course the runtime could work around it by, before relinquishing
> control of p1 to a new executable, returning the lsm_get_self_attr()
> data to over a pipe.
>
> Note I don't think we should support setting another task's namespace,
> only getting its namespace ID.
>
> > Since we have an existing LSM namespace combination, with processes
> > running inside of it, it might be sufficient to simply support moving
> > into an existing LSM namespace set with setns(2) using only a pidfd
> > and a new CLONE_LSMNS flag (or similar, upstream might want this as
> > CLONE_NEWLSM).  This would simply set the LSM namespace set for the
> > setns(2) caller to match that of the target pidfd.  We still wouldn't
> > want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().
>
> A part of me is telling (another part of) me that being able to setns
> to a subset of the lsms could lead to privilege escapes through
> weird policy configurations for the various LSMs.  In which case,
> an all-or-nothing LSM setns might actually be preferable.

Sorry I probably wasn't as clear as I should have been, but my idea
with using the existing procfs/setns(2) approach with a single
CLONE_NEWLSM (name pending sufficient bikeshedding) was that the
process being setns()'d would simply end up in the exact copy of the
target process' LSM namespace configuration, it shouldn't be a new
set/subset/configuration ... and I would expect us to have controls
around that such that LSMs could enforce policy on a setns(2)
operation that involved their LSM.

--=20
paul-moore.com

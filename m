Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FF1FAA
	for <linux-security-module@vger.kernel.org>; Thu,  6 Jun 2024 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717704452; cv=none; b=Ayz48UTTKiXyFp8MvPCGinSVNn5N5fg2n9fb0Pr9bn+OJjRt7ULAXmWxDkldFw+JfvwnZEzdSw8TUEw+Z1mnQKwaKIirzwpVHJeU2kggWv9Dim2wTWhtcTp8sm57MAOkk7wI2Tc5yLGDmagRQOUuyKrl52bwuAdqhoX4s+ZuUQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717704452; c=relaxed/simple;
	bh=U2YOLGhWnJ3EKs6TvLDBihgog9qIC96h8Zr3CJUPGfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChGNV9OqcLK8BtyvpZWDlgvoEuPG9L9AJ0xSv9BnpzYoEx3PnUlevBsVyA4xEImYzB3WdG4i9iThuy2CtwUFSXT7zxuvSHrKECvN7KmO0KD//epCKH12Edk5d91QY2Qp497SG//zIVl/I/3PgviaPNeRRoNSM7ouZCSGdzxVhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MTtiAUF/; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MTtiAUF/"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-62a052f74c1so11591107b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 06 Jun 2024 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717704449; x=1718309249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDb/wZ+yDZPmhrmv2GpPqRfAAgDWr6bj0zJL5aDLHMY=;
        b=MTtiAUF/2b3MjG455GPO4YV9b8e1yyZfb2TRagg56AhCjowa/Nf3Cd0yIKM+V/bOAL
         nI8ZCka0x4aKhs3ABUXYn3Ld2ZrVGHLOubiZWs4bAEYVVTnIuqVbyaDG9jd29B53U7tc
         aHmDBkCfU5e/trHn3c8OMRPGx/+EM1/Rog9JRLD9E49SFaZsjbwlQ9xJE6j/FllAbHZI
         N2VQ/hWL6WO90ajb1Cbe7aDylVCrfq5+IgPBiqyCAPajxOAssMuIDyhj6jE2g0hGUDQy
         HBZCMZWEaDcVCbDIBAKdfveK8J3A6eaoPL0A0wtHesyAarqI8jy4EYfndM5ztZkAJR/4
         +xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717704449; x=1718309249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDb/wZ+yDZPmhrmv2GpPqRfAAgDWr6bj0zJL5aDLHMY=;
        b=ia3NvmS27hoSjPLBHsI/KkBogunb3gtP2o/16GIElD3F/0fKwdrg0nhxaaDhL70sd0
         u4WtBuujV6LZNHipZyBgCzFxtuJgjnk2PwqhuZkObDuRCWLO6LNtRlIKa3u9v+tAof4V
         aJtqSnAjTQuohyYRss/SaLNE1YyuYTW445xzuXLbQHds76xupZ8kXPbIk9Fb9Hp5e9Cb
         XAJOFvuyfdRq6MzXT6zt3mCrpJmGmxndNu47MPkS8BK95+Nx2cEuYvRQ46urS9xEdRwi
         jBsO0Bn3dvX/Im0LDZ0CcX0IuNA2Wrejhw5t2tubk6e2fwh+QWsF8pSqYYeBvCL3goA7
         Dl/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDGuMdjZaXEk6fOkzSn9kB18VYu+0adwXitaRVKg5KbpGGnWQA0zxOYHBFfpOmFGzkWEo0ybY/CdHq3iU8HBj2SGymuHf+MGS1NtG7iwsuHFN2nR4p
X-Gm-Message-State: AOJu0Yxv/Cr39hwqA8nIDHPfdMnoyexyp4m8/e3nfJ/SSZECzZK59gYY
	isrhO8yTFoLZqYevlipppcLNpHiBzs6XPFj3lMz+maV9+sQSmdh9VC2fz0GMpfLuBtJ0G5bmxf4
	dElWw4aOzgR+BGcFWtYsjqeVu/qQy/rJSozNK
X-Google-Smtp-Source: AGHT+IHUoi8Z31NKeV4XbsUe0RlTFo2m7VtyOJYW/ftgP4W6BKHiU74Jf3FuILhUE+62R40hTTPPhs7JLqRZLuHV5Wo=
X-Received: by 2002:a0d:d204:0:b0:62c:c641:f8eb with SMTP id
 00721157ae682-62cd45efda4mr6679627b3.24.1717704449460; Thu, 06 Jun 2024
 13:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516003524.143243-1-kpsingh@kernel.org> <202406060856.95CBD48@keescook>
 <CAHC9VhQ1NfdPZ1WVKTnsYmMt_0Lvb0XKMS3EqLKHQrX78yjohg@mail.gmail.com> <202406061049.F2FD4F8A@keescook>
In-Reply-To: <202406061049.F2FD4F8A@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 6 Jun 2024 16:07:18 -0400
Message-ID: <CAHC9VhQyy6u9O=KPE4vNR3FO+5ofGky8hw53jadxW2n0RyLd=g@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Reduce overhead of LSMs with static calls
To: Kees Cook <kees@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, casey@schaufler-ca.com, 
	andrii@kernel.org, daniel@iogearbox.net, renauld@google.com, 
	revest@chromium.org, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:07=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Thu, Jun 06, 2024 at 12:36:03PM -0400, Paul Moore wrote:
> > It's in the queue, I've been swamped lately as you'll likely notice I
> > haven't really had a chance to process patches yet during this cycle.
>
> I get that you're busy, and I understand that situation -- I get swamped
> too. The latency on LSM patch review has been very high lately, and I'm
> hoping there's some way we could help. I assume other folks could jump
> in and help with the queue[1], but I'm not sure if that would satisfy
> your requirements? Other subsystems have been switching more and more to
> a group maintainership system, etc. Are there other people you'd be
> comfortable sharing the load with? (Currently James and Serge are also
> listed as "M:" in MAINTAINERS, but I don't think the 3 of you have a
> shared git.kernel.org tree, for example...)

We already have a fairly distributed model with each LSM sending
directly to Linus; the issue we are seeing now is an odd combination
of multiple things: 1) $DAYJOB has had a sudden explosion of high
priority internal work which has siphoned away a good chunk of my time
2) we have seen an historically unusual amount of development at the
LSM layer itself (as opposed to the individual LSMs) 3) we had a long
holiday weekend here in the US and I decided to do what normal people
do and not spend all weekend arguing with people on the Internet.
Without going into details on #1, let's just say it is transient and
not something I expect to be a long term issue (if it does become a
long term issue I'll start looking for a new $DAYJOB).  I suspect
issue #2 is a byproduct of some of the efforts around reinvigorating
LSM development, clearing up some long standing warts, etc. and also
not something I expect to last for an extended period of time.  Issue
#3 is a direct result of ... well, far too many threads like this,
both from well and poorly intentioned authors.

As an aside, things like this typically work better if you have
another email setup so you can do the good-cop/bad-cop bit more
convincingly.

> And yes, there are a lot of patches up for review. I'm antsy about this
> series in particular because I'm worried inaction is going to create
> larger problems for the LSM as a whole. We've already had Linus drop
> in and tell us to do better; I'd really like to avoid having him make
> unilateral changes to the LSM, especially when we have a solution on
> deck that has been reviewed by many people.

You'll note that I'm one of those "many people" that has reviewed it
(and had my feedback ignored for several rounds).  I simply haven't
had the chance to review the latest revision.

In my opinion the LSM's largest issue has nothing to do with code, and
everything to do with the mentality that a hardware flaw is a LSM bug.
If that same mentality wants to ignore decades of work, in a construct
it insisted on, and break the user experience for billions of users
(and entire usage scenarios) in order to satisfy some misdirected
need, then I seriously doubt one patchset is going to solve anything.

> I will go back to being anxious/patient... ;)

"do better" ;)

--=20
paul-moore.com

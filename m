Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165C6155387
	for <linux-security-module@vger.kernel.org>; Tue,  9 Apr 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683384; cv=none; b=Qx+CP3KBNb/k0SfB1Tn92G5zevxxxGV4UcvJ2UJtNAuWaN3TkyjCIK+5NH2HdXyShrzwjFYLVoZVYQ3CtLTHO7uW46YKDSBM6hnObeCwLl6nrozod5sQsFbmUf8mdPvdFSlujywHTf3en2ljMAvjCJkEYpz/5yGAF3iVrCbs+4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683384; c=relaxed/simple;
	bh=D6NH/veypjX3visTbwV07IOKhioYsy7e8a4VJvDvwSc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dTDuA0chCXtvYWWW3hZMtEcpALj3Ia65kPAtbABo1PYttU7JrrOYu7XhLLhGeMuFkUTPljR1vsSYDTOKZwYIDOj7S2J+CUE5+v1km4smJJbGLG+Ov2sRr61O5yQddVXvsw7wTKTKu8oobhnXIIaUCfXNfsG+Kd8xXK1Cb4aaEuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cttmha/9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cttmha/9"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d700beb60bso95680981fa.1
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2024 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712683380; x=1713288180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gZQn/VsBmfAUTb4U4oHqfvHtdoT5PpXagKaDAaqxim0=;
        b=cttmha/9nZDYQ0upSC6KmEnFBAV56gSPLYJW6O8Aqy1h5LbBnCdmK23fmv701Zdfx6
         vGk9/UqwQaC5/gL7Ml0Nd9DRcA67GRJB4v9x0p3sT3/dZe6rxGnjEWi4pPPI5M/f4XKF
         coB8VH0Eh5HGvhPfuH8jfXiPpoBMvh5hduveA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712683380; x=1713288180;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZQn/VsBmfAUTb4U4oHqfvHtdoT5PpXagKaDAaqxim0=;
        b=l0bFutVA31ytkNeM8IlIWHLfrLMf2VzEXhpJT60L6eP7OxwBVNtO0Zb9yH9FKPu7tX
         wlYj9n2oknlS7TQUeFbVmm33YqkK6wObgISVsZxyzWlCEzYLBGwd3Plfj7Bv49P5PMDp
         agBTYo43MNiDR0KB4w2RrRRyiv19F/pRh/FfeAZFUYzk69d6rbOcXnTzpwkpD5GdKNiP
         GVXwqYU1MZkJUVcryav1psXEuF57B7Ut+wCkHSsm5nTEGEVKWebDHrVR6gCAZSSTisv4
         NjXWklEoHQX55UqT2GsOJSQnnJZnoVspkbiTEJF2T08B4SAi433B9FJarFaL7cNLN9NV
         RSFg==
X-Gm-Message-State: AOJu0YxFx1uo0M7lEmf5Xdf40nM3HhxhNLnEpmqoznueUwabx3N7rTB5
	3nWM0RQ7cfdUy7WmkOaBnbDWExhTE4Lt4p6Ks45xnhA4MFMOVEjk4EgPYkDUTlKA7hPR33xSM+7
	YG5jKAw==
X-Google-Smtp-Source: AGHT+IGuA8Sa58Sz4CTaXSz30kYGL3SnPcBlya3oQo1touClliDnMp3h9drxUkK89SrN1yi6JvFB+w==
X-Received: by 2002:a2e:9f4a:0:b0:2d6:e148:2463 with SMTP id v10-20020a2e9f4a000000b002d6e1482463mr421870ljk.24.1712683379951;
        Tue, 09 Apr 2024 10:22:59 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id d10-20020a2eb04a000000b002d875e679aasm1361186ljl.89.2024.04.09.10.22.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 10:22:59 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d485886545so103285101fa.2
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2024 10:22:59 -0700 (PDT)
X-Received: by 2002:a2e:9f4a:0:b0:2d6:e148:2463 with SMTP id
 v10-20020a2e9f4a000000b002d6e1482463mr421816ljk.24.1712683378788; Tue, 09 Apr
 2024 10:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Apr 2024 10:22:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+_xXpnHfUv=FwGWcce4XwqwKvtq7LcxK6WKmbf4eGGA@mail.gmail.com>
Message-ID: <CAHk-=wh+_xXpnHfUv=FwGWcce4XwqwKvtq7LcxK6WKmbf4eGGA@mail.gmail.com>
Subject: Hardcoded security module suggestion - stop the stacking insanity
To: Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>, 
	KP Singh <kpsingh@kernel.org>
Cc: LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

People, I know there's been LSM work on the whole "multiple layers of
security modules" for over a decade, and it's been a design decision
and a target, but I've complained before about the cost of the
abstraction, and we just had *another* hardware security issue with
speculated indirect branches go public.

So I say "suggestion" in the subject line, but  really think it needs
to be more than that: this whole "nested LSM" stuff as a design goal
just needs to be all rolled back, and the new design target is "one
LSM, enabled statically at build time, without the need for indirect
calls".

Because we're now in the situation where the security hooks are
actually a source of not just horrible performance issues, but also
actual insecurity. The first indirect branch in the kernel is now
often the security layer, and the latest

One current PoC literally uses security_task_prctl() as the attack vector.

Yes, I realize that the "security" in the LSM name is a bad joke, and
that to a first level approximation the LSM people don't actually care
about real security, and that the goal is just "policy".

But dammit, I think we need to put our foot down on this. The
complexity simply isn't worth it, and the flexibility is of
questionable actual worth.

So here's a challenge to the LSM people: work on walking back all the
silly nested security layers.

And yes, I'm aware of the random hacks for turning the indirect branch
into a series of static direct branches by

   https://lore.kernel.org/bpf/20240207124918.3498756-1-kpsingh@kernel.org/#t

but honestly, this series needs to be turned to 11.

Or rather, it needs to be turned *down* from the current maximum of 11
nested calls to be something sane. This whole "security layer allows
any policy at all" has been a fundamental design mistake. It
absolutely needs to stop, and this "you can nest arbitrarily" needs to
be walked back.

The whole "add cost and insecurity in order to give people random
policies" must go. When the LSM *becomes* the attack vector, we need
to just fix things.

                  Linus

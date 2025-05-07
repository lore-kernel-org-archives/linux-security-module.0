Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BF321146B
	for <linux-security-module@vger.kernel.org>; Wed,  7 May 2025 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648896; cv=none; b=uZmdFFPZvzmWort4CeXg+tPUEbRQsg5ri7M7d0YMCjswRGFiqzeky6k7qMPZQ/ChQBIq/tkSqlu19YFOD/L1mhJsLtnSCBjQjQbYTePIp7Uj9QD3SJ6mrEPM3GhlxIwT+4FkGAu02KsVTAjBL9WNcs4wztY97z75UEgdb/8JreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648896; c=relaxed/simple;
	bh=MEFn67+TrG4lHGRvstV/z3JApTqpXgAiCseDLrX0NsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrL4z3bY9W6jzEiZtwhzP2r6TeKE7RUqogYHbo5rBEHst7UT0ieVmsI90zJzY4VsrX2+PaSHlgplQyXdCWSvJY99RLjrZO6KHIyBlfnv0RPTYEjndpm+Yze7JNz6wzodUh5Znb5ZujUNpfSNE1/LzXMNGNiUt+XlYZR69BgA7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SJWczp4Z; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SJWczp4Z"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70842dc27easo3113597b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 07 May 2025 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746648894; x=1747253694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwc+QiQYG5xseLqfTusgvKwZXcDRffUFFezIyLWpxCo=;
        b=SJWczp4ZHhHOHtDwydTaxLZpQiEItrlkU9bp+NVYqFt7sCMY7mSKi7vXETVARGG8II
         d1bASvinJMsjdrwoWoZsuV1BjgpitwrDG/BjTqoZnG3F/I2wiDZK15SRvq3JYe5A9MKy
         b6wxKe5s2A+lQIdnsXISKOvF41d5/7DJNyP9uxAPN3TMIyJj/vXTBtJvfP3GXzE7ZuOB
         XfPEkfsLc3sb7GiZL7cNJc4zuzctAqODG/qyVqRI309BXfY0aOpi41QCcCI7xmP9bYL3
         8NfyQbFmkD+IWMaXb2QySb8xy5o+qVrR3ps5o0Klzl61PhiyMGAGG36gtdta9dAGm/AM
         iB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746648894; x=1747253694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwc+QiQYG5xseLqfTusgvKwZXcDRffUFFezIyLWpxCo=;
        b=PlrSOMs7esXTfj1031splT3TpXax/3Yeedvk+qhPTOlzq+1atBsIEwXuHbqS9UQ8Qm
         MuVi4S2alBz9teQ7JpjavK06fkZxNbklB5kIbiOGtzriw4Zr4fXcbjfiySdW66kWiX6f
         swmoVkrfOIh97rpioyvoCWJwVhv2nh3zRST7d9m/+8rzevM9W9DuTK/pOFnG9mUkSNSd
         L9/shb0RbBENPkAk7iIbyL0FvSDG8NZw924b/ISSkv7uHGSezdKrSyG2cG+d8FsY86YG
         JR6AJxhqC78jbIxj8YFN90bVjMqJWxxrOLCL3YpVzhcZiUVKeHqCex1C0ZZs7o+qsibD
         mTSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLEG6vpCZzQjW1BxvKE085rKmAmsYSJQ/twK4atzW5fgxT2xWsAxjTDEXvQzqlIvna8HZFJMtEEqTxpNh6T9fxOeEtdqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqyiK/fbVmZdBcX/YWZQL66G79whpDsuyEFtMtLj3fO0SHjyL
	Is4uHPDNYOnDZ2/GC0WjbwclzcN8sVUwxQ3C2b1hvaOFmm3PEjc1K1q2di7mnbqgUpngKD4HxOw
	4OpI7/RY+MkPznDE0tRtt21zfFW/vuAaOp1fb
X-Gm-Gg: ASbGnctAB9H/kdRdI0KM4lM2aCtFwHrI0IyzWrp3hKl9e9jcZxjw87sch4y4oRxu/O6
	Rf/7MUs57IU/umU8VIavWG/UhuEH8WgrJpgZOSv2cpMlR9xmWoa7XltZacQbu0VzBXWdgc6jdUM
	wZDGgxa65mY7jzUSQY1eq65A==
X-Google-Smtp-Source: AGHT+IHNq3St9Wehw31xbkZm//ex33Pf4Nu1DNbf+a5lCeUG5pOFVIi/TH4AwwiR23ZAcZouF9abxWJks9SGyLIeMHU=
X-Received: by 2002:a05:690c:6ac6:b0:70a:1084:8749 with SMTP id
 00721157ae682-70a1dad2f1cmr65005747b3.23.1746648893961; Wed, 07 May 2025
 13:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
 <295201ef-5299-4bf0-b0ee-6e1e2a74174b@I-love.SAKURA.ne.jp>
 <CAPhsuW4U5ULtOQ9ucucs3bs+jw+EbBzrCfhAuvOCO=1g5aWAHg@mail.gmail.com>
 <a6d26d37-3475-4f3f-829f-0883dbf8014d@I-love.SAKURA.ne.jp> <39ad6f58-db30-4c3c-a3d1-f0af516025e3@schaufler-ca.com>
In-Reply-To: <39ad6f58-db30-4c3c-a3d1-f0af516025e3@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 May 2025 16:14:43 -0400
X-Gm-Features: ATxdqUFiNEWuib0B5654agpL8CNEH-_eyAoI21MLzZe_hje-KgLve7-RSv_x9f4
Message-ID: <CAHC9VhRk1H6OVTF-peV-Rr9PK6aDmyUeM1G7bgE8e-pAvA=FSg@mail.gmail.com>
Subject: Re: [RFC] LSM deprecation / removal policies
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Song Liu <song@kernel.org>, 
	linux-security-module@vger.kernel.org, Fan Wu <wufan@linux.microsoft.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	John Johansen <john.johansen@canonical.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 12:24=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 5/7/2025 4:06 AM, Tetsuo Handa wrote:
> > On 2025/05/06 6:53, Song Liu wrote:
> >> On Sat, May 3, 2025 at 4:47=E2=80=AFAM Tetsuo Handa
> >> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>> On 2025/05/03 5:01, Paul Moore wrote:
> >>>> ## Removing LSM Hooks
> >>>>
> >>>> If a LSM hook is no longer used by any in-kernel LSMs, there is no o=
ngoing work
> >>>> in progress involving the hook, and no expectation of future work th=
at will use
> >>>> the hook, the LSM community may consider removal of the LSM hook.  T=
he decision
> >>>> to ultimately remove the LSM hook should balance ongoing maintenance=
 and
> >>>> performance concerns with the social challenges of reintroducing the=
 hook if
> >>>> it is needed at a later date.
> >>> What about BPF-based LSM users? Since BPF-based LSMs cannot be in-ker=
nel LSMs,
> >>> it will be difficult for users of BPF-based LSMs to respond (that som=
eone wants
> >>> some to-be-removed LSM hook) when removal of an LSM hook is proposed.
> >> If a LSM hook is important for an out-of-tree BPF LSM solution, the ow=
ner can
> >> add a BPF selftest for this specific hook. This does not guarantee the=
 hook will
> >> stay, but it can most likely detect unintentional removal of LSM hooks=
.
> >>
> > The problem is that the owner out-of-tree BPF LSM solution cannot join =
the
> > discussion about LSM hooks being modified/removed. That is, out-of-tree=
 BPF
> > LSMs will be forced to stay as unstable as out-of-tree non-BPF LSMs.
>
> The same issue applies to out-of-tree filesystems and device drivers.
> There's no problem that is new or unique to the LSM interface here.

Exactly.  Out-of-tree kernel code is out-of-tree code.  Tetsuo, we've
already had this discussion many times, and my opinion on this has not
changed since we last discussed this topic.

--=20
paul-moore.com

Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45CF31F98F
	for <linux-security-module@vger.kernel.org>; Thu,  6 Aug 2026 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022135; cv=pass; b=k/Wx2tMoznfAmCmgtbq/PgBBo8E72EcdbaDxJR8ZtKb5nFspoXWUE9j2dMbxhtkD4t+1AfUSo8Yg13pwlM2edVpZe47rQg+FIG9NGPN6o003F631yELAo+EoqKf1xC8s1CXx6oPHdjrtnIl9A/BP0WQX24ikTY4dA5Dg9erXHKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022135; c=relaxed/simple;
	bh=qcRoa7wxcm+4U6CerRrkNKXv+MRezWBibcEtDT467Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CU97Pkxgisol9gTpR/0iIqzQjlf/C+BcsKbDU2Zwl3ogn0m7Jlf8lSCCvlhr7fIr3gUT/w8OqFdSVsykqQ2PfemmKB8x0Ijjee9FwW5z+5HiNncTsW99G9PU92pmGo9tuhGE5d6aDYAxVPRMLVBYDYIRvUI6tBp2RJSNTYqem5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZThfR34; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZThfR34"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cab97c86bdso115865ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 06 Aug 2026 06:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786022131; cv=none;
        d=google.com; s=arc-20260327;
        b=NvT/1oaIiuYLdTld3jmlFdKj7+l37LroDGdxwYRP6PkwditFuykxQOObr/Affh5c5r
         3eVxEOWyKRhoYhFZseC+f/trD8q+O86ciTlfiS5eRhxJsxvYV3lFO+p4VxGZF367GTDH
         QTwRDBY3+mnapdXDpop5puHGwrLHOzk6Zzvh0aEo1B/xOJI7y0Vh8r+LBpbRfiTeyxQ8
         EQ9JakaCdAbL8UKc7D3I2hpO8BY04dNqSSaL/93AkeWvR5g6l0OheiDv4XBzG44hYttJ
         7R5a+HH1+XzLDGBI6B9YcBX7cU64vMjQ+fxVHJwmKl6olnjdkGKMDw9IXXopgd5+owQW
         CdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qcRoa7wxcm+4U6CerRrkNKXv+MRezWBibcEtDT467Jk=;
        fh=l/n6IDWcWhxDk8+r3X7vort4VmTZOm6SBdH2QzLT91U=;
        b=CmV4NmKL2+gxHBKStVAFtuKm027tKJey/SAQXeu/Nz5V6n5NeSS1a/YOSJ40h/CEbL
         /lbkRYGNhFyQ+mr6Ftjq8PMuK9cy6JnbIvB/PD+/MVn8WGqslj3H71gE7CBfol7kEKCi
         b1Wr8hFnul26PwUQb2VO1aPcZTSesToukQre/yMJa8STSiVqzkBgst1wYeyagtzHKxoW
         9l3wNNb4NDj8N93UPZw0MXtM0LRtGU1TABxeT58GGOzBFOHeKf7EJWNgpxbyfTLrLu0F
         dju3vh38hcuBwB+qrtYh/garvdQDZjmTWTwRsm+WtTNcIk/mQdYWNe1wTxeod9h4XHPb
         J01Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786022131; x=1786626931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qcRoa7wxcm+4U6CerRrkNKXv+MRezWBibcEtDT467Jk=;
        b=LZThfR346KE+M/6KLhEZ0HZ1PHOH/+RUDHuxV5JlzQKa6LyWP/alkEoR82ttZtXPNj
         PH0Z+BaamNde7BsuNvKhhRgh5WEICnjkk/9ks3qrI6BJI936IZnkQAH5sPkWd1/DAlG4
         QJSKYNTzVl3UFNgiQWKZ29CXeZrGpaGCaKs0NWyQytqf/tdUiM8WT/CHw1E95rrbY7ie
         kukNwiIlNmz5e5bqdScK5CDog0xqt87ASqKuF7/6qTVX5hEFvkmXcvNo3+1famsZt1iy
         l3ECUdd3DlC78ngaQ1otsX8MpfTn6adKnqgq3iAPph9BD0KEdsCDAbuFgDHV0EIRovU3
         Lusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786022131; x=1786626931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qcRoa7wxcm+4U6CerRrkNKXv+MRezWBibcEtDT467Jk=;
        b=UXAH8OJqa4QOpw4NZBfWeqJuZYWQNI1ZvCkZEGNsMreBKfB9i5gbvxxLzfmJOmbnSZ
         EKfnGcyHOOY9lDJ4f32euTmt8EsHMrPbSI4itpXyIf7Ayz3W3y5KhdfBezUY9V0oG1p8
         GY8c3XyWfz2iezo6YtRadwLqEvW1l0/kZ42r1w7twwP8Jh0VYEkEjlm1MmBJngRdA4AN
         YrlS0QN9PbwvYNfmjX8K+0VdryMuh2QHhvXSoKTqRHLdAzqzYN09AIStXdcUdBBgW6qZ
         ZJnfXEINaWX6xc/mjwdueDnIWb70whUPc/+EKVhc2KcwDIox2SEPrZtCrJPwUkjWAMVI
         1M2g==
X-Forwarded-Encrypted: i=1; AHgh+RptEMRwZ0lKV+q0j3cyIWzDmmgu4qIU/y2NJ/iZYvG6UcIAJTMcZfcXGaNwWnbVKQwIVYCWqq5LM/E1enOomOyHSg5RLUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7IPMSYw4JLYoIeSSwDBggk5UUBdjTp9iEyn0Tc3+Z0mNCdKmL
	bGy6aCqUC0HRr0vUlDouFoLL+WJ9qn656IonnfxrdcFFuNJs7QVk34Q1lZB0evoWaoKoLrMV/ah
	5QWmDQ98XGTPaXuUkoRay1AQzVI0wl+ost7gDpvBr
X-Gm-Gg: AR+sD13OFywk7WEkiNsJ6xHjjCah7lZ8Ly/h/RbGAo0lwqXYDDWh2Y2w0GznDU8I37z
	+meQlmXyzJuYIGNvRtRx+MzI05aXv9AfvugyqoSpy8iQC6BTADQvpx5mlwsGCm7fJmYSCxSzkAc
	3VWqIbOfZ/00mu19SElGMa8az6AKWL/cM+c49sPzOZMWs7P3qa5LTGj70fKwrCqcLPAIytvffZO
	g3XMeA45LycP4ahAVNBtpy7kt3wDbSD7R9lEEg0sUlH4dObgz2uWSANAqBKZxM+Y0v+wgvffGmf
	UU56W8JfD3H9Gjpv16QHHFd1WNsmtjwXRMjTJORNbLkw8QR1T4pX86v3dUNwMscAd8EOZKU5hE7
	Qgz5x9EZ79EtBXH1YM9Rd9tiGuyfGN8GqofIXGtkSsg==
X-Received: by 2002:a17:903:1a0d:b0:2c7:f0cc:dafa with SMTP id
 d9443c01a7336-2d0f55cf869mr6202385ad.5.1786022129037; Thu, 06 Aug 2026
 06:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com> <f13d94b4-2bd3-4737-b25f-bd5371189e62@canonical.com>
In-Reply-To: <f13d94b4-2bd3-4737-b25f-bd5371189e62@canonical.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 6 Aug 2026 15:14:52 +0200
X-Gm-Features: AUfX_mxjHccwhlBK-ZEwcRdt09EaFA_3UXxZXnpQMajQPSs8iZsc_fBXfIGTlTg
Message-ID: <CAG48ez3QfBZAQNG6K-rVmbkEtfJ9HtRs7MTrmNsKaoJLDVbnxg@mail.gmail.com>
Subject: Re: [PATCH] apparmor: fix cred UAF caused by begin_current_label_crit_section()
To: John Johansen <john.johansen@canonical.com>
Cc: John Johansen <john@apparmor.net>, Georgia Garcia <georgia.garcia@canonical.com>, 
	apparmor@lists.ubuntu.com, Paul Moore <paul@paul-moore.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, James Morris <jmorris@namei.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 2:02=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
> Q. What do you think about making the callback_head part of the apparmor
> security task blob. It would increase its size, but allow us to drop
> the alloc/free. Generally profile is generally something that is relative=
ly
> rare, but when it does happen, its is quite common to have all the profil=
es
> being updated, so a thunder herd type problem.

It would waste a little bit of memory, and I'm not convinced that the
thundering herd would be an issue since allocation would only happen
when a task is running, and the allocation would go away at the end of
the syscall...

But yeah, I think that would make things simpler and avoid touching
task_work infrastructure, so I'll rework this.

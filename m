Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9753362
	for <linux-security-module@vger.kernel.org>; Thu, 15 Feb 2024 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040338; cv=none; b=SrjMrbOb39wic1dyHUdjox4iWB2IdWblmdhArOf6+KfgX8mLrok7ozIVcmNNLmwlraY8gmjMHlkqrrGJhxqircwJPXHyO6s5NJqB/tUwZdn0nI8IP6Ldp4AlHXbaIl4jkod8LX+Kn1oyaXv8FiDVzBXiBKAI03NVm/JEqJCg0Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040338; c=relaxed/simple;
	bh=WLFO4rH2cvjFe/2ca1//lVsE5C9v5Z8KKpX4nigPgQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCVrw0NI4HN2rAFFSyITeE3X2HFUYZqjVxnZGCt3qbMiE8Eb8QlpimVcAay1STsiOGQEqIdfYD7mFZ1kqB5/V+BnEhMXpddwDgxU1uPM0CFx8F/NMd1rhz4bRU9qDugNo/87ClfobRWkbrDXwIFHhD0ox12PkhDQ20Zs67+aZ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N5IZYBn2; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N5IZYBn2"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc74435c428so1345018276.2
        for <linux-security-module@vger.kernel.org>; Thu, 15 Feb 2024 15:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708040336; x=1708645136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INjRrFs9Fl6hiUuT3m5y4+rWDShgxGtC1HUlvmpvUDI=;
        b=N5IZYBn2XjZ3LKKvHjak5L3Og8V/fxsH5Kkrep26raJFmMsftNIRRA3om5nNdwuiwn
         fdIZEG8EfNiJ70+a0PrIWOinOqwzXsMMWOJl+8I3LvMYQDhD48uoVFwIhk4LKyfmRYAe
         5UJsUT0/T4kGW90JVfFc+iYLfROSHgE4ovbD+h8PsQBLsaE17QRLG1a74rghR8vSYwQL
         yBD0BOM/lVIb823YUjOI/cH/DYkzLkOMzqHApjvHOW2+LBNSJ/1qmhNMeiBE+Y2ZHfHp
         1HauZtmpjfSrjwnCcVvWk5hf5YKG7vupncKXU1t3omp4LYpX03cclG7PUS1VRHCllW32
         10Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708040336; x=1708645136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INjRrFs9Fl6hiUuT3m5y4+rWDShgxGtC1HUlvmpvUDI=;
        b=eLSnkT49W2WGWYw4BQOqhjrqMIfLiel7qWfcb6IAZy3EOm/naEAnWPPbKeVKy/5h1Z
         tACspB0wmFoVJ1RYaB3bxrtpcj7oz00CQXt8jnQvWoS7/u+8o7e2n8yyLo7fss9TnjgC
         TXjXJs1qB0T0GO/OAWGnjf6iv+8AenxFbMe8XB91ctOPzPbA5HuXwEXk6Z/EmMNPbUww
         P5iQtqWyyrWs1cwa+jNVvoAifHf8DuYe9ynY0Pjuh4U0lO+yE1mxYyXrRt0IuxZmL3xI
         r1Gx5mKnzDxuUw9HlGE2jfr1XTlxCT7yuLKgcEdWPtc6zvG8hKUE20yTQtjbaWBedVwr
         A+cg==
X-Forwarded-Encrypted: i=1; AJvYcCVmrk+l/EpIv0PKVuSxTfoYXB1kUD2MF8usLN0bYHvDUbIMr2IVipTA7dROTr/x4VS4VI19FxtkdL9Zh38l4dUHflhydoZHYYksofzBooGvGmcvKwVw
X-Gm-Message-State: AOJu0Yyr2FgeIjuQ2sTUQTxgCrBOssqddF8YsLXLKWDx5j5rosDONeC+
	QWxpVHtw2G7xjPov39W+XQQkuheiULg3sm5JqE2t9BB4gWh4iQpLqTS+da7OJqOqPShr+mDpwLN
	/sPHodC6Sw1eSMjdvhElfxwejM5kscMjXbaZmexsV7pNvi3oO+w==
X-Google-Smtp-Source: AGHT+IETk9gvfUExiQgN0fr1e1fXmGSl8z8EV4KfC3eYL7d6kNlTL/dCY8gx3LzUU/PG1fqXSQuVUdlv3aLMGuQ+kVk=
X-Received: by 2002:a25:9d8e:0:b0:dc7:45c6:f8bc with SMTP id
 v14-20020a259d8e000000b00dc745c6f8bcmr3181986ybp.4.1708040335941; Thu, 15 Feb
 2024 15:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ad9dddfe-0fa1-40f6-9f8c-f2c01c7a0211@I-love.SAKURA.ne.jp>
 <fa719d6f-1960-491e-89c2-ed2c14d184fc@I-love.SAKURA.ne.jp>
 <2fa0a73a-1d03-4937-8599-e4560297af3f@schaufler-ca.com> <f15e4a73-02e1-4758-a8e6-0edd27224c0a@I-love.SAKURA.ne.jp>
 <757dc423-f914-44b7-98bb-fde5cd42d33b@schaufler-ca.com> <b240a8ad-240a-4bc5-9414-62bd417f0b92@schaufler-ca.com>
 <CAHC9VhRdqjWa0Zhw==U=kLNiSeYHDWnQyP8Yb4JNtTA7ki1gqw@mail.gmail.com>
 <8d093ada-995f-4291-9c31-35d9a62525b7@I-love.SAKURA.ne.jp> <6e00373a-a028-4575-b2cf-d4da366c2b6f@schaufler-ca.com>
In-Reply-To: <6e00373a-a028-4575-b2cf-d4da366c2b6f@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Feb 2024 18:38:45 -0500
Message-ID: <CAHC9VhT730AxsUv=1=dEn22ABeHJPZ1JA-xwZv6DN54+DiiKQg@mail.gmail.com>
Subject: Re: smack: Possible NULL pointer deref in cred_free hook.
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 7:13=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 2/14/2024 2:15 PM, Tetsuo Handa wrote:
> > On 2024/02/15 3:55, Paul Moore wrote:
> >>> Ah, but it turns out that the only LSM that can fail in _cred_prepare=
()
> >>> is Smack. Even if smack_cred_prepare() fails it will have called
> >>> init_task_smack(), so there isn't *currently* a problem. Should anoth=
er
> >>> LSM have the possibility of failing in whatever_cred_prepare() this
> >>> could be an issue.
> >> Let's make sure we fix this, even if it isn't a problem with the
> >> current code, it is very possible it could become a problem at some
> >> point in the future and I don't want to see us get surprised by this
> >> then.
> >>
> > Anyone can built-in an out-of-tree LSM where whatever_cred_prepare() fa=
ils.
> > An in-tree code that fails if an out-of-tree code (possibly BPF based L=
SM)
> > is added should be considered as a problem with the current code.
>
> Agreed. By the way, this isn't just a Smack problem.

I've tried to make this clear on previous issues, but let me say it
again: I don't care what individual LSMs are affected, a bug is a bug
and we need to fix it.

> You get what looks
> like the same failure on an SELinux system if security_prepare_creds() fa=
ils
> using the suggested "fault injection". It appears that any failure in
> security_prepare_creds() has the potential to be fatal.

Perhaps I didn't look at the original problem closely enough, but I
believe this should only be an issue with LSMs that register a
cred_free hook that assumes a valid LSM specific credential
initialization.  While SELinux registers a cred_prepare hook, it does
not register a cred_free hook.  Or am I missing something?

Looking quickly I suspect this affects Smack and AppArmor.  While
Landlock registers a cred_free hook, it looks like it should properly
handle being called without a cred_prepare hook first being executed.
Of course Micka=C3=ABl is the one who should confirm this.

--=20
paul-moore.com

Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967944C86
	for <linux-security-module@vger.kernel.org>; Mon, 16 Sep 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483584; cv=none; b=BkfXoUIq5MGTPFFh3nTBnUOw+iWEiGB9oSD43DX09dPIM2aU0mtReX5v0oNXaGnWHL1bWLrxk8UwHdkvCw1cfWJkxTQAYC6GU4WDayB2yaUKHrUSTRWN5PHYGLHKpi6K235tKjfd4/iBvz9n4TFBcANSjLzLkanmoKMYE63uzP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483584; c=relaxed/simple;
	bh=mV9du04VKGKk1nPwWEovpDjsnvZZeLOYjvudwBnQ87c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPjpuWpbLxbsf2qwWLL2WnOZ442L7zjAr2FU+ZXSnDWpIkGQSm+68wZR4oMTIlbuyZMQ+Yf404ynpj6qK+LF/hppElrUh9yuIfDtn2HYvo4bcDF1ULKaiL6odB9GQkOhDTlIdgW/qkwkeiz4UKWH9pc6jTLb+wFOtX8BL6/4lTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZF/CBSDL; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZF/CBSDL"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1a7d43a226so2449501276.3
        for <linux-security-module@vger.kernel.org>; Mon, 16 Sep 2024 03:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726483582; x=1727088382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOot1WAmO0n8LqJvNiku2kLrm8KQvY7N+dDNwBSEg74=;
        b=ZF/CBSDLw30DFYzkwvHzm2IktN8jmz0b7vNZq0DWTGZAVFfcfFcP/wIXl0Tvj+ujnp
         GbkaPj0CXymhl6axTdGscnGJQph5P/lxaOYhn7ebYVqaA4nOxHUUJNuBdtKqhxhHoPpk
         VZRjlhm5ad7OJYYX9V4jmqM5qpBr7Q7XDdqcBMJqy/PXxY8qKwnG+J8T/mqJLYqIS+YL
         GxSWeR9JIBw9hDX8iHDe1/htoiETqUVtz9xY2QAJC3sQEnTqWmIKOk/9uSXcQAPz/04i
         XR70Zq/8CDOmKPO9mdnZk57XNSW/d5Tf/Ju0ftptKSA/ti6NofGU+jdV8vfZB9pqzlkh
         0MQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726483582; x=1727088382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOot1WAmO0n8LqJvNiku2kLrm8KQvY7N+dDNwBSEg74=;
        b=d8xxNBCpAaxGQsQwIJdYSwtKXDt6jn/pp+V85xftqmqkY/8ZRZEUvK8Vt40TauCDtb
         VjEAAmBO8SAl6VZhR6+g0sZ5/6Pz2MVAaNp4zfObTTNyHTzP+jRfm94nytAsQd2yxDBy
         gBsSN1whT2feC5WFGH0jaA3E7F31tI/rJ5mrWb9WAcLLAefVrfsL60F/ipoP05od8HA/
         n38qhD+9I3APlrYfkFI6nzWGVBpJoSCttbyWb6piTuCuOSBVRlHAkA9nY9fOELJkHO7S
         hNq8N1axchw/UNbxccrxjz/WpGYuzOHkZ8qKQ5ttXaQrfpVAR5jX0rTLyx2j9HipA6Ez
         q/EA==
X-Forwarded-Encrypted: i=1; AJvYcCX/5gNyOc12YB5CZEFV6sggjTJQkysnkD1gM0qivy1918vazPZxYA+HapQ+kvBu3Xcsol9OJjUxH+82TVyKU7MA6o9EIss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDLcd1SOBGE8fO1koSMUhfc7A91boiTtxe0rZBffNH4CAkzNrv
	u4d3EBX6IDgOGJYM/eM+7HsE7o38b9H69ucx9slcdOTAWv0+r3cxtzzJJsoKc2CNHpfN8wPIT7b
	rq4zQIwp4eOGu9XD6w7efuUIOGAcdnTp3M4A4
X-Google-Smtp-Source: AGHT+IFPT7p70pyzFPnGYf9oumwIpGAwqpVNEQ2qCQe0d4QnaPMyQB86xSQEpMCg12204Y4OQ+FOje+z2iOX3Dd9gQg=
X-Received: by 2002:a05:6902:1883:b0:e1a:8e31:e451 with SMTP id
 3f1490d57ef6-e1daff6229bmr8957471276.10.1726483581486; Mon, 16 Sep 2024
 03:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com>
 <20240805-remove-cred-transfer-v2-1-a2aa1d45e6b8@google.com>
 <2494949.1723751188@warthog.procyon.org.uk> <CAG48ez2LBmS91fQVLYRYEaBHssj22NyUjB0HVtkDHUXDvDZ6EA@mail.gmail.com>
 <CAHC9VhSPcy-xZ=X_CF8PRsAFMSeP8-VppxKr3Sz3EqMWTEs-Cw@mail.gmail.com>
In-Reply-To: <CAHC9VhSPcy-xZ=X_CF8PRsAFMSeP8-VppxKr3Sz3EqMWTEs-Cw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Sep 2024 06:46:10 -0400
Message-ID: <CAHC9VhS5ar0aU8Q6Ky133o=zYMHYRf=wxzTpxP+dtA=qunhcmw@mail.gmail.com>
Subject: Re: Can KEYCTL_SESSION_TO_PARENT be dropped entirely? -- was Re:
 [PATCH v2 1/2] KEYS: use synchronous task work for changing parent credentials
To: Jann Horn <jannh@google.com>, David Howells <dhowells@redhat.com>
Cc: Jeffrey Altman <jaltman@auristor.com>, openafs-devel@openafs.org, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	John Johansen <john.johansen@canonical.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	apparmor@lists.ubuntu.com, keyrings@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Aug 15, 2024 at 4:00=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> > On Thu, Aug 15, 2024 at 9:46=E2=80=AFPM David Howells <dhowells@redhat.=
com> wrote:
> > > Jann Horn <jannh@google.com> wrote:
> > >
> > > > Rewrite keyctl_session_to_parent() to run task work on the parent
> > > > synchronously, so that any errors that happen in the task work can =
be
> > > > plumbed back into the syscall return value in the child.
> > >
> > > The main thing I worry about is if there's a way to deadlock the chil=
d and the
> > > parent against each other.  vfork() for example.
> >
> > Yes - I think it would work fine for scenarios like using
> > KEYCTL_SESSION_TO_PARENT from a helper binary against the shell that
> > launched the helper (which I think is the intended usecase?), but
> > there could theoretically be constellations where it would cause an
> > (interruptible) hang if the parent is stuck in
> > uninterruptible/killable sleep.
> >
> > I think vfork() is rather special in that it does a killable wait for
> > the child to exit or execute; and based on my understanding of the
> > intended usecase of KEYCTL_SESSION_TO_PARENT, I think normally
> > KEYCTL_SESSION_TO_PARENT would only be used by a child that has gone
> > through execve?
>
> Where did we land on all of this?  Unless I missed a thread somewhere,
> it looks like the discussion trailed off without any resolution on if
> we are okay with a potentially (interruptible) deadlock?

As a potential tweak to this, what if we gave up on the idea of
returning the error code so we could avoid the signal deadlock issue?
I suppose there could be an issue if the parent was
expecting/depending on keyring change from the child, but honestly, if
the parent is relying on the kernel keyring and spawning a child
process without restring the KEYCTL_SESSION_TO_PARENT then the parent
really should be doing some sanity checks on the keyring after the
child returns anyway.

I'm conflicted on the best way to solve this problem, but I think we
need to fix this somehow as I believe the current behavior is broken
...

--=20
paul-moore.com

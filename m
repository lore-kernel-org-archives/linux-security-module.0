Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662FF1386A1
	for <linux-security-module@vger.kernel.org>; Tue, 12 Mar 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266984; cv=none; b=GYrcGD3uqihe3n5GbM/C847IH/sSy/xhW+/brnukEVOBAKJdJld1lQRRe0nZF4K1I49Oq64K41tq5j+L/gXqBb1Yo0pru4CqlYEzGBgRaYbCd8x1QIYn8t4F930RvOxQSAFDlIY4Bp+iVG0kVCmqP1wQU0ORojTCWX0y2TITUNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266984; c=relaxed/simple;
	bh=N6hbKJDOHWvCISGJQnkD0ws17JAmMnk10DjL7GMCPbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwDKxrlh5fq3N7iE2PzG8bjnnx52pgQuD+902qa0jmW5LoxdUjYM7xi3V2wGJkwN1Ai7kyQM1JCRFA6lQHRgAP/hrCaCyLVNp8u1e+CGihxmkHB3lScwGS40qeIvCnZeHgOl53UK7l8C6YQKXwNPxHd+MfUI3sYz/uVcrnIy3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MO5r/bpc; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MO5r/bpc"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609f1f97864so58099917b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 12 Mar 2024 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710266981; x=1710871781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQo4IO+Obsv8ytjIy9Irob+LVNNIUZt7hIxL51DJ3S4=;
        b=MO5r/bpcbRlLiTsp9jHWfjaVz2xFdsbjA3WrrFORsFaQ30hrndnLV0mAUzAs1NXtB4
         74JpTG96HcpxDOSDljAgEsZLY0BNd9Ltn8E/pFES4HGXU4VNFCFBngQxqoDPNd6q62qE
         govHWYfzwT2mAJ8eMTsXrVAcw/wvCLscgQ0o9GTsRdVGEsF9djHkdNjxvKtbfvmLPuI+
         384kgTxt8H6bYC43XfkgtIjgeS1NW+NwKej5842rQLRKDz29ECaKG6xDekPP/xjFDw9t
         q6G/4/8ZOaksFas7uPvCNPgz/U55+v3XFqLUGLQorjBn/X60qhnSyciYh/L/FQZjOj8j
         iFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710266981; x=1710871781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQo4IO+Obsv8ytjIy9Irob+LVNNIUZt7hIxL51DJ3S4=;
        b=AUzNjAgcGeeXCrZVWctHluT6d89vFGaoKuWiJw2+iyzVZJhTuOVmOUpYcK4GHmEift
         zPJaC5HGJ+L/f+/+/JuCECAPbwRpw7Kzx8bGHu6r6IVeTpcsPiJDTWfJgb/XTKo3RLsB
         YMhJrXpP+rtVTsa3TNEglpF20ite7r+NEZPuEkrl2B4FZPuWSvNAhH+pGqnmzD1sYqrX
         ATYR0QE7GIBFa9cLMhSRurtuI7+/FGXHcZnAmSleN5Dkmp84gebq8qXh3E5rwkWn1wfu
         EGJFPVpZjQKbs7wRVZoHMAmi3CpBm18NMgEjSKWxR/0AeOjSMnTB2eeu3d2HcxFcJtnl
         IiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7jEsUWquI7BX9DdacfTIPxpD7lUDxn+lY/ZjmY9NrjHo6F7cAFk0qFufnqLcSJkdKXjikqlDS/IldeqcojKD9R0lsNXwx9kmZoApL+RKxCM/3XHN6
X-Gm-Message-State: AOJu0YxD9mgD7wk2KLNw/ajuXyiJsrzDYYZeJZZ1r9lqFCD9WSRYUpR+
	uEtXa/d7NdfaeXZRM5mpnXavzC7hol73SVOqTHH0E0I2w0iY+dPl/spIin7FQARSWN0mT/aYrO7
	UoNpVwisCtlpvv6FaulPGwXnEt4AlTZkUFpbT
X-Google-Smtp-Source: AGHT+IH6XUpoIR4I7KGxCGGcQZ+fLoTY6rtMqBf0P2fTFq0mAdMh6HRJQ6lDe0ysu+Y5GV5ITdX5ZTJY7Yana+iWyGc=
X-Received: by 2002:a25:bf8d:0:b0:dc6:19ea:9204 with SMTP id
 l13-20020a25bf8d000000b00dc619ea9204mr212004ybk.61.1710266981294; Tue, 12 Mar
 2024 11:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912205658.3432-1-casey@schaufler-ca.com> <20230912205658.3432-6-casey@schaufler-ca.com>
 <20240312101630.GA903@altlinux.org> <CAHC9VhRgjNT2YnVgCqMJnyr227qUjmfrWZ+LBnu_DGxnJZgeKw@mail.gmail.com>
 <f122b3a9-1208-4c0b-9289-73eb070a8337@schaufler-ca.com> <CAHC9VhRfwjsGiHXBRcWA6S9+H_kj0vMdQC0gyHr3ZnX-u7KzRQ@mail.gmail.com>
 <f4f5d993-552b-483a-9a3e-1be99ea48757@schaufler-ca.com>
In-Reply-To: <f4f5d993-552b-483a-9a3e-1be99ea48757@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Mar 2024 14:09:30 -0400
Message-ID: <CAHC9VhSewmfbuqyTMgC7MRcw8EcQN0Srdsxmy5r01cCN8U5pAw@mail.gmail.com>
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, linux-security-module@vger.kernel.org, jmorris@namei.org, 
	serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 1:44=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 3/12/2024 10:06 AM, Paul Moore wrote:
> > On Tue, Mar 12, 2024 at 11:27=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 3/12/2024 6:25 AM, Paul Moore wrote:
> >>> On Tue, Mar 12, 2024 at 6:16=E2=80=AFAM Dmitry V. Levin <ldv@strace.i=
o> wrote:
> >>>> On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
> >>>> [...]
> >>>>> --- a/security/lsm_syscalls.c
> >>>>> +++ b/security/lsm_syscalls.c
> >>>>> @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int,=
 attr, struct lsm_ctx __user *,
> >>>>>  {
> >>>>>       return security_getselfattr(attr, ctx, size, flags);
> >>>>>  }
> >>>>> +
> >>>>> +/**
> >>>>> + * sys_lsm_list_modules - Return a list of the active security mod=
ules
> >>>>> + * @ids: the LSM module ids
> >>>>> + * @size: pointer to size of @ids, updated on return
> >>>>> + * @flags: reserved for future use, must be zero
> >>>>> + *
> >>>>> + * Returns a list of the active LSM ids. On success this function
> >>>>> + * returns the number of @ids array elements. This value may be ze=
ro
> >>>>> + * if there are no LSMs active. If @size is insufficient to contai=
n
> >>>>> + * the return data -E2BIG is returned and @size is set to the mini=
mum
> >>>>> + * required size. In all other cases a negative value indicating t=
he
> >>>>> + * error is returned.
> >>>>> + */
> >>>>> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user=
 *, size,
> >>>>> +             u32, flags)
> >>>> I'm sorry but the size of userspace size_t is different from the ker=
nel one
> >>>> on 32-bit compat architectures.
> >>> D'oh, yes, thanks for pointing that out.  It would have been nice to
> >>> have caught that before v6.8 was released, but I guess it's better
> >>> than later.
> >>>
> >>>> Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modules=
, ..)
> >>>> now.  Other two added lsm syscalls also have this issue.
> >>> Considering that Linux v6.8, and by extension these syscalls, are onl=
y
> >>> a few days old, I think I'd rather see us just modify the syscalls an=
d
> >>> avoid the compat baggage.  I'm going to be shocked if anyone has
> >>> shifted to using the new syscalls yet, and even if they have (!!),
> >>> moving from a "size_t" type to a "u64" should be mostly transparent
> >>> for the majority of native 64-bit systems.  Those running the absolut=
e
> >>> latest kernels on 32-bit systems with custom or bleeding edge
> >>> userspace *may* see a slight hiccup, but I think that user count is i=
n
> >>> the single digits, if not zero.
> >>>
> >>> Let's fix this quickly with /size_t/u64/ in v6.8.1 and avoid the
> >>> compat shim if we can.
> >>>
> >>> Casey, do you have time to put together a patch for this (you should
> >>> fix the call chains below the syscalls too)?  If not, please let me
> >>> know and I'll get a patch out ASAP.
> >> Grumble. Yes, I'll get right on it.
> > Great, thanks Casey.
>
> Look like lsm_get_self_attr() needs the same change. lsm_set_self_attr()
> doesn't, need it, but I'm tempted to change it as well for consistency.
> Thoughts?

I'd suggest changing both.

--=20
paul-moore.com

Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48635C68A
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533299; cv=pass; b=Uqz67mIqxmrtfzvWgAQk4i10JSibpLzwUcdh0WkYbyMu5eR/VFMGMmBy3FhrTBr3fRVU0BTwCGZ92NdYeNuUaO+/juo/qetWU1M7b+7oDPSfXR4DVOM2qsdODQNspz4J8uzTP77aEz3N1mm+HElrI06swKoNMGGRzj1Ma7p4LdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533299; c=relaxed/simple;
	bh=F4F1eQivkcTHEyVnKH9/YEnj3GfxU1bVW4td4NV93ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJV+o3v0gPPYoQK3RD2dhCOj08G4iwYqeh7Qp+gEeU4snhzfJETtHkIZnXOzhxvrIK63OHvkvYF6bXCbo6f/xGyy8/K1ZhwotXkv6xeWDG0P9Z2GcvLiOyIcrZtwO/b13EHlZoaFy5hpUdBLA+9GYExqrXgUPYukoteNEv9LCXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EOXyQXAj; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EOXyQXAj"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso1651737b3a.1
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 14:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785533297; cv=none;
        d=google.com; s=arc-20260327;
        b=hCAQs6YjyAi39GHWZn4CFAI7HTkV9Pke/Xsm4RELp6SniBifQ1lOjtLUFmTuAAaBKb
         hCanbX9DVUDqKQjnrP36gUTmiOxLeyP7RWvZtH08+6C3Cq+xplOLVKLL4pZ7XVTm1UPI
         XFzjgo6f1SNTBUeF3x9tfLtnUEHuz+Po4/ySnz56rhUZGw0JbImN2ccPqOBna04CQPft
         ZKUmT/UA3aVkWzVFAJwTRu4ByyAbA+MLuwwA87FvV9rH/71mTLD0X7GEhVevdMAhS8Ak
         6h3fBa+tKNzdEehzWHFlIwqdcjU5Nj8OEqFPoOlPHKDM7GtR0FqnEcJowP/tMnw+EABn
         ukBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wq25m4uPekD2ZOm9+5jKXB7P9bW7fvfxXLKPmMhnQp4=;
        fh=GSVbNy25RmIAqImq1dL3F6JqugeboTsowxGnam0dh14=;
        b=rQoVynnl3Ow870bP7NGZognWRCjnCeuHXIYBbFGXpZ+LNo0VjTu5AkeobMaVUFpeFH
         ej9GGXbJ99HhW4pK6nCEgEVh62RHHHlM0BCRDSjjn++LYfqhv9fZevUoMLeQOqegStkf
         HmWqiegZYSZSV4yiAQyMLq9jsDaIdTyaHWuyttNlDHpXIJYzPAz31rFGQbIMvqQ3Y1dW
         C/Zg5iqok2NpLmQ2a+h8JUvy9lCyiwlMRWIZjA43gCN6B7KOv+cP3f+vJGt9Zvy8kYGg
         gvrQg40WADyPnIbBFU1KGtzSAAeYsl+EI/l21koLH0XYaTsvLGCaBeRMgV+/p02TJi35
         Ma5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785533297; x=1786138097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wq25m4uPekD2ZOm9+5jKXB7P9bW7fvfxXLKPmMhnQp4=;
        b=EOXyQXAjXYiXTg7a2h2FOgpYSIZfFtPnRTJU7rOTwUgHNhvSzGQ7JD4siSHxKnV+Gr
         /8h2foihrL3GlqjP6xLeNOxBknhTYVcmPsd1MY5YUzJaIktLaGz1rAmub6+z6LJNymMj
         zVunaNtyosr6LzxDx47rTlwKnwFwIFTu7BZjxaNJhkLUzxAchS5DNej5JXX1wGlhmri+
         BqvQPKcqCQf/SNzvp5nkeZvcXlp07lJICgxVpPvDtOMTYV1Rse2xjsQHq6MOo9WJFf9a
         EP1GuM4Jw4UdNa+VZkcBjuksXxSR74cKj4cCYmKDjwW7vk8VZ8m6LwUyteSjYLsvNT17
         RM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785533297; x=1786138097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wq25m4uPekD2ZOm9+5jKXB7P9bW7fvfxXLKPmMhnQp4=;
        b=aFthLk1M/bIKI1MlntseRHXs9vFQ9ge3eJTWWyQvY2MAnsHIPFYvwm0msz/VbSn1HU
         btCUrNyU7z1MqS2DiwG1KkR67S5dMp0cHYj/TNKNXmp3P36pqLENr5eTwIEDnm2YBvF8
         bbXLxjkek92AY2NY77izdw43JUEt5+V8QkQHbXZu3KMBDg4OJOMDgsLdVknjyq6lsJfK
         IZq9febRkRsM1phx2L5c2OrbnKjHMEA+z8pH6kxyfyG9BzzlDOKrKuZf6iudSJFZIoXy
         +mFT+Ij8eZtIMHEdDhdASkAij+lFGBV8juZ1q7yeEYFltWzq/lu21dUYPrrXfqCeWFfO
         Whbw==
X-Forwarded-Encrypted: i=1; AHgh+RoozVwjUIx9FCUFMY3vfjm/j1C/NaOPNq1ueq9TzxN+wWbbCVBA4hJttV1marqVxj2dAmZ2G+of3mN6/B1b9Q7os2tNJ78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lsNQmQxgr88rwiRBxoK/apzBuj3ynibAVXrz8z78k6qFcSfe
	5TpgBbEkx13oqFU98c+is7oul3bToeIGuzsq0NqE38UlcuhpYRq+MxK41+ENPXkRMFKLSYyFqtV
	P/urnce3u/av18HU3k/NRrdGakYHydpKXPqyRUJAk
X-Gm-Gg: AR+sD11Q9RKYeJPlfOYSXIdD8jgmGKMfQO/2OUYVKSQfrqsmqUsUzchaVzdahQG44Uu
	Ztmqum3E7wl7PNsElkJqpS5zd/wBOmlGb/OQbWrzAIcI8f8C5+MKJYq0jPSnw7aNrq1QSqys3Bs
	Hqo7CBuJK2LXNzlAjTWsbvqOEsiYqPIoEWsnzXg8VxcTBcL23X+1v/DghbZA6Ww4FVfvHPLvijU
	kujXeUhfZS01fG+473/JXh4MMzTAg8TD6HcdNbPwFLEekvvAeSSWKG6zB8YUxcFMkED5NBodmxX
	FgSCM+B7NaMMPX0rsnFYqdckh8UHvbgiJoG4sDMMQ9M4
X-Received: by 2002:a05:6a00:2d25:b0:848:469b:3d19 with SMTP id
 d2e1a72fcca58-84ee4881d3emr990432b3a.29.1785533297083; Fri, 31 Jul 2026
 14:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com> <am0JT2UJQgl0ogwy@zenbox>
In-Reply-To: <am0JT2UJQgl0ogwy@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 17:28:05 -0400
X-Gm-Features: AUfX_mxWu6YlU6MDspjIcmKDeXRNWi9hfBWLIXfPQTq-XlrvMUKPDsGtSdKCHvg
Message-ID: <CAHC9VhS-nPeu3Y-cBAmnNyO5Ju8irKm4W9A-Nxu04cRXJrairQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock rulesets
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 5:15=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
> On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> > On Thu, Jul 30, 2026 at 10:21=E2=80=AFPM Justin Suess <utilityemal77@gm=
ail.com> wrote:
> > >
> > > Howdy,
> > >
> > > This series lets BPF programs apply an existing, userspace-created
> > > Landlock ruleset to a program during exec.  The goal is unchanged fro=
m
> > > the RFC [1]: BPF does not create, inspect, or mutate Landlock policy,
> > > it only decides whether a ruleset that was already created and
> > > validated through Landlock's existing userspace API should be applied=
,
> > > based on runtime exec context.
> > >
> > > Motivation
> > > ---
> > > Deploying Landlock today requires the sandboxed program's
> > > cooperation.  A process can only restrict itself, so applying a
> > > policy system-wide means wrapping every launch path with a helper
> > > that calls landlock_restrict_self(2) before exec, and anything
> > > spawned outside those wrappers runs unconfined.  Supervising exec
> > > from userspace instead (ptrace, seccomp user notifications) is racy
> > > and slow.  Meanwhile, the tools that do enforce system-wide policy
> > > with BPF LSM programs today (container security agents such as
> > > KubeArmor and Tetragon) end up reimplementing path-based access
> > > control in BPF, fraught with horrors of path reconstruction, bind
> > > mounts, rename races, and worse, which is exactly the problem Landloc=
k
> > > already solves in the kernel, with maintained and versioned semantics=
.
> > >
> > > This series composes BPF and Landlock along their natural grain.  The
> > > intended deployment: a supervisor creates one ruleset per policy
> > > class through the existing syscalls, a syscall BPF program parks
> > > them in map kptr fields, and an LSM BPF program picks which (if
> > > any) to apply to an execution based on its runtime context.  The
> > > policy semantics stay Landlock's; BPF contributes only the
> > > programmable decision of when and to whom.  Deciding inside the
> > > exec path closes the race a userspace supervisor cannot: the
> > > policy is in place before the first instruction of the new program
> > > runs.
> >
> > Discretionary models are fun, and useful in certain situations, but
> > they do have their limitations ;)  To be fair, mandatory models have
> > their limitations too :)
> >
>
> This series does kind of blur the lines between DAC and MAC
> a little... interesting thought.
>
> > I've only just barely skimmed some of the patches in this patchset,
> > and I didn't have a chance to fully read your reply in the previous
> > revision yet, so I wanted to get you a quick response here ... as
> > incomplete as it may be.
> >
> > As you may, or may not have seen, there is currently an ongoing debate
> > regarding the location of LSM kfuncs that will impact this patchset.
> > Sadly, we don't appear to be approaching an agreement on this issue
> > which introduces some additional risk to this patchset.  We'll have to
> > see how that ends up, but I just wanted you to be aware of the
> > situation.
> >
>
> I'll hold off on further iterations until that's resolved.
>
> Moving these kfuncs anywhere fortunately amounts to a trivial
> cut/paste on end anyway.
>
> > I need to look closer at both the LSM hooks and the BPF kfuncs before
> > I can really definitively comment on them.  It looks like there has
> > been some progress towards an LSM agnostic interface, but I'm
> > concerned more work might be needed.  However, as I said earlier, a
> > closer examination is needed and perhaps that will reveal something
> > different.
> >
> > It's also worth mentioning that this functionality looks an awful lot
> > like a call to lsm_set_self_attr(LSM_ATTR_EXEC,
> > <lsm_ctx:LSM_ID_LANDLOCK>, size, 0) with a lsm_ctx::ctx set to a
> > policy fd.  Once again, perhaps a closer inspection will reveal that
> > it is nothing like that, but it kept popping into my head while
> > reading things so I wanted to mention it, especially as it a lot of
> > the framework infrastructure already exists.
>
> They were the direct inspiration for the hooks (and set/getprocattr).
>
> Main difference being the object in the hook is a trusted kernel pointer
> rather than a lsm_ctx blob or fd. We can't use an fd here since the
> sandboxed task and supervisor don't share an fd table.
>
> I'll wait for your full review, no rush.

I appreciate your patience, thanks.

--=20
paul-moore.com

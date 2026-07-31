Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E63624B3
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785532524; cv=none; b=I49rGTPokYHMTCb/jYMUQM4XrfIo99TZA6w8bUzHnGdFoVmqHwwBuZDwvYaSX5qMI9kxphgtd1Yhdf6j9BAuVw54f7ZGgGGH/O1tAt17+Dgl69uAaCYMwuyIOSJSm+uWwtWwMXfZyK0iMwJof1sFdau8rddFQCpbFj5QSJ3FIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785532524; c=relaxed/simple;
	bh=tfway8HYZ5WCOmU94tVvG9Ex6N9dUtJeCUSDptLPmwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agExVqbssHMTBHw05jhk0Ue30CfbtpAeKZQbFJ+TNbtiq9sTXjPIxJFcel2nhgcrHNB3lh6iSDYxN6ip6j1UcnF1TPTmJDoI9Tw76SDLKYrhq2UYqvyJctOFK5v2arzNFmt83QD6HDWOSYhKuM0CZEW8yasxC0mzsZhGFZ6Jyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgX2YXeT; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgX2YXeT"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6682259cae6so1441701d50.3
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 14:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785532522; x=1786137322; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=elDw9oiQreFLpRRXW9sbDNq6XC8CGaBRYJ4NHBLdM0s=;
        b=LgX2YXeTw5Np7xRY2LuuBLMaG5+btS6Wj/e3o7RsGxtcO/C/84tSS+Cra2yF7JWRev
         fQJd4jarbWUo+tETAl67lWTWYo2eRJ+sMN1j5TVGRw3/luGgYJthTk8hw/xt5+6aYw4N
         XrlI9zZYiQFM1KEO0Jsv0vWl3k//9ITqkDUDdIRaeLMIcHz9qB8UxwRwBe+bfWva3PBt
         at5G/mfTVlwnPw89f3lCe1Kl259Ob1atBWsQSZ3Q78aQjyNrRdd6mUTGUN4GMwB5eFkk
         Bt0mg12Yly/5fo/gZbMqJpIbphCELiZ9oje/dATKfjFCUWyMK1sm+/QgTgDtqJnqJWrx
         HorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785532522; x=1786137322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=elDw9oiQreFLpRRXW9sbDNq6XC8CGaBRYJ4NHBLdM0s=;
        b=sNVHjCcLw5CdkRnL5kIeJ7A92boqIRM++4pJzBUpX7pJ2ZvbjFZzgXVO1V9faghAcn
         sWgiW6+j078IYW7L2Ii/DzKBQzzZk6eHpA/HMLmTvP1E/SvmO3T7puvWngX59bEhl64j
         cKT4NUvexGL7R4L508aivn7WPmr5G2pxkjFU4rI8ERmq1mYKsiAHlKxS4U82aHKfxIOc
         rcubzWpeVlj1xoYdlSEt8A0iKhHsj9FkZGKmqxYmoPvzUn+Zjr1AL58iA4b1NLk4ixW8
         OC76W4eXa8cqdenwawiNY2/QsOb15NsWHJyp1SdJQz57Ka2TitowtLhor4xaoKcxYOnn
         4UTw==
X-Forwarded-Encrypted: i=1; AHgh+RovLk0O9SKIaacdFv6QAp27JTu1H7c0OgHdw+n5IOVtY6vfeh6xO9OFBBiXZaxRcxUUYXttZgbMBE1mw2O/63shFB0jNOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkSDbyfOLFRtqhYG+dlwZjH6eOTgz0MNFjExd7Z2a8RFDXUPaQ
	z3V78BuirIcsC9RSlzgzPYffclpMWyKV15Y2uZJx7GuQaUQcKb/vGFdy
X-Gm-Gg: AR+sD12JXIk15X2znUEp1neOcf2eY6/kQ01A8mzc4BiFJKju24clDtKINeYdTXWvu35
	ZciD2BF3V1WkF+34WvHiPXxgoLf9Yg6dXWErzNhUhTbDtujH07QT2w1specfQqbJazm5FYuT/lj
	HVV/TOT8MyVuE6Xe1G2wFM95PnfmTMSKxaHE42EO1BnkUNlLB5CKtu1j1rY8WX9MvWDUubvL4Rk
	MJQkEQg0K2O+SuFe/RyYrDUXOohszCSRQ5a7JEZ6gb5Aq73EdI2xEj1fZ+zVOM6yuev1VoYR4LY
	Oucw6Jc8vyWnfQ68zYsSNuPsjfQqj2XKVsjEuuJG6+zeO7eHTB0COEEdsiqTR2Amx0M9udAM0vt
	oJKTZa7CkeHifhwRtrE4Qx2seRxq9ZXmuurzG6wrsLJxK+qNRSmEzYJnkWbcUvaYvAfvRLs+YOP
	mYWPBjlkIIJjvxCai+wPbXeEd/6U16aE7zMJjewN5wBKme6hWCHqIq6H6j+/zvwl9rq4oGvO+BD
	Ln8W/nByt21yZDTYHZlIfMgACJSCSc6SNW6fMHJAHMw
X-Received: by 2002:a05:690c:604:b0:7fd:4ef9:e5a4 with SMTP id 00721157ae682-81fd4bd6688mr20512397b3.29.1785532521535;
        Fri, 31 Jul 2026 14:15:21 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d52:64e9:32ac:b832])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd124e8bsm15083237b3.41.2026.07.31.14.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 14:15:21 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:15:20 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock
 rulesets
Message-ID: <am0JT2UJQgl0ogwy@zenbox>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>

On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> On Thu, Jul 30, 2026 at 10:21 PM Justin Suess <utilityemal77@gmail.com> wrote:
> >
> > Howdy,
> >
> > This series lets BPF programs apply an existing, userspace-created
> > Landlock ruleset to a program during exec.  The goal is unchanged from
> > the RFC [1]: BPF does not create, inspect, or mutate Landlock policy,
> > it only decides whether a ruleset that was already created and
> > validated through Landlock's existing userspace API should be applied,
> > based on runtime exec context.
> >
> > Motivation
> > ---
> > Deploying Landlock today requires the sandboxed program's
> > cooperation.  A process can only restrict itself, so applying a
> > policy system-wide means wrapping every launch path with a helper
> > that calls landlock_restrict_self(2) before exec, and anything
> > spawned outside those wrappers runs unconfined.  Supervising exec
> > from userspace instead (ptrace, seccomp user notifications) is racy
> > and slow.  Meanwhile, the tools that do enforce system-wide policy
> > with BPF LSM programs today (container security agents such as
> > KubeArmor and Tetragon) end up reimplementing path-based access
> > control in BPF, fraught with horrors of path reconstruction, bind
> > mounts, rename races, and worse, which is exactly the problem Landlock
> > already solves in the kernel, with maintained and versioned semantics.
> >
> > This series composes BPF and Landlock along their natural grain.  The
> > intended deployment: a supervisor creates one ruleset per policy
> > class through the existing syscalls, a syscall BPF program parks
> > them in map kptr fields, and an LSM BPF program picks which (if
> > any) to apply to an execution based on its runtime context.  The
> > policy semantics stay Landlock's; BPF contributes only the
> > programmable decision of when and to whom.  Deciding inside the
> > exec path closes the race a userspace supervisor cannot: the
> > policy is in place before the first instruction of the new program
> > runs.
> 
> Discretionary models are fun, and useful in certain situations, but
> they do have their limitations ;)  To be fair, mandatory models have
> their limitations too :)
> 

This series does kind of blur the lines between DAC and MAC
a little... interesting thought.

> I've only just barely skimmed some of the patches in this patchset,
> and I didn't have a chance to fully read your reply in the previous
> revision yet, so I wanted to get you a quick response here ... as
> incomplete as it may be.
> 
> As you may, or may not have seen, there is currently an ongoing debate
> regarding the location of LSM kfuncs that will impact this patchset.
> Sadly, we don't appear to be approaching an agreement on this issue
> which introduces some additional risk to this patchset.  We'll have to
> see how that ends up, but I just wanted you to be aware of the
> situation.
>

I'll hold off on further iterations until that's resolved.

Moving these kfuncs anywhere fortunately amounts to a trivial
cut/paste on end anyway.

> I need to look closer at both the LSM hooks and the BPF kfuncs before
> I can really definitively comment on them.  It looks like there has
> been some progress towards an LSM agnostic interface, but I'm
> concerned more work might be needed.  However, as I said earlier, a
> closer examination is needed and perhaps that will reveal something
> different.
> 
> It's also worth mentioning that this functionality looks an awful lot
> like a call to lsm_set_self_attr(LSM_ATTR_EXEC,
> <lsm_ctx:LSM_ID_LANDLOCK>, size, 0) with a lsm_ctx::ctx set to a
> policy fd.  Once again, perhaps a closer inspection will reveal that
> it is nothing like that, but it kept popping into my head while
> reading things so I wanted to mention it, especially as it a lot of
> the framework infrastructure already exists.

They were the direct inspiration for the hooks (and set/getprocattr).

Main difference being the object in the hook is a trusted kernel pointer
rather than a lsm_ctx blob or fd. We can't use an fd here since the
sandboxed task and supervisor don't share an fd table.

I'll wait for your full review, no rush.

Justin
> 
> -- 
> paul-moore.com

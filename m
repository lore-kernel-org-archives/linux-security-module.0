Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com [209.85.222.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328F253340
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771620314; cv=pass; b=BEFWYrKAZZ1DrNh/stReMeuYVcK1PjZkKpYt5ybQUkzS9oDtE5bBidcuXy/st+XOGC9j2HRb2RDosAT44ZoFAlErP9KTXtmWDuIwiZAAQtqxTghDoLZvOocn2mkngPR+8cD5gXY+FeONTBbHyEjVM1UAjefShr1/fORX+rtmXDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771620314; c=relaxed/simple;
	bh=twNtpoPLV92wLbRpHd1Jq94+3VlE5YGGP3StH2uelFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMP1Dt6FsxVcQ8PmNiOTBu1sK14913rhqMPGhCN446P7C8mtM5Q6p+kkVpFBG+MXP+XckrL6ZONIJhDd30NXQoNzpPbmsb9QgTTc1InbHLJ6iVMsHnscpoHRDQvJ3IyTdKne4/7qD4j8aOUdjbJ1iTRuiF6ly/XiVQm4WBYkkRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2WaxQ8P; arc=pass smtp.client-ip=209.85.222.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2WaxQ8P"
Received: by mail-ua1-f66.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so765377241.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 12:45:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771620312; cv=none;
        d=google.com; s=arc-20240605;
        b=JAvlEJ4TUIJixkXSR8FKzUlWUvmB7gLQNYePMnHLmzLD0PDQJ35r9l7PmMm2MNB7Cg
         O2q6AX1b/4UPTG0+2rc6k1DH1VFcEq2n+csYWaImlDzmL7+aKbayPB1N0Scig3YMyJwB
         u9RARPyyuKkQLoUDNMDpgccn6fOHI1xAT2ZiHHWPWO3Tpbu+DGdsJluABfttwA2FFNBY
         zTQVeZRrxnkvwCIwDmtFXgVApfuwO7hFvp+Dx3ZgJKarBiwbdXeOK9Apgo3GPROyQS5h
         /XwBmuy2sfqhtouCLnqg1NWGK07jX5yU4FOE2dTLjBPxbW8T9IaU5z5X7aLIoOmIn+6r
         ykkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=twNtpoPLV92wLbRpHd1Jq94+3VlE5YGGP3StH2uelFg=;
        fh=IcBzYGDRA9/lL/hSiUO3J8+rpr0uLpHbI788jZPUufs=;
        b=SFWEtg09KXaBzi4+NJVZb4yerAHgXGs/AyNX0zery6tE2QWBg9BeGKkBaXDVhGmx4Z
         V4bXQ/P/DhJtxenXUjT29e3+1kUQ85KqaSMp7nNdCnUWswFE4ESbBbeRrCmLW/L1DUex
         xavHKiP8zSMA2MqV12J8sZH1O4h/FnciGn/3qphKBtMM3jndPXHeXoixrjLVSQbuMZyM
         oueu1J9Hq4ZAa7r6SUuOCM085oC7wZ8k4Ei5/vcQWIQzsxDfiUn63gbL5HtBrm+0sPxr
         gLiOdD9RI0C8hMgdoZgtJwEGB8LSAwA+WVOAeYQTFmIqtBkgPXY61UiDDUtVL+JsbwAp
         K2/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771620312; x=1772225112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twNtpoPLV92wLbRpHd1Jq94+3VlE5YGGP3StH2uelFg=;
        b=c2WaxQ8P4khqGusVN5wYxJZUaqdbb6iWAUT4GxA0PEMLqYPqsaJBdpZO3xwiK6OZyg
         IPYnLt1+l+B41ezCs+nv9poBwkKG1j7mA9MyOFh2HJCbWwaK+0UIRxZC91Zd2s4xGk7+
         V6BNxUKZboRQYwtZpWy543r14/eEG9RK+UN1ocqHrmF3FcpSlSWnZ3GazFuPp26WL/m1
         wOkMM9AHtIwA1bptRa6fBN0r3qENqYUFj5X6tLWaoTKpg33MQUyMlcjUbf1U/BLq2+ph
         K94P0tKb1waoxg5f0MFWGjVT/d53ih0Y70yQfbUhaz4b6lsxwaMzlWOTrphWmAtjnedH
         KyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771620312; x=1772225112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=twNtpoPLV92wLbRpHd1Jq94+3VlE5YGGP3StH2uelFg=;
        b=L9vCy04yRBRmV7XV7a3ntKqhInUHxyfwuICDC05dVHWt5IKYxYdqD39mD/221vFD+R
         WyWqidw+vqHdXvFuX/gowzmE3GjSxM7lfxhVsb/+CMZtYVVbrnPZgGvOWHgt3Sev1qVG
         70XjanCm2gNqq+S209bfAlWBKReKiSI3Uh4iujX3zRIbbBJVnercaaZsnRmtbJQOr5Ws
         z3KKovLWd87P9wsFfZCnCAqmYQCTr9x9YIjESYW97bd6xw63gD2o7yVNvdd+CcdN2E/i
         LY87So3+rP8aj6xJJmqdts2EmYtKY7JgMEKystqvgtjdNjSvh2FPiIqDEE5V1HacfVDe
         kdjA==
X-Forwarded-Encrypted: i=1; AJvYcCVYnzK1LeIzBLCV3wEsDo0cHZf0YNxfylXoawMevMv2wJsl6Au4EbH/KXGFOdA737CUmqfNfnLgbXLkpisDUuCWZnC/c9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPP58pf65zd54B1kx+3IBYYjrjDzMXRHNjbu2QPXHlr6AxjEPN
	Ito4z87rCZJP/q0j85V+9XZDNOa8t/D49pva2hDRPwVKyKUrSPAVCNpqETUGbV8Iil18aUCvzdN
	xRc4YfAT6/4G7O4i6OFbLs1YYl9aA8Vs=
X-Gm-Gg: AZuq6aIX0iuSnEEywdXQn6vGClrvlTfH1pqR2Apzud5+TLVqU9wVlvgVISgRmm9fyVJ
	T2ghee1KmRBE1pA2JsLLwnLFsdCFgW0BlpdfF4RhH1b6fhGtQpYpXbdhmToEZUvOqvxvGK8yA/z
	LU7pRI1zrG5g57/RzlakKP0ss9Vo/JmGlBE73q9WCOd0IRwTzoyrFayxZ4Zb7XqebC8Tj1WBMH7
	+JTEvXBCqubZY9IdC8uz8k+P1oF80wWAr36DwlSrQzYHMXZdqelV5BcIinIDXKOKsOSO6dKsJhx
	+quYnS6NPWOgTeg58w==
X-Received: by 2002:a05:6102:b16:b0:5f5:514f:4e59 with SMTP id
 ada2fe7eead31-5feb30a72d0mr465363137.27.1771620312379; Fri, 20 Feb 2026
 12:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206180248.12418-1-danieldurning.work@gmail.com>
 <20260209-spanplatten-zerrt-73851db30f18@brauner> <CAKrb_fEXR0uQnX5iK-ACH=amKMQ8qBSPGXmJb=1PgvEq8qsDEQ@mail.gmail.com>
 <20260217-abgedankt-eilte-2386c98b3ef7@brauner>
In-Reply-To: <20260217-abgedankt-eilte-2386c98b3ef7@brauner>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Fri, 20 Feb 2026 15:45:00 -0500
X-Gm-Features: AaiRm52hM82IevVg7Vmo62C2F5Yss-2733FdxbX2tudFZkW41cTm1-3xKTkFeQI
Message-ID: <CAKrb_fFEvf5VzY_-zcc800wjVGOFbiGrpzC7S6Ghy9qhYJrZ1w@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/pidfs: Add permission check to pidfd_info()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	paul@paul-moore.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 7:01=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Feb 11, 2026 at 02:43:21PM -0500, Daniel Durning wrote:
> > On Mon, Feb 9, 2026 at 9:01=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Fri, Feb 06, 2026 at 06:02:48PM +0000, danieldurning.work@gmail.co=
m wrote:
> > > > From: Daniel Durning <danieldurning.work@gmail.com>
> > > >
> > > > Added a permission check to pidfd_info(). Originally, process info
> > > > could be retrieved with a pidfd even if proc was mounted with hidep=
id
> > > > enabled, allowing pidfds to be used to bypass those protections. We
> > > > now call ptrace_may_access() to perform some DAC checking as well
> > > > as call the appropriate LSM hook.
> > > >
> > > > The downside to this approach is that there are now more restrictio=
ns
> > > > on accessing this info from a pidfd than when just using proc (with=
out
> > > > hidepid). I am open to suggestions if anyone can think of a better =
way
> > > > to handle this.
> > >
> > > This isn't really workable since this would regress userspace quite a
> > > bit. I think we need a different approach. I've given it some thought
> > > and everything's kinda ugly but this might work.
> > >
> > > In struct pid_namespace record whether anyone ever mounted a procfs
> > > with hidepid turned on for this pidns. In pidfd_info() we check wheth=
er
> > > hidepid was ever turned on. If it wasn't we're done and can just retu=
rn
> > > the info. This will be the common case. If hidepid was ever turned on
> > > use kern_path("/proc") to lookup procfs. If not found check
> > > ptrace_may_access() to decide whether to return the info or not. If
> > > /proc is found check it's hidepid settings and make a decision based =
on
> > > that.
> > >
> > > You can probably reorder this to call ptrace_may_access() first and t=
hen
> > > do the procfs lookup dance. Thoughts?
> >
> > Thanks for the feedback. I think your solution makes sense.
> >
> > Unfortunately, it seems like systemd mounts procfs with hidepid enabled=
 on
> > boot for services with the ProtectProc option enabled. This means that
> > procfs will always have been mounted with hidepid in the init pid names=
pace.
> > Do you think it would be viable to record whether or not procfs was mou=
nted
> > with hidepid enabled in the mount namespace instead?
>
> I guess we can see what it looks like.

Having looked into this some more I am not sure if the mount
namespace is viable either since a single proc instance could be in
multiple mount namespaces. In addition the mount namespace
does not seem to be easily accessible in the function where proc
mount options are applied. I also considered adding an option
similar to hidepid to pidfs, but since pidfs is not userspace-mounted
I do not think that is possible without some significant changes.

Doing a proc lookup with kern_path() does work, but it does not seem
practical in terms of performance unless we had some other way to
skip it in the common case.

Curious if anyone else has any ideas or suggestions on how this
could be implemented.

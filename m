Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E6F332EA7
	for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551189; cv=pass; b=chbAI5P5USz3T4kWQ7QKKLKaKIF91xjuCtl/B8fxYbM85NRGx77fvqSgHjbYNeyBBmbgdbvA64gp/Zswy+8eEYYOSxzgQ1nYmTcYhltrm5guaV9/FO9onFFBoxUr/z595L7Lc/Q45n931U5cUaMl3xLJ2/s5hxj01LG6nqxnd68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551189; c=relaxed/simple;
	bh=iEljPudkY64iSiYqxMk96XjA0vobla4RgCkNZJQ8tPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fl0ps+SH/AoXGGgeTEtimAFMgn9jePAz60uwjdED9pW9iUv+340dSIeOUz/VYS282+/sTJNGvF2a6c3wRMgvP7EUMCAgKfQ3eucF3hYWAuJ5zTe/HWD0i4/uLcfo46gzfOF07Y5JDRm3+hgUNqTS//HLIU4NEnxWp67J0xpF9qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JMTs7/Kd; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JMTs7/Kd"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so183186a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 13:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769551187; cv=none;
        d=google.com; s=arc-20240605;
        b=Sf4+gxNG5R+jhPKhfESQnwuMSNScDMSmN2E1DVq/ANj7LCrgBV1ootUW/8IUUAPCRn
         26kyRnN9SL8HGpqEJgT8Jz6p61L/nAgAZ6d5CAuLk0kPggsbwropVZ0MQV93xD7WO5de
         waLVT09NtbyWJD/rOlPV1gFRdZJr6DQlrKo7cOxS+bv/aWcdqSjM7bp6xKlFzAz231qA
         61culbWBalahf/2k3HdEx5Lu5cUIs/HbDdLDi0kGlq6lwCqEV/DxEyyVMaSkvdce8Ahe
         /BUK+YlBADxGnJElDrOSIe4QkbJZbo+upjfgXarx6opgnHjXWgfE6ZVD94u489GHMtDD
         6ZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ten/eO1oep9IThmAZR2NG/u5boCnCD9ELrI44ZU2xuc=;
        fh=HRBiv8PyHUXoY4wfCC7H6ko1R3Xo4I1AiGeL67EuEbM=;
        b=csWSbu83pOn9nEzrUe4T2srgDehy+q//h7pLZ0c4XPzpv9RxB0eGSvELgS2tvuwvUp
         eRIqn8kqwgFazGYXnypLWrtG0twKdqDIlZynVPIFpR+9wdkncFqa0zrJhumuAPeTliFh
         ZLSuIcI+uuRvnMR2b98d+nnQrCjTS07c7qgkgPVHk9RdE7ra8WpoLr6jU2/zW72WgImX
         1nuGhWYT6rNktMFVbv4Yv+wNqZKQeG6u+VECvcWXXA1TqzD4JZNYm1FgMUOg9s9X1jUM
         bNWlkrZuTnqTy0FOTgsIu2D+ChmPZxNw++ED/ZwHRvRdPD/dOqAtCLIfR7Pkh/1uicvr
         PWjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769551187; x=1770155987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ten/eO1oep9IThmAZR2NG/u5boCnCD9ELrI44ZU2xuc=;
        b=JMTs7/KdKcxdrGHC9AxwSrl7pGUSUk9jwHQczSqgkGpi/CHtAKQxw4q5cLAwykh/fG
         skVxRkLh677s9HCG1jzpiaLsQc5WcGD2+l8JC1inqX68k3eVANi6eqXRYDWNkZoJKfzq
         KcsQqyxJ16yDe5Gmkl7NKPQahYfiTZ4lnS+8/t4bd1tBseOmH8KfgE9sYNy6mcUw0786
         w9TP3+ayqGx+MNkNLyDBcq7yU+4YwjZcxs8np53XFiWYGdyy6tKvV+RcfLITdfstnW1j
         X8X1vjbPpaPdotfnbJwVqUpqudgH0prRNnFonLR845mTgTvD9b0H7wTIhmNoZwMoWuSD
         NfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769551187; x=1770155987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ten/eO1oep9IThmAZR2NG/u5boCnCD9ELrI44ZU2xuc=;
        b=MsiL1Kd597gOiHP9dUC1cI1J0Vf2W5lIlNR990iwEyJpluIQ8aengLOPrATTmwrhtd
         eY6+9Ji/5o/HV7E0dr0gO1HxcBSzuhd0Rbp3tUcFstEqjOfClYILvs/6+/HWHfLXGSWt
         4HyKCDO2omA29z9rBJ1wCJFiibMd89MQ7zpRouLjvS8fZJbjGg4EIicbrq6T1k2Q8cqW
         rroQmqFuSOdSHjFokHNAcpji3qIU4JrRJgS7lYyNi/TkYBvtBupyDBn6OrR0OSqtV0e5
         U5I+PUqP0CPaxRigxNClxtfGDFStWaiY5TjS+WaaA7l3v0r71O8K7TBM40rBj3yBQQ+4
         MmMA==
X-Forwarded-Encrypted: i=1; AJvYcCV4gQPAjGO97U+wGgrBE0E7HY+ibbYhLMsBedU2KTkb9oVwTw/SXLUfGRYwfYvAgK893W3Fs1Ov8y/7FXC8/tvF8VinDD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAjG8DydBwLIM76AGJMbLZNI2uqI6KlbSX0I1nIdgAmL7KxCbS
	u/VvYxrRXuZEGFkRLEQNqzXCzirg+McPVq0j3ydB9kAFI72o2rult0TkZVyqpTlBj6iF5Vn+/1Y
	k6oUqcMIZXRoiMI4Fa7vQTHoVl/GZrVWGrbySfKZpYAmd2JgJS0kf9OGz
X-Gm-Gg: AZuq6aLEazkSNZWPISeGd7dZ7mrWqupiVblVwXd452+iz6lnNZCCS3WcVO7BlpZhCyy
	HEz6rVibHs7lUeRfb4EdF3X25YZsdkPr0YdGhytWjdpeAq2DUPOz6yK22x1Z2LXaHSQVF4e8elu
	ejrYsDgUq+yxz7WYbTExnaH/Mv0/8MGE3Zyhnpc97oohBP4bUSHPjmtO9oFx9NcXdpl2l6wiTrF
	c0ScMo7g9Sckvxc8AH9DJhDoZSyOnX10XvaYdHeFRetwxrOHEQngBXmSeW87Bk99/pWvKzrJcAq
	ydHA4g==
X-Received: by 2002:a17:90b:3c4f:b0:34a:a16d:77c3 with SMTP id
 98e67ed59e1d1-353ffa2e81bmr2407723a91.2.1769551187312; Tue, 27 Jan 2026
 13:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com> <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
In-Reply-To: <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Jan 2026 16:59:35 -0500
X-Gm-Features: AZwV_QjHjF_BvN3T07RPQg-eLzyv77ege_ZVuB2hfBf8S1skY3WEi6mlROEWEsI
Message-ID: <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: SELinux <selinux@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 10:51=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/01/27 7:33, Paul Moore wrote:
> > On Fri, Jan 23, 2026 at 5:13=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> Since xfrm_dev_{state,policy}_flush() are called from only NETDEV_DOWN=
 and
> >> NETDEV_UNREGISTER events, making xfrm_dev_{state,policy}_flush() no-op=
 by
> >> returning an error value from xfrm_dev_{state,policy}_flush_secctx_che=
ck()
> >> is pointless. Especially, if xfrm_dev_{state,policy}_flush_secctx_chec=
k()
> >> returned an error value upon NETDEV_UNREGISTER event, the system will =
hung
> >> up with
> >>
> >>   unregister_netdevice: waiting for $dev to become free. Usage count =
=3D $count
> >>
> >> message because the reference to $dev acquired by
> >> xfrm_dev_{state,policy}_add() cannot be released.
> >>
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> ---
> >>  net/xfrm/xfrm_policy.c | 35 -----------------------------------
> >>  net/xfrm/xfrm_state.c  | 33 ---------------------------------
> >>  2 files changed, 68 deletions(-)
> >
> > I didn't make it very far into reviewing this patch, because it looks
> > like xfrm_dev_state_flush() is called by the bonding driver's
> > notification handler, and I don't see that reflected in this patch?
>
> xfrm_dev_{state,policy}_flush() are called from only ...

My apologies, I was looking at the patch too quickly and shortened
xfrm_dev_state_flush_secctx_check() into xfrm_dev_state_flush() when
looking at the callers.

> LSM hook for checking whether to allow deleting a file in tmpfs which is =
still mounted
> makes sense, LSM hook for checking whether to allow starting unmount of t=
mpfs makes sense,
> but LSM hook for checking whether to allow releasing memory in tmpfs whil=
e unmount operation
> is already in progress causes nothing but a resource leak / denial-of-ser=
vice kernel bug.
>
> What xfrm_dev_{state,policy}_flush_secctx_check() are causing is somethin=
g like
> "LSM policy is refusing release of memory used by a file in tmpfs which i=
s already under
> unmount operation".
> xfrm_dev_{state,policy}_flush_secctx_check() are too late to make LSM pol=
icy decision.
> A must-not-fail operation has already started before LSM hooks are called=
.

It sounds like we either need to confirm that
security_xfrm_{policy,state}_delete() is already present in all code
paths that result in SPD/SAD deletions (in a place that can safely
fail and return an error), or we need to place
xfrm_dev_{policy,state}_flush_secctx_check() in a location that can
safely fail.  The patch doesn't relocate
xfrm_dev_{policy,state}_flush_secctx_check() and I don't really see
any mention about security_xfrm_{policy,state}_delete() in the patch
or description; have you verified that the LSM xfrm hooks are still
being called to authorize the removals?

--=20
paul-moore.com

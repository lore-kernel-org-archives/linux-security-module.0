Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E828725A
	for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767136632; cv=none; b=TRcYkqwhwhAdy5mFJk4NgC2yGHPPNW9wNkq0AjazaYV9d5qpzL3bgc/BDw1VQO9q1as73x6h89arRXPHOYmWO0VfoBJHKwj8dYflsVc4vudklnfhfHFbhPnWOz6HqgfWKsF+XeF9iKCvk0X4iFgLL/5EVW6u+Ph7jh59SS/pZdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767136632; c=relaxed/simple;
	bh=2nGEj+D74IRFtWK3kNF8CraFfTOpJ0i/5JjK8HGURV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnLPNf2MXn1PyrkXTKiNrxNOOHlrbV6U8gFLXZrpwA43sSkyDbBYvq1eVCXDF6cgXU8AtICTM35ESaL2TKaKTAnaiyoVvaWQG5bzpKj28WT8GH4MKi9AWNnjw+GIc2neIT3KKwwIEM7RBK2DkdD0bguvqg2GAdAc+iD2lDr5LKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHimRZk5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHimRZk5"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b713c7096f9so1634656866b.3
        for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 15:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767136629; x=1767741429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/TNSJrP2mJZ3nrDxPf2kug1P5afZB3GSblU/KWWN3sY=;
        b=aHimRZk5tUsaJz1/LgbnD9HG47IZ6Au8wkhNDgjnb1fKxxZ2fchCqnOXV/ah5Io2sI
         bYX/pH51LGzyNIsjLj3fJfZ8XqCKaCx0DOWV7cKrkwJVW4iTQx+202pKOdCmI0iBisHv
         eGXyV25p617rRdUX41lGUHKe9oBHzq4kVerJ4P9cLSHyNrx2+1f18Quwa0K3+6JsxjRZ
         66l9rIeTyyVm0F2/Dc4Vu7InYrfweDWPXq1WJTpLBrz/90YjzFZvn87MK2kQ1+y/7KPW
         QwY2Zm6++A31thj9ydDiZXZnSAkP9n3O4tEOV0wD6vBy/jAxYwePkLYdObQsShIXva8H
         ZD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767136629; x=1767741429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TNSJrP2mJZ3nrDxPf2kug1P5afZB3GSblU/KWWN3sY=;
        b=Xq2P/eab0WUq1IaV0zIEJMSzXbBk9NkiC6Kq/sNBYQ3xcOj12XhCNujyJLOKVmdwRo
         iO1FV0fM5IvSujRGAeKQS8LgZYKjgij1YbxtSqeo9D66Y84Ow8LKMBh0WLQ3BR5rtX33
         YQEoGIhGUen+d3zIFLS3MRPvNu7hBR/F0c8hcKaUwzOdZIRMswEm1vKi9iZUAc86T/sJ
         HnAqSyVvClrsfsJI2WGHYQTy311TT2aNS0dIYT8kX72wxgCwpr7Gvk9UBeWd0YPT8crH
         xAAOWp0n6N+FUJMnxPf/BTZu/wq28HRRtV1Z6slzzjfeqP1bOA8IUIsr+obJPSnL5SPc
         9VCg==
X-Forwarded-Encrypted: i=1; AJvYcCV6w6E25/JGSZXtJxVhmHwIrCWy/ib5vyTn1anM89AuG8CqAi8mLSFhH0sWVOV3wKX48XRaJCQhiGqui4v32xl3wf8e9JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykbpI6U/pz+40kzgQ503UCGttCtXZZVGsAZHr+K/RL/MaA2LTz
	RR4KLaA+bKQh3u1Y9Nxq5dMBHb4BKAKmGz9Iy/HJSnge/NKUwn7ajPOx
X-Gm-Gg: AY/fxX6cJdDYGG4dNBB+/vtEzNbjlhutQSTBruqyjkDf5ptNxJQE3btXGlPFdChX6FA
	RcX2Bj+cerbWaaBlz8Avhe5WF4KP62+GqzmI1gwSsiMPmxUZuun/MVjlPe5n3hhoHDwRY8Zz5Dx
	zioQU0Xaj7gNq99Yis7g3W0NEFAoKHv3u63HGwRFUTdze/BidqoQGh0pYXWjHh1SyR8fe3euOIN
	2nQyW/sSr0IwrJYZpVAItw58aRrF/oe6fDaYiP0OSap659o0Uptg8I+9sd1Wj5ZHOeX/z/6+ol7
	hGK/zCWrk8XeZW537zKbfD1A5q/h1+wzx8v1zjCHHiV3n9XpzRSZECofl/lo2OEPNwcROkNkxqs
	6IoApi6VvLGUXOnMlRpd7Nclu/+q/le0r3UtR3y9TPJV7o5xV58NHv1/HPHZELe2d7X1V3jMf0Z
	FeFhPUCGUC1iLcZOpCyuaI8TvhV4IW3bYyeFgU
X-Google-Smtp-Source: AGHT+IF9xhiqzsZ0MwhD/8m94MgvQ4TaFlv+WIJuhIccrBbu4Mont7/y38Bz2wSM1VZrbJyObRTiow==
X-Received: by 2002:a17:907:94c6:b0:b73:853d:540e with SMTP id a640c23a62f3a-b8037155d90mr3770516766b.30.1767136628698;
        Tue, 30 Dec 2025 15:17:08 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f3e271sm3832189166b.60.2025.12.30.15.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:17:08 -0800 (PST)
Date: Wed, 31 Dec 2025 00:16:58 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Tingmao Wang <m@maowtm.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
Message-ID: <20251230.bcae69888454@gnoack.org>
References: <cover.1767115163.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1767115163.git.m@maowtm.org>

Hello!

Thanks for sending this patch!

On Tue, Dec 30, 2025 at 05:20:18PM +0000, Tingmao Wang wrote:
> Changes in v2:
>   Fix grammar in doc, rebased on mic/next, and extracted common code from
>   hook_unix_stream_connect and hook_unix_may_send into a separate
>   function.
> 
> The rest is the same as the v1 cover letter:
> 
> This patch series extend the existing abstract Unix socket scoping to
> pathname (i.e. normal file-based) sockets as well, by adding a new scope
> bit LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET that works the same as
> LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET, except that restricts pathname Unix
> sockets.  This means that a sandboxed process with this scope enabled will
> not be able to connect to Unix sockets created outside the sandbox via the
> filesystem.
> 
> There is a future plan [1] for allowing specific sockets based on FS
> hierarchy, but this series is only determining access based on domain
> parent-child relationship.  There is currently no way to allow specific
> (outside the Landlock domain) Unix sockets, and none of the existing
> Landlock filesystem controls apply to socket connect().
> 
> With this series, we can now properly protect against things like the the
> following while only relying on Landlock:
> 
>     (running under tmux)
>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb ~# LL_FS_RO=/ LL_FS_RW= ./sandboxer bash
>     Executing the sandboxed command...
>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
>     cat: /tmp/hi: No such file or directory
>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# tmux new-window 'echo hi > /tmp/hi'
>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
>     hi
> 
> The above but with Unix socket scoping enabled (both pathname and abstract
> sockets) - the sandboxed shell can now no longer talk to tmux due to the
> socket being created from outside the Landlock sandbox:
> 
>     (running under tmux)
>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb ~# LL_FS_RO=/ LL_FS_RW= LL_SCOPED=u:a ./sandboxer bash
>     Executing the sandboxed command...
>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
>     cat: /tmp/hi: No such file or directory
>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# tmux new-window 'echo hi > /tmp/hi'
>     error connecting to /tmp/tmux-0/default (Operation not permitted)
>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
>     cat: /tmp/hi: No such file or directory
> 
> Tmux is just one example.  In a standard systemd session, `systemd-run
> --user` can also be used (--user will run the command in the user's
> session, without requiring any root privileges), and likely a lot more if
> running in a desktop environment with many popular applications.  This
> change therefore makes it possible to create sandboxes without relying on
> additional mechanisms like seccomp to protect against such issues.
> 
> These kind of issues was originally discussed on here (I took the idea for
> systemd-run from Demi):
> https://spectrum-os.org/lists/archives/spectrum-devel/00256266-26db-40cf-8f5b-f7c7064084c2@gmail.com/

What is unclear to me from the examples and the description is: Why is
the boundary between allowed and denied connection targets drawn at
the border of the Landlock domain (the "scope") and why don't we solve
this with the file-system-based approach described in [1]?

**Do we have existing use cases where a service is both offered and
connected to all from within the same Landlock domain, and where the
process enforcing the policy does not control the child process enough
so that it would be possible to allow-list it with a
LANDLOCK_ACCESS_FS_CONNECT_UNIX rule?**

If we do not have such a use case, it seems that the planned FS-based
control mechanism from [1] would do the same job?  Long term, we might
be better off if we only have only one control -- as we have discussed
in [2], having two of these might mean that they interact in
unconventional and possibly confusing ways.

Apart from that, there are some other weaker hints that make me
slightly critical of this patch set:

* We discussed the idea that a FS-based path_beneath rule would act
  implicitly also as an exception for
  LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET, in [2] - one possible way to
  interpret this is that the gravity of the system's logic pulls us
  back towards a FS-based control, and we would have to swim less
  against the stream if we integrated the Unix connect() control in
  that way?

* I am struggling to convince myself that we can tell users to
  restrict LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET as a default, as we are
  currently doing it with the other "scoped" and file system controls.
  (The scoped signals are OK because killing out-of-domain processes
  is clearly bad.  The scoped abstract sockets are usually OK because
  most processes do not need that feature.)

  But there are legitimate Unix services that are still needed by
  unprivileged processes and which are designed to be safe to use.
  For instance, systemd exposes a user database lookup service over
  varlink [3], which can be accessed from arbitrary glibc programs
  through a NSS module.  Using this is incompatible with
  LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET as long as we do not have the
  FS-based control and the surprising implicit permission through a
  path_beneath rule as discussed in [2].

  (Another example is the X11 socket, to which the same reasoning
  should apply, I think, and which is also used by a large number of
  programs.)

I agree that the bug [1] has been asleep for a bit too long, and we
should probably pick this up soon.  As we have not heard back from
Ryan after our last inquiry, IMHO I think it would be fair to take it
over.

Apologies for the difficult feedback - I do not mean to get in the way
of your enthusiasm here, but I would like to make sure that we don't
implement this as a stop-gap measure just because the other bug [1]
seemed more difficult and/or stuck in a github issue interaction.
Let's rather unblock that bug, if that is the case. :)

As usual, I fully acknowledge that I might well be wrong and might
have missed some of the underlying reasons, in which case I will
happily be corrected and change my mind. :)

[1] https://github.com/landlock-lsm/linux/issues/36
[2] https://github.com/landlock-lsm/linux/issues/36#issuecomment-3699749541
[3] https://systemd.io/USER_GROUP_API/

Have a good start into the new year!
–Günther


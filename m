Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F12EB10
	for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2026 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781468733; cv=pass; b=tl5kjsi+U7R4FBVe51LjtEPc3NPJW5n88pQ4KI9c+oRl+vEgXTDB0P0X/OArQoCndgK8GPelPtAW4uq4gGgG1NHledNOwosh/d1/EXmqHGLWrsMKiQiFsp8jOaPkUIWhuBU1rlP331nUvio5G7Q7iYo4ul7rtD8yLPLVi2ehV/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781468733; c=relaxed/simple;
	bh=bOKxDPKuaCxZCEB4psu/WuUy/sKwaJ1/swXJRxsOzFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqH19kedxhZO7WXJgQNiKsQxAwcvfc4YH4ifDCsSbGS7klB1eHRRxlwcDvav4lzd9WHg3ws8HFr+Cx3tKAOIE8udnjGEBHO9+QXKhtdncTD6fNEuK8wfuhQtR6f9MzOs/TJVIsoJ2cKnT7JBzJ4oRS3gcbdh/kuEe9fq/vhSIhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SVPD0tJe; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SVPD0tJe"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37474afe908so1289570a91.1
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2026 13:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781468731; cv=none;
        d=google.com; s=arc-20240605;
        b=O7nS7kdIY0p00AvD5cHN6fkbAt9XXR3+ZNVIiJdBBAkzZoc44ugsh9cZZMcWWhur6L
         47K0GXaDYXjkc2O14GvUPeHAKAn7UScP30e52m7iaikA+pV8HOmQZo+W90ArPjIFzT2Z
         +2+SPPFjkChEplWOJPWG+Tu44YeZl228g60j/xWUneaVLxt7UIOBu1MmBcm+8/DoIUvo
         DHHIvIinLPysQSo17O53zDMoACdCdNrwbFj9b2DTmL7KuwAsLXzmmhWCdY8/suyS3Itq
         gTCM2rO7PNhhSF2OVIuxspSjKYo5YTBSr3t7FJecqC2RP+ydwck3BlMQtGYkfAtQsEJH
         HZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6175+bhRhWWA9QTYt0jgA82Mq/7abv3w42zWcC6M6b4=;
        fh=OBlHeAjBePPO0rKHt+9mShvkbnzJN0ecGxv3S6WScGE=;
        b=Ogw0gOTL45kug/w1xcKS3HailsgeapAcnhJbsMPzt0YVtKySQ3VIL08gSsNtycFeGA
         o8K4aJpBDromhOW4Hy2u+UU+ynXxo0ng7rKQwGXnh9/QSuy3BZfcvRYgPDawmdjR6dgC
         6/Mqq9Lv9LKp2A6+y03uWGGFjG8GuZRyT6GtJJUKq40ZTqrDsJOMk8UKoJhWZ7WzhRzs
         nckGY44o3QQ9CIk1akgr396fTdqgJYl6V3u1IfSYk/CQkD6TnotqD0HhyqxY5T5tqDzc
         pSRTUjhi01tIpFfKzPqY+1edKOGrRr+cSVchg06qS40zDHubXLe4bnF3TyHdQY0hf3Pg
         1Fvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781468731; x=1782073531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6175+bhRhWWA9QTYt0jgA82Mq/7abv3w42zWcC6M6b4=;
        b=SVPD0tJeGfv58tUC40z0BCArMc8XceZ+5AIcLvaPZCQFfjKGhKpSGj+CDBr5Bpu3x4
         LjZrxg5DEqG3Vab+PW2Ti5gIC7/fW0QABub8YzXVMrECUZlbq6FK57HEOo9X7jXKSSto
         FRz4ZabLEN5CXO8Ac4TNQjn4LiwI6k2k/j4bsfy/b2LEPJz5HTtb/1JZ0l4Tzu6P2hKL
         Dct2XiAsyOSeDjt5dcuqVq1NOrkkSHIoM/aLrdl/jyo2nf0zt1LYHDMVuBFNMqEAdJ2k
         x0nq7+DFgrTZZAvY9C63M8+ZraMnxJcI3GbUjj7ACSZfwoxCNGP+m8R2s3m01T1F/IUt
         pLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781468731; x=1782073531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6175+bhRhWWA9QTYt0jgA82Mq/7abv3w42zWcC6M6b4=;
        b=aAcYtAtnpnPBp2eZ6eyu4HZtVNLEnwbYdyzitdVrqQAr+Oo/+nZc3DIZWf7UP38sKn
         8Roa8+PDLtpMc0kVaNOaHLfQJLn72bcntewnQiyrCc/UpmWQ41wRrrz1G7YmjKRx7qPQ
         DNde+h6HpzmF4iFFei7Oe4mBk1LOKTl/yzUZANCDibhBrJVQoA0G6lPz3vMXcLmJQdci
         ynDMNsyfdqrFIi/joSG+Y4kRS39vQApeHhnCwon46gW809lvQL/2bqEtK8zT3KXFE3UK
         LgI6XuTfUvbsL9ccpKrHkpeKyi2tM+wlwvVBjK1cRM8SvADitrSheNb5HJwLsFWSP829
         EDlw==
X-Forwarded-Encrypted: i=1; AFNElJ/eXachDmzAzVTvWa0ZhEO0m++CyEmHdP6uS8OQws2+O4IO8bHs2pJxgWJgamaydx1FvGdq+Qkj5G/zimzJa7Q3FG0D8lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK9ie6xhGC1WFYw4hGg+yoAtskO+cqNuAdN5gaxx5K8/Mc76cP
	PEb5kRzQWRCApjT4YnsnFDARgnu85YGuPhoXK5uoO3IaqL9ghNC06LkKpb4kSOfnEoj0XZuenP9
	ShmdIXqDcecDcDJLhlkhz8oSUWlA7O7Q60Zptq47G
X-Gm-Gg: Acq92OG0DkoPQiyQT6o1K6fbO4h9Kx9u4WT7EBCOfOhBZ4wimzQX9aDwoGDqWQJLSn9
	LFXWRsnpCLPtPzZm8lu8uQWeKnd0vr7rf6m5MJRy114PIW6U0dlkgweo1k4fng4AbjEshD9zTgZ
	SpBtTMENX6MS5/3OHIeXPFcbGW3P1L7DSbIyUG21ZuWkbbJ/X0D87j0rKLD1pcL7uTNERaK/XUe
	Kk9WgvmclXhG5VjhTgRfcnMzl1kXgDaVKdvbic+m0cSpUK9QlE9ANav96kKpQYvGbXbNJGHuiIb
	I3r+anA=
X-Received: by 2002:a17:90b:53cb:b0:369:7421:75cf with SMTP id
 98e67ed59e1d1-37c2bce7aedmr7047109a91.16.1781468731181; Sun, 14 Jun 2026
 13:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513180506.760657-1-stephen.smalley.work@gmail.com>
 <b99c011e6d988fb98ad017265115b323@paul-moore.com> <1c87912e-7d7c-49a9-b964-3568e63e74a0@canonical.com>
In-Reply-To: <1c87912e-7d7c-49a9-b964-3568e63e74a0@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 14 Jun 2026 16:25:18 -0400
X-Gm-Features: AVVi8CeHUOSJ_1WPAZ_Ef02Y1P18TzRtWRSe47IYgVhmXKXgZJVaIOmP9BY_9dY
Message-ID: <CAHC9VhRvGUQKiJUNCY6oYY2PuWqQeuV8xdczoAqXyRw9NAtdSQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: hold cred_guard_mutex for lsm_set_self_attr()
To: John Johansen <john.johansen@canonical.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, casey@schaufler-ca.com, serge@hallyn.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 7:29=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 5/14/26 13:47, Paul Moore wrote:
> > On May 13, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >>
> >> Just as proc_pid_attr_write() already does before calling the LSM
> >> hook. This only matters for SELinux and AppArmor which check
> >> whether the process is being ptraced and if so, whether to
> >> allow the transition.
> >>
> >> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>   security/lsm_syscalls.c | 9 ++++++++-
> >>   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > Thanks Stephen.  I'm going to merge this into lsm/stable-7.1 now, but
> > hold on to it until next week before sending it to Linus.  While I
> > can't see why John would have any objections to this, the extra time
> > should give him a chance to respond.
> >
> you would think?
> well finally getting this far back the backlog (sorry)
>
> no objections

A review is almost always better late than never ;)  Thanks for taking a lo=
ok.

--=20
paul-moore.com

Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7321F4A3E
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 03:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736049117; cv=none; b=dnq7pYB4XjtTrCLTXakzT6ldjOfUkY0Suo/xYgCEknFgGDpU9kO3sc/llSZCQYl1jjE4cBhkBLgOrmyHIBCiYmJYplef+mYCJWmCG+FA6HwSLsHaqv2on1S6U5YogTiV1vqMbkjCB2jv4IacmUz7VuYcQsBuZSpBfm9fyXgEPJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736049117; c=relaxed/simple;
	bh=JB8u9MpdUGcVST/3+QyhiiiB+l2M3B5wnGcVrvsDf1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rft1hN/ccRwYpLneHuwBSQkRj7zzOmlq3J4NO+oi8Jy7W1hMa8J1hBdWn47dTC2o3p3Ar2iRacPXSIaLt0y8NW3Cipwi2nfmZ+5vpl3vRE03twVmhYq8gk+nmbRygd2iH9orZLuK8vrAivB3XkFoS+W5oe/xV3GucCEPtKxYn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NHtSQxBk; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NHtSQxBk"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e5390ed85a1so17711253276.1
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 19:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736049114; x=1736653914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoyVQMf7stkvDb40CL9IIDCTdKO3yMnPD0zWSkcmakw=;
        b=NHtSQxBkFpO00/uz4ptChLD4nCgfbpogmz4gPs1HExqa2bsPMmxLtp7W23dx+/ezKl
         LEl8HYyYqosI7DEl0E2aSwSR0SZzcjCSPXQYrIXVuBi7h+S+yh+dS0aqp1+FXFObN1ZA
         mfKaXdz/Xc8/AMLRb6H2pRhJqAJdkuHiUPVgqPFfaxEMl75bekfnDk8ZNgRxtLXQAGqQ
         6Ryb4Hc0KMim+kpPV7QgdkTO5ZsOKdVKI1CJdZzoHFOz5HNg1PGzfqreoiSpRQGAaycs
         8BDtFLC6NbdgpPbtbqs+CLYMCux2rAuqx6JH6MOZltDV0KDaxJh8QCqvILJvGHMyVTMv
         tsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736049114; x=1736653914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoyVQMf7stkvDb40CL9IIDCTdKO3yMnPD0zWSkcmakw=;
        b=iV+AH6zR+qeZnt6FdZlJj8KnuUerUQqG56MQL4uef6zdMLIa03MFG4p2nZUrmG3h0M
         HRiNUOJmPGFQZSn/JHP5wu1j5rJl7zAibm9h9qVlznvt8wWHRJY69vU744dgKOqBUR0b
         TUyrI/AKwWMUtbpCXOeWaCd/62s1rDYklrv1dB8fuiGNI56ZEUZH78pKjN0bylc8p/9g
         EPwt3cqune5FmzyjakwN2+UiA6Izpm3vIE/WtRhpJHYx4UdqcRrc+9wSqBZJZP76hwBw
         1SnCJb8w0IBcQXZz+ZSYyx591JpoiCtC99WKJoLM8VWKpSlE4wEKJ1PaUSNU9WYRZjmS
         XS1g==
X-Forwarded-Encrypted: i=1; AJvYcCUunWxcAZQP13AA1oEnHVIPVziOlNfk6jVOkn+Kex5gP+mcz6aiGXm4KdkAmQU3Kzt/02xiXmETvn3pKCNBe5OHQ/TsQFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyIqqS5cSWtjxPT2xL2SN2uDbNpqN02fS9oyBSyGPlkLA25sy
	wY9DM2OTWW7RXhuvRy/zO2Yt6NHGKHseJHCMkywE5rJj6BAdRUjLO5WioYaysVDlA9qgkOKufyh
	YnAb+iBiGARRAS7yPrTFLqWWe732vMmPGPUi/
X-Gm-Gg: ASbGncuZqGKitLd0V02hhNpOlXdhIoNIYeiDE63lawgpu4xp+ma0lJJMcsuW44rIBLs
	C0TrN+riGDQnQ1mYXZXyNQ1Dt9VZOjT3roRBD
X-Google-Smtp-Source: AGHT+IGc7SMsivE9GNfp0zOKo3BHvCo9GY4oGtCRj5PqxHP0r8P+X/TxYI8hJSRcaVO6yGl+W68xIRiYLzadGWtlYVM=
X-Received: by 2002:a05:690c:6a02:b0:6ef:7d51:eba6 with SMTP id
 00721157ae682-6f3f8219ef5mr460876097b3.28.1736049114425; Sat, 04 Jan 2025
 19:51:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675f513a.050a0220.37aaf.0106.GAE@google.com> <20241217182657.10080-2-leocstone@gmail.com>
 <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com> <ed6e5639-c87e-49e8-8125-5b93cec69d43@I-love.SAKURA.ne.jp>
In-Reply-To: <ed6e5639-c87e-49e8-8125-5b93cec69d43@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 4 Jan 2025 22:51:43 -0500
Message-ID: <CAHC9VhTUZjsVwO874oW2+6eNYdsudUcnP_ZFGn6ZEFS1O7zk2w@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: check size of writes
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Leo Stone <leocstone@gmail.com>, mortonm@chromium.org, 
	syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 5:01=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/12/19 6:51, Paul Moore wrote:
> > On Tue, Dec 17, 2024 at 1:27=E2=80=AFPM Leo Stone <leocstone@gmail.com>=
 wrote:
> >>
> >> syzbot attempts to write a buffer with a large size to a sysfs entry
> >> with writes handled by handle_policy_update(), triggering a warning
> >> in kmalloc.
> >>
> >> Check the size specified for write buffers before allocating.
> >>
> >> Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=3D4eb7a741b3216020043a
> >> Signed-off-by: Leo Stone <leocstone@gmail.com>
> >> ---
> >> v2: Make the check in handle_policy_update() to also cover
> >> safesetid_uid_file_write(). Thanks for your feedback.
> >> v1: https://lore.kernel.org/all/20241216030213.246804-2-leocstone@gmai=
l.com/
> >> ---
> >>  security/safesetid/securityfs.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >
> > Looks okay to me.  Micah, are you planning to merge this patch, or
> > would you like me to take it via the LSM tree?
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > I'm going to tag this to come back to it in a week or so in case we
> > don't hear from Micah, but if you don't see any further replies Leo,
> > feel free to send a gentle nudge ;)
>
> FYI: I sent
>
> https://lkml.kernel.org/r/014cd694-cc27-4a07-a34a-2ae95d744515@I-love.SAK=
URA.ne.jp
>
> which makes this patch redundant if my patch is accepted.

Sure, but this patch is trivial, and there is no way the
KMALLOC_MAX_SIZE is limiting any normal use of safesetid so it seems
safe to apply now.  We can always revisit this change in the future
depending on how the rest of the kernel changes.

--=20
paul-moore.com

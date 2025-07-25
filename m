Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B55F9E8
	for <linux-security-module@vger.kernel.org>; Fri, 25 Jul 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403181; cv=none; b=Z05LeX88BhYzMcwBEUYfTceUcW+6TVbPQDtXZ7+bExAkqcdB8iUlryFDAX2laLb+E+zWOzhXA8mQIEpWO1JAxIQYzFqvU7WFD7Y6uHOecedEF1ReKPUcml25RSl/50hhoNJJYcRbl9FNlXFoJdhPGVj8mGBzxFeOPoeoH9zocd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403181; c=relaxed/simple;
	bh=l6KU0Ym47gpo/4+gkXeck9uuSdoJ+qGh859kPbrOGxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDjpA/TJ2Qi+cZ8OPHAC8QdibcxLKmt6mFqcFdluS2GMit+Wiganx3qg2lfpgWNpoWS/xvlnWpFDTj/6jCY9xEeJA2UsgyBGFarVr16efzO+w2ah0tXDLiM7zD1CJWM6tP8dKKPnGCvOM0bsxTO1YyQzGfFjt2q5QEf7QR9nODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QL95pT9n; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QL95pT9n"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8dbe824ee8so1455411276.3
        for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 17:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753403179; x=1754007979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBJLs/PJJpZNnfbuzOicwNBmKO4/LfqUB+w9NcUKQoI=;
        b=QL95pT9nNEUuLj5YIn8J968lin62mEs8NsAxep0uc80xD58yjg+QAEu0hyVdff3bTy
         2V+TuRY/rDd8wCtME6VGwi++mN5YN8mdlqF2yhJwHsB9pej45Mksj1JdjPGFzQqwt+xp
         GZFjNl6++t+OD/gKZdk8ZLSLMKKIDDMAMZ5ugpO6n3j/AXc9h1/1NyN7PLJMtaKWpezX
         QyhWbS5TSEEDlidavpE0MMKwQfZ3ZKBJuosFgjAjePOUNSMM31MQvFRPDDjiN34kRRvB
         Rmt5LJpNbDTTwOiyQaiUmWvwjiPWGTIUKjhiG8tXsEZeEy5/Hq7R0FAwQIyrYSdR1ljO
         17cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753403179; x=1754007979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBJLs/PJJpZNnfbuzOicwNBmKO4/LfqUB+w9NcUKQoI=;
        b=OXO0SYCh3a986ZnJnoAFQJsCl1GRWrGcOSukv2FGJ2GCugBMIOZtsyc/HuYT8Ch+L0
         EaKzxbrYetdXphVeZGDt69U8z6WZ1NgTLeu2udKXNv/NkDi7oO3tbAi/zuMyRjM5fmgr
         CLBcxFta0FI2oX1OdA4JayN5CSGhtTYSbG+fibLVb9q9cMLI0/gG5MfNYbMHuYsdZUv4
         yf3TTohSC6gyQCTlXmPVLUStl/tSddvDtY4qiMksaVam8RZ+MJrwIEnyjPgHU2LyVtap
         KNs1BJXl0ti6CYPkkI6bsYlzNb/9+REZe18320UvjTPj/0GvrS2R/aSrVFhoIUKYOYmq
         WYDw==
X-Gm-Message-State: AOJu0YyqGaWGXCj+CyfMQcZiL8H2hMin0omKcEK/VVpAWBGDy2RBUquI
	REQD/eIp2zmnCEkJPImqsJ+N1mFYjeIzePzZ7xdBF5r4o/nptceva4DURnWGuaWVls9XnCSdOkG
	A7iA96k9sDeSUPVnqRgVF4oSXDevmIukPMUDdsbeQ
X-Gm-Gg: ASbGncuX9Cz+pS9j0opwlUd80/vQOcXgYUFwbsMQv85D7ccU+WYwKel5mwriGOXI9bS
	QX2ANjFQib649Y/BPSYrvXgOfZOlanw/QQisr7cWX4pfkigY9yn+Y6OifULVFcJDG/hMs9du2k/
	yFF4ExgySiMXnfvE5gs8CcvikG9mglBKE7/aKCA83GcF1sXL9Nzrp57A6OQ2QpHkD44Ve9XGwb5
	TjUpiU=
X-Google-Smtp-Source: AGHT+IG4xX28wZoJE5JbFJ1OTlVa2IhSG6LUzyalZVXihO1W5jvkr82mHUzmVqX4OTGOr9Xttp4WAF0/MiDAQgFmyD0=
X-Received: by 2002:a05:6902:13ca:b0:e8d:ed1b:3186 with SMTP id
 3f1490d57ef6-e8ded1b3c48mr1253952276.39.1753403178849; Thu, 24 Jul 2025
 17:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-46-paul@paul-moore.com>
 <4ad43ad6-97b9-462f-af17-6d6db8ba3bf6@schaufler-ca.com>
In-Reply-To: <4ad43ad6-97b9-462f-af17-6d6db8ba3bf6@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Jul 2025 20:26:07 -0400
X-Gm-Features: Ac12FXxzx9eoUQimi8ooqCkQhXmAgNy1LksHgxSM-xb0VeXwFZGGkkiSgXURJwg
Message-ID: <CAHC9VhSV=e6aM1raofn-WWRJLS8aMYxi9kEsmL4BuTWLxXWLvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/34] lsm: rework lsm_active_cnt and lsm_idlist[]
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 11:34=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 7/21/2025 4:21 PM, Paul Moore wrote:
> > Move the LSM active count and lsm_id list declarations out of a header
> > that is visible across the kernel and into a header that is limited to
> > the LSM framework.  This not only helps keep the include/linux headers
> > smaller and cleaner, it helps prevent misuse of these variables.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>

...

> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index cbdfac31ede4..03d3e140e0b1 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -22,8 +22,8 @@ static __initdata const char *lsm_order_cmdline;
> >  static __initdata const char *lsm_order_legacy;
> >
> >  /* Ordered list of LSMs to initialize. */
> > -static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
> >  static __initdata struct lsm_info *lsm_exclusive;
> > +static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>
> I can't see there's a good reason for the reordering. I'm not
> objecting to it, but it's curious.

I'm pretty sure this is one of those things that came about while I
was upset with the state of this code and was going through it with a
hatchet; a lot of code was ripped out and put back, so it's likely
just an artifact of that.  I'll flip it back around.

--=20
paul-moore.com

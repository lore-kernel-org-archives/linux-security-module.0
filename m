Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2652F3DA5A7
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843297; cv=none; b=soI7CAwII+dqlPaBuM2kr80DSWFqTFTsnW6J4guHxbryUGPFXZN/sPcdlwfUaPJuzg2KqYZzdhrk2yDpmr3jW1Lha400dr9XwmddG5FxNFGbLCDlGyZ4H80hI7MJg7HJiXaqFBpnUPoYWEiKk3GF9PiLw9Ya40malUWzDk2CKJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843297; c=relaxed/simple;
	bh=QApw8TJjnQ7N9sVAlRbNc7hAYXQoDT/tA1gaRycz0IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh5c1dmdL7KlKl33jwuL6NVwzx7G/Bc5ObX7eKiHDEL1NsFx+PzroG65vaQCxPp/4Jxuep1hi3qzaHBgoX/ZpyGyeHzAilWFz6Gx6jS15xWmg9toZ9LokpXGtVXQfXnx87yVckVhN1aP+XUsuRzDRNdCCB5haIxHaF1cM0AHmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZGmkzFx; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZGmkzFx"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a610a32a6so25689207b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 07:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773843295; x=1774448095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/rL7ESYOr93CkJL9mrCdMWsofQZ1/yzk34hykdWcS8c=;
        b=NZGmkzFxvPvJMKPIpAUGu2LW23uqb1b9SW3PVmlmytVwbo0MmAGaiX3AC8qNiae5QL
         yoaRyW5T2v0ia4Z2dNi27TzaWZTD0QAT7hbs6zddk8N/U/6FjP9aLKRhuUZunqc9xIEh
         l0Wu55FwW9bmo4mnkz38+IoagVTwYp06L57/i3qaIiRsg663gQTU69ym8U1zkhKOQFyS
         LyREY/rdvWmcvPH+CQVm9g8a6fJJbbhyGMdmkXF1jYya3e0yjZ/cFBy77r+Zq/mOozPT
         rn2sGVdXLUCJivaZgLiD9hg0aL/z8IUY3VE0/wCcLkO81QrMcj/qKnNUm2/mtJmBzEov
         GIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773843295; x=1774448095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL7ESYOr93CkJL9mrCdMWsofQZ1/yzk34hykdWcS8c=;
        b=i+H9km17wEFmnej1J2MaSvJJH7M3PGJeF0TvpVTVvfIJYsm7h2HGHjvETTbQ1j290C
         qXpwdfjUhOvKeXO7bEpoErI4taHukfhX88GtVch/l3++tWD/SylFgGJw7hZoIMkJWnKd
         XH6X2arVsSQi7Jlmgm3sU8FQ0YeOpFziG2Tf1XkmVWdmJrS0Ci2wWiL0WDNqgHuMv8B1
         zTuyl/MNWI8glewqfUIiSyy9qVQunpAXNAwQbSMHOUexRRplRFsRQ6r5KNj0+aeMlfmJ
         KA5sDjLmqyqOAoSrvwew+3rJVCHadQyY8hOY+PpHXXFUZY9+nWUazLmdNJZJUgK57jFM
         Ik2w==
X-Forwarded-Encrypted: i=1; AJvYcCVRzcV1HlfWhkXBn4EKYYnxA9ehm0z5cgroxvJPSCMI6P1bXhNquJhvee16Kivsc/N2fvoK9a9yvpkJUY6Diq855tWF29A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxogJkNi/Xjk39tjIUAV5cxruFIWpt1e7hUEyov5maCw+6gxaon
	+gSmG+3VoA9TLq2LYuA6OBPfU8o+Kco6LG52us8l0YaKCkox08MlnAjzIfYpJTds
X-Gm-Gg: ATEYQzyXDgh+kjIvCzW9J1VLlW2TRIKqs1XCj3aNdHUp106xbdO50uBaPIGpODbn01f
	5m49AadylwL3ektMxy6YYR3uWMHToX3+3S47hzPztrKIWHwGC6kpV7epuJwoj53kYCwMzb5MJ5o
	rjF1fSBOmnVw/vQbrmFuW3vYevfjwsrFHVsz9sh9yNy+Q+Kcp87HEbuWYDAMbitdY+B7qew6Kup
	xgDhL3lDcjp3IRpd9J7iARWhdRLDt0JKeDtj43VIQbVHmDYHIas3f0a07T0i9j8csPjCcebRpX8
	xhN4FlrfZtsh41S0j8Zqo5FvSy2m/CItsEKfvsSkuEiOELTQaftZapppg//ZITaI8gazh0WnOjK
	05O9u7VyA5QzCwvJ7HCefHEKli3kHg8hVo2Y7EPG8EPg5iMn1IIfEdFGXwzEJiqAJ4cv4y3EpDg
	IKWKjZFreRbZTD+S21lT3nWWjMmmLo
X-Received: by 2002:a05:690c:9a0f:b0:794:d3e6:a503 with SMTP id 00721157ae682-79a718c9335mr32324777b3.24.1773843294972;
        Wed, 18 Mar 2026 07:14:54 -0700 (PDT)
Received: from suesslenovo ([129.222.86.248])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a715f8b4esm17873877b3.45.2026.03.18.07.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:14:54 -0700 (PDT)
Date: Wed, 18 Mar 2026 10:14:52 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	John Johansen <john.johansen@canonical.com>,
	Tingmao Wang <m@maowtm.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v6 3/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <abqzXO3MmMXKqXOy@suesslenovo>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-4-gnoack3000@gmail.com>
 <20260318111507.1nr6rAki@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318111507.1nr6rAki@linutronix.de>

On Wed, Mar 18, 2026 at 12:15:07PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-03-15 23:21:44 [+0100], Günther Noack wrote:
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> …
> > @@ -1557,6 +1560,110 @@ static int hook_path_truncate(const struct path *const path)
> …
> > +static int hook_unix_find(const struct path *const path, struct sock *other,
> > +			  int flags)
> > +{
> …
> > +	/* Checks the layers in which we are connecting within the same domain. */
> > +	unix_state_lock(other);
> > +	if (unlikely(sock_flag(other, SOCK_DEAD) || !other->sk_socket ||
> > +		     !other->sk_socket->file)) {
> > +		unix_state_unlock(other);
> > +		return 0;
> > +	}
> > +	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> > +	unix_state_unlock(other);
> > +
> > +	unmask_scoped_access(subject->domain, dom_other, &layer_masks,
> > +			     fs_resolve_unix.fs);
> 
> This might be obvious but in case it is not: You obtain the domain
> pointer from f_cred->security. Within the unix_state_lock() block the fd
> can not be closed. Once you drop the lock, the fd can be closed. What
> guarantees that the domain/ dom_other point remains valid between
> unix_state_unlock() and after unmask_scoped_access()?
Sebastian,

In short: dom_other is a pointer to a landlock-owned refcounted struct.

There are two cases, one where there is a correspoinding landlock domain
with the other socket, and one where there is not.

We lookup the domain under lock:

    dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;

The '->domain' part is important.

Thus dom_other isn't a pointer to the actual tasks credentials,
it's a pointer to a landlock controlled/refcounted domain.

This is the function which returns a pointer to the creds.

    static inline struct landlock_cred_security *
    landlock_cred(const struct cred *cred)
    {
	    return cred->security + landlock_blob_sizes.lbs_cred;
    }

If we were storing the landlock_cred_securit, that could potentially
be a problem.

But we copy the domain pointer, which points to a landlock allocated
and controlled object.

If it is a domain, dom_other points to a landlock controlled, refcounted
struct landlock_ruleset object. So even if the f_cred is freed
afterwards, that object is still valid.

Justin
> Is this invoked within a RCU section which would delay put_cred_rcu() or
> is there other magic involved?
>

> Sebastian

Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B71DF261
	for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771507580; cv=none; b=AGcJ9CcSR0bFP39RJqGrxTHtHj1NkTYEwW6lROJvlPXNR9H2FNLgJyPWPvLN7CRhl8/au4JYDoPe29LavN7ehjRetGk2O6POMRYPNHcdsEL7ufgouHspavgOklGrnWgQCOlvvRXO0fuTZWD86eg2njOqw2ztnBzsKgHovJJdj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771507580; c=relaxed/simple;
	bh=lE2P5xBnskwwF3hyMxaTa17iB11krmUO9SMfHmVlolw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBPU4OZzZIbJrmVYEHynTrPh2A2WimDzjwLIIJt39yU9O0e2MobgouN70Nx86U8A/YzG2OPdpq4rh1P2RjZdMLDyuUWn37VltS6PrtYIlJw3iyyBtt3j5M0u7L7U5Gd5D6yLbrEjM9DLCYOop2asj7Fdvs3h52UegKE6/M8FxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIWVJ/MS; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIWVJ/MS"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7946a1f2430so8465137b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 05:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771507578; x=1772112378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1tG8t+pRzO4Wpd4p/h1xeXEM+zY8Ql0TZxNWG+B2+zU=;
        b=nIWVJ/MSlicMU/+Hw0tDnyqYOA7vULCmHc/brPKqLXdK+GPoVHyL59PqWFSFB1BgWM
         Qc1ipHOA7DuX4RC8xiv1kiDi0TKd6JZJyE5IAbteW4OwmRYpUryKhdyQpmvaLuzj9jkx
         KahKCOxsduBgJZSqaxgIjwEXkdr/33mwfxhRYVHFg1UJtbowKdppGOn/e2Ji5zMNSHEn
         v03OKz3Z5cfIhiPRX+wY/SIwQSyqvctTTnjBlw78ZAiquPnp05EbiDd5O4weBtaZ6J3b
         eV9yO0iFnRDkUhHF1+0rQNqGilMHf5PicNDHyi4ZTNddy7JE39h9G1XBaV/WmL4Hfki2
         Q8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771507578; x=1772112378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tG8t+pRzO4Wpd4p/h1xeXEM+zY8Ql0TZxNWG+B2+zU=;
        b=J84eLgDeIt7V/WLTsZ9tUlY63Smmn4QFooV+5UCxmgykH4xeRFl4JdhcHgQrPU1TIK
         SASs+bRBQ37oIAFCcpZMq3b/07UuUciParm+hhXUocheZ1bDtD7c1HC06gxFh3RMAdh4
         gw/YVwLX/YdXVqQgwTWB32+4lnLPxTIPfhI5Y67wXwJh590DWfP6JNzJCczaSSmHQJIc
         r9SC2l6UkrsZJROSAX/1NCe+mjYkROltoJ6dDNCvEmZIFV6QTjFp6KSyaIVtVQD6ZKvQ
         N8m9IshP7heaIx8IrJR2BLQFgxhMY2tEuvPMR+fiv61SyhbURAouMsKbXMNWDBWRZaxI
         kdXA==
X-Forwarded-Encrypted: i=1; AJvYcCX177L/7S3zAbiKLMnp9YYmjL9bCeV3RJCav/YyQzkHbZGy5Pr9DTN6ulWKclcltKp/+9hF0Fp/Hw8ZNMAzjdNrA3Kbo3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+3iUrYeai+xCoGPaltNxY+OsXsRIK4UhkRxSU1QueM+p0i2B9
	fj4HdYAuzjOpQ7t8D0ekEnTd6S8agNSg2Qzo6nMm9VaYLpYAdrbNRoCt
X-Gm-Gg: AZuq6aKSIo5rv3vOX41B9c770xyGpDOU0fbnD7vp2tQ9+7Ne9+++fyUDhaHznymI987
	WmoHX5VA+dxd62qyIQZyyg2JuaVkb/Mkg2gzkI03z7JunSpGzUm26jX6bymd3RN+BUKQNE1EYUZ
	m77apFC1EFVLXhGsO91jxR39aFfmjZdr8YBlCcwGdBr5LH54HdMymxaAIOBlMa45II1o+hNDlDr
	3vCUcwa7lFzM1B9Z5dvrLzBiRtK8M0QmqPDhCEw3Qyv9SCcS8hzo9+kLlQx/g+Cl9MWan2A9uDn
	SL+YibPZcHBST12RDRY5jc5kVLJkPfMqG6CeEDgHWb9Eiulsik5wVxl0nD9kwC6U6o8tFf3SjEi
	S7itpbJizglj5yfrLZW7ttGPUkbAlIGg+vKxt7YHch6PpsPu7Q3qoJT696G9avjkoNLGqJ6KPEW
	JheLKpCsVPGQye/Uv9PuuEntIieg8H
X-Received: by 2002:a05:690c:4884:b0:794:ef94:120d with SMTP id 00721157ae682-797ac5263d8mr137193447b3.24.1771507578168;
        Thu, 19 Feb 2026 05:26:18 -0800 (PST)
Received: from suesslenovo ([129.222.84.220])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23f251sm134243267b3.24.2026.02.19.05.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 05:26:17 -0800 (PST)
Date: Thu, 19 Feb 2026 08:26:15 -0500
From: Justin Suess <utilityemal77@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 1/9] lsm: Add LSM hook security_unix_find
Message-ID: <aZcPd3OKqxwCZV-5@suesslenovo>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-2-gnoack3000@gmail.com>
 <20260217.Nei3Aeg8bo6h@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217.Nei3Aeg8bo6h@digikod.net>

On Wed, Feb 18, 2026 at 10:36:37AM +0100, Mickaël Salaün wrote:
> On Sun, Feb 15, 2026 at 11:51:49AM +0100, Günther Noack wrote:
> > From: Justin Suess <utilityemal77@gmail.com>
> > 
> > Add a LSM hook security_unix_find.
> > 
> > This hook is called to check the path of a named unix socket before a
> > connection is initiated. The peer socket may be inspected as well.
> > 
> > Why existing hooks are unsuitable:
> > 
> > Existing socket hooks, security_unix_stream_connect(),
> > security_unix_may_send(), and security_socket_connect() don't provide
> > TOCTOU-free / namespace independent access to the paths of sockets.
> > 
> > (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> > This requires another path lookup. A change in the path between the
> > two lookups will cause a TOCTOU bug.
> > 
> > (2) We cannot use the struct path from the listening socket, because it
> > may be bound to a path in a different namespace than the caller,
> > resulting in a path that cannot be referenced at policy creation time.
> > 
> > Cc: Günther Noack <gnoack3000@gmail.com>
> > Cc: Tingmao Wang <m@maowtm.org>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  5 +++++
> >  include/linux/security.h      | 11 +++++++++++
> >  net/unix/af_unix.c            |  8 ++++++++
> >  security/security.c           | 20 ++++++++++++++++++++
> >  4 files changed, 44 insertions(+)
> > 
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 8c42b4bde09c..7a0fd3dbfa29 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -317,6 +317,11 @@ LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
> >  LSM_HOOK(int, 0, watch_key, struct key *key)
> >  #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
> >  
> > +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> > +LSM_HOOK(int, 0, unix_find, const struct path *path, struct sock *other,
> > +	 int flags)
> > +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> > +
> >  #ifdef CONFIG_SECURITY_NETWORK
> >  LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
> >  	 struct sock *newsk)
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 83a646d72f6f..99a33d8eb28d 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -1931,6 +1931,17 @@ static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
> >  }
> >  #endif	/* CONFIG_SECURITY_NETWORK */
> >  
> > +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> > +
> > +int security_unix_find(const struct path *path, struct sock *other, int flags);
> > +
> > +#else /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> > +static inline int security_unix_find(const struct path *path, struct sock *other, int flags)
> > +{
> > +	return 0;
> > +}
> > +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> > +
> >  #ifdef CONFIG_SECURITY_INFINIBAND
> >  int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey);
> >  int security_ib_endport_manage_subnet(void *sec, const char *name, u8 port_num);
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index d0511225799b..369812b79dd8 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -1230,6 +1230,14 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
> >  	if (!sk)
> >  		goto path_put;
> >  
> > +	/*
> > +	 * We call the hook because we know that the inode is a socket and we
> > +	 * hold a valid reference to it via the path.
> > +	 */
> > +	err = security_unix_find(&path, sk, flags);
> > +	if (err)
> > +		goto sock_put;
> > +
> >  	err = -EPROTOTYPE;
> >  	if (sk->sk_type == type)
> 
> I think this hook call should be moved here, just before the
> touch_atime() call for consistency with the socket type check, and to
> avoid doing useless check in the hook.
>

Agreed. One less annoyance for end users of the hook is a win. I'll
resend the hook with the call moved into this if (sk->sk_type == type)
block for the next version.

> >  		touch_atime(&path);
> > diff --git a/security/security.c b/security/security.c
> > index 67af9228c4e9..c73196b8db4b 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
> >  
> >  #endif	/* CONFIG_SECURITY_NETWORK */
> >  
> > +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> > +/**
> > + * security_unix_find() - Check if a named AF_UNIX socket can connect
> > + * @path: path of the socket being connected to
> > + * @other: peer sock
> > + * @flags: flags associated with the socket
> > + *
> > + * This hook is called to check permissions before connecting to a named
> > + * AF_UNIX socket.
> > + *
> > + * Return: Returns 0 if permission is granted.
> > + */
> > +int security_unix_find(const struct path *path, struct sock *other, int flags)
> > +{
> > +	return call_int_hook(unix_find, path, other, flags);
> > +}
> > +EXPORT_SYMBOL(security_unix_find);
> > +
> > +#endif	/* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> > +
> >  #ifdef CONFIG_SECURITY_INFINIBAND
> >  /**
> >   * security_ib_pkey_access() - Check if access to an IB pkey is allowed
> > -- 
> > 2.52.0
> > 
> > 

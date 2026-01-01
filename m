Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D431288537
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767269622; cv=none; b=TFBJYH7m2PSjAqmQ0NzfJXgtzuMAecH1NDZjkGJ0DdIRG4qxClOhZVMa19F+0X0RMdrKPrs5vUHiSi8lgiEhLNUrl6fOaz5oVUqSeTlg6PNgXvqKbjG7r3tLLb9ip3005CTp5FJLoVdlFO95sJdL17MA1rCASY46FN1dhONwbMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767269622; c=relaxed/simple;
	bh=UdM1HfQreH+Y+jnaqsSNzGeHjhqbTMMiQQfYeJbdnXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrA5gUtRy7+f9h8B2FV3XUteDoc6PvJuFiGIEcE50jUg8THU+aILijn5N04U2q8/Z2sxU+fpvr6FbN/87UQXMXnK/KzO2ZrL4U8lERy7E4CwaGH7/R3O46GxlhspM9bamoi3Vq/Pcx39TbayIMgKPc9zNlL1O+6xXH8OOGpQM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngrydRdz; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngrydRdz"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8052725de4so1124224266b.0
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jan 2026 04:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767269619; x=1767874419; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sYSYQ5jiWBTKPeAkBFI55cURVtS8dCeOtSoRxb6fDPY=;
        b=ngrydRdzp9UMrAAej0nm7dkpQYveneJRxLWiyOvp1O2sxhVO8OTYXWAKDdXmel0STx
         Qsv/RmFeEH1izvJ9ebpbYScLl++pt74kFZFaLL8Tr7H/l8aUDvi1UudI9pqFC8lGRI3q
         B3+GygT0X+adD9K6bExUcOQw/itPdhl0XSR9UOSmDr/og2fbLgxXVY0Ks0kJYEE5kRLy
         DxDFk+QZV6yUjuoNqT1bIfrtz7G5DWznBTwhFH/xlsslP9i0kHSscurTTmrdumuySNPh
         pnVM1Q/NKekhakr9prrVHuRGn3J2A+eWfHIHxHkrx5XoNloUdkt8eYt5ZDEG9Njeh3rE
         bcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767269619; x=1767874419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYSYQ5jiWBTKPeAkBFI55cURVtS8dCeOtSoRxb6fDPY=;
        b=pGC2iObjfgpG46Nym7wahGiQCLChya45duOU5X8KnTAmtUl80ONb/+7Z/lLokGtExl
         7sbMON7l9K3HD3kEAgKcwC/XWIxBnHQVNjXjtdxhm5w+7IxBeoXY4Ao4ldUDUWDeuA5C
         Y+cPk/uE3/1w5SN4cU/S8ZoCYQz/GH+nSk1wBbWvNf4BvrvpdTio9hPMeSwJK6Z6pFJg
         lrjUww/Frrhl8FItbugrDXwlqF0jtGtmU1fF43ngkB4qlzifgjsVNMiml8v/hgEhupaW
         p5oGvNaNrXOUDg55SGXoozZdmZ9NY/8IFhvsy/1TeLiQ7Fo/hWPwhWTobtEWYLAeTWo7
         zjpw==
X-Forwarded-Encrypted: i=1; AJvYcCXbFaYhgUO7gIYwKU07HAiik1+MSbY2TKR2E0xKoC/tMZsgw5GuoK2lGAY42JQAfLBflXULd2NTJJwaul6xoIodyF+id/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1UIkePGW1VOsnZp5SJTWI8NwudI72rxDeuNIOOa+dZhIW/ZN
	xlaw4e6MkIKv2MAqB2Cuw6VyUCJzwU6eSLzMPqX4XL8B62uLkzmHRrFs
X-Gm-Gg: AY/fxX4Dc4lWgEWefZrivJQurV69zQ2O/2daP8ri7K2QfhOnEL1j9BPGCLXoTnb3fRb
	xrtbNg3EN3VIDbLlZl+dEb2A1xirfCmJN6hBMzxhSsi6SM27ngUCj5oi7C7hVTAHBAKQONedc1Z
	gl2zVahZVzOIwy9rSoXrqeg228lw4shJitNW4P1YDNH1BIA/iXPwcG6dtJjw1wTrcIevKDDt0Xf
	4Ujby3CJ+oW671s56GY6XV8r8QYkG9YvkLgO2bSvlwzs6wdSnsu1dM/auTbh3BDu7OrTr8/jGVP
	S2ON5GB8r+VQHoW/AoaI/ibU/g7gbCDpDWgjdU/RUpqcthVpR8Vx7GDjlYPvaUetaRDF1seBct0
	JGKEfYFXCOs1mDb8xaqKN4OQuRVwWefD0EABeBfvSVQ9P5PlYjiL8VjwRfABCazMqTIPlIpkI0v
	G5zk1oOGyztvEZ5D+YLHdMiK7nU1SHfjiQrB1t
X-Google-Smtp-Source: AGHT+IEA+7d+Le0QvTD4GE5Cpqvg95b6e5wI7qG/ls/oCYhqJAD+jFmLwVfPk9/Tl1oJiXP0XLihGw==
X-Received: by 2002:a17:907:7eaa:b0:b73:1e09:7377 with SMTP id a640c23a62f3a-b80371d6c10mr4513082466b.58.1767269619308;
        Thu, 01 Jan 2026 04:13:39 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80620c4520sm3669832066b.28.2026.01.01.04.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 04:13:39 -0800 (PST)
Date: Thu, 1 Jan 2026 13:13:37 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] lsm: Add hook unix_path_connect
Message-ID: <20260101.f6d0f71ca9bb@gnoack.org>
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <20251231213314.2979118-2-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251231213314.2979118-2-utilityemal77@gmail.com>

On Wed, Dec 31, 2025 at 04:33:14PM -0500, Justin Suess wrote:
> Adds an LSM hook unix_path_connect.
> 
> This hook is called to check the path of a named unix socket before a
> connection is initiated.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Cc: Günther Noack <gnoack3000@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  net/unix/af_unix.c            |  8 ++++++++
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 31 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8c42b4bde09c..a42d1aaf3b8a 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -318,6 +318,7 @@ LSM_HOOK(int, 0, watch_key, struct key *key)
>  #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> +LSM_HOOK(int, 0, unix_path_connect, const struct path *path)

You are placing this guarded by CONFIG_SECURITY_NETWORK, but there is
also CONFIG_SECURITY_PATH.  Should it be guarded by both?


>  LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
>  	 struct sock *newsk)
>  LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f..ab66f22f7e5a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1638,6 +1638,7 @@ static inline int security_watch_key(struct key *key)
>  
>  #ifdef CONFIG_SECURITY_NETWORK
>  
> +int security_unix_path_connect(const struct path *path);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
>  int security_unix_may_send(struct socket *sock,  struct socket *other);
> @@ -1699,6 +1700,11 @@ static inline int security_netlink_send(struct sock *sk, struct sk_buff *skb)
>  	return 0;
>  }
>  
> +static inline int security_unix_path_connect(const struct path *path)
> +{
> +	return 0;
> +}
> +
>  static inline int security_unix_stream_connect(struct sock *sock,
>  					       struct sock *other,
>  					       struct sock *newsk)
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 55cdebfa0da0..af1a6083a69b 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1226,6 +1226,14 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  	if (!S_ISSOCK(inode->i_mode))
>  		goto path_put;
>  
> +	/*
> +	 * We call the hook because we know that the inode is a socket
> +	 * and we hold a valid reference to it via the path.
> +	 */
> +	err = security_unix_path_connect(&path);
> +	if (err)
> +		goto path_put;

In this place, the hook call is done also for the coredump socket.

The coredump socket is a system-wide setting, and it feels weird to me
that unprivileged processes should be able to inhibit that connection?


> +
>  	sk = unix_find_socket_byinode(inode);
>  	if (!sk)
>  		goto path_put;
> diff --git a/security/security.c b/security/security.c
> index 31a688650601..17af5d0ddf28 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4047,6 +4047,22 @@ int security_unix_stream_connect(struct sock *sock, struct sock *other,
>  }
>  EXPORT_SYMBOL(security_unix_stream_connect);
>  
> +/*
> + * security_unix_path_connect() - Check if a named AF_UNIX socket can connect
> + * @path: Path of the socket being connected to
             ^
mega-nit: lowercase for consistency

> + *
> + * This hook is called to check permissions before connecting to a named
> + * AF_UNIX socket. This is necessary because it was not possible to check the
> + * VFS inode of the target socket before the connection is made.

I'd drop the last sentence; the defense why this is necessary can go
in the commit message, and once we have a call-site for the hook,
someone browsing the kernel code can look up what it is used for.

> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_unix_path_connect(const struct path *path)
> +{
> +	return call_int_hook(unix_path_connect, path);
> +}
> +EXPORT_SYMBOL(security_unix_path_connect);
> +
>  /**
>   * security_unix_may_send() - Check if AF_UNIX socket can send datagrams
>   * @sock: originating sock
> -- 
> 2.51.0
> 

Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC8281358
	for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768063507; cv=none; b=M50HrLV6jHhCvwg3RoyRJ1V3OBNStZGerTQ3RESRhUHnuK9mZLyt6J7zz+HImrFx0dp0+kQN99hzCw443db6v+rIaWqN6KQpmRPj428DMPM8968/w5ymsaOdgkE+ZspBP+EodAXrxybeIWjg8RPwJCAxA9oHOW1xbjuiKr7MQGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768063507; c=relaxed/simple;
	bh=0VM9KCmw1P39Wqs7XdZuxA4R85V6QsXgtikOUJooDZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpQ3GyT7MaBJjxukQb3jFdJaTsnME9GQhbqRGDN2Q2/Gk8mqrj9ANns2Iy2mG2QV+GbmQC5XP02eecxDboFRfOtXsqRT7/yDxKWgY4nEdbIZNA4+RiStZpF92ZLtravmCnogFTtaTYDAs4IdWNIdHBHZJAPjUiv/1TD6Fp6YXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMYQD8Ij; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMYQD8Ij"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64476c85854so5068148d50.0
        for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768063505; x=1768668305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZj8C+WJTqO5Fhdwh8WBBEtQntwBMgdeokvzPM/Bz9Q=;
        b=aMYQD8Ij3EhBALQrQ39dnqdwmF3xvb0Uv03I31sHy6td8Wq3+7s7/OD5mEOtuRboL2
         ETOPWS9EA7n9n4VbOkEZL3hx7yXIE+5CM2ShHjqRPpJU+R75vmhjlG5eXVj82yeeJiWd
         k+7c5Q6Ygb5o04ezzJ6DrB17wpa/Qj4Zcbm2sKW5HH/wFZ0lzqj2Zf4IpmOl8YkI+Xma
         unLidL6oNCXwoWsSMsXyp98q/EGj71eEe1dMVHrLYByqhRCs67vLTRK5ZmprhKTX/rVQ
         tgMnDJXzKKZFLDUR8Q0IJ9eW+s7wpDWgJTx21SUezwaxUkEicM+uazUpPxWmaS+iKjvT
         w0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768063505; x=1768668305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZj8C+WJTqO5Fhdwh8WBBEtQntwBMgdeokvzPM/Bz9Q=;
        b=c4OsTfMz2yKW+ibWeg8wzTREFylFJhBWwtgZjSp+hnrgaGgGgDOir5dhxPH4UkGhIH
         bXa5dXABOANDFWa2Ap8Adq5N1wKLc8nAZB84d3rKK0wZpmrllEaXTSR9kOIIstSqpSsN
         FXX+ILzAhQ+x/NuJRDVao9F0RxykgNKmtzZFDMqlGVnfDdv5JCn2O1IzWcG5VMfh93Gr
         uYp1TOoJPAabCcGU0cMQ4ZRBS2iQw3BvsFrwMrrpFPrsIT3KVrYSho92XGDwn6vi1AEv
         ZyNnYXi6+gauC+90yJxKnXzGf9gi4RCq17yP5G//7u2mWhOWR9eLGWsp+3DUMabdnisV
         R6aQ==
X-Gm-Message-State: AOJu0YyIMO86zgMZRVCPEdoJrN2OXXZPovMdlIP69i0nWznG8GR/WGgg
	+Z4sAemdZtNGjQUTis4XlHLm11SsWdDtfDmP0cXPb3z0xy8SI7hWAKad
X-Gm-Gg: AY/fxX7HwPXnOcGIj0pZCgGQ0FFl/xRVM+BwgKOT65288TorawEYWgscdxJKot8RZBL
	JqsbWpRKQOGHCy4nla5JQbH4CXHD44imT4mvbmuFsFP1DnHCeEC9HWBQxohws0HV3+isvzLGc3N
	rKF/9OLW14QDJ+tsfWxU7mw1SEn/JA49oLUpNG5yjYn13Pd3zsOdKaLVfrO6fO9loPMGtvh25iA
	tpkt9y5R2g5AZQyonSDysZxv3Pv4zEF1kQtfE+kChUw+uMy6+A9nzGHyTGJ8oZ17Bd0QpNS7dS+
	Gg3X2K53X/0RQ2ngXYTK4x/EYygR80CqHVGwbpl7oW25VO50IAOGZVEfPd2FTAwkYDnIN4y/YUI
	1fgsva6AVKVpaq/hAtUrjhX4+ukxbXICtEK5VCZirKV398IZCuEIL9gTfuqX8twxC3lX7uQm/AJ
	i9lp1mVU8TUe6S/r8heR+PZvMI2K1HnTcUsgihZVVU53Ybahi0CkyLdKgGK4JDdZd8f9ViXQ==
X-Google-Smtp-Source: AGHT+IHdumL/CyDmdrqvgMkE/IVyFzsfovyRmwWdV2GajUG6u0NQ9kSTf83jDhpg21DNJ0ulihZz3w==
X-Received: by 2002:a05:690c:7087:b0:78f:afbe:3e85 with SMTP id 00721157ae682-790b575834bmr261130877b3.24.1768063504921;
        Sat, 10 Jan 2026 08:45:04 -0800 (PST)
Received: from [10.10.10.50] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b2573sm5891322d50.21.2026.01.10.08.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 08:45:04 -0800 (PST)
Message-ID: <4bc22faa-2927-4ef9-b5dc-67a7575177e9@gmail.com>
Date: Sat, 10 Jan 2026 11:45:03 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] lsm: Add hook unix_path_connect
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>,
 Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
 Tahera Fahimi <fahimitahera@gmail.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260110143300.71048-4-gnoack3000@gmail.com>
Content-Language: en-US
From: Justin Suess <utilityemal77@gmail.com>
In-Reply-To: <20260110143300.71048-4-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/10/26 09:32, Günther Noack wrote:
> From: Justin Suess <utilityemal77@gmail.com>
>
> Adds an LSM hook unix_path_connect.
>
> This hook is called to check the path of a named unix socket before a
> connection is initiated.
>
> Cc: Günther Noack <gnoack3000@gmail.com>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  4 ++++
>  include/linux/security.h      | 11 +++++++++++
>  net/unix/af_unix.c            |  9 +++++++++
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 44 insertions(+)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8c42b4bde09c..1dee5d8d52d2 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -317,6 +317,10 @@ LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
>  LSM_HOOK(int, 0, watch_key, struct key *key)
>  #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +LSM_HOOK(int, 0, unix_path_connect, const struct path *path, int type, int flags)
> +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +
>  #ifdef CONFIG_SECURITY_NETWORK
>  LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
>  	 struct sock *newsk)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f..382612af27a6 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1931,6 +1931,17 @@ static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>  }
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +
> +int security_unix_path_connect(const struct path *path, int type, int flags);
> +
> +#else /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +static inline int security_unix_path_connect(const struct path *path, int type, int flags)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +
>  #ifdef CONFIG_SECURITY_INFINIBAND
>  int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey);
>  int security_ib_endport_manage_subnet(void *sec, const char *name, u8 port_num);
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 55cdebfa0da0..3aabe2d489ae 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1226,6 +1226,15 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  	if (!S_ISSOCK(inode->i_mode))
>  		goto path_put;
>  
> +	/*
> +	 * We call the hook because we know that the inode is a socket
> +	 * and we hold a valid reference to it via the path.
> +	 */
> +	err = security_unix_path_connect(&path, type, flags);
> +	if (err)
> +		goto path_put;
> +
> +	err = -ECONNREFUSED;
>  	sk = unix_find_socket_byinode(inode);
>  	if (!sk)
>  		goto path_put;
> diff --git a/security/security.c b/security/security.c
> index 31a688650601..0cee3502db83 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>  
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +/*
> + * security_unix_path_connect() - Check if a named AF_UNIX socket can connect
> + * @path: path of the socket being connected to
> + * @type: type of the socket
> + * @flags: flags associated with the socket
> + *
> + * This hook is called to check permissions before connecting to a named
> + * AF_UNIX socket.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_unix_path_connect(const struct path *path, int type, int flags)
> +{
> +	return call_int_hook(unix_path_connect, path, type, flags);
> +}
> +EXPORT_SYMBOL(security_unix_path_connect);
> +
> +#endif	/* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +
>  #ifdef CONFIG_SECURITY_INFINIBAND
>  /**
>   * security_ib_pkey_access() - Check if access to an IB pkey is allowed
Just for awareness,

I'm considering renaming this hook to unix_socket_path_lookup, since as Günther
pointed out this hook is not just hit on connect, but also on sendmsg.

Justin

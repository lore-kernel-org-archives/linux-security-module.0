Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA87C198E83
	for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694231; cv=none; b=fYmu/WbMdaRWVDp0zY7z9+6FbWDHmt8lklJbVgUa7mm1atDaLMiRYJKFA3/FL9Zw1nfLaiE+UFlJf5hw0C9de4P211Sk9U2Gy70ch8m8xZOtmr3xezV8PqMMT+H2HMfHcONxU36KcdOT6kiQ7PR+sR0bNJRL/uNfM3o68YTTkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694231; c=relaxed/simple;
	bh=GNgZdN9JfLem1l8C7PLyMfxHN/rbYHscVgrkOFj7ZWY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lJpRdS3AaAt5N/ROHho8qFbCNpL1k7jVJe1pmguk+lIlsfojArtWcpLwG0pEPFUkxs6+H675nKjpHH0UVgQkGn8NB4u48kAktMI3FLyymhi05l67Bge2uD+u5aXMLLW3/IHx2Z9c3+V2OQSfn+yc+EQJ0Hg5N8c6xLgkdraT7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rz5UkXEV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rz5UkXEV"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E7F013F453
	for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724694225;
	bh=OBNG5j/3CfORGD7VYnfgWZ/MQ3aEoSJcxjiGkjETZD4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=rz5UkXEVFiS91mY7jOEqJ00O+WhBEqfEQhJK2fKeLifhoZ5zqedBp1MQdz1QA5ckw
	 7kzuRaj/YN2s4Uxm9kKhgND8ofcNIwaYcUhm1j7z+ggYplccQezx0I0w5kPcPXykL4
	 /iSroxY3MiFinJhaTB4DUAI+GkV8fxerev5OeA2ffn4lCmtNh6jvgJ31C9QwWFSsUQ
	 DUXxh3fxykIo06wtgdh4kWgB8nr2Ns0ArHNxooLPJuWruvWeuuj1KMKtXDPSHmIo8U
	 8dsQc6CMYVKG9XX0LYy8rJhXj6G8QhHM22qJyG0cVL0nZEWwrNAx3jLtlOsBwqef05
	 zSSHxDqTyt9XA==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-201f27cdafcso42307045ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 10:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724694223; x=1725299023;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBNG5j/3CfORGD7VYnfgWZ/MQ3aEoSJcxjiGkjETZD4=;
        b=lfy+gPlra7ScIn5zWzMAKRSc0F4d+5KVNxwAx9STj2svHUU74Np2yKeXgnEdiIlQoI
         5jJuPIOLrNEhqFwnk4Z0BYugZrhGMw2oHSsVhlXVYjXKFWL7l4GLjX6MgdCkEoti/Lpu
         qyT02UAg5sceS15BNJAvaEAsOZ17Eyv6KhdffFHGF5pJkbuvqBfLh6MeiKSATLJ/xKgI
         lYMxLH8YckKJBojAGpCPoI175keWIPifjmeLvYVndDRqVHGtOQ4VxdeD96xbbI+CbQmZ
         9eXDkT2hWJPktrNR4E009B5BOsE8IHgxslthUON+dVveJF6tj8cNGjoPp7zR3JwtvW1o
         jaNA==
X-Forwarded-Encrypted: i=1; AJvYcCVUz4gxzdnSJhk+SxblKPOtYTQwNVcuc5gxcVIzBN1A+nKHjQBINGGJKbzGD9SWkeZ/MMnEONBzcDXl5djyEuNX1eKo35w=@vger.kernel.org
X-Gm-Message-State: AOJu0YySWCPq8cDedPk7dUOFKOdT0AMnJaV75yjG9igeFc0JWaEvvz1Q
	zhQdqCJ8ZMjkyCe4EgnHpTTSBJNzNSk526TPAnGoqR2Zj6Ln4WjClnF5M7TqALh7xBvJmCOq7GO
	8f7d+pQ5hJBr8k/DRi+MPItwhC7nm8p/ZK1ygWGziA22f/F0nimX9kF+eVdJPGYRze8LT1SpxnR
	xXsmGvDNv/gflu8w==
X-Received: by 2002:a17:903:1103:b0:1fb:8f72:d5ea with SMTP id d9443c01a7336-204df4d6c6bmr3074685ad.50.1724694223328;
        Mon, 26 Aug 2024 10:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn6t+69SXJuBs4cg96RisWBlc0ERPQf2fGnAfmknCkPGXCd2gEBRtcYncjPdR7Ct5naubm8A==
X-Received: by 2002:a17:903:1103:b0:1fb:8f72:d5ea with SMTP id d9443c01a7336-204df4d6c6bmr3074335ad.50.1724694222904;
        Mon, 26 Aug 2024 10:43:42 -0700 (PDT)
Received: from ?IPv6:2001:1284:f502:1ed0:dd4a:fefa:915f:4c09? ([2001:1284:f502:1ed0:dd4a:fefa:915f:4c09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdb575sm6830026a12.41.2024.08.26.10.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:43:41 -0700 (PDT)
Message-ID: <dbd5431588de920097637e25b66ea5481675cd47.camel@canonical.com>
Subject: Re: [PATCH 03/13] LSM: Add lsmblob_to_secctx hook
From: Georgia Garcia <georgia.garcia@canonical.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com, 
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 mic@digikod.net
Date: Mon, 26 Aug 2024 14:43:36 -0300
In-Reply-To: <20240825190048.13289-4-casey@schaufler-ca.com>
References: <20240825190048.13289-1-casey@schaufler-ca.com>
	 <20240825190048.13289-4-casey@schaufler-ca.com>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Casey

On Sun, 2024-08-25 at 12:00 -0700, Casey Schaufler wrote:
> Add a new hook security_lsmblob_to_secctx() and its LSM specific
> implementations. The LSM specific code will use the lsmblob element
> allocated for that module. This allows for the possibility that more
> than one module may be called upon to translate a secid to a string,
> as can occur in the audit code.
>=20
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hook_defs.h     |  2 ++
>  include/linux/security.h          | 11 +++++++++-
>  security/apparmor/include/secid.h |  2 ++
>  security/apparmor/lsm.c           |  1 +
>  security/apparmor/secid.c         | 36 +++++++++++++++++++++++++++++++
>  security/security.c               | 30 ++++++++++++++++++++++++++
>  security/selinux/hooks.c          | 16 ++++++++++++--
>  security/smack/smack_lsm.c        | 31 +++++++++++++++++++++-----
>  8 files changed, 121 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 1d3bdf71109e..3e5f6baa7b9f 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -291,6 +291,8 @@ LSM_HOOK(int, -EINVAL, setprocattr, const char *name,=
 void *value, size_t size)
>  LSM_HOOK(int, 0, ismaclabel, const char *name)
>  LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
>  	 u32 *seclen)
> +LSM_HOOK(int, -EOPNOTSUPP, lsmblob_to_secctx, struct lsmblob *blob,
> +	 char **secdata, u32 *seclen)
>  LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *=
secid)
>  LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
>  LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inod=
e)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c0ed2119a622..457fafc32fb0 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -520,6 +520,8 @@ int security_setprocattr(int lsmid, const char *name,=
 void *value, size_t size);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> +int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
> +			       u32 *seclen);
>  int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid=
);
>  void security_release_secctx(char *secdata, u32 seclen);
>  void security_inode_invalidate_secctx(struct inode *inode);
> @@ -1461,7 +1463,14 @@ static inline int security_ismaclabel(const char *=
name)
>  	return 0;
>  }
> =20
> -static inline int security_secid_to_secctx(u32 secid, char **secdata, u3=
2 *seclen)
> +static inline int security_secid_to_secctx(u32 secid, char **secdata,
> +					   u32 *seclen)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int security_lsmblob_to_secctx(struct lsmblob *blob,
> +					     char **secdata, u32 *seclen)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/security/apparmor/include/secid.h b/security/apparmor/includ=
e/secid.h
> index a912a5d5d04f..816a425e2023 100644
> --- a/security/apparmor/include/secid.h
> +++ b/security/apparmor/include/secid.h
> @@ -26,6 +26,8 @@ extern int apparmor_display_secid_mode;
> =20
>  struct aa_label *aa_secid_to_label(u32 secid);
>  int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> +int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
> +			       u32 *seclen);
>  int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid=
);
>  void apparmor_release_secctx(char *secdata, u32 seclen);
> =20
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 808060f9effb..050d103f5ca5 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1532,6 +1532,7 @@ static struct security_hook_list apparmor_hooks[] _=
_ro_after_init =3D {
>  #endif
> =20
>  	LSM_HOOK_INIT(secid_to_secctx, apparmor_secid_to_secctx),
> +	LSM_HOOK_INIT(lsmblob_to_secctx, apparmor_lsmblob_to_secctx),
>  	LSM_HOOK_INIT(secctx_to_secid, apparmor_secctx_to_secid),
>  	LSM_HOOK_INIT(release_secctx, apparmor_release_secctx),
> =20
> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> index 83d3d1e6d9dc..3c389e5810cd 100644
> --- a/security/apparmor/secid.c
> +++ b/security/apparmor/secid.c
> @@ -90,6 +90,42 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata=
, u32 *seclen)
>  	return 0;
>  }
> =20
> +int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
> +			       u32 *seclen)
> +{
> +	/* TODO: cache secctx and ref count so we don't have to recreate */
> +	struct aa_label *label;
> +	int flags =3D FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED | FLAG_ABS_ROOT;
> +	int len;
> +
> +	AA_BUG(!seclen);
> +
> +	/* scaffolding */
> +	if (!blob->apparmor.label && blob->scaffold.secid)
> +		label =3D aa_secid_to_label(blob->scaffold.secid);
> +	else
> +		label =3D blob->apparmor.label;
> +

It would improve maintainability if the rest of the function was
refactored into label_to_secctx(...), for example, so it could be
shared by apparmor_secid_to_secctx and apparmor_lsmblob_to_secctx.

> +	if (!label)
> +		return -EINVAL;
> +
> +	if (apparmor_display_secid_mode)
> +		flags |=3D FLAG_SHOW_MODE;
> +
> +	if (secdata)
> +		len =3D aa_label_asxprint(secdata, root_ns, label,
> +					flags, GFP_ATOMIC);
> +	else
> +		len =3D aa_label_snxprint(NULL, 0, root_ns, label, flags);
> +
> +	if (len < 0)
> +		return -ENOMEM;
> +
> +	*seclen =3D len;
> +
> +	return 0;
> +}
> +
>  int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid=
)
>  {
>  	struct aa_label *label;
> diff --git a/security/security.c b/security/security.c
> index 64a6d6bbd1f4..bb541a3be410 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4192,6 +4192,36 @@ int security_secid_to_secctx(u32 secid, char **sec=
data, u32 *seclen)
>  }
>  EXPORT_SYMBOL(security_secid_to_secctx);
> =20
> +/**
> + * security_lsmblob_to_secctx() - Convert a lsmblob to a secctx
> + * @blob: lsm specific information
> + * @secdata: secctx
> + * @seclen: secctx length
> + *
> + * Convert a @blob entry to security context.  If @secdata is NULL the
> + * length of the result will be returned in @seclen, but no @secdata
> + * will be returned.  This does mean that the length could change betwee=
n
> + * calls to check the length and the next call which actually allocates
> + * and returns the @secdata.
> + *
> + * Return: Return 0 on success, error on failure.
> + */
> +int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
> +			       u32 *seclen)
> +{
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
> +		rc =3D hp->hook.lsmblob_to_secctx(blob, secdata, seclen);
> +		if (rc !=3D LSM_RET_DEFAULT(secid_to_secctx))
> +			return rc;
> +	}
> +
> +	return LSM_RET_DEFAULT(secid_to_secctx);
> +}
> +EXPORT_SYMBOL(security_lsmblob_to_secctx);
> +
>  /**
>   * security_secctx_to_secid() - Convert a secctx to a secid
>   * @secdata: secctx
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 55c78c318ccd..102489e6d579 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6610,8 +6610,19 @@ static int selinux_ismaclabel(const char *name)
> =20
>  static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *secle=
n)
>  {
> -	return security_sid_to_context(secid,
> -				       secdata, seclen);
> +	return security_sid_to_context(secid, secdata, seclen);
> +}
> +
> +static int selinux_lsmblob_to_secctx(struct lsmblob *blob, char **secdat=
a,
> +				     u32 *seclen)
> +{
> +	u32 secid =3D blob->selinux.secid;
> +
> +	/* scaffolding */
> +	if (!secid)
> +		secid =3D blob->scaffold.secid;
> +
> +	return security_sid_to_context(secid, secdata, seclen);
>  }
> =20
>  static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 =
*secid)
> @@ -7388,6 +7399,7 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>  	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
>  	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
>  	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
> +	LSM_HOOK_INIT(lsmblob_to_secctx, selinux_lsmblob_to_secctx),
>  	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
>  	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
>  	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 52d5ef986db8..5d74d8590862 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4787,7 +4787,7 @@ static int smack_audit_rule_known(struct audit_krul=
e *krule)
>  static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 o=
p,
>  				  void *vrule)
>  {
> -	struct smack_known *skp;
> +	struct smack_known *skp =3D blob->smack.skp;
>  	char *rule =3D vrule;
> =20
>  	if (unlikely(!rule)) {
> @@ -4799,10 +4799,8 @@ static int smack_audit_rule_match(struct lsmblob *=
blob, u32 field, u32 op,
>  		return 0;
> =20
>  	/* scaffolding */
> -	if (!blob->smack.skp && blob->scaffold.secid)
> +	if (!skp && blob->scaffold.secid)
>  		skp =3D smack_from_secid(blob->scaffold.secid);
> -	else
> -		skp =3D blob->smack.skp;
> =20
>  	/*
>  	 * No need to do string comparisons. If a match occurs,
> @@ -4833,7 +4831,6 @@ static int smack_ismaclabel(const char *name)
>  	return (strcmp(name, XATTR_SMACK_SUFFIX) =3D=3D 0);
>  }
> =20
> -
>  /**
>   * smack_secid_to_secctx - return the smack label for a secid
>   * @secid: incoming integer
> @@ -4852,6 +4849,29 @@ static int smack_secid_to_secctx(u32 secid, char *=
*secdata, u32 *seclen)
>  	return 0;
>  }
> =20
> +/**
> + * smack_lsmblob_to_secctx - return the smack label
> + * @blob: includes incoming Smack data
> + * @secdata: destination
> + * @seclen: how long it is
> + *
> + * Exists for audit code.
> + */
> +static int smack_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
> +				   u32 *seclen)
> +{
> +	struct smack_known *skp =3D blob->smack.skp;
> +
> +	/* scaffolding */
> +	if (!skp && blob->scaffold.secid)
> +		skp =3D smack_from_secid(blob->scaffold.secid);
> +
> +	if (secdata)
> +		*secdata =3D skp->smk_known;
> +	*seclen =3D strlen(skp->smk_known);
> +	return 0;
> +}
> +
>  /**
>   * smack_secctx_to_secid - return the secid for a smack label
>   * @secdata: smack label
> @@ -5208,6 +5228,7 @@ static struct security_hook_list smack_hooks[] __ro=
_after_init =3D {
> =20
>  	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
>  	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
> +	LSM_HOOK_INIT(lsmblob_to_secctx, smack_lsmblob_to_secctx),
>  	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
>  	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
>  	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),


Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840D44C8C
	for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769976; cv=none; b=WgsPyL05aAEa/l0IEnlifXxSeUcPMBdmQUePnfHrjrkEZRVmUkTplO1Qp3LHoF3gqcOLxHdmjS6OtL89gTZojm2LAYEJ6IvFiLx6GvIUQGQHLuoaoJnO6cT1XBAdLwjxTn0Hc0uPj4hCHW3Par8eKfbxpmfqe4Mt4+e0hU1Bt8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769976; c=relaxed/simple;
	bh=QEzOVa1CIVcycCoY61qIk7T/o1kYBm4X5t9et8LzqsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tp3mYP0xiUVOxJfK3lMvNzHW/ncl+gVF6hjR1QSd6JY0ztl6F0WIxCxoQsWgWhcn0kMTUi71yNfAQKAYRpw0tqphKkDgPjblTxkliGCA0SZstiGCXxE7tXVsoPGoJ3KWJ+YmbKjdT/rcLQHfPKle72667/hw2XCii8LqWkeLjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XgiIoS95; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XgiIoS95"
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E09B53F2F2
	for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724769965;
	bh=9p9W+Dmy/iAHBg8XLvhdQjQp1CiC1ztA8nycLKhuwJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=XgiIoS95RdDKXrWQCAwfJVxW6w5khlctzz0XDofNjm+Er29jcONv/bdEpgx2mB6rp
	 Yp8avlahbuj6Qu0/G9t1H+SwxSnJcIfKDWrMsxC16gc57mybs/G6VcYzdGQNXyC56S
	 P1qbEWiCCRbQvTUmT5S+T2y/GM47EJDWlF0g/zwn4pD/S3gI3Xx13Tl7VyROahiU43
	 0UTQ+PTxSm7+odJ4/Z3hn3TaPQRdOum94jl14LwO9AedmqOtk0Wl4FPT1lzOLj1irK
	 U7mmedlK0y0cM1yOLFkJfkkozsDEsJmc+kunE/nIhcRDoKp5L5bQ6qUF3uQxOQAR5s
	 ALXuVBBo++0iw==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7125fb17a83so3710333b3a.3
        for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 07:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769963; x=1725374763;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9p9W+Dmy/iAHBg8XLvhdQjQp1CiC1ztA8nycLKhuwJE=;
        b=FzIKQ0vroTRsXLgtAzQj3roiVw6PNZg1fqFAYTkfCaOqZ0lvMs/e8RZHPzsvmnaq/V
         9wnMG/pthMAkcQPErWpoaMUnX/St85KpzRh1RIXy8fVvvAj4/8Ji44E8vFxWulTpDkPM
         Xymi9mG8nV7HTCyhyLUFmFgcEICxAdupnP1k8s6Rm3PKaCUucmwPeeIjtCxGBMjW3FU+
         HI6Gg9AEwMrUvKZzYokn5MxPgyjLQL5yb4tj0jVGitNQh1qQifSbwH/LsdAUR2damb1B
         RgC9hhS2TBQRtEHdMmoz8Q/foyaTD0E/TRxMXoneH9XDJPGjWJ4CDpCfi3hGrpOkFBxi
         IznQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0J3/AL3/SacIe+gS6UxOGRi0yu+/wuXfgxKlSYG8pM5PiHi5l8pA5WYrtNUx7sh0YOfWUSVdtbfDsE7FqwWfamSw0wlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL829CEoW5toj4sJc+L8q6pl58YXZWzhK6Ga3mEUBQJelb0wTe
	CB/g/VbZ3Anh0dDSJuF6QiD3EZCJPeW9J9lzZzobzqbgieBUCgUj9iFsmvtBGEVtVe69YLPKo1v
	hXoRIk6P8JSbgtvmhptJav6Hjb0hm7mtpy66o5nHuE5+3GG3uxyj3v62l0adzSeK2j/3WWXrM/P
	PwveCZWxGB1ZIhTA==
X-Received: by 2002:a05:6a00:2d14:b0:713:f127:ad5c with SMTP id d2e1a72fcca58-71445e7852emr14662277b3a.28.1724769963227;
        Tue, 27 Aug 2024 07:46:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/LWjdqfYex38+L8s7uu1JsFZLRR4KTY0U+g0zeLNcZZA033T4DFklPxHiNj6vYqH4CIgqmw==
X-Received: by 2002:a05:6a00:2d14:b0:713:f127:ad5c with SMTP id d2e1a72fcca58-71445e7852emr14662246b3a.28.1724769962715;
        Tue, 27 Aug 2024 07:46:02 -0700 (PDT)
Received: from ?IPv6:2001:1284:f502:1ed0:3614:22f:7b0b:19c1? ([2001:1284:f502:1ed0:3614:22f:7b0b:19c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342732b5sm8885570b3a.92.2024.08.27.07.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:46:02 -0700 (PDT)
Message-ID: <4ea89fdba649142dcebc05e115d6e5aefb7f9430.camel@canonical.com>
Subject: Re: [PATCH 03/13] LSM: Add lsmblob_to_secctx hook
From: Georgia Garcia <georgia.garcia@canonical.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com, 
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 mic@digikod.net
Date: Tue, 27 Aug 2024 11:45:57 -0300
In-Reply-To: <a0f4bdcb-dc21-4255-abbe-9f557046e7f7@schaufler-ca.com>
References: <20240825190048.13289-1-casey@schaufler-ca.com>
	 <20240825190048.13289-4-casey@schaufler-ca.com>
	 <dbd5431588de920097637e25b66ea5481675cd47.camel@canonical.com>
	 <a0f4bdcb-dc21-4255-abbe-9f557046e7f7@schaufler-ca.com>
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

On Mon, 2024-08-26 at 11:45 -0700, Casey Schaufler wrote:
> On 8/26/2024 10:43 AM, Georgia Garcia wrote:
> > Hi Casey
> >=20
> > On Sun, 2024-08-25 at 12:00 -0700, Casey Schaufler wrote:
> > > Add a new hook security_lsmblob_to_secctx() and its LSM specific
> > > implementations. The LSM specific code will use the lsmblob element
> > > allocated for that module. This allows for the possibility that more
> > > than one module may be called upon to translate a secid to a string,
> > > as can occur in the audit code.
> > >=20
> > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h     |  2 ++
> > >  include/linux/security.h          | 11 +++++++++-
> > >  security/apparmor/include/secid.h |  2 ++
> > >  security/apparmor/lsm.c           |  1 +
> > >  security/apparmor/secid.c         | 36 +++++++++++++++++++++++++++++=
++
> > >  security/security.c               | 30 ++++++++++++++++++++++++++
> > >  security/selinux/hooks.c          | 16 ++++++++++++--
> > >  security/smack/smack_lsm.c        | 31 +++++++++++++++++++++-----
> > >  8 files changed, 121 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_d=
efs.h
> > > index 1d3bdf71109e..3e5f6baa7b9f 100644
> > > --- a/include/linux/lsm_hook_defs.h
> > > +++ b/include/linux/lsm_hook_defs.h
> > > @@ -291,6 +291,8 @@ LSM_HOOK(int, -EINVAL, setprocattr, const char *n=
ame, void *value, size_t size)
> > >  LSM_HOOK(int, 0, ismaclabel, const char *name)
> > >  LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdat=
a,
> > >  	 u32 *seclen)
> > > +LSM_HOOK(int, -EOPNOTSUPP, lsmblob_to_secctx, struct lsmblob *blob,
> > > +	 char **secdata, u32 *seclen)
> > >  LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u=
32 *secid)
> > >  LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 secl=
en)
> > >  LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *=
inode)
> > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > index c0ed2119a622..457fafc32fb0 100644
> > > --- a/include/linux/security.h
> > > +++ b/include/linux/security.h
> > > @@ -520,6 +520,8 @@ int security_setprocattr(int lsmid, const char *n=
ame, void *value, size_t size);
> > >  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
> > >  int security_ismaclabel(const char *name);
> > >  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)=
;
> > > +int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
> > > +			       u32 *seclen);
> > >  int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *s=
ecid);
> > >  void security_release_secctx(char *secdata, u32 seclen);
> > >  void security_inode_invalidate_secctx(struct inode *inode);
> > > @@ -1461,7 +1463,14 @@ static inline int security_ismaclabel(const ch=
ar *name)
> > >  	return 0;
> > >  }
> > > =20
> > > -static inline int security_secid_to_secctx(u32 secid, char **secdata=
, u32 *seclen)
> > > +static inline int security_secid_to_secctx(u32 secid, char **secdata=
,
> > > +					   u32 *seclen)
> > > +{
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +
> > > +static inline int security_lsmblob_to_secctx(struct lsmblob *blob,
> > > +					     char **secdata, u32 *seclen)
> > >  {
> > >  	return -EOPNOTSUPP;
> > >  }
> > > diff --git a/security/apparmor/include/secid.h b/security/apparmor/in=
clude/secid.h
> > > index a912a5d5d04f..816a425e2023 100644
> > > --- a/security/apparmor/include/secid.h
> > > +++ b/security/apparmor/include/secid.h
> > > @@ -26,6 +26,8 @@ extern int apparmor_display_secid_mode;
> > > =20
> > >  struct aa_label *aa_secid_to_label(u32 secid);
> > >  int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)=
;
> > > +int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
> > > +			       u32 *seclen);
> > >  int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *s=
ecid);
> > >  void apparmor_release_secctx(char *secdata, u32 seclen);
> > > =20
> > > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > > index 808060f9effb..050d103f5ca5 100644
> > > --- a/security/apparmor/lsm.c
> > > +++ b/security/apparmor/lsm.c
> > > @@ -1532,6 +1532,7 @@ static struct security_hook_list apparmor_hooks=
[] __ro_after_init =3D {
> > >  #endif
> > > =20
> > >  	LSM_HOOK_INIT(secid_to_secctx, apparmor_secid_to_secctx),
> > > +	LSM_HOOK_INIT(lsmblob_to_secctx, apparmor_lsmblob_to_secctx),
> > >  	LSM_HOOK_INIT(secctx_to_secid, apparmor_secctx_to_secid),
> > >  	LSM_HOOK_INIT(release_secctx, apparmor_release_secctx),
> > > =20
> > > diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> > > index 83d3d1e6d9dc..3c389e5810cd 100644
> > > --- a/security/apparmor/secid.c
> > > +++ b/security/apparmor/secid.c
> > > @@ -90,6 +90,42 @@ int apparmor_secid_to_secctx(u32 secid, char **sec=
data, u32 *seclen)
> > >  	return 0;
> > >  }
> > > =20
> > > +int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
> > > +			       u32 *seclen)
> > > +{
> > > +	/* TODO: cache secctx and ref count so we don't have to recreate */
> > > +	struct aa_label *label;
> > > +	int flags =3D FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED | FLAG_ABS_R=
OOT;
> > > +	int len;
> > > +
> > > +	AA_BUG(!seclen);
> > > +
> > > +	/* scaffolding */
> > > +	if (!blob->apparmor.label && blob->scaffold.secid)
> > > +		label =3D aa_secid_to_label(blob->scaffold.secid);
> > > +	else
> > > +		label =3D blob->apparmor.label;
> > > +
> > It would improve maintainability if the rest of the function was
> > refactored into label_to_secctx(...), for example, so it could be
> > shared by apparmor_secid_to_secctx and apparmor_lsmblob_to_secctx.
>=20
> All uses of scaffold.secid disappear by patch 13/13 of this set.
> This code, being temporary and short lived, would not benefit much
> from being maintainable.

I was referring to the rest of the function which does not include the
scaffolding and remains duplicated by the end of the patch set.
From this section:

> >=20
> > > +	if (!label)
> > > +		return -EINVAL;
> > > +
> > > +	if (apparmor_display_secid_mode)
> > > +		flags |=3D FLAG_SHOW_MODE;
> > > +
> > > +	if (secdata)
> > > +		len =3D aa_label_asxprint(secdata, root_ns, label,
> > > +					flags, GFP_ATOMIC);
> > > +	else
> > > +		len =3D aa_label_snxprint(NULL, 0, root_ns, label, flags);
> > > +
> > > +	if (len < 0)
> > > +		return -ENOMEM;
> > > +
> > > +	*seclen =3D len;
> > > +
> > > +	return 0;
> > > +}

To here.

> > > +
> > >  int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *s=
ecid)
> > >  {
> > >  	struct aa_label *label;
> > > diff --git a/security/security.c b/security/security.c
> > > index 64a6d6bbd1f4..bb541a3be410 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -4192,6 +4192,36 @@ int security_secid_to_secctx(u32 secid, char *=
*secdata, u32 *seclen)
> > >  }
> > >  EXPORT_SYMBOL(security_secid_to_secctx);
> > > =20
> > > +/**
> > > + * security_lsmblob_to_secctx() - Convert a lsmblob to a secctx
> > > + * @blob: lsm specific information
> > > + * @secdata: secctx
> > > + * @seclen: secctx length
> > > + *
> > > + * Convert a @blob entry to security context.  If @secdata is NULL t=
he
> > > + * length of the result will be returned in @seclen, but no @secdata
> > > + * will be returned.  This does mean that the length could change be=
tween
> > > + * calls to check the length and the next call which actually alloca=
tes
> > > + * and returns the @secdata.
> > > + *
> > > + * Return: Return 0 on success, error on failure.
> > > + */
> > > +int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
> > > +			       u32 *seclen)
> > > +{
> > > +	struct security_hook_list *hp;
> > > +	int rc;
> > > +
> > > +	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list=
) {
> > > +		rc =3D hp->hook.lsmblob_to_secctx(blob, secdata, seclen);
> > > +		if (rc !=3D LSM_RET_DEFAULT(secid_to_secctx))
> > > +			return rc;
> > > +	}
> > > +
> > > +	return LSM_RET_DEFAULT(secid_to_secctx);
> > > +}
> > > +EXPORT_SYMBOL(security_lsmblob_to_secctx);
> > > +
> > >  /**
> > >   * security_secctx_to_secid() - Convert a secctx to a secid
> > >   * @secdata: secctx
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 55c78c318ccd..102489e6d579 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -6610,8 +6610,19 @@ static int selinux_ismaclabel(const char *name=
)
> > > =20
> > >  static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *s=
eclen)
> > >  {
> > > -	return security_sid_to_context(secid,
> > > -				       secdata, seclen);
> > > +	return security_sid_to_context(secid, secdata, seclen);
> > > +}
> > > +
> > > +static int selinux_lsmblob_to_secctx(struct lsmblob *blob, char **se=
cdata,
> > > +				     u32 *seclen)
> > > +{
> > > +	u32 secid =3D blob->selinux.secid;
> > > +
> > > +	/* scaffolding */
> > > +	if (!secid)
> > > +		secid =3D blob->scaffold.secid;
> > > +
> > > +	return security_sid_to_context(secid, secdata, seclen);
> > >  }
> > > =20
> > >  static int selinux_secctx_to_secid(const char *secdata, u32 seclen, =
u32 *secid)
> > > @@ -7388,6 +7399,7 @@ static struct security_hook_list selinux_hooks[=
] __ro_after_init =3D {
> > >  	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
> > >  	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
> > >  	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
> > > +	LSM_HOOK_INIT(lsmblob_to_secctx, selinux_lsmblob_to_secctx),
> > >  	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
> > >  	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
> > >  	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_securit=
y),
> > > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > > index 52d5ef986db8..5d74d8590862 100644
> > > --- a/security/smack/smack_lsm.c
> > > +++ b/security/smack/smack_lsm.c
> > > @@ -4787,7 +4787,7 @@ static int smack_audit_rule_known(struct audit_=
krule *krule)
> > >  static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u=
32 op,
> > >  				  void *vrule)
> > >  {
> > > -	struct smack_known *skp;
> > > +	struct smack_known *skp =3D blob->smack.skp;
> > >  	char *rule =3D vrule;
> > > =20
> > >  	if (unlikely(!rule)) {
> > > @@ -4799,10 +4799,8 @@ static int smack_audit_rule_match(struct lsmbl=
ob *blob, u32 field, u32 op,
> > >  		return 0;
> > > =20
> > >  	/* scaffolding */
> > > -	if (!blob->smack.skp && blob->scaffold.secid)
> > > +	if (!skp && blob->scaffold.secid)
> > >  		skp =3D smack_from_secid(blob->scaffold.secid);
> > > -	else
> > > -		skp =3D blob->smack.skp;
> > > =20
> > >  	/*
> > >  	 * No need to do string comparisons. If a match occurs,
> > > @@ -4833,7 +4831,6 @@ static int smack_ismaclabel(const char *name)
> > >  	return (strcmp(name, XATTR_SMACK_SUFFIX) =3D=3D 0);
> > >  }
> > > =20
> > > -
> > >  /**
> > >   * smack_secid_to_secctx - return the smack label for a secid
> > >   * @secid: incoming integer
> > > @@ -4852,6 +4849,29 @@ static int smack_secid_to_secctx(u32 secid, ch=
ar **secdata, u32 *seclen)
> > >  	return 0;
> > >  }
> > > =20
> > > +/**
> > > + * smack_lsmblob_to_secctx - return the smack label
> > > + * @blob: includes incoming Smack data
> > > + * @secdata: destination
> > > + * @seclen: how long it is
> > > + *
> > > + * Exists for audit code.
> > > + */
> > > +static int smack_lsmblob_to_secctx(struct lsmblob *blob, char **secd=
ata,
> > > +				   u32 *seclen)
> > > +{
> > > +	struct smack_known *skp =3D blob->smack.skp;
> > > +
> > > +	/* scaffolding */
> > > +	if (!skp && blob->scaffold.secid)
> > > +		skp =3D smack_from_secid(blob->scaffold.secid);
> > > +
> > > +	if (secdata)
> > > +		*secdata =3D skp->smk_known;
> > > +	*seclen =3D strlen(skp->smk_known);
> > > +	return 0;
> > > +}
> > > +
> > >  /**
> > >   * smack_secctx_to_secid - return the secid for a smack label
> > >   * @secdata: smack label
> > > @@ -5208,6 +5228,7 @@ static struct security_hook_list smack_hooks[] =
__ro_after_init =3D {
> > > =20
> > >  	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
> > >  	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
> > > +	LSM_HOOK_INIT(lsmblob_to_secctx, smack_lsmblob_to_secctx),
> > >  	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
> > >  	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
> > >  	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),


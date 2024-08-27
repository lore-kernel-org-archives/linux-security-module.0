Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C07C1C6F5F
	for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770931; cv=none; b=SHRb810y2lVAU+ejPy7H45beLtKPG021w1QNkyJwepR85xNVt9LK5zBBCt5xo8MLItTFGHRip2Pw5yX0of1HL4LkrG0slsNbC9zv0Sc4usXQxpAMfmUkn3Z3ICYeefpxHstfpwvEUjAJKlecToXae8idfqxOt9p22s6oHaUbdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770931; c=relaxed/simple;
	bh=IFJgwMMBQAepiR9Zi+ANoAhwQDy/WXTKO+hYFcxwYqM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOdFt9u7+mKZZpwM3hWcvncSIE7QWV6+ExEIPmMfGeJscne+YyFk0uuU27ZCD9cAJPN0XyP9Zd6QiMth9ctUSDc/SwJFt7CS/vFjSna708ZxZPHGAGLafdVFbZV8zycxOPDGKnrmggWutuyJMC/MHdn35IqK5yzN7FoylhKoDt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jpXYuCEa; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jpXYuCEa"
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9EA9D3F4C6
	for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724770927;
	bh=2P+kxQuaxtYEyNIEJy9bWFJkdnavlhUTk0CuwFAwO4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=jpXYuCEaAkbCWCsKXUWYaERh0jugBpkoNsynBu9Kf0eea2OIJbCF3oPG+N3FXQdVG
	 IGwR7XfPaUoTG9LVMrLK6GDQeUl9TV/LzGlrnMAjAQArJiM1/6fvbFtPsG5hoAKM5N
	 IhYZZPoXZ3vVqXhUvHRHXNanESr2XGXecdHi0ze+u3QO+BDhk8HAnsXO/emikj9dKn
	 4BF14D8Rqz8DAUoAfoPIJ4OswzxvwFdNSJw4ssFhHOxZt1xpppfha/aMD6Wo0SJFc1
	 aU91c4QYtW+jbWsL38FFt8NpblJqiL3be1/AkHpNsXqboNuabUOL1Z2NsLyKgoGL8z
	 v3xmfqim0FlAQ==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70eebcab33aso5184724b3a.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 08:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770925; x=1725375725;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2P+kxQuaxtYEyNIEJy9bWFJkdnavlhUTk0CuwFAwO4w=;
        b=M21t/slxdmw2TbsTB5ArJL3yCvhldBeryqk9Dbi7aW9RrMSLzcYkGuESDRsWuCkOvj
         Ae7+7A5RSvjLJYoVWp8VkVmh+UZHCACYEeE/oOIGpDItt0RGFCMznz6eAQF7b0LUpkwZ
         uEBSHuhuUbTqJVH+5fzXF1fCH9CUc1HE+vNdqPnAVTnTWo3ir4VyRZM2kaFQmdTF2CDC
         w0TR7xqVfyDa6eoukTF5VTMqHPQb+eo32DlHVX0BVdfrczJa/QdPXRX3O6lQQaIgDe4y
         USGU131N2NjSNOUGjVlMuhcCic5usuIMkEsRMVvtGqS0MVBkRSGdgr6YDzg0rtlglUk5
         FhcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJRrBGHsLIh/an9PGBLjBUjJWvgjJDbis1qibUnjS9JRc4mvQGOIMzECViC/9oe/fG6OA57AROufNj9ZqeF0RlEUDPuYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQ3sO+4vS4HDx0bJpanR5bGoK1yNKT1MekZMXq5BRPfeEBREI
	nzjrn8mrBY8yvHPM1odw/S4Ull9//OMmV+alGCo9m4lz6Hdm39yLWZsORIIr5qjHEGgXuKo3crZ
	NJIk9NJw8k2DTM58Hi5EYRNaqmN9J4/BBF8O/OXRxnl0ETIKXRFQwRo2HiqruuGCsL3AWokXvLg
	xEU4zG9BnILiS/LA==
X-Received: by 2002:a05:6a00:1ad1:b0:70d:33b3:2d7f with SMTP id d2e1a72fcca58-714458938c8mr16205127b3a.26.1724770925420;
        Tue, 27 Aug 2024 08:02:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI8lTF1ZBJUDeALtcEVWbx6fWOzsswhP6jDP8l7b2/0KT1Mh1E2vOICYN29ZeYQNn5ju5YlA==
X-Received: by 2002:a05:6a00:1ad1:b0:70d:33b3:2d7f with SMTP id d2e1a72fcca58-714458938c8mr16205091b3a.26.1724770924997;
        Tue, 27 Aug 2024 08:02:04 -0700 (PDT)
Received: from ?IPv6:2001:1284:f502:1ed0:3614:22f:7b0b:19c1? ([2001:1284:f502:1ed0:3614:22f:7b0b:19c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430020fsm8984983b3a.146.2024.08.27.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:02:04 -0700 (PDT)
Message-ID: <a8aeacdc4afec5855fa4b80f0f5f43e8f7d3b5cb.camel@canonical.com>
Subject: Re: [PATCH 04/13] Audit: maintain an lsmblob in audit_context
From: Georgia Garcia <georgia.garcia@canonical.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com, 
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 mic@digikod.net
Date: Tue, 27 Aug 2024 12:01:58 -0300
In-Reply-To: <20240825190048.13289-5-casey@schaufler-ca.com>
References: <20240825190048.13289-1-casey@schaufler-ca.com>
	 <20240825190048.13289-5-casey@schaufler-ca.com>
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

On Sun, 2024-08-25 at 12:00 -0700, Casey Schaufler wrote:
> Replace the secid value stored in struct audit_context with a struct
> lsmblob. Change the code that uses this value to accommodate the
> change. security_audit_rule_match() expects a lsmblob, so existing
> scaffolding can be removed. A call to security_secid_to_secctx()
> is changed to security_lsmblob_to_secctx().  The call to
> security_ipc_getsecid() is scaffolded.
>=20
> A new function lsmblob_is_set() is introduced to identify whether
> an lsmblob contains a non-zero value.
>=20
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h | 13 +++++++++++++
>  kernel/audit.h           |  3 ++-
>  kernel/auditsc.c         | 19 ++++++++-----------
>  3 files changed, 23 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 457fafc32fb0..a0b23b6e8734 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -277,6 +277,19 @@ static inline const char *kernel_load_data_id_str(en=
um kernel_load_data_id id)
>  	return kernel_load_data_str[id];
>  }
> =20
> +/**
> + * lsmblob_is_set - report if there is a value in the lsmblob
> + * @blob: Pointer to the exported LSM data
> + *
> + * Returns true if there is a value set, false otherwise
> + */
> +static inline bool lsmblob_is_set(struct lsmblob *blob)
> +{
> +	const struct lsmblob empty =3D {};
> +
> +	return !!memcmp(blob, &empty, sizeof(*blob));
> +}
> +
>  #ifdef CONFIG_SECURITY
> =20
>  int call_blocking_lsm_notifier(enum lsm_event event, void *data);
> diff --git a/kernel/audit.h b/kernel/audit.h
> index a60d2840559e..b1f2de4d4f1e 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -11,6 +11,7 @@
> =20
>  #include <linux/fs.h>
>  #include <linux/audit.h>
> +#include <linux/security.h>
>  #include <linux/skbuff.h>
>  #include <uapi/linux/mqueue.h>
>  #include <linux/tty.h>
> @@ -160,7 +161,7 @@ struct audit_context {
>  			kuid_t			uid;
>  			kgid_t			gid;
>  			umode_t			mode;
> -			u32			osid;
> +			struct lsmblob		oblob;
>  			int			has_perm;
>  			uid_t			perm_uid;
>  			gid_t			perm_gid;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 23adb15cae43..84f6e9356b8f 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -724,9 +724,7 @@ static int audit_filter_rules(struct task_struct *tsk=
,
>  				/* Find ipc objects that match */
>  				if (!ctx || ctx->type !=3D AUDIT_IPC)
>  					break;
> -				/* scaffolding */
> -				blob.scaffold.secid =3D ctx->ipc.osid;
> -				if (security_audit_rule_match(&blob,
> +				if (security_audit_rule_match(&ctx->ipc.oblob,
>  							      f->type, f->op,
>  							      f->lsm_rule))
>  					++result;
> @@ -1394,19 +1392,17 @@ static void show_special(struct audit_context *co=
ntext, int *call_panic)
>  			audit_log_format(ab, " a%d=3D%lx", i,
>  				context->socketcall.args[i]);
>  		break; }
> -	case AUDIT_IPC: {
> -		u32 osid =3D context->ipc.osid;
> -
> +	case AUDIT_IPC:
>  		audit_log_format(ab, "ouid=3D%u ogid=3D%u mode=3D%#ho",
>  				 from_kuid(&init_user_ns, context->ipc.uid),
>  				 from_kgid(&init_user_ns, context->ipc.gid),
>  				 context->ipc.mode);
> -		if (osid) {
> +		if (lsmblob_is_set(&context->ipc.oblob)) {
>  			char *ctx =3D NULL;
>  			u32 len;
> =20
> -			if (security_secid_to_secctx(osid, &ctx, &len)) {
> -				audit_log_format(ab, " osid=3D%u", osid);
> +			if (security_lsmblob_to_secctx(&context->ipc.oblob,
> +						       &ctx, &len)) {

Is there any reason to stop auditing secid when we fail to get the
security context?

>  				*call_panic =3D 1;
>  			} else {
>  				audit_log_format(ab, " obj=3D%s", ctx);
> @@ -1426,7 +1422,7 @@ static void show_special(struct audit_context *cont=
ext, int *call_panic)
>  				context->ipc.perm_gid,
>  				context->ipc.perm_mode);
>  		}
> -		break; }
> +		break;
>  	case AUDIT_MQ_OPEN:
>  		audit_log_format(ab,
>  			"oflag=3D0x%x mode=3D%#ho mq_flags=3D0x%lx mq_maxmsg=3D%ld "
> @@ -2642,7 +2638,8 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  	context->ipc.gid =3D ipcp->gid;
>  	context->ipc.mode =3D ipcp->mode;
>  	context->ipc.has_perm =3D 0;
> -	security_ipc_getsecid(ipcp, &context->ipc.osid);
> +	/* scaffolding */
> +	security_ipc_getsecid(ipcp, &context->ipc.oblob.scaffold.secid);
>  	context->type =3D AUDIT_IPC;
>  }
> =20


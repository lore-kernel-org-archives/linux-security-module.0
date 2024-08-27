Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FAA1B0122;
	Tue, 27 Aug 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761451; cv=none; b=P+YcTYDeCTnMTBUh2oYG6vF0NteQ1W4xabRIA+Gw+TsuXTMLo6uxtw8U4Z4baz1JiGsltgqeFTEJk+nbwtnfS+RI09J4weThtfMkrZxLJMe1GOzL/x6w1wSTRlCKxg7FQcz2bfQyNcU2GpkMYTEbPDi/EezjWVm//NuQdjqkz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761451; c=relaxed/simple;
	bh=qnOIMBwJ22TK2Fz+NCBsm8Fz01GgZhvPdfqhM41/OFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvgY6IkzBwuuEcxNXobS+s/OP2jOqylKR8UAsAtIpwdvb9lLePWMHfj62ID/wMTiz6WHwirQvhMOyXneLyQi3eorBUZiv4YS7cA1KGcAUELw1RvIFRA/iR4rkgZNEQIOKEMOUggAZwlBXKQfdh9FDXYvJhtokzewvSn0KHgdIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iY1ykIDl; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY1ykIDl"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so3398874a12.1;
        Tue, 27 Aug 2024 05:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724761449; x=1725366249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPnsNcQSfJlRrejA+n4cbheHsYk/EilnCWd0u+6eBhM=;
        b=iY1ykIDlGXIBEkoBME3A6d131cIeakgaknZu5FA5YEuCIeAE9PVBIqfo2npgDkwQIE
         KOveco9Sa1DtO73TNcKIJxUEIeDWXqQxo32MtakNh7FiLt3kKASYsIm07XpksEd8b68j
         Lj2YXaUoHzZcpY/78wLo7me+Vy3gmnP7fF5Vvlyff6AybJkFVhtJzIqnso0eUJ/nWVA4
         ibI+jNZryuzS8dq4f54Gao1ttUURxIOW6ZdWTCgcIi55nzdlRONbOws/8lVd/0/qOzjh
         KE5xTQu0vuulF1BjGNoHAVYYDXw8ScoALopiYYgAXKGvd3+CoclxilpcEfBpf3/dn4y7
         WCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724761449; x=1725366249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPnsNcQSfJlRrejA+n4cbheHsYk/EilnCWd0u+6eBhM=;
        b=w4aAxPbElwjS3ppnwqEG3rcZvuDRn14ntgDMmNQsjGOIFknxNKyY/nmHuETW0trnVS
         DswEYHz7AtXxltVn4xjqBr9jHC1PoHaWez7mkKFNi6+xOuLMLmnN4kRPuTF9JC+v/W5e
         VgtAe9ocsjq1V/TvqwBjP2Z9gCbUvgaDFKWwI8Trm/KagcT006LOWIgHr67lzW3WS30m
         Vmpaq1QpbKORd8ta5fNw/U/Cl7JhubX75YsM4H54zIjqLOEABJPu2p31uJwaWj6IC0oE
         HO0KvTZWh+hxm3KFQDC6mDrSWjruWS9mIFBqripgB7Zo5Cu3UclueHg2Hi2fS6NDg4Tv
         +m2g==
X-Forwarded-Encrypted: i=1; AJvYcCUKkbozI2A6IMzOXmBSIcLwUhO5U8kighHtTOJseXq5UMEKqmFK37TewO1fdy/jzF+kRcuiKOAKRojJgJmzECiJ13s0MHHK@vger.kernel.org, AJvYcCUwqr5/gxv6p3MXrtCYE1unnzIzYNpkbf7Z+Q7UI/iXlo5bjV98GJQUCNXkW/Pjtq/w7lnEV86q70+Obx2N@vger.kernel.org, AJvYcCXefNlGHpI230wjO8dS2ObHFNLfl2B5f7HuVSPu2QkdG1OSF2XheeTPpt2BpSoxqfbsiqE32w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGw+FS0JgXf5QF/0D+cKWs1GfRyuaZJcf4eRZewdy903hHl/rC
	3Z4kHIFZELEoSVbGgWV69YMy7pfWsMgwAKhQT/fV28ARGO4d3DmW3n6GgZeCOQxxWS3epOkftXJ
	gjZvbCDnNs/SAHVvpOacPYNN9uCTYPQ==
X-Google-Smtp-Source: AGHT+IE50bFJybQFHzw2hRxY/1ojWCGwqUvWY16IkkuMjotIHvQh0Y0uMuuLQ8mareKU6CCatKdYtSC68k9WwDZJaC4=
X-Received: by 2002:a17:90a:8a15:b0:2d3:c4d1:c95d with SMTP id
 98e67ed59e1d1-2d646bf62d2mr12188862a91.21.1724761448677; Tue, 27 Aug 2024
 05:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825190048.13289-1-casey@schaufler-ca.com> <20240825190048.13289-6-casey@schaufler-ca.com>
In-Reply-To: <20240825190048.13289-6-casey@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 27 Aug 2024 08:23:56 -0400
Message-ID: <CAEjxPJ49Q1od7XXJ2bepGc=6O_FA+1fz=W+_4vLhFcCyakPUqw@mail.gmail.com>
Subject: Re: [PATCH 05/13] LSM: Use lsmblob in security_ipc_getsecid
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, mic@digikod.net, linux-audit@redhat.com, 
	audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 3:02=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> There may be more than one LSM that provides IPC data for auditing.
> Change security_ipc_getsecid() to fill in a lsmblob structure instead
> of the u32 secid.  Change the name to security_ipc_getlsmblob() to
> reflect the change.  The audit data structure containing the secid
> will be updated later, so there is a bit of scaffolding here.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-audit@redhat.com
> Cc: audit@vger.kernel.org

1. Need to cc selinux list on patches that modify it.
2. Can't retain Acked-by or Reviewed-by lines if the patch has changed
since the review.

> ---
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      | 18 +++++++++++++++---
>  kernel/auditsc.c              |  3 +--
>  security/security.c           | 14 +++++++-------
>  security/selinux/hooks.c      |  9 ++++++---
>  security/smack/smack_lsm.c    | 17 ++++++++++-------
>  6 files changed, 41 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 3e5f6baa7b9f..c3ffc3f98343 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -253,8 +253,8 @@ LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct ta=
sk_struct *p,
>          struct inode *inode)
>  LSM_HOOK(int, 0, userns_create, const struct cred *cred)
>  LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
> -LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
> -        u32 *secid)
> +LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmblob, struct kern_ipc_perm *ipcp,
> +        struct lsmblob *blob)
>  LSM_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
>  LSM_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
>  LSM_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a0b23b6e8734..ebe8edaae953 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -290,6 +290,17 @@ static inline bool lsmblob_is_set(struct lsmblob *bl=
ob)
>         return !!memcmp(blob, &empty, sizeof(*blob));
>  }
>
> +/**
> + * lsmblob_init - initialize a lsmblob structure
> + * @blob: Pointer to the data to initialize
> + *
> + * Set all secid for all modules to the specified value.
> + */
> +static inline void lsmblob_init(struct lsmblob *blob)
> +{
> +       memset(blob, 0, sizeof(*blob));
> +}
> +
>  #ifdef CONFIG_SECURITY
>
>  int call_blocking_lsm_notifier(enum lsm_event event, void *data);
> @@ -500,7 +511,7 @@ int security_task_prctl(int option, unsigned long arg=
2, unsigned long arg3,
>  void security_task_to_inode(struct task_struct *p, struct inode *inode);
>  int security_create_user_ns(const struct cred *cred);
>  int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
> +void security_ipc_getlsmblob(struct kern_ipc_perm *ipcp, struct lsmblob =
*blob);
>  int security_msg_msg_alloc(struct msg_msg *msg);
>  void security_msg_msg_free(struct msg_msg *msg);
>  int security_msg_queue_alloc(struct kern_ipc_perm *msq);
> @@ -1340,9 +1351,10 @@ static inline int security_ipc_permission(struct k=
ern_ipc_perm *ipcp,
>         return 0;
>  }
>
> -static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32=
 *secid)
> +static inline void security_ipc_getlsmblob(struct kern_ipc_perm *ipcp,
> +                                          struct lsmblob *blob)
>  {
> -       *secid =3D 0;
> +       lsmblob_init(blob);
>  }
>
>  static inline int security_msg_msg_alloc(struct msg_msg *msg)
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 84f6e9356b8f..94b7ef89da2e 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2638,8 +2638,7 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>         context->ipc.gid =3D ipcp->gid;
>         context->ipc.mode =3D ipcp->mode;
>         context->ipc.has_perm =3D 0;
> -       /* scaffolding */
> -       security_ipc_getsecid(ipcp, &context->ipc.oblob.scaffold.secid);
> +       security_ipc_getlsmblob(ipcp, &context->ipc.oblob);
>         context->type =3D AUDIT_IPC;
>  }
>
> diff --git a/security/security.c b/security/security.c
> index bb541a3be410..6e72e678b5b4 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3611,17 +3611,17 @@ int security_ipc_permission(struct kern_ipc_perm =
*ipcp, short flag)
>  }
>
>  /**
> - * security_ipc_getsecid() - Get the sysv ipc object's secid
> + * security_ipc_getlsmblob() - Get the sysv ipc object LSM data
>   * @ipcp: ipc permission structure
> - * @secid: secid pointer
> + * @blob: pointer to lsm information
>   *
> - * Get the secid associated with the ipc object.  In case of failure, @s=
ecid
> - * will be set to zero.
> + * Get the lsm information associated with the ipc object.
>   */
> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
> +
> +void security_ipc_getlsmblob(struct kern_ipc_perm *ipcp, struct lsmblob =
*blob)
>  {
> -       *secid =3D 0;
> -       call_void_hook(ipc_getsecid, ipcp, secid);
> +       lsmblob_init(blob);
> +       call_void_hook(ipc_getlsmblob, ipcp, blob);
>  }
>
>  /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 102489e6d579..1b34b86426e8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6328,10 +6328,13 @@ static int selinux_ipc_permission(struct kern_ipc=
_perm *ipcp, short flag)
>         return ipc_has_perm(ipcp, av);
>  }
>
> -static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
> +static void selinux_ipc_getlsmblob(struct kern_ipc_perm *ipcp,
> +                                  struct lsmblob *blob)
>  {
>         struct ipc_security_struct *isec =3D selinux_ipc(ipcp);
> -       *secid =3D isec->sid;
> +       blob->selinux.secid =3D isec->sid;
> +       /* scaffolding */
> +       blob->scaffold.secid =3D isec->sid;
>  }
>
>  static void selinux_d_instantiate(struct dentry *dentry, struct inode *i=
node)
> @@ -7252,7 +7255,7 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>         LSM_HOOK_INIT(userns_create, selinux_userns_create),
>
>         LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
> -       LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
> +       LSM_HOOK_INIT(ipc_getlsmblob, selinux_ipc_getlsmblob),
>
>         LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
>         LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 5d74d8590862..370ca7fb1843 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3442,16 +3442,19 @@ static int smack_ipc_permission(struct kern_ipc_p=
erm *ipp, short flag)
>  }
>
>  /**
> - * smack_ipc_getsecid - Extract smack security id
> + * smack_ipc_getlsmblob - Extract smack security data
>   * @ipp: the object permissions
> - * @secid: where result will be saved
> + * @blob: where result will be saved
>   */
> -static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
> +static void smack_ipc_getlsmblob(struct kern_ipc_perm *ipp,
> +                                struct lsmblob *blob)
>  {
> -       struct smack_known **blob =3D smack_ipc(ipp);
> -       struct smack_known *iskp =3D *blob;
> +       struct smack_known **iskpp =3D smack_ipc(ipp);
> +       struct smack_known *iskp =3D *iskpp;
>
> -       *secid =3D iskp->smk_secid;
> +       blob->smack.skp =3D iskp;
> +       /* scaffolding */
> +       blob->scaffold.secid =3D iskp->smk_secid;
>  }
>
>  /**
> @@ -5157,7 +5160,7 @@ static struct security_hook_list smack_hooks[] __ro=
_after_init =3D {
>         LSM_HOOK_INIT(task_to_inode, smack_task_to_inode),
>
>         LSM_HOOK_INIT(ipc_permission, smack_ipc_permission),
> -       LSM_HOOK_INIT(ipc_getsecid, smack_ipc_getsecid),
> +       LSM_HOOK_INIT(ipc_getlsmblob, smack_ipc_getlsmblob),
>
>         LSM_HOOK_INIT(msg_msg_alloc_security, smack_msg_msg_alloc_securit=
y),
>
> --
> 2.41.0
>

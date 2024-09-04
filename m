Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FDD3D6B
	for <linux-security-module@vger.kernel.org>; Wed,  4 Sep 2024 00:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725409115; cv=none; b=KwQj/IiUTmT1UUamEJ3vba+2ebesVXA8PER/rESjmfY6cEYLXuIkv8opBG8T8WUJ+lCAHweN6WMKsDGeRPmnkhPd84WMmD0EaO5u0BNkD4SdI4urOyPF4hq1ANXVJoPEPXpXgplx1qqxmi0ldcJjs1yX4vzL0Q3C1pVi6eTmNXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725409115; c=relaxed/simple;
	bh=maA3RP7pe/gagogwVKFOTv1GARftK5AmlMjSMUHlNrY=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=BdHWxhVXVrh7ZyghXnuY2moyTdZtoOwAcYAY0L8N3JdXNs7x1YZYksuWUAZTIw39QJekVgZac0tfgbHjpcRUhEzPpWJ3UzxchQuveD6Uao81XrK1MJxnAFvTdjpGP0Zz5mcncTQPqS9L1BVcuxnU8g7aSOHcHmqLbCSiaxNZU5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bK86CJOs; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bK86CJOs"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a81309072dso292930085a.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Sep 2024 17:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725409112; x=1726013912; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/KK8E8XbtZHqeNwUxxALukoNijMwJ9sVaaDZmXi1uzg=;
        b=bK86CJOsJx9L4Z4lI1HT/tIKOpxOZ9U5D7y2d3G5AV0HFopDN04oabx1TllvhQKG96
         sh3Qz2E7YDcPlTaIYwJouLBzvtwH+3Err2Q+YA9rEMQoiEkax9XMPijBI7KPPJQQzrWC
         KVo1CNmTWIngT5xjRuZ8B/U0ZzVgo5x8IVQRyHda3wib33P6oUi56LUf/ARCbdxI3zdr
         /EY0UlOSAJk4eqOOAHvYzSALX73OZ9rFsGH8NUVBb220bRVQsFqMWzYGhmRctMwpCGNk
         jiL9eF6aSV8tTT7La4YKoYSqK7nL50GBVtt5Ow7O7yA3QwKZQeXUXQ52mtCtCNAlA5IK
         tKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725409112; x=1726013912;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KK8E8XbtZHqeNwUxxALukoNijMwJ9sVaaDZmXi1uzg=;
        b=ZLeiXOYKsSqqufHJPYvahU7EY0cyA2UjM3IZmY1/DeRgqX+N2S7nh4Bb1QUrq+CUcW
         TsY9ThXYX7SfJmA68niukACcc1+RDofCXzEUSDVQjJgVeQ6tf6mY4+f0Enre+lCoRDWo
         kDiYE/vxLvnxBl8yHw+cZckWoNE0wJ4d0PdF5VM/F9O6sIe1oy528TwB7KzyrTgyT488
         6XowbAG/YEPRW/QwlrsL8ZDQHd/6PsSiXwKjI5dunopMryGR/DwVgEh8TzM75eMzMAu2
         hHKTv3zJl/DpCvwg038IZ7KmG3Cy+nGk0XXyL6liL8FEK2woZup1O9ZQ4N7TskIvIqLd
         g0vA==
X-Forwarded-Encrypted: i=1; AJvYcCUUK0ahHIVieFqSi2aTWKH3g9+pW9O+GzERsntGkxIwmGREHLwQa/273rw/s+/9YfG5DPnW1KprHlsbe4mznGT0M69AY+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTioLfWSlC1YdoQrwe2vqRFtXA9ArPa/kagb46FdpT4uxm2PrK
	HRXdM/y2lRlOnFLWQStGuNKmT/40Ul9ot8O+Z07Q4Gq1p2bA+P4GBsvd1ZAeSw==
X-Google-Smtp-Source: AGHT+IEAkame932TPaYRLg/8YoKrklA6vbq95atOfnBpcjTQqvQyn+0TULJts+nXRQRSKukfQWgJYw==
X-Received: by 2002:a05:620a:1725:b0:7a1:c40d:7573 with SMTP id af79cd13be357-7a902f29e21mr1690059385a.49.1725409112544;
        Tue, 03 Sep 2024 17:18:32 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d36b11sm575401385a.74.2024.09.03.17.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 17:18:32 -0700 (PDT)
Date: Tue, 03 Sep 2024 20:18:31 -0400
Message-ID: <e7c67e345b136ba6c4ebc5a8debe9338@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, audit@vger.kernel.org
Subject: Re: [PATCH v2 5/13] LSM: Use lsmblob in security_ipc_getsecid
References: <20240830003411.16818-6-casey@schaufler-ca.com>
In-Reply-To: <20240830003411.16818-6-casey@schaufler-ca.com>

On Aug 29, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> There may be more than one LSM that provides IPC data for auditing.
> Change security_ipc_getsecid() to fill in a lsmblob structure instead
> of the u32 secid.  Change the name to security_ipc_getlsmblob() to
> reflect the change.  The audit data structure containing the secid
> will be updated later, so there is a bit of scaffolding here.

I think that last sentence needs to be updated based on the current
ordering in the patchset.

> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: audit@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: selinux@vger.kernel.org
> ---
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      | 18 +++++++++++++++---
>  kernel/auditsc.c              |  3 +--
>  security/security.c           | 14 +++++++-------
>  security/selinux/hooks.c      |  9 ++++++---
>  security/smack/smack_lsm.c    | 17 ++++++++++-------
>  6 files changed, 41 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 3e5f6baa7b9f..c3ffc3f98343 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -253,8 +253,8 @@ LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
>  	 struct inode *inode)
>  LSM_HOOK(int, 0, userns_create, const struct cred *cred)
>  LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
> -LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
> -	 u32 *secid)
> +LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmblob, struct kern_ipc_perm *ipcp,
> +	 struct lsmblob *blob)
>  LSM_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
>  LSM_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
>  LSM_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a0b23b6e8734..ebe8edaae953 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -290,6 +290,17 @@ static inline bool lsmblob_is_set(struct lsmblob *blob)
>  	return !!memcmp(blob, &empty, sizeof(*blob));
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
> +	memset(blob, 0, sizeof(*blob));
> +}
> +
>  #ifdef CONFIG_SECURITY

Once again, I think we may want a !CONFIG_SECURITY variant too.

--
paul-moore.com

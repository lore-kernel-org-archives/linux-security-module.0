Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5C1F4FD6
	for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2024 03:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616093; cv=none; b=WNDfLbRU/m5J2ssQUaYZj3ABgSxVx1svaMj+69GcM6CHwmRP5BLzK8NGtv7Atsx8VE5+vgBVTol0GnjrS4U+aN0pWlr2A+iGdrSVayw8IcBvul2C7pd1fqbbQHQNSEEWiPsqqGB0jy2CWs1ogcQCdlSnNmXSeJJ2e5VSZMR7a+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616093; c=relaxed/simple;
	bh=gW94NmI73PiDXzWaRhJN3by7GzK2SB61EYnd+RU+SXA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=cLLH8GMWjrke5R0abbPjyEgi1uZ9glnWi2OSqxgR60fcK6NUOz5xI3F+/K8fTiNqC/bkqA2MOibG0kFsZM36SU9h0cADk9xkRcwi2DZa37w2qGJCUHAb037QOxIxmQVaZBoqeqCqpUk9kRVMbV3cBHFpuC3rRc5VKUwFEjyaLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UZ0XzDby; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UZ0XzDby"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4603b835a1cso16666611cf.0
        for <linux-security-module@vger.kernel.org>; Thu, 10 Oct 2024 20:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728616091; x=1729220891; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBk1BYCe6DiQlB7u6jhmsN4dxnIYnOFQt3USnG0/ZxE=;
        b=UZ0XzDbyYnSzfpGshfhQilxkudVsilmBYpKi7XvEWwxa1g+JHwXOuC9KeXQtCcBqK5
         Blop1tff5scgPx2X9In44yEOR83CvGj4wwgTmo75eFnW+ccRyVhh70l9oZQnm3nmcs4h
         zpOx/nEcB+48GQ0gVDEgb3pRUaRwkK/qLA73eAcY31/sGAQDBGT8QvNHX0fgtn3wfTCi
         mrVxyhFoSMwzogBmDrQvWdzucKo/6vXKIv/i9mnMqf/DyyAJLOQz2bHEiKaRSGx5PQES
         g1bpGUULdZtV/Mr+31L/jOc7V58dsf4x0GRdkvY6Z7PnjqapIJ7KJtXaXZBgTA441xNM
         sQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728616091; x=1729220891;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NBk1BYCe6DiQlB7u6jhmsN4dxnIYnOFQt3USnG0/ZxE=;
        b=TUchdCoIS6FYbaOy2KgTf9rgtSmdj8u2RxM3bCgmdFiTfWoH6T8GdvLT0uR8veYu3t
         r1eBzZoBBNXrdzjmM6zTeYh3qxGJsUrSF/F/8UBPWAf0QhJXeREPbl2N64JlobnZjnqh
         0hpAQi/CsyWg1Moa2E2V0wKjCJyFyPBwp9Rt0kIHVks6TKEsp62fcux1l3HTBA3ENPPr
         iDhTg4zGnyu2LTKhpYz4GDq6lTwZ+RTDB46miRmR0BUb0MHGjFPWmC+isyIHFmPIubm4
         aeOMMlpfy0/HQg8k1BYulLqF69vpGsyDvceOJQzYuypZNFXzV+h6Q2eA4HP1tn1IC1Lz
         pfQw==
X-Forwarded-Encrypted: i=1; AJvYcCW7hG21i2SULnntzNOiPsOiGG/HVFHKsXeO/+j7//4m6wD7PCGqTznzzpAb1DkGKInFoH3f2LMqySDYJdZh8v+eHi3xacA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAeRkACPLHzHuO2daUmUK3wSVFaQUOEFDL1AXQwTX6DdHH3wrK
	HplSbfzOOZeE0Uxeqh0av1YPsOBobZ2BJJQEqMrmVRkhiWkpYYHlRWnQJbzBqA==
X-Google-Smtp-Source: AGHT+IFIbv+OlmL3pBDaxxtxV8FVN6u4fxW5kLN1uhrom9lCfz4zEXObG0lu7ct0SSx801Obl/QRcg==
X-Received: by 2002:a05:622a:2cb:b0:45b:16b:ecb7 with SMTP id d75a77b69052e-4604bb962camr17699621cf.1.1728616091095;
        Thu, 10 Oct 2024 20:08:11 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427905adsm11358401cf.15.2024.10.10.20.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 20:08:10 -0700 (PDT)
Date: Thu, 10 Oct 2024 23:08:09 -0400
Message-ID: <9dbed0bc4172063c43aaae0fc9af542f@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, audit@vger.kernel.org
Subject: Re: [PATCH v4 5/13] LSM: Use lsm_prop in security_ipc_getsecid
References: <20241009173222.12219-6-casey@schaufler-ca.com>
In-Reply-To: <20241009173222.12219-6-casey@schaufler-ca.com>

On Oct  9, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> There may be more than one LSM that provides IPC data for auditing.
> Change security_ipc_getsecid() to fill in a lsm_prop structure instead
> of the u32 secid.  Change the name to security_ipc_getlsmprop() to
> reflect the change.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: audit@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: selinux@vger.kernel.org
> ---
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      | 22 +++++++++++++++++-----
>  kernel/auditsc.c              |  5 ++---
>  security/security.c           | 14 +++++++-------
>  security/selinux/hooks.c      |  9 ++++++---
>  security/smack/smack_lsm.c    | 16 +++++++++-------
>  6 files changed, 43 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index ed6ea0b1ec57..6ef2a345ea03 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -256,8 +256,8 @@ LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
>  	 struct inode *inode)
>  LSM_HOOK(int, 0, userns_create, const struct cred *cred)
>  LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
> -LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
> -	 u32 *secid)
> +LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmprop, struct kern_ipc_perm *ipcp,
> +	 struct lsm_prop *prop)
>  LSM_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
>  LSM_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
>  LSM_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5652baa4ca3c..15aef5f68e77 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -289,6 +289,17 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
>  	return kernel_load_data_str[id];
>  }
>  
> +/**
> + * lsmprop_init - initialize a lsm_prop structure
> + * @prop: Pointer to the data to initialize
> + *
> + * Set all secid for all modules to the specified value.
> + */
> +static inline void lsmprop_init(struct lsm_prop *prop)
> +{
> +	memset(prop, 0, sizeof(*prop));
> +}
> +
>  #ifdef CONFIG_SECURITY
>  
>  /**
> @@ -297,7 +308,7 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
>   *
>   * Returns true if there is a value set, false otherwise
>   */
> -static inline bool lsm_prop_is_set(struct lsm_prop *prop)
> +static inline bool lsmprop_is_set(struct lsm_prop *prop)

See my comment in patch 4/13 about naming it this way from the start.

--
paul-moore.com

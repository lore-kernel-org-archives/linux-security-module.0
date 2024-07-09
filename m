Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2B6135A63
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720562885; cv=none; b=lQp+nqxg8R/qfexFabIb82Fu3OS8oM2IEWqiQ+MYbbXM3etsU4dHJ4/YubXim44GJlz8LnYplDxp7fh2H1C5WExsn21AA2XwHsSGgNVH7L6f4T4Dq1awr5Gg/z2IrnYkbyf0/FC465o6x17tJsB99hqFBL/0uVVriaORwtNRnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720562885; c=relaxed/simple;
	bh=a0IEvsseBx2lXRDAMOpnmaVgyAUOhpHrqgq02Qgy2bM=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=UDLya/8HyPp5LSWJQiq1beFajkhTilqbsgan2/e1D27m+igmizJdlS8EuJkYlO4yUzhnq35MUix5/ShWHfmQSQT60sjZP6dRWCMGD2yhk1e65yJG/7mYHy/Q3dvkDvZ6PM5EurA5F6sgfWyQJGIizYZ4NMTJfRz5U24D2VSEJDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bvvRhWyk; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bvvRhWyk"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25e0d750b73so2870024fac.3
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720562882; x=1721167682; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7bL0TlKOsMXbDTOiaM9rZ9bL0TymI3EaDxO5HtRQYXU=;
        b=bvvRhWykoHSN0RYBGlhjj3b9GkmvHJJWYQr0ccAKhgZwpoW43snbXh8BjRh8dC/S9U
         OIZXKKe9QIBud8JQbyCKzp0YecLWtRn/PS47VPTiE1Op3NtBbTlExB+yFqroR0S0i45I
         Q35/BRexjw/xOgUroJhnV1CHKfKagmMs6j+KoeQl5wl5NWeO+xKpaOjQ0hK2dQv3BDuT
         4HxbQlY5d8it5OzZ4EnFVDIaXAPR6t5mLRHfwtR04gdjwyTW6457Fbfa2Wf+MwIUvaL2
         Dv6334uqkvNHoufnRRVZvUyicBFq/6AwQXOcDIeupDzlyAXT0rYiWhjWhY8QyI4WvIUd
         mP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720562882; x=1721167682;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7bL0TlKOsMXbDTOiaM9rZ9bL0TymI3EaDxO5HtRQYXU=;
        b=xTQ5rGTpLIOAZZOd/1gPa653qcP1mwsBxm5TljxqZXv95e1BAuvrlfIUbs2pnppAms
         RXRYWgRWys3p4ZKfgaD1fzO+dA/Guuyok9aUIlzPzByrHkYt5EGaazriqoQyiYpruKJJ
         bHZe2RQeL9+rTjB/zXPuEcMIUXhAh6oqb3DUA+AIkjUsi16AxGFXfw4mBuf6HpFmOFc4
         eipeSjRor272Qcn9ojfzEkHNErMhddLhAULKGUP0CxHrutgnW+RuuOOFjJzK/06N5Ycm
         K12b04gC3IrPdMgfp0yRTq+Crv7iUVjsy18NhTCBDOi1M4r2PC6oEnilRV7c6ptfyIhM
         HZCg==
X-Forwarded-Encrypted: i=1; AJvYcCVfZBMU8gpNLkc7vDl8EayPlsLkKTntBzJyO4wRbvXHwjazgVAweopljcr4o1Y/qnf/b7xPrjdD8v4qi7+yl/HWo8vAjfhb66JirnFrSVRLW6Q8hh4H
X-Gm-Message-State: AOJu0YwTP/x4nIaIX0IzmlK2KYoE7IvxYi6AMrNgFVChjGzED9yggP8e
	yfSAx481XZ8NjByfyBHDe7Q9gJvH2bYaOoCPoxVReo7t66kclY4kspqvqED5GQ==
X-Google-Smtp-Source: AGHT+IEx8cFRTFZDcL4q7cih1qN1K04l6VG/psPlz6g5TQ1S/Js1CKeD6EVib+ZnxZN7EWTYuTh+5A==
X-Received: by 2002:a05:6870:1017:b0:25e:1659:5eec with SMTP id 586e51a60fabf-25eaec3f16bmr2206717fac.51.1720562882344;
        Tue, 09 Jul 2024 15:08:02 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bf3308sm14436931cf.85.2024.07.09.15.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:08:02 -0700 (PDT)
Date: Tue, 09 Jul 2024 18:08:01 -0400
Message-ID: <8088e9a23a22fef35159b86760a9ab8e@paul-moore.com>
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
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, mic@digikod.net
Subject: Re: [PATCH 2/6] LSM: Infrastructure management of the key security  blob
References: <20240708213957.20519-3-casey@schaufler-ca.com>
In-Reply-To: <20240708213957.20519-3-casey@schaufler-ca.com>

On Jul  8, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Move management of the key->security blob out of the
> individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.

Perhaps mention that the key_free hook is being removed as it is not
currently needed after this change?

> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h         |  1 +
>  security/security.c               | 41 +++++++++++++++++++++++++++++--
>  security/selinux/hooks.c          | 23 +++++------------
>  security/selinux/include/objsec.h |  7 ++++++
>  security/smack/smack.h            |  7 ++++++
>  security/smack/smack_lsm.c        | 33 +++++++++++--------------
>  6 files changed, 75 insertions(+), 37 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 5e93a72bdca6..aae37481b7be 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -227,6 +227,9 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>  		blob_sizes.lbs_inode = sizeof(struct rcu_head);
>  	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>  	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
> +#ifdef CONFIG_KEYS
> +	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
> +#endif

Since the lsm_blob_sizes struct is going to have the lsb_key field
regardless of CONFIG_KEYS (which is good, I'm not arguing that), we
should be okay to call lsm_set_blob_size() on the lsb_key field, right?

>  	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
>  	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
>  	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
> @@ -402,6 +405,9 @@ static void __init ordered_lsm_init(void)
>  	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
>  	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
>  	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
> +#ifdef CONFIG_KEYS
> +	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
> +#endif /* CONFIG_KEYS */

This one makes sense.

> @@ -5301,7 +5337,8 @@ int security_key_alloc(struct key *key, const struct cred *cred,
>   */
>  void security_key_free(struct key *key)
>  {
> -	call_void_hook(key_free, key);
> +	kfree(key->security);
> +	key->security = NULL;
>  }

A note to future devs, we can add the key_free hook back if needed, but
currently nobody is using it beyond basic memory management.

>  /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 19346e1817ff..b3de2e941ef7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6981,6 +6968,9 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>  	.lbs_file = sizeof(struct file_security_struct),
>  	.lbs_inode = sizeof(struct inode_security_struct),
>  	.lbs_ipc = sizeof(struct ipc_security_struct),
> +#ifdef CONFIG_KEYS
> +	.lbs_key = sizeof(struct key_security_struct),
> +#endif /* CONFIG_KEYS */

We can probably get rid of the Kconfig conditional.  I understand the
desire to keep this to only what is needed, but since this only really
has an impact on boot, and the impact is some basic math, I'd rather
not run the risk of rot due to conditional compilation.

>  	.lbs_msg_msg = sizeof(struct msg_security_struct),
>  	.lbs_sock = sizeof(struct sk_security_struct),
>  	.lbs_superblock = sizeof(struct superblock_security_struct),

...

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index a931b44bc959..17bcc9cbf584 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -5010,6 +5005,9 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
>  	.lbs_file = sizeof(struct smack_known *),
>  	.lbs_inode = sizeof(struct inode_smack),
>  	.lbs_ipc = sizeof(struct smack_known *),
> +#ifdef CONFIG_KEYS
> +	.lbs_key = sizeof(struct smack_known *),
> +#endif /* CONFIG_KEYS */

See above, but ultimately this is Smack code so it's your call.

>  	.lbs_msg_msg = sizeof(struct smack_known *),
>  	.lbs_sock = sizeof(struct socket_smack),
>  	.lbs_superblock = sizeof(struct superblock_smack),

--
paul-moore.com

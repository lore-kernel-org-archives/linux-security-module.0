Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCFA624
	for <linux-security-module@vger.kernel.org>; Wed,  3 Jul 2024 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719965258; cv=none; b=X1EmkZhX3PtOOdxG1tdoRTvVsdB+dkKrp9cOEmcae+zzmpjCzMx6HvxNz5xPM1pcvs2RxvrK0FxjfxHVVK4x5cQ8e/GRkyL2KOlxfXx4rgkGDA8myoUDE8rn2DNJt7JIKSaZjPWGk7SW6lYQG9yKfAGE6oU5oJ3qSclSQXgfmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719965258; c=relaxed/simple;
	bh=708q51VDrLDLXCuX9cS9zxMFVakOmrGNTBp2ntm2W44=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=ra1RuY09qGlEQJOJQNe5dYvT2kffSgJniiQRyFkeaIV2bb4hfLkat2pXpJbCIG8im1KnL9maV2EfH39qzQKhn0hQHu0kRbUszJ0+5/SQCemd/7oxgdligY+CZxPfLZiJ4q6pz8rgmkGBKgzFWNsjK3dJz/jy5ICyQFAmj7vNDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QkgC+4An; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QkgC+4An"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4ef75bc9a61so1156870e0c.3
        for <linux-security-module@vger.kernel.org>; Tue, 02 Jul 2024 17:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719965256; x=1720570056; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TmcPvEUPshmVrzIc8Gu6uR9hITsbcvpqQ2w6Me2abxQ=;
        b=QkgC+4AnfKyOBEAQIi7cvsblYDS8bAsBIu6FWVXHcnxxHthiTfRX0AcEjGFYKPr85c
         mOnH+Wgde5OtlgO3a9JzOAp7H2S/8z64HuR265d1S3JdTCaxdjqIbmSybS7XRdnPt0Ry
         vyQWrhL7PkJT4sa8Z+0iK23b+wG+XazDqSLjKfZs2j4KUOL0XoUM5UYCMLlO7UBaYGy6
         qL92NjDaeJRyH+CwAO0ounDwp03XZtJbAyUeGkWYJjocJqqzoOv01HfmdtWSTa/TuEfV
         jZPlvfKybpPnYwo+h01tiiSmphD8MKgN8nIJDOmrb8t7OB/L1st2sqM4IFq/xGnngsqL
         7cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719965256; x=1720570056;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TmcPvEUPshmVrzIc8Gu6uR9hITsbcvpqQ2w6Me2abxQ=;
        b=fkEAWoDQ214mrzKJ34pXCL2SlKw1tSf2nJpSkafigRpWPOjX13+TtjL+FWXSN9HE0b
         XZU5c8U9GzwP/sOnJb0aIoAszdtmrCBe/Ox67QeNnTHeS4NfFDfl/qgGLwJF4kfnONum
         VyCvobN3yes9IvgGvnR7F2fAHNMDGEA/3R4QElii1jhEDq4F2joCgZyagjeVHQgh3r0C
         3HF4MdIzYogrXbrIIlA1hc75/rVVJE3HF8INSJDNQ8gQCEzKDKEJsUlve1jA4AKoaZx2
         lP/3FhZWuIyuwKujhdX9iDIH5aAZGGTrgoZY4DDvcPDkLvyY8pfTWpbYhbKaP0SCegf1
         RS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2shp/KG4u5iVO9WREgwAyarLhjZePdJvBmrLXv+pzWyncl41mdWZYaYGEPeGOh3VkO/tqxhnf8xFqjmhiPficw/CAgCjbkwSpfZZ8/SWkBUaJipwv
X-Gm-Message-State: AOJu0Yx80xgcJ5zy2y4hGfrVSrJPDZX32R+bjhIwNhPPold2VBzToDz+
	kArcdzBrzCt85XXx9koGVeie2mUkH/zt8q7sc26AabaZiaG8eKtq9WRLWfGksA==
X-Google-Smtp-Source: AGHT+IFfyVTaUtQTeAqaGFPiQKpXf2tkYPRvHMT5mmqzxxn7GnED8VPT54ph7QsS31va6q7U82FjbA==
X-Received: by 2002:a05:6122:3544:b0:4ea:f128:7adb with SMTP id 71dfb90a1353d-4f2a57288b1mr9838969e0c.10.1719965255851;
        Tue, 02 Jul 2024 17:07:35 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692945b4sm503247985a.57.2024.07.02.17.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 17:07:35 -0700 (PDT)
Date: Tue, 02 Jul 2024 20:07:34 -0400
Message-ID: <f40a3d1bc1cd69442f4524118c3e2956@paul-moore.com>
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
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net, renauld@google.com, revest@chromium.org, song@kernel.org, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH v13 4/5] security: Update non standard hooks to use static  calls
References: <20240629084331.3807368-5-kpsingh@kernel.org>
In-Reply-To: <20240629084331.3807368-5-kpsingh@kernel.org>

On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> 
> There are some LSM hooks which do not use the common pattern followed
> by other LSM hooks and thus cannot use call_{int, void}_hook macros and
> instead use lsm_for_each_hook macro which still results in indirect
> call.
> 
> There is one additional generalizable pattern where a hook matching an
> lsmid is called and the indirect calls for these are addressed with the
> newly added call_hook_with_lsmid macro which internally uses an
> implementation similar to call_int_hook but has an additional check that
> matches the lsmid.
> 
> For the generic case the lsm_for_each_hook macro is updated to accept
> logic before and after the invocation of the LSM hook (static call) in
> the unrolled loop.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> ---
>  security/security.c | 248 +++++++++++++++++++++++++-------------------
>  1 file changed, 144 insertions(+), 104 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index e0ec185cf125..4f0f35857217 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -948,10 +948,48 @@ out:									\
>  	RC;								\
>  })
>  
> -#define lsm_for_each_hook(scall, NAME)					\
> -	for (scall = static_calls_table.NAME;				\
> -	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
> -		if (static_key_enabled(&scall->active->key))
> +/*
> + * Can be used in the context passed to lsm_for_each_hook to get the lsmid of the
> + * current hook
> + */
> +#define current_lsmid() _hook_lsmid

See my comments below about security_getselfattr(), I think we can drop
the current_lsmid() macro.  If we really must keep it, we need to rename
it to something else as it clashes too much with the other current_XXX()
macros/functions which are useful outside of our wacky macros.

> +#define __CALL_HOOK(NUM, HOOK, RC, BLOCK_BEFORE, BLOCK_AFTER, ...)	     \
> +do {									     \
> +	int __maybe_unused _hook_lsmid;					     \
> +									     \
> +	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
> +		_hook_lsmid = static_calls_table.HOOK[NUM].hl->lsmid->id;    \
> +		BLOCK_BEFORE						     \
> +		RC = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);   \
> +		BLOCK_AFTER						     \
> +	}								     \
> +} while (0);
> +
> +#define lsm_for_each_hook(HOOK, RC, BLOCK_AFTER, ...)	\
> +	LSM_LOOP_UNROLL(__CALL_HOOK, HOOK, RC, ;, BLOCK_AFTER, __VA_ARGS__)
> +
> +#define call_hook_with_lsmid(HOOK, LSMID, ...)				\
> +({									\
> +	__label__ out;							\
> +	int RC = LSM_RET_DEFAULT(HOOK);					\
> +									\
> +	LSM_LOOP_UNROLL(__CALL_HOOK, HOOK, RC,				\
> +	/* BLOCK BEFORE INVOCATION */					\
> +	{								\
> +		if (current_lsmid() != LSMID)				\
> +			continue;					\
> +	},								\
> +	/* END BLOCK BEFORE INVOCATION */				\
> +	/* BLOCK AFTER INVOCATION */					\
> +	{								\
> +		goto out;						\
> +	},								\
> +	/* END BLOCK AFTER INVOCATION */				\
> +	__VA_ARGS__);							\
> +out:									\
> +	RC;								\
> +})
>  
>  /* Security operations */

...

> @@ -1581,15 +1629,19 @@ int security_sb_set_mnt_opts(struct super_block *sb,
>  			     unsigned long kern_flags,
>  			     unsigned long *set_kern_flags)
>  {
> -	struct lsm_static_call *scall;
>  	int rc = mnt_opts ? -EOPNOTSUPP : LSM_RET_DEFAULT(sb_set_mnt_opts);
>  
> -	lsm_for_each_hook(scall, sb_set_mnt_opts) {
> -		rc = scall->hl->hook.sb_set_mnt_opts(sb, mnt_opts, kern_flags,
> -					      set_kern_flags);
> -		if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
> -			break;
> -	}
> +	lsm_for_each_hook(
> +		sb_set_mnt_opts, rc,
> +		/* BLOCK AFTER INVOCATION */
> +		{
> +			if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
> +				goto out;
> +		},
> +		/* END BLOCK AFTER INVOCATION */
> +		sb, mnt_opts, kern_flags, set_kern_flags);
> +
> +out:
>  	return rc;
>  }
>  EXPORT_SYMBOL(security_sb_set_mnt_opts);

I know I was the one who asked to implement the static_calls for *all*
of the LSM functions - thank you for doing that - but I think we can
all agree that some of the resulting code is pretty awful.  I'm probably
missing something important, but would an apporach similar to the pseudo
code below work?

  #define call_int_hook_special(HOOK, RC, LABEL, ...) \
    LSM_LOOP_UNROLL(HOOK##_SPECIAL, RC, HOOK, LABEL, __VA_ARGS__)

  int security_sb_set_mnt_opts(...)
  {
      int rc = LSM_RET_DEFAULT(sb_set_mnt_opts);

  #define sb_set_mnt_opts_SPECIAL \
      do { \
        if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts)) \
          goto out; \
      } while (0)

      rc = call_int_hook_special(sb_set_mnt_opts, rc, out, ...);

  out:
    return rc;
  }

> @@ -4040,7 +4099,6 @@ EXPORT_SYMBOL(security_d_instantiate);
>  int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  			 u32 __user *size, u32 flags)
>  {
> -	struct lsm_static_call *scall;
>  	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
>  	u8 __user *base = (u8 __user *)uctx;
>  	u32 entrysize;
> @@ -4078,31 +4136,42 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  	 * In the usual case gather all the data from the LSMs.
>  	 * In the single case only get the data from the LSM specified.
>  	 */
> -	lsm_for_each_hook(scall, getselfattr) {
> -		if (single && lctx.id != scall->hl->lsmid->id)
> -			continue;
> -		entrysize = left;
> -		if (base)
> -			uctx = (struct lsm_ctx __user *)(base + total);
> -		rc = scall->hl->hook.getselfattr(attr, uctx, &entrysize, flags);
> -		if (rc == -EOPNOTSUPP) {
> -			rc = 0;
> -			continue;
> -		}
> -		if (rc == -E2BIG) {
> -			rc = 0;
> -			left = 0;
> -			toobig = true;
> -		} else if (rc < 0)
> -			return rc;
> -		else
> -			left -= entrysize;
> +	LSM_LOOP_UNROLL(
> +		__CALL_HOOK, getselfattr, rc,
> +		/* BLOCK BEFORE INVOCATION */
> +		{
> +			if (single && lctx.id != current_lsmid())
> +				continue;
> +			entrysize = left;
> +			if (base)
> +				uctx = (struct lsm_ctx __user *)(base + total);
> +		},
> +		/* END BLOCK BEFORE INVOCATION */
> +		/* BLOCK AFTER INVOCATION */
> +		{
> +			if (rc == -EOPNOTSUPP) {
> +				rc = 0;
> +			} else {
> +				if (rc == -E2BIG) {
> +					rc = 0;
> +					left = 0;
> +					toobig = true;
> +				} else if (rc < 0)
> +					return rc;
> +				else
> +					left -= entrysize;
> +
> +				total += entrysize;
> +				count += rc;
> +				if (single)
> +					goto out;
> +			}
> +		},
> +		/* END BLOCK AFTER INVOCATION */
> +		attr, uctx, &entrysize, flags);
> +
> +out:
>  
> -		total += entrysize;
> -		count += rc;
> -		if (single)
> -			break;
> -	}
>  	if (put_user(total, size))
>  		return -EFAULT;
>  	if (toobig)

I think we may need to admit defeat with security_getselfattr() and
leave it as-is, the above is just too ugly to live.  I'd suggest
adding a comment explaining that it wasn't converted due to complexity
and the resulting awfulness.

--
paul-moore.com

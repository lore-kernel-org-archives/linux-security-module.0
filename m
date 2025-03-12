Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3BF1F192E
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823497; cv=none; b=YUaVoNlhG/RNAhuI0SwGtWJ5Nn4nCtp4ZHxxFoSOqIyv/iXPlq4Adwbxn3yWSFI3Mt7tXx6vFe7PTihGczMsQRrqg0mz4VxyqbcRbmH/IartlSYUgwlrYCtmCMNfkodQhKXnyRW+XW1ZuPEovq/XphbsPP+gyY45OilxxD6yJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823497; c=relaxed/simple;
	bh=nZppvXExe9z50boTqFggcjUjW+ehiSBBDdzzf3Mnh3I=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=NdhP6K+CGhl7AUjWkLYEFxp+LpOks/SAVjrKolRcdQxjhQKKFwelLpQjkUqg8qaOa5n5amjKf/Ou52pti7Q1I8cVmhjiiyglv2FNEGxurARzgOBjNRKQkPZHbt3tQO2/WPkz78r2oQiTdkTavJtIaxCQfl1qC76f+w/7BIupmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EZ+8pCy1; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EZ+8pCy1"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd049b5428so5666006d6.2
        for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 16:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823494; x=1742428294; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CW90axoo0o9jpPTk+/SEj4I5AijDX95SkVqF//3Gczg=;
        b=EZ+8pCy1b5Iv8gyVt3xRDvb6fknPtM29D7El+oqDFPB4nlAJdTHmzlgZkh+j+qcaRB
         ufXPokzwA3jOcyPOgJ6lRj/1FRB4O/U7V2SJyBLYKb7B1W772i+tNpFNThJGy3N3+af0
         utDAn8vAFyBooZrDMKhCd9AfaUxyCSIamTBv16Kdv1S/EMlW4dNpGQR47Xq8GYIjsZqb
         EtPLL+uSznx3rLfY6c49YpsPXp5XC13dnKXhidIXyRi7FXUZs81FZF1PRhXEiCiiRy2x
         PuTpWh3Fmrw55t+cZImN0KN865YapvUmZDmip+p7FVJ21KKka9e7P1l4Sze1kCyvDQZR
         NJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823494; x=1742428294;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CW90axoo0o9jpPTk+/SEj4I5AijDX95SkVqF//3Gczg=;
        b=TwfoxAADXJGvD9B4dLQWts8TQkjJSFt7UEtr2yoMO+YnYmch97OxE6GgfPNlzE/HwR
         CtGg6ghZ1ouTHcAokvoLatEV5MVnIv7tjxNFKQEiHkMm4+eG0241pNIUkc5PlwQcaMC6
         4RcPUYukd2ubfc8yVkOkkF+BCKeF78Em0LQBaF5O1ww6ujSLToa2aobhErdCm9Fkp13l
         smc2kH2D5H1CnO7gFgRwm4mS0osQ0qBM0Z6n3isv0tLDIDInWr1HXALmPkpn3dhjqO/P
         Ra8YCjcRFMbHUe0ZP7dKlmxDu6wFGPb247OlpQBgeCtPWAKmz6TSTkZc3hu5WcB9WYsM
         C1Hw==
X-Forwarded-Encrypted: i=1; AJvYcCV9IYbRFV8TACLLa69XrMhZMlx0SZZA2xleZzJq8FWGjrIZ/zqjZnahFv63D6WP9EUqvlVoanmvw/OmJtNpdajsz+70FLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMtGgN9gmhMvPed3Hw44KDUe9Jc7HqB/rFcBb6r/f9GGClf7f
	GsWrZ+J+Cm0xTcHj2KNKZOoQC/acGnPmeT3ZLJO1D60RjxCoRJKhJombeypI+Q==
X-Gm-Gg: ASbGncuAwjdIJSVCHZSS3xcj7/269gnJn1yGtKgXxsMhmZxurSdlmMTfSBeKIuZLQXH
	qJF4U0Ho7+bREDek5GSpnWMPvn1No0GGQgYbzSU4wsxSNlJFbvV0UCqpZzlVFuDpPvj50nUcf64
	dUuIXX3+hDAgQExKoZvO7QCl/8tamGzW24InxrHBzAWzTBAZSE4w6u7op6+NehPQwEaynNV8Kfs
	hViq10r/EgPE7u3E6V4NgV26zuhqlnhcOKCQ2qz1rPvGaEcsfb+tiN4tuIYYVYTyDhTFh62ztgM
	/va+hpP28i6b29uEwklArdFThnOu/FP+0AlJ64MXTRn5gE6RIf+paoFHcID3PbqDTy4+GP3IG57
	ThIPD2U2BFf43mg==
X-Google-Smtp-Source: AGHT+IFSqTK2ilUcKx6zm2i0BV+o8XNbFHCnS5If+1fP0sLk3byjVxocCH06FxErBK2o3HRcOC9grQ==
X-Received: by 2002:ad4:5c8e:0:b0:6e8:fb44:5bda with SMTP id 6a1803df08f44-6e900609592mr404688736d6.19.1741823494123;
        Wed, 12 Mar 2025 16:51:34 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade34c51fsm1722136d6.109.2025.03.12.16.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:33 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:33 -0400
Message-ID: <d3a295144441248d47fee124e30a008a@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250312_1930/pstg-lib:20250312_1930/pstg-pwork:20250312_1930
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 1/6] Audit: Create audit_stamp structure
References: <20250307183701.16970-2-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-2-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the timestamp and serial number pair used in audit records
> with a structure containing the two elements.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c   | 17 +++++++++--------
>  kernel/audit.h   | 13 +++++++++----
>  kernel/auditsc.c | 22 +++++++++-------------
>  3 files changed, 27 insertions(+), 25 deletions(-)

...

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 9c853cde9abe..2ec3a0d85447 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -994,10 +994,10 @@ static void audit_reset_context(struct audit_context *ctx)
>  	 */
>  
>  	ctx->current_state = ctx->state;
> -	ctx->serial = 0;
> +	ctx->stamp.serial = 0;
>  	ctx->major = 0;
>  	ctx->uring_op = 0;
> -	ctx->ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
> +	ctx->stamp.ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
>  	memset(ctx->argv, 0, sizeof(ctx->argv));
>  	ctx->return_code = 0;
>  	ctx->prio = (ctx->state == AUDIT_STATE_RECORD ? ~0ULL : 0);

Since we are now combining the timestamp and serial number into a single
struct, let's move both clear/reset instructions together up to where
we currently reset ctx->serial.

--
paul-moore.com

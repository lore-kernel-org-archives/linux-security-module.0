Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7065C605
	for <linux-security-module@vger.kernel.org>; Wed, 14 Feb 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936798; cv=none; b=tZwOdxD9sdCJt//2B4c0awHh6wZ+2q5WMlIsPKeqUBhRrpc9Zl4R3EW1FUaLKP+kJRV5G3wojYAb/3SUth2PmJTHtu9vOvbRzIqa9JvyLkSFTUPk1oPWpdSScYWRZQ20QcY1t71/LZDFDuHMlU/30GfDdCdNQ/O3tlq3lGHbmd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936798; c=relaxed/simple;
	bh=YB0WSEf01Y/V+3sTwuD+fxIA+EUO/mOnBcLiacfmF6I=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=VAWCnYBgrJBCCSWZBD4JT9CxTJqujZykfMbcHX/dQlc5azPEEYeYgfH1rrXXjp+Fezaalc2sfICKiv+17H+n2e2GmnMzhvQuj7yA0ij0pSm6g1sSCmId8Jr6hfEPGfkxUIRtAbXPANBOsnOs4PgfF6ir4sAMkls5i6SwH1NLSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GmqFbF+1; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GmqFbF+1"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d2e1832d4dso2291406241.2
        for <linux-security-module@vger.kernel.org>; Wed, 14 Feb 2024 10:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707936794; x=1708541594; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U7EX0BUU8eYmhs0ZPEmIoQh2Kp64rH+uh/MBL1tuL4s=;
        b=GmqFbF+1eCKxVFuR+Kyrsu977sb38LnrWY4AeZ4YUMCQVyxLwakk4NQ1ZpNhFHr3Uk
         PGSE5UOMKHj8qLZjPmanF93VmKGWjkiAvWTnhjY3P88Y4+6xb14uPjS8qC/oGWBMCTIC
         5Cdx6H6vOOhUBJS1BM6dti1loA91Agdp+8fjQVuPCVS5BCyjSl5od08u59k2Se46xi27
         RU7+P7+NmK/bK0Ffdz1iYP9NGzRzo3bY1+3l5KOKl9Z0TvVMcNM3S6WH3ve2jDPWt2/u
         2juXNx9h1j5Y7aJfBPEiWMq+wFuZXc4JAdUgk3MlhlndBVNqFbqNKW51pv211e5ia5w0
         Swmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707936794; x=1708541594;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7EX0BUU8eYmhs0ZPEmIoQh2Kp64rH+uh/MBL1tuL4s=;
        b=imaYFdWJg0dFOB67/EDh06xkg7XTlHZ28a40+pl/mZy5O5zv2X3D8vuNgT4ZcHOKBP
         E1j3g+iIODriJj+A4afvlmIvckw2XaeZrx1Q2PxqxGxnJMeLU9shHi0XBZvmXpNCMhc9
         WzJF+SAmUj36kbVXARwvIhX+uU/Mks4wClIClYP+L7GVPenQGYeWJ+ebXsfaGw9Lk49G
         hAFkqagP+hO28WSu5oGC3SV8uITfqUCwCh70hyqsJ9L3QWOUT4+q4DXwQrVcDf4Aiqy+
         ELg8cTAeZx0zRZCQo3W+rTcdl/Qh2L9Yp2k/1tcTe45uRa6YfoBMAiaVVwJFNolegNfI
         dUJw==
X-Forwarded-Encrypted: i=1; AJvYcCUd1KbV365OnKCGSc4YhqE2fHeOLPgK8I4CfVihlOO6gfX+esV9jtaLuf4iFCGd34/Mjb0tgtetu7uHDfxCC/Wa9hMAx6m+/hFZNjQ4CmOBdrCJzicH
X-Gm-Message-State: AOJu0YyARqjlq8asg1Ba5Wky+HCi+hhMg6io/fL3DCdyg+Cu1Rrg+xSw
	zsJSLjEbUSlyjkGDPlWQg7DLZ+0IauMYbBbUsBvNz8lbn3lCt0TPrh6ABCyJlQ==
X-Google-Smtp-Source: AGHT+IFE3dcYT/V2vseHwfI/QKGAhtoiv7lpaXvutbo6pW5L51Jt87o/Rt6W4ld0LKTeyp5DB9cqIQ==
X-Received: by 2002:a1f:d986:0:b0:4bd:3433:aac with SMTP id q128-20020a1fd986000000b004bd34330aacmr3156328vkg.15.1707936794508;
        Wed, 14 Feb 2024 10:53:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXIWXDO78A/kdG+CESi3cvOFauyQKoDlFtG4hFccN+h9utfaGjVgINu6NGQywVXm1XZTduZQuRt4VMbk2TJqUWQRgiusXQJQyNFSgYfyR3xT0nLnJnF4IEv8tRuCMd531L2GhbHjeECt89qI4vouDAXu0V6lQ+gt1DSUpfs6IYE6P66sTfa4pzzrNCKl4DYeKthIeK1RbmNbgcK22Pz+lUyFM6uzKnjHctyUD9C+ZRxNGFufQxHUmre6QrRPOVjE3Df8yVvHrlrIKSEPU=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id od9-20020a0562142f0900b0068c9d0561d1sm2523643qvb.83.2024.02.14.10.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 10:53:14 -0800 (PST)
Date: Wed, 14 Feb 2024 13:53:13 -0500
Message-ID: <1e24f1ef83614516c995e1cceccba6ff@paul-moore.com>
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
To: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] security: fix integer overflow in lsm_set_self_attr()  syscall
References: <20240214160538.1086089-1-jannh@google.com>
In-Reply-To: <20240214160538.1086089-1-jannh@google.com>

On Feb 14, 2024 Jann Horn <jannh@google.com> wrote:
> 
> security_setselfattr() has an integer overflow bug that leads to
> out-of-bounds access when userspace provides bogus input:
> `lctx->ctx_len + sizeof(*lctx)` is checked against `lctx->len` (and,
> redundantly, also against `size`), but there are no checks on
> `lctx->ctx_len`.
> Therefore, userspace can provide an `lsm_ctx` with `->ctx_len` set to a
> value between `-sizeof(struct lsm_ctx)` and -1, and this bogus `->ctx_len`
> will then be passed to an LSM module as a buffer length, causing LSM
> modules to perform out-of-bounds accesses.
> 
> The following reproducer will demonstrate this under ASAN (if AppArmor is
> loaded as an LSM):
> ```
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <stdint.h>
> #include <stdlib.h>
> #include <sys/syscall.h>
> 
> struct lsm_ctx {
>   uint64_t id;
>   uint64_t flags;
>   uint64_t len;
>   uint64_t ctx_len;
>   char ctx[];
> };
> 
> int main(void) {
>   size_t size = sizeof(struct lsm_ctx);
>   struct lsm_ctx *ctx = malloc(size);
>   ctx->id = 104/*LSM_ID_APPARMOR*/;
>   ctx->flags = 0;
>   ctx->len = size;
>   ctx->ctx_len = -sizeof(struct lsm_ctx);
>   syscall(
>     460/*__NR_lsm_set_self_attr*/,
>     /*attr=*/  100/*LSM_ATTR_CURRENT*/,
>     /*ctx=*/   ctx,
>     /*size=*/  size,
>     /*flags=*/ 0
>   );
> }
> ```
> 
> (I'm including an ASAN splat in the patch notes sent to the list.)
> 
> Fixes: a04a1198088a ("LSM: syscalls for current process attributes")
> Signed-off-by: Jann Horn <jannh@google.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Looks good to me, thanks Jann.  I'm going to merge this into
lsm/stable-6.8 and send this up to Linus soon (likely tomorrow).

--
paul-moore.com

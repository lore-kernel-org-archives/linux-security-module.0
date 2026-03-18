Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC3366064
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815404; cv=none; b=qF077zXX+CNfBSPPWTCaVfq3du8Tz5KO4PyfJswkNc/E+2Zb3YhHcWBoUoCPOlY3+PZVOVGtb48Qmry8jrmPTFZZtVtlPZ/s/i5utDm6I2Ujf0F+LqEEnhMW2sgtKO9tAcbfbqNmSrLxrXpEBn/wkBKviqrMCujMwVscNmxsiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815404; c=relaxed/simple;
	bh=515SINgI6kqm7ZSbI9U5cU8WIxH3ZlFlRVE7vDStyIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYPYl/YHPrqBuqUN583UD/6XvuGEaK7Qa/Dv1g8doVbuVYkpOtj5eE7fHbOXW77mIN8SHs8aGsSSVPWMMD5g7IFmcUa6ZAWJ5cPxp1+HyuQTFJVPJg/pYf7YdCrbxfYhLX2HQsgeShbMZAfuKzZ8HFOHIzp0gm2eqUwQHu78neE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=HA7Lp6NB; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="HA7Lp6NB"
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A57553F604
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 06:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1773815401;
	bh=K88Jm+9X5McxqI8geo6x88kcpXettytsIvZ/5tL3nOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=HA7Lp6NBwZRF0FnsmHLp29+VevhNkf9+CzVsdnP7LZToZTZNwwaZAMAi23B/cqrfS
	 7WvCVpRwr2zVxZnum4g9DAezdwqNSu1tiJvI2VGmNrifmdikZdPpo8LdXYktODJeDq
	 ljBRwfB9rSuFKjMDUVNpe3wYKhQFGIxMcbm4f9MNOsWUT+elp6iJ6V4+YD1h86vz0T
	 cNbvm83SOooV1gdZBDW95iT/q6ROwo0n7pvHF9txfmpXFfeAbglRJeAuWJ5xTGn47z
	 S3dP2rcJfTCK4E+3l7UCcMMNitNwM5c5q928chY5zd6nOITO6ymU8M0zYvE+4gfr7E
	 Htkf845ML+2BQqyeWozerEG9ibzHt488qfPjCUvLi5fmbadKeGcfwZUGkfNT0+r6t+
	 S8zeNFTYtoCPUDaOikFOylZaZC+I0Qpz6okwRiU3Zh/FjoNvj1mX8uTQ/9pFnRUDEf
	 PAJvghLWR2rx0gXQg7Cr3aqgPnenZytVZ8JSksCAbqK0mEgqsFYEW9Mm8Ac7ch/0vA
	 79EgYWclywD2s/Rr5hlKXMT0cmSA2WSrhlp/LwLSidyGt/FxP9vgROgxiJfww/Et6d
	 UrA9OFEwjASSddEGuOyNO3wEmyy2eqFbAv6KOq+gpKk5XsFcomaCDEdkq7yw0aI9VQ
	 3Bk/rO0Yx+V+Kap+i6M6jTB8=
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b059511554so178881805ad.0
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 23:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773815400; x=1774420200;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K88Jm+9X5McxqI8geo6x88kcpXettytsIvZ/5tL3nOc=;
        b=TNNvkWgGB8osajZ6WeG++3OTIOd9LYmVSpmzv1904gV16ZKjXimMreUzLscv44nVZY
         JzUls89/3KGHXEws38OX1TDOB6IdSz8ZVYwAbv0cgrlYefG1jWj3O+TdHJgveEcmy+5g
         B1itmuwsM25Qurk84RoLQEK4nj/CJ8XwFeJSU7BQutzWUwTjuuimN9UciQmi24oqcB4Q
         oE+HQJ+ywMT8cAnnXDqmErzT5Y7fxm//glWnzcZMS56oppwFNsYvlvDsNfaYrtsXHhGy
         u5naNQCQUtz7kNzx7k8aGdhFrF42unQ48GzPyS7Nr1/dvVdu8PAPu3MMd8jDvj7fYPkv
         W0sg==
X-Forwarded-Encrypted: i=1; AJvYcCVSnkP4YedoBhH6C9M5HdWBp5wusHqFtL1USseKyNcLbGQ3qTqqntL98HfYPEE7YZSihtIMVK+piZRI0TaB5Nd1IOxweNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYabuRLuDNEG8EzCv1gk4Fks2xPTJEAhmnmPYVqmjvcg2RhtDD
	kr83BSmIwyDqgau/48rpEQDoi0IYO60HqsZOwq7KmAcbBGU+qihlIs3D08SyFVy6VWVEOgvCwBZ
	y/JAZ+P0eQX9D52/xePggxhY1Agro+vm5gg084dG/GB4O8ilA07tB29ZFqxFNyf7Tc9Ay93An0V
	/71w4/40MXqwq8ZhyXSQ==
X-Gm-Gg: ATEYQzzfJkTQtn0+oQxHB53UhNPItwJHbchN/SMsPOHH+h1wshoa8732uXZFso77IEF
	6W4V6PXMLhJRt3+nMgk/fm+Z9Cezig/Qg34rrU1ffSktrEgXX1bGkCGjAiPnFpJHMNOTLOlqqom
	JqWlplUh97qhWKY87uv66kDFHVlPUjS461uTwhf/JDSnovzEZEm3ul3k3LODrM2a0Vh8aI3LFXT
	OgTbCLj2uHPD8xmBAXrRYNOhE7OTPd93iKnX8pbuLVFN4NVrJWDMWCEc79TdNUdgOzcUKps9EZX
	/AXXJ0B8C9C83p5qSKjgJ7oAAHutHYl8MrOhkkX5LIKW0EkWtgANYMSj4zgS3Q4Sso673UiTtoB
	bk42LFjar3YWaIxoaGMRd5OGcnXn/KHK8GQNuWg==
X-Received: by 2002:a17:903:1986:b0:2b0:6140:aa65 with SMTP id d9443c01a7336-2b06e3ca13amr21714225ad.30.1773815400298;
        Tue, 17 Mar 2026 23:30:00 -0700 (PDT)
X-Received: by 2002:a17:903:1986:b0:2b0:6140:aa65 with SMTP id d9443c01a7336-2b06e3ca13amr21713945ad.30.1773815399923;
        Tue, 17 Mar 2026 23:29:59 -0700 (PDT)
Received: from [192.168.192.71] ([50.39.102.197])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b06e5f12cesm14146285ad.41.2026.03.17.23.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 23:29:59 -0700 (PDT)
Message-ID: <add84d74-27af-45fb-8fe1-c172a2f21cfd@canonical.com>
Date: Tue, 17 Mar 2026 23:29:58 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: Use sysfs_emit in param_get_{audit,mode}
To: Thorsten Blum <thorsten.blum@linux.dev>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260222214038.287814-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260222214038.287814-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/26 13:40, Thorsten Blum wrote:
> Replace sprintf() with sysfs_emit() in param_get_audit() and
> param_get_mode(). sysfs_emit() is preferred for formatting sysfs output
> because it provides safer bounds checking.  Add terminating newlines as
> suggested by checkpatch.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Acked-by: John Johansen <john.johansen@canoncal.com>

I have pulled this into my tree

> ---
>   security/apparmor/lsm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index a87cd60ed206..1250192f7b12 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -17,6 +17,7 @@
>   #include <linux/ptrace.h>
>   #include <linux/ctype.h>
>   #include <linux/sysctl.h>
> +#include <linux/sysfs.h>
>   #include <linux/audit.h>
>   #include <linux/user_namespace.h>
>   #include <linux/netfilter_ipv4.h>
> @@ -2081,7 +2082,7 @@ static int param_get_audit(char *buffer, const struct kernel_param *kp)
>   		return -EINVAL;
>   	if (apparmor_initialized && !aa_current_policy_view_capable(NULL))
>   		return -EPERM;
> -	return sprintf(buffer, "%s", audit_mode_names[aa_g_audit]);
> +	return sysfs_emit(buffer, "%s\n", audit_mode_names[aa_g_audit]);
>   }
>   
>   static int param_set_audit(const char *val, const struct kernel_param *kp)
> @@ -2109,8 +2110,7 @@ static int param_get_mode(char *buffer, const struct kernel_param *kp)
>   		return -EINVAL;
>   	if (apparmor_initialized && !aa_current_policy_view_capable(NULL))
>   		return -EPERM;
> -
> -	return sprintf(buffer, "%s", aa_profile_mode_names[aa_g_profile_mode]);
> +	return sysfs_emit(buffer, "%s\n", aa_profile_mode_names[aa_g_profile_mode]);
>   }
>   
>   static int param_set_mode(const char *val, const struct kernel_param *kp)


Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71C29D287
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815515; cv=none; b=TCzcDoBYYfzdGlQ5rLK1uaT/XTNnrI0IAzi5VWuO2FL08XvD5SsPn7j90xm+xQOFvk8pZYqczdh7nQ/x+6zWtwD8xdGvQgp5Uyoo3UJmGvBiuwSBOZ3vmVsGmbV23HKqloX80G4fEF3VWzDhcWvQn8qAK/qtzqRYSqW5Ja6OJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815515; c=relaxed/simple;
	bh=axv6vZl0GVTlzKcIZ4eSepd993smWSMA4mc9NkmS698=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3r9V+6YDlO7QP93qz9Jak1Him/dtUf14LLkUp0SoUlP9qxsvuCTEhkEeQG3CHaG4ITfq0YJ0e3wcvsD6pHfF+IBkEUDqVEe2p/OOllTlbPMeD69hP7AVfQzBP0XRjGZAt94QazdcDCFVqFHkojG/ndy2Zs2drSQ2pNNr4+Heug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=YiQib5tZ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="YiQib5tZ"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A10933FB75
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 06:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1773815512;
	bh=EML+XTGUQs60PcdBYA32Jysi6fX2cPvKb7rTjuZcNxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=YiQib5tZjI3up7JoFGouoKC2f0EINfvFkmxNSW3pdzZ4jU2lVeWE9FMDdUbJ6NPCR
	 6+Gf7gG3ieBzLYLMcIY/4MuFgN2rgta0mMloeeGXiIPwmQ6s/1Jn5/bPfMHV1Ol6DJ
	 faKIIu1CE98dUblJwgPEzWAYisG4+WYifSuA2GsQ/2sUXArTKM0HztsOm6C+o6OCCS
	 FCjIf1UZeCeiOD7DHMyoEMgEWBHfk+q5VSCcOlxBJ/Svn6VaWlGeiDWizzXjPinujJ
	 kYwNi4Uwbusw6UE4Bsmq1x113oY5tzRZ5vbJxM5Edt61LsLGsY2rghYSBZhZmsaNqa
	 1dJmFl55QxBOGSUepZ2YxehxWiYwTx7j/2QFrQ4nHX/j+GDJ7zMhirU6KfGMHdSoX7
	 ydMeWV7WJs0V3KBbbf8RVvaQlJsQRqtI/WA1U4Xtr77bYvv7zfFlagREWf5vRTp79t
	 XnMjV8W7o9wCi6q58vw6AnnzUFEz/guNPbqyXXBdgdcNyxZHSkqTUFJURrwRDP3c++
	 kqgXwKa5mT5L2XB0fTa6l8wwlNrI4IDR5B9NRCcmCEhNA4/VbHv8jyA7/F/mqqfFhu
	 f6E5mK5dlGJ25bCzJl6RYD40A2YiYzbgtRosMF0jSkng6AtL8qdJ9IFs+079gAgYbY
	 zTh6gRk5jMAM4z43zBXTulFo=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b061868724so144577125ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 23:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773815511; x=1774420311;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EML+XTGUQs60PcdBYA32Jysi6fX2cPvKb7rTjuZcNxo=;
        b=SnqlMss9eClaJtKhl4blJRL8YVS2GuOGiCpXzE+t2OMpd25KNuIfSf4xFFInIyajim
         0uc2OiwtzARtJfSFlFeDRFrS2gFKtvfjuIgRYRpe1lH2bDTw8zTNVTaBREkDvvf1lnS1
         ckp9Mf0n8HBsYTaGygcxvjJoCEKmSvjB7O1gvdxXB3ApJI1NnVXHSZnayzBDRz5jXEbc
         Qw31YNwEIFelPqQ8kbPECkXTKJ9EhtjJaNngWvvIAgv12NymCo8grlg4vlgm60dDpLTI
         RsE/ZDUM+xDjG1He1S5MTNc2FQApZRTP7JOr4V3lfS9AefO8Ratm0nRMT8T7s5SttQJ8
         XTvA==
X-Forwarded-Encrypted: i=1; AJvYcCWsHGReB/kXUPl6YwqX7ng5vrtj0lJqFJAWr1VcCVxbGKhi7MrvawRcj/E3imFhl6QTy6gL0N2214F7RjQtEdF4s4cYNgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrNM0fjG0eexZI+ptBSsr+VNVGDSIhANonXGFFzOtvTi1qTqh
	92+VPdNQi9hrr1qu4LL20ASTC2lKyldb3zbUSRM2kn+hlT61sfp8MyC5vWiilg3sYF83dyMLKPK
	OWV1t580S0QZH3YrnX0yBqWFCOVizFUdRGWM7JFHopXZsKGU+w91dCF1b9FKgXOYXWZrAkhQqME
	/e6+Q6YXwCbfgcnqtXtw==
X-Gm-Gg: ATEYQzz6Wu+rLILWM1S8bV7NpH2i7E08njm/QN/O102QRPAuqVMEHXQTqzkA17PBoyQ
	H7wab4ZrhuYlvJn0b99jIddvn7Jx80dAunUG5rsoAjor/ZiW/r659a0b7+pUhcJA9KO+NKHpfC2
	RPOs8t+pU3QLUhpOFoZWUi5m6fKvMLTMDuv8Hw48DyZgM5Aa5zBxArFOWo0stcAozwrKIcP0lSB
	a04a5q1W9o7bfd+PGfgIadRQIxw7VyBxHunSR4HG3xqEOAWrpLyq7N9Y1/HN/W/n8r7CqLZCOIe
	vzdnEKsYKhIUQfz4xf6PmyIjYcWUq8pQmObR94ZJLLJMljppLz61KvrVhfcWqQAc1ui1c5X5Pqr
	tt1JtkhUc2FhGxIaAQKVsar5dsFBNl8g3U84d9w==
X-Received: by 2002:a17:903:1a0e:b0:2ae:59d3:27f8 with SMTP id d9443c01a7336-2b06e364b30mr23360215ad.19.1773815511311;
        Tue, 17 Mar 2026 23:31:51 -0700 (PDT)
X-Received: by 2002:a17:903:1a0e:b0:2ae:59d3:27f8 with SMTP id d9443c01a7336-2b06e364b30mr23360065ad.19.1773815510969;
        Tue, 17 Mar 2026 23:31:50 -0700 (PDT)
Received: from [192.168.192.71] ([50.39.102.197])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b06e419b22sm15820985ad.11.2026.03.17.23.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 23:31:50 -0700 (PDT)
Message-ID: <6e51ba11-21e1-425d-851f-60916deec6ba@canonical.com>
Date: Tue, 17 Mar 2026 23:31:49 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] apparmor: Use sysfs_emit in param_get_{audit,mode}
To: Thorsten Blum <thorsten.blum@linux.dev>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260318000758.1568-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260318000758.1568-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/26 17:08, Thorsten Blum wrote:
> Replace sprintf() with sysfs_emit() in param_get_audit() and
> param_get_mode(). sysfs_emit() is preferred for formatting sysfs output
> because it provides safer bounds checking.  Add terminating newlines as
> suggested by checkpatch.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

this has now been pulled into my tree


> ---
>   security/apparmor/lsm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index c1d42fc72fdb..cdf19a5e7626 100644
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
> @@ -2073,7 +2074,7 @@ static int param_get_audit(char *buffer, const struct kernel_param *kp)
>   		return -EINVAL;
>   	if (apparmor_initialized && !aa_current_policy_view_capable(NULL))
>   		return -EPERM;
> -	return sprintf(buffer, "%s", audit_mode_names[aa_g_audit]);
> +	return sysfs_emit(buffer, "%s\n", audit_mode_names[aa_g_audit]);
>   }
>   
>   static int param_set_audit(const char *val, const struct kernel_param *kp)
> @@ -2101,8 +2102,7 @@ static int param_get_mode(char *buffer, const struct kernel_param *kp)
>   		return -EINVAL;
>   	if (apparmor_initialized && !aa_current_policy_view_capable(NULL))
>   		return -EPERM;
> -
> -	return sprintf(buffer, "%s", aa_profile_mode_names[aa_g_profile_mode]);
> +	return sysfs_emit(buffer, "%s\n", aa_profile_mode_names[aa_g_profile_mode]);
>   }
>   
>   static int param_set_mode(const char *val, const struct kernel_param *kp)


Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3819C542
	for <linux-security-module@vger.kernel.org>; Tue, 20 Jan 2026 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768869888; cv=none; b=YGk/X7d88K55Sa6IeEZdpv7J6xnQ7bOADJQpTYf0cCsyNPFWEpCW69mx8vK9O4mq4dmH6zT9tpsGG1Ey3YcpvJqKEP1D1AaFFf7av22tIXhxHyOmkcqB86eOeOJ0WIhe9lzn9FDYtUF8O9Pz+GYN3GLQfWgUHkY7aHF9g1sw3O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768869888; c=relaxed/simple;
	bh=+NIglS3pdsarHQFge5QrPnZvIwHc3vsAkQ43tYIiWXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jw1sD342Wt1uqtl8j/zCVeg+AMdgh27G6YvZoLs4W8xUFjKMEFcNAQnSEpcTBhaHzhkHJ0hL7k+tfV/kxTMM82RDj+UAE7zV0KqY/OsDZVNcnzXMDv7ws/lvD6voIXCHCsAqqbu2POOmuwP6zuqtEvgZfMaPEkhO9VPUUDxbJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=aTlOmiYN; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="aTlOmiYN"
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5E7BB3FBCE
	for <linux-security-module@vger.kernel.org>; Tue, 20 Jan 2026 00:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1768869878;
	bh=QYIUKitptevaGw1P3/4y8IjKDAu5WlM17haDrLnfc/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=aTlOmiYNTchPSZS6gSnxFsq+kY7r5dtFvPt1cbSn9YM9Cdo6SiH5esbjjtmfSx1Tv
	 sX9RGWLzwKzlp/KgYTSJBLyvpb0K4TeXU5OeBeoPUweTlS+mtJ1rgcSUG9Mi0mUiNJ
	 zRYb33kbaIt628bBGOkOXaepVY4ngICdvne+8wRlW724qvJW4yWAZ9gFAdHtmR8ZM3
	 OKCxbELXopnfqpHxPgW9NdgKOVW+vGBJPbL2onfiwJ7n1zYzTmUrugQcTuNaBVUyoD
	 LXRm91Syx5p+juxr+SdZOptDo7p5FeJLKfSmFXg7nxnTgfaHrp+nilovR1EbxNdAo5
	 q2UlqkzHO4Q0My7H7BaKFusZXAsjFukAkmIXQ064xWM/NRvtK3ca9++oPXmS2ALYTl
	 uxx7c5NchaU379z7a3ghVvVgctjdTrWW+D+gtragL0kaw4wksgtgiqzvBkv5uQDpir
	 cJgkr19bxENL6IfzkywviMUeUV94waohPd0wEKgg/4Wv1H6QiCkyLBFjqA1/ssIgjU
	 nJBFV89GM0j84tLO9YE+uBbTwLwmD79/NLZ+Oryn8QYP69v7xOwJ8Nyk6ZVvRYngtT
	 gTrf/a/Im2uLC0xkSfBxyN9RASpCJWMWU97dUVCBr7Ecg/85csXGuQ6UUdDwycZk7+
	 1pUlfr1l+TWTqCqzY+Z8fDwA=
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c54e81eeab9so2952963a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 16:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768869876; x=1769474676;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYIUKitptevaGw1P3/4y8IjKDAu5WlM17haDrLnfc/U=;
        b=CMDuOUfVeFekbffB/8vkz8RIlmdjdkwIjFXUh7Hjf8Kuzl7EU0hy6TkbHV/PeKRtK5
         PzJJDs4O/omQmjcYPhV1OpII3cFB/jNjUztMyAwAyHjPFs/EYCDRPm/skkFXOHTp2hg2
         5Y6UJ5wU9BVx5OeEK0c7rg402RxpmEMr+miBxzlbxdl9EUHfp7teaIiTBfrcoIl5KPII
         67lQwUbDKXjry0ihKsVpdsWpt+kP5vAPJ0Z39VppypWfpOmsJMXmQzkQj4uIzXh4SrTu
         yUSnnQ2APi+joICMgwZpONNpW+y8dmOltFrHhDTPG7+Wyhh2x06bVvIbJ8BhXXLSDJ4N
         XlGw==
X-Gm-Message-State: AOJu0YyLSl4vrN0unrwII6SvWe8wWXQ8qn+IklHTbzwrAf4W4hOksJBo
	6SDmnYzkOKi80IO7tUoBvRwfsD54qfOekQJhAWkt8vytcQI+UuOr0aN3WE3Y+1CEbIx/G4ZtFa9
	UwIhJd71mPv9robTksIKxIQz6WJ4miP7xVcvRdSnSaId5rLphDR37QByA/stCLp7kN36QopH5X6
	AOtLCR3nlxa5Ai2yCeoA==
X-Gm-Gg: AZuq6aIuk+om11+yy6kcZx1f03uYgxKD82HtLkMBjXVChn/GYgliarZVRouL9BdGRL9
	dMQIJfVolAUf9P7pKPlsh/piI0D9PK5yciEsLXdZEfebcjeOhu8aYi6z5JPNx1Sgd7DqIJJMkqW
	ZiPQEw4AiyGMfA031AJ7ol+3DD+1elbQODVD3M5DTMw59CyqAjBDMnFyicrP2FCSWZ5KO4M6rKo
	tTJH2JY8auQutJ0v+/cyaTQPeDO7X8E8isYUrWxipJm/5i76NvW3eLdYmEpOtiCBJRwW9xOO5ow
	a887aS3Zgc16Y1mbMVs6UHqHXjziAHUePjcI36bILoc6GTdCrquGLsTfTVFL/NuhRK+1DU1rkyq
	L87dogc5zJZLGoqOjNOggUYKK
X-Received: by 2002:a17:902:da8c:b0:2a0:bb0a:a5dd with SMTP id d9443c01a7336-2a7177e99eamr103222915ad.57.1768869876687;
        Mon, 19 Jan 2026 16:44:36 -0800 (PST)
X-Received: by 2002:a17:902:da8c:b0:2a0:bb0a:a5dd with SMTP id d9443c01a7336-2a7177e99eamr103222825ad.57.1768869876264;
        Mon, 19 Jan 2026 16:44:36 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a7190d14cfsm106460445ad.38.2026.01.19.16.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 16:44:35 -0800 (PST)
Message-ID: <35869346-9eed-4120-9e4b-cdc1b04dc844@canonical.com>
Date: Mon, 19 Jan 2026 16:44:35 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] apparmor: avoid per-cpu hold underflow in
 aa_get_buffer
To: Zhengmian Hu <huzhengmian@gmail.com>, john@apparmor.net,
 apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260120000307.369587-1-huzhengmian@gmail.com>
 <20260120000307.369587-2-huzhengmian@gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260120000307.369587-2-huzhengmian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/26 16:03, Zhengmian Hu wrote:
> When aa_get_buffer() pulls from the per-cpu list it unconditionally
> decrements cache->hold. If hold reaches 0 while count is still non-zero,
> the unsigned decrement wraps to UINT_MAX. This keeps hold non-zero for a
> very long time, so aa_put_buffer() never returns buffers to the global
> list, which can starve other CPUs and force repeated kmalloc(aa_g_path_max)
> allocations.
> 
> Guard the decrement so hold never underflows.
> 
> Signed-off-by: Zhengmian Hu <huzhengmian@gmail.com>

thanks, Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into apparmor-next

> ---
>   security/apparmor/lsm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 9b6c2f157..a6c884ba6 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1868,7 +1868,8 @@ char *aa_get_buffer(bool in_atomic)
>   	if (!list_empty(&cache->head)) {
>   		aa_buf = list_first_entry(&cache->head, union aa_buffer, list);
>   		list_del(&aa_buf->list);
> -		cache->hold--;
> +		if (cache->hold)
> +			cache->hold--;
>   		cache->count--;
>   		put_cpu_ptr(&aa_local_buffers);
>   		return &aa_buf->buffer[0];


Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E042361DB3
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773813565; cv=none; b=EZwMR+DeRQYDnv4n4xaRPPcI2d+qipGpAYqcX3uuZ+vq9BQu1l1T6assrQtxGbqDw+5XbyjJgze8YUMED3hXpCL1kjtDxND3YsX4i6ZVNzFfoT/etu9uJwjGONyjDvMUlJm/bkk0XrmP/bMYpELdQu60yTnqCgprz+pznb1s/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773813565; c=relaxed/simple;
	bh=d30czZRkc2XcvtgLp/ml4rAGkzT+vUu6xrXY6kq51vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+B1qJyaQs+xBrjdEfrOt8+SLKB4EYpRXX9bbi05kRXuxLMsx2was67mCur4cLQ1UINFc4tkTYgVJ/upm1wg30u0ac0Ogy/1BJhYa2h3HdfULHavDskxSDYJjh7pfw8Buoji06RAaGLevz5taJdLFbxIxcWRgA0AnXAxUWzlcwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=osYvrhJ/; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="osYvrhJ/"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7028B3FBB1
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 05:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1773813561;
	bh=HnYxWZf82VZYFToxxlKhf4jSSNuvzsDXOVG4cgFbtgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=osYvrhJ/6x8DCgS13rclDQ/qnvBn3Rt1LB13wnTu3JMi+Q5Ir0U6e0h+mnNBfd9wN
	 UyFBoo77juXzo09Z+Qcvy5JTmIaBpP7EXS8V5zDklNgbDufbym5d/60Nwkyp9wVyPV
	 s2pVthwHhWHLq4CKW9wb1UnAy5Uiu449hgGFsH9M7rCmI7apPr6FMLZJFithHKBWFP
	 ummuDHIT4ox7NdgaR/MOQEfOPUX1HMPYh2lQIE9dJU/gun8unEDEF1jrzuklzCUx1d
	 pDp0AufktKhBQcMKJOR5j36P84o6YRrHtp/EETqBuPIpzxsGBiPjZN8BhJZrHFiAUv
	 d9VPV6mhy4tv9W1s5QvkoqBvD/9ESaHYdiRggW8gqAeIusWM12ZNqPJzQw7sJo5JuK
	 Um4h6MwcjIW1IL/aGsi8seqXe7SJR1z/OUHLpaHpqE4wq4x1XBax/IYtaVDFP997vQ
	 12bip3F5zBlpxUcHXjr5cuUM5aYR9iecz9HsR0+PrHOXJxKpgSJp4KUigEKcf4lth8
	 IdmYo3QTEyRe5ZHxMwsfQjxC09VReRyEEGS9YJGgMpbyrrtaliTdp/6VL5o9BsP91P
	 o7Q7zK8u9MiXtzyCtqWIvWi5tNPonCGJkHEQxyONuOfrBqCkhdliscF0SraUKTNptc
	 ZDriHc3Es5cZzdEE+oLyXV7A=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-358e425c261so489122a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 22:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773813560; x=1774418360;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnYxWZf82VZYFToxxlKhf4jSSNuvzsDXOVG4cgFbtgw=;
        b=lM+Dt1PK34BiaK3/e/3SdsxAjlPMWVgtpmoP+qEdhHH3ifA9qSavWfXPUFu1stLsQU
         /vlgsvXtfvKRPRRUsxC0H44HZHU5YvDaqLbDcyJoBpACqUD5lRVlk2GOD2MBkJXerhWm
         oQFHOUQdxT5TpI9NymtorVJqdzSxxpvPS7sfSWqA6LnXSxGaoIpvyZSdE8cQsRZeZ9to
         mqPIuQFonh94i2iFAPGUddc/+cNVsgnyK/qI2a792sWkglTMfJSaKwwWktscyd8A7USl
         U2d9qI3Ch92sQ4fwjmeGtcheK95wO7+jwxzVR6euP/cSFZM0rM3/Xs7Acdy0+gFzYJ0T
         idsg==
X-Forwarded-Encrypted: i=1; AJvYcCWBbJU2gYinu2PmTSg4YgqCVpzk2Qwyc0zy3j63Xso8psaprd7aYGgyiWAEwyZRsi1QLd1lmvFrz0RWKQbP87zh+ol4B8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+2RAiBY7mpFL+zeRclss+YHeJX63iTkjlfMjyiQTX6tVBVkKZ
	Nr4CxMqPLzBnQ1+COX8Lgomi6BzkKMNueGth/hjs1KQJrqjXEBNhwfzRSvZ09I96U48FsRBxbgX
	rPdSw4XXNAtrMw0x2B+EMyqU0Owgy3eEZmQ7tGqMpOpOTf57AhJtSzIEqgm/Yu7KMLR8WSiTscc
	LZ6XLyTFdLr8k5/NG0qw==
X-Gm-Gg: ATEYQzwaLGvEw+n1WWLx3JdvBBOS5KnZUzq/Oy8Tu8bDuPwle4UKmPnRA3qrKQnzqXc
	8sHY+LuIENyyr4PA1v2f11JQmQqFfHloOW2tnZekwwU5vaZa7gTVFRXybPfMjjm97MrGI8wsm5u
	WUC/16jVFOTpXcUQLkjOfd5CT6gsdFOA9ayQzh2sIFHkVSr7u92saLBUgDH1CQNsu0S2jBfdyI6
	1YJ1Hj+smy9iSVQDn8eLVxfL8w56iFCGZK1ii8XvKQ42JXfUAXzKfXugQUsEsFUGBl2fft2srnf
	5WUQenxW9lXL/lN6gmBxpHnJlO4qYS1ToXz1zUXKLvpfaZ0mLFNBwFVMW3hpTQ9bkFZha5+ZjBw
	7tU2lFXVjdjwDV2juaUwKgNdLHAyYs6DtElzc1Q==
X-Received: by 2002:a17:903:984:b0:2ae:c88c:197 with SMTP id d9443c01a7336-2b06e34520fmr22225895ad.17.1773813560048;
        Tue, 17 Mar 2026 22:59:20 -0700 (PDT)
X-Received: by 2002:a17:903:984:b0:2ae:c88c:197 with SMTP id d9443c01a7336-2b06e34520fmr22225675ad.17.1773813559709;
        Tue, 17 Mar 2026 22:59:19 -0700 (PDT)
Received: from [192.168.192.71] ([50.39.102.197])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b06e603b2asm14262025ad.55.2026.03.17.22.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 22:59:18 -0700 (PDT)
Message-ID: <717f90e0-41cc-4852-b3d7-5ea3b975bc95@canonical.com>
Date: Tue, 17 Mar 2026 22:59:17 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: Remove redundant if check in sk_peer_get_label
To: Thorsten Blum <thorsten.blum@linux.dev>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260204220734.1008069-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260204220734.1008069-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/4/26 14:07, Thorsten Blum wrote:
> Remove the redundant if check in sk_peer_get_label() and return
> ERR_PTR(-ENOPROTOOPT) directly.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
>   security/apparmor/lsm.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index a87cd60ed206..54343f7c96a4 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1536,15 +1536,11 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>   static struct aa_label *sk_peer_get_label(struct sock *sk)
>   {
>   	struct aa_sk_ctx *ctx = aa_sock(sk);
> -	struct aa_label *label = ERR_PTR(-ENOPROTOOPT);
>   
>   	if (rcu_access_pointer(ctx->peer))
>   		return aa_get_label_rcu(&ctx->peer);
>   
> -	if (sk->sk_family != PF_UNIX)
> -		return ERR_PTR(-ENOPROTOOPT);
> -
> -	return label;
> +	return ERR_PTR(-ENOPROTOOPT);
>   }
>   
>   /**


Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637D17B425
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768867007; cv=none; b=cFOyJGA3eUVaSk1dc70RuKUdR8fk25P9ZeXC1hifLwqQLDsI8Du5zRXyhLdOGFiyM+lW4qc6EViBf9tZ/AqROzdtpp9eKpJN/sNzChH643w/UGJ/rj/7r6rJmGbzAfZyDlwuSbZh2tuENRJj0K679EJpsaZy9ECb8Mbq9xl310I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768867007; c=relaxed/simple;
	bh=KhzhJtGC10qYkuuIhrEWCK3VzSCAsBoTsuiM9++BCCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzm8R2Seupa03gm9Q7APs1v691DVQpL4bLkpi+KAZG3uLUdggcnULzYwC51FxvEb84/7oYSNJylBQ5S2fTqk4/1hPeXGnVFFnJzdk6u6BZyxAjaiPcRtdVscGxxiB0r67wCSyCBkP8rjJ/ixONVv7P1feIPw7xPu4GGXFAJPHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=DQSSwM20; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="DQSSwM20"
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 53BB23FDE4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 23:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1768866997;
	bh=Oo0wji2kExLF4MhDfF+dqGzKTMshpVWDzqNzGuD749w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=DQSSwM2086LccMJtWYBlhMXbh6b9cj/dQSBlQ7nd17ftnezaLL+57OScMA7kiHQTx
	 NDrcRgp1hf/qx7yCYTT58/XJBGMmBWxCA6qjmN9AStHJYDuAucra4d5D8IOAmp4pDx
	 F0EXo9MYlq/z0WaVdoF86fWHtWwQMe2PTDYTlhFPnEaNkSy3TNmpdodbi5Jff+Jn8O
	 72gkm0PvMXogaCnrqmNevJCRS7dBX6bmpqV4AVOtpXcMnZwr70wJH01Q3YTuj9Ai8s
	 qZ+6xfBzq/d72jz1tBi7sVAR2JgWiRnny4TUpvB5IIAeXp9XLWonUtacFJR9T1pdlj
	 2R0ehbnvlqkdPJAG5/Fylo8fh4vFBXWkY+L9jjSpuJFmjvDAPCvrQ1zFrKVDDK/lr5
	 A/eS8dboMuT/hcL3ZI/Ul245dFjYkWp4jZB3pFXVRcCeiXUoZ0aXXpEXRXXH2QlJOX
	 eYaThlNJ7K4UuGSyQDSa1EII92cz1L3/xsWcFHQtKkxj2aNKOAMJ881nB+y++n8lF3
	 NprwdZKvx/Q/NVFp9SYYXqNM2KfoKKOw7BBPpWerJs7O7PuFen3XNkGuDeU1QRkdAE
	 MJOyOFHWpnC5QSBLZbqSuXotZBEpT3GjmuA2mmqykh+cN4e565XOFGVByYM0C96uHw
	 9RVs3NrCLoyhReFGAaZAl2+s=
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0e952f153so105942565ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 15:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768866995; x=1769471795;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oo0wji2kExLF4MhDfF+dqGzKTMshpVWDzqNzGuD749w=;
        b=VL33zTWaXU0TFL8R9f4ZdE+Fm3XvEN9zyg71NGRX3F7IBpDuBhZsv8mahBKf/m3Ghm
         SJvRmyd72DBEevbYbyMRUg+epzDtLLxLbKdsQuu+fmTE2Aqh86MvFtWAfdIBf6dvQPDE
         uEXRKNFI5U82mNKKIvdBh7Hg2UzoeXspQFbIaDpEq4/SkH5+ych7Ub1zFUNuI80kfTkB
         ZEFc7rd//HIW5DRxJ8bp5oUPXSFXQlCygsK/Ya5CTPaurNZ6QSkFu/Ot3frebiUr2yJx
         Qkbfr94d/W/wB0g2ySQL3ZQCWUayQlFPdhKPJLbeuR7cIVn79yVxPasFBRVnlG6Cra1R
         gAwg==
X-Gm-Message-State: AOJu0YwfzXdOIAsvd72pmhty0hrUzuk0aBenDQCYq5V5UBQeO3sD27xL
	/Ev655k//t0IqGt9P74mOltvL/nEuK4zUr/1A/B9uyFTcK+WiraMGQHsjDYEniAQBqwYNvuzgv0
	o4GCHWIXg+tD69iNsPUT48RZSCe78fXZHAiZrXk/MOssytFQg6wVV3T8zJaaQ8P41sEvF3ey2g/
	X6M90ORZcPZ7a1GLVKdp3XP5iO1Q==
X-Gm-Gg: AZuq6aLIbkREt97h/pYxz2E7WRSP8eqILQfdKAG3rN3SYDf4VdLtv7tYN7OQeVGU/ZC
	TcV0453Av3dOFmsOwVs68b8QFD1ocGMe5UXuhskiPiACLyfW1h4k4ufC7PFC+k5Xu5x67+pYbvD
	HNiEpCO9OuRs/8RgXvZgj9AIjFRxjMA+4hlorXbIE1jkMoGmF5jVY1U9T/jBLDdMT2iMkLebBni
	cKH5qVz4KXKQsGdGK+L23lRGgWpxw1jERSybmGvsbUfPYRldjsfdKjcUuuWC3B/mDMzx2seRhUT
	nZAIeFUSig39nc+Kt52MSc92WX/lWRi+9hYEshzUy/hzDnGDJ2y4PwMUb2PBfavJnP0D0mdfGBU
	bcINcNmaoAjPR00UAimCWkSrI
X-Received: by 2002:a17:902:e74f:b0:2a0:bb3b:4191 with SMTP id d9443c01a7336-2a768a7e5cbmr288605ad.12.1768866995662;
        Mon, 19 Jan 2026 15:56:35 -0800 (PST)
X-Received: by 2002:a17:902:e74f:b0:2a0:bb3b:4191 with SMTP id d9443c01a7336-2a768a7e5cbmr288505ad.12.1768866995302;
        Mon, 19 Jan 2026 15:56:35 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a7194235ffsm103332965ad.102.2026.01.19.15.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 15:56:32 -0800 (PST)
Message-ID: <0fa0e263-da74-43f2-9c2e-c61801e0d3ac@canonical.com>
Date: Mon, 19 Jan 2026 15:56:31 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] apparmor: avoid per-cpu hold underflow in
 aa_get_buffer
To: Zhengmian Hu <huzhengmian@gmail.com>, john@apparmor.net,
 apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260119122119.3648154-1-huzhengmian@gmail.com>
 <20260119122119.3648154-2-huzhengmian@gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260119122119.3648154-2-huzhengmian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/26 04:21, Zhengmian Hu wrote:
> Signed-off-by: Zhengmian Hu <huzhengmian@gmail.com>

Small nit, there is no patch description. I can pull that from patch [0/1] if you are okay with that, otherwise can you send in a v2?

I will pull this in once I know your preference


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


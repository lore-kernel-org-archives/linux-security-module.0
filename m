Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E83DCDBE
	for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791766; cv=none; b=k0h69fhq2b4xssnUJ0huJNUYCjRhPOwDXK5B1GHFOOo41opVlOZW4N/qLMJFq+pUP4MajQ3CuD6YNhE6uXwh8ZTzsO5D6pZ0Pz94Wl8P8mYbDiBRNqlWBekoP/Ud4kRDd+IcpzeDJLsIT48xlNW/EFA3ZSnwudyJRmgjQObOPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791766; c=relaxed/simple;
	bh=OP8gQgKmrgNl/Tv4qmsTuHrpVfsW/1y26zRhKFHkGG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owz1cQUWS1wYWmBb7P1GkMpHIeXHgu+gWhRU7ZyBBxeAQfeIMtWZ9azu5WccA38iBTNLszLuL2HUCDefBah8CNpaY51n9XUCZTWW2T2UIcQYkFF4wHRmOEXBLoeONt3AHwk44w6CE3ZH7yLpY+1zaRkfN+0+OWq/qx0e2GxJtxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PY2O3RnD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PY2O3RnD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779791764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKCnyq8WGI8GQIs4WPayrwC5+jOUXUYoU+B/AmoRgVk=;
	b=PY2O3RnDCAC/UxlPX35SoxYby9DT9kFROTLPAzxGtQusw/UEJ1OTQ2GyIUvCIC++eh/9H1
	oHMSRXQGHaYoPzLKTD0K/OI4bDVLQFFuo62286IHGQZkjXFrBU2mmL4SkRFPuXpt9DbqOw
	OaNVX0KFXEe9q0jMjHMoFLxlYBu+Ug4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-MpMBNlTPNjGLd6YynayJPA-1; Tue, 26 May 2026 06:36:02 -0400
X-MC-Unique: MpMBNlTPNjGLd6YynayJPA-1
X-Mimecast-MFC-AGG-ID: MpMBNlTPNjGLd6YynayJPA_1779791761
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49048e21ea7so17774495e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 03:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791761; x=1780396561;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKCnyq8WGI8GQIs4WPayrwC5+jOUXUYoU+B/AmoRgVk=;
        b=BHr/POtn4KtXBsgwuKqE8e1IBdDKoN7G1odgL2jRVBvLgwEuTLY8pZuVLkgMPoWTvK
         DswMlzgEZvUQ849NOlZMqHW2A0nt05BSnMB3Wc7EMoS+/jOLuJginBp2oXpx4n5NdEoR
         wzRA0KGOXej03cCpF05AMkTZmprb8nowz/jyfkU5s+UEMJH4vwEbcZ5JkSQqAekrY6F9
         Pn60qV1fj93t4D8k8UdYGr1K0BjNXVKE4Xyk7yFmfJpOOktwnj5Bu2BYRHFh67/MD8NK
         xzj2NyaBLogXgRmi7+pSBo1qHf8yYLl6K+h0VdQLU+q30s0CtUPFxqxt3YB7SLjHbYKp
         WDYg==
X-Forwarded-Encrypted: i=1; AFNElJ9UVYTzgztMOxXVMpXoZLaYq2GpRwf71Rezv3a8EdTFeuP6NIcTWj63TVP0Z0hZZv1U9zehYNySg/Q8gaSn8y0wgnkjsxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwknwfslVAXBipb3nsoudTZEOxEsi23q6nakuNSymnoWBSlhpnG
	JWY5dMfJAYt42hxcEikWiTtDzZi3dadaGA2+p/OO53I2fjT97HfU+qGY/iXdXZz881ZybhWX7Mw
	NawLG822gI8NoacCIM2hSjz3IZq2yEh9qtnnQvbaoGF+1kcxNQZLOyX6XcrqTfNIGICo5ImBC7C
	74kA==
X-Gm-Gg: Acq92OGzPGNIawbZ7d1A5NG/EkR8GUAHt4qb4wwsUqvbghAPCr/M8J977+poqYxuyFt
	rgv/7oEnJts6EJAUez2CWNs+RyHlmpKG7Ia2GGB0rBFGQmMLgiA5Qcortwpl62qNNH9RDEq+tg9
	gW63CBG251wkaYWbEr2LcewycL6Pusfhmh0uOyEUmYpiYkQAKo/wsTVTHG0SoNjT30haDwtrKfH
	1q0NCtcSAI2Is1jzlzAon94MlB3bTy+ecvRSUWgjPBtn1w7ZYHajke/PBIcWlci80edkrA4CtFM
	VhBSHWgd3RZZ3N7N0S4lDDGK2Cc90966wkTjXzIISHT3V1jQzQ710366VfShcEq3G2+4L0IbEdu
	ib8ojRo5rBwtfmDiO0G9sz0Bo5G583NM4YWuZUuTcYuvXuvTGzPlTZAssO5sjGZYWsdYO
X-Received: by 2002:a05:600c:46d1:b0:490:3d3d:805a with SMTP id 5b1f17b1804b1-4903d3d823bmr305095775e9.12.1779791761365;
        Tue, 26 May 2026 03:36:01 -0700 (PDT)
X-Received: by 2002:a05:600c:46d1:b0:490:3d3d:805a with SMTP id 5b1f17b1804b1-4903d3d823bmr305095295e9.12.1779791761010;
        Tue, 26 May 2026 03:36:01 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d49132sm34527634f8f.24.2026.05.26.03.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 03:36:00 -0700 (PDT)
Message-ID: <bc518fbc-5593-4084-b712-a5346367680c@redhat.com>
Date: Tue, 26 May 2026 12:35:59 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] netlabel: validate unlabeled mask attribute length
To: Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Paul Moore <paul@paul-moore.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260522054521.1169755-1-zhaochenguang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260522054521.1169755-1-zhaochenguang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PMYki4vxCdWWsDXhVNGUtS_k32dFv4d97Hoz9nKIy2Y_1779791761
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/26 7:45 AM, Chenguang Zhao wrote:
> netlbl_unlabel_addrinfo_get() checked the address length
> but allowed shorter mask attributes to pass through to
> fixed-size address reads.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  netlbl_unlabel_addrinfo_get() only rejected a mask
>  length mismatch when the address attribute length
>  was also invalid.  A crafted Generic Netlink request
>  could therefore provide a valid IPv4/IPv6 address
>  attribute with a shorter mask attribute.
>  
>  NLA_BINARY policy lengths are maximum lengths,
>  not exact lengths, so the short mask can pass
>  policy validation.  The mask is later read as
>  a full struct in_addr or struct in6_addr.
>  Require both address and mask attributes to
>  have the exact expected size.

The above should be part of the commit message. Also this looks like a
fix that should target the 'net' tree and include a 'Fixes:' tag.

Thanks,

Paolo


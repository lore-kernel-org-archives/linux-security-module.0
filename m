Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2D36167C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815549; cv=none; b=JsB5qp0DEjVYYjJs6RFCVNSKFTbIpye9ahXdxdW5smpa28iAqibztk316jTeM+A5scPNxD7QTKChk+uys8wPJDRTQhUwjF0cxOnOsoMEoUXrafhdfPPduDjM5t4irRNz/n9vUFjiDnZpEkLd8g4LKNvRlYT00POXKp/yvMhSupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815549; c=relaxed/simple;
	bh=z9UEvXn1i7IlTVKzdEovYrCfxLruQ5PWEvcY+VRVec8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnfCUSMYhDaA3bdcMlKRJWLowbgK3wcuYeSZ17uD8QEaXiZw8YazrdnQ9a7EonxLF8PzD0LYOWnuHM1lf7zjG5mHGzgVhpP9Wx5IYTK7oybcF2gFAwmpnw+eIYLfYLnkR009BdetdfwX9Fmj/cHgCgb79fI2qsZCGfmJAQmql4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=R3BKFiI6; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="R3BKFiI6"
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D51B63FB79
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 06:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1773815546;
	bh=epmCUqv6SVCOMHsBhYMWL9iFUoQWgW1lR+M3UIYJn6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=R3BKFiI68P4OjLLx9FjahWPUfKXbPj1nqKkpv6YAfe2DkSl3U0dtgQrxfnPqwMw3h
	 4FN//9Nhu1/cy6tMB7sqDpqYyW8X4G3CnOIaARUAPrfcKAwWuKHyTaEc7TkaEZBsOz
	 +mbXBnj4ZDawYVvrPazetw7fkX0Xv90167LgahFd7dRAfLBK5lPrQwVbuUs5Fptx3f
	 7GWUpMvqpwI1MC/fOaWbwGqMonXEQZg3Ox6QUylRWVfP1hlCg2ypBhVnzhYp0A2fEq
	 W8nkSGK/OCU5q6ap1FWtV4APeiUWk4IZ2q+mbx+7UJmzzLesO7oJ0b7refuKssTMFd
	 bAFvaLbOAc3YWuTkkvKdj7Lo4CBIwaCJ5fMDyisKvx+a16/2G5uLdZDqo/fN3nElPz
	 puofeTbynDk/uvBEE8GAhyaGIJi0Fw5eE8lVKeIbCg1iO4yZyEdNwsFHuZPHqjjcwO
	 D9M9wkzeeVmUfNWl22VDlsADs1/wf7K4/xGUVpqnkOM8nH8FjNCQu2YG2iE5K648vR
	 AyeT9H5i4Banfjy7gfi9vVK7ouj3+yWX+P/VSG+yEFhm0reGXNoM5fLHwA+/h98JE/
	 4kmgniJRPduXyrftoXZFpH2+f01iVIjpuQOztsP3LpIhzAbj+SQA70tJsmUXWrCx4w
	 ZVoxVNmi6XHWIYZEYBMlHyYc=
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so517994b3a.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 23:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773815545; x=1774420345;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epmCUqv6SVCOMHsBhYMWL9iFUoQWgW1lR+M3UIYJn6o=;
        b=mC3bFP1PzJ/PbLWSQGQy4F/GblGJAswKx5E0SE1LSvsEVCUPIrFXQSGCxhSB69ILy+
         UkXwRKuTNbpCbQLtDdXdwY21J3eHGGp+6yf6P4PtdkbtTfzYegwaPjHHSW1vHFj8+ihU
         EdFkKtVBUQ9fE2jXMGucz8qk617BuNw+ZU77BLps1IzioVlxMfDfrihPg97isC6/4ypP
         6SjWIwMlBJzlE+QR0n1IyDtBZXMIUNsJcxKggafO/Q5mF3yJoTY5SUiODSuVvkoTID5y
         T9G6vOcpcyOdwTJyZyMWIBVBCMXWYkKmaaKsUJEaSKd2XfZxZhCkZdy4P7Uib5dbBHYr
         PoZA==
X-Forwarded-Encrypted: i=1; AJvYcCWb96cHfVyNwsS1OdfrxCMXz6a+zgiDAv1NbM4iBhlMBmXcG8PfCSYXniYrgF4SEFiLmj1DOQK+8Z/JEClvgz7EWDqia9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH3e4Fprz59dL4U+WZQ/uad+xe7tLg3x2AdFbynZ1hz/IRLtQl
	unR4mWRlLfTtEVpp9dFrnBrFW+AA/arWrRoCk+I4B3u/QgyNdbYYLFa5V4vwsD4Xii2zOl3ikG8
	thJVGtaMoFdlAfjCWed7tkbDIHky62rTToh8hdxltqZvu6Ee48M4QcGDTgFOLXgqv+jL/fYa92m
	mJ+hgG4Yyspc+8AyDQDQ==
X-Gm-Gg: ATEYQzwQ5qKN1s4TeITt0eOtkK843wE3IkcS6B1yPSHcDvv2uUolIC3l7lI9h+f5r1o
	DmWt3eqz8JZmJ/OguLrfKS/LkrPAUK88PuuHsOdnhhPk7YVYO60D+/6bAe84692U95z+pVopBTp
	IjVCxYBkPA7qVLJCZ80FysRS05yRcl4ObbztEEIwDH5hbBC75bQQz3MvUr+Gl3JYxUCBblM7sp2
	B/34eMSUnhhcy55bYqnExUv1FvKkTZ8ikkCQGRX9O8ZjAk1I3hUAceY57mxmBMCh+KbTLDD969n
	Np8hS8ydMmIW4Dyj3JNsCR8HU+1eHc4PK3jICsnXeZxPQsH52WM3DRIzvhkYOhKg5eIP7fudPuF
	7MiGK7UXBZksRoQeJ7MqPwGTwTA3u9RYu4mgsCg==
X-Received: by 2002:a05:6a00:1c9f:b0:824:b304:2d1e with SMTP id d2e1a72fcca58-82a6a088027mr2117673b3a.8.1773815545375;
        Tue, 17 Mar 2026 23:32:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c9f:b0:824:b304:2d1e with SMTP id d2e1a72fcca58-82a6a088027mr2117654b3a.8.1773815545044;
        Tue, 17 Mar 2026 23:32:25 -0700 (PDT)
Received: from [192.168.192.71] ([50.39.102.197])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82a6bdd776bsm1380585b3a.49.2026.03.17.23.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 23:32:24 -0700 (PDT)
Message-ID: <10bcdb0a-5e85-475f-bb02-658d892f1688@canonical.com>
Date: Tue, 17 Mar 2026 23:32:23 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] apparmor: Remove redundant if check in
 sk_peer_get_label
To: Thorsten Blum <thorsten.blum@linux.dev>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260318002141.3362-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260318002141.3362-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/26 17:21, Thorsten Blum wrote:
> Remove the redundant if check in sk_peer_get_label() and return
> ERR_PTR(-ENOPROTOOPT) directly.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

this has now been pulled into my tree

> ---
>   security/apparmor/lsm.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index c1d42fc72fdb..f7bcfed40222 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1528,15 +1528,11 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493694;
	b=0XFn/UsR7pC6GL+HQo/dD27a9nArE7nMI72f0Nv/ih2O37i89kTCDSaUbRrwbLpt/Uzj
	 PFPsgxwyz0D9tdm/6Ip+0tdsWCAnPiNBBg5trXYoZfRyoIscdip65xhXYtWzT85hghU+m
	 YKIaCgt/BeZnlxWTSEkzTlkf3d8ldKA/+jdhZdfDZxJRez0PKLspVR8o+dukRXQL9JnPv
	 4GBnsRKr6SWTuzVuwk2v8kJgGI08PYj8P5mXFlS/MgRHdXUYuIKy+FJeJBYjVi51MizGN
	 HaYfWGIjJQI9kpzq3dW6fZfp/ePNUMy3BT2Jo41mZ1yS6gsIlQCWGWZsFD9Msc/rQJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493694;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=Rc9bf8NN613bIi8UJTLUeEhOmQUWktCfilbKq+1NuLg=;
	b=kqT+cKy2JNDXK1Wwh+vpmgwiJyfgxlm64kFFV6buvKABUDEYoOXfjXEqjc4Yk8lxO5Zu
	 p8hha39/zITPbWxU1/J2oKaPghUDtftcoCTh777R8ByPnEerycQtWKrT+xOgKixWhmK4r
	 ZZKZoE4YEfUds/dSPaYgUhHd6lyKt7GAxUdceMrIp8rvu0mT3HDH4+tIL7nuR/2aiVYHE
	 WZ78U/Fnv3EuiOUoxjFcYmgQPfMs6Pd2CfmVF4ORrRmxxYzoL8ZuGIVvSQu+c30Slw0wZ
	 tQ+UC8XU7yOR2QdVpmq3lyjWO/olzx53UULwLbP0QO96U4gK1yXbAQ0/nFs9BULB9wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ch0w08DL;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7B606D54F
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 14:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70E7B606D54F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ch0w08DL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794493692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rc9bf8NN613bIi8UJTLUeEhOmQUWktCfilbKq+1NuLg=;
	b=Ch0w08DLquo/MLe3vXT7N8xsd7o/Jq9FqjHyz1ARzFAyef3kblh5ATY7MpfJnBxIzEZ49F
	YalEFjvhZiqj4z4KN3OH2moAWP2PXWkAVmdctBw67FvjNcbB7TbVw2csrLSceKEYEu0x3Z
	hAl1PqKM0I2xFzbatiLdwcBtf8zCRBU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-ilYQWqZqNrOfLtSHuJlV9w-1; Thu, 12 Nov 2026 09:28:11 -0500
X-MC-Unique: ilYQWqZqNrOfLtSHuJlV9w-1
X-Mimecast-MFC-AGG-ID: ilYQWqZqNrOfLtSHuJlV9w_1794493690
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4b8b3cd61a5so5243595e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 06:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493690; x=1795098490;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rc9bf8NN613bIi8UJTLUeEhOmQUWktCfilbKq+1NuLg=;
        b=oW4E62VoE/Gp71h9+QM5jQXmQv5mMqPSHTskj20FSRY6kbetD5CWgFggPmeQEtwUiH
         vHCxMALO5rq6t4beLKjzpAwBc0vFc5SqWZ3VAiW3GePXH7Ldb1Uvm9zYjXkt1ojGAfcX
         IEMF7Y/mxKIgUdGxrDGKmX7Uf095MTM27jewV8hH4xsNN1RuqFyWsJ2TJco/Nxbs3nYL
         Ei4hiU5Bq6NM0uWD/Q6t3wR08VmPbrZSSnSgwc0AtBJpIHOV+QS/OdnTLEiHDxdKddCt
         xbKjxWc2UE5WWQ9Y5mumbYio2evwBRUGauZYJFIoEkrMrOfrPYwCORO1XZzhFaW2aAu7
         GZRA==
X-Forwarded-Encrypted: i=1; AL+hErF3OtwvndRAZx8mmxF9xhQm3oM7lHs5F4u+mSBtkGrqhL42iWwquKCsLBeJ4cux+K7jWt5xz0oyELzB+Z0n6rirqp12h8k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+K+2avANu0BGwY0yjDdZKbiGb9aOi8DkKMgQ1/bW03pKS+QZZ2
	c/FzNwM0eO1PeodMMFphW6QUEyId1JVvfjJAa12zXXP976Fpuo6ZGbkMhqQjg9MFJWfHbwL17Sh
	IeoK+vcY9F8+/mX12vjWj+CLjSsk14A+8J1C1nk1qg65OuMT8gvJG6m66Elj3FKgxf2zozGiJ7R
	FJevl3WkMARw==
X-Gm-Gg: AYBFou2pr3OW3lTg8JuGe1GigNfC+HhJTE5fDZmsaPAZJO9D64cLk3Jc8EEjL/CUq7X
	WYm1q46cuRi2L3mxUoYEG1Ze/e0QV3KDzbroXN0wRVYQhcuaFOgn3VS22OPaFr/nYoYdJK2Isdv
	nHntynSE8EXW/R7N2RtGXWtqvbAU8iE2Ou6CnyV3pd7DCcJnvgMhhE46oG+0b2HtaZDlM9dK02m
	a0b/5MB3F0Rzr3U5o8qNoVxgnmteERMenT8WgO50469bfic301ujWTbGTdscC4HGNLRxZdbxV1N
	/13jlksz0y8m19pgZsYAM64n2Jiz+iwcZ/TXBQRxwZ9WKMYCFdaIzpRlJTlhdQG0NnzxBezWCcf
	SaNY8JT4KbaR6G9VIPSd8Oh3BOosS5CAk0I6CK+kJlofOrSJK5tH8OO5jXJUBZYgmYjMiF77EzR
	ABOqdn/CWE1MfyOnsri35UJQQnMUMxtS7FOLwDrG4FYJvi
X-Received: by 2002:a05:600c:8183:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4bb4e296cd4mr53828335e9.16.1794493689810;
        Thu, 12 Nov 2026 06:28:09 -0800 (PST)
X-Received: by 2002:a05:600c:8183:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4bb4e296cd4mr53827785e9.16.1794493689324;
        Thu, 12 Nov 2026 06:28:09 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb51f3cbf9sm40266145e9.0.2026.11.12.06.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:28:08 -0800 (PST)
Message-ID: <2fb8d2d3-9840-4e1f-a02d-877a9b93593a@redhat.com>
Date: Thu, 12 Nov 2026 15:28:07 +0100
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] ipv4: recompile IP options on a private copy
 in ipv4_send_dest_unreach()
To: Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>
References: <20261109131736.3060756-1-edumazet@kernel.org>
 <20261109131736.3060756-2-edumazet@kernel.org>
 <20261112134645.GA3195113@shredder>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261112134645.GA3195113@shredder>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NvA0VDhqb8Mj8pZw8fVEDNqlT-F4Y2RZ_2C9j3qm74A_1794493690
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 14:46, Ido Schimmel wrote:
> On Mon, Nov 09, 2026 at 02:17:35PM +0100, Eric Dumazet wrote:
>> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
>> index 3a90c8d28b940bf615c165d9b30ac634943586e1..9af72cb892034deff2bb3169911c02c025d73cf2 100644
>> --- a/net/ipv4/route.c
>> +++ b/net/ipv4/route.c
>> @@ -1256,6 +1256,7 @@ EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
>>   
>>   static void ipv4_send_dest_unreach(struct sk_buff *skb)
>>   {
>> +	struct sk_buff *nskb = NULL;
>>   	struct inet_skb_parm parm;
>>   	struct net_device *dev;
>>   	int res;
>> @@ -1271,6 +1272,16 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
>>   	if (ip_hdr(skb)->ihl > 5) {
>>   		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
>>   			return;
>> +
>> +		/* __ip_options_compile() writes into the options, and
>> +		 * callers of dst_link_failure() may cache pointers into
>> +		 * skb->head: work on a private copy.
>> +		 */
>> +		nskb = pskb_copy(skb, GFP_ATOMIC);
>> +		if (!nskb)
>> +			return;
>> +		skb = nskb;
>> +
>>   		parm.opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
>>   
>>   		rcu_read_lock();
>> @@ -1279,9 +1290,11 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
>>   		rcu_read_unlock();
>>   
>>   		if (res)
>> -			return;
>> +			goto out;
>>   	}
>>   	__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0, &parm);
>> +out:
>> +	consume_skb(nskb);
>>   }
> 
> Not sure that what Sashiko describes can happen today, but I wouldn't
> rely on the network header not being in the headroom. Something like (on
> top of your patch):
> 
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 630143ca0f31..77c03620f89d 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1282,6 +1282,10 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
>   		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
>   			return;
>   
> +		/* pskb_copy() does not copy the headroom */
> +		if (skb_network_offset(skb) < 0)
> +			return;
> +
>   		/* __ip_options_compile() writes into the options, and
>   		 * callers of dst_link_failure() may cache pointers into
>   		 * skb->head: work on a private copy.

I think the above makes sense.

/P


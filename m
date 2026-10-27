Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132832;
	b=UdJJvF1dVyZMKSYnevywpSvj1315yfqsUPBFLCvjFLOl1I1i5BR++uVmfUc6NDW4liB/
	 Om1Ad7XDb7w61BZhnpTORdI+KeiQLyPoSeNM9qXeyscIJS86UG/il9cF2wLdOJFJPBA5R
	 MxzDfNLuSLn7ijNy7GfWfrNrY+IWW5H/oaAYCTIgMVzIJP4qoJQQ8MW+v3+ltDu6qNvjZ
	 GS1vfzHICAOhb41624jld56GayZa9aKh6s5LEnMpLZgZRG3sIkOdLHi/kUz98brruZyAt
	 5UjX8p5Yy8LO3Qq7elDyDSu2ZFwNOs1Hmk18a2SiHbuDQ81enQNHvQBUF97RIIIzwkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132832;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dAIhWV14mrK0zz/OnYeaXG75ONoFCGEArK6ZD7HRTzc=;
	b=UPreQbIrWsECcHXVUI+JdX3fNTPd+xp3qMu0HXU8OluuE9KJ3vI3oK6kKGzkwLXv6HnU
	 7AWRIBS1/gMhgQW7WFIzXj4VTIc6XJgrOt3Zw/VaeVvF9aF60ei9PRGwDEuoIMQOR2um2
	 9rdbtJoesT5FMuhQPQRVDi8cwSLudFMnBfZNtGQlzGKIJNsep0SbH53FPgZ4IXkYyNbzw
	 jEkJCM/FxK67VbMBgSuUss0wOfHCcBQH28RY6racayQGmA81n26uOCrBWiOY/mLMCK2WX
	 iyDwoLo+p/Q7h1+lfUmsTg406c4OZj4OUVJE2d9Vx0QTAPtbAvGxSFVtTnqBrY5MQHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=EUqxkM9z;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBAF606A902
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 20:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBBAF606A902
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=EUqxkM9z
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0E25F3F846
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793132830;
	bh=dAIhWV14mrK0zz/OnYeaXG75ONoFCGEArK6ZD7HRTzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=EUqxkM9zd03e209GBCH1REUEURQfqN/6VsCzGi9ufv3RM1eev5Z++Q0dUlhD5YfpA
	 OOQmzvb+CHVWOQ/p8d9aHglkxtEu+fa7rcrsO5kZwV3b0z134vaXCratkW5xEjXKKa
	 UmmI5f5+94h2bjsnKopmyoddQ4yZugyV72NGLZxNlzdTbMqrx+r3Ktz6NOmxX5rvXG
	 jGjrsQkGPVPxb7vyk9l53rla50hKVBF65rj8FiLaT7nGOxu5O2HdjDXjK8DFwesyHp
	 Xq+NdkhltQ6xyKtd+kZ1B5yiWEbUHg3yJqxLfHPAlb7Zwn+1TBICMmsGBgGXMcopVu
	 3NmFad/SkJtjzCLlwTjCpwrouRPG3PB/SG3cl7gaaww97zylFVEvJeAO9E4JWMjUV3
	 laG+IPpYT9zPQBh6ad2gdbcs1EjLq0UalWjjYjXUcEdN52lFNPklF3k6u/wPu1tslT
	 LgEIwbnPklCGJLrEXHccsPvASfaHDb4G68X9PzxUW7X3SWuiItU9w9cg9zLI+ak5sX
	 m7FP6FRfekpjo2lPTLxZeivlMpt7/1oe07ex/MnnzdXiPl3Y61XLqiV6dvKvkWz2Bw
	 +WTtZeN660f14r18QIMDaLMl3KWpt2vq1/ywiY1cIprP82a4ajEzsS85YtCOTqtYXt
	 KnvG6s+qkV9N9BiYysHMI+3k=
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b0f1c06332so4071097b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 13:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793132829; x=1793737629;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dAIhWV14mrK0zz/OnYeaXG75ONoFCGEArK6ZD7HRTzc=;
        b=ylV9hmeQFyLV1939omwlfVIlt3IXaUMEALbtr+OWnk7n0hQENR1itvgza11cu0dXHg
         IA+9zv31RLtpSs9VjcncD27i4BitwjWaqs0qtjeWMkHsM2F4kPKEjJ0JjctJJKYgORpW
         FztP5V+FEZ10E4jL/7gDVx3ASlAXt1Og5iO6mpKo5mJpeFmhVqYyivDsDsRWaq6lfsKv
         clWVguRIAE01/pGJn9QvzGUM1vQPJbwyDongF/u/9TxwNEX6BkRaZD1ldHZB0cN2b6qP
         4CEvuWHiJ45QoUM7pyQPTtpg71httFauIjl90dKNnqH77lvkQ1+rgiufHdOkIo79E/Mu
         3vMg==
X-Forwarded-Encrypted: i=1; AKwUvBzXm3wbyE89WCTvt3xV4IsYUlNXJd1r5lgPmgNoc8Xq/gbnmdld1xqKEWQucuNLBhDtkyACKTdjvkXjDa539lQCN61FKUQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4TcrnIfdMDmH6qR88iUm+iUHq9jQTl3AL+LRL0Urjh2L+b9oB
	wot7YXSt+pC1wNk2B2oxwOsEMX/Y+OmoIpc4aFGtpnjdqIp6OpEHwgWgCcLAtjxjLwXilHbarsP
	LJrGkSCUAgO0hi5XzSh1Gk4EebKaoPlnCZg1PE2Z9fOQWNwPlTzwp4i+1ao6VgW1p5u1cSv2rHs
	Q26V3fwCBwXrmGGXj87g==
X-Gm-Gg: AYBFou0kYbOVlT7Ny1Q0g8rTFh92dMYU7qPodnYtZRhkMISuRAA/r8havoBEceHfVlf
	2U0714EhDmkHbujHgLp24WynR9MDqfz2fdRCyROKQSCkNA1TMM6LvrTsWGjhRrn7ZDcqNhmLVt+
	SM5uCLm78HOscZwAUAaki+yTifKVAbYDZMYi4uIWFhQTFaqYCFS9QDLejq7DvbR0xsqH3qx1wbK
	gxiA88yTAOjcjnrzDoZ4ltoXDII6Garbo/vAa2Yg9C3+3/yrr6IY+yTMhS5NmYRDteZ3wk0oGCd
	1dJV5a67En5L1XnmrXPXO4UfE3WemS0M6XbQikRzUAxo8p3FZVFp/OChl+alqQsfvDM8DoOfmmv
	zGT1kJOIFguHj8MkaW8Lnu5bTFbhFqYo+/pISGkoE6ngDGSU6L2p6Ef8=
X-Received: by 2002:a05:690c:6611:b0:8ac:dbb9:2204 with SMTP id 00721157ae682-8b1b5c13144mr958177b3.16.1793132828866;
        Tue, 27 Oct 2026 13:27:08 -0700 (PDT)
X-Received: by 2002:a05:690c:6611:b0:8ac:dbb9:2204 with SMTP id 00721157ae682-8b1b5c13144mr958097b3.16.1793132828501;
        Tue, 27 Oct 2026 13:27:08 -0700 (PDT)
Received: from [172.21.9.52] (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-8b19e539e28sm18111507b3.11.2026.10.27.13.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 13:27:06 -0700 (PDT)
Message-ID: <a22ce13f-50a3-41ab-a189-c8749bebf1d7@canonical.com>
Date: Tue, 27 Oct 2026 13:27:04 -0700
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
Subject: Re: [PATCH] apparmor: check accept index + 1 is in bounds
To: Guanglei Zhu <zhugl3@xiaopeng.com>,
 Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260916115307.454593-1-zhugl3@xiaopeng.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260916115307.454593-1-zhugl3@xiaopeng.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 04:53, Guanglei Zhu wrote:
> aa_lookup_condperms() returns perms[index + 1] when an accept entry has
> ACCEPT_FLAG_OWNER set and the subject uid does not match the file uid,
> so such an entry consumes two slots in the perms table.  But
> verify_dfa_accept_index() only checks that index is within the perms
> table, so a policy that sets the owner flag on the last entry is
> accepted, and the runtime lookup then reads perms[index + 1] one entry
> past the end of the table.
> 
> The perms table is allocated by unpack_perms_table() with a u16 size
> read from the policy blob, so a crafted policy can place the owner flag
> at index size - 1 to reach the out-of-bounds read.
> 
> Check that index + 1 is also in bounds when the owner flag is set.
> 
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

so this isn't quite right, the index+1 constraint only applies to some
of the dfas, it very much depends on how they are used and encoded.
I am going to take this as is, but add a follow on patch to address
that the check is actually conditional upon which dfa and the condition
under which it is loaded.

I have pulled this into the apparmor tree

> ---
> Found by code inspection: aa_lookup_condperms() reads perms[index + 1]
> for owner-conditional entries, but verify_dfa_accept_index() does not
> bound index + 1.
> 
>   security/apparmor/policy_unpack.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index f1fc48e72..1ea89e9c5 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -1489,6 +1489,15 @@ static bool verify_dfa_accept_index(const struct aa_dfa *dfa, int table_size)
>   	for (i = 0; i < dfa->tables[YYTD_ID_ACCEPT]->td_lolen; i++) {
>   		if (ACCEPT_TABLE(dfa)[i] >= table_size)
>   			return false;
> +		/*
> +		 * Accept indexes for owner-conditional permissions come in
> +		 * pairs, so the non-owner entry at index + 1 must also be
> +		 * in bounds.
> +		 */
> +		if (dfa->tables[YYTD_ID_ACCEPT2] &&
> +		    (ACCEPT_TABLE2(dfa)[i] & ACCEPT_FLAG_OWNER) &&
> +		    ACCEPT_TABLE(dfa)[i] + 1 >= table_size)
> +			return false;
>   	}
>   	return true;
>   }


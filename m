Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0CA38889D
	for <linux-security-module@vger.kernel.org>; Mon, 10 Aug 2026 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346784; cv=none; b=MZelp+2C/I83DrsJgeyV33ApP8kaQjgR+tohejV27Cya0yr64YLPJkQ2+5bBEfPuuBGRoubS0WIP0b9oH4ElwbH4aE8FjMhz/FeNR28rqRUH84CWhngIhbwl4ugPcrmDk2pCyFWOPFcd3qaAjPVXQapQ4ObujBfvTBK0nbAwytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346784; c=relaxed/simple;
	bh=BCv6IdxsKkinSG/MWfYx+0ZEK6jMSElAGBx+mJUYD3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EThBaKGBESIVF+7hmrX9JKfq9Uug4I/OjJQRYkNYhEgJt4joYCnAHx3TqFleX6U6U5F9aZ9yNutCWPiSNdTJCnN/z8xXlKMtCHueu0zGvH9XwF5cvOdQh13fo8cevPdBWDkAvEYlD8ELIbO6gmBG/9j2tYP3lZwyBiAAK6Fsmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=RS3fdPcH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="RS3fdPcH"
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D54383F20C
	for <linux-security-module@vger.kernel.org>; Mon, 10 Aug 2026 07:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786346773;
	bh=765OTD9/XArt0TfhZr0fUc7F/jraVReoc79Y334nFTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=RS3fdPcHtHyHQoBVy/da+eucvjNZmfXUICxki2HmNi19eE7ziq6j2nslicKrO9XbI
	 J8vc4qND+fo7Xnb9G/mKUCQLBGio8f1x/66TYCIxt5i9h6UzQ2JA/7bnB2AEwHHn2B
	 X6A50jNXednEsjlgTz8y6vABCGHqw+9fZwqWkK3q0aJyGacmBhWL65nvhXa/DsTMl6
	 VOet6NcMLLuVH52v7mE6z4no8R1xQzZfaCda4APFjpiWoMpzPRO3406yI0BFimrGbd
	 jC9ZJ6jiVct5LByuUSIMbY1N09TnRXZLz3+lRfgURcifKLv9024jwjrGJByhv4tLJB
	 +hga7nI+x0xRdiQqY8pMjp4AGoq+MPr8ukq+LDjHxs6LSnrPAfP1YhqHBmHW2SRhbP
	 zvXrL0FRtjXhxNWCRuRSuXonljRMGyljigxSF9aC00HD8ZUoVUl9dVBJNX9nVU+mse
	 ZGs1A3tVAhZ0FQv9AoM0QHzlJgddoSus2oIOtJKmT5nXqoOD21eYpG9PWRJRF8ZfYV
	 bPlj7MiWzFYvz48kb6JqACEkjWsw2u6/AVK+l2RBkYRhf1CAdsgX30waWVfqHM2OfL
	 PgPYEuvzG/rOLDtkATMny0eGEMLVdGS+HHOkHbGukQ/NhAvlAg0V3Jve6TQTWL8Vrt
	 0p162Hx8l+LHRi9oxO4h8cFs=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so2562348a91.0
        for <linux-security-module@vger.kernel.org>; Mon, 10 Aug 2026 00:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786346772; x=1786951572;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=765OTD9/XArt0TfhZr0fUc7F/jraVReoc79Y334nFTQ=;
        b=U5q/BkEdQXbeddjPZurXSyzMvcynA3p07ixp481BaDdq+mmt3N0TSZX4jxkjqdvWZF
         iG1kzS2RCEBppvhm5YeTXCOZ3Gy7dvSRn+3gl0R63Q03Wbhuxk4BhdmOwFxF8goyPnie
         aA9t65lpNS1HR+ZPFjw5TGhU8rpMSzcGfGDs0wYXg2wPorzXfxz8ADcgFYNIZ2+iY4Ns
         VMRhuPIYwa/TADD+GbtYCWA6Q7M5ztYIn5VUqfjnkEt7sguItQI7x16rjyLxOKIMV1mP
         lg/EyH5gByTUOHqbxIC+xYDFNnbTRNwag1XqVzACxPRp8d3mlNinCC9q7TyaJvtljU3I
         pwDw==
X-Forwarded-Encrypted: i=1; AHgh+RpRkh7Fb5RLNlPrziI+URCSrLsDf9FTStpzH1Rz7n9ZAyLQp5pNbzNGvoro5EWJCNa7j+ez8vzvEimgvBsrjrYYwHjv9xE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0aXY/LpFbl9g0MJhcwrm8rz+s8QSHGf0xEA9dpPeOLiK1ZFcw
	Wq4cLEoRaKUtHDplTAojO5BfAFV/whdnq3msvOaJ0P90F6x207Y9Zc9VISNi9YHDA2NuQIbukW7
	o+50LOhh8YRhQ1xRiLptvFLNYopCeVx+/oxwthD0YIu2rqIqjwBkX3vj0eiZKU5WZ94WtfTjdvj
	CUCPzv62j4GA/eYKEGig==
X-Gm-Gg: AR+sD13znkIcTGdQbjPdtn5MAzebvDjhtTr7QnXz4qdvJm1yLcFuMf5iA6DwPTw+aXY
	a7RdJTtJZzUJE/FswOtj2J8TTHjZWGNWVaPVOxGrJEk/VZEEx22+8VCQdxuo4C1HorEo/xN28uc
	Pbq1JCEkgWNu5rVUdP8GsUHuwYt15kls4iWjniykyFWDHb1JNuTxDGAvVApL0UBje7U2/NPiX5b
	ahSK6scwGKVEFjcI0fwccAQmwxsgDY+M452hK7+E7zihEQ3P1jU/MPx5FWMmrqjvr1i/Jek5hSQ
	fgUR4AOoix7dQ4UcBO+CJExqndL+x6l/+GYPKvBjxKyVgI67ZBYRzyV0ylByTPAnLqMEaH+At9w
	RUKSo0H5dmJpT1+HO0umk4CxFBqxgGZ/c+rEocmOYi2IxADEzGk1l
X-Received: by 2002:a17:90b:280d:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-3903c54fbebmr46484427a91.1.1786346772238;
        Mon, 10 Aug 2026 00:26:12 -0700 (PDT)
X-Received: by 2002:a17:90b:280d:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-3903c54fbebmr46484381a91.1.1786346771799;
        Mon, 10 Aug 2026 00:26:11 -0700 (PDT)
Received: from [192.168.50.156] (S01061056118100b4.lb.shawcable.net. [96.51.42.105])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3925fd95794sm11386867a91.7.2026.08.10.00.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 00:26:11 -0700 (PDT)
Message-ID: <2e0e97cf-4aad-421c-b5f3-9f24409d68fa@canonical.com>
Date: Mon, 10 Aug 2026 00:26:10 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix integer overflow in verify_tags() bounds
 check
To: Fabrice Derepas <fabrice.derepas@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <20260809142947.548440-1-fabrice.derepas@canonical.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260809142947.548440-1-fabrice.derepas@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/26 07:29, Fabrice Derepas wrote:
> verify_tags() validates the tagset table unpacked from a policy blob.
> For each set it reads a count and checks that advancing the index by
> that count stays inside sets.table[]:
> 
> 	u32 cnt = tags->sets.table[i];
> 
> 	if (i+cnt >= tags->sets.size) {
> 
> i, cnt and sets.size are all u32, so i+cnt is evaluated modulo 2^32.
> sets.table[] is filled by unpack_tagsets() with aa_unpack_u32(), so
> every entry is a raw unbounded 32-bit word taken from the policy blob,
> and verify_tags() is the function that is supposed to validate it.  A
> count close to U32_MAX makes the sum wrap to a small value, the guard
> passes, and the inner loop then walks sets.table[++i] past the end of
> the kcalloc(size, sizeof(u32)) allocation.
> 
> Note that sets.size is bounded by 65535, because unpack_tagsets() reads
> it with aa_unpack_array() as a u16, so the wrap cannot be reached by
> growing the table; it is reached purely through the attacker-supplied
> count.
> 
> With sets.size = 2 and sets.table = { 0, 0xffffffff }:
> 
>    i = 0: cnt = 0, guard 0 + 0 >= 2 is false, inner loop does not run
>    i = 1: cnt = 0xffffffff, guard (1 + 0xffffffff) mod 2^32 == 0 >= 2 is
>           false, so the guard is bypassed and the inner loop reads
>           sets.table[2] -- one element past a two element allocation
> 
> The walk continues until an out-of-bounds value happens to be >=
> hdrs.size or the access faults, so a crafted policy yields an
> out-of-bounds read on the policy load path
> (aa_replace_profiles -> aa_unpack -> unpack_policydb -> unpack_tags ->
> verify_tags).  unpack_tags() runs before the perms and DFA tables are
> unpacked, so no other table needs to be well formed to reach it.
> 
> Policy load is gated by aa_may_manage_policy(), which checks
> CAP_MAC_ADMIN relative to the subject's own user namespace rather than
> the init user namespace, so with the default
> unprivileged_userns_apparmor_policy=1 the path is reachable from an
> unprivileged task in a matched-level nested namespace, not only by a
> globally privileged one.
> 
> Perform the addition in u64 so that it cannot wrap, restoring the
> intended i + cnt < sets.size guarantee.
> 
> Fixes: 3d28e2397af7 ("apparmor: add support loading per permission tagging")
> Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>

I have pulled this into the apparmor tree

> ---
>   security/apparmor/policy_unpack.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index d9dcff1..15b5e92 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -730,7 +730,7 @@ static bool verify_tags(struct aa_tags_struct *tags, const char **info)
>   		/* count followed by count indexes into hdrs */
>   		u32 cnt = tags->sets.table[i];
>   
> -		if (i+cnt >= tags->sets.size) {
> +		if ((u64)i + cnt >= tags->sets.size) {
>   			AA_DEBUG(DEBUG_UNPACK,
>   				 "tagset too large %d+%d > sets.table[%d]",
>   				 i, cnt, tags->sets.size);


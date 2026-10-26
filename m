Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793044108;
	b=1zCZswS6welCyB5FzTlE1gRJXslnNNqEjGkJyPzw3kOhGRlbrqxredGrXzPkxA7JNb61
	 iFM9jIty7j+Q2duMweg+TWUS4vJUlm5b/LZptE9p+7LphvlaC81YeJGJA4uHjrjghTb+d
	 ie3jumiS+DlGk6u+Ajn7/ekceBaZH4zai1F+Ph3lyszfFtC1uAQa8KZNkNKQNbQyP0Vb7
	 nxmDeTirDx05GCNeHYaXtikndsLFVtm6Tbx3OtWOVMSwPZd51z3nAvyaSb4Mun6xd0uX6
	 9svVlLB92FZqz2g6kI3G6V58TPz8U1BFmJuQycZY2G6tO1FNxEvlQeCN08AHcnPgDpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044108;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=oOSXH3b8YM+3zQu1xQxJWyhbK4XJyHCVontaJB3DeTU=;
	b=wfWDY/zsGE3FSBn/PursQdln8XCa5XpY7eAoaiOZtO/9gwiI3MEKwn8HvG48e4MdzvgC
	 GOs1ngvGYpl1Mu5qzkTaWIHqQYwegM1WEDliiB+vrzbNeRdc2kdc2mWFPi8jBcKCGYoGB
	 aeoPst0MmKHfNr5kxsFagnr1Yjkjt/OHZllpJOv3G8DIpPQSbGXa2naeS5D2SgTeDK/Ku
	 rJdNHp/xIqxjOtbiMWVJu+XSOATEpWQ/8CWLFBqEx6AC0ZIu1Uv5KMa4VYKch3YX3wdSN
	 SKeDHqCJmgFHLY60mtniwkMPdb42SfFEuvKk3zRhfhCDFHiOCWQUGuu3ZcBVmaihfEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=GUIUnTyP;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F26606A31D
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 19:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14F26606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=GUIUnTyP
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F12CA3F57D
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 19:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793044105;
	bh=oOSXH3b8YM+3zQu1xQxJWyhbK4XJyHCVontaJB3DeTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=GUIUnTyPhu6mELzhowXpXOoiIBvtySXVuVfLzXcBjdl9kWnVgUxD2Kr2XJjI7bQUL
	 qowBgoDuSCQj856GtpZcBXStrjCb7UAnAcPvhH0JJIPcRZbN8RLnY9SMN9L44fkdq3
	 9NNhKk2AqgWmo3ckjtDw2rckDMD6SN06kYzrBGlLZoufLqybBzuN6VUEMYVJceTVE2
	 GUzPdX/ETRAo5waveiPd9hiUjn3YGRhiejmY00EbYE3qX29BmvIaJ0ULO07KcE9+CC
	 k5gpN+2r8I6dPI53wmxVrVYn5vluyX/Ke/cJnWIHcrEDwng7j50XA472irmlU0dss2
	 skqzqCYc9Pb9Rs3KSmNJL+mJaSsn3jF9K0nmsgrJC9pmQOmU8I7Jg9nLk8hykBW0St
	 TiUh+PBlBpvIaOP4a/kzIIeJDF2PeKZ0DdTzV85nGWkSDPrW9GK/bnihQcQGCkhXh5
	 5ZnSCyTBy/03DAIhRU75neywahiWg1s0dh8FsBWdThnujfUYChTGmXUaPp0Fza2mHT
	 EHd3ZboLex0xt/ngzpqdaObnc2hNsL9R2iYSj+tvW5O9ARJ4JHUkIc/2V8gS7f0Cdq
	 L/bJ++2LX/hi0gOOVPhaABhFcHtF12pUy+NmyGcmMPN8pqicyTfIEc6zb+zqU8pgPL
	 acd/iUmFgqrFZiIADyL8SmxM=
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b0e878f574so6354317b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 12:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793044104; x=1793648904;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oOSXH3b8YM+3zQu1xQxJWyhbK4XJyHCVontaJB3DeTU=;
        b=tjGpctnwXPkor6pHMxxbNi7MSqjCxyoTyJPY8TGzwABiGJvRHbDrQNRWmerWn+HYHj
         OfTqX7BXbPaLhzeWeWeuAES6+JTOwbd6SWhp3534En9P6sYtGzTyhJCuPtSU2lvGEzfQ
         dVTYEEYHkgOii++N7R2g4fl7mcaBl6/84MJrLNXVnT5njK6x5vzSuOAsrSYw9aFJXUjh
         boDg4aCkuD7RC/wQ21awRMlcErVRFzOWO9+4IM6mcEavE5bvmniPD0pQPb9KOMsqPSL6
         AgeImJtTXp3TTKX816wcSN/8ZWR6Cqnq5ju5p8WAkmWDj3MO8waRgDhDCd6mJrWTnTzl
         0psg==
X-Forwarded-Encrypted: i=1; AKwUvBxBWTf1/XzpxvDrIn9uVjJzJh8ovENs1mYRWOkkfSXKYIRmDfbAOQCSxvRDISzq2V4QZpZs8CZYO/sCsAr6d5yAJ/iu8LA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAjsI4d8otPRx0bIKI+i9hXIoryga94qYG34srNaw9c9TXkMm6
	9F5f1rhoVrJTf5njiuFP7IvIa0Z478XhWLqe1/0fQK5W3Z96O95vVRdJA/8MD86lPsWD5/VDTjo
	j2tS7M5ILgKprQdBTzWtL9I5Vhff5sFU3K7AauVEp3XsY/CeHqAarnOj7vS2YVvMJmudfLe4jhJ
	wBhgLJ6ZgNsPJIU2JCtw==
X-Gm-Gg: AYBFou2f26s8WMQ5KG+Y5BXAxSFkQkPo9fxNenUlsbEDD/5hNnuGkM+ze5Jac/vQuxP
	rJ7XZTOFqMsvcr5cH3oRoemKS1gg5KWA75WMz4S9Xtltt/KpQrCG2/VK7pPW6d9yR/YbMuyRWM4
	8BwQG+K9iNBriqug81++AZYNNfaj0Si4hFnfYMsWziQwTBF/0sc27eN7bHXiPKWqxocV+xEH9Bd
	z7U0LsqlmdV4k7kH0fskCNTxC/thQBGlX/3qRg4QZbocJgfuTpY+QwTka+lsg8Mcmjgdf+h9Jyh
	56K1zfeo4mo+17a5jQVecxaxD08ps0Bev+WxUIUbYCDV7aHe5XvRHz4NRI1keAOp9pD7y+hskYX
	1HvC8vL1onXoOBhjIBcRIKOrO3Vd6Z+D2tpMmAeOwiR4asWNtyWAcIDM=
X-Received: by 2002:a05:690c:e3cb:b0:8aa:e4e7:c5a with SMTP id 00721157ae682-8b19c796e7dmr5537847b3.5.1793044103931;
        Mon, 26 Oct 2026 12:48:23 -0700 (PDT)
X-Received: by 2002:a05:690c:e3cb:b0:8aa:e4e7:c5a with SMTP id 00721157ae682-8b19c796e7dmr5537737b3.5.1793044103622;
        Mon, 26 Oct 2026 12:48:23 -0700 (PDT)
Received: from [172.21.9.52] (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-8b19e566718sm1157977b3.17.2026.10.26.12.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:48:23 -0700 (PDT)
Message-ID: <598098fe-c598-4a67-a60e-849141d27ac1@canonical.com>
Date: Mon, 26 Oct 2026 12:48:21 -0700
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
Subject: Re: [PATCH] apparmor: check address length before reading AF_UNSPEC
 bind address
To: Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
 Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 stable@vger.kernel.org
References: <20261020140030.92643-1-mike.michalo@gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20261020140030.92643-1-mike.michalo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 07:00, Michail Andreas Michalopoulos wrote:
> bind_map_addr() handles AF_UNSPEC on an IPv4 socket by reading
> addr4->sin_addr.s_addr to check for INADDR_ANY. At that point the only
> length check done is addrlen >= offsetofend(struct sockaddr, sa_family),
> i.e. 2 bytes, while sin_addr sits at offset 4. move_addr_to_kernel()
> copies only addrlen bytes into the on-stack sockaddr_storage, so a
> bind() with a short AF_UNSPEC address makes AppArmor branch on bytes the
> caller never supplied.
> 
> Depending on those bytes, a confined task gets -EAFNOSUPPORT instead of
> the -EINVAL that inet_bind_sk() returns for the same request. Kernels
> built with CONFIG_INIT_STACK_ALL_ZERO read zeroes and happen to behave
> correctly.
> 
> Check the length first, as inet_bind_sk() does, and as the AF_INET6
> case above already does for inet6_bind_sk().
> 
> Fixes: 89ac6aa752ec ("apparmor: push inet mediation into profile callbacks, and improve auditing")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>

sorry for the lateness of the reply,

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
> Tested on v7.3 built with CONFIG_INIT_STACK_NONE in QEMU, with a task
> confined by a profile allowing all network access, calling bind() on an
> AF_INET UDP socket with {.sa_family = AF_UNSPEC} and addrlen 2 and 4
> (200 times each, after leaving a non-zero address in the kernel buffer):
> unpatched returns -EAFNOSUPPORT every time, patched returns -EINVAL
> every time, matching unconfined tasks. Other AF_UNSPEC, AF_INET and
> AF_INET6 bind cases behave identically with and without the patch.
> ---
>   security/apparmor/af_inet.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/security/apparmor/af_inet.c b/security/apparmor/af_inet.c
> index 516c9016537c..a617f8058634 100644
> --- a/security/apparmor/af_inet.c
> +++ b/security/apparmor/af_inet.c
> @@ -196,6 +196,9 @@ static int bind_map_addr(const struct sock *sk, struct sockaddr *addr,
>   		 * AF_UNSPEC if the address is INADDR_ANY
>   		 */
>   		addr4 = (struct sockaddr_in *)addr;
> +		/* Length check from inet_bind_sk() */
> +		if (addrlen < sizeof(struct sockaddr_in))
> +			return -EINVAL;
>   		if (addr4->sin_addr.s_addr != htonl(INADDR_ANY))
>   			return -EAFNOSUPPORT;
>   		family = AF_INET;


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793228086;
	b=x7Kgcx8qTgHqnVHpKzDWZdu0rsFz9IOq2EAiJNpvB/hwkwlK9/R8jjHbcVqLNrPL6dXN
	 Qb8fZUyq95V98qNYdjx6gppVYUb5FDL3xTD5A5igUZGS4DI3Sk5tJNAzULWTy6tbQ8EZ1
	 nwdF2mS+VRPQEbbrJdsBrqhH/W2tjObbPspNmT4/koRdRx9/ZmeWE54CY4YcE1HP85yuj
	 8oAPZg3qyyI2GEjEwlt2nwu0tQ4LrdvXNZ5shfDlXGgQIbvbBypRBohgEPiMQz1kgSxbd
	 1ox1xIbPB0RClduk/vgfZhr3LvzzPW0IvIFnlbJXorgWl0Haj+ZHKM21Y2m3VoYmQiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228086;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jmFCGmNACFlPFrISnOMUVqVZ/JE+SOakAXip1lWiLl8=;
	b=FTzInSLAxJHDow9G4N9DmRdBcifMRG+VUyjB2SGcmyIsAC31Suh6N+OsN004E6zcCQw4
	 HrSz46JaCYYXHkCVWDZxCIm8AfEOHy9yc2oUY+tuIjGRHER2fxVJ4aCTSpdRrvmqTDyE3
	 bxZQFt7ZSoFAOzTb29P+PcyKcNXJHoVbxZpRGRBZd2dg7Vx6nDxTQio/FZVK/LJKvhGOv
	 wVLlpBPY2HbRs2OpeEz3KYt0SNypZUPKugXoYD133/TCDvWIn1qMXorDkw0/LbSkMOiLO
	 zP3EN9OH45aYdXb8KtXDdIa09zSDB4nY/QEzUbiCdHaP20yG/oTnLvdmN6qqZWCmGrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=GlNWKs5A;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09D606A323
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 22:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D09D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=GlNWKs5A
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 873C63FBFD
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 22:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793228078;
	bh=jmFCGmNACFlPFrISnOMUVqVZ/JE+SOakAXip1lWiLl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=GlNWKs5AA3HFd9yDKNvf8szc4/4ln6F/ZFFj2KISUp6T5GVyxC7XD+jRjP0xgMw14
	 QQRylVsAjSy44xPODa9nZuyrQ52PiEiDzvRpP2d0jrtay8H/oFlpjI4lix0QF97LU4
	 Npp53lDoniSjudT8cQEz7UjAx+C6037Do7xWboqTRECefr+ndBzBBJAWrA2wm70cH9
	 P+EijXweqgJGKqQ4gTWXuFZnrMTXUSiFfoVySB3FXVMfgL28wVv65uO7hNdyygIyhG
	 0JoDD+kTcghDvtwgDJxZebBdvoKO6k8SaZTTMjwuQEuCfTLZDF1I4Jbi38aO0KLnTf
	 5F3u656VXa0f/WMpiaweu34ZlilEvjB7VYPoKEquL/+DdhQGcuv0ca5ZFTsrBS53oK
	 nJQd3GtvmZf14xy0EBp91lFDwe1Fy/GRVTN7xBh/f0f+ixy62ExkgfGPohT4kEJXAD
	 bwIxIoJf2J4VGli2wvLFIathAnGWKdcj4BmQX/MjQxoWJezxIdckhhp1nWp9b83vvH
	 sZvSvv5epr8NbIh6Ixpo4pUmIKcHh19va7EAFX2KuFpos/hVVZzDv6jm+XaKlPW3MQ
	 MvoiIF+96KdFIWe4i8reGAew8azyRoYMSCC9hKr9QQ/LcvBIQ5JGuwkoEZPUE9qUaZ
	 coPB14Ww6u2J2eNn866FdudI=
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-67a781c1069so2512222d50.1
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 15:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793228077; x=1793832877;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jmFCGmNACFlPFrISnOMUVqVZ/JE+SOakAXip1lWiLl8=;
        b=R4DnzW1OOYkwicJiCbWaJO45foWGKDPCAcZgzGAMVq0WImfWoF1YS0v8o7uefpL2cC
         YAAonANDnEId9T6ZPqWJa7bgPtpWzkPkGqV4JLhW9vkdy6p51Nt65DdBmrgLa12MpESe
         e3OxlsTc+9tcTE3jSAXMVUhMfG6aTaGnjM22vVUynWhhOvrwewEA2bXuA894UgGQewr9
         69S/WhS66FlHXyKbB7SniB8A5AYlhSio1VAPd0NWr6zXHLDwqG3eCaqMwLmTNbdlD3uG
         YCUSLGEAVKpZn6vSmVUBJcVAK0Lw4npn7qR2p+d2IvBRh6UrBvHUxcYoMmatpZtiya8d
         uWyw==
X-Forwarded-Encrypted: i=1; AKwUvBx7oxUwR/0mpEuH/9ugdNdhyjb/0dAH/AWldjAWR06VaEhOmLaEHrmiPOs1BrtDrwOxV791csPhclNfb7jDN82VECtWUeo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQE7mjy6h4sZHeoSTuaX7R6J8waoJypIvPvZ0SOXR2gWF1fJe0
	QNj0obhFRVWl8AnnZOu3JK5hIyqWTOdKh9EqGFSBTMM3pxMwjTt23Wg+Z6aEu+qUU6ke9QuVTuf
	cAKKJ2k312ttvXk1oINlcy0cokPKrr5WDIM/tzkHrgNC1qHB7WGlkkl50G1WLB/zuj8u/f4QxwY
	f4pXAsrWa3so05ydlYKQ==
X-Gm-Gg: AYBFou30gcl67SbfCXDr7BCDmNubFTJQjcdutT83VWvRhOjoEJjZgh0oxrfi2yG+15W
	Tt0x3rTAkYE4RC0c//QsKE4Yy5yQW2WghGBg3vpuwDapoPZiO1qjIA+61W9+dEqH854cRMYfkx9
	+REbOYK9CPq4+wKNRb5p+EI37lDZ5tzai3fFPZGQs4ScowBawFcpeSp9yUFOqu54X3O9MrUd507
	a6kcwkPMEmPJadupzb9NtAxkJqHTxiliyY1SmzReYr3J5K4pBliyA0mPfn17SVIUk186S8dZefH
	+rYXn4QIZ3/VOmkqeFmUHpo1iMzuU5k5RCklE2VHqZP3SUpCWxuRZ5gfGLa3wiZS5IB2kpFwIgp
	wXZOhrJS6izAVl/m62USDKecpHy0/wng+i7muqjBOEheFAYffiELJsUj1a0UFb0tqFXmE3tQ4vN
	134IKHAMHldHt83LzwXOCt0ivqenLnWw==
X-Received: by 2002:a53:a78c:0:b0:679:5bea:d3e9 with SMTP id 956f58d0204a3-67a7bcbb663mr2324414d50.55.1793228077244;
        Wed, 28 Oct 2026 15:54:37 -0700 (PDT)
X-Received: by 2002:a53:a78c:0:b0:679:5bea:d3e9 with SMTP id 956f58d0204a3-67a7bcbb663mr2324396d50.55.1793228076692;
        Wed, 28 Oct 2026 15:54:36 -0700 (PDT)
Received: from [172.21.9.52] (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-67a7a07e163sm2391204d50.8.2026.10.28.15.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 15:54:36 -0700 (PDT)
Message-ID: <fcab58a3-1a8e-4bac-a96a-1c2f60742d1e@canonical.com>
Date: Wed, 28 Oct 2026 15:54:34 -0700
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
Subject: Re: [PATCH] apparmor: handle diff-encoded states in leftmatch_fb()
To: =?UTF-8?Q?Patrick_Gr=C3=B6ssing?= <invarianztheorem@posteo.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 stable@vger.kernel.org
References: <20261026133600.11252-1-invarianztheorem@posteo.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20261026133600.11252-1-invarianztheorem@posteo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/26/26 06:36, Patrick Grössing wrote:
> leftmatch_fb(), used by aa_dfa_leftmatch() and therefore by find_attach()
> to match profile attachments, open-codes the DFA transition and treats the
> default transition as final:
> 
> 	if (check[pos] == state)
> 		state = next[pos];
> 	else
> 		state = def[state];
> 
> For a state flagged MATCH_FLAG_DIFF_ENCODE the default state must instead
> be tried again with the same input character, which is what match_char()
> does for every other matcher. apparmor_parser emits differentially encoded
> DFAs by default when the kernel advertises policy/diff_encode, so larger
> attachment patterns end in a non-accepting state and the exec silently
> stays unconfined. No conflict is detected, so nothing is audited.
> 
> One visible victim is Ubuntu's firefox profile, whose attachment
> 
>    /{usr/lib/firefox{,-esr,-beta,-devedition,-nightly},opt/firefox}/firefox{,-esr,-bin}
> 
> never matches. Firefox then runs unconfined, is moved to unprivileged_userns
> and is denied CAP_SYS_ADMIN, losing its user namespace sandbox. The same
> profile compiled with -O no-diff-encode attaches.
> 
> Use match_char() in both branches of leftmatch_fb().
> 
> Fixes: 21f606610502 ("apparmor: improve overlapping domain attachment resolution")
> Cc: stable@vger.kernel.org
> Link: https://gitlab.com/apparmor/apparmor-kernel/-/issues/8
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2172229
> Signed-off-by: Patrick Grössing <invarianztheorem@posteo.com>

thank you for the patch, unfortunately this issue has already been addressed
by daa9ef365c0ed apparmor: convert duplicated dfa transitions to match_char()


> ---
> Tested on a kernel built from Ubuntu linux 7.0.0-38.38 (upstream 7.0.14):
> with this patch the diff-encoded reproducer profile from the GitLab issue
> attaches, and the stock Ubuntu firefox profile attaches to
> /usr/lib/firefox/firefox-bin (all processes "firefox (unconfined)", no
> unprivileged_userns denials). Without it both stay unconfined, also on the
> stock 7.0.0-38-generic kernel. Compile-tested with W=1.
> Based on apparmor-next as of 2026-10-26.
> 
>   security/apparmor/match.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> index 7713484..796126d 100644
> --- a/security/apparmor/match.c
> +++ b/security/apparmor/match.c
> @@ -751,7 +751,7 @@ static aa_state_t leftmatch_fb(const struct aa_dfa *dfa, aa_state_t start,
>   	u32 *base = BASE_TABLE(dfa);
>   	u32 *next = NEXT_TABLE(dfa);
>   	u32 *check = CHECK_TABLE(dfa);
> -	aa_state_t state = start, pos;
> +	aa_state_t state = start;
>   
>   	AA_BUG(!dfa);
>   	AA_BUG(!str);
> @@ -769,13 +769,10 @@ static aa_state_t leftmatch_fb(const struct aa_dfa *dfa, aa_state_t start,
>   		/* default is direct to next state */
>   		while (*str) {
>   			unsigned int adjust;
> +			u8 c = equiv[(u8) *str++];
>   
>   			wb->history[wb->pos] = state;
> -			pos = base_idx(base[state]) + equiv[(u8) *str++];
> -			if (check[pos] == state)
> -				state = next[pos];
> -			else
> -				state = def[state];
> +			match_char(state, def, base, next, check, c);
>   			if (is_loop(wb, state, &adjust)) {
>   				state = aa_dfa_match(dfa, state, str);
>   				*count -= adjust;
> @@ -788,13 +785,10 @@ static aa_state_t leftmatch_fb(const struct aa_dfa *dfa, aa_state_t start,
>   		/* default is direct to next state */
>   		while (*str) {
>   			unsigned int adjust;
> +			u8 c = (u8) *str++;
>   
>   			wb->history[wb->pos] = state;
> -			pos = base_idx(base[state]) + (u8) *str++;
> -			if (check[pos] == state)
> -				state = next[pos];
> -			else
> -				state = def[state];
> +			match_char(state, def, base, next, check, c);
>   			if (is_loop(wb, state, &adjust)) {
>   				state = aa_dfa_match(dfa, state, str);
>   				*count -= adjust;


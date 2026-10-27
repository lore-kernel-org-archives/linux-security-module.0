Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121287;
	b=cUf+Xfx+g3gRu9KwHZs8HKPjYWZHN7pu+GajWxdQCV+uxYJR4dtYyiAVzoFOTw2xFnuF
	 d9F1NNcWw14iVlbwQOoeEUhoA6oEjXXRRpEwDYigcm3N/4jCgffaMClej5YSbbDElIsCm
	 xdrs7+bKvs7s4N/oS9qeoASjdTFPFYpT3sA0sD9xNQgWVOtrI1ndbQNeB3KOvVjsnGRbI
	 SMe73MTL1ENv1SDSl4fcmPOyZk4zqaJvOnJEIqa6RoUwtemLdslqFLPf+/Fz2lMCo/I3J
	 tAu/Rm8PCPXztM2MbwtjV/E1tzzJG1srSy/gMFDcJFqY15zWYk/xi5OidvKl67dOxXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121287;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gReZVq2L+A9edWEpEVL3xuTz1Tp4ufGvwMsvE+Ou07U=;
	b=V0nb5YfChNtQh2lPKbwCb2YlJmaK+lO8JAFzvMwFdW7TJHxxGpuHIum5YAM2s8KtxgUf
	 buxkr92Yw+TWdHMpKXVAMXq24IZbGKCFkCIRovAKD7YBruh2lDm58sjwagz43BpSZ9Dih
	 i+PiqTp+9xpAhgoSKgV54LbzIcP2XA8H35BciQ4xtuAHH3k0FjTBYCEobpvmyhRuyaQg5
	 dDSB8UnKfxVO/JfzaGETvGCCDkZyjd7PwDxwdjrqLvUadliorI3LoT+mx9eAGyLsUtbcS
	 jknKSj0sAl3oaWO+dWbZ3dvo15+x72w4JmhAQlMnl26cvKo4cYjyvjQTNY62LBTKElg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=h7Jcpd65;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4908606A324
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 17:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4908606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=h7Jcpd65
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3AA023FE35
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793121284;
	bh=gReZVq2L+A9edWEpEVL3xuTz1Tp4ufGvwMsvE+Ou07U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=h7Jcpd65N1L5TyTrF2i657ggnG3ULrlFgH04MlO2DCa1w11OHp66QOMkvdKB+UZOJ
	 8MM3sbP1ezxdUXSS/cXBYCnseTFj6KOMg1bSadY3Fk4Bb6r3escEYjEtxk04WYCvMV
	 moPUdxdxdTKhm7iGexDtempmzgmWEme4Ar4UQW+aNMwKrYhMmsIR7MYjA49yn/wwYE
	 8k3o6QaOfzV1UZe7dwq1z3PdUbSPGvvbU1NtpfpteeQTM0neiBnetKmTcv1JMfM1ft
	 0LnsOFtJstba3Uzavay8a4DgcaOpTQYhZK6vEZUeHKOo28o8vjqJSN6xmDr1rp6q3D
	 U0ZthyzQugPyCq9KcOCmEWVCT/5IpDjl8pm39mbAFEcxCzRqWL8pQL9EYv01IDpF2c
	 DJCji812zbFDAXMNaPX/F/4iGJAP7h6BnI0EJmEBu/ACfA0gIO3gJFTAMjgCtGBvkv
	 QPTqw8bwSUCBazNR+TMW7Cw0iQBjUJ5GhulPdolghljZWBmSzYpTT7nj6Z+AiLsLWl
	 0ytBW3q7l2fdh72hwVM5Ntv+JNRO853OBDqdGSmJTpnSWZ/kFQ+QNnI4crPKui1+yw
	 WIZla7TeDfbp/x8SEije6o6pWhf+GBlqoUYgXKrLhuKiyXihIqrlMHkKlRl0INuc3B
	 ISG3uU/WC6VI6MtDkqsDM4dc=
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67a781c1069so143768d50.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 10:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793121283; x=1793726083;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gReZVq2L+A9edWEpEVL3xuTz1Tp4ufGvwMsvE+Ou07U=;
        b=vXgjxxG7cjW50WKk4NHHzJKpaktPAOUJ6BcbLxCxX1ZiNULsjUdqhMPy7qdblMej/S
         2/jJei5PcYzmEzPxyV+6EqiHhKYal9vSkYxV+3NqDWe9STZEFGiW8wASJS7m0DUa/VBL
         vk2trMLeyX7Ao5eyEb54girnkThlZ2w8K932kezkJQ4nB0WQe1sJooEoqjmSAZzlx0yw
         EwOBp1Q0zKioGtVmVFmE+q4BhGEHIMC7A/nAxcm1DBmsz4sVDLPQJLq2SS9bA6C7u6cJ
         z6wmxKo8tqqo8kmXTyQtq6LdVW5aYcTAsmLb9e0iD3h65St/fvbxtO/pqyR+D84KQsg4
         C6ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgcJwsW8VfKTHnlbHPtPc5+R2SlEkuojdEZ2nLO9g+HFaFWqlMfYRfz56b0eI+IvavSzI7rxFKX1455yGTEVPQSC+MbXM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+3s79TathOq8EHwbt5Cph5FKadQ5COofEU2M6qdCkosRNHcFR
	EkZ+R/I4GjRO6U7xBgXuCxAZimXnWvm6d0ezPDU/wBuuIt6jlh+uZ1O/sfNvVsMw2ep3rRC6HGf
	nnrCYME19rPW9CHgMtNWdOqH2cKfMie70mTR1UvmoRlNqug3C4otCSKwWvJkdWY9zp9K8TFAG0G
	lHo0ygXtbtx32APdaA15WecWiabtX3
X-Gm-Gg: AYBFou3uglp84MnHFWjoN3akhpFxHHE77KR+PN8vBR8CcqEHUhvLPjHEB28S6Bk2ZMQ
	rNHnIkIZ8SAzrwt9WX8zYE6GTpPVnuUspHmZU0jVIxpaU0mLkBXc8pe5kgrQ4tzUTOGrN1QjoVu
	nHSX8kRO5B445mJJmhR3nyvvcawIr1rPTf1bmkowi7/Fo0Lt79VtXGwa2/YUXqPyIGtMJNnpkD9
	W1s1TiLOTAWa1z1+43YHrTwjerfUjjQdydUbX8wL0YPZKxb06DKSpXg7Kd1lkgnQFrj2P2iO8Z2
	bCt0eadQhkvPZUtkbANt9J0zuLDJsNQFEZ+n+pAQby5NDWExz8FjM0CfmsEcmFlNSB/bzFTxlin
	6H4ZsNmE+k/Uzql5oNa8LDKcPodAgg/YBl8Biz6DhDEpJ3ipPH+ZsafY=
X-Received: by 2002:a05:690e:450d:20b0:679:c4a2:8bd3 with SMTP id 956f58d0204a3-67a7bc9ae86mr109010d50.41.1793121282934;
        Tue, 27 Oct 2026 10:14:42 -0700 (PDT)
X-Received: by 2002:a05:690e:450d:20b0:679:c4a2:8bd3 with SMTP id 956f58d0204a3-67a7bc9ae86mr108997d50.41.1793121282473;
        Tue, 27 Oct 2026 10:14:42 -0700 (PDT)
Received: from [172.21.9.52] (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-67a7a19b1d8sm445975d50.22.2026.10.27.10.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 10:14:41 -0700 (PDT)
Message-ID: <2166cb07-3111-48cf-9764-fab8003e94ea@canonical.com>
Date: Tue, 27 Oct 2026 10:14:40 -0700
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
Subject: Re: [PATCH] apparmor: convert duplicated dfa transitions to
 match_char()
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
 Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <20260901140740.2629-1-maxime.belair@canonical.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260901140740.2629-1-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/1/26 07:07, Maxime Bélair wrote:
> For historical reasons several matchers duplicate the dfa character
> transition instead of using match_char().
> 
> This is because aa_dfa_match_until() and aa_dfa_matchn_until() were
> written on a branch that did not yet have match_char(), and copied code
> from aa_dfa_match(). leftmatch_fb() used the same pattern.
> 
> When match_char() added support for diff-encoded states, the change was
> never ported to these copies.
> 
> match_char() resolves a diff encoded state by using def[state] and
> retrying the same character, until it reaches a state with a valid
> transition. The copies instead do a simple `state = def[state];` after
> the character is consumed, so on a diff encoded state one byte is dropped
> and the walk continues from the diff parent in the wrong state.
> 
> This makes an unnamed px/Px/cx/Cx transition resolve to no profile, and
> exec fails with
> 
>    apparmor="DENIED" operation="exec" info="profile transition not found"
> 
> Convert the three copies to match_char(). For a dfa with no diff
> encoded state this is a no-op.
> 
> This bug is latent until the kernel advertises policy/diff-encode.
> 
> Closes: https://gitlab.com/apparmor/apparmor/-/work_items/663
> Fixes: 21f606610502 ("apparmor: improve overlapping domain attachment resolution")
> Fixes: cf65fabc2a2c ("apparmor: add first substr match to dfa")
> Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into the apparmor tree

> ---
>   security/apparmor/match.c | 52 ++++++++++++++-------------------------
>   1 file changed, 19 insertions(+), 33 deletions(-)
> 
> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> index 7713484f6a36..5e5030c12393 100644
> --- a/security/apparmor/match.c
> +++ b/security/apparmor/match.c
> @@ -614,7 +614,7 @@ aa_state_t aa_dfa_match_until(const struct aa_dfa *dfa, aa_state_t start,
>   	u32 *next = NEXT_TABLE(dfa);
>   	u32 *check = CHECK_TABLE(dfa);
>   	u32 *accept = ACCEPT_TABLE(dfa);
> -	aa_state_t state = start, pos;
> +	aa_state_t state = start;
>   
>   	if (state == DFA_NOMATCH)
>   		return DFA_NOMATCH;
> @@ -625,22 +625,18 @@ aa_state_t aa_dfa_match_until(const struct aa_dfa *dfa, aa_state_t start,
>   		u8 *equiv = EQUIV_TABLE(dfa);
>   		/* default is direct to next state */
>   		while (*str) {
> -			pos = base_idx(base[state]) + equiv[(u8) *str++];
> -			if (check[pos] == state)
> -				state = next[pos];
> -			else
> -				state = def[state];
> +			u8 c = equiv[(u8) *str++];
> +
> +			match_char(state, def, base, next, check, c);
>   			if (accept[state])
>   				break;
>   		}
>   	} else {
>   		/* default is direct to next state */
>   		while (*str) {
> -			pos = base_idx(base[state]) + (u8) *str++;
> -			if (check[pos] == state)
> -				state = next[pos];
> -			else
> -				state = def[state];
> +			u8 c = (u8) *str++;
> +
> +			match_char(state, def, base, next, check, c);
>   			if (accept[state])
>   				break;
>   		}
> @@ -675,7 +671,7 @@ aa_state_t aa_dfa_matchn_until(const struct aa_dfa *dfa, aa_state_t start,
>   	u32 *next = NEXT_TABLE(dfa);
>   	u32 *check = CHECK_TABLE(dfa);
>   	u32 *accept = ACCEPT_TABLE(dfa);
> -	aa_state_t state = start, pos;
> +	aa_state_t state = start;
>   
>   	*retpos = NULL;
>   	if (state == DFA_NOMATCH)
> @@ -687,22 +683,18 @@ aa_state_t aa_dfa_matchn_until(const struct aa_dfa *dfa, aa_state_t start,
>   		u8 *equiv = EQUIV_TABLE(dfa);
>   		/* default is direct to next state */
>   		for (; n; n--) {
> -			pos = base_idx(base[state]) + equiv[(u8) *str++];
> -			if (check[pos] == state)
> -				state = next[pos];
> -			else
> -				state = def[state];
> +			u8 c = equiv[(u8) *str++];
> +
> +			match_char(state, def, base, next, check, c);
>   			if (accept[state])
>   				break;
>   		}
>   	} else {
>   		/* default is direct to next state */
>   		for (; n; n--) {
> -			pos = base_idx(base[state]) + (u8) *str++;
> -			if (check[pos] == state)
> -				state = next[pos];
> -			else
> -				state = def[state];
> +			u8 c = (u8) *str++;
> +
> +			match_char(state, def, base, next, check, c);
>   			if (accept[state])
>   				break;
>   		}
> @@ -751,7 +743,7 @@ static aa_state_t leftmatch_fb(const struct aa_dfa *dfa, aa_state_t start,
>   	u32 *base = BASE_TABLE(dfa);
>   	u32 *next = NEXT_TABLE(dfa);
>   	u32 *check = CHECK_TABLE(dfa);
> -	aa_state_t state = start, pos;
> +	aa_state_t state = start;
>   
>   	AA_BUG(!dfa);
>   	AA_BUG(!str);
> @@ -769,13 +761,10 @@ static aa_state_t leftmatch_fb(const struct aa_dfa *dfa, aa_state_t start,
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
> @@ -788,13 +777,10 @@ static aa_state_t leftmatch_fb(const struct aa_dfa *dfa, aa_state_t start,
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


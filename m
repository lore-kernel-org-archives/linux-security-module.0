Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120872;
	b=H4vj5ruo+k3yOnzvrVg9Fk5mGCb+5/9rOTUyeVCjp9ZYYXPo53OMWjhkiGkSjGRL7WkE
	 aM8GCD2aDO2UT1N8ZMpBBUl0v8FGh25+rlLG+T4MNJD1VAoklJ325mMsLMENg2I5DqsMm
	 Y5XkFygCLqRbZUVgpUFHsBFP8rfEZqT7YC8noYl4tcvLdLeH09KfsQFDIBe7nJ6J0wts8
	 yc87YzghvVndEqCtuLyB8jNNzjYdEh5T60dQrKzQMg5lbpAtm6pTM6pQnUmI9AYuC5ChL
	 3TQWjIR4yyEeLysOI03Er+WUhgkNriLzIJdXyUE56WMzBpFWAwosP9yEPOFABnNFE6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120872;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Bh2ereZgveIj/jLInyo8zSDhunmqvE23nbEBWuKxdwM=;
	b=Xu1H56RC/1cUgfTn6rSl9Vz4/rNDy6DJZ8lBZ+vHaun7ZfbceRqkiQJnBjv1PfOqkDPD
	 C0conFP/YYpI6rzyM2WQrlbSNiYBM4nkVS7f5gcS+waMEWdxhoT06mIkk2g2PzrCUfT25
	 ozFohAfGMuS2Y/O5uld5n93GpQ0raKdErWJjvR2+dUBa4C+pfFKI/D5pHMo+gYx3RhqMn
	 FJQ1HRHA+ckc1kj57f3ch3RHjLgHEJgGr1Tu0qtE7IqJBy96XDN3no8NDfJD2smOxSh/L
	 W727M75iTDc+PBG6gVHaoBJhg1+CY57Nhs6H3pF/hey4I2EyRDG3hsT+dQAnNDxHeUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=k+ZctrOM;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F5606A31E
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 17:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C04F5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=k+ZctrOM
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 12B953F98D
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793120869;
	bh=Bh2ereZgveIj/jLInyo8zSDhunmqvE23nbEBWuKxdwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=k+ZctrOMKuzv8tGsk8RgdsfobklAhJdYPTfLtPaETIArxhgz/U/me8ur2J+tGhl8L
	 nGz62chI3ea4+Y1sIQPy+Pz1XaR+mHD3VKJ454EmWOsxnPtmW6Q5Tn4INeLW+tujVm
	 Azuy0ePnxJr26sYAY7EmdBQSctVXMuPA9znLHsXGgbZVy7K931Mm3zj9CR5eE0WAs8
	 RaCyVsgsOO69pnQQ/29vuLewT59tQt2lcidBe5+nsR8gDz2M+RXGXiutBmuuGTutcl
	 7YZ+Fx2AARm+um2udMxy2zILh5+YntqOJNF2WuuNggPM6qRX+TRZs28JG+rDs5noKK
	 Wq65WXSRFfxkWQDdAHUfh0VWlUP/wTTZX1OqtH1EJ6msORANyo8mHZgUp0lvuCCASQ
	 IKs6RWVgFE3dtmEFqB1uVUx7PLtUbIQmYevfA/e7IZuviKMLCSMpfnXc4+9cGV7ccL
	 UHn9QR2OGuAwDwi21Yr2xhQt15P8LI2SNTUhzihuDqKXkud4ZEmLnkVqdedSlc992I
	 f5b4aRJUihA+saj6cEIMZeGCYDqXesLTMEt91qpcE4sDq3tc4YVoqpoP8sxFkmfGdw
	 T5XcKXFYsJRUhfMkfoIyCTV3kb7G46zMzAg3PDJwZQ/C0nDcbewCcZZvk59z/xqlrr
	 XsWyHnN4XTuoEf2wrY0QD250=
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b12b209c4dso205077b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 10:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120868; x=1793725668;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bh2ereZgveIj/jLInyo8zSDhunmqvE23nbEBWuKxdwM=;
        b=tr2JQ2k9qA/JRJ7AfsRtoz4cdTmUNl9QyUJDjj5azPYd6Bu4gkiZDTE9WGDXIaq0Ra
         PVuG/GcLSi8pWAStdb4dnyYmmC4qFG442zRpJfF6WGuPz+LmmIrx46sjRjiGQ2lnKItV
         VMxkz9wG5I0PR0eXO1Orhr+XcD/ULfOJfXqHMUX+zkHioHJD7jC2/+/UtSOm1Du43NdR
         ITwdACNxrBbE2pyjeXQumIrQ0sC/mSgt+sHROJ/BPAFutBg6szeu6FMHVNfGggcEtEg4
         urH1209uMTqYqGZtqfZrb2/K8C/ngiHswim5/M7tvC40WxvoEg4bIdbUJ8b+78yMLNLt
         Gt5g==
X-Forwarded-Encrypted: i=1; AKwUvBwbxFfqui9yhZqZ/zKwRouSwdtJ0g6JUtV0JTDW8aYNGDJvLUPc8vAotpwCmKJjF2kxnOu9JNFyyd87zuR9I/n4EGq3NgY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJyUbe1c7jIeN9lKsH6xdzzcFwqgeJYq9P8+nA4aIT97pPy8b7
	+Ez7D9ybH0gEzrxl82vY96Xcv/xbYUrWHlHNqQC297a0w0e1WkJWX/XpeoDcwUJArrhh08f6Lnc
	TweiPsDYowwGPy+aw0MsKOzwR79GJ1D6u8vuIelFkCFLJw7A5PSAf0pgSpXb4P0vaneJdcaPbPg
	58/lmS2LTGcYEq8/vfAW+lHJGBfVpP
X-Gm-Gg: AYBFou0ucr4Ss5q2A7K/MCCnD00uo8VO0qeYXz6w5+1UlEiY991jb7UJS4JA+wM7Rd1
	ZbAsN0rCnvR7uNcKgxXNX0u3O2wiNPWoAOSLuuwi6lCTEuZn8sfdMwHjNxpTv0ki0vp2h4W+oDz
	0o04SQD3tchAb6eVeNPAMARATn9fcYsrx6i9qXeKCckcJlwFKtX14TLf7alFeu+fEgbIU8ypvvT
	IF++sE4uMPsehJHnGTwdrGT0IYcXpYO0SB8hBXmcocNreZbDs1k2VeokS7QwACMETz3W6pEJbwX
	u+aPQib6AwBZsUQ8t+naQTB5+PshGNmeVBvKNWj+rUBwY+dyAVe+fOZuwKcEq3wgjLWDkaDzQ+U
	Vu83GkfhiyfL9IJf6zlgmQvy4mznU02TVV4GKb93nfFWA7FTxt1YvaP58
X-Received: by 2002:a05:690c:39b:b0:8b0:ab57:ec04 with SMTP id 00721157ae682-8b166c623cemr69936637b3.55.1793120867774;
        Tue, 27 Oct 2026 10:07:47 -0700 (PDT)
X-Received: by 2002:a05:690c:39b:b0:8b0:ab57:ec04 with SMTP id 00721157ae682-8b166c623cemr69936457b3.55.1793120867401;
        Tue, 27 Oct 2026 10:07:47 -0700 (PDT)
Received: from [172.21.9.52] (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-8b19e5a30bfsm15431237b3.24.2026.10.27.10.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 10:07:45 -0700 (PDT)
Message-ID: <421eda86-c7c5-4fc6-b190-f57e50d31c5f@canonical.com>
Date: Tue, 27 Oct 2026 10:07:44 -0700
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
Subject: Re: [PATCH] apparmor: fix table_size() integer overflow on 32 bit
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
 Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <20260903072650.13160-1-maxime.belair@canonical.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260903072650.13160-1-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/26 00:25, Maxime Bélair wrote:
> table_size() checks ALIGN(sizeof(struct table_header) + len * el_size, 8)
> in size_t, where @len is td_lolen, a u32 user-provided value from the
> policy blob. On 32 bit kernels both operations can overflow.
> 
> Triggering this bug allows to:
>   - overflow a 16 byte allocation with up to 4GiB of policy data
>   - store the table header at address ZERO_SIZE_PTR (kvzalloc(0))
> 
> However, this bug requires CAP_MAC_ADMIN, only affects 32 bit kernels,
> and the copy runs until the machine is destroyed, so it gives no
> controllable primitive and is therefore not a security issue.
> 
> Compute the size with the checked helpers and return 0 when the result is
> not representable, so the callers can reject the table. A valid table is
> never 0 bytes, the header alone is 12.
> 
> 64 bit kernels cannot overflow (these structs are 32 bit), and are hence
> not affected.
> 
> Fixes: e06f75a6a2b4 ("AppArmor: dfa match engine")
> Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
> ---
>   security/apparmor/include/match.h | 11 ++++++++++-
>   security/apparmor/match.c         |  6 +++++-
>   security/apparmor/policy_unpack.c |  5 +++++
>   3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/security/apparmor/include/match.h b/security/apparmor/include/match.h
> index f7bd7855f1bd..66485f76d331 100644
> --- a/security/apparmor/include/match.h
> +++ b/security/apparmor/include/match.h

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into the apparmor tree


> @@ -12,6 +12,7 @@
>   #define __AA_MATCH_H
>   
>   #include <linux/kref.h>
> +#include <linux/overflow.h>
>   
>   #define DFA_NOMATCH			0
>   #define DFA_START			1
> @@ -120,7 +121,15 @@ struct aa_dfa {
>   
>   static inline size_t table_size(size_t len, size_t el_size)
>   {
> -	return ALIGN(sizeof(struct table_header) + len * el_size, 8);
> +	size_t size;
> +
> +	/* Need check_*_overflow for 32 bit machines */
> +	if (check_mul_overflow(len, el_size, &size) ||
> +	    check_add_overflow(size, sizeof(struct table_header), &size) ||
> +	    size > SIZE_MAX - 7)
> +		return 0;
> +
> +	return ALIGN(size, 8);
>   }
>   
>   #define aa_state_t unsigned int
> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> index 7713484f6a36..825811d566b9 100644
> --- a/security/apparmor/match.c
> +++ b/security/apparmor/match.c
> @@ -58,7 +58,7 @@ static struct table_header *unpack_table(const char *blob, size_t bsize)
>   	if (th.td_lolen == 0)
>   		goto out;
>   	tsize = table_size(th.td_lolen, th.td_flags);
> -	if (bsize < tsize)
> +	if (!tsize || bsize < tsize)
>   		goto out;
>   
>   	table = kvzalloc(tsize, GFP_KERNEL);
> @@ -281,6 +281,10 @@ static struct table_header *remap_data16_to_data32(struct table_header *old)
>   	u32 i;
>   
>   	tsize = table_size(old->td_lolen, YYTD_DATA32);
> +	if (!tsize) {
> +		kvfree(old);
> +		return NULL;
> +	}
>   	new = kvzalloc(tsize, GFP_KERNEL);
>   	if (!new) {
>   		kvfree(old);
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index f1fc48e72d0e..3c744f99a15c 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -1052,6 +1052,11 @@ static int unpack_pdb(struct aa_ext *e, struct aa_policydb **policy,
>   		u16 tdflags = pdb->dfa->tables[YYTD_ID_ACCEPT]->td_flags;
>   		size_t tsize = table_size(noents, tdflags);
>   
> +		if (!tsize) {
> +			*info = "invalid dfa flags table size";
> +			error = -EPROTO;
> +			goto fail;
> +		}
>   		pdb->dfa->tables[YYTD_ID_ACCEPT2] = kvzalloc(tsize, GFP_KERNEL);
>   		if (!pdb->dfa->tables[YYTD_ID_ACCEPT2]) {
>   			*info = "failed to alloc dfa flags table";


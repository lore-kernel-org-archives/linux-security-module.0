Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227392;
	b=327MMlY/gWX7Sy8KvMXXJptp23ryuZU+DOGKoDTvPnArq05vtFqyVDBb3as3lOJPdTR8
	 +XTuVd9pAh+f12BKUZUXg6LYlq0K9lyZTWkxRG53YxD/l3oHcu4XVvQayxMEOgtyxkw/9
	 6Ch1iSlpDDn1AQsvUd0be9ProSVGIpfiT5/dxUonPmCNRaRnDRfeJusletTeyXGHCnbfT
	 u9Yc/qgXObyDUV4AmOdxb+k0A0K+Pv0H4PCqrBqNnxn5i0l5i7F+XhHGZpmAAjFyxx9vj
	 vR6IDXCi3VJu7Dyt+CumTOIRnHLR6iC5tbt5qkQY3DYvSpH5Qu+axfwkc399XHI3rFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227392;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=WxqDzkpqx1Zw/ddwhxWaFtRopLAQo5taF9tRd8I1ORI=;
	b=1foAugBcA2r7fS7xL6NO0HIGzfsPZRmLqi9kQvoxusZDb+oo998mc9mR9HRVCDjagOgo
	 Ms9nqyDig+FR6H4uvZBF1Lju8kM4/81WbLfzBmaTDeypeZzp/IxxqezRVGu1+70RkAGhT
	 L8I5H41deQhxzQ5eWM2iG7PRkyZ30xEmdzfQ9tJWuJl2oG7hmAoB7KFZjb48z3jkVgOjj
	 PZrh4LeSiIIXiOSmzOz3ceNj+1enTyk4Lo+uI9W3ea3DHm23niCzlPVEiDn2SeIJtAPvz
	 yALCqzYCWY/ejFH5Iu0bezmzDCX+eYR8PGeemqKi3JUeDrfUn9RU5H/eVBt/7SA6G0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=IHegLAeW;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7070A606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 22:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7070A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=IHegLAeW
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DD16B3FBFC
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 22:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793227382;
	bh=WxqDzkpqx1Zw/ddwhxWaFtRopLAQo5taF9tRd8I1ORI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type;
	b=IHegLAeWmk+ti2JGFEAzEoe3PmjpLkx5ZtQdAEESiC0Gdb9vsKRVsRI0COlUcPvnL
	 E23rLhocaf5ZL4nueHNpmf3cPCfEIo4ONDiUwW79LGSTX8HvpsGW9up0g6xtYFhrjv
	 TUhSsEBUfyJHIlQJ1rNXZKHH5nhnCfgUO3ApUA4ri/3WXCswg3VDHMyZz7KS9oYDJq
	 kgaRU1Z4T4xkes4KtHwce5MZYNseENtQCUXtgVxH/0YDTuNGu+/ZbfiuogOuOAC8lP
	 1wsqSi27NB9RsMZ66Im8H8ajTE1weIzc9pPz4m6ezDMBB0B9pVcnAGmNgvZfgo+LID
	 yGU3z1Ca+cQh4iCVEOlxBSE8XNrdaX1XEDfrwyNVGh/2WfMrYfpgPBBtY92UaVnJCN
	 Bo+a1zhRGPuWkm51x8NksAGFY2vOuqOuhZRZremgVHs+aSiY4Kr3wWp14EU36ILN0C
	 Dic/MqpdBGN6E1E/eckKA9+KxsCaXWP0JYxSOMYBZJDBotqaI7SphOKYw7Enb0tiZl
	 hdUa2Mkn4MoUJegrTOHyhtrbTwLGn7g6fRhr/7LkOVNH5wdff7d5TfTtBqcmv4qSBb
	 v1vJfLOMgG5n9SuzJGRI2hC85xL/wypbRiVNN9w1vqC99QhQoPKWM96OxxvufYqvCw
	 0RSga5uktrBMaCvQUAdJuzMk=
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b0cd41e7aaso24617617b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 15:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793227381; x=1793832181;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WxqDzkpqx1Zw/ddwhxWaFtRopLAQo5taF9tRd8I1ORI=;
        b=dZaEQ54+6YsnOIyQxTdcrqFvd14VcMIbomrmrpN4WJ7+8524g2iG2rTTpBXrmHeO56
         yHqGyizvgNB0/12Xyl9bAG5sVupRNHv+z8HETOHEIwv32N8uxKs/M6dUva6HCmx4GZx0
         mhOcj73LowGQ8qdRnC6WKSlqxMJWkYPUb4dxgsxy6fbYWFqqrZc8vau6SRsbRArFpEW7
         H+A4kAPgUMXM8W2Z2U+E0njTvukJvj3yKK9tjhBp+z8QEc5cQbZQavTKogC0S1Q825SO
         Ddaf+VjPpXeqBjPlWwE6vz0kjBDKc0vWg2C2YzcivdyHE3wg7O1fJEtBOkl4SojXgBvy
         GmyA==
X-Forwarded-Encrypted: i=1; AKwUvByPoaUSsMv7tefCBhk86ynEHTqjVfd2diYhEf/DM7RlQRXFPvLfAcbyE/zi3fzXAux+bGDWAiZDsTVPDnVxydV27ZKpfQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbwi3UT8qlPdNlSRw5OhP8GCiMQEpRefbb8wWjd7ExNvyrClAP
	ctiD1V9cpBQ3UdQrToSu82r61OBV9NlYWP1ZYgNJuOSlP3F7uhPPWrhFUVZhcmlZCEZ38/PcUoJ
	/qJrrR8lNs09KQIZg3alSpWyhxVYMrKIS7T5ArNtFXZ6qnmxoIX38jdjvQ76w1RvJ46WDwGURJb
	z5WWNACK8uZZFzUmm05A==
X-Gm-Gg: AYBFou0uJf7uBjc/yFCrtYJKwYKO5Nm5QvznxBB7nUDZ2qZ5om6tp7fNpwQfPAL/DDT
	j9lO7yQYFoVWoU/9QcqU6KCZhpDJNX1FB+0QPCkYK5pqTHq6sZuh9n9sQKARy1J9Su5+3Mu5YAq
	jhFvwrI62MdbVIEzjoT6Y5GkEVPDDDVfy6GvVJHMtQRraDKJUwqMh/SnftDLVYFoMe8K15FOFJE
	AuEtkeM4lwwWftavPvLmevnmbXAdoML13rrqjTzGJNwhFMHy33aSD8sVb81tNOZb+mwAMzrZyQp
	IGP3xLhYJ/QtFXjO4L2ZdxffZH/8u8gobIGD4mWeN2agfHRvqkT+8CJ1evSol/GjaIijX/MNcBw
	ZVk966THHj5E/PShoAFfCRuj8zmhjdoYOGiBVwfpl3UIjhGMxVz1p2YI2B16+pNNupfJqC+CYyR
	O1zTNPkaFA/ajlnEutq/jGo6kYjHim
X-Received: by 2002:a05:690c:10:b0:8b0:cc41:a12b with SMTP id 00721157ae682-8b1b5cb8325mr25887477b3.38.1793227381674;
        Wed, 28 Oct 2026 15:43:01 -0700 (PDT)
X-Received: by 2002:a05:690c:10:b0:8b0:cc41:a12b with SMTP id 00721157ae682-8b1b5cb8325mr25887297b3.38.1793227381162;
        Wed, 28 Oct 2026 15:43:01 -0700 (PDT)
Received: from [172.21.9.52] (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-8b19e43c9e4sm35900807b3.3.2026.10.28.15.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 15:42:59 -0700 (PDT)
Message-ID: <9bb8ebd8-d64d-4cb6-89d4-595a3bc4584b@canonical.com>
Date: Wed, 28 Oct 2026 15:42:57 -0700
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
Subject: Re: [PATCH] apparmor: avoid potential double free when remapping DFA
 tables
To: lirongqing <lirongqing@baidu.com>,
 Georgia Garcia <georgia.garcia@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261008031533.2205-1-lirongqing@baidu.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20261008031533.2205-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/26 20:15, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> When unpacking a DFA, aadfaunpack() stores a table in dfa->tables
> before attempting to remap a 16-bit table to 32-bit.
> 
> However, remapdata16todata32() frees the original table when
> allocation of the new table fails. This leaves the corresponding
> dfa->tables entry pointing to freed memory. If the unpacking then
> fails, dfafree() attempts to free the same table again.
> 
> Only publish the table to dfa->tables after any required remapping
> has completed successfully, so that dfa->tables never contains a
> pointer to a table that has already been freed.
> 
> Fixes: 9208c05f9fdf ("apparmor: add support for 2^24 states to the dfa state machine.")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into the apparmor tree

> ---
>   security/apparmor/match.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> index 7713484..ca30a42 100644
> --- a/security/apparmor/match.c
> +++ b/security/apparmor/match.c
> @@ -397,7 +397,6 @@ struct aa_dfa *aa_dfa_unpack(const void *blob, size_t size, int flags)
>   		/* check for duplicate table entry */
>   		if (dfa->tables[table->td_id])
>   			goto fail;
> -		dfa->tables[table->td_id] = table;
>   		data += table_size(table->td_lolen, table->td_flags);
>   		size -= table_size(table->td_lolen, table->td_flags);
>   
> @@ -414,9 +413,9 @@ struct aa_dfa *aa_dfa_unpack(const void *blob, size_t size, int flags)
>   				if (!table)
>   					goto fail;
>   			}
> -			dfa->tables[table->td_id] = table;
>   			break;
>   		}
> +		dfa->tables[table->td_id] = table;
>   		table = NULL;
>   	}
>   	error = verify_table_headers(dfa->tables, flags);


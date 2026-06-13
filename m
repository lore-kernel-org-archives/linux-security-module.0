Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA2D3939BF
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343761; cv=none; b=aayLaI++eJTL0kSOWBLXJbY5CenPTLHFiZf6w3U5zhnFFwSAk6ZvLcFou+Q9xoF9zOms/wVJ2+IZSHrFmlZb9+bCj5MFIJVzsOJ71SBneTUnTArnYnpMAaJ/e/x7LWloYnd+zL1ZnuzlhhTvPSB5Dd/Ytf8gwN+d7hprk60oPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343761; c=relaxed/simple;
	bh=Rye3VhjpNkav1PlLlnVkrNM/UHF2yFX7Ra/n7Fxk8Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NJyK+oEFtDglcNlfsJHFvSSN4bJWwpLWJpEwpWT+bQXqdfg0lvXo10S6RVTj2hZWuuHfiFqTR0IqHHsxM4iTGPjCx6NJjqNSXnuVsfDq+H+zEKqkfTMc28xIbthMFqxtavWJvxVoJAkjdae8ZtaEFsRIdTYaYTDQ56QTSyJ90Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=V+BEh9F8; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="V+BEh9F8"
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3AB1A3F60E
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 09:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781343755;
	bh=3cNWgxOsVXXusBlgwT5EOutzJoWn3PYwrKdwFsGdgcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type;
	b=V+BEh9F8FWzHSykE8aef9rqErrCHFDG27g5WtRhTprjhQEoboUx+US9zsg43clfVx
	 Wb9dNIzgsuS7zN0e6etNh1NKYRNxolIUg/NDGZBOhNWTvH3DR8JGHlYHYAB5LCGEtn
	 CMf56igm1jH1lWmMCR/Vuxz/k1gGZhBMYlxykpLgUqaiUCcYSY6JOR0nZ/zwIAI2j3
	 /FAnIiguxPRsY/4D5eKobWszqh59zZluf2JQ81LtqfQNEevopwaM02STrWNSyLbkXN
	 poTbYvUKS08TTjPXyBZYTntvpP4+R31glg1HALhUr5CxMRQ6SdX9pWAY61kgg5fkKg
	 Kkk9hiWhMS5o7XrxKGqd1CjsHDWX7SW4ehe2vbhsIz+3XA6G9+8MHBZkQ0XTprhgQf
	 /3TiihVIqpFuMvqPuegQsAxQyYj800Fxf05uQS5V7gOIdc43jHl+xQdayDwcC0LbHv
	 t9PxZXIbtnbo35GcyDUPf23XE0cSa8TxvdxvHwFwDJlUJOsus0ayRUbIL2ZAcjn7V+
	 eec01GW6wncVKugZbfTyvuVuWF3TQyNUjJrIeqPgNwGWVekhPISFvHpMtUjuE2LHco
	 bSRyynOe/jyEbtBlo4lVXS9V4UQaNNJ5JXGFidrts+25yzSruN20D2o8vlmCnuDBvX
	 lLUtLk+deEi5pq4DWeMicxX8=
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85a2cde332so820768a12.3
        for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 02:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781343753; x=1781948553;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cNWgxOsVXXusBlgwT5EOutzJoWn3PYwrKdwFsGdgcU=;
        b=OdBvY9tqmJGEmBsWw3cJIGwxzGDHNK3itfaCg3tyoIOOVBDPENKgW+7TsxoP/MK82A
         CRDTRp1sloW2j6amoduiMddF4PwSHP9zi2aTfGQ8Q0f1h5hOj8cnqKtQact41o7iUxpU
         hhr0cZuDQZnsZzngfKTBsXQPOqI88TapsZXCmsjUmhnQtVjgjWJDh0Q/44EfNY1d/w/O
         KTBnbqcc4bFj5EW8Z1YiqDfKNhgKJMl+pQwREa6Pp9WlhpQ82MM/uOWiVyykYSK1J/iD
         hTFe6cgOPViuEEd8xdNUmgnJOPYWMptMIo6Tn6+CUbES9y4QCh9an6dlHmVbxFlFWr5C
         kUxA==
X-Forwarded-Encrypted: i=1; AFNElJ+0BQAnAqo3jI/6p1Eo7vbUgSL9KdCGt2yvCQamE0MaTOQN8DQuAQJp+TXe6mKO7mcXe5G9r/7uOteb4cEVq7yEGQsb6Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQ76jiJSC+UsIo7hlCdHfawJqt5DHPbXqjUTXMy6/M3TRPomC
	HikKx3gwIJNQIETLRmsyx3ss4QJ4H39dzcIJzoP4dXjjgNwH/5A4o4E8g1A6VReX8ly/TqiM4Fr
	IZ16VDR6OFr3c/22n/TR1KAnYb/9EnUM4NsO6P5xC/KoovAtH2BigejqY8gzbRkEZA5cK2G/VuD
	ztQ3VRlOoUgvzrGVgTXA==
X-Gm-Gg: Acq92OEn61ZZIHoWl1A909+UlzVlI5U9lTmSIhHKCCY1Ukl5lE6RTTUGWWWOe8iGygY
	qYJbg9fp9exbuYPQEWkJ8fRL2jGxEGfkhYXNKrcdP28VEJcD1ZVZUKPBx83wtr5LRjtWi9sSWFK
	eqkgUruTiuQuHSnc5vsx842ZU1wQFG9NIALuzbjkqwD76Z6xizcX9ZQ1DIcP2qf7aGhFiUHY8G2
	NeuzBx53FcqGnXsbekv+IiLY/rWWmGzCQHK4u2piFyFTV91dma2w6SIuPDdFXLaf7RHUezMHzEn
	DnF5dFzswCX+ogVa0NIWLTvUTC4UjaaRwmobdCkgNCRncVazwTK9mH7v19XsGHCZ6wh0ioFXjh6
	4t33bRBh8eJQ7ukeGdk9R7c6UE3JG6L20vp3q
X-Received: by 2002:a05:6a21:6da4:b0:3b1:80c7:5f8c with SMTP id adf61e73a8af0-3b783f3c781mr8077334637.28.1781343753522;
        Sat, 13 Jun 2026 02:42:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:6da4:b0:3b1:80c7:5f8c with SMTP id adf61e73a8af0-3b783f3c781mr8077307637.28.1781343753109;
        Sat, 13 Jun 2026 02:42:33 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c8661b5d505sm3958420a12.1.2026.06.13.02.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 02:42:32 -0700 (PDT)
Message-ID: <c1bd4bd4-26d9-49d7-9989-2609493c2410@canonical.com>
Date: Sat, 13 Jun 2026 02:42:31 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix use-after-free in policy replacement path
To: Junxiao Chang <junxiao.chang@intel.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260613060424.2213712-1-junxiao.chang@intel.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260613060424.2213712-1-junxiao.chang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/26 23:04, Junxiao Chang wrote:
> A use-after-free issue can be triggered when running the
> following stress-ng workload:
> 
> ```
> sudo stress-ng --apparmor 0 --timeout 30 \
>      --oom-avoid-bytes 10% --skip-silent --verbose
> ```
> 
> The warning looks like:
> 
> ```
> refcount_t: addition on 0; use-after-free
> aa_replace_profiles+0xbe5/0x12a0
> policy_update+0xdb/0x170
> profile_replace+0x4b/0xb0
> ```
> 
> The issue can be reproduced on both v7.1-rc7 and Ubuntu
> 6.17.0-35-generic kernels.
> 
> aa_get_profile_loaddata() requires the supplied loaddata object
> to hold a valid reference. However, the loaddata reference count
> may already have reached zero in the replacement loop, resulting
> in a use-after-free condition.
> 
> Avoid calling aa_get_profile_loaddata() on loaddata objects with
> a zero reference count and skip those entries instead.
> 
> Fixes: a0b7091c4de4 ("apparmor: fix race on rawdata dereference")
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>

sorry I went with Ruslan Valiyev's earlier patch that fixes the same
issue
    apparmor: fix use-after-free in rawdata dedup loop

> ---
>   security/apparmor/policy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
> index b6a5eb4021dbd..98f84d4552697 100644
> --- a/security/apparmor/policy.c
> +++ b/security/apparmor/policy.c
> @@ -1220,7 +1220,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
>   	/* check for duplicate rawdata blobs: space and file dedup */
>   	if (!list_empty(&ns->rawdata_list)) {
>   		list_for_each_entry(rawdata_ent, &ns->rawdata_list, list) {
> -			if (aa_rawdata_eq(rawdata_ent, udata)) {
> +			if (kref_read(&rawdata_ent->pcount) && aa_rawdata_eq(rawdata_ent, udata)) {
>   				struct aa_loaddata *tmp;
>   
>   				tmp = aa_get_profile_loaddata(rawdata_ent);


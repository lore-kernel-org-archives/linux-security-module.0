Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D7119AD85
	for <linux-security-module@vger.kernel.org>; Fri, 27 Sep 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727459443; cv=none; b=PDBOyaWwhY5Q9vKduLhFC3JhjWDDbMGr/b6ZwAzIO6yFiCx7XSawzlcmeemprWVFDfmlSruzu5KlKU5Pev71G5mod+5iqhbrXVFiXO9f3VNAC2NsxzZDnhSsFJbKqr/vcOfmWKBleRqz69wYM3M9HQL6HXkNOLKWfK8NYg8P9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727459443; c=relaxed/simple;
	bh=IdV2F6HENA+Y5UNifmAe0seIic90LH/ONjld9T+apsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGVcD4fTiVruG6ntyDLqsBjwF3XKrG2iIe5Esdl9q5C/0BPkBHGWY44q42XbaG+NxXn1ChFFlPJAq73nR7b7e6Gy3rZnhfkopQ3lzjzlQNaxA8SauYFVEFGDqDrv22cm3UymXJF2cY5KjaxnqMZh9+dGdZ9yyepFCAeOK3YMfh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q7GUmDjO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q7GUmDjO"
Received: from [10.137.106.151] (unknown [131.107.174.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id A877A20C898C;
	Fri, 27 Sep 2024 10:50:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A877A20C898C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727459435;
	bh=3ze0byaS0d4/5vwl8vpYyRjN5KlYTsuxteZDlopYEkM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q7GUmDjOLgyFaJQlLyFJES018UdswyG/oA6HQ5ndgBvlzKF7x3RRA8H6f75FMT3/l
	 fgvrpB/x+SgyikNyr7EToeiAXs4fKcGOdVcNuMKhL8ihloBXDtLi0QtZU99SeFDC8J
	 7RBu0+UrmCMrqSze3R+AkegZJ6PXyq1o6Dxo3stc=
Message-ID: <8d1203e4-c935-4352-9924-1418a56e9f4f@linux.microsoft.com>
Date: Fri, 27 Sep 2024 10:50:35 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipe: fallback to platform keyring also if key in trusted
 keyring is rejected
To: luca.boccassi@gmail.com, linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com, serge@hallyn.com
References: <20240927082343.553258-1-luca.boccassi@gmail.com>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <20240927082343.553258-1-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/27/2024 1:23 AM, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> If enabled, we fallback to the platform keyring if the trusted keyring doesn't have
> the key used to sign the roothash. But if pkcs7_verify() rejects the key for other
> reasons, such as usage restrictions, we do not fallback. Do so, following the same
> change in dm-verity.
> 
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> ---
> The equivalent change in dm-verity was accepted, so apply it to IPE as well:
> https://lore.kernel.org/all/63220688-ac55-e1fc-300d-c93a948801e3@redhat.com/
> 
>   security/ipe/policy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> index 45f7d6a0ed23..b628f696e32b 100644
> --- a/security/ipe/policy.c
> +++ b/security/ipe/policy.c
> @@ -178,7 +178,7 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
>   					    VERIFYING_UNSPECIFIED_SIGNATURE,
>   					    set_pkcs7_data, new);
>   #ifdef CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING
> -		if (rc == -ENOKEY)
> +		if (rc == -ENOKEY || rc == -EKEYREJECTED)
>   			rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
>   						    VERIFY_USE_PLATFORM_KEYRING,
>   						    VERIFYING_UNSPECIFIED_SIGNATURE,
Acked-by: Fan Wu <wufan@linux.microsoft.com>

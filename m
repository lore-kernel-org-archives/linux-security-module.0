Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6C31B85DD
	for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726374433; cv=none; b=BKLWrVsD6/iBbVcBTR8bEtYr0BK6BB+aVv1S1OYdeOKlNDxQQyrmYGUBTxaCwUZ8K0r+glPywJktaORzx2hG9otge2H7Rr4SZbvdGN+xnREj0GGDwopH96kp/pXuG57O1BzquYgr1Y3ZFUuBaCdwvJPKYWa/LGqldtjvY/vo7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726374433; c=relaxed/simple;
	bh=CGc1KIA6mSH2RnK8SvKt9jh7WzWnKEy+x9gTSeYDKkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgAHvlYxHfXlM1oA+L7Hk3ON5LLFB7B4oGybPF5WPNzYdlDxpqDwE27HtXEWlOGMKupINTse6rwzSlCOOv92XBi+BOn+PWxEATVPAhsjcwIJ6GI4DdydxEXL1PM+CYeoiRX+8+7zutVyk0knDcftJqTk3xiJwL9YXwhza2XrY9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ly6dSfjD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ly6dSfjD"
Received: from [10.137.106.151] (unknown [131.107.174.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id BD97120C08A2;
	Sat, 14 Sep 2024 21:27:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD97120C08A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726374425;
	bh=UpBvoKHlUVR4iNOhXeBcdSs5/yYrgzkffxrkjPBniXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ly6dSfjDeVi1e+FgcqXFrVUAO02Z5n7NUxolwLNjhcphLkRB/Cz4L3WawFVnmxGDt
	 dq7il7jGH2Bf+yhkzlxntD7zYsL4G832v8i3b94hnHkJq/OED5Y7k1xSr+Iso+M4bM
	 o/IVU7BXtBID6VJoNVMU1eEpO+VWLVjAbBzLunoM=
Message-ID: <049ea228-dd20-4a15-961f-ae560a7ed715@linux.microsoft.com>
Date: Sat, 14 Sep 2024 21:27:05 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipe: allow secondary and platform keyrings to
 install/update policies
To: luca.boccassi@gmail.com, linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com
References: <20240913234840.1318655-1-luca.boccassi@gmail.com>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <20240913234840.1318655-1-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/13/2024 4:48 PM, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
...
> 
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
>   security/ipe/policy.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> index d8e7db857a2e..cac304dc86c2 100644
> --- a/security/ipe/policy.c
> +++ b/security/ipe/policy.c
> @@ -169,9 +169,15 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
>   			goto err;
>   		}
>   
> -		rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len, NULL,
> +		rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
> +					    VERIFY_USE_SECONDARY_KEYRING,
>   					    VERIFYING_UNSPECIFIED_SIGNATURE,
>   					    set_pkcs7_data, new);
> +		if (rc == -ENOKEY)
> +			rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
> +						    VERIFY_USE_PLATFORM_KEYRING,
> +						    VERIFYING_UNSPECIFIED_SIGNATURE,
> +						    set_pkcs7_data, new);
>   		if (rc)
>   			goto err;
>   	} else {

Hi Luca,

This patch looks good to me. My only thought is, like what we currently 
have for dm-verity, should we also add two kconfigs to enable to use 
these two keyrings respectively?

-Fan

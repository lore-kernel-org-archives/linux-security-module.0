Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA048C1A
	for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114475; cv=none; b=cMg3ToY11WIL3hxgaGMr/Z82SodqxI/ibah/h3YCMnrq+EVsQiHG/HH+ZlJoADvKB5WrfdY5RLHd27S5C8iiexabdmqhDaOb55miIOTLD091f5jkozgn6ExKcIJl40WuOi6/9mOWWcb73t9Oytj1Og3lg1IgM5lEcj/n6kQPpw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114475; c=relaxed/simple;
	bh=4lbzbIP6xr0jM5REIJVVR1xzODuU13RMARe0B/BhEKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgbFzALQIyD7fNM7nsbwaEefeYbxVjCk6c/TAqxXt5/WVXkq/TcG7GPpfNgp+zDhRonXANPhUDbYopcLCONAsa8alG6XyulpQ32AQ9qrsJpd9pURLyCjmqARvw41vyww8MAxtivuyfyKmybXHEEjJFwqC0cezsSNcpaqOvLbrBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jZJ8j06T; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jZJ8j06T"
Received: from [10.137.106.151] (unknown [131.107.174.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 092C520C5D86;
	Mon, 23 Sep 2024 11:01:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 092C520C5D86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727114474;
	bh=PAbKux+TMi2AA5OobQ4o/RwVBRjR6P8cddEg+wg0JtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jZJ8j06Tv3iisR7L/Comk24enotoJVLJBSTJi0bSl8NAFV8YdWJ8nq3tWxMfpoUNt
	 eVXTBhPQa8MKoecC+mCz0jhh3emZYAyPvYN6DO122KFYaTqd+SL/ao4tdofSxLO2rO
	 Gh3jox2zv4E5I14CHvn9J0QSnJ7uoV1INjAXq0Eg=
Message-ID: <4a8414c5-6df1-40aa-b538-a1b4c48f8f1f@linux.microsoft.com>
Date: Mon, 23 Sep 2024 11:01:13 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ipe: also reject policy updates with the same version
To: luca.boccassi@gmail.com, linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com
References: <20240922135614.197694-1-luca.boccassi@gmail.com>
 <20240922135614.197694-2-luca.boccassi@gmail.com>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <20240922135614.197694-2-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/2024 6:56 AM, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> Currently IPE accepts an update that has the same version as the policy
> being updated, but it doesn't make it a no-op nor it checks that the
> old and new policyes are the same. So it is possible to change the
> content of a policy, without changing its version. This is very
> confusing from userspace when managing policies.
> Instead change the update logic to reject updates that have the same
> version with ESTALE, as that is much clearer and intuitive behaviour.
> 
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
>   security/ipe/policy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> index 5de64441dfe7..01da3a377e7f 100644
> --- a/security/ipe/policy.c
> +++ b/security/ipe/policy.c
> @@ -115,7 +115,7 @@ int ipe_update_policy(struct inode *root, const char *text, size_t textlen,
>   		goto err;
>   	}
>   
> -	if (ver_to_u64(old) > ver_to_u64(new)) {
> +	if (ver_to_u64(old) >= ver_to_u64(new)) {
>   		rc = -ESTALE;
>   		goto err;
>   	}
Hi Luca,

Can you elaborate more about the potential confusion for the userspace 
users?

The policy version is currently used to prevent the activation of 
outdated or vulnerable policies (e.g., to avoid activating a policy 
trusting a compromised device). The version is not incremented unless a 
vulnerability is identified. Essentially, version comparison acts as a 
minimum threshold, ensuring only policies that meet or exceed this 
version can be activated.

Additionally, the version check is performed in ipe_set_active_pol(), so 
it will need to be updated accordingly. The documentation should also be 
refreshed to reflect these changes and ensure consistency with the new 
version handling process.

-Fan

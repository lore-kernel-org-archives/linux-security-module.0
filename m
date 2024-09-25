Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7C2130E58
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727297766; cv=none; b=m4feqYDCQrhE/d8SwJ0StmUDlrOSuP9pUr74iItgPhvjC0EVvHNNuRWumVYOLz42QMpFA2XHuTQOSAd4YEBaYtI9LIZROtV6lL0x65/zJhpPoFNjrd7ycAu7N3PqnhOplpnSVrPSNkBKcBY5NXp/mTzc/bZ8U2Fv6iigL/xHX7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727297766; c=relaxed/simple;
	bh=Snxplu0+FC8IsZWqU/KlOusN7ULLGmdKbyuQDtjBSts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwAcW060gUUtcAIdQUS3HvTqWVCm3Hy4yad2sCWlSa+R6kQfkvc8nUiqGlT58/1K1EfEaqtkVNDMIpQlfu9ThBAct5H7phNXDcrkTTovRFDXEOLWOodhUJDFho/8jN37rb2k9fkEdFtfHVeQrLjzo3hcSF4Ao8wxBJNng9OtJLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OFfQRz1Y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OFfQRz1Y"
Received: from [10.137.106.151] (unknown [131.107.174.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 24AD720C6AF5;
	Wed, 25 Sep 2024 13:56:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24AD720C6AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727297761;
	bh=eXWdT/2Xcp09Pca0FLu//YYFe8XzyyyQzHmFQsHLDNU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OFfQRz1YegBK/ztECbfrKhCwOand5zWU2IIxrjL7y9wUDBzffTJeYeP5VE+4+a4nA
	 XUIqCQZzETc1D5Li4pvp8zt9AwfDrHtqOGai1ZG0ulFxCmT8+Dq+qHrOiQt21KaiI1
	 hnzAMcLjw6Fv9GTz5cjqo0pCmkHvfz834Vvyt9UU=
Message-ID: <5cc33adc-1e02-477d-9f72-70653e68172a@linux.microsoft.com>
Date: Wed, 25 Sep 2024 13:56:00 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ipe: also reject policy updates with the same
 version
To: luca.boccassi@gmail.com, linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com
References: <20240925204227.528624-1-luca.boccassi@gmail.com>
 <20240925204227.528624-2-luca.boccassi@gmail.com>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <20240925204227.528624-2-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/2024 1:42 PM, luca.boccassi@gmail.com wrote:
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
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
> v2: also update documentation
> 
>   Documentation/admin-guide/LSM/ipe.rst | 2 +-
>   security/ipe/policy.c                 | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
> index 47323494d119..7cd04d3261ad 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -269,7 +269,7 @@ in the kernel. This file is write-only and accepts a PKCS#7 signed
>   policy. Two checks will always be performed on this policy: First, the
>   ``policy_names`` must match with the updated version and the existing
>   version. Second the updated policy must have a policy version greater than
> -or equal to the currently-running version. This is to prevent rollback attacks.
> +to the currently-running version. This is to prevent rollback attacks.

The "to" here should also be removed.

-Fan
>   
>   The ``delete`` file is used to remove a policy that is no longer needed.
>   This file is write-only and accepts a value of ``1`` to delete the policy.
> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> index 3a0069c6d5af..45f7d6a0ed23 100644
> --- a/security/ipe/policy.c
> +++ b/security/ipe/policy.c
> @@ -106,7 +106,7 @@ int ipe_update_policy(struct inode *root, const char *text, size_t textlen,
>   		goto err;
>   	}
>   
> -	if (ver_to_u64(old) > ver_to_u64(new)) {
> +	if (ver_to_u64(old) >= ver_to_u64(new)) {
>   		rc = -ESTALE;
>   		goto err;
>   	}

Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63792AE6C
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299341; cv=none; b=bZyTcrX5d2a+pN62Yu3udv5Mrc6YGTLN8bne1/XjeyAqxh7aXmQ113jJa8HA7OtkxBu8nULlsz9Jte+ZkVxzUqse+pOC9kUdD60HC2uY2ySN4ZP3kWoE5BinKVT+/GZow0R5uqW8b5bvyoxqE9pwYz2bILora8mxQppKohry9o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299341; c=relaxed/simple;
	bh=pQQGSpZ927tx7dwwWK+rCWrBy6IRfK1DLb0Ip+/z97M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIeqffjdT2G4l1N7d12/azxH0RriQzuYh2S6xaH0BuW0DZaVzMNohL2+8wKk0fIrOiRtO7EQx+eFViJKutMYiq1U+3ymsGeQFl/+5+CVzp7Xeu3iHU8rJlBl8G6X2gOzR9bQ4Fmt/58Ga2EJbrcZ6nfjDcOgZBkMMkFvfru1psE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N3mIZQH/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N3mIZQH/"
Received: from [10.137.106.151] (unknown [131.107.174.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5A1A120C6AF5;
	Wed, 25 Sep 2024 14:22:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A1A120C6AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727299339;
	bh=06tDynG3S3R6AXnncgsxLB6HUpnLuE+jiYWWiAJuqD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N3mIZQH/U9Y+TlZHA7VxAVuTohfiD+1MtMqe26TyK9FzDFsDLdAog2EOluZN8SgQh
	 pheIskocnO43vHCnyaugU7OlkgepM7wmVLqGUJpS3Hztl/yYwr49oaYfEPka167FUo
	 3jyOQ5TBzNGQ6QFd4PwQsF4TRX+l3u3JIqu0WAGg=
Message-ID: <4fc9a356-abf1-476f-ac69-7fa47cbee52c@linux.microsoft.com>
Date: Wed, 25 Sep 2024 14:22:19 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ipe: also reject policy updates with the same
 version
To: luca.boccassi@gmail.com, linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com
References: <20240925210134.530989-1-luca.boccassi@gmail.com>
 <20240925210134.530989-2-luca.boccassi@gmail.com>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <20240925210134.530989-2-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/2024 2:01 PM, luca.boccassi@gmail.com wrote:
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
> v3: fix typo in documentation
> 
>   Documentation/admin-guide/LSM/ipe.rst | 2 +-
>   security/ipe/policy.c                 | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
> index 47323494d119..f93a467db628 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -269,7 +269,7 @@ in the kernel. This file is write-only and accepts a PKCS#7 signed
>   policy. Two checks will always be performed on this policy: First, the
>   ``policy_names`` must match with the updated version and the existing
>   version. Second the updated policy must have a policy version greater than
> -or equal to the currently-running version. This is to prevent rollback attacks.
> +the currently-running version. This is to prevent rollback attacks.
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

Acked-by: Fan Wu <wufan@linux.microsoft.com>

I will pull them along with the policy signing keyring change once I get 
things ready.

-Fan

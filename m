Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1A615667B
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727297609; cv=none; b=X6BJeDB7Mibaok4Xn0QAC3P+evV6td/gYnC5gzf3jlTdoNYn/Q3e4JpctD8zhtOmwBwXlajUe1YwcuvRhZp0rl0HZLqYHgI5eAGVzpqSI0+rK9Qu2TNg8SYZQCAqO8XSgNYYCQRQ6FSTAqvFXHzt/kk/N9MRdKGPhm5414yZXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727297609; c=relaxed/simple;
	bh=BTiEg0jx50HvYGkUoNAeGpPJMpmaBaMfdhb8vW5Umyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0kH1tPlwd3jUtynqLjYlgC3qwa8NEHQCQybR967kRwaURSwdHgkZDMF26qEGpbWLxlTjEyM3Opj/pRtCs14qiNu4HwKUhUIomxO/r6D6SifkY/bAMcnsYoixO3Hn/43qD+v9LUrdtwxpQB0lM1QYxm2NXpgbLLVYxZYgNsRMpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hwhkzSzN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hwhkzSzN"
Received: from [10.137.106.151] (unknown [131.107.174.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4740120C6AF8;
	Wed, 25 Sep 2024 13:53:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4740120C6AF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727297602;
	bh=lzKJ4qfxj1wEXpMuNu+maaVPaYsEuEZPYHgGeJgLRWY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hwhkzSzNldV9u2w/IUuwjTgzt3AMY6V5LD9vK3woU7HLxDctC/DnfZ2ke3HPgnp0K
	 uWML+ldbYmUSC1nwTvL6Ly4VS9+aDZk3Z81ytRwebujChk3xbfOPgw02QSYUiFdPT7
	 P5TuHR9hkHM9SWdZm6/+pmPV2SrnRZOT1PFb07Fg=
Message-ID: <86c607dd-6b21-4731-89e0-d60dfc3f6943@linux.microsoft.com>
Date: Wed, 25 Sep 2024 13:53:22 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ipe: return -ESTALE instead of -EINVAL on update
 when new policy has a lower version
To: luca.boccassi@gmail.com, linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com
References: <20240925204227.528624-1-luca.boccassi@gmail.com>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <20240925204227.528624-1-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/2024 1:42 PM, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> When loading policies in userspace we want a recognizable error when an
> update attempts to use an old policy, as that is an error that needs
> to be treated differently from an invalid policy. Use -ESTALE as it is
> clear enough for an update mechanism.
> 
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>   security/ipe/policy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> index bf5aa97911e1..3a0069c6d5af 100644
> --- a/security/ipe/policy.c
> +++ b/security/ipe/policy.c
> @@ -107,7 +107,7 @@ int ipe_update_policy(struct inode *root, const char *text, size_t textlen,
>   	}
>   
>   	if (ver_to_u64(old) > ver_to_u64(new)) {
> -		rc = -EINVAL;
> +		rc = -ESTALE;
>   		goto err;
>   	}
>

Acked-by: Fan Wu <wufan@linux.microsoft.com>

I'm still in the process of applying kernel.org account, once I get 
everything setup I will include this in my tree.

If that process take too long time I may ask Paul to merge this from the 
lsm tree in next merge window.

-Fan

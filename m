Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D001FE45B
	for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724593; cv=none; b=m2rxPP9NYcIRQ9+EWTULAO3D/LswUF+79rUSbbsbGYGIKNW/9NoACcQu/bVxY5kTItj/TfM70Evgp0QpRbTQdbwhJAgXI+elSbR8tFYctvHHYp8hF2Mg+c5BX9s2VDkFaA/H3CPdwAIOShkKi3pF07fEmMVMB3S4670eYpl0TLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724593; c=relaxed/simple;
	bh=4BvR3qqVHbkhsrFaU6dtHleCI6rQBT+uApKTFEb+zdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4tGeaSWRdD0kwqFoZLrTx5+mYPXCkwRrADhYYChBO8gqgaO36A9JKg6kgeOtbZtuyEzhuZI5w3RNd1+pVsBY32Ic2i6Q8TY832nWDon+GcwbBVpDSBVE6KMd7BZlO9vDmhbt08LaSoMHAO4pYC1RVybe6CGsNa8bX5HA9HU43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HDz+swan; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HDz+swan"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xz4Vg5FmbzYKX;
	Wed, 27 Nov 2024 17:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732724587;
	bh=F2MXArca2NlOJjAFB2mV+14cR8CmdlnnuWWn6ahZHfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDz+swanWDKFuVbGJSZ9zsL4K8bJ3VwiqjmsSOMQt7aTcI/3qgeB/peoasGl2ZKd6
	 DoQng89zk0SaWFhIdFpNv9J6vJdBQ0QwMRGXYtt5IDh5lKt48JDXWjpvq36TjuOjEj
	 gMgnnUdxxOPbgKqnLYbPAEpwxH49xnxejXPtdd9g=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xz4Vg1bzLzT9g;
	Wed, 27 Nov 2024 17:23:07 +0100 (CET)
Date: Wed, 27 Nov 2024 17:23:06 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Gax-c <zichenxie0106@gmail.com>
Cc: gnoack@google.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] samples/landlock: Fix possible NULL dereference in
 parse_path()
Message-ID: <20241127.Aem3oshua4ai@digikod.net>
References: <20241126184156.12503-1-zichenxie0106@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126184156.12503-1-zichenxie0106@gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Nov 26, 2024 at 12:41:57PM -0600, Gax-c wrote:
> From: Zichen Xie <zichenxie0106@gmail.com>
> 
> malloc() may return NULL, leading to NULL dereference.
> Add a NULL check.
> 
> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> ---
>  samples/landlock/sandboxer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 57565dfd74a2..385fc115647f 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -91,6 +91,9 @@ static int parse_path(char *env_path, const char ***const path_list)
>  		}
>  	}
>  	*path_list = malloc(num_paths * sizeof(**path_list));
> +	if (*path_list == NULL)
> +		return 1;

This creates another NULL deference in the caller.

We should print to stderr to explain the issue, return -1, and update
the caller to check for this error.

> +
>  	for (i = 0; i < num_paths; i++)
>  		(*path_list)[i] = strsep(&env_path, ENV_DELIMITER);
>  
> -- 
> 2.34.1
> 
> 

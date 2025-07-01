Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F2260590
	for <linux-security-module@vger.kernel.org>; Tue,  1 Jul 2025 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359872; cv=none; b=tlPTUSEhjw0A1numUoPL13+wbXcxvn8LcHAlj4y3Stje38J7aWmhTJqKdEJfzViYpalQ6kiLSUEbxOJsOzUkeLl5tL1hljm3U5y+BEa11JfbGah2BFw/bjc9gyygQ1J6qjmtUyeUYa/Rt5rJZ40MP3QKzJCHXqC0U8yve3O6/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359872; c=relaxed/simple;
	bh=Zv7zHWX9QCUUIhmqfhqpUipXar2S9Vx7xA7E2cUbsTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V04ZcvF11hWMNF9znIBWdMBAKl6h2YvGE5jTbARBTTFSbwN98SVqcuyHDTf+4f+5S60AUnK4o46RdDXVGsJAWKcsFdCQVThl3S3qOTy5Un/HiIYXbZNoYMwsf9fPVKp6sXZ/nFObcNBvbdnra83uzZomRMjyj/Vce6u5Gz0d/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0b9j4gEu; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0b9j4gEu"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bWcFF0v51zSvj;
	Tue,  1 Jul 2025 10:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1751359856;
	bh=HNK3BM/12gf6KA3brcQfZRNCWeetfJXuSqh/QgcxXnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0b9j4gEusgxlm20dQkf7tX9M2yP0tJ8Ju2mnOpsdSPiGeIF29zElnAUgpUImX9wfO
	 txYqVd7z0NNbibL4U/2VtL+CR4cUa6EAMqEpffwKv7gafxQvpwcbDH1DL3vo/B9AOI
	 SuFn4wUxcn1IkY7CeEyWnRkrhugW6xLLgFzM3gdM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bWcFD47vbz90g;
	Tue,  1 Jul 2025 10:50:56 +0200 (CEST)
Date: Tue, 1 Jul 2025 10:50:55 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Brahmajit Das <listout@listout.xyz>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gnoack@google.com, jamorris@linux.microsoft.com
Subject: Re: [RFC PATCH] samples/landlock: Fix building on musl libc
Message-ID: <20250701.Ahj9ohkee3wu@digikod.net>
References: <20250630203248.16273-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630203248.16273-1-listout@listout.xyz>
X-Infomaniak-Routing: alpha

On Tue, Jul 01, 2025 at 02:02:48AM +0530, Brahmajit Das wrote:
> Building with make allyesconfig on musl results in the following
> 
> In file included from samples/landlock/sandboxer.c:22:
> /usr/include/sys/prctl.h:88:8: error: redefinition of 'struct prctl_mm_map'
>    88 | struct prctl_mm_map {
>       |        ^~~~~~~~~~~~
> In file included from samples/landlock/sandboxer.c:16:
> usr/include/linux/prctl.h:134:8: note: originally defined here
>   134 | struct prctl_mm_map {
>       |        ^~~~~~~~~~~~
> 
> This is mainly due to differnece in the sys/prctl.h between glibC and
> musl. The struct prctl_mm_map is defined in sys/prctl.h in musl.
> 
> Signed-off-by: Brahmajit Das <listout@listout.xyz>

Thanks, applied to my -next tree. I just moved down the if/include/endif
block.

I tested it with check-linux.sh from
https://github.com/landlock-lsm/landlock-test-tools
  ARCH=x86_64 CC=musl-gcc check-linux.sh build

> ---
>  samples/landlock/sandboxer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 4e2854c6f9a3..3cc990618f5b 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -13,7 +13,9 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/landlock.h>
> +#if defined(__GLIBC__)
>  #include <linux/prctl.h>
> +#endif
>  #include <linux/socket.h>
>  #include <stddef.h>
>  #include <stdio.h>
> -- 
> 2.50.0
> 
> 

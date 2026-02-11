Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0746352958
	for <linux-security-module@vger.kernel.org>; Wed, 11 Feb 2026 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770808581; cv=none; b=eC99N3ByQhp6XvxOEvidccwDVsbhCcwyMti5SSwBjjNL5w9jq7QRt0rQvol7856uD+oGR9/VJUfWTLv7EqLIB2qikpGH1tbnj7AV9O+CcuEeNQft8U4vHSKDjCK82DYp7yt6uSGfuIZkZZR9KNzTULeoLCHgON9OjangoFYeHbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770808581; c=relaxed/simple;
	bh=/Hq/qB0lGjwwN5C/Eaa5yEbAKTkQUqcLM2Xc2flmtn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aY3NZQeZndO6Xiqu/ofzJg/w17aocm1IkOOyG5sMtHtaSsFyXpjRkGvhL1zs+EV4NEpmMtgp0z1QUOFHqur5YJc+MvH9m3OfzRXCu4Z5KPcxor2qGL7DKvfvOuCKkJtLAZSTkcPkSzRHEQ8Qmubgxj0mdjrnAXeXtmOW/AcxEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CJToK9is; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CJToK9is"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f9wpx72sYzSxJ;
	Wed, 11 Feb 2026 12:16:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770808569;
	bh=dCI4QP633NwXgmVSxk0byHC6mLunBnF6KDgi1+dof5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJToK9isw/R0h5IYdu+r8ZKYRpdtUm7jgG5kEX//ZxuyCOphD9i7R97yCmLKLbdd9
	 2CUwDQeaToIuNGPCpClD3G5iq/rkZLw3BB0/Roiz2/VLuKajsBdpOUx7b9nkphqeoM
	 RunQa4KJYy3AzVB/R9k0Gpd8LZixLb+XEXc3lplo=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f9wpx2ZzjzjKX;
	Wed, 11 Feb 2026 12:16:08 +0100 (CET)
Date: Wed, 11 Feb 2026 12:16:02 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: gnoack@google.com, shuah@kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: Remove duplicate include of stdio.h
Message-ID: <20260211.Sahriegigei2@digikod.net>
References: <20260211062122.2975127-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260211062122.2975127-1-nichen@iscas.ac.cn>
X-Infomaniak-Routing: alpha

On Wed, Feb 11, 2026 at 02:21:22PM +0800, Chen Ni wrote:
> Remove duplicate inclusion of stdio.h in fs_bench.c to clean up
> redundant code.

Thanks!  I also detected this issue while running `sort -u` on the
includes, so this is already taken into account in my next branch (with
other small fixes).

> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  tools/testing/selftests/landlock/fs_bench.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_bench.c b/tools/testing/selftests/landlock/fs_bench.c
> index 733c1264e5fd..551cb615ad93 100644
> --- a/tools/testing/selftests/landlock/fs_bench.c
> +++ b/tools/testing/selftests/landlock/fs_bench.c
> @@ -26,7 +26,6 @@
>  #include <linux/prctl.h>
>  #include <stdbool.h>
>  #include <stdio.h>
> -#include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
>  #include <string.h>
> -- 
> 2.25.1
> 
> 

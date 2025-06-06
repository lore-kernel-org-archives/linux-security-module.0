Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1601B2853EB
	for <linux-security-module@vger.kernel.org>; Fri,  6 Jun 2025 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206587; cv=none; b=QgtCgwZJvEWZuam60Fnc4Gv7mG08mRUHhELEcdRPw+ra/4ZFtjxlJwzhHi4n+nVaQYjPJXFUSEwlCJu+1bIJNXOIWE7SsMwuLsAiJYjeM9DfUmpdIRHCjh3/B9+WhId44+XSvcoKatJLfhhucstSRb3XPPdxMxB7aRIjz7T2sTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206587; c=relaxed/simple;
	bh=wrn+3rOWvM87KNI4ByTT9tgKVnOn0qTuL+U86xqfst8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/uoqSMfu+LI7GLJZPa8tBDgRvBnOYF0t/Qz2N71PCub/x1fP7nTiUMDtiOIgerSLHuQwoiaOPxpN2c69ZOspQm7Hct73c2RZuERR2U/yQfCYzl7pDRhHVDynlm+/Y+cgdYBcf9vhxI1jkMug3IqdgiryEKqoG1vsN/yNArzyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=islTGnV9; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="islTGnV9"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bDHvy3G4qz19Nb;
	Fri,  6 Jun 2025 12:42:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1749206574;
	bh=oURZo3u/Ijfi30U+8q9mvGdgG1OWCl0bWYeWRioE/tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=islTGnV9JVc951WitJVrDbilZnMEcgKMy2K3pVi4ErWwirkCHCaSWK7d1Cr1XgwPe
	 RdkjgIuC2b9ZXTHos1GMeABf4GXKVaKQXDFhoJudF/YH39AyDZby0KYRh3KNFjTCxc
	 8cZjFthevoKqcJ8XRAjKN6/qbhBHHvqeRvCuvf0g=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bDHvx6Vp6zGRc;
	Fri,  6 Jun 2025 12:42:53 +0200 (CEST)
Date: Fri, 6 Jun 2025 12:42:53 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, gnoack@google.com
Subject: Re: [PATCH] selftests/landlock: Fix build of audit_test
Message-ID: <20250606.xooch5pieChi@digikod.net>
References: <20250605214416.1885878-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250605214416.1885878-1-song@kernel.org>
X-Infomaniak-Routing: alpha

On Thu, Jun 05, 2025 at 02:44:16PM -0700, Song Liu wrote:
> We are hitting build error on CentOS 9:
> 
> audit_test.c:232:40: error: ‘O_CLOEXEC’ undeclared (...)
> 
> Fix this by including fcntl.h.
> 
> Signed-off-by: Song Liu <song@kernel.org>

Thanks, I'll merge it in my tree.

> ---
>  tools/testing/selftests/landlock/audit_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
> index cfc571afd0eb..46d02d49835a 100644
> --- a/tools/testing/selftests/landlock/audit_test.c
> +++ b/tools/testing/selftests/landlock/audit_test.c
> @@ -7,6 +7,7 @@
>  
>  #define _GNU_SOURCE
>  #include <errno.h>
> +#include <fcntl.h>
>  #include <limits.h>
>  #include <linux/landlock.h>
>  #include <pthread.h>
> -- 
> 2.47.1
> 
> 

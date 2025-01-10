Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A120A5C2
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508207; cv=none; b=faOx0z/l0u9veFjGieG1wE2LXXHcVCsLzDzuJjWlDQ4HKu7jZ5kzSwbx4E5JmawOUaRNZQ8pns7QLMJgz0VQAurXjUgb3X66EuCnNH1zBditZCXTRqdWMvF/cSq0yWLne9EUMaK+zeo0K0AFbZZFGUW1qfkc+JDlnFXBdLffoPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508207; c=relaxed/simple;
	bh=bdlNO3yKK05ZKaN4uWfxIVSK8c7+0EObM46B915nyxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n29jXJDjAnsaGGQs0vnILoJMBqvhXXwPZxnc0bpZXvsCcTxPm6SebUOM9rksrhZxHKt2JVzTYdnLIheUWezBxk6alH/tm9gou+8OtT16fBvaEdL/fLgwfV7pxcZu38YEUNweu2sgL4aOxzH+GXF1dPNOGSD/PJlKjSHSHtuIZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=u/Udx6Lc; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="u/Udx6Lc"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YTzmL28vDz11R;
	Fri, 10 Jan 2025 12:23:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736508194;
	bh=6UiB4shNTla0uuyYvlN+y8UqueiEnbyVowti7Z7Fy3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/Udx6LcGTElwlVYakcX6ULQO4MtCGvlOA7z3CX9rJ+KmZJ7p0iR4GtyB0tZI24bc
	 fIyHkDU0PH79iFUBHDWG8rOOgwZPljQJKHIl5+5KCQ4xuov1CHD4/LAMEVwVwajW1T
	 +PYmiHVXRlMblpitihGAEaW48f90Yow2BTPfUGBw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YTzmK4p7Czknk;
	Fri, 10 Jan 2025 12:23:13 +0100 (CET)
Date: Fri, 10 Jan 2025 12:23:12 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Ba Jing <bajing@cmss.chinamobile.com>, Jeff Xu <jeffxu@google.com>
Cc: gnoack@google.com, shuah@kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] landlock: ptrace_test: remove unused macros
Message-ID: <20250110.do3boi0AeKee@digikod.net>
References: <20241118042407.12900-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118042407.12900-1-bajing@cmss.chinamobile.com>
X-Infomaniak-Routing: alpha

Thanks!  This is now merged in my next tree.

On Mon, Nov 18, 2024 at 12:24:07PM +0800, Ba Jing wrote:
> After reviewing the code, it was found that these macros are never
> referenced in the code. Just remove them.
> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/landlock/ptrace_test.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index a19db4d0b3bd..8f31b673ff2d 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -22,8 +22,6 @@
>  /* Copied from security/yama/yama_lsm.c */
>  #define YAMA_SCOPE_DISABLED 0
>  #define YAMA_SCOPE_RELATIONAL 1
> -#define YAMA_SCOPE_CAPABILITY 2
> -#define YAMA_SCOPE_NO_ATTACH 3
>  
>  static void create_domain(struct __test_metadata *const _metadata)
>  {
> -- 
> 2.33.0
> 
> 
> 
> 

Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C63446A6
	for <linux-security-module@vger.kernel.org>; Tue, 28 Jul 2026 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237039; cv=none; b=CPEFOS3jdyXkp9vs4MDzQzqzrQck2DjL2tjui8pcOBfgHbt7mFFpxH16wUzaiCd2gbSopaKJx7ZguZvBcVMArz+K1iGHihNeloB0Xb35ObvV1mZjeF77JGIp7Dy56tOUmBLClGXewFnHP0jlaZFE1SF2oQecUlruPoJfJZ2ytfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237039; c=relaxed/simple;
	bh=Xrf3GPNj1oBgDK8lB7s6FBPlsfZGXuyEpz4KGcgKwyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG2tGthCvcYxHc4h/GrlpucE7Ao9dExNeyOekb12fMn8QjqmN868mQLfm4MKXVMbDtPpT7I4cZrgW22Hn5BshlYBgJz2y626QpJj9MT6u4RGrzhqyPFoE0xH+vZkHjWiAkEIFMnJqENusqowka3Ik9oilc1DOMo/si6r0iCG/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=iiteOHnC; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="iiteOHnC"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h8XdL3FB9zF3g;
	Tue, 28 Jul 2026 13:03:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785236614;
	bh=+n+IKhXh1aPa0OiMMX+B8EQuDNEuQqzCdCLyYffWlRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iiteOHnCaV6UrTKQ+4jf4LpBg7Lunv7R20llS1MXUC2S9hyK+SYAf8nz/OftH4461
	 0NIK6RQ7DttJ8tp7Ng6cgpYcnbHVWq/Z3uWiJ9an2X7J+dK5Fwo4VLgbrcd4sN7tCe
	 H+kbGhDcucLB200ZOqV3wVXUHY0TvApou8GQ7Am4=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h8XdK43jTzT6Q;
	Tue, 28 Jul 2026 13:03:33 +0200 (CEST)
Date: Tue, 28 Jul 2026 13:03:32 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Oxana Kharitonova <oxana@cloudflare.com>
Cc: gnoack@google.com, paul@paul-moore.com, serge@hallyn.com, 
	wangyan01@kylinos.cn, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, landlock@lists.linux.dev, webprosto@gmail.com
Subject: Re: [PATCH 3/6] landlock: Bump ABI for LANDLOCK_SCOPE_POSIX_MSG_QUEUE
Message-ID: <20260728.ADaexaip0iez@digikod.net>
References: <20260722122952.42149-1-oxana@cloudflare.com>
 <20260722122952.42149-4-oxana@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722122952.42149-4-oxana@cloudflare.com>
X-Infomaniak-Routing: alpha

Patches must be bisectable and self-sufficient, so this one must be
squashed into the previous one that actually introduces the feature.

On Wed, Jul 22, 2026 at 01:29:39PM +0100, Oxana Kharitonova wrote:
> Increase the landlock ABI version so userspace can detect support for
> LANDLOCK_SCOPE_POSIX_MSG_QUEUE.
> 
> Signed-off-by: Oxana Kharitonova <oxana@cloudflare.com>
> ---
>  security/landlock/syscalls.c                 | 2 +-
>  tools/testing/selftests/landlock/base_test.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 36b02892c62f..84521a31bf75 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -169,7 +169,7 @@ static const struct file_operations ruleset_fops = {
>   * If the change involves a fix that requires userspace awareness, also update
>   * the errata documentation in Documentation/userspace-api/landlock.rst .
>   */
> -const int landlock_abi_version = 10;
> +const int landlock_abi_version = 11;
>  
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index cbd3c1669951..b8b5fa1042ba 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -76,7 +76,7 @@ TEST(abi_version)
>  	const struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(11, landlock_create_ruleset(NULL, 0,
>  					      LANDLOCK_CREATE_RULESET_VERSION));
>  
>  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> -- 
> 2.50.1 (Apple Git-155)
> 
> 

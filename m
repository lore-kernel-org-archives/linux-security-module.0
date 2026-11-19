Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107164;
	b=B42vyNmWiITsrJSTlg/4cLtwPa/taqfzv7BcTvCG8asmPyTWtHlGZK+7xT4qp7yaaMDW
	 LI2LGiB17pkfL/TSRFDtFDy2ahlQypFjLrVS4mSRw2lawzb5PKHJPacTwg0Bqdf7xXW8o
	 av8JzqvzjtP+vinB7NPXmmMhYqV+7hUPaaBSu95uhPsIUaKBrrOY6AsZe5ljCB3/3mmRJ
	 OfAb4wEGZSjAeTIYklyWvFGiYONEU9nl39tdo+3RK3GmT0Oi/ys/Yv7bSb2lfmU6CiZ6X
	 TRYxwgnIoWca4xfByfiUu8RwdDkploHypo5vE5jHhbKhB5MmGEbUpQkuMDZYlHhn+iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107164;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Infomaniak-Routing;
	bh=D6UMX74DM2FM70Ils+BFn1Mj7vEE8p5tjR2stdqAR5c=;
	b=ac4H4S8aEPQ3UxLTebEbc1Eiep6hnb3T2afuBaESm9b5kipmYRrticz0+idUWyMajnya
	 u8rqth69hyw2TsLvldpRGTPOpyUavt5iTu9ZJBK721b6o6vKyT20zfrCQe4Y3aM2VsknS
	 lqqwCNKmPhMsI3LAmmD9fTmqfCKpmdcmnxjQ5QgVlk1akhkQdW5uZWg6u5Io9cZdxMisw
	 Nu5B9OyBpRBtdLwtbELu2nNHQtkZPLnW1sP+2NKwnUfLNdmbYnwgbzxvflyp46/kRpdkw
	 Akwlvu3z8mz9ByCEovfKs+XXoo3wKG+aW/KZYNVauSdzBfNi9dG5Nv7Ko3sAkSJJScQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=FBCWDP8m;
	arc=none smtp.remote-ip=185.125.25.13
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC159606A324
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 16:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC159606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=FBCWDP8m
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jVkzQ2Qjgz8rQ;
	Thu, 19 Nov 2026 17:52:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795107154;
	bh=D6UMX74DM2FM70Ils+BFn1Mj7vEE8p5tjR2stdqAR5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FBCWDP8mq1f23YXbBIv3TAtsjeIA+kDH9oGCtmWa+rO4URwkcmEd8r9fgWFZ7qKLy
	 NrfJHTvc3dg/eMLpiZ2WvUy7PxkFvIGbuz44rM1nzBRdzb+wrZN0gdsmyRk1UXJsR8
	 HNj04qk64MVKHbDwSCFby0stbVfWDT1ovPgcFnQ4=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jVkzP2kJLz80S;
	Thu, 19 Nov 2026 17:52:33 +0100 (CET)
Date: Thu, 19 Nov 2026 17:52:29 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: Add missing EINVAL case in the doc for
 landlock_add_rule
Message-ID: <20261119.joongia4xahS@digikod.net>
References: <20261116233139.206924-1-m@maowtm.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116233139.206924-1-m@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Nov 16, 2026 at 11:31:37PM +0000, Tingmao Wang wrote:
> This is another way it can return EINVAL but is not documented.  Documenting
> it is useful to help rule out errors.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>

Thanks, applied!

> ---
>  security/landlock/syscalls.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index fb5af318b69b..29e9d5d7399d 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -629,6 +629,7 @@ static int add_rule_capability(struct landlock_ruleset *const ruleset,
>   * - %EAFNOSUPPORT: @rule_type is %LANDLOCK_RULE_NET_PORT but TCP/IP is not
>   *   supported by the running kernel;
>   * - %EINVAL: @flags is not valid;
> + * - %EINVAL: @rule_type is not valid;
>   * - %EINVAL: The rule accesses are inconsistent (i.e.
>   *   &landlock_path_beneath_attr.allowed_access or
>   *   &landlock_net_port_attr.allowed_access is not a subset of the ruleset
> 
> base-commit: 57493c3b7f449a60d1c43322158671b98684f9b1
> -- 
> 2.56.1
> 
> 

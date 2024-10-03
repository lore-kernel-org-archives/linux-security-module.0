Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A31A38D9
	for <linux-security-module@vger.kernel.org>; Thu,  3 Oct 2024 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969359; cv=none; b=gFxgwioAhq4UVukaENxKx4JxjpWsuE0g0wkUVhDZyadvlRMaBwLu3TGMZ1xN/kn3O+dJiXbFCE8fTKS6H3TBbB23XCxON2MH0W5xGyKhRtfDH8ayq3676QoVvSsQonQid87i8nNkVZY5hRQlWOGoDPiqbzKyQ/frayr8+sM5AIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969359; c=relaxed/simple;
	bh=vHAhxvdfBCy0Fig2E+fqk6AIZTILhCxXYnZE49T+x0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3D0gCch5nCP2FkssyJInbK/7QFfO7BXDzPvt467Fyen967cDWe4Yo+h/Zvph8MaAD+MuHS+8qjSPyW4RzMUAXB4xpeHxvJmIAfknPlXdDbammgm9xT3P5tCNZHCDE5w+TW02SUQPHoelEj5RFODD3pWnDxLznw5mwO3x/m/85A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=spXx6AcA; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="spXx6AcA"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XKFvn1VKBzjD4;
	Thu,  3 Oct 2024 17:29:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1727969349;
	bh=DHC7Z0lCSKbSGZQeetiruygx7u51kZ68Uq60ZbYypoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spXx6AcAEgB+Xx38piZsAmWdLSbYwd170/uvEaAd+/J1lqCzEgQwQi7wYZ6j0ZS2j
	 TrK76Xb/cqqESFD9aoTNVhsUrXkDObRtfBFRrJliPHeYrsJnj1zAvFSr7HOubINbHi
	 wG2Pk+JynlVB+1DA0Fusy+RKRLH91Sof8EtbV7Hs=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XKFvm5TD5zKcb;
	Thu,  3 Oct 2024 17:29:08 +0200 (CEST)
Date: Thu, 3 Oct 2024 17:29:06 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] samples/landlock: Clarify option parsing behaviour
Message-ID: <20241003.tieveil5xohL@digikod.net>
References: <20241003005042.258991-1-matthieu@buffet.re>
 <20241003005042.258991-3-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003005042.258991-3-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

On Thu, Oct 03, 2024 at 02:50:42AM +0200, Matthieu Buffet wrote:
> - Clarify which environment variables are optional, which ones are
>   mandatory
> - Clarify the difference between unset variables and empty ones

You can remove the "-" and just go with two sentences.

> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  samples/landlock/sandboxer.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index f16994d35d9e..a28e4a9c5f87 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -298,24 +298,27 @@ static bool check_ruleset_scope(const char *const env_var,
>  static void print_help(const char *argv0)
>  {
>  	fprintf(stderr,
> -		"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s "
> +		"usage: %s=\"...\" %s=\"...\" [other environment variables] %s "
>  		"<cmd> [args]...\n\n",
> -		ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> -		ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv0);
> +		ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv0);
>  	fprintf(stderr,
>  		"Execute a command in a restricted environment.\n\n");
>  	fprintf(stderr,
> -		"Environment variables containing paths and ports "
> -		"each separated by a colon:\n");
> +		"All environment variables can be multi-valued, with a "
> +		"colon delimiter.\n"
> +		"\n"
> +		"Mandatory settings:\n");
>  	fprintf(stderr,
>  		"* %s: list of paths allowed to be used in a read-only way.\n",
>  		ENV_FS_RO_NAME);
>  	fprintf(stderr,
> -		"* %s: list of paths allowed to be used in a read-write way.\n\n",
> +		"* %s: list of paths allowed to be used in a read-write way.\n",
>  		ENV_FS_RW_NAME);
>  	fprintf(stderr,
> -		"Environment variables containing ports are optional "
> -		"and could be skipped.\n");
> +		"\n"
> +		"Optional settings (when not set, their associated access "
> +		"check is always allowed, which is different from an empty "
> +		"string which means an empty list)\n");
>  	fprintf(stderr,
>  		"* %s: list of ports allowed to bind (server).\n",
>  		ENV_TCP_BIND_NAME);
> @@ -325,7 +328,8 @@ static void print_help(const char *argv0)
>  	fprintf(stderr, "* %s: list of scoped IPCs.\n",
>  		ENV_SCOPED_NAME);
>  	fprintf(stderr,
> -		"\nexample:\n"
> +		"\n"
> +		"Example:\n"
>  		"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
>  		"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
>  		"%s=\"9418\" "
> -- 
> 2.39.2
> 
> 

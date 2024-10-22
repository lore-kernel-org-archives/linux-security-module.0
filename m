Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA31C9DC5
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623022; cv=none; b=Envb4JtHJ4Qm6ktPV6DIptNYWtgjnJIc8WVnebTco7XTuU/KJyrTB/YtDUfIZS/VtpY7X5y7hXeHqYXEao9bE6/W+iE1D1gkBnc6lBiJ8NeiHonvxGz4QqvjbWaPtEBW6Os4elYKywxMEizQZwPB+mCb5g/f/nf8Yz1C1rg4mys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623022; c=relaxed/simple;
	bh=d/zYHo3XSmvCjgghf+gjOur7TW8EivNHrBv95ozuYHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FziMKSzfDh3S5p/L7t13GTldE/pXquVy0KSFj0NveKBQRshx5ynE4YWjEudSXvUxSeMLOPYY4zmEbXvq5i2OLJY/yzKkLZTUWSFezYcIrdA27b5c94c9BPqK7WZ65oLY9b1fSNXcrI0dWbTAyf2jo5ga4tBW0OUEW7DKYqOUyt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pVIqO6lu; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pVIqO6lu"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XY1T52WPJzkFQ;
	Tue, 22 Oct 2024 20:50:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729623017;
	bh=/wRzhAF3XCso0qp5u1K/B70PE/54SKPVK3abJpPO0fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pVIqO6luQBSM7PLDi3eLayxNMIhzxVetkUnCBSY6U8C8+5gr7Fmz979O4fjXOQ3tZ
	 6FiwMEQqq9/4xER4syFC3Eu8ds+gdn9i4oukCsbvTLp6aANvZ/MDbFJNkAJqrOQvLp
	 OI+l/Tqs87ynSPJmQmXiGW9/m6rf4cJW8+mtFC8A=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XY1T45cBVzV3R;
	Tue, 22 Oct 2024 20:50:16 +0200 (CEST)
Date: Tue, 22 Oct 2024 20:50:15 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v3 1/3] samples/landlock: Fix port parsing in sandboxer
Message-ID: <20241022.Xi2Wiemeehai@digikod.net>
References: <20241019151534.1400605-1-matthieu@buffet.re>
 <20241019151534.1400605-2-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241019151534.1400605-2-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

Thanks! I pushed the three patches in my -next branch with minor
changes.

On Sat, Oct 19, 2024 at 05:15:32PM +0200, Matthieu Buffet wrote:
> If you want to specify that no port can be bind()ed, you would think
> (looking quickly at both help message and code) that setting LL_TCP_BIND=""
> would do it.
> 
> However the code splits on ":" then applies atoi(), which does not allow
> checking for errors. Passing an empty string returns 0, which is
> interpreted as "allow bind(0)", which means bind to any ephemeral port.
> This bug occurs whenever passing an empty string or when leaving a
> trailing/leading colon, making it impossible to completely deny bind().
> 
> To reproduce:
> export LL_FS_RO="/" LL_FS_RW="" LL_TCP_BIND=""
> ./sandboxer strace -e bind nc -n -vvv -l -p 0
> Executing the sandboxed command...
> bind(3, {sa_family=AF_INET, sin_port=htons(0),
>      sin_addr=inet_addr("0.0.0.0")}, 16) = 0
> Listening on 0.0.0.0 37629
> 
> Use strtoull(3) instead, which allows error checking. Check that the entire
> string has been parsed correctly without overflows/underflows, but not
> that the __u64 (the type of struct landlock_net_port_attr.port)
> is a valid __u16 port: that is already done by the kernel.
> 
> Fixes: 5e990dcef12e ("samples/landlock: Support TCP restrictions")
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  samples/landlock/sandboxer.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index f847e832ba14..4cbef9d2f15b 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -60,6 +60,25 @@ static inline int landlock_restrict_self(const int ruleset_fd,
>  #define ENV_SCOPED_NAME "LL_SCOPED"
>  #define ENV_DELIMITER ":"
>  
> +static int str2num(const char *numstr, __u64 *num_dst)
> +{
> +	char *endptr = NULL;
> +	int err = 0;
> +	__u64 num;
> +
> +	errno = 0;
> +	num = strtoull(numstr, &endptr, 10);
> +	if (errno != 0)
> +		err = errno;
> +	/* Was the string empty, or not entirely parsed successfully? */
> +	else if ((*numstr == '\0') || (*endptr != '\0'))

We cannot pass "0 " but we can still pass " 0".  I'm good with that
though.

> +		err = EINVAL;
> +	else
> +		*num_dst = num;
> +
> +	return err;
> +}
> +
>  static int parse_path(char *env_path, const char ***const path_list)
>  {
>  	int i, num_paths = 0;
> @@ -160,7 +179,6 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  	char *env_port_name, *env_port_name_next, *strport;
>  	struct landlock_net_port_attr net_port = {
>  		.allowed_access = allowed_access,
> -		.port = 0,
>  	};
>  
>  	env_port_name = getenv(env_var);
> @@ -171,7 +189,17 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  
>  	env_port_name_next = env_port_name;
>  	while ((strport = strsep(&env_port_name_next, ENV_DELIMITER))) {
> -		net_port.port = atoi(strport);
> +		__u64 port;
> +
> +		if (strcmp(strport, "") == 0)
> +			continue;
> +
> +		if (str2num(strport, &port)) {
> +			fprintf(stderr, "Failed to parse port at \"%s\"\n",
> +				strport);
> +			goto out_free_name;
> +		}
> +		net_port.port = port;
>  		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>  				      &net_port, 0)) {
>  			fprintf(stderr,
> -- 
> 2.39.5
> 
> 

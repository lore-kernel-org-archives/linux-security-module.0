Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097C17995E
	for <linux-security-module@vger.kernel.org>; Fri, 20 Sep 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839548; cv=none; b=SSxUYIfw1N+L8yKmEIFzELEqjJ8z13AxU3riBVyhB2rnu0R6i6dmEUxaQ9rl591dyUzpwtFmlsQoGEtnzeFi2S69Fxk8eF9HGy6wrtfaDGIVzDmyARzN4Ai+3EHFiOqyw+1vtShqXRDOP6DgYE+Ssu5YsaA6p+RdaEwfAFXxhaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839548; c=relaxed/simple;
	bh=DLsKJr4YlzNLQtdFz2zsoC2MN60e2CxbzndUkkTCHMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcXYHPl7UmDpvKJd1QrkXpWu/ruL7sknCazpU0ChxRSYAU5dLqyndZg3+zUgbwGNpLeHfkCrhZdgiSPe+MlONUpoxUXFUfdy559L74K9VG40zA2jeHbAooI+RWCCSbM6LgiM7j6TvlkAqgVK4JQFadyn3W6ioR9oHWCEb4Zpcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=tqzNXDLl; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="tqzNXDLl"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X9D4c3WNCzQvl;
	Fri, 20 Sep 2024 15:38:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1726839536;
	bh=NJyQwUoR2L8COyJ47NkNMntwL6UmlIg6/7AE1B3kW4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tqzNXDLlK+Pl8ft5KtxZ19Bu13/1pr5OplCGVxr2Oc1PWDcsJJYRa5z84wt7SnYA7
	 gIhR/sGXTRt4TiOuVPT/XVnhndDoVhdEDP2eundgsp71egkTwK3cythUyv0b1bEPcQ
	 /4jXXUXAMonTqJlvtLOzYaN0qKHqrq4xGTuVdFzM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4X9D4b6S7mzZ1Y;
	Fri, 20 Sep 2024 15:38:55 +0200 (CEST)
Date: Fri, 20 Sep 2024 15:38:47 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Subject: Re: [RFC PATCH v1 2/7] samples/landlock: Clarify option parsing
 behaviour
Message-ID: <20240920.xaeBeed4Ge6o@digikod.net>
References: <20240916122230.114800-1-matthieu@buffet.re>
 <20240916122230.114800-3-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916122230.114800-3-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

On Mon, Sep 16, 2024 at 02:22:25PM +0200, Matthieu Buffet wrote:
> - Clarify which environment variables are optional, which ones are
>   mandatory
> - Clarify the difference between unset variables and empty ones
> - Move the (larger) help message to a helper function
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  samples/landlock/sandboxer.c | 86 ++++++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 38 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index a84ae3a15482..08704504dc51 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -221,6 +221,53 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  
>  #define LANDLOCK_ABI_LAST 5
>  
> +static void print_help(const char *prog)
> +{
> +	fprintf(stderr,
> +		"usage: %s=\"...\" %s=\"...\" [other environment variables] %s "
> +		"<cmd> [args]...\n\n",
> +		ENV_FS_RO_NAME, ENV_FS_RW_NAME, prog);
> +	fprintf(stderr,
> +		"Execute a command in a restricted environment.\n\n");
> +	fprintf(stderr,
> +		"Environment variables containing paths and ports "
> +		"can be multi-valued, with a colon delimiter.\n"
> +		"\n"
> +		"Mandatory settings:\n");
> +	fprintf(stderr,
> +		"* %s: list of paths allowed to be used in a read-only way.\n",
> +		ENV_FS_RO_NAME);
> +	fprintf(stderr,
> +		"* %s: list of paths allowed to be used in a read-write way.\n",
> +		ENV_FS_RW_NAME);
> +	fprintf(stderr,
> +		"\n"
> +		"Optional settings (when not set, their associated access "
> +		"check is always allowed) (for lists, an empty string means "
> +		"to allow nothing, e.g. %s=\"\"):\n",
> +		ENV_TCP_BIND_NAME);
> +	fprintf(stderr,
> +		"* %s: list of ports allowed to bind (server).\n",
> +		ENV_TCP_BIND_NAME);
> +	fprintf(stderr,
> +		"* %s: list of ports allowed to connect (client).\n",
> +		ENV_TCP_CONNECT_NAME);
> +	fprintf(stderr,
> +		"\n"
> +		"Example:\n"
> +		"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
> +		"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
> +		"%s=\"9418\" "
> +		"%s=\"80:443\" "
> +		"%s bash -i\n\n",
> +		ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> +		ENV_TCP_CONNECT_NAME, prog);
> +	fprintf(stderr,
> +		"This sandboxer can use Landlock features "
> +		"up to ABI version %d.\n",
> +		LANDLOCK_ABI_LAST);
> +}
> +
>  int main(const int argc, char *const argv[], char *const *const envp)
>  {
>  	const char *cmd_path;
> @@ -237,44 +284,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  	};
>  
>  	if (argc < 2) {
> -		fprintf(stderr,
> -			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\"%s "
> -			"<cmd> [args]...\n\n",
> -			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> -			ENV_TCP_CONNECT_NAME, argv[0]);
> -		fprintf(stderr,
> -			"Execute a command in a restricted environment.\n\n");
> -		fprintf(stderr,
> -			"Environment variables containing paths and ports "
> -			"each separated by a colon:\n");
> -		fprintf(stderr,
> -			"* %s: list of paths allowed to be used in a read-only way.\n",
> -			ENV_FS_RO_NAME);
> -		fprintf(stderr,
> -			"* %s: list of paths allowed to be used in a read-write way.\n\n",
> -			ENV_FS_RW_NAME);
> -		fprintf(stderr,
> -			"Environment variables containing ports are optional "
> -			"and could be skipped.\n");
> -		fprintf(stderr,
> -			"* %s: list of ports allowed to bind (server).\n",
> -			ENV_TCP_BIND_NAME);
> -		fprintf(stderr,
> -			"* %s: list of ports allowed to connect (client).\n",
> -			ENV_TCP_CONNECT_NAME);
> -		fprintf(stderr,
> -			"\nexample:\n"
> -			"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
> -			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
> -			"%s=\"9418\" "
> -			"%s=\"80:443\" "
> -			"%s bash -i\n\n",
> -			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> -			ENV_TCP_CONNECT_NAME, argv[0]);
> -		fprintf(stderr,
> -			"This sandboxer can use Landlock features "
> -			"up to ABI version %d.\n",
> -			LANDLOCK_ABI_LAST);
> +		print_help(argv[0]);

Looks good, please rebase on my "next" branch with the new LL_SCOPED
variable and send it in a new series along with the previous fix:
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next

>  		return 1;
>  	}
>  
> -- 
> 2.39.5
> 
> 

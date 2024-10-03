Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED4DDA8
	for <linux-security-module@vger.kernel.org>; Thu,  3 Oct 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969294; cv=none; b=ZCz3B7sIc/EgzsearMnJySbYJK1U45t4EfpFiHWNtSNdUnT+o7mdcWRMFvE3hq3Ij7uLuQYspJCOsOGY1qg5ROSP+maqFzwqG6bno5gxpExi5sCKbU4ZxojgPQXuh7loRirYcqWJd6GHJcwXDzUSNwsOvyseRIjeW4xshl0G4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969294; c=relaxed/simple;
	bh=23DmI3ZOG95lNnEDbHKLxf0PlXPI5rDQVtmX+6ep1CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI2v3wj3oQ4jqftkz8o+2xojC68NG6990kTg3omsS6jc+qunuXC83tHGhbaAOM66W8SSSkN+pwr788+6WHEbKkwVjDGMJv1Ujs96xrjNZ1M7b4pWNMz3jBsosmlmZlp2iH9pnPm3cPx1QwUNYFQKDsPrCiovGfGcs5vFwjnDLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nS4k6zQd; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nS4k6zQd"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XKFtT3QqXzkrw;
	Thu,  3 Oct 2024 17:28:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1727969281;
	bh=RtMnr2s6u7cUmsuv8MOgfvVfWmTfShe/DgZRHT5uuFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nS4k6zQd41hGTaVBKT9BN2UGiuWzLZ5tslKz9NF49mAukMpAxD0TbmXB9IpY89Qpv
	 CU2M35TTSM80Ktzl4HYOmT9/PJx6lkORP9/bV5Rnn/bPplAHBY2yFadY3nJl+c8weS
	 QxJ6A/HfIxj0jOXnfZCKEww4U6sSw0CU8mJZuU7s=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XKFtS6lqqzJ4X;
	Thu,  3 Oct 2024 17:28:00 +0200 (CEST)
Date: Thu, 3 Oct 2024 17:27:55 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] samples/landlock: Refactor --help message in
 function
Message-ID: <20241003.ieh5gaeCh9Sh@digikod.net>
References: <20241003005042.258991-1-matthieu@buffet.re>
 <20241003005042.258991-2-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003005042.258991-2-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

This series looks good to me, but each patch still needs to pass
clang-format.

On Thu, Oct 03, 2024 at 02:50:41AM +0200, Matthieu Buffet wrote:
> Help message is getting larger with each new supported feature (scopes,
> and soon UDP). Refactor it away into a separate helper function.
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  samples/landlock/sandboxer.c | 87 +++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 41 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index aff5ef808e22..f16994d35d9e 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -295,6 +295,51 @@ static bool check_ruleset_scope(const char *const env_var,
>  
>  #define LANDLOCK_ABI_LAST 6
>  
> +static void print_help(const char *argv0)
> +{
> +	fprintf(stderr,
> +		"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s "
> +		"<cmd> [args]...\n\n",
> +		ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> +		ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv0);
> +	fprintf(stderr,
> +		"Execute a command in a restricted environment.\n\n");
> +	fprintf(stderr,
> +		"Environment variables containing paths and ports "
> +		"each separated by a colon:\n");
> +	fprintf(stderr,
> +		"* %s: list of paths allowed to be used in a read-only way.\n",
> +		ENV_FS_RO_NAME);
> +	fprintf(stderr,
> +		"* %s: list of paths allowed to be used in a read-write way.\n\n",
> +		ENV_FS_RW_NAME);
> +	fprintf(stderr,
> +		"Environment variables containing ports are optional "
> +		"and could be skipped.\n");
> +	fprintf(stderr,
> +		"* %s: list of ports allowed to bind (server).\n",
> +		ENV_TCP_BIND_NAME);
> +	fprintf(stderr,
> +		"* %s: list of ports allowed to connect (client).\n",
> +		ENV_TCP_CONNECT_NAME);
> +	fprintf(stderr, "* %s: list of scoped IPCs.\n",
> +		ENV_SCOPED_NAME);
> +	fprintf(stderr,
> +		"\nexample:\n"
> +		"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
> +		"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
> +		"%s=\"9418\" "
> +		"%s=\"80:443\" "
> +		"%s=\"a:s\" "
> +		"%s bash -i\n\n",
> +		ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> +		ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv0);
> +	fprintf(stderr,
> +		"This sandboxer can use Landlock features "
> +		"up to ABI version %d.\n",
> +		LANDLOCK_ABI_LAST);
> +}

While we are at it, could you please transform this set of fprintf()
calls to a static const char[] with "%1$s" where we need argv0, and use
the defined constants in place instead of %s (with string conversion for
the ABI).  This would make the whole help easier to read and maintain.

We'll need some help from the preprocessor as explained in
https://gcc.gnu.org/onlinedocs/cpp/Stringizing.html:

#define XSTR(s) STR(s)
#define STR(s) #s

static const char help[] =
"usage: " ENV_FS_RO_NAME "=\"...\" [...] %1$s "
[...]
"up to ABI version " XSTR(LANDLOCK_ABI_LAST) ".\n";

> +
>  int main(const int argc, char *const argv[], char *const *const envp)
>  {
>  	const char *cmd_path;
> @@ -313,47 +358,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  	};
>  
>  	if (argc < 2) {
> -		fprintf(stderr,
> -			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s "
> -			"<cmd> [args]...\n\n",
> -			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> -			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
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
> -		fprintf(stderr, "* %s: list of scoped IPCs.\n",
> -			ENV_SCOPED_NAME);
> -		fprintf(stderr,
> -			"\nexample:\n"
> -			"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
> -			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
> -			"%s=\"9418\" "
> -			"%s=\"80:443\" "
> -			"%s=\"a:s\" "
> -			"%s bash -i\n\n",
> -			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> -			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
> -		fprintf(stderr,
> -			"This sandboxer can use Landlock features "
> -			"up to ABI version %d.\n",
> -			LANDLOCK_ABI_LAST);
> +		print_help(argv[0]);
>  		return 1;
>  	}
>  
> -- 
> 2.39.2
> 
> 

Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B49335B631
	for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722077; cv=none; b=QyzzTPX0NX4lAYZI+ZUxtB62xuSiuAZg11t8MRhRiKDpDOh0ioJTLg0B5/CjWlb8Irv98QTwl3CX+v4fjpoy/RDfG9hCDr67ULo8pW7e04xOG8IhBl47YOZA+afinaJyjpXw+D1v3qeMOEY8PGDn5yPLnzBcPuN12YSdiOeY8OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722077; c=relaxed/simple;
	bh=p1DZllPnXyA1x0Y0psBMdb7chG6U0c6ebPxwiXsjS7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTYawCawGaHhW7EwAc1ijUTMJbwcGJHpb/BqJ0qmAYwdyDUVfOCKaooY+9DAvoX5aK9I0xyI3HaQsfIHLcpYFusH0wV2QnBNuIfMhJ93qsaqvQtiita05oKtrS9IFQTUQR9Ml0QaAkvCkR/rb2wf0lNJw6rH5fipkWbGttqU7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=uThQtlKS; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="uThQtlKS"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f2C0n1ybdzhVw;
	Thu, 29 Jan 2026 22:27:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1769722073;
	bh=YWdX0XpZwY7UPTO/uNdHQLJf31WGWzNXUl53cZoSqEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uThQtlKSHqCNsH3xiIYwJKg/FZszif0vmOt9pEhAxqvKvkLbVo5Zg+xY3PoYclk5i
	 XLwfH0jgsbdtvMh3d82b+RsFlS37Uv6N9cf/jbWs1Egep6lHAiPuAPQZM7XpKa1KeX
	 UpvS+7fFAKgl44dxi7tF6zXFESJ3CHSlGuTBTVX0=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f2C0m4RBLzdpQ;
	Thu, 29 Jan 2026 22:27:52 +0100 (CET)
Date: Thu, 29 Jan 2026 22:27:51 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/6] samples/landlock: Support
 LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
Message-ID: <20260129.Hizei3ea8eew@digikod.net>
References: <cover.1767115163.git.m@maowtm.org>
 <5e9ac4104e5f70cdf250a3dea9a553a65a36fff9.1767115163.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e9ac4104e5f70cdf250a3dea9a553a65a36fff9.1767115163.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

We should have a (potentially small) description of what this patch
does, even if it's a bit redundant with the subject.


On Tue, Dec 30, 2025 at 05:20:21PM +0000, Tingmao Wang wrote:
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> I've decided to use "u" as the character to control this scope bit since
> it stands for (normal) Unix sockets.  Imo using "p" or "n" would make it less
> clear / memorable.  Open to suggestions.

Looks good to me.

> 
> Also, open to suggestion whether socket scoping (pathname and abstract)
> should be enabled by default, if LL_SCOPED is not set.  This would break
> backward compatibility, but maybe we shouldn't guarentee backward
> compatibility of this sandboxer in the first place, and almost all cases
> of Landlock usage would want socket scoping.

I agree that this example could have better defaults, but this should be
done with a standalone patch series.  An important point to keep in mind
is that this example is used by developers (e.g. potential copy/paste),
so we need to be careful to not encourage them to create code which is
backward incompatible.  I think the best way to do it is to request a
default behavior for a specific Landlock ABI version (e.g. with a new
parameter).

I'd also like this example to still be simple to understand, update, and
maintain.

> 
>  samples/landlock/sandboxer.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index e7af02f98208..2de14e1c787d 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -234,14 +234,16 @@ static bool check_ruleset_scope(const char *const env_var,
>  	bool error = false;
>  	bool abstract_scoping = false;
>  	bool signal_scoping = false;
> +	bool named_scoping = false;
>  
>  	/* Scoping is not supported by Landlock ABI */
>  	if (!(ruleset_attr->scoped &
> -	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL)))
> +	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL |
> +	       LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET)))
>  		goto out_unset;
>  
>  	env_type_scope = getenv(env_var);
> -	/* Scoping is not supported by the user */
> +	/* Scoping is not requested by the user */
>  	if (!env_type_scope || strcmp("", env_type_scope) == 0)
>  		goto out_unset;
>  
> @@ -254,6 +256,9 @@ static bool check_ruleset_scope(const char *const env_var,
>  		} else if (strcmp("s", ipc_scoping_name) == 0 &&
>  			   !signal_scoping) {
>  			signal_scoping = true;
> +		} else if (strcmp("u", ipc_scoping_name) == 0 &&
> +			   !named_scoping) {
> +			named_scoping = true;
>  		} else {
>  			fprintf(stderr, "Unknown or duplicate scope \"%s\"\n",
>  				ipc_scoping_name);
> @@ -270,6 +275,8 @@ static bool check_ruleset_scope(const char *const env_var,
>  		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
>  	if (!signal_scoping)
>  		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_SIGNAL;
> +	if (!named_scoping)
> +		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
>  
>  	unsetenv(env_var);
>  	return error;
> @@ -299,7 +306,7 @@ static bool check_ruleset_scope(const char *const env_var,
>  
>  /* clang-format on */
>  
> -#define LANDLOCK_ABI_LAST 7
> +#define LANDLOCK_ABI_LAST 8
>  
>  #define XSTR(s) #s
>  #define STR(s) XSTR(s)
> @@ -325,6 +332,7 @@ static const char help[] =
>  	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
>  	"  - \"a\" to restrict opening abstract unix sockets\n"
>  	"  - \"s\" to restrict sending signals\n"
> +	"  - \"u\" to restrict opening pathname (non-abstract) unix sockets\n"
>  	"\n"
>  	"A sandboxer should not log denied access requests to avoid spamming logs, "
>  	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
> @@ -334,7 +342,7 @@ static const char help[] =
>  	ENV_FS_RW_NAME "=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
>  	ENV_TCP_BIND_NAME "=\"9418\" "
>  	ENV_TCP_CONNECT_NAME "=\"80:443\" "
> -	ENV_SCOPED_NAME "=\"a:s\" "
> +	ENV_SCOPED_NAME "=\"a:s:u\" "
>  	"%1$s bash -i\n"
>  	"\n"
>  	"This sandboxer can use Landlock features up to ABI version "
> @@ -356,7 +364,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>  				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
>  		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
> -			  LANDLOCK_SCOPE_SIGNAL,
> +			  LANDLOCK_SCOPE_SIGNAL |
> +			  LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET,
>  	};
>  	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
>  	int set_restrict_flags = 0;
> @@ -436,6 +445,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		/* Removes LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON for ABI < 7 */
>  		supported_restrict_flags &=
>  			~LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
> +		__attribute__((fallthrough));
> +	case 7:
> +		/* Removes LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET for ABI < 8 */
> +		ruleset_attr.scoped &= ~LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
>  
>  		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
>  		fprintf(stderr,
> -- 
> 2.52.0
> 

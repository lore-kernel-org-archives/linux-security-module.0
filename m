Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E93C4562
	for <linux-security-module@vger.kernel.org>; Tue, 28 Jul 2026 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785236678; cv=none; b=B4mAsFc0MYJA7B+/hLLc/itcXLNTc/wS+PoNzga422m2DbXgEjojZFj5X8JqFoP4WRf5N6ZdjE8uym0N6qsPeLgwr9QMh80GYx109EZYTjhxfBGqIUm3V+13wqi8b+W0JzWtXIkWD04YzfXLVkeXC4RBFLfZSFSbRl6AYaktEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785236678; c=relaxed/simple;
	bh=5IFxQcG32HM7Ko6hjDGZeWs5YP5H5OjDIRhQFk4PCFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de7A57nigv1x2AMVVrmxeJz79c3TiuV5ropHSIC4issLuXKF2uTZpM5A1C2tQz/jV1A/d+xIfOfJBmSCSqsHPoYa4NlhpijpmXyJt/0w+shShFRKDyCQiLcE9+f6+VJNRhD00Kgg90Bzb6WcfDoUUwPpxjIt4TD5drwSlXkGF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=173KHmow; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="173KHmow"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h8XfK5L4zzsSy;
	Tue, 28 Jul 2026 13:04:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785236665;
	bh=xLD7GVG+ucS1KPkHrDWDO/hNWXwCYWJMVWtzfhIW390=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=173KHmowe+xcynApCK8XzoqWJupaSr9L8bEYUi3AD9xAEokjgaBFxzeCp6tN+tOQB
	 EknX6yLvhjBFIiymb7981W+ZfiCKVvv/ECDU7/oAfohs+H5Ewk/7VdKkw03pmma85o
	 zRZmSPvVMEibU3ijLugkrRRWxVTTkaQuJUP3VglM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h8XfJ6pm3zhmN;
	Tue, 28 Jul 2026 13:04:24 +0200 (CEST)
Date: Tue, 28 Jul 2026 13:04:24 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Oxana Kharitonova <oxana@cloudflare.com>
Cc: gnoack@google.com, paul@paul-moore.com, serge@hallyn.com, 
	wangyan01@kylinos.cn, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, landlock@lists.linux.dev, webprosto@gmail.com
Subject: Re: [PATCH 5/6] samples/landlock: Support POSIX message queue scoping
Message-ID: <20260728.Ro3ni9Cee9es@digikod.net>
References: <20260722122952.42149-1-oxana@cloudflare.com>
 <20260722122952.42149-6-oxana@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722122952.42149-6-oxana@cloudflare.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 22, 2026 at 01:29:41PM +0100, Oxana Kharitonova wrote:
> Teach the sandboxer sample to request LANDLOCK_SCOPE_POSIX_MSG_QUEUE
> through LL_SCOPED.
> 
> Add the "q" scope selector for POSIX message queues and document it in
> the sample help text. Also allow POSIX message queue denials to be
> quieted with "posix_msg_queue" through LL_QUIET_ACCESS.

This commit message should contains an example to prove with this
sandboxer that the scope actually works, or at least to show how to use
it.

> 
> Signed-off-by: Oxana Kharitonova <oxana@cloudflare.com>
> ---
>  samples/landlock/sandboxer.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index ac71019e6212..59024ca53398 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -240,10 +240,12 @@ static bool check_ruleset_scope(const char *const env_var,
>  	bool error = false;
>  	bool abstract_scoping = false;
>  	bool signal_scoping = false;
> +	bool posix_mqueue_scoping = false;
>  
>  	/* Scoping is not supported by Landlock ABI */
>  	if (!(ruleset_attr->scoped &
> -	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL)))
> +	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL |
> +	       LANDLOCK_SCOPE_POSIX_MSG_QUEUE)))
>  		goto out_unset;
>  
>  	env_type_scope = getenv(env_var);
> @@ -260,6 +262,9 @@ static bool check_ruleset_scope(const char *const env_var,
>  		} else if (strcmp("s", ipc_scoping_name) == 0 &&
>  			   !signal_scoping) {
>  			signal_scoping = true;
> +		} else if (strcmp("q", ipc_scoping_name) == 0 &&
> +			   !posix_mqueue_scoping) {
> +			posix_mqueue_scoping = true;
>  		} else {
>  			fprintf(stderr, "Unknown or duplicate scope \"%s\"\n",
>  				ipc_scoping_name);
> @@ -276,6 +281,8 @@ static bool check_ruleset_scope(const char *const env_var,
>  		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
>  	if (!signal_scoping)
>  		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_SIGNAL;
> +	if (!posix_mqueue_scoping)
> +		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_POSIX_MSG_QUEUE;
>  
>  	unsetenv(env_var);
>  	return error;
> @@ -354,6 +361,9 @@ static int add_quiet_access(const char *const env_var,
>  				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
>  		else if (strcmp(str_access, "signal") == 0)
>  			ruleset_attr->quiet_scoped |= LANDLOCK_SCOPE_SIGNAL;
> +		else if (strcmp(str_access, "posix_msg_queue") == 0)
> +			ruleset_attr->quiet_scoped |=
> +				LANDLOCK_SCOPE_POSIX_MSG_QUEUE;
>  		else {
>  			fprintf(stderr, "Unknown quiet access \"%s\"\n",
>  				str_access);
> @@ -400,6 +410,7 @@ static const char help[] =
>  	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
>  	"  - \"a\" to restrict opening abstract unix sockets\n"
>  	"  - \"s\" to restrict sending signals\n"
> +	"  - \"q\" to restrict opening POSIX message queues\n"
>  	"\n"
>  	"A sandboxer should not log denied access requests to avoid spamming logs, "
>  	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
> @@ -416,6 +427,7 @@ static const char help[] =
>  	"  - \"udp_connect\" to quiet udp connect / send denials\n"
>  	"  - \"abstract_unix_socket\" to quiet abstract unix socket denials\n"
>  	"  - \"signal\" to quiet signal denials\n"
> +	"  - \"posix_msg_queue\" to quiet POSIX message queue denials\n"
>  	"\n"
>  	"Example:\n"
>  	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
> @@ -423,7 +435,7 @@ static const char help[] =
>  	ENV_TCP_BIND_NAME "=\"9418\" "
>  	ENV_TCP_CONNECT_NAME "=\"80:443\" "
>  	ENV_UDP_CONNECT_SEND_NAME "=\"53\" "
> -	ENV_SCOPED_NAME "=\"a:s\" "
> +	ENV_SCOPED_NAME "=\"a:s:q\" "
>  	"%1$s bash -i\n"
>  	"\n"
>  	"This sandboxer can use Landlock features up to ABI version "
> -- 
> 2.50.1 (Apple Git-155)
> 
> 

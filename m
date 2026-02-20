Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1347526F2A7
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616818; cv=none; b=HSSCl0H11EdmKuCocXGVlX5ckufFusaxdscYQq9k/B2yGxzq1KDNsXIlxqITUoJ2Nhbt5RYGKWqDwSATphYNuZbxkuZniHgB27zlGBaP1dGYMB2S7d+xvr7qnQfsiXW8TmDJ4HF3yd3DGTW11JOSNFi2gjMpyNtCgtzBSSW/950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616818; c=relaxed/simple;
	bh=iDybTyQ6VIGfc8cvzs+J2wt1ghy/sbACnQzIRgE4Ht0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSTM1Zc0sYsomJNu0RLVtiQ6o6+Ex57/KQZ8wY8QOzoCaQzNyaCtOFHSWvxW8c5MlTMrI97CsgUDU1+YcwyPeypr2wmddAoAQZjh5DlowP38A2BME9JvLvkkcgrO4PBvXCgqnW6wpFcYvMxbzj6XT9gF17Du6K2xoXFO43UFI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ImmaoLQX; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ImmaoLQX"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fHgMc3B1QzkXS;
	Fri, 20 Feb 2026 20:30:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771615852;
	bh=K8db/GbFo4RE1UKWhSh9Bhf5essgRgocgRncHGhmWs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImmaoLQXx20CMySEYxxmGKY3P66kL9ejr9o191a6AF8ytpJWUNaocW9bYrQZzkYNd
	 HR4PM3TIpdnvZsiJR3VbmtYJa35jQi4ROJdmGTuUs8fnED5aNXT6QaOHdyeyZd2u+H
	 q8a7hNk5jRY6CgF8rH6ZiyrT/lmT9A2OvnyVtzfg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fHgMc0YwZznQY;
	Fri, 20 Feb 2026 20:30:52 +0100 (CET)
Date: Fri, 20 Feb 2026 20:30:47 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH] samples/landlock: Bump ABI version to 8
Message-ID: <20260220.aTiem5fah1da@digikod.net>
References: <20260220160627.53913-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220160627.53913-1-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

Thanks, applied!

On Fri, Feb 20, 2026 at 05:06:27PM +0100, Günther Noack wrote:
> The sample tool should print a warning if it is not running on a
> kernel that provides the newest Landlock ABI version.
> 
> Link: https://lore.kernel.org/all/20260218.ufao5Vaefa2u@digikod.net/
> Suggested-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  samples/landlock/sandboxer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index e7af02f98208..9f21088c0855 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -299,7 +299,7 @@ static bool check_ruleset_scope(const char *const env_var,
>  
>  /* clang-format on */
>  
> -#define LANDLOCK_ABI_LAST 7
> +#define LANDLOCK_ABI_LAST 8
>  
>  #define XSTR(s) #s
>  #define STR(s) XSTR(s)
> @@ -436,7 +436,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		/* Removes LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON for ABI < 7 */
>  		supported_restrict_flags &=
>  			~LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
> -
> +		__attribute__((fallthrough));
> +	case 7:
>  		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
>  		fprintf(stderr,
>  			"Hint: You should update the running kernel "
> -- 
> 2.52.0
> 
> 

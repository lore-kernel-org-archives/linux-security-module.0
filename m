Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025427587E
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154386; cv=none; b=YBCCN0hPb5uoDKVjOgtQ8FAl2dAqWHZg1P3AcUC7rh/jrAd7OlRvrYscR1mlqGdj4wlSwuJX7C5nf10XHiJ3r2Nkd2xHetHy/4jsCgEMlle0qrT+YOsf6133cDWRJgYEmLTaLLRsDkFB5Ms0FkZZr5eF8ho/m5VkkTuQ3lOck+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154386; c=relaxed/simple;
	bh=WD57hpt6FmAvM5GbDcOqDxI194HmwK6iQszoGMzWqdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrVG5EiPhzYgXqqk9FrYhL/wo3y4AhfIdntkU8i8SvXGb9uvuYhcvU7JAGi6QaTadlLLKjv6Cau3VKL1T6GTsqoNmXWTrK/GlQvEjZDHQAfAJvId9St50LqeL0azr+lf4DPXGC/YvvK0NGmgXZKC75Ged/bfY9iUCsqnnqNMaRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=c8SFqy/g; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="c8SFqy/g"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dXqb90gbwz4t5;
	Fri, 19 Dec 2025 15:26:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766154372;
	bh=kKDOjBrr9Cw/Nfg502ofWKfhj49H4kwZkez0YkXxB4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8SFqy/ggGWMbR8PUM4dd5/pwjtJKoVJpq7+9lB/LLvmUnUJwy8D+MJt/fxXfScpL
	 SPof9DxqaJu4I0ka467mTIgYPpOOlWdb1PY3ynfQ15CPgLXbBuW4y+5Xrke54L1790
	 Iy25HHLlq42Id2YagfvWj05gVRpWZ8O0mgtSvGZQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dXqb84GJZzW19;
	Fri, 19 Dec 2025 15:26:12 +0100 (CET)
Date: Fri, 19 Dec 2025 15:26:11 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: linux-security-module@vger.kernel.org
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Justin Suess <utilityemal77@gmail.com>
Subject: Re: [PATCH v1] landlock: Optimize stack usage when !CONFIG_AUDIT
Message-ID: <20251219.YaeXeeVai4Ke@digikod.net>
References: <20251219142302.744917-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219142302.744917-2-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Fri, Dec 19, 2025 at 03:22:59PM +0100, Mickaël Salaün wrote:
> Until now, each landlock_request struct were allocated on the stack, even
> if not really used, because is_access_to_paths_allowed() unconditionally
> modified the passed references.  Even if the changed landlock_request
> variables are not used, the compiler is not smart enough to detect this
> case.
> 
> To avoid this issue, explicitly disable the related code when
> CONFIG_AUDIT is not set, which enables elision of log_request_parent*
> and associated caller's stack variables thanks to dead code elimination.
> This makes it possible to reduce the stack frame by 192 bytes for the
> path_link and path_rename hooks, and by 96 bytes for most other
> filesystem hooks.
> 
> Here is a summary of scripts/checkstack.pl before and after this change
> when CONFIG_AUDIT is disabled:
> 
>   Function                       Old size   New size   Diff
>   ----------------------------------------------------------
>   current_check_refer_path       384        208        -176
>   current_check_access_path      192        112        -80
>   hook_file_open                 208        128        -80
>   is_access_to_paths_allowed     240        224        -16
> 
> Also, add extra pointer checks to be more future-proof.
> 

Reported-by: Tingmao Wang <m@maowtm.org>
Link: https://lore.kernel.org/r/eb86863b-53b0-460b-b223-84dd31d765b9@maowtm.org

> Fixes: 2fc80c69df82 ("landlock: Log file-related denials")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/fs.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index fe794875ad46..722f950307f6 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -939,7 +939,12 @@ static bool is_access_to_paths_allowed(
>  	}
>  	path_put(&walker_path);
>  
> -	if (!allowed_parent1) {
> +	/*
> +	 * Check CONFIG_AUDIT to enable elision of log_request_parent* and
> +	 * associated caller's stack variables thanks to dead code elimination.
> +	 */
> +#ifdef CONFIG_AUDIT
> +	if (!allowed_parent1 && log_request_parent1) {
>  		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS;
>  		log_request_parent1->audit.type = LSM_AUDIT_DATA_PATH;
>  		log_request_parent1->audit.u.path = *path;
> @@ -949,7 +954,7 @@ static bool is_access_to_paths_allowed(
>  			ARRAY_SIZE(*layer_masks_parent1);
>  	}
>  
> -	if (!allowed_parent2) {
> +	if (!allowed_parent2 && log_request_parent2) {
>  		log_request_parent2->type = LANDLOCK_REQUEST_FS_ACCESS;
>  		log_request_parent2->audit.type = LSM_AUDIT_DATA_PATH;
>  		log_request_parent2->audit.u.path = *path;
> @@ -958,6 +963,8 @@ static bool is_access_to_paths_allowed(
>  		log_request_parent2->layer_masks_size =
>  			ARRAY_SIZE(*layer_masks_parent2);
>  	}
> +#endif /* CONFIG_AUDIT */
> +
>  	return allowed_parent1 && allowed_parent2;
>  }
>  
> -- 
> 2.52.0
> 

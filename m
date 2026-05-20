Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976D37D10F
	for <linux-security-module@vger.kernel.org>; Wed, 20 May 2026 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268773; cv=none; b=sOewp2VpsNBaDETFDBR6nr+9g1i1iPVgxdSHAsx9dlgAaeOaoaq/1vUAqGk53voIKG5Zs4GLVVxiwHHouAzS4DhFwywdT8+mMzyCnIDYSxwNfESgT7fihr5fmmr/4/cWERSiCMS3CKJsPV6W+bkBApUtsYtYZR3RRBcMLYHXM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268773; c=relaxed/simple;
	bh=KDnkvBO3pqkcSMiHzit3N6kmot0JbYg79znGk4e40kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkZIYv71ufZ1OhI8v1kgXhgL9DrDtjxHO6iAeL7lA/I0geCWHdBmmBtXG8cVWUeCzZf7M/oDzS5IBw1bxPZDgiJ9WUjCW9XKvafrcHct4AC+wfVhcbEFfdmlohWzt6RU8B+uxK/gEri3G7HTRsssMowiu1+8Bjee8rwijceCLeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=i8ATjvbL; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="i8ATjvbL"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gL5NN6tT8z11Zn;
	Wed, 20 May 2026 11:10:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779268212;
	bh=PCeKLjcrce32Qz22MjpQRjJbp3qHEeppeOcimbU0dEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8ATjvbLW6hIobGEoqrmO1RzOygliTMn4AYOlGVrULwcY/a3ChNPbmUY8iHKqMBqF
	 60y1ANibMuBUwGawfJcg6Vu8n/3h9AHHRjH46gWSvqcyLXrkDB2ZexhH59EGXcIcrB
	 0sKC3/Inffgk6LtrG5jyWpnUiBsZtJjLd2H+tp24=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gL5NM2wQbz9dh;
	Wed, 20 May 2026 11:10:11 +0200 (CEST)
Date: Wed, 20 May 2026 11:10:07 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Arnd Bergmann <arnd@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Arnd Bergmann <arnd@arndb.de>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Tingmao Wang <m@maowtm.org>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] landlock: avoid memcpy static check warning
Message-ID: <20260520.iez2sheoc8Ae@digikod.net>
References: <20260519203012.1340274-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519203012.1340274-1-arnd@kernel.org>
X-Infomaniak-Routing: alpha

Thanks for the report.

On Tue, May 19, 2026 at 10:30:05PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The fortified string helpers trigger a -Wrestrict warning when
> gcc deducts that the size of the landlock_layer array can
> overflow as a result of the flex_array_size() calculation:
> 
> In file included from arch/x86/include/asm/string.h:6,
>                  from security/landlock/ruleset.c:16:
> security/landlock/ruleset.c: In function 'create_rule':
> arch/x86/include/asm/string_32.h:150:25: error: '__builtin_memcpy' accessing 4294967295 bytes at offsets 0 and 0 overlaps 6442450943 bytes at offset -2147483648 [-Werror=restrict]
>   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> security/landlock/ruleset.c:139:9: note: in expansion of macro 'memcpy'
>   139 |         memcpy(new_rule->layers, layers,
>       |         ^~~~~~
>   'create_rule': event 1
> include/linux/compiler.h:69:46:
>    68 |         (cond) ?                                        \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    69 |                 (__if_trace.miss_hit[1]++,1) :          \
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
>       |                                              |
>       |                                              (1) when the condition is evaluated to true
>    70 |                 (__if_trace.miss_hit[0]++,0);           \
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/compiler.h:57:69: note: in expansion of macro '__trace_if_value'
>    57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>       |                                                                     ^~~~~~~~~~~~~~~~
> include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
>    55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>       |                            ^~~~~~~~~~~~~~
> include/linux/overflow.h:334:9: note: in expansion of macro 'if'
>   334 |         if (check_mul_overflow(factor1, factor2, &bytes))
>       |         ^~
>   'create_rule': event 2
> 
> Out of these individually helpful checks (-Wrestrict, fortified
> string helpers, flex_array_size), one of them has to go to avoid
> the warning.
> 
> Seeing that the length of the array is already checked earlier
> in this function, through both an explicit LANDLOCK_MAX_NUM_LAYERS
> comparison and the implicit kzalloc_flex() having succeeded,
> replace the flex_array_size() call with a direct multiplication.

Can flex_array_size() be fixed instead?

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  security/landlock/ruleset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 181df7736bb9..26e0b7193a7b 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -137,7 +137,7 @@ create_rule(const struct landlock_id id,
>  	new_rule->num_layers = new_num_layers;
>  	/* Copies the original layer stack. */
>  	memcpy(new_rule->layers, layers,
> -	       flex_array_size(new_rule, layers, num_layers));
> +	       sizeof(struct landlock_layer) * num_layers);
>  	if (new_layer)
>  		/* Adds a copy of @new_layer on the layer stack. */
>  		new_rule->layers[new_rule->num_layers - 1] = *new_layer;
> -- 
> 2.39.5
> 
> 

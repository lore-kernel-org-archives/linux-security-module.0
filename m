Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F6B20FAA4
	for <linux-security-module@vger.kernel.org>; Thu,  5 Jun 2025 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749117512; cv=none; b=PF9eKGxXOazqX9caH0bT1CeS8XPwmclthZz1ZA4NAjVUb+4O2hLh4YdPV1PlbU9mBgFg272WrotahAEwQ1EjrWmCUbyF1JogoqtThkKbsUBHg2mFF2lKNtMETvG6UJNt+nkfH3h6Ubu1LNTbdhSREc6Ed8n5aeSOj1Ay1sablBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749117512; c=relaxed/simple;
	bh=f3/ls/OWcxL5t4jplgeZ5bA5j5q0Y7QNkYy3mBs/1UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQT19sIHfjsxrDSyWTPqZUgGBZILt6NzdRuPwRTPkK82nAOdVxHICaqahw+rGpmWqJA/S7S7MGnKH6dnzmSloaM8Q32DWTdnTWJWQRN0itynIPx6f4j1CTIt14SKsXY4sW4Bb34+ybu2sWQuIjWU67WdejjR+t9PEed70xdtxx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C66EA5C0AC;
	Thu,  5 Jun 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5677B1373E;
	Thu,  5 Jun 2025 09:58:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7co1EERqQWjUZAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 05 Jun 2025 09:58:28 +0000
Date: Thu, 5 Jun 2025 11:58:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Cc: ltp@lists.linux.it, linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [LTP] [PATCH v2] lsm: fix overset attr test
Message-ID: <20250605095826.GB1206250@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250605-lsm_fix_attr_is_overset-v2-1-dd10ddb04238@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-lsm_fix_attr_is_overset-v2-1-dd10ddb04238@suse.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: C66EA5C0AC
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.00

Hi Andrea,

> LSM(s) usually handle their own internal errors in a different way,
> so the right way to check if they return error, is to verify that the
> common return value is -1. This is the max we can do, since errno might
> vary according to the LSM implementation.

> At the same time, overset attr test is _not_ checking if attr is
> overset, but rather checking if attr is out-of-bounds, considering OR
> operator as a valid way to generate an invalid value with
> LSM_ATTR_CURRENT. This is not correct, since any OR operation using
> LSM_ATTR_CURRENT will generate a valid value for the LSM(s) code. So we
> remove this test that doesn't make much sense at the moment and replace
> it with an "invalid attr test" instead.

Thanks for the fix, LGTM.

Fixes: ad4ab6ce4f ("Add lsm_set_self_attr01 test")
Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> This patch will fix all false positive errors, where LSM(s) might
> be implemented in a different way. We just skip errno check.

> This will also fix:
> https://openqa.opensuse.org/tests/5087893#step/lsm_set_self_attr01/8
> ---
> Changes in v2:
> - remove exp_errno from struct
> - change attr overset test
> - Link to v1: https://lore.kernel.org/r/20250604-lsm_fix_attr_is_overset-v1-1-46ff86423a14@suse.com
> ---
>  testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

> diff --git a/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
> index caccdda7ecf2edaac1fa8e2dc2ccdd0aff020804..cde9c2e706ed607024dff362b7ff00cbcef1d6a5 100644
> --- a/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
> +++ b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
> @@ -23,28 +23,24 @@ static struct tcase {
>  	struct lsm_ctx **ctx;
>  	uint32_t *size;
>  	uint32_t flags;
> -	int exp_errno;
>  	char *msg;
>  } tcases[] = {
>  	{
>  		.attr = LSM_ATTR_CURRENT,
>  		.ctx = &ctx_null,
>  		.size = &ctx_size,
> -		.exp_errno = EFAULT,
>  		.msg = "ctx is NULL",
>  	},
>  	{
>  		.attr = LSM_ATTR_CURRENT,
>  		.ctx = &ctx,
>  		.size = &ctx_size_small,
> -		.exp_errno = EINVAL,
>  		.msg = "size is too small",
>  	},
>  	{
>  		.attr = LSM_ATTR_CURRENT,
>  		.ctx = &ctx,
>  		.size = &ctx_size_big,
> -		.exp_errno = E2BIG,
>  		.msg = "size is too big",
>  	},
>  	{
> @@ -52,15 +48,13 @@ static struct tcase {
>  		.ctx = &ctx,
>  		.size = &ctx_size,
>  		.flags = 1,
> -		.exp_errno = EINVAL,
>  		.msg = "flags must be zero",
>  	},
>  	{
> -		.attr = LSM_ATTR_CURRENT | LSM_ATTR_EXEC,
> +		.attr = -1000,
>  		.ctx = &ctx,
>  		.size = &ctx_size,
> -		.exp_errno = EINVAL,
> -		.msg = "attr is overset",
> +		.msg = "attr is invalid",
>  	}
>  };

> @@ -77,9 +71,9 @@ static void run(unsigned int n)
>  	ctx_size_small = 1;
>  	ctx_size_big = ctx_size + 1;

> -	TST_EXP_FAIL(lsm_set_self_attr(tc->attr, *tc->ctx, *tc->size, tc->flags),
> -	      tc->exp_errno,
> -	      "%s", tc->msg);
> +	TST_EXP_EXPR(lsm_set_self_attr(
> +		tc->attr, *tc->ctx, *tc->size, tc->flags) == -1,
> +		"%s", tc->msg);
>  }

Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1EB1B3930
	for <linux-security-module@vger.kernel.org>; Thu,  5 Jun 2025 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111199; cv=none; b=mpkErmQOEoOsaV7ELD0RLPl+DV1D3lZOCuCbKBUwxJfYN+gr8sxQwboXn/APxvZAeTF0DbEcQzabCkkMBYouhHLxJCzHAuy9sp5cVGxpXl6ww1UK8KH59+WPUctfkwcv56cttx2yO+pfes1rjhoTHMZ9G5AZhs+s99BdAy80Iu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111199; c=relaxed/simple;
	bh=5QYnw3jI+c++65ZsMkmb5FnhZ8wb8W6qzgN2Q8ITr1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsLZQXPfiABs/hnN1CYiWPBqOy0jo8u1T4XdLkULGVpFacXr48ZzG8aNLSKDGX91N3kelI3w/hNJNfqzPT31gHbP5gdaJOS3sZI1VMwr/oPy0x3wIch7KT0Md88OoTTiD61jJqNbCCvf2jhcTsgirAFXoXz4NtCr0x0JDUfF/Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HADvRxmn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eq3K7Fo8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HADvRxmn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eq3K7Fo8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HADvRxmn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eq3K7Fo8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HADvRxmn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eq3K7Fo8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B72420881;
	Thu,  5 Jun 2025 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749111196;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RYO4b/CeI1hoUhImmO/HMeMpnMI8r8Dtfwkw2xvlYo=;
	b=HADvRxmnxBAr6zDxG1K1sChJqLID/UAnKE63bFCJP9hLajTLlLtuiT0SUNfwqdtT0om6V6
	ZmVMlUdvmhxQmOupPBSywUxxlQgk4Wj+4Ho3XV/g+oKfJsR6jGfZtkg/89rrZ3Db3ZTIZK
	RqaUQr+gIClLRPONm8SZiZI357bMoLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749111196;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RYO4b/CeI1hoUhImmO/HMeMpnMI8r8Dtfwkw2xvlYo=;
	b=eq3K7Fo8eD8fGmCgeO0HnrMkXVBsXCZZ+YyLDvkPzOrub1u3uZ3uPGxae0sFKkJHMAyptA
	G0KTnt2X/hd0T0CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749111196;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RYO4b/CeI1hoUhImmO/HMeMpnMI8r8Dtfwkw2xvlYo=;
	b=HADvRxmnxBAr6zDxG1K1sChJqLID/UAnKE63bFCJP9hLajTLlLtuiT0SUNfwqdtT0om6V6
	ZmVMlUdvmhxQmOupPBSywUxxlQgk4Wj+4Ho3XV/g+oKfJsR6jGfZtkg/89rrZ3Db3ZTIZK
	RqaUQr+gIClLRPONm8SZiZI357bMoLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749111196;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RYO4b/CeI1hoUhImmO/HMeMpnMI8r8Dtfwkw2xvlYo=;
	b=eq3K7Fo8eD8fGmCgeO0HnrMkXVBsXCZZ+YyLDvkPzOrub1u3uZ3uPGxae0sFKkJHMAyptA
	G0KTnt2X/hd0T0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A57A137FE;
	Thu,  5 Jun 2025 08:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sc5WBJtRQWhaPgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 05 Jun 2025 08:13:15 +0000
Date: Thu, 5 Jun 2025 10:13:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Cc: ltp@lists.linux.it, Avinesh Kumar <akumar@suse.de>,
	=?iso-8859-2?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-2?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [LTP] [PATCH v4 7/7] Add lsm_set_self_attr01 test
Message-ID: <20250605081309.GD1190804@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
 <20250429-lsm-v4-7-602b7097e722@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429-lsm-v4-7-602b7097e722@suse.com>
X-Spam-Flag: NO
X-Spam-Score: -3.48
X-Spamd-Result: default: False [-3.48 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.18)[-0.900];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Level: 

Hi Andrea, all,

> Verify that lsm_set_self_attr syscall is raising errors when invalid
> data is provided.

...
> diff --git a/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..caccdda7ecf2edaac1fa8e2dc2ccdd0aff020804
> --- /dev/null
> +++ b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Verify that lsm_set_self_attr syscall is raising errors when invalid data is
> + * provided.
> + */
> +
> +#include "lsm_common.h"
> +
> +static struct lsm_ctx *ctx;
> +static struct lsm_ctx *ctx_orig;
> +static struct lsm_ctx *ctx_null;
> +static uint32_t ctx_size;
> +static uint32_t ctx_size_small;
> +static uint32_t ctx_size_big;
> +static uint32_t page_size;
> +
> +static struct tcase {
> +	uint32_t attr;
> +	struct lsm_ctx **ctx;
> +	uint32_t *size;
> +	uint32_t flags;
> +	int exp_errno;
> +	char *msg;
> +} tcases[] = {
> +	{
> +		.attr = LSM_ATTR_CURRENT,
> +		.ctx = &ctx_null,
> +		.size = &ctx_size,
> +		.exp_errno = EFAULT,
> +		.msg = "ctx is NULL",
> +	},
> +	{
> +		.attr = LSM_ATTR_CURRENT,
> +		.ctx = &ctx,
> +		.size = &ctx_size_small,
> +		.exp_errno = EINVAL,
> +		.msg = "size is too small",
> +	},
> +	{
> +		.attr = LSM_ATTR_CURRENT,
> +		.ctx = &ctx,
> +		.size = &ctx_size_big,
> +		.exp_errno = E2BIG,
> +		.msg = "size is too big",
> +	},
> +	{
> +		.attr = LSM_ATTR_CURRENT,
> +		.ctx = &ctx,
> +		.size = &ctx_size,
> +		.flags = 1,
> +		.exp_errno = EINVAL,
> +		.msg = "flags must be zero",
> +	},
> +	{
> +		.attr = LSM_ATTR_CURRENT | LSM_ATTR_EXEC,
> +		.ctx = &ctx,
> +		.size = &ctx_size,
> +		.exp_errno = EINVAL,
> +		.msg = "attr is overset",

FYI The test fails on this check on current Tumbleweed with new
6.15.0-1-default. It worked on 6.14.

Looking at 6.15 landlock related changes (added Landlock audit support and
Landlock signal scope fixes) test might needs to be updated.
https://kernelnewbies.org/Linux_6.15#Security

@Andrea could you please have a look?

Kind regards,
Petr

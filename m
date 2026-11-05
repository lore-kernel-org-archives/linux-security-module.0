Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900684;
	b=0NdJPcIPeu3I3NHgeyhtIwtOdTY4AUFv2nkiKjeadR6DI5yeJpvqxGPpeMk5x2hHdU/d
	 ockhjhP2+ii3O/06GgIPWgdhgqkECR3tboyGbcmsosCCyrmtJ8POLoRzVrmaXU4vTHFmw
	 I/dhCxNx0GcNGG7HQ771GKbZlQh7jdBh+mr2SWkWG5bjYgjm+4qKi6ijVWyPGT0TDrk+L
	 I+ZP70Vjusk47LwwUbATw7uMm8FaLV3X7YRiN4/TiWphsaXCUxILzZ/ko8I+Lm6uGlxjk
	 iHQYcQ5R1Dsi9SZgIXQMag6/sFQhckEQLYQ5DS01Hxsuq7EP8YVDNPt9Mg152wqgIMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900684;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=LarAaXMV0AMCDWN64cT05AvWg34TX9zprYaeWP45D7c=;
	b=G8tkxcjzyrla0KDukGIyXgQgAb9k1esTiY5qS9O2+2x+ltsFZDk5uWYmhSuT9wAJCoz2
	 pDU+/cbkgrXGom2w6+/0HyGdiC+WumXx0Jqt+RablhV71RTXTQc31Bp1N6/DFn5ADOyeb
	 1yV1NJqKQNqxtALc1TvhOgOJ5EMv24Lb8kW4ztYj88YGKaQn+iBMZrKEr538VuYeXfcon
	 zPG2sKseYJ6hmLnYupG6hCBhR9A3sZdIG8u5VKkUQAKXgL9gcneToFqqUu+Ujkr2UaJT6
	 802RAhAx+1tFHEwyMjhBbWRbLCiuN4oue6jutHAwYpbQMB29itwtleoitm3b1IvdzXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=AKT6FZwI;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=A5Girvdv;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=dwA6YLaL;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zqLxfa77;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CDC606D807
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 17:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57CDC606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=AKT6FZwI;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=A5Girvdv;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=dwA6YLaL;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zqLxfa77
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B350421E3D;
	Thu,  5 Nov 2026 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793900682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LarAaXMV0AMCDWN64cT05AvWg34TX9zprYaeWP45D7c=;
	b=AKT6FZwIiYHLg6up0prUJ6MxT6z/Bh3mauGFI/umuYWd+iin8Q50WBZc3r8ou9sMw3/qWA
	5QWKI4b2BSEEaxqKv+L03Xh55scHK2rR9AQRMCelMe4vpEbIPZRgdg5scJ0COTFRJ1d3N8
	rl8bHUlxdrnmkccBjYoZrK9yCjOsMaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793900682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LarAaXMV0AMCDWN64cT05AvWg34TX9zprYaeWP45D7c=;
	b=A5GirvdvGPlX/yArwo6yPAcWkaS4J4Q0Sd/lvDcazrSi7YYU0zXnUhavn47e74cm260mGt
	/M0npi58TiR7haAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793900681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LarAaXMV0AMCDWN64cT05AvWg34TX9zprYaeWP45D7c=;
	b=dwA6YLaLUOvdJf7rZaEnrIbSo0SIi5vru8caQ6d2noF6fv6bXM83d9+6cAItsd92Or9cbv
	3Xue2GC22o3A7iz0FVPyHw1++pQVjQvXIztd10MvTyl2e6JUTZDHsPKWToA8hKdXRHFeBn
	6EWwN7FOyrVpad9kKT6E/jXBNBmGYvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793900681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LarAaXMV0AMCDWN64cT05AvWg34TX9zprYaeWP45D7c=;
	b=zqLxfa77ZeNDtAuoZdht5KmA+5HhADpv5eO8Ym845DIiqUd5qMF7+h6EG0664H/p43X+Tf
	lgIApx9VyeQStWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53714134F4;
	Thu,  5 Nov 2026 17:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uvqxCYnA7GrLcgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 05 Nov 2026 17:44:41 +0000
Date: Thu, 5 Nov 2026 18:44:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Cc: Linux Test Project <ltp@lists.linux.it>,
	linux-security-module@vger.kernel.org
Subject: Re: [LTP] [PATCH v3 2/2] syscalls/cma: Handle Yama ptrace_scope in
 tests
Message-ID: <20261105174439.GA520216@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20261020-fix_process_vm_writev_permissions-v3-0-1e92d7a29aef@suse.com>
 <20261020-fix_process_vm_writev_permissions-v3-2-1e92d7a29aef@suse.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-fix_process_vm_writev_permissions-v3-2-1e92d7a29aef@suse.com>
X-Spamd-Result: default: False [-12.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Level: 
X-Spam-Flag: NO

Hi Andrea,

[ Cc Yama list ]

thanks merged.

Kind regards,
Petr

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> With Yama LSM enabled, process_vm_readv() and process_vm_writev() fail
> with EPERM when a sibling process accesses the target's memory.

> Let the target child declare its parent as ptracer, so that mode 1
> works for unprivileged users too. Require CAP_SYS_PTRACE for mode 2
> and skip on mode 3, where access is never allowed.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/cma/cma.h                | 38 ++++++++++++++++++++++
>  testcases/kernel/syscalls/cma/process_vm_readv02.c |  5 +++
>  testcases/kernel/syscalls/cma/process_vm_readv03.c |  5 +++
>  .../kernel/syscalls/cma/process_vm_writev02.c      |  5 +++
>  4 files changed, 53 insertions(+)

> diff --git a/testcases/kernel/syscalls/cma/cma.h b/testcases/kernel/syscalls/cma/cma.h
> new file mode 100644
> index 000000000..6636cb5a3
> --- /dev/null
> +++ b/testcases/kernel/syscalls/cma/cma.h
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef CMA_H__
> +#define CMA_H__
> +
> +#include <sys/prctl.h>
> +#include "tst_test.h"
> +#include "tst_capability.h"
> +
> +#define PTRACE_SCOPE "/proc/sys/kernel/yama/ptrace_scope"
> +
> +static inline void cma_check_ptrace_scope(void)
> +{
> +	struct tst_cap cap = TST_CAP(TST_CAP_REQ, CAP_SYS_PTRACE);
> +	int scope;
> +
> +	if (access(PTRACE_SCOPE, F_OK))
> +		return;
> +
> +	SAFE_FILE_SCANF(PTRACE_SCOPE, "%d", &scope);
> +
> +	if (scope >= 3)
> +		tst_brk(TCONF, "Yama ptrace_scope=%d forbids process_vm_*()", scope);
> +
> +	if (scope == 2)
> +		tst_cap_action(&cap);
> +}
> +
> +static inline void cma_allow_parent_ptracer(void)
> +{
> +	if (prctl(PR_SET_PTRACER, getppid(), 0, 0, 0) && errno != EINVAL)
> +		tst_brk(TBROK | TERRNO, "prctl(PR_SET_PTRACER)");
> +}
> +
> +#endif /* CMA_H__ */
> diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
> index 1e2ac38fa..ceff77e29 100644
> --- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
> +++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
> @@ -17,6 +17,7 @@
>  #include <sys/wait.h>
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
> +#include "cma.h"

>  static uintptr_t *data_ptr;

> @@ -29,6 +30,8 @@ static void child_alloc(const char *data)

>  	tst_res(TINFO, "child 0: memory allocated and initialized");

> +	cma_allow_parent_ptracer();
> +
>  	/* wake and wait until child_invoke is done reading from our VM */
>  	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  }
> @@ -64,6 +67,8 @@ static void setup(void)
>  	/* Just a sanity check of the existence of syscall */
>  	tst_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);

> +	cma_check_ptrace_scope();
> +
>  	data_ptr = SAFE_MMAP(NULL, sizeof(uintptr_t), PROT_READ | PROT_WRITE,
>  						 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>  }
> diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
> index 95d35c422..831f79c89 100644
> --- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
> +++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
> @@ -20,6 +20,7 @@
>  #include <sys/wait.h>
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
> +#include "cma.h"

>  #define MAX_IOVECS 1024

> @@ -80,6 +81,8 @@ static void child_alloc(const int *sizes, int nr_iovecs)

>  	tst_res(TINFO, "child_alloc: memory allocated and initialized");

> +	cma_allow_parent_ptracer();
> +
>  	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  }

> @@ -139,6 +142,8 @@ static void setup(void)
>  {
>  	tst_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);

> +	cma_check_ptrace_scope();
> +
>  	data_ptr = SAFE_MMAP(NULL, sizeof(void *) * MAX_IOVECS, PROT_READ | PROT_WRITE,
>  			     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>  }
> diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
> index 15bd66a44..78b98200f 100644
> --- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
> +++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
> @@ -16,6 +16,7 @@
>  #include <sys/uio.h>
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
> +#include "cma.h"

>  static uintptr_t *data_ptr;
>  static char *str_buffsize;
> @@ -33,6 +34,8 @@ static void child_alloc_and_verify(int buffsize)
>  	memset(foo, 'a', buffsize);
>  	*data_ptr = (uintptr_t)foo;

> +	cma_allow_parent_ptracer();
> +
>  	TST_CHECKPOINT_WAKE_AND_WAIT(0);

>  	err = 0;
> @@ -81,6 +84,8 @@ static void setup(void)
>  	if (tst_parse_int(str_buffsize, &bufsize, 1, INT_MAX))
>  		tst_brk(TBROK, "Invalid buffer size '%s'", str_buffsize);

> +	cma_check_ptrace_scope();
> +
>  	data_ptr = SAFE_MMAP(NULL, sizeof(uintptr_t), PROT_READ | PROT_WRITE,
>  			     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>  }

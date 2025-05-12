Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11B266569
	for <linux-security-module@vger.kernel.org>; Mon, 12 May 2025 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042317; cv=none; b=cNffM5vKlje929rJvtCfDgaP487tBW3MgDqZSQXbBse3uBUoZnKBFtYikCzvilkO8cHVFjiq0LswmdzI6BNz9EF2GSJh5tvuzbhiM7icrTZCXzLDJNGh8xJhkvC7AD4BGjMRh/F3wUZbuoEuaj9aYxKh7uR5ep8kFW/ur/MgiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042317; c=relaxed/simple;
	bh=YpAeR6TYQnE+JuRQsCY8N7QKQbBIvLuNh8RAHjhRUBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCvp6mX5NOaj4u1TA3b/TPNi0FNOd5QkQr8ZNg1h/CGOPtnMTgVDS5HTWzd0nq1pahYKgE2nGqrqXz7/rdyfMvQWHst2SmpzV/u1TS23cL9L2m+d8UC1v4fodnq6S6o78cdqEco4EkTeyC3RvxRbNwHVcBdnIVAgXVxAUJVFVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=epyqwOx5; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="epyqwOx5"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZwvWL5Tz4zsKX;
	Mon, 12 May 2025 11:31:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1747042302;
	bh=VFtt2EeKOwvGLlqMCzO00svgSGsIwImhwzbFIv50OJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epyqwOx57k6r423EmIgtnTX88ZUTz7CV50+yVSqbXYryw7Zp9v81IzHgdMHmt7Z1O
	 qQH2VbMt71DT0YFE1LEDdeXlfD1XCZQB2aYYV8tJyXzZGAtQ9UkkYi88MwyO7MrLaF
	 HhJ0qw+LfQPHyY+wegwzIr+IxkU9+vmm7jQr6Mq4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZwvWL1nLbzdTy;
	Mon, 12 May 2025 11:31:42 +0200 (CEST)
Date: Mon, 12 May 2025 11:31:39 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1] landlock: Use bitops macros in audit code
Message-ID: <20250512.uth9faiR8kie@digikod.net>
References: <20250507185404.1029055-1-mic@digikod.net>
 <20250508.f94265b49f51@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508.f94265b49f51@gnoack.org>
X-Infomaniak-Routing: alpha

On Thu, May 08, 2025 at 08:30:46AM +0200, Günther Noack wrote:
> On Wed, May 07, 2025 at 08:54:02PM +0200, Mickaël Salaün wrote:
> > Use the BIT() and BIT_ULL() macros in the new audit code instead of
> > explicit shifts to improve readability.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/landlock/audit.c    | 2 +-
> >  security/landlock/id.c       | 5 +++--
> >  security/landlock/syscalls.c | 3 ++-
> >  3 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> > index 58d5c40d4d0e..c52d079cdb77 100644
> > --- a/security/landlock/audit.c
> > +++ b/security/landlock/audit.c
> > @@ -437,7 +437,7 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
> >  		return;
> >  
> >  	/* Checks if the current exec was restricting itself. */
> > -	if (subject->domain_exec & (1 << youngest_layer)) {
> > +	if (subject->domain_exec & BIT(youngest_layer)) {
> >  		/* Ignores denials for the same execution. */
> >  		if (!youngest_denied->log_same_exec)
> >  			return;
> > diff --git a/security/landlock/id.c b/security/landlock/id.c
> > index 11fab9259c15..552272307697 100644
> > --- a/security/landlock/id.c
> > +++ b/security/landlock/id.c
> > @@ -7,6 +7,7 @@
> >  
> >  #include <kunit/test.h>
> >  #include <linux/atomic.h>
> > +#include <linux/bitops.h>
> >  #include <linux/random.h>
> >  #include <linux/spinlock.h>
> >  
> > @@ -25,7 +26,7 @@ static void __init init_id(atomic64_t *const counter, const u32 random_32bits)
> >  	 * Ensures sure 64-bit values are always used by user space (or may
> >  	 * fail with -EOVERFLOW), and makes this testable.
> >  	 */
> > -	init = 1ULL << 32;
> > +	init = BIT_ULL(32);
> >  
> >  	/*
> >  	 * Makes a large (2^32) boot-time value to limit ID collision in logs
> > @@ -105,7 +106,7 @@ static u64 get_id_range(size_t number_of_ids, atomic64_t *const counter,
> >  	 * to get a new ID (e.g. a full landlock_restrict_self() call), and the
> >  	 * cost of draining all available IDs during the system's uptime.
> >  	 */
> > -	random_4bits = random_4bits % (1 << 4);
> > +	random_4bits = random_4bits % BIT(4);
> 
> Optional nit: Might be slightly simpler when written as a bitwise AND:
> 
>   random_4bits = random_4bits & 0b1111;
> 
> (Probably does not make a difference in the compiled code though?)

Yes, it results to the same assembly code.

> 
> And, to also simplify the statement:
> 
>   random_4bits &= 0b1111;

I'll send a v2 with that.

Thanks

> 
> (If you prefer to stick with the modulo, "%=" exists as well, even
> though it's more obscure.)
> 
> >  	step = number_of_ids + random_4bits;
> >  
> >  	/* It is safe to cast a signed atomic to an unsigned value. */
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index b9561e3417ae..33eafb71e4f3 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -9,6 +9,7 @@
> >  
> >  #include <asm/current.h>
> >  #include <linux/anon_inodes.h>
> > +#include <linux/bitops.h>
> >  #include <linux/build_bug.h>
> >  #include <linux/capability.h>
> >  #include <linux/cleanup.h>
> > @@ -563,7 +564,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
> >  	new_llcred->domain = new_dom;
> >  
> >  #ifdef CONFIG_AUDIT
> > -	new_llcred->domain_exec |= 1 << (new_dom->num_layers - 1);
> > +	new_llcred->domain_exec |= BIT(new_dom->num_layers - 1);
> >  #endif /* CONFIG_AUDIT */
> >  
> >  	return commit_creds(new_cred);
> > -- 
> > 2.49.0
> > 
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> 

Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671DA3FD133;
	Tue, 26 May 2026 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806274; cv=none; b=I5JJhXddHCGJC1emLDzeceBw2NulpvSRG/IokaxgRT5MsrEMpHI4WAr5xrVw1XuxN6ggN+5iamybg0q/U6WP1EOsUzLsXE6vUaKjKiaTlgWF30j7BNFuIUXBusU4GKsAHYpNYMYExMaGCVuU9MVQ9bOsQlp8M8l4cw5Y7E4c0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806274; c=relaxed/simple;
	bh=iBl6xfasCJ/QiS/65LZ03kywe8aoBbVau/vatpwODjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njgSl5ivRT/8VC9OZuLYSAq2/ZFHZQYMPFQSWC+Fiuo1WAqNMjg0XuD4PdvSd7lAJh3vYVVpGT7gvJKPsY15BmSFHNt31U8E5DD/dSY+hu2C31P4m6RTe8ySG2mheUfj+GkU1g+AaD2Fg0nGtTM5vRHyaeKokVI1CmflN+XD1vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64QEbTFO046008;
	Tue, 26 May 2026 23:37:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64QEbTOL046004
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 May 2026 23:37:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <973e7bd1-6919-46ad-aa3b-f4e02737462e@I-love.SAKURA.ne.jp>
Date: Tue, 26 May 2026 23:37:25 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tomoyo: Fix NULL pointer dereference in
 tomoyo_init_request_info() when domain is NULL
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Cc: jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        serge@hallyn.com, takedakn@nttdata.co.jp
References: <814a7f61-67b2-49e9-b5bf-fd049b458079@I-love.SAKURA.ne.jp>
 <20260526135859.3211799-1-xujiakai24@mails.ucas.ac.cn>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260526135859.3211799-1-xujiakai24@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav302.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/05/26 22:58, Jiakai Xu wrote:
>> Thank you for a patch, but I don't think we need this change.
> 
> Thanks for your review! I understand your perspective, but I believe
> the crash is a real NULL pointer dereference, and I'd like to explain
> why the defensive check is warranted.
> 
>> TOMOYO's initial domain is &tomoyo_kernel_domain, and each thread belongs to
>> a non-NULL domain. Therefore, tomoyo_domain() is not supposed to return NULL.
> 
> While tomoyo_domain() is not supposed to return NULL under normal
> operation, there are code paths that leave s->domain_info == NULL:
> 
>   a) Pre-init window (security/tomoyo/tomoyo.c, lines 598-612):
>      The task security blob is zero-allocated via kzalloc(), and
>      security_add_hooks() at line 603 is called BEFORE
>      s->domain_info = &tomoyo_kernel_domain at line 606. If any LSM
>      hook fires during that window, tomoyo_domain() returns NULL.

This code is executed during early boot stage. Other LSM hooks are not
supposed to fire.

> 
>   b) tomoyo_task_free() (tomoyo.c, lines 533-545) explicitly sets
>      s->domain_info = NULL after decrementing the refcount.

This code is executed when a "struct task_struct" is about to be released.
Nobody can find this "struct task_struct". Also, this "struct task_struct"
cannot be the current thread.

> 
>   c) tomoyo_find_next_domain() (domain.c, lines 876-883) writes
>      s->domain_info = NULL when the domain transition fails.

I couldn't catch, but old_domain is initialized as

  struct tomoyo_domain_info *old_domain = tomoyo_domain();

which cannot be NULL.

domain is guaranteed to be non-NULL because old_domain cannot be NULL.

	if (!domain)
		domain = old_domain;

Therefore, s->domain_info is guaranteed to be non-NULL because domain cannot be NULL.

	s->domain_info = domain;

If domain were NULL, the kernel should have already crashed at line 884.

> 
> I think adding a NULL check makes the code more robust. What do you 
> think?

Then, this will be NULL pointer dereference.
But fixing the location that is setting NULL is the correct approach.


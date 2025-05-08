Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA11D8A0A
	for <linux-security-module@vger.kernel.org>; Thu,  8 May 2025 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685879; cv=none; b=C0ReAbywdefWBONR+oS5pf2/aUHbtkZ1oAr8r7MoF9sM3NMYaMg7B/jiVuUwTMfH9r0jR95U5H+1WxS6MqiwO8quFVmkumd6al4mH6oAfs9PBdfjmVx4gMbTFSvCCLU8TEPHwbeuxTekcXC7nrsXJBA+FvGVWuAfLKn0WzdA1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685879; c=relaxed/simple;
	bh=NV4jSgnPvWC+bMGF1TfDFhdljWo//hfiPk+HVBZIf9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbGwN8URAp4lHuVXHZbglNpVGPDkM4dFZAkuA50dZOSn1iY9ySS1R+KyDCzmEnT8uboN46pmu6jXhjhuQYJCKv95Y3tGaGOT5Qsa/jL3+vyeNUDL6g92lIjLM7OOOm8fNNch+2Bye+11FvZ0Cpzk1QfbHFEW95RcQMQKW4VucYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwK3An8o; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwK3An8o"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441ab63a415so6194355e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 07 May 2025 23:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746685876; x=1747290676; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SZJh7zioLIZhv1vC1txVlc+NSwqFoQlHFMPmnEd1kIE=;
        b=JwK3An8oq/LsfpXjhqmPm7K3oVztOsae/xFf3rQvBH4WRdHXsg1OViD5UtLZ6i03pw
         7F7cWG1OLNtBduZXqW5PAxp+Zo3tHx629rztB4YoWykhK2Ac+3Zr8NK+doxJhAQgP4Ho
         DSaNBXZxVyBz5iKr5un/FfFODwp46HrY44QksG5G1+29I/R0EcYTWZN6mSNwBJTd3iwJ
         ZL+gv1p1gYpYY/uqB03SLKy1fDUI01+sI8Oi93fhZjZevHZXPqKcUUJ6PIY1F+RFyNS5
         DxPiM4EuJbwj6V+gJyn//yluwsoHrJrrv+eqRfOMd1vimMHJUlipDx29ihsD0lbnIXI0
         +5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746685876; x=1747290676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZJh7zioLIZhv1vC1txVlc+NSwqFoQlHFMPmnEd1kIE=;
        b=d+K9terVAYBjmWQOTOJp69TYCYnTsLcaOqQiX7B791yXXBZfFLavuT5fR/LuFiIb5h
         +umwO4J6pbHvXAkKtqCoUYfoq9gYftMt4HDl1S1b1b0co3/UPXHHiLjr+yRiwlrgqcym
         vKCzRuL9bxDo/NnaIPMf32HBnY55QomNW0l9m23c4hGSKRtGcdooYMsd2bUvNPRqV9RK
         wB+KAt84uekGzsr7i0UWkjn3gqHjO4tDbQRjniYV3Icpue6THNHefUavQecCEpqTRZne
         gswgcUxJ11zD6Zux0hWlt/TCHD5Wj1UR4QSZFeSk7vwWLFygDUjEbBTeLMPGBfd72lix
         rpMw==
X-Forwarded-Encrypted: i=1; AJvYcCV3F29COSSye3LY4sCGejD327Bt24TenfpzRmIPt7XtH3d3fJCi374gn7yClcUOtuac2Cs93bmG9e+VMDmgyf/5vg0Qe3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVwwuqZdFNHI1zKaxhvs7gYc87F6rH9/qVJajsaFQmQD57rIX
	Wr9AMWA1Nwf6vyGQ+Gm9Ik9KYkW15oPYRXXEE3Gypn1wiS6C6QxD
X-Gm-Gg: ASbGncsjY1YORGUWA5GwyF8nrq/pb3CgIhgDLnKG4Ve3Bw6MpMSDzcHrWUQIbN5j65A
	JTOdt0vctxNW5QmHYeRtbRQF6Z4LjEXvlROY2KRZpkS5bIS+xuOpDvg0jaLSzzeV+P3VF9csfrT
	XrHt344tluli6TbGMASZMMZlCxMvZKAuukP2nrK/s0QDOofYwvLYiN+0UqRz3U2Zw92HnciIAZs
	GaR5aA766+8yZ/mscKb+jOQOyvsnn2Yrv4NZ6JI7EXtSQUV4/YGTe1qcKvj4Qi9dQY7P6aynqv0
	dwlc9DWkXHZB/882EHXIA5YZ1Ba9MwbTdEhkQQG3ETNI8UBNfIni8WFXvr46lSgv/8E=
X-Google-Smtp-Source: AGHT+IFaqldeWdd8/uMi/lBw3iZiSAt/oXIxhwCA+vNXWgEpYzCu7TXFvd10ekHqAsBCsoXQbQSuFg==
X-Received: by 2002:a05:600c:83cf:b0:43d:49eb:9675 with SMTP id 5b1f17b1804b1-441d44dd0f4mr44977895e9.22.1746685875629;
        Wed, 07 May 2025 23:31:15 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442cd3aeca5sm25949905e9.26.2025.05.07.23.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 23:31:15 -0700 (PDT)
Date: Thu, 8 May 2025 08:30:46 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1] landlock: Use bitops macros in audit code
Message-ID: <20250508.f94265b49f51@gnoack.org>
References: <20250507185404.1029055-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250507185404.1029055-1-mic@digikod.net>

On Wed, May 07, 2025 at 08:54:02PM +0200, Mickaël Salaün wrote:
> Use the BIT() and BIT_ULL() macros in the new audit code instead of
> explicit shifts to improve readability.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/audit.c    | 2 +-
>  security/landlock/id.c       | 5 +++--
>  security/landlock/syscalls.c | 3 ++-
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 58d5c40d4d0e..c52d079cdb77 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -437,7 +437,7 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  		return;
>  
>  	/* Checks if the current exec was restricting itself. */
> -	if (subject->domain_exec & (1 << youngest_layer)) {
> +	if (subject->domain_exec & BIT(youngest_layer)) {
>  		/* Ignores denials for the same execution. */
>  		if (!youngest_denied->log_same_exec)
>  			return;
> diff --git a/security/landlock/id.c b/security/landlock/id.c
> index 11fab9259c15..552272307697 100644
> --- a/security/landlock/id.c
> +++ b/security/landlock/id.c
> @@ -7,6 +7,7 @@
>  
>  #include <kunit/test.h>
>  #include <linux/atomic.h>
> +#include <linux/bitops.h>
>  #include <linux/random.h>
>  #include <linux/spinlock.h>
>  
> @@ -25,7 +26,7 @@ static void __init init_id(atomic64_t *const counter, const u32 random_32bits)
>  	 * Ensures sure 64-bit values are always used by user space (or may
>  	 * fail with -EOVERFLOW), and makes this testable.
>  	 */
> -	init = 1ULL << 32;
> +	init = BIT_ULL(32);
>  
>  	/*
>  	 * Makes a large (2^32) boot-time value to limit ID collision in logs
> @@ -105,7 +106,7 @@ static u64 get_id_range(size_t number_of_ids, atomic64_t *const counter,
>  	 * to get a new ID (e.g. a full landlock_restrict_self() call), and the
>  	 * cost of draining all available IDs during the system's uptime.
>  	 */
> -	random_4bits = random_4bits % (1 << 4);
> +	random_4bits = random_4bits % BIT(4);

Optional nit: Might be slightly simpler when written as a bitwise AND:

  random_4bits = random_4bits & 0b1111;

(Probably does not make a difference in the compiled code though?)

And, to also simplify the statement:

  random_4bits &= 0b1111;

(If you prefer to stick with the modulo, "%=" exists as well, even
though it's more obscure.)

>  	step = number_of_ids + random_4bits;
>  
>  	/* It is safe to cast a signed atomic to an unsigned value. */
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index b9561e3417ae..33eafb71e4f3 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -9,6 +9,7 @@
>  
>  #include <asm/current.h>
>  #include <linux/anon_inodes.h>
> +#include <linux/bitops.h>
>  #include <linux/build_bug.h>
>  #include <linux/capability.h>
>  #include <linux/cleanup.h>
> @@ -563,7 +564,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
>  	new_llcred->domain = new_dom;
>  
>  #ifdef CONFIG_AUDIT
> -	new_llcred->domain_exec |= 1 << (new_dom->num_layers - 1);
> +	new_llcred->domain_exec |= BIT(new_dom->num_layers - 1);
>  #endif /* CONFIG_AUDIT */
>  
>  	return commit_creds(new_cred);
> -- 
> 2.49.0
> 

Signed-off-by: Günther Noack <gnoack3000@gmail.com>

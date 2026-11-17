Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925446;
	b=M0frghSOt0AvlRHKvYpXqhKY7iMPMXabLvt9QotZnHn+AP1iLgwnnK5o6dQt8ha8mluP
	 T5/IqdADwwrZwaL51J7k52nOfHk+EKtERbDbvhwd/rKmO0wsdyB4x/K0NrJnTH/CByUwo
	 dAZTjHIp2jOVOmIclG767iqPMGF8ioG4Pu1MLfYfUbntws/yqr24Pa7m4OrHrk/Nb+8UO
	 7yIL1EwuCxoIf2eGJEB414z6cMhT+uFbxb1PCXlFHjO7jICI3nN6trDek3DfE6xQOGAef
	 dUw59zJaOV9Q//0hFwRKb9d7KF+gL7jTd/qMHLaTt3o/pdAmyav2NhTEJoLFtTlWF5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=vOJ+aYWhkwD6HIGtph9wp8GgSB5fsvMb0iWQS98XCE4=;
	b=aaLct7JqUe7cvKOrSm8R7nDx6ltRDseFt+koltXolPYBhS4F8WLlvUWOPlGVhjr32FFw
	 tiPZA93IlSKefsraND6SP4a6on6QzHCHfPtXBPbuh5uZYOs7VYmhb4SB7BDP2/Y0mW/K3
	 Oat8/QtxkQkB5nC3ZqsU4DIGv9jg7Rg1O8L4qKegW93rSeUQQF/hoSQE4KEAZrzb8t8UM
	 f4c0OZQR+HJSX+7qbKxcK92re1pSBWOZrLgbsMTAMf9IdjT9IDRU0yIMcWTIoMDQQpW3L
	 ECxav5zhm7HnTVsXKfVCTaXmAlyAmHgDHWwND+9Nz84jYgw3DAg4L3JK47bFZVgl9aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="I5/x7GUM";
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A96606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 14:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21A96606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I5/x7GUM
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c50933bdf4bso221991366b.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 06:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794925444; x=1795530244; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vOJ+aYWhkwD6HIGtph9wp8GgSB5fsvMb0iWQS98XCE4=;
        b=I5/x7GUMTUk9ZBagKydceTqyNS9FeML64SX6ZRMO+bd9SLKBzzSfgwyCjb/NRNtrj7
         I3J8zGygIcAvyCrS3i6apKAOlxfgKdiF00qjeO0LndpJD2pPpREubbwwf0yTl1bEg/He
         li0KmvTtboryrQYzgYfe5Gu8qB6jHAAtjBRVzt/nGCxjl0FuTcJiUSssAEjK3wQUPYx8
         SDBHNcJBcckCoAeokCCQ5bpBtYtc8O6f/JB7LilBqPyD5ofmvv+Ej1vXYQ3X5rV34fXN
         gnDY3vQ5mubET2nb4rvOQRwKRkVH83lZtizEhOfVuj1WPXrzl3xVbZ6VbznNGsjj2IKe
         R/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925444; x=1795530244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vOJ+aYWhkwD6HIGtph9wp8GgSB5fsvMb0iWQS98XCE4=;
        b=c9QduzBBFkVgKdhLz4Vl8XkpEFbQPnxZ280NTbRh6Jzc0KwyO8MTo5NoB2mpNQax0C
         oCq+GxQQTKsPmbeVjucD0Ovgvaf1tSJ6pnzVOPmuLuZfghBDtLgnGguvCbLxpH7vXkmB
         flGukKbfuM5lZvVWtpc0Kg8bJjVCPqRWKou7t3neShTy/Bm5CDVU/HU8wprnAYN0L1rX
         1EOswSty1x8oZCh0UHjyRIHZ8s18eMbltQGt3x+uFQKkq5nPs/sfwexLwdf0nBxzqGB8
         PH/WhlKsfsH7UQDHqGi7phN/u+tEWNh9dk48f6Ur9eH/JhOZ/O0ynfDGb7pIDrES4i5M
         W07g==
X-Forwarded-Encrypted: i=1; AL+hErGN54hJCO7HhVkhMfDZJTdmo49vAlZcsflObN6LtNtzAg9xZkjBzjTHF8ytjd/zQzjyCBAz0BtngCJYu4na2EIne3ecMrk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MhcbUckQUEGTai47q7bvtZE7l/NK5qIwHaVJvFY7sQjDffObL
	38Shz0Yj19v5mzTNrFvPpPJ+wlYx88sn7vz6xfAc/asFMAiF/W9HPQqFhE0BCOfSxA==
X-Gm-Gg: AYBFou1Ws6UaZ8eqgSXzBXWp1KGSKyfrjBEB9xOFdBG3BoklL43MfNmJ4dzcYaAQQT6
	Ht7WnPOeETlHJ/EfLhLjmARwJZs+vyL7enfTu/GUFHkomGt1wO1RTJn2hK/6UTJanhVoMedSjR+
	aBbcveUpcHvu+0VPGeastTfjN9sJXTKCZwEC72K96ZsRfpvmpJHdEi8VP4uT7GFsZyQUDd9Qwu4
	kzl8c1jksHC9qinOQsYpWuNu8o/0tVNckyYkrWYFHTMauubv8d4hWyKcv2UAQNkdDIyGpHKOCBe
	9ARqnMghugibAYFPardZoUr7bpZgYU4JeSIsRy8xeSpwAWL88svqJ8yARcVofE7+OxgaL3yLLS7
	nILSGq6baIWVFf0TSn9Lr+7hYFf6Wj2ZadNz5qOQRqKwS0c05MRBByJv8YiVYttX3niPPsyYfm+
	6wt4Njy8ZckHFmI4JA7BQsSx6nWbDNNkJAzKAouDZRJdXa0/g4TUkQucxi8GEhhO8jUq3dnQiPo
	Q5P1kWbs8RZ3juYnY9WClMuuPmQ6W4MxdZHpgbAISl53CNeYbKSXwsForgbXk4CLIr/58mc3qlr
	sLIV4XGDD3Dw1pextFgoldnJ4+djTWwq93UhKwNsOaBCXMNo/qGqWzzjEVVcMnVWgr590UWs7eM
	GaFRMgQ==
X-Received: by 2002:a17:906:99c5:b0:c51:2e3:f426 with SMTP id a640c23a62f3a-c5102e3ffbemr156705666b.18.1794925443904;
        Tue, 17 Nov 2026 06:24:03 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:12e4:4602:d8d8:3043])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b60988sm551518866b.59.2026.11.17.06.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:24:02 -0800 (PST)
Date: Tue, 17 Nov 2026 15:23:56 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Ada Smith <adasmithgt@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>,
	Serge Hallyn <sergeh@kernel.org>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 2/6] landlock: Mediate CAP_SYS_RAWIO for mappings
 below mmap_min_addr
Message-ID: <avxjfHybQBcATFKV@google.com>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-3-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261117101157.2520463-3-mic@digikod.net>

On Tue, Nov 17, 2026 at 11:11:52AM +0100, Mickaël Salaün wrote:
> Until now, a process in a domain that denies CAP_SYS_RAWIO could still
> map memory below the vm.mmap_min_addr limit if it held this capability.
> cap_mmap_addr() is commoncap's mmap_addr hook, and it checks
> CAP_SYS_RAWIO with cap_capable(), not security_capable(), so the check
> never reaches hook_capable().  Mapping the lowest pages is what this
> limit protects against, because it helps to exploit kernel NULL pointer
> dereferences.
> 
> Add a Landlock mmap_addr hook that checks CAP_SYS_RAWIO against the
> domain under the same condition as cap_mmap_addr().  With the same
> vm.mmap_min_addr value, the hook only denies mappings for which
> commoncap required the capability.  security_mmap_addr() stops at
> commoncap's error, so processes without the capability get the same
> result as before.  This also covers the x86 vm86(2) and vm86old(2)
> system calls, which use the same check for address 0.
> 
> Making cap_mmap_addr() call capable() would also fix this, but it would
> send every low mapping through the capable hook of all LSMs (SELinux,
> AppArmor, SafeSetID, BPF LSM programs), adding capability checks that
> their policies never had to handle.  For instance, SELinux checks
> mmap_zero in its own mmap_addr hook and keeps it separate from the
> capability on purpose.  LSMs with their own policy for low mappings
> implement it in this hook, so Landlock does the same.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> https://patch.msgid.link/20261110202436.2408244-3-mic@digikod.net
> - Add Serge Hallyn's Acked-by.
> ---
>  security/landlock/cap.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/security/landlock/cap.c b/security/landlock/cap.c
> index fa59118e3486..10e1ca772b9c 100644
> --- a/security/landlock/cap.c
> +++ b/security/landlock/cap.c
> @@ -9,6 +9,7 @@
>  #include <linux/cred.h>
>  #include <linux/lsm_audit.h>
>  #include <linux/lsm_hooks.h>
> +#include <linux/security.h>
>  #include <uapi/linux/landlock.h>
>  
>  #include "cap.h"
> @@ -90,8 +91,29 @@ static int hook_capable(const struct cred *cred, struct user_namespace *ns,
>  	return check_cap(cred, cap, opts);
>  }
>  
> +/**
> + * hook_mmap_addr - Restrict mappings below dac_mmap_min_addr
> + *
> + * @addr: Address of the new mapping.
> + *
> + * cap_mmap_addr() requires CAP_SYS_RAWIO to map below dac_mmap_min_addr, but
> + * calls cap_capable() directly, which skips hook_capable().  Check the same
> + * condition against the domain.  commoncap runs first, so this only sees
> + * mappings that commoncap allowed.
> + *
> + * Return: 0 if allowed, -EPERM if CAP_SYS_RAWIO use is denied.
> + */
> +static int hook_mmap_addr(unsigned long addr)
> +{
> +	if (addr >= dac_mmap_min_addr)
> +		return 0;
> +
> +	return check_cap(current_cred(), CAP_SYS_RAWIO, CAP_OPT_NONE);
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(capable, hook_capable),
> +	LSM_HOOK_INIT(mmap_addr, hook_mmap_addr),
>  };
>  
>  __init void landlock_add_cap_hooks(void)
> -- 
> 2.56.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>

Looks good; I compared this against the commoncap implementation of
the same hook, and the logic checks out.


Minor nit, in case you end up sending a V3; I found the commit message
a bit wordy.

It makes intuitively sense that the commoncap LSM does not want to
invoke functions which themselves call into LSM hooks, even if it's
just a safeguard to prevent accidental recursion or deep call stacks.

So for the few cases where commoncap checks capabilities directly, we
need to do the equivalent checks in the same LSM hooks in Landlock.
That means, we replicate the logic from the commoncap hook if
necessary and treat it like a capability use that came in through the
normal hook.  This is similar to what SELinux already does as well.

What I would have found useful to discuss in this commit message would
have been the story of PF_SUPERPRIV:

commoncap sets PF_SUPERPRIV when granting the capability use, and
Landlock does not undo that when it rejects the capability use.  In my
understanding this is OK because the flag only gets used in "legacy
accounting" use cases and the consequences are benign.  The
interaction with SELinux is already the same as well - it does not
unset that flag.

—Günther

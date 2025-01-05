Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678D20311
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736040233; cv=none; b=It6Y3ReA2WJ8o3rRmSlYs2kwx8MwTO9vDcQSbPzSULTIukD8vmQQzKGbCSHh5U5/foXxcGvDli4Yii5RLhH8jLaiLKts2VjQa8F+e7g6hRfmTrV1uRt+4aBnpU9DdujAhbZMPxEu9FCvKN8ovepUbdCLxuhkF7AM9bx261rZWlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736040233; c=relaxed/simple;
	bh=cx7aFAQRYoFBaTP4xpurSvEu2jN1c2qlDvCUOzCk0Fw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=B70AdDMz9FFyhOQEciF4QjXbzyHVzUZKqL/h1L/m36c3t4/6fo/aTpfY2PEQEAp3BWqH9l/i2DMLigDjLMcTn29Y/7FUzcBvL2z7eESqgGY3zdgSgpibpkxNLfSQKBCHZTukeaWDoY7gH4zfEFrpvPSa34INeBOXO8G2oQovtT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OpxFLTu5; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OpxFLTu5"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ddcff5a823so9287716d6.0
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 17:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736040231; x=1736645031; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbSANAit+nNhV/GPK4Rpn/U4rLbYqshu18t3yU7ZUZ0=;
        b=OpxFLTu5WAG9yUqrRzBCOVX8YW1SL36NwnDTzXMMy0uJY28cYCd4ltKtNurffscjuP
         0rSGWDR4nowP+GvdBam1K/VJXXLePah4W1NVYCC2pGlcSOLLYND1bS43gRWBc0mkJ+de
         WRn5yzvNhrrEAvq2pT4PPDL+6zz3M0grBUKYnoczBuOyje6ZT7D3JUGMo9kecVxyapPm
         7+04LeDDoXjluGl9DZtwsLVQabdiZqlyy7Cc8KzMFNDvb5+7kZKITVCd32kK071RJxP5
         dP/6J81++UXseI+ti1RP5DAGBDLmkOwuiq94XJZ6clpFU/b9BiboTJLQ3mNESkWuWdlJ
         jMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736040231; x=1736645031;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZbSANAit+nNhV/GPK4Rpn/U4rLbYqshu18t3yU7ZUZ0=;
        b=p8CTVSbr3byyqyIyY6ctop5ogw/wivo3GLyWeKiFZdLVnsRcZuQ3Njr3o6mzylTpCm
         omjdDerMjB+mLpsw+2b1e2UwLujGIRejBt92g+WIS5M+0m3rzGGoyZLOUjwy4pVCmlaj
         rHOGNlgoff387bkER5S7qq79K2cUxMDRWFXcYKmdCZhL/ET4HWv0/CrwHH3yl/Yme7vF
         MVC4xGIjwLHS25EukMZjf3hxZAyGF6pGftbfEqUI1z0rm9Cy03jdh1iSI/zzqZVI4CS0
         Y3d755dMTWTvqSSrXsxwsGq5IUYRaGH6ntxyD/D+9GagqqyqYHM+XEwGPq7NK1E53iN0
         l5fg==
X-Forwarded-Encrypted: i=1; AJvYcCXWptBqJp2S1jUe21kdfJRgD10u0VA/69isHjc4rBiI1SphKjdYE9v2uJMdXywY9uwEaI0wzLvBw3ZPHdG0TphB0kRsZ7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEwmFwJo3m/K7ftLrT0xwINKOgId4PIvZNdHolZyapATVQPOR7
	HLuhp6S+E9UooyiulNXRwfab3MEAan0Ao1ocg1TI8CESv0X7f5q1FDmGoCa69g==
X-Gm-Gg: ASbGncu0zA8uRrcwYSV3HKVriJCIu/n0xGr/4O1I9d2dyavS6Hp2Bct2pOQ0rwcTTCi
	u/tTQbPofpvcHOqX37SJ3xSmvMzcUxNZMNlG9tOVR0mrczoHzqsnZHo1qPeKu2j6gug0/CZXAF3
	+BCLBWaF3a/FJWSuv/Omg54kkG4SzfDOEsHqFDwcMedzNAKcKH1p5WlGW2x2dnyo4ur+EWXTUu6
	5NpOCASK0uYbRgvpTBN8mQk33Uwj2uLMr2ucK+9kwAcZktVpFQ=
X-Google-Smtp-Source: AGHT+IFAW/O9xgHOLQxU7/y6pZPm969hCUI/wy/IpW8NgeI8pQ0oZf7IolNnJMoqvr+sjb1Uc1f85w==
X-Received: by 2002:a05:6214:21e9:b0:6d8:a1fe:7293 with SMTP id 6a1803df08f44-6dd233ac3afmr710213676d6.42.1736040230673;
        Sat, 04 Jan 2025 17:23:50 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1810db8fsm156404746d6.46.2025.01.04.17.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 17:23:50 -0800 (PST)
Date: Sat, 04 Jan 2025 20:23:49 -0500
Message-ID: <a0181404db7048781857521d010d0658@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250104_1133/pstg-lib:20250104_1133/pstg-pwork:20250104_1133
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Eric Paris <eparis@redhat.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 8/23] landlock: Log ptrace denials
References: <20241122143353.59367-9-mic@digikod.net>
In-Reply-To: <20241122143353.59367-9-mic@digikod.net>

On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Add audit support to ptrace_access_check and ptrace_traceme hooks.
> 
> Add a new AUDIT_LANDLOCK_DENY record type dedicated to any Landlock
> denials.
> 
> Log the domain ID restricting the action, the domain's blockers that are
> missing to allow the requested access, and the target task.
> 
> The blockers are implicit restrictions (e.g. ptrace), or explicit access
> rights (e.g. filesystem), or explicit scopes (e.g. signal).
> 
> For the ptrace_access_check case, we log the current/parent domain and
> the child task.  For the ptrace_traceme case, we log the parent domain
> and the parent task.  Indeed, the requester is the current task, but the
> action would be performed by the parent task.
> 
> The quick return for non-landlocked tasks is moved from task_ptrace() to
> each LSM hooks.
> 
> Audit event sample:
> 
>   type=LL_DENY msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
>   type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241122143353.59367-9-mic@digikod.net
> ---
> Changes since v2:
> - Log domain IDs as hexadecimal number: this is a more compact notation
>   (i.e. at least one less digit), it improves alignment in logs, and it
>   makes most IDs start with 1 as leading digit (because of the 2^32
>   minimal value).  Do not use the "0x" prefix that would add useless
>   data to logs.
> - Constify function arguments.
> 
> Changes since v1:
> - Move most audit code to this patch.
> - Rebase on the TCP patch series.
> - Don't log missing access right: simplify and make it generic for rule
>   types.
> - Don't log errno and then don't wrap the error with
>   landlock_log_request(), as suggested by Jeff.
> - Add a WARN_ON_ONCE() check to never dereference null pointers.
> - Only log when audit is enabled.
> - Don't log task's PID/TID with log_task() because it would be redundant
>   with the SYSCALL record.
> - Move the "op" in front and rename "domain" to "denying_domain" to make
>   it more consistent with other entries.
> - Don't update the request with the domain ID but add an helper to get
>   it from the layer masks (and in a following commit with a struct
>   file).
> - Revamp get_domain_id_from_layer_masks() into
>   get_level_from_layer_masks().
> - For ptrace_traceme, log the parent domain instead of the current one.
> - Add documentation.
> - Rename AUDIT_LANDLOCK_DENIAL to AUDIT_LANDLOCK_DENY.
> - Only log the domain ID and the target task.
> - Log "blockers", which are either implicit restrictions (e.g. ptrace)
>   or explicit access rights (e.g. filesystem), or scopes (e.g. signal).
> - Don't log LSM hook names/operations.
> - Pick an audit event ID folling the IPE ones.
> - Add KUnit tests.
> ---
>  include/uapi/linux/audit.h  |   3 +-
>  security/landlock/Makefile  |   2 +-
>  security/landlock/audit.c   | 137 ++++++++++++++++++++++++++++++++++++
>  security/landlock/audit.h   |  52 ++++++++++++++
>  security/landlock/domain.c  |  21 ++++++
>  security/landlock/domain.h  |  17 +++++
>  security/landlock/ruleset.c |   3 +
>  security/landlock/task.c    |  91 ++++++++++++++++++------
>  8 files changed, 302 insertions(+), 24 deletions(-)
>  create mode 100644 security/landlock/audit.c
>  create mode 100644 security/landlock/audit.h
>  create mode 100644 security/landlock/domain.c
> 
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 75e21a135483..60c909c396c0 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -33,7 +33,7 @@
>   * 1100 - 1199 user space trusted application messages
>   * 1200 - 1299 messages internal to the audit daemon
>   * 1300 - 1399 audit event messages
> - * 1400 - 1499 SE Linux use
> + * 1400 - 1499 access control messages

Thank you :)

I'm also reminded once again that the original audit devs stubbornly
used "SE Linux" instead of "SELinux" :/

>   * 1500 - 1599 kernel LSPP events
>   * 1600 - 1699 kernel crypto events
>   * 1700 - 1799 kernel anomaly records
> @@ -146,6 +146,7 @@
>  #define AUDIT_IPE_ACCESS	1420	/* IPE denial or grant */
>  #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
>  #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
> +#define AUDIT_LANDLOCK_DENY	1423	/* Landlock denial */

Generally speaking, we don't really encode denial/allowed verdicts into
the audit record type, instead we ask that developers use a field like
"access=" to indicate that an action was allowed or denied.

How about AUDIT_LANDLOCK_ACCESS ?

--
paul-moore.com

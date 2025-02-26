Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7932248B4
	for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597241; cv=none; b=miGYQWtsBx7DL2GQpOyqrWkJR36g/GblXGl7IspaPrOfPnNOKQ0YVm8A/mtWrU8/lq0sU42CmUIGa/okalfWDv6CIahexuLe/Q6X4TYzvS7YYchqGtKAjLLdZaCOiMP7yKERaESY9b9ELOTuQuYB29o60qZOORRBwxGx8Fgw9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597241; c=relaxed/simple;
	bh=vHzrEzooH4K8CcIGUei7pRVS17MmHjHrMcmzZoer/Ec=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=cSM7w6rX3KKFs8tEEXqTuA1ogIyFplPrcAtyyXjxUcKaoDTJwh4icq92CpM2KTS1Ka5wV0yXqGlkgBhdenebjovwphA9dn3XERGZZXy0cLLGMS2CkGiiG6vK9hy3EWdcVp16p2JBjMKIKJGrZ8bBJrQdbkYvp6IXOx7CYkl5ge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PrgrgjIB; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PrgrgjIB"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46fa764aac2so1219411cf.1
        for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 11:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740597238; x=1741202038; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/7HubgIS3yguXLFwagiKL0MIanaDsiXeL1ZcDJnpI0=;
        b=PrgrgjIBDzFyuCW0/BkssmUrWr+ejDo9K2GOMxCGaRhnW6xhcbtTD1JwwVGKLo/83P
         3dM9rKUsAMq62CVpok1RfQHA2wfcnXMzJ18qMcZcYUdGiwaEKk+ikc6U0hO+hXP5eQ2E
         NyqwDG/QmtPKzQkkLdTGYwhvbp9CTaW2CN1tiR+JGk13bm+x5+rLq5IqlamFPgOFO8PM
         HjoHxNDXIv68a/z/4EiqGgLE/s9X5kBDvYWorhxzCCaJ/Ef6jGrbARuL5iiZvdsP0RaR
         Wk+ZOlH0gvpRUqepXN07eMUzObSySHsdNfhHZlo1wCex2FQyD78d2/r2De4OapeVF9iC
         RAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597238; x=1741202038;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O/7HubgIS3yguXLFwagiKL0MIanaDsiXeL1ZcDJnpI0=;
        b=vXJ3yTZIW1nW2JUG6s9T8Frc5JZer74Yp1qIZKUCmcZvwmhoSfiTEq8MsXWIU+g9WJ
         S9c8D1l7xH/5toQOPbTgYaySlLSXYm5iS3qfTLbajzWoiMCTB9rPAg3JMJwbIsGy3r1E
         CrrtkxHUUa+DXLKNeXxl5+F6UGma3aecbxRGhUUtFS31cwrMmkfRl3hsxod5AmDiBGly
         8uvo9S2HGhiUuEotdnYvQ5tIcozixd2Ue5WF/emdJ+5CXpCr14tcwRQKkL4Q/96TwdAo
         gsnnmIrH4mT/3FJ/jLcLhYGoI1/x/nabm/r1VUGUbrsZjsPu/CwwFc7Qp/xnLSBvaSB6
         6ROw==
X-Forwarded-Encrypted: i=1; AJvYcCU8BhqIetJlOSZyGA0X6ABVbvJw2GJvxRdMdUiDgc6AP2A4YbsztcYl/Pry27Ek5buMRZxzH6iF2LydPfIkMXov7fKNqc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89rSEKxAnjIMkpsIPVqKcDRIHBakJJDyefmQRP2nPUFFm6lTu
	ab2xkE3QOYSioyPP/VHexg4I5FOvyUdlWuZJj1+HNVGNVz0Gu3iiENIBd9p6gw==
X-Gm-Gg: ASbGncsKyfAgYCekcTD1P5TTjjEnEa5c4r5BhdYZ3EIfKXHXy+7n56OWgwdFGF5zahU
	HDaJpAvw0kAmr98snD60Ae3x0ruRfotCGgqh066/xNTs01fhz/wP8bhYojjM8ZzTjj6tLVdDSHj
	WZROSscC7Ge5CaCZLdn4UX+MRpldO6cdfEboj8QVO8ZRTPb8k9EzbVPJtKh5thuoOIRr/eisWG0
	LC66tsTUPJN7VEtbrBjSLqYRlBIkZbzp02KDiotzcnF60NxXMK/n4LEtCpQ4yxaspb8j/lkl/vY
	q/94sd9vp2usUjiNtKniOIeHKppojnXKLMxLYaCQXAJwv9QK+/+ZJ6w3ZQ+DEveXUvlrwfA=
X-Google-Smtp-Source: AGHT+IGZKQ763FRka4tXmeqX9uwcpJ0v96pIEchafXYFD2cwhU7ih42tfW2HHRWzr2HQKaEkzBO+qA==
X-Received: by 2002:a05:622a:1a07:b0:472:201c:aa45 with SMTP id d75a77b69052e-47377116ed2mr109013401cf.9.1740597237709;
        Wed, 26 Feb 2025 11:13:57 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47377e1543csm28407591cf.27.2025.02.26.11.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:13:57 -0800 (PST)
Date: Wed, 26 Feb 2025 14:13:56 -0500
Message-ID: <41cb98ddf724ade0fc529b8c952f3efc@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250226_1339/pstg-lib:20250226_1339/pstg-pwork:20250226_1339
From: Paul Moore <paul@paul-moore.com>
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org, jmorris@namei.org, serge@hallyn.com, rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, luogengkun@huaweicloud.com
Subject: Re: [PATCH 1/2] perf: Remove unnecessary parameter of security check
References: <20241223070650.2810747-2-luogengkun@huaweicloud.com>
In-Reply-To: <20241223070650.2810747-2-luogengkun@huaweicloud.com>

On Dec 23, 2024 Luo Gengkun <luogengkun@huaweicloud.com> wrote:
> 
> It seems that the attr parameter was never been used in security
> checks since it was first introduced by:
> 
> commit da97e18458fb ("perf_event: Add support for LSM and SELinux checks")
> 
> so remove it.
> 
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/events/intel/bts.c     |  2 +-
>  arch/x86/events/intel/core.c    |  2 +-
>  arch/x86/events/intel/p4.c      |  2 +-
>  drivers/perf/arm_spe_pmu.c      |  4 ++--
>  include/linux/lsm_hook_defs.h   |  2 +-
>  include/linux/perf_event.h      | 10 +++++-----
>  include/linux/security.h        |  5 ++---
>  kernel/events/core.c            | 14 +++++++-------
>  kernel/trace/trace_event_perf.c |  4 ++--
>  security/security.c             |  5 ++---
>  security/selinux/hooks.c        |  2 +-
>  11 files changed, 25 insertions(+), 27 deletions(-)

Now that we have Ingo's Reviewed-by, I've gone ahead and merged
patch 1/2 into lsm/dev, thanks everyone!

--
paul-moore.com

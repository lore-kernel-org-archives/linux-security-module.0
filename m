Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63DA3595B
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736040234; cv=none; b=Vu3vwvuqtlQIXVaC+80K+prB9Bv7yi1dLPbOBEY5W3dc5Pab737NmYr/V1w4fZDHwz+iOX5ByIDUIt0PqVm6HiIKfx+LCxyRJeP88UEj/NI+k5Lrv9qJvVxnXCAee2f+7U1pp4Qu+1bT3aN/lz5YEin2Et1ey4NQH+hHLDPpdQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736040234; c=relaxed/simple;
	bh=giREWuotuLRExC4OqokuExUwTwDtYZNFJ1UGDeGpW3U=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ZhiXLlmL3bnc2m1J+sFBn8z5l6MTBDpHcCIkykH8PIrc9rdE7X4X9g3Nt56KzNPFutp4qlfY4D4BqYlN9TmdNpz9ha3eVQjM4gnxcBkiw98KrzYElx2j5kGUThK/wy859XZWm4SqS8OHyLuMMRfazpihfcC8KTDmsvH4TgC47n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FHj2GdSa; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FHj2GdSa"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6e9db19c8so1009730985a.3
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 17:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736040232; x=1736645032; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9rT4XVdO+KJptzLIU5K24Iy8JAMC8dWqPat04fTPeg=;
        b=FHj2GdSa2GLcP/Buw/ipSliYzfTZKnKhu2XOTVM8TXvYh8MCR6nxFqG7K6eNpPH/Pd
         zAX9mksFYptwqhF8N7TDfoC/u93U6liBjzTCS14IdVghwgDlVmkQjlraqPoxaUa12vr1
         iHZ+ku3S4kvxDVjWQnNO4/op28FyCL5zw66NxmQfX9CWTrPqV82foe68lPV17StLodn7
         T/XicEpED+qruuzArZtuAm0WhIhA2+9z7MEja/PddJoPfs7+ewohryZmHIT/gXWaJ5uQ
         IDCnAXESfh+LGqJMIkST+pP8uRDHZlSjY+hXLRmATKlH+o5mdFgFu5O4svpbhzUPMnce
         kw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736040232; x=1736645032;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k9rT4XVdO+KJptzLIU5K24Iy8JAMC8dWqPat04fTPeg=;
        b=ovmnUJDSlIOY3gbKlFuQLdw5fS0dzeoGLKgUNTHi5LvZMKWEEun7EJmsz3RV+Jc7yb
         17XH02UAZnBWIpXH6bzP5TgKwWmHx+ANHvENNjYAMadhRvjzXFEpbElQLDlebsPLvgr/
         6NYTmNU0tF3/Xlkm+EXpHPzlWF23p/+IbiQNSCJSrEu+Xt0/9C747XPoFuxlY2W/iA4j
         oESlzSMFK4lWM+u6sDFmM2Vj67eKmWvVLbuI+y+9K0+NyXDgPS+48kBOt+aE8HUk163a
         lxhrjzI4+QLKKhV8tWhXZN8mCGyEwWodZV5BbSr7auYJ96ntxBHnj1NbBB/pmgvPRvGE
         VFDw==
X-Forwarded-Encrypted: i=1; AJvYcCUg0hi84iT9gw0JSWVydh+mLE3zeiSId4Zt29Q284EHxhgeiuyi9QJn+hy4Y9/5fIbIQVaAX6LLj72rUALC6KtmCluoThQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqmsj1FdB/ZTlL0fUazBPQJDrObf7AvOOfqrx9i5YbRavUtHgP
	QCKfP8nXjC3o7174KM2+5WznewUfNxZrmT6yEO8Kd9dIb2hUXd/FVH5sda+hHA==
X-Gm-Gg: ASbGncvdPmYcNTyEEWz7WCs2K2gySlOzOEwIdDIEvVvbfyL85JCVEgyaFC8jp5dHSce
	p9ATJYuakf+aW+eZfAOW03IZVDlfTq/VWXXhJiFDN7LJTVzVRuRveck7ir2IIOwNKitHc+suGMT
	+DhPJFuOFAvdp9+EtjxSnC8EkeyhnzULiLpGT6bycMjOqc9RLdtS/A2qFqLjHGc38xo/k/C8OA7
	FeU2sZn8qFsSlKQCyO7bZxWYdl+bQhaf2kuCgRL2A0Z1VAjFRE=
X-Google-Smtp-Source: AGHT+IHglY+9TOxiTWIJ5F+v+fUise97c526iFqjanfLoXT3ipJnbKyIO+pLuH0YYRWs4S+ESy8RGA==
X-Received: by 2002:a05:620a:1727:b0:7b6:c673:7427 with SMTP id af79cd13be357-7b9ba83a774mr7790907085a.59.1736040231672;
        Sat, 04 Jan 2025 17:23:51 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bc18dsm1392530885a.22.2025.01.04.17.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 17:23:51 -0800 (PST)
Date: Sat, 04 Jan 2025 20:23:50 -0500
Message-ID: <a70e3b887f55a0e21c2cec553e047ce0@paul-moore.com>
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
Subject: Re: [PATCH v3 9/23] audit: Add a new audit_get_ctime() helper
References: <20241122143353.59367-10-mic@digikod.net>
In-Reply-To: <20241122143353.59367-10-mic@digikod.net>

On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> It may be useful to synchronize with the audit's timestamp e.g., to
> identify asynchronous events as being created with a previous audit
> record (see next commit).
> 
> auditsc_get_stamp() does more than just getting a timestamp, so add a
> new helper instead of exposing it and risking side effects.
> 
> It should be noted that we cannot reliably expose event's serial numbers
> because there may not be any related event, which would then create
> holes in the sequence of serial numbers.
> 
> Cc: Eric Paris <eparis@redhat.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241122143353.59367-10-mic@digikod.net
> ---
> Changes since v2:
> - New patch.
> ---
>  include/linux/audit.h |  8 ++++++++
>  kernel/auditsc.c      | 21 ++++++++++++++++++---
>  2 files changed, 26 insertions(+), 3 deletions(-)

I need to see where you actually use this, but I'm not sure I want to
expost the audit timestamp outside of the audit subsystem.

Okay, I found at least one user in patch 10/23, and no, that's not
something I think we want to support with audit.  More about this in
patch 10/23.

--
paul-moore.com

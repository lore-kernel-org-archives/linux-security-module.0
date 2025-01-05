Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9401E84A30
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736040238; cv=none; b=XS9bwjDbw8DOG7fwHnx8lwK+IPfXGcs9ywvwcMNycNJmXTSH7zzQImWe4mIRY2wJIUsx0jL4WXWiKBiCoa621nMUVTkQfpH53f3Fw0iOX7LH9K11Kw1PSWSnP5SM/yq8fen4C9OKx41Bz77GfYAGVah9cHZIMKTgnMB0kZiuUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736040238; c=relaxed/simple;
	bh=oRpjOHn0MYdlDgb16H93ygH3JV76zY1R0D6wzNkXsBs=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lgxTlmJP7jHox9Ae1TPQ/+Xm5rpf3DXUYBRsmZCJz5zkKO4e9NA2HjfREzQM6BWGHxtnqV9KX9aUNEa8KhMWWDq5nK09gOMOrcjUyHinEOsPLBnwEMbRFuluTg244q8g2Vk0H2ilotkRdMkzlrY3x8L4B/nLiLu3CnU2KInO6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PYo6m5o5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PYo6m5o5"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6fc5bf609so1061827085a.1
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 17:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736040234; x=1736645034; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IERUjrBgw0h/87tZ2x8wz7LTzEntrKvOegC9huRuDWM=;
        b=PYo6m5o51rWMjCfRgS0D0a/mfmm3xejPHP6Ia1wnuA2Rc2RfwGaOF1hxiAQ+1MU00X
         Bo6W5T90IXtU4ptAwKtrFUidrBpTfeIVBzdnWHOYE77yujQGJHAU0gAJihWGJMsZM0ZS
         qDTTts5kAcb+G0oEzbQkscgPsTXuRmiuGmT+KmKwTMVBPYhv/7knzilMuq5x2ThgNcBm
         P+HzBgzew9rZYpffJeEZv9O6x5nY5g6okQ5xzvEZQlWNX5W/i6vOp/kx6KP7BgrShv+x
         SapG7Eix4D0KcUzNKBgArUN5NvDdp30GqUnmO0zzNGMEcB/ODt9PLEQJL2cD5DVGd/03
         lOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736040234; x=1736645034;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IERUjrBgw0h/87tZ2x8wz7LTzEntrKvOegC9huRuDWM=;
        b=BTBLuPokeqBBGeK5HTjtj/J2S4hyI2qlxaNAnSwowp5ZdOOS1oFniZyjknBxNpo9T0
         d2n8oUzm494Z3c8qfYf59SAZjz77U4NjJxraxJceBN//gTsHK42YO83aRwIhPW9uieY1
         6goPZxetRWXbuzd0fIvFWNXxlZIimz6Pm9p4GI+n+6udz2CgPTv83wZL8qcPR1RqlbPj
         sU3i6wejmFtJ7/JjBNRuApeMzUd8jic5ouS9BJy/wEiGWK7bSEj7gSMcowgzgj7SaLG9
         GrS0vPduamIUtCOT0H9Uil3wKBq2vruZA5m4EY3NAjU9wg0ObAvno805AObarf1axQ7F
         UGLw==
X-Forwarded-Encrypted: i=1; AJvYcCXsK6aDicdq523Tkz+5oatd8LG4Kj3HtxNUtTswu2a2qN237F60IMscZiESNZ9ndvoxt9VlvAr0Qoy2lRN2be0NhdTdhDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyglTLZwqPWfgjdCpvE0RsX/uduvWMSlB+qVuDIVpuWAH1kUpNE
	5eOdUUrP0nadd9P0uaZyQxOX0WXAlX4XZK11tFRv8ttkqoBORGH9LJxrskVQHA==
X-Gm-Gg: ASbGnct/QPSWX1kRA2Y6f08Qwy24/LW8MOB+34mVvhTxs4kfg6q9GfB1xwHI42q30cj
	K+Oqib6ljX8UeihH4r7KJB0F8xTuF59kJFEEf3R6FIGG86pz6XXM0FyCK5LhprQf1P1iJNuaq2D
	85fj14oQ8G+b/uHMROr3crQZyMvArACy119p169pHGCG9MIZ+1gfhZn3voGNov1pxxD89wJ4hC3
	SgkgPH8UliSRqdsCeozYaTifaLNl91+kY6P+GXKCgNh89JP/Zs=
X-Google-Smtp-Source: AGHT+IEa+pstb4Wkj/s5QGwreQlq92o1CyOpFbpUwW+Li/Drfu8YVwkRT28VxYrjRnk6Wfqm7BaqWQ==
X-Received: by 2002:a05:620a:31aa:b0:7b6:eab3:cdd2 with SMTP id af79cd13be357-7b9ba881fc0mr8162968085a.56.1736040234616;
        Sat, 04 Jan 2025 17:23:54 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac30d4b9sm1389176485a.57.2025.01.04.17.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 17:23:54 -0800 (PST)
Date: Sat, 04 Jan 2025 20:23:53 -0500
Message-ID: <1372f9de0bb265a08114a870ec086da0@paul-moore.com>
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
Subject: Re: [PATCH v3 18/23] landlock: Log scoped denials
References: <20241122143353.59367-19-mic@digikod.net>
In-Reply-To: <20241122143353.59367-19-mic@digikod.net>

On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Add audit support for unix_stream_connect, unix_may_send, task_kill, and
> file_send_sigiotask hooks.
> 
> Audit event sample:
> 
>   type=LL_DENY [...]: domain=195ba459b blockers=scope_abstract_unix_socket path=00666F6F

Similar to 17/23, I believe the SOCKADDR record should already capture
the socket address information.

It would also be nice to see an example record on a signal event.

> Cc: Günther Noack <gnoack@google.com>
> Cc: Tahera Fahimi <fahimitahera@gmail.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241122143353.59367-19-mic@digikod.net
> ---
> Changes since v1:
> - New patch.
> ---
>  security/landlock/audit.c |  8 ++++++
>  security/landlock/audit.h |  2 ++
>  security/landlock/task.c  | 58 ++++++++++++++++++++++++++++++++++++---
>  3 files changed, 64 insertions(+), 4 deletions(-)

--
paul-moore.com

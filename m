Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C506F305
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 01:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736040237; cv=none; b=n6yasX6A2/yPsXtx/u6CFM4cujwbBfQs7V+idp0M5B0euxMYqKOZ3SoBq+lOlRoUti5bGigka6qONOifDFVGWY9rCmCctyEWKUxslJALrwNf+FzY2iwv3W7J6AcdLtSSu2yJPJ1UWEuG4Hc3U7Nbpq1MrRmOPmFpqDSFKMu2jR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736040237; c=relaxed/simple;
	bh=/btT7n0d2ZHfop1mstfeCbgn8fQGxmS9KNdzrV2Bi94=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lYVFBnEbeMr/FPOGf8PBXhyv9rtn3YTiagd4inCn0n9X2Y84fqBPsqNCm2ZjCCLWcrcrGT+fmOp5swK/VGts8YVOGw4ZVSGsWF/S0e6+FgWMaX1POPK0R1YFE4BafBH4IJqqYKQyJ8qB138xRiU+Jqc40JPJ8CFgrCXV0AO8zGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GvgYGqlH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GvgYGqlH"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6eb531e13so686125585a.0
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 17:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736040233; x=1736645033; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oodCSrqLJ6/wV1EWtq/vcEze69LUP+43yNurMHOkC/o=;
        b=GvgYGqlH/rvxgULg/8rP5+4dRnkP5HEko5Kvlge17oaSgsoM9ZIkbbmLm/ITYrWLxg
         XqHfyErLJLeTdiYda9xZltV3lQbWrdUsaWaPZah8pCs7p460/74XPQ+/ySSSuJoqFJAL
         OZWbl7ak0sYn8idvoGRwCR+E23qEAToCP8oWaZ1H3mZ5J7e/PKOE6HVHcwGPQk9dzpRD
         gv/VXK7KGwVFzTpghm4wti1yGrUNYnA0KeuflF02bM2ItXSY6yuVmpHW19UFsC6W24Xy
         uDEj3kk0q8qvn0komBt0wSl4juyBz7mSPvUPheKwv3RfjWuMfClAZFtodgesLh7Vuqb3
         am7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736040233; x=1736645033;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oodCSrqLJ6/wV1EWtq/vcEze69LUP+43yNurMHOkC/o=;
        b=bS+bNmujY9bPLHnnh7WP0+fV80WMp0ZH4esEVusxkOcduYpNT9TCEXA8Ih/keaM64Z
         QMyhAjSotWZWqa3tE6jxh07xMSfelaaHA3Ecc6kiFXBSVhzfuU6JxVq0dbOIE5ZfBZXc
         ZY8xCIkKyYQDzp/lKBTAmfKc9pUkJpx77xXfnOuwTWUAucx/IguFPenJRHUxdMtu1dQo
         JMWZguPS+Aga+vhzSqpdSVb5jl8i4edEUb7ugNYKPm7EGFnNCMmObKze+kJ6k0tsdc+4
         1/4e166GiseMakAT/xBuaLKer7eJgjl6R7fJHvAdruTO7Q5x0Nz/zGnXYZ9nhCVlMfUi
         9K6g==
X-Forwarded-Encrypted: i=1; AJvYcCWHZV/kRc28RCloBQCUUmfQIpBKLtxsDoxRqVVxCcBrBHGw/Nzi3MlU+0OhLOa/cAz9qFb171MkQLYmBYHsBbbJy/IQVNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyy9pnCO5EDGNats5vQRxehl9tnfcHpk+O3emCB9upvXD0Kp9E
	0Xc9QffBq92O/+wD4732jbXiwCZGRtDtffNL48kGN0Q14MDcfZMgScNBTN0ynQ==
X-Gm-Gg: ASbGncvVJ/Nsm/FSqCLsurl+dU5o2jlarspF79D+z7Kd0DHRP+yWe5LnGtnrLgyfduJ
	pg9GbvuYJjosvGj5mykuaf8B2j0wZXssYhkEx0ippqYOFvOoL3oQjyaJUB8v27RDFVFRlcraxyJ
	Gzvkmlg+ejEbRv0r3G6iNBhzGVDNT6LXAf1m6Dx2GG9qJrX42OYeKrGMlwibLAmCvXSjys8etZr
	eifwxk8Z0FMwfJFMxfy8R82iHB+v5NRMhNZYUC0TRHJNDP9StY=
X-Google-Smtp-Source: AGHT+IGH4CFrIPXTbsb1KbkdD0mCjpfzWpvEGfeBYbIb7PKQ7U7KdTUnGjDro4NTziohWutc9MBYew==
X-Received: by 2002:a05:620a:3915:b0:7b6:dd82:ac9c with SMTP id af79cd13be357-7b9ba6ef8a0mr9033023885a.12.1736040233637;
        Sat, 04 Jan 2025 17:23:53 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac47a354sm1390202485a.70.2025.01.04.17.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 17:23:53 -0800 (PST)
Date: Sat, 04 Jan 2025 20:23:52 -0500
Message-ID: <0055bef6843289ac8dc728a68326513d@paul-moore.com>
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
Subject: Re: [PATCH v3 17/23] landlock: Log TCP bind and connect denials
References: <20241122143353.59367-18-mic@digikod.net>
In-Reply-To: <20241122143353.59367-18-mic@digikod.net>

On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Add audit support to socket_bind and socket_connect hooks.
> 
> Audit event sample:
> 
>   type=LL_DENY [...]: domain=195ba459b blockers=net_connect_tcp daddr=127.0.0.1 dest=80

The destination address and port is already captured in the SOCKADDR
record for bind() and connect(), please don't duplicate it here.

> Cc: Günther Noack <gnoack@google.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241122143353.59367-18-mic@digikod.net
> ---
> Changes since v2:
> - Remove potentially superfluous IPv6 saddr log, spotted by Francis
>   Laniel.
> - Cosmetic improvements.
> ---
>  security/landlock/audit.c | 12 +++++++++
>  security/landlock/audit.h |  1 +
>  security/landlock/net.c   | 51 ++++++++++++++++++++++++++++++++++++---
>  3 files changed, 60 insertions(+), 4 deletions(-)

--
paul-moore.com

Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9A43165
	for <linux-security-module@vger.kernel.org>; Thu, 22 Aug 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724360339; cv=none; b=lYrzpT6yPZIX+alpiNe9On8P9v6zqfYHIGnS8H8jEUoj3FlgHVp9s8c0I4WU5ta6lVZlcbX2ywHHMsyTdcn4UHqWEjcw0AQGv2tKR/DXClPoCd9ZJsq5FVHuioV7LHbIRLlB5/zFknfTld1RpEKcr3Auci2Ih97oPSjtVX2/Gzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724360339; c=relaxed/simple;
	bh=dEwsnfjXIyI6z712CyPIkoA/TgzpBgSIgyyAUGvh91Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9w0mw1OnfXD163z83vJKo5aa9XSPlYfd0pMI9y2+a2vOcf1aE6IJnEXNQ52mPYAHD+c3nepj7uzECdL8VW0r+8340q8YkE+HL1nbUwHVAbL/pR40hgXqIYWGR2atIy3wSruG12XWxk4CyHRgIlOIXDZKkbvsPXJ1w6Q8ACkeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LXHle41i; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LXHle41i"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso1271746276.1
        for <linux-security-module@vger.kernel.org>; Thu, 22 Aug 2024 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724360336; x=1724965136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8N8bN2ci9nm0ep6oCOlsfU0RlABxLI550Pt8fOG+QY=;
        b=LXHle41ip0UJJQzSEaH+kTddNAncFD9X2kbX08mVW4kF1wCoGJnjpN9BVo5CbfNoHn
         hcUlGvUXM8wW/maFWUBwpDbSOGdu804BOqzwEJNMY4/NE0f/lpWUrB1O8rxa8NdcHuxy
         JV14srjn+wj9if88SaIOWHFpmRpuJD3gtEMm6zWOTSxYpHTJ8/JddpNsTyqd43TSXt5y
         eKKQiTSyMdTfHTf9V8UKeNEcpkqUIjuuA0wdNNcz42tCm8IJKZBAN0kwOiX0bxSeroTL
         qCsDTjbN1PmfV88wZ5aSQIj1t39k93/JAlRVTh/w1X9BBHjmVD8mBhLsrVd2de9A58qa
         p25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724360336; x=1724965136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8N8bN2ci9nm0ep6oCOlsfU0RlABxLI550Pt8fOG+QY=;
        b=WGGP3nBHVJPsBfK+A6FyiDry6KC9TnReLj7hB0smklTCU7tr5bTijftLs/fECTbA/r
         PoJadX5uJV+RVYFiKnBpvcShApuXIiqJlaOgr5maW4bgvCPbuWitZnUWHqShI7DKzJMZ
         tFtzJhssXrrVT8TBcMlhDclODST9inh456FIPd+SXyQkziajiTSr5WM1VCpWhFEwujwN
         xv8sK6OqaXcsccg0I2nDlLHe9iWssIBE6NvdnySzd9dh6O43syFd8GX7LKvftCZDtuwp
         g90U3rFT2qZwVKmSmOKicOUN3w35ZVT/QlDiCmoReSg9+JDFmLJ62aHVt6fAilR6dwyr
         jsgw==
X-Forwarded-Encrypted: i=1; AJvYcCVDr4XMoYqE6DhJhV2Yjsf0ZB0Pqw4TvSJofllqp9YVHUoLmN3fF6Ht6MWuaFDWb5rdoCNwWHyc3OQwh6FVxI1Gi/S1/yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKY84fN4SyB00K77dGfw7sUMqLK58G4TuYrRDbMLg8t0x3js5L
	ETzN7GgI0rGnL2nKezcWtSJHfJSd2/FsPcVN6TJKNAesekvmf11+2oBYVPT8TCYPTAY9tTnGRgQ
	tF89RV2Q3OZie5+A9kR3ajMBJk7IVEdz5B35vUqs3pUeRjS4=
X-Google-Smtp-Source: AGHT+IFUzoqh5If8UewR14wwjbtLRahoz/yxEpbOFIRw01N1HKbimey3PkySJkjy03S76hs2Ti6RicZKOHQVJqmZkdI=
X-Received: by 2002:a05:6902:727:b0:e11:7fcf:40d with SMTP id
 3f1490d57ef6-e17a83d0b16mr274259276.16.1724360336240; Thu, 22 Aug 2024
 13:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822131542.785546-1-mjguzik@gmail.com>
In-Reply-To: <20240822131542.785546-1-mjguzik@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Aug 2024 16:58:45 -0400
Message-ID: <CAHC9VhRNMMtZ-_-sON_jz5_pkyFTyH5VOOVmPem=AbLpA5Y6dg@mail.gmail.com>
Subject: Re: [RESEND PATCH] cred: separate the refcount from frequently read fields
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 9:15=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> The refcount shares the cacheline with uid, gid and other frequently
> read fields.
>
> Said counter gest modified a lot (for example every time a file is
> closed or opened) in turn causing avoidable bounces when another thread
> tries to do permission checks. Said bouncing can be avoided without
> growing the struct by reordering the fields -- keyring (enabled by
> default) is comparatively rarely used and can suffer bouncing instead.
>
> An additional store is performed to clear the non_rcu flag. Since the
> flag is rarely set (a special case in the access(2) system call) and
> transitions at most once, it can get placed in a read-mostly area and is
> only conditionally written to.
>
> With this in place regular permission checks no longer bounce cachelines
> in face of refcount changes.
>
> Validated with a simple test where one thread opens and closes a file
> (dirtying creds twice), while another keeps re-reading *another* file in
> a loop (ops/s):
> before: 4353763
> after:  4742792 (+9%)
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>
> This is a resend with a reworded commit message and added Linus since he
> wrote the non_rcu thing.
>
> Note each process has its on creds, so this is not causing bounces
> globally.
>
> Even so, there is stuff I plan to do in the area and this patch can be
> considered prep (only one store to non_rcu).
>
> I'll also note I don't see a way to *whack* non_rcu either. :)
>
> 0 rush
>
>  fs/open.c            |  2 +-
>  include/linux/cred.h | 31 +++++++++++++++----------------
>  kernel/cred.c        |  6 +++---
>  3 files changed, 19 insertions(+), 20 deletions(-)

[NOTE: no comment on the patch context yet, just process comments below]

FWIW, I really haven't commented on these last couple of cred patches
mostly because I've been assuming someone else would emerge from the
shadows as the cred maintainer, or at least someone who felt strongly
enough about these changes would merge them.  Unfortunately, I worry
that isn't really going to happen and I'd hate for some of the cred
improvements to die on the lists.

If no one starts grabbing your cred patches I can start taking cred
patches as part of the LSM tree, I've done it a couple of times in the
past and Linus didn't seem to mind.

--=20
paul-moore.com

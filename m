Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328794A0904
	for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418518; cv=none; b=cH+bfVxmsvoV70vsTAqwDAHtqzqVEW92xeGf7/muXkc9kbJRQfG39GuniR741SiWw1B0i/yaNi58Zm/rgjuJEBrYU2fhOHFUeaYrJhlBi8F5iVsz8naqQSSl1UoeGqQYla8GNIzug5p4qXpBjnTu2YDioYJzDi2A6JYZOzvt630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418518; c=relaxed/simple;
	bh=7lTv3k07zA7RFFF2IudlduRWQ6nXWPTkRfXfmwqrpmg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=WUUrUhHSK2zADG/CyM9FvLJgY0VI3RfXOWq0Y0+1L4zajc5LHVdmrvFab1/8gFOgMrfRSBZapF5j/zutqqeKuUDhw2NZ4AUxHLFO3SRuNOevPjXDqQh3awI3IunwNqdA4DjC+dq28o0alinf8LNkaEOzibUnvN6WHf+ykjWBB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SEF5ugga; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SEF5ugga"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90ceab90152so35765716d6.0
        for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 13:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789418513; x=1790023313; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=duuPvdB4qaHPpjjbBizZlT/PQ2qkQWx6bSPOOeU9NRQ=;
        b=SEF5uggay4dlMAl2tPfntHb/aTTPGNwMmCpQFP9rIrryHgaD9+ElcAjxeQeSlL0wWB
         FHwUilZr0oeZ0/3tHgRUypLNsyBQxCZqIoE3FyTrv5LigFRVsXrLoA326XyHGSXWq8+9
         bIyqu3Cv0iD0gFra2rJom0neFV65HWZtehniWcLOBV94Z5FM98Ratkge6pgUXbAvSoCF
         Y1D59GV+/EOd5G9Q6YuKZtFg3ft4mAkXeWB5bi7L8k0JQ+F4hwV1xbnBh+JWpKLg0Glj
         0Bf3GJhDJmXL+AjMo/CnNCG5Jif8SlnrCcn+fOQuoKaIZBRwpEfLbL03JljI5vey+N+L
         MM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789418513; x=1790023313;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duuPvdB4qaHPpjjbBizZlT/PQ2qkQWx6bSPOOeU9NRQ=;
        b=nz8aisYq9SPaCPY6NKAj7eAEvs64uoT6+lPcC++6+z91N0zbhWrA0w2ns1rnQQkYZ9
         wAkNX6kDupAPUCHemBMj0/g061A5G6nYXGIOEkXIIOz0kMbjtpYO/Ee0dadq97HiPJwJ
         iiD7Hd1Bzb4Z/RAY0+ibO/ZLXIYv7O28zYdG8V2ggTHzo2P6Qla+Au/kCAnG/LMy16aS
         ftJDPgnvDqBphp65XwEaxEs0ltdZLq+8Twqe9jMv2SlUDLeuoBQRKwmyzSYgTk9cXPCU
         EFPXGGhQ+IhTq4y+YFXazvZYxjiH32ekHEXHl5FZlUb0ywngssQyPRxiafysHOvX+Nn6
         Qw3A==
X-Forwarded-Encrypted: i=1; AKwUvBztyXKOIhpjjETp7RRIeWnILDMvj7y+Dw8EKM58aT+8lpNteOVGuQ8VtPaA3tcKg83ihVyZ2YdmmS6Nrb0CmuRyeU71AW4=@vger.kernel.org
X-Gm-Message-State: AFuF++mJV+tWh9qhL6tioSvz86A+cdO3tS3tyRNwaqfiVTb6AHz6lDKZ
	qGr82cCM1GW5WAG3nYSEDrUWWvCBXBX/HIxMLpCr2HWDCGQbXvF7ECjrhjP3TERrCA==
X-Gm-Gg: AYBFou0rcGBcBJIYXL4inqEz5qmFCpzNHNvsa4/6Sr4V5BsgpFOEO4c4vqCjBUMxdV8
	agVQJmb/5yqliIlXVpzK9ZdH63o9pnFvw0567Bcr99uaNTfXCYUziv3LjBujdrv8gAlG6w3omfC
	qn25IUg85cFmYRBr7GEZj4rwil8Xl1DdyWRHCmVIdEiH3FVhmVU4cI1F74Sp/pQjzvABS3MFWll
	KjSL1/lOXC1dkPZnJHSyMgR4xwJk8BXBHcyAXsm90fd/ofhUlEOJTAZWdw2DiYpYALh6WPV5qSU
	UmdfDqR9QqybooWKNo/WNeeAfvwB9Vu6kE0R72N5Cj/qvoAXELe7jF0EZ8Act8JBa43Ep9FWTc6
	cloEZLVQoR5mEPwx8B1CnJj5XuvI8Vqi3REVm7MGhnPVS7Ohg8ew6jeqSHZOe3Efn4UR+rQzbkE
	GPisB92lBFjlbZK4ZC8iRjdBoANITgXwROvzEBwLGfXx/1o6R/CQb/I3L4JnT/ynM36w6fLXywF
	LrEnLLw8mstWBKfN3O/Q6HiLhdfMj+Uu2PESFgSK9GCOPugTS7PuWOw1PIkd/a4PNAxTNPn2b4N
X-Received: by 2002:a05:620a:2707:b0:939:bd4e:b2fe with SMTP id af79cd13be357-93a29a12d15mr593158585a.40.1789418513279;
        Mon, 14 Sep 2026 13:41:53 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ebda519bsm1046663585a.26.2026.09.14.13.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:41:52 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:41:52 -0400
Message-ID: <506803b6b6c4a74551bc5c0d6e31cf71@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260914_1619/pstg-lib:20260914_1251/pstg-pwork:20260914_1619
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, audit@vger.kernel.org, kernel-team@cloudflare.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v1 2/2] selftests/landlock: Check full ioctl commands in  audit records
References: <20260910144837.381855-3-mic@digikod.net>
In-Reply-To: <20260910144837.381855-3-mic@digikod.net>

On Sep 10, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> The ioctl audit test uses FIONREAD, whose command value fits in 16 bits.
> It therefore cannot detect truncation of encoded direction and size
> bits.
> 
> Use an architecture-independent unknown command with set upper bits and
> require its complete value in the audit record.  Landlock rejects the
> command before the device handles it, and the existing ioctl enforcement
> test already exercises the same request.  The new expectation fails with
> ioctlcmd=0xfeee on an unfixed kernel and passes with ioctlcmd=0xc00ffeee
> after the shared audit field is widened.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Reviewed-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com

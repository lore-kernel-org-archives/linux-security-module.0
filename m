Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4813227FD5B
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764236181; cv=none; b=dU7WKV5NXNeF6w3Y2yatd1OxCCY9/EMjA90f4yyH/++b2hZ7kz5eAAkm2IhAxT4J34ApENOVf/gud46DpdHi4KPNVBnGI8l4SuqaANCvcyqd5nnmms1MBZRAfzjaXCe70GulPSiEXiwoNvRWOGgNYbd7Ss9iBmooKC0AbJEjJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764236181; c=relaxed/simple;
	bh=nt5Lq9dNg6O98njD9LAXQdeorFK8f64G15L2mplLE6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLf6ujKRJou8PC5qZAQyETwDCkOKLD+bZCSL/zcJDPebyPDsKlm8GDNW9f94Q+FiOyFdEmrR2JzRKZxWUmeOvhLEeYYHQ0PW/I2vNOgfm5MxMuzk7QVevnJZCqHdjz1FU/tiVW/808vXHUHBeLQGf96h/MRBPpROTKpP3YcHpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ff9Y1y8b; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ff9Y1y8b"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so3309185e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 01:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764236178; x=1764840978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oaOSw13buAziHGBSbWm0hNO3x8fQlL/p2Y3bQwqoOJ0=;
        b=ff9Y1y8bCIJdX6HUZQoOqLhPzRSudamX2A7wtVck+m5OBh6wHlBdAFuZqc1bhbK63g
         tRM/LKqqcf65Sh5x+M3mbyAlMgfKaiD4UcnnG1qkNKqVS3DF82dsvvhkHQRfa5GcqWQF
         uPF9lxUnW32PGR06jgwPjfH8mR4YvKCDeDTkWOYG/VPmEmFg7OSZabMAW1ir8fR0WkLC
         KxfjxBrzpbX6F6VGAyRSGgK4lzPIR1U8o/DnHuVbMRrRCGEVwTTp8jeSuY+bzuSse4AW
         py3tZeJJatstQiZEHVQoOahktry9DgRnnk2GiiLEIxbla/nh5vx9o/f69VOJhwRLsgYA
         6GmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764236178; x=1764840978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaOSw13buAziHGBSbWm0hNO3x8fQlL/p2Y3bQwqoOJ0=;
        b=L/WcendUG7K1qCguoXy9ZUwx5q+um8A+StpCz6c9EgWZzMbO6135FqyUNNgoEV9lJD
         juXUsP+7eS+v/n+bgLNS4YuXSlSlv27CaB8o2A1BQB6khja/lI9c7ebU/EOahxLrOYwx
         E7jpLsHt0Yg+pcyt2oxbarZVuz2Olr18YcEGM8aCNezxQzTzEaVzLl5RcZsusozrQ7aW
         OZov8rzP/dRESffqPbJFTu6itpABfmQhYvx40m/sqjywk6fI+H/1bMa0eZ55Jr0dbOZ7
         z+M3Zxod94civERfcZIl8Y9CISTJCYPEsdVeHXBirOK3LT61pFp1uf82MxgIqSc+1DtV
         Z5kg==
X-Forwarded-Encrypted: i=1; AJvYcCWSbbCWSagJ9uT4gWel57dBs77k8nkCqVdEmdEmP7Vj5nN8JVqMCHA4x42IFcKdT8mLwODzvSS5dG+S8h/UbxgS/00HUr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA7Sk9WfJ/LryilUjfm5zU7vifQrPiXSKwbh7vNLpzMKvhJhk+
	0vlaEOPZvC8uLWjq46PGmzUjutHM4iCiz50jTZOOshgaXgirWUWfjWNnh8s9/3x0gA==
X-Gm-Gg: ASbGncsH8hTOHrO/pTNvVn5gPKUipWiWvr7gZoXL4LjVYff5wP0bzmLyJRvh8kkV1BL
	SRCsoBYibVunhYXCtUv4TVwTWNVQTSt3vg6Dcl0qS/13/3TOwSQWIxQ8CQuPc5BL36bMdExblcs
	UYqzE04FZc8IrA+UQ8QDr6r46W8XjBAelL75lY5BAeNrVsd2rvW+gwdWoOQGp3N3WwRlQ2Up9J5
	ckng/NTslIaZI8rSldSnRXfMdO8QFxzuum5s2ZJrTGJwIcK05eouFFW6iLyYwM8Wgpv/tdhg1Uc
	KxCRB2R+lw2TmFNdcZhkfGULSHop7Zz/p4mrEC55klRUe2AeiUwtcSlHhE6ZqkyTSy8Jq7RuAnr
	aLCYAXWzADJ6MCgDxuPZk/pd/c15TZq9m0zrM7ySWmtm6hlHK33AcHUQy30quJCETF8JzWnAlkn
	Rl9sHaJ9BztkORGTALjyVZ+kLi3GwehXEqjBitoWCoPQ==
X-Google-Smtp-Source: AGHT+IHlq2MHf2HXyagT2tm3H/TTjkZAWV4H74CimZYBZSS+4uuIZh7Jl/omzs/W+OzsZirkuIYQkA==
X-Received: by 2002:a05:6000:2506:b0:429:b525:6dc2 with SMTP id ffacd0b85a97d-42e0f213901mr10066710f8f.17.1764236178357;
        Thu, 27 Nov 2025 01:36:18 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:2372:89e8:ec59:7515])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a303sm2424722f8f.27.2025.11.27.01.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:36:17 -0800 (PST)
Date: Thu, 27 Nov 2025 10:36:12 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Jann Horn <jannh@google.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Tingmao Wang <m@maowtm.org>, Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <aSgbjOl6reyLNRMG@google.com>
References: <20251001111807.18902-1-gnoack@google.com>
 <20251001111807.18902-2-gnoack@google.com>
 <20251020.fohbo6Iecahz@digikod.net>
 <CAG48ez3MxN524ge_sZeTwL0FEDASaSTb-gm1vPO8UwpijTeHqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3MxN524ge_sZeTwL0FEDASaSTb-gm1vPO8UwpijTeHqw@mail.gmail.com>

On Fri, Oct 24, 2025 at 11:29:51PM +0200, Jann Horn wrote:
> On Mon, Oct 20, 2025 at 10:12 PM Mickaël Salaün <mic@digikod.net> wrote:
> > Is it safe to prevent inconsistencies wrt execve?  seccomp uses
> > cred_guard_mutex (new code should probably use exec_update_lock), why
> > should Landlock not do the same?
> 
> We don't have to worry about interactions with execve because, unlike
> seccomp, we don't directly change properties of another running
> thread; we ask other threads to change their credentials _themselves_.
> From a locking context, restrict_one_thread() essentially runs in the
> same kind of context as a syscall, and doesn't need any more locking
> than the existing landlock_restrict_self().
> 
> > Why shouldn't we lock sighand as well?
> 
> seccomp uses siglock for the following reasons:
> 
> 1. to protect against concurrent access to one thread's seccomp filter
> information from multiple threads; we don't do anything like that
> 2. to protect the for_each_thread() loop; we use RCU for that (we
> could also use siglock but there's no reason to do that, and RCU is
> more lightweight than the siglock which requires disabling interrupts)
> 3. to ensure that threads' seccomp states don't change between its two
> loops over other threads (seccomp_can_sync_threads() and
> seccomp_sync_threads()); we don't do anything like that

Thanks for digging this up! I used a (reworded) variant of these three
points to document the locking rationale in the code.

—Günther

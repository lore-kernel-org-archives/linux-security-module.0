Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4122545D9A
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921818; cv=pass; b=GY8tsiClDSuM8QQ/iJP9lD5gw2QLPSnabwMICAuplU+XJMPfLp44WCg5WuC1OopEPDFvrZZ4m5ZJ6DGAmntnv5fbnZE77m+dDW9ih+p40/99pOZkK3hx2ynofBuO5pJb+39NJ1Z/zKXwgak1noTKNzYCJI+1QbUQIIJpd4EE/Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921818; c=relaxed/simple;
	bh=wXw6JHPaoi8GZR7MHv9SvzkiwDSQOxjrJsI9ZNtm4ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGo3HwJy2qA8eu6U6yptY0GD+o1GrC7Hs3gKuE7SYq6wHUi9aLz3OomRfOAt/73i1dnLqovAfKJE1s7iVch/9T3FCc+Bt7E005icNJB5tRhGDp9oDnPAjTMMbnrIpqsJ+higr24kqEnnRonqhS3di+lj69MqEFTqUCGTPueVYTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=H68qEmmv; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="H68qEmmv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e61ac64ec3so29320115ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 13:03:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791921816; cv=none;
        d=google.com; s=arc-20260327;
        b=LKMVgFiLLpDrgp8uc9cIMVhBrz2BhaRuIMSwu/3uMNaYKJEPN5TUVZxqVRmXAM/gqS
         OpCjHPD0nbQHwNl7S8oFYUWlEQ3BmgyXDfFIHqy4ik49p0FWwL9d8ib18gl4BN+Pna1w
         kycczK2V9NHaXH7mJbsvNBhkxXylvTyUtJxOneZOVvQRylDH/TajNUCMcUE0iHmhnniY
         JSRqlWw0th6RIZpYqjJiw6kb0hcUPAV69kjWmoQqz3PeoYbqxy0rmAFvU2hIjPRXn+q8
         OFn0uIDJ8BiXEGkhRJ9r9sXhHCulq+ktMJv6TSQUUqJ9le4r9tDgu7gf6B0f5IhVn1hO
         rdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xFuEyDlYHgdcnxzN9A5B3Rxn2gC4ba2X8EOvUAd6hpo=;
        fh=2TujbhTr2kX6H32Kw/DLkFCAmEoYEzZfPkkf9Jn97Io=;
        b=oSKzAaY7tIFNZGuIIgQz8Omk6+xF/zVJmfjWZegIRG0kYUZzmZhnQXDOuiUTJIgChL
         oNV5rpbuGSRuS4CSHxLIggykHpG0f4n/VdgZ2+AU4kSQvcwyU1Brk/sxo79kffwYTrvg
         mpmyBIASZuo1cgML8uUua918uUfUSZgGTa6s6YtX447ecxhKEvW1ty+85Ou9sPz9zUd0
         arEtybXrHYcz6ezV7xB/v6PlhFs/cRAzzvhm3ffdHhkc40hQAIkwVOGSGLkgLhRVRHBD
         97epleJw+ZrT5ywU9K52r+hltYBpV+MZpBzGoCX31cT7B+/OGh0r6AdidVq3BXkHL6n2
         uoWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1791921816; x=1792526616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xFuEyDlYHgdcnxzN9A5B3Rxn2gC4ba2X8EOvUAd6hpo=;
        b=H68qEmmvpyeJu6G2IWTpJv5xkJLsQricUPc9Ou+f/mdzwVgurR7CgIAJqefXR/HWFv
         1GS6S2kbzYndfoUwgdNO4oJqEoYcUms6HZZcjVlz2bWIM/kimLfd+ATGU5DAfy8WxRe0
         ZRy8vvW/qw9GD1Mu4nE7HduUirNj0eQvIxchf7dVa578VTNPl0xAYNJpuVFgzcTwdtvq
         7Q0tXKG2IOdDJdTxBM9H/3ZoE0N1z7XLxBg4OGLAcwkybTiStZ5KCDQ+LL92UPIHK6qG
         x6fAHnX0GMekyGe3F4od7NOlepDoTGBP8nKq2XuoV032TaxxzAX5u9Q0tgqsNfVa0r3O
         HFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791921816; x=1792526616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFuEyDlYHgdcnxzN9A5B3Rxn2gC4ba2X8EOvUAd6hpo=;
        b=oV+UPRU8LA2jWUsHq6wkAfgPlR05SXSqLiksCbjtGTaWCSUiMcMaMI0uPqeFcYz87w
         N5I5VIxDK8jUgoyD/xziY0we3WL8wpV1mJfR8cMmNe81xWqpfiexFYWZFHhytHaOJY3r
         hzxIknYYWFywoXIHWrGvyDTbiQ9hmPf07p/S1mww6EEsNJwNwkGLAasynOlsOTUw8QEt
         ICxE7XTm8KhR6ALSGsRCunp/l8nwMUBxpn1dp/XO0ZZFYomjm29QAnUAaYrUNx938r6C
         H0ZBdbRFFVEeG0snmSBlrcNx05F+Q5BfwFeEchzbCgFg70BYE9HqWQuHz8H0zyRFJJuv
         no5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxHnvfqUKodQI0YMvXOuWNBDcTsSMWYzaK+fbMKC8fg4RjGlKHIJyq6TPip42rJO8KcyB3LYPw/+9xysyATFDJnvJWoKJw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZdrBOPlXanit73ptXi1cJ+FhgYuwCOwn04gwPIy0IgVIo+636
	XIO4Hg7eEdRmKH3z5+lP3AejaoVhWv8icX+u3A9vY/4XtJxPedyj68klcrxmHoBvoOk5Y7P0yqr
	zW0TMx9zrFSN1XYFKB43IDUfINvhEtAF3MQlay4m/
X-Gm-Gg: AYBFou0LZU2hCpWAhMsdsl1L8Ea7BF1RXCN5QFIyzfZBWYCe/vVZ2c9xlTWHQNfwjjM
	17WTrTQS1y/LmRP94BM+UkWQLlSNjQbHUXPJmUFkLj8cbYpq5qmqGpUZr1mKMOLJaDQVQTMDUBA
	JIemenxyJS2r7GanmEKs7DNWoAOybfa8j/XMB3xosObTXyCLg958JP+EXzdFg3M62YxPyUpaKv7
	q5lz+4DlLvZQyQ7m1T/WaScLA3HCxz8XTLDSrxmFPZjdCRsl/0XqHnId3p1dz4rPhp+59Ojpxli
	YjK4qW0zXgF+n54qBGxjk7UDX8XqyrJ/VS84sBTbAAHqghYbAbQYxU/D61GSdDKDj3PsozBGHt1
	Kheho531KVa0=
X-Received: by 2002:a17:90b:5886:b0:3ab:be66:ddc8 with SMTP id
 98e67ed59e1d1-3abbe66dfdfmr8069651a91.14.1791921816217; Tue, 13 Oct 2026
 13:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179138670045.80227.16155454353416856947@gmail.com> <179188620452.191181.12068195457732970673.git-patchwork-notify@kernel.org>
In-Reply-To: <179188620452.191181.12068195457732970673.git-patchwork-notify@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Oct 2026 16:03:23 -0400
X-Gm-Features: AclHuK-x8Auj0GJS-cFhNW52kGpl3z0EMRffxOk8nEUcDwL-EM60rfxC-vuurWA
Message-ID: <CAHC9VhQuBJQmwZDmK+rKFUcfsRkBBjTEP0yGeoTjn-V1qaaLHw@mail.gmail.com>
Subject: Re: [PATCH net-next] calipso: hash the cache key, not the option
 start, in calipso_cache_add()
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 6:10=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
>
> On Wed, 07 Oct 2026 12:25:00 -0300 you wrote:
> > calipso_cache_add() stores calipso_ptr + 2 as the cache key, but
> > computes entry->hash over calipso_ptr, i.e. starting two bytes earlier
> > at the option type and length.  calipso_opt_getattr() looks entries up
> > with calipso_cache_check(calipso + 2, calipso[1], ...), which hashes th=
e
> > key itself.
> >
> > The two hashes only match on a jhash collision, so the CALIPSO label
> > cache never hits and every labelled packet takes the full DOI lookup an=
d
> > category conversion path.  The memcmp() on the key keeps lookups
> > correct, so this is a performance bug only.
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next] calipso: hash the cache key, not the option start, in cali=
pso_cache_add()
>     https://git.kernel.org/netdev/net-next/c/d538cc3ec0bc
>
> You are awesome, thank you!

My apologies, travel last week for LPC and LSS-EU has me a bit behind,
but this patch looks good to me.  Thanks for identifying the problem
and providing a fix!

Likely too late, but for the sake of posterity ...

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

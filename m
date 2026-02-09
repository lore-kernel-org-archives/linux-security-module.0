Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7336657E
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632528; cv=none; b=FN0Fkphs4nisheIs9Hofwlj9/Q7rOJ01GrNDNPm1eol5yiWV3cP3ux8TFJboH2u2BjgCUNlxb8zuuQJ+1mYOybWLa42/24UxShSCdVItWYHOHfo/LOA4r0eXG+o8VcEJmKzzZ5VG16CQKvwb51/WTmXzzByDIIAleskzSv6tSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632528; c=relaxed/simple;
	bh=N/IJ2YhBVRuUBX2vGlG8H7nT9U7UFqA3Y0xSF4QOEa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zyw6EDoFEc4eSKTYQrAakIDQwdOEKSFSTZ3aAveqX0MUTY1+Wrw1ACObhxjYRkwTHCgf5EFNkphH/SIY5JTaFrKZhKjDxnPQVMUlmJTU1JGP20LD3aR8kYlXthn/O7Bv3G3y8XXrjbEc3EfZorIeFuoGBFgu3YTquE7ZwR2muy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0XEbI47; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0XEbI47"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483487335c2so961045e9.2
        for <linux-security-module@vger.kernel.org>; Mon, 09 Feb 2026 02:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770632526; x=1771237326; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8s8+jDHB5/f0Kr0A+HA1lYqLhHagDgFiiZqavCArg+M=;
        b=b0XEbI47itrWfbtN72ZiykXIRvllOZPYcYKRp5HY9cuMYGDmOhFnYvCHqYdrG8xC46
         gZNuyUTLNyAKdx6an7McXsgjfQEU+Yn5QW26H8DxeP+017SxPGGCpMnKabyb/22z8C6d
         ND1mNWbhcGtMZb+sADiJamYGhtx8sNgy6C9A+JW9JOq9H5TjRMHMvblFrjqZzywEb/3h
         FNR296G/2yv22EQR0mNKS5bpnkRhYxYlbnJ8zRPLEv2XoS87gSINfLu2OA/GXaqT2a4t
         kWceENacSBe7zfNzORJqAJHulilCfvEMs+LkONy5UL9nKZaoOjmm+AXUL6GPnNVMJebR
         K+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770632526; x=1771237326;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8s8+jDHB5/f0Kr0A+HA1lYqLhHagDgFiiZqavCArg+M=;
        b=VswMakJltxd+j4+oHiMUJfdytCp5ZKjmfoDA5pNqB5TNvjSPB8/gkTPAoE9W3BjB4E
         3KZmtgdCF4ypkcbhu5IEHwXIMgYe0ETm3vSr/vQ934ZwAFdQgii4i1Jzo1RYuEtGYpTf
         V9gPx5ywHZDdTivUPCWATYfo8BlFt9ENtgWCLeRXgp8JLV3+1nckU1zuVVkpNrCOw2E4
         B2MbGln8RiSkM1pPcbArlul62dVTNJROTkkDLyj0BlMHd5EAS5DlO/hCQPmrZxEGFaX9
         niPw2kwX3Ypb/oKW2A2F1bRIVaTs3c6BbgvTmM82kAERkKYJC/nauxZkQJrqDvH0IYfs
         v4hg==
X-Forwarded-Encrypted: i=1; AJvYcCX83RL1Y4y+LJ8sKs10suD5BIsrPBjA5sv/qcw5KOgkSL8zRHSxgQSkZY0clstw0I8eiefQ1+oRXgN6XtExfwbh+P55wIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMZUqVOYIURqoKFaaZg5GRU9tCJVQe30OUTfTXDyEZj4NBZFgD
	90EmgyVcr8gzCMNgR4g7HCQMYQOQh3FWUhTHfu+E9hK2YvTndGIiEKsJXdPIadi6rg==
X-Gm-Gg: AZuq6aIHjFoVz54VW3NFEjbzawvTRDuKqbICv/wIJOuWW7Sp/2zYJqAYAi49fXwxRK0
	UmrOnRv8wtw//epIyvB9rMJUjYTFHGPoyquvlJXTqldNlK+S4zI2L9nLmoTnUN5r4gtmBmHrQnQ
	hYNF5cAzt6FfQcY8rLUBAUQ4ibirWS/WOTUqCLOQlt0z/FBxewZUH7oMRPEhcTqWxfs5mB5t3RS
	sG5mjvPFj3EQ2DPnQgG8ZAA9sorQqHl3eua/quLuttEwJ4wvDXPdf+XlakvpCkFSyJiffAoHZDc
	W42y/svVOE144/qg4gk6zLXtDk7JtywAlydzKBUyA9VSwYQAlzIa9oLmzApIT1MnCw28Yvg0EJK
	7s/j+jYsFj6Vo69y57Urt3tdQ1lAW2CRfzTcBt/uQ6EQluMuGkoIP6ECxIziV9o7l+kM7pXVbwX
	Ze/EoPIVM3UHQjDcjncWynBFAMBO9lzLBT5s2FTkwU
X-Received: by 2002:a05:600c:8207:b0:480:4d39:84b3 with SMTP id 5b1f17b1804b1-48320928e6emr139665015e9.6.1770632525984;
        Mon, 09 Feb 2026 02:22:05 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:4691:a1a:ffd3:5695])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376accfc0bsm11101819f8f.32.2026.02.09.02.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:22:05 -0800 (PST)
Date: Mon, 9 Feb 2026 11:21:57 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	John Johansen <john.johansen@canonical.com>,
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>,
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v4 2/6] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <aYm1RWtV6Af-zEHf@google.com>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
 <20260208231017.114343-3-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260208231017.114343-3-gnoack3000@gmail.com>

On Mon, Feb 09, 2026 at 12:10:12AM +0100, Günther Noack wrote:
> +static int hook_unix_find(const struct path *const path, struct sock *other,
> +			  int flags)
> +{
> +	const struct landlock_ruleset *dom_other;
> +	const struct landlock_cred_security *subject;
> +	struct layer_access_masks layer_masks;
> +	struct landlock_request request = {};
> +	static const struct access_masks fs_resolve_unix = {
> +		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	};
> +	int type = other->sk_type;
> +
> +	/* Lookup for the purpose of saving coredumps is OK. */
> +	if (flags & SOCK_COREDUMP)
> +		return 0;
> +
> +	/* Only stream, dgram and seqpacket sockets are restricted. */
> +	if (type != SOCK_STREAM && type != SOCK_DGRAM && type != SOCK_SEQPACKET)
> +		return 0;

FYI: This is a (highly speculative) safeguard, because these three
socket types are the only ones that exist in AF_UNIX (compare unix(7),
2nd paragraph).

In the (highly unlikely) case that someone adds a fourth AF_UNIX
socket type, this means that Landlock will start permitting
connections to these sockets unconditionally.

I am unsure whether the safeguard is useful, or whether we should
rather group that (highly unlikely) future socket type together with
the existing ones.  *If you have opinions, I'd be interested.*

The fact that these are the only existing AF_UNIX socket types is also
the reason why it does not matter that we are now (in v4) taking the
type value from the server-side sk instead of the client socket.  The
check will either way always pass as long as only these three types
are the only ones.

For now (and probably for another few decades :)), as long as these
are the only AF_UNIX types, it does not make a difference though
whether the check is there or not.

—Günther

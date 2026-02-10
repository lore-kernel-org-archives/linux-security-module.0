Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45D2288CB
	for <linux-security-module@vger.kernel.org>; Tue, 10 Feb 2026 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770764994; cv=none; b=jV7GVVQkXHM8Jktx0p6aJ/a/1E3nLCKDnGnTwg+9NajBwXbxezZMtSwUCVsEtoyM9wRPfxdIEapEsYZhruIoFEc1+dzjgLPtVCdY/HdN4gto2ZSmtw+0WjO6jjQNW1OCTpX+k5d3t/b5c5/RRrdYGu3+c6xJ21Sj3aKIvm2tp8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770764994; c=relaxed/simple;
	bh=0wmQoR1QzyB7MIxd+0TeB82pi5/269FRU4xmbAb3RyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2mh8nOhG2Kb0oF2aVbzpl7SngBVa5I6TJ5C+tuBU9FVLJ09Rnf2THqIsZkX1unxmFTNUdQAbc2t4Ee70+qciBG0cMkHXYoRCaLQBNukLy+Y7mhV8Au8jbHxdzYGDdeJmli2wb2ObM9xdLeCSMCjKqGlHrDDYWTBn6mL4sGKnKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am7D+k39; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am7D+k39"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48327b8350dso39774735e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Feb 2026 15:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770764991; x=1771369791; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dq16FYZW+aWHRcwtq+Ad9IUgFjneG2Jlvs8geC49Ubo=;
        b=am7D+k39bkd4g2VJ30BzaB97kXWP7lTTW5jAWCijC8WEJe82PHNLXh2ulxoUH1Fnrl
         9I5nDizqvHpGjzkp1Au2Ig5/9mZFmtDV9IdT/g05MFK0dXM+o7WWpbBUGrE78rjg1xVS
         GGBmvYSvYeySU3S3smVjMq2T7HIGkMITW48LeUcbaqUBU62CxEsjQieNHB4iygH9EAPE
         4i1NsBXdZIRB9Z05uSyuOqXkecL/zwf34jKZ7qIZQzCgB9Y91l6hHs3IEQSJemaBAGx4
         rJ8dN+bfewVo14fz4Ii8HQ0I+cevx6ioyb8wje5QivMXSUK+sslN9UZlB+8p+r6DsVKs
         sB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770764991; x=1771369791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dq16FYZW+aWHRcwtq+Ad9IUgFjneG2Jlvs8geC49Ubo=;
        b=eJmgBzGxYkp8xAVVW0U5oYi6xpqSdbmLgwTHfWwS/JqGyANK0iEhkaLUi7sqqcrKrj
         ZTqrEBKk+8HcBFBxrzffkWQN5dky4fAYaycipovBdZ1HXHv35mWqXLoQA1rxIlG8yPYi
         2JbG6FV6Js2cjmPjwnTgwCoR7ZNhSVOTibygLTcWuqJtT9g7aluQTzzkghiG0G+xzAMm
         V7wEZjvdl5c0u3RVwxMl7Rb+Mbov3WD8g6x/wgA46eSbNDr5z6lkEhRhrSuxk5F5Vq6v
         XDseDjY8LjSVbeXUbxdxE4VFqpyxv0mTL+66hVys9rZ9s+3stv1bBxjORVFWqhOITvdp
         597g==
X-Forwarded-Encrypted: i=1; AJvYcCUq83V7lfSvMjl87cOamslRr2OqaIC0gHWfbXZ/rJSnZXhbzpma5aSkJo75eeUUjubD7iz29ZKxcBiX45o3r1NEoYaIt9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUfs74DhcVHQ6tlB7akygMTkSyrY4nGzrifhGhXuIBdOQHl6Xp
	OU+J8lSm8/D9lVhokHJgHhJTelRK1jpaWOpN/G51E8+ASbW1PpJtmqGi
X-Gm-Gg: AZuq6aJXpe1XATptvckkyCuM3MWKUpQ1ZWL7ShcQnpI8JcLwABswwPcm58k0l3UU2Gt
	q/XbjvIH8UZEc0K7kq+E+nPaS8FWLHshTYOQ1mnYCk6w6ePguup1pOaSwKaGJiI6JBkmuX/353x
	g67pTDAWoptBuqiCuAUD3iVSxT1gfrVtwMKrHwU4F/Ccs3WmLx42XCqMr9KoknP3Qa/AfmB8XHI
	4E16yi/+aeyA7mty0LMbRtGAJTlwSe04/8eXl9R+pemuF6xTs3n18u96Z0Etb2iy1dYC+zHxS17
	bUqizH8WPhyzjuVi/Jc7RV3YBDERK7/790INq5FHA/2Km1/0KEJFEyMrwAyHYwRSGzSLeMKJ01m
	7BIwaKLcapIbXfqzW+8B8fg90tl45ordVvZNo7Wowx2zUNYr+Y2ZFB5WGW6mJQBa0xmmAoLaZv3
	o/BQZw2TEYbDeE74NayVZ+/3wv8bfMDKn9FojtqnMqavpzjWoE
X-Received: by 2002:a05:600c:34d5:b0:480:426e:9d38 with SMTP id 5b1f17b1804b1-4835b938984mr7691475e9.27.1770764990863;
        Tue, 10 Feb 2026 15:09:50 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4afsm182128555e9.11.2026.02.10.15.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 15:09:50 -0800 (PST)
Date: Wed, 11 Feb 2026 00:09:49 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
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
Message-ID: <20260210.859f9d2dc55e@gnoack.org>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
 <20260208231017.114343-3-gnoack3000@gmail.com>
 <aYm1RWtV6Af-zEHf@google.com>
 <20260209.IWeigh1theik@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260209.IWeigh1theik@digikod.net>

On Mon, Feb 09, 2026 at 06:28:24PM +0100, Mickaël Salaün wrote:
> On Mon, Feb 09, 2026 at 11:21:57AM +0100, Günther Noack wrote:
> > On Mon, Feb 09, 2026 at 12:10:12AM +0100, Günther Noack wrote:
> > > +static int hook_unix_find(const struct path *const path, struct sock *other,
> > > +			  int flags)
> > > +{
> > > +	const struct landlock_ruleset *dom_other;
> > > +	const struct landlock_cred_security *subject;
> > > +	struct layer_access_masks layer_masks;
> > > +	struct landlock_request request = {};
> > > +	static const struct access_masks fs_resolve_unix = {
> > > +		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> > > +	};
> > > +	int type = other->sk_type;
> > > +
> > > +	/* Lookup for the purpose of saving coredumps is OK. */
> > > +	if (flags & SOCK_COREDUMP)
> > > +		return 0;
> > > +
> > > +	/* Only stream, dgram and seqpacket sockets are restricted. */
> > > +	if (type != SOCK_STREAM && type != SOCK_DGRAM && type != SOCK_SEQPACKET)
> > > +		return 0;
> >
> > [...]
>
> You can remove these type checks.  We're building Landlock access
> control wrt to the (moving) current state of Linux, and the goal is to
> cover most/useful access types that currently make sense.  Once access
> type is implemented, it should handle (by default) future features
> related to the kernel object to make sure a sandbox is well covered.
> This LANDLOCK_ACCESS_FS_RESOLVE_UNIX right is really about UNIX sockets
> that can be resolved through the filesystem, so this should handle
> current and potential future UNIX sockets as well.
> 
> If a new named UNIX socket type is created, Landlock should handle that
> with this access right, unless there is a specific semantic (e.g.
> coredump), in which case we'll update the access right, and potentially
> add a new one if it makes sense.
> 
> I was thinking about calling WARN_ON_ONCE() but this is not worth it.

Sounds good, removed the check for the next version.

The possibility of a new UNIX socket type seems anyway pretty
theoretical, and even if an additional type were added, it's not
entirely unthinkable that we would actually want to have it covered
under the same access right.

–Günther

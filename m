Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43F145A1F
	for <linux-security-module@vger.kernel.org>; Sat, 14 Mar 2026 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773522979; cv=none; b=YlvjTKbucOL8+ae/Sr75e8QTsuIl1Kp/vm+FyKekGVr13Qa+OXrO+dnmFKwjwjnairN/6V+9PbmOUYfwIR6ko4bhpYGM9n9pK5bW0MpsfDjz97RnA62y30TOwJCuhtPItxDbV4m2G/bnqkRb9P21htDf6XO0vGGgWpRnS3hxUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773522979; c=relaxed/simple;
	bh=Y3mCtxVqsop5AgnrR25QwUYnShmlhHeTbqPRzD1VzN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEGttSHF11I8XyPQrsUHoW/PkmGHcMs++qB/q6Jf608UF72d8A5B7mXNusUVVvEMudfBe358V7SJ1sPVHvXQeuySC1m8KVjKBOYsoeoRMwaXeLkMvLSlJwKb7uXu+rZsFemnpGRmEfeWSLnYPoFOYJIjz5Nl3CXiD7rmFhAEki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bln/Gr7L; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bln/Gr7L"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so3413423f8f.2
        for <linux-security-module@vger.kernel.org>; Sat, 14 Mar 2026 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773522977; x=1774127777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KAaxGaQisRANZTYU4205w8AqLdWP7K6YA+z2DrSW9fI=;
        b=bln/Gr7LH4V+8wXx/oVKQzKTbp3Zbl/4JbDryknDza7IWymdYr5KzMV5PnGOhFS5pt
         gs4S6jQ/sCdibLOOq9Zk978K8ihoRnp6FZz/Z63cuiRoPdXDkagy/tKM/Q4akbqa7KDO
         nV8Pd/l7ySFeYTYYBvdm3pQICk8Bv2zWOsS+sylEWQf0WHnCylkWsxP+dV+9OvEeuHvo
         WNCkWIjue6cIAkG2Tcu3kBAXSv+pkdrikZFq7r5L4NcGUTehxsfYqXRxhoMyYtKtQzWS
         Ld9YBojR9j5RJazbXad1TVkXq/E6WW4KAzqnwBf5eLPDL1qGa2eZXNvQ1FThyvQFFS+3
         ynng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773522977; x=1774127777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAaxGaQisRANZTYU4205w8AqLdWP7K6YA+z2DrSW9fI=;
        b=TKnHiMROc8SNvD+b8EOyYFxwNicfeVzMWLpmUzgusCqf5QFjl/kAYWVIWMwVJvQa/L
         zPjeXGzqd7HGBaVyTsCmqA24kCzyCBtxT95r20lkIIx1cPq2WasI+WcmR50qZL4oOrjp
         hu8FBJNBfya5EermfEeaMkX4xMo0yX0pS1KQMBi8cQCHmcUzuVE0YFg4wo0SUCVuukdx
         x76V1trNO/tTa9Ei7EIGlzgYKxrKSYyEj1v5SZqLhd4giihXqsYjrIVsdDMSPYbzsQCz
         2Qr1nwK9aPKnGuj/RYJzx1fSYTi0RAWK41G7dcMIHbFkB+1+s80GeTGagccs0QQ/pkdh
         4eOA==
X-Forwarded-Encrypted: i=1; AJvYcCWbvVjn4xErvpzUUB8/SPp4vYEQbuMcMgxP7Oxw9wIM83a0U12zA65Pt19IGngRJOPBgX2PIleIguCwPrBmbE4y9obNoHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBFT8g4Qc3fuFfHMbbUwWqFcJMjhreoOJSZePjQZvEw9p4bHq
	m5cFeQb3STy68oNeEPka7Q9KL6KJtJY058RK0wiB7dY2daHklodSpJ6h
X-Gm-Gg: ATEYQzxvLXG59B+FXVQd2GSaM+/gSzk5FZMDAAiZhGiz+fZ7OXJ3DYe5nY1yj+t2f1c
	87zTi+yC+leaN3LRM3hy9+ChKxBBUs/8u9NMLgPl7gw8iSVVWWnMHM5nB0xc83hhJtH3re5i4Ox
	8tyNdzJXMn9GJoEJBMGqJyO7VzleZ1FQdJmQmscKyOH/N8bSI17uJdShhETdRyxuCamR4s62FGH
	qmcMEjSVDQYwhX0Q9cfdhVqBkDdgfy12yvyqJ8aKlVDPgQ8uoECfklOuLRWnSe5OUd98CNsCBvt
	VLB3U+n2cWnrAVYI+X0qoCQGfcbPpuDhfmnu5eFD7NwTFQwcEiauODDubVlNcVR5b+kmLQraKOi
	wZ7cpvVNUkFJ5BZcWtx+4561xJSeNZpCgk9hQqQ1Y6OE8b6AvGl52TBBIMXWYYBeijo7KLjK2GQ
	O2RwZQgffIZ6zzzN47ZFmyDgYz5TUVGZd5HTAzuSuo5QxZt88G
X-Received: by 2002:a05:6000:2287:b0:439:b4c5:cef2 with SMTP id ffacd0b85a97d-43a04d866a8mr13842942f8f.24.1773522976498;
        Sat, 14 Mar 2026 14:16:16 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20bb90sm29918987f8f.19.2026.03.14.14.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 14:16:16 -0700 (PDT)
Date: Sat, 14 Mar 2026 22:16:14 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v5 8/9] landlock: Document FS access right for pathname
 UNIX sockets
Message-ID: <20260314.0250c4c23397@gnoack.org>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-9-gnoack3000@gmail.com>
 <20260218.AXoosuwo8aen@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218.AXoosuwo8aen@digikod.net>

On Wed, Feb 18, 2026 at 10:39:23AM +0100, Mickaël Salaün wrote:
> On Sun, Feb 15, 2026 at 11:51:56AM +0100, Günther Noack wrote:
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> > @@ -77,7 +77,8 @@ to be explicit about the denied-by-default access rights.
> >              LANDLOCK_ACCESS_FS_MAKE_SYM |
> >              LANDLOCK_ACCESS_FS_REFER |
> >              LANDLOCK_ACCESS_FS_TRUNCATE |
> > -            LANDLOCK_ACCESS_FS_IOCTL_DEV,
> > +            LANDLOCK_ACCESS_FS_IOCTL_DEV |
> > +            LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> >          .handled_access_net =
> >              LANDLOCK_ACCESS_NET_BIND_TCP |
> >              LANDLOCK_ACCESS_NET_CONNECT_TCP,
> > @@ -127,6 +128,12 @@ version, and only use the available subset of access rights:
> >          /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
> >          ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
> >                                   LANDLOCK_SCOPE_SIGNAL);
> > +        __attribute__((fallthrough));
> > +    case 7:
> > +        __attribute__((fallthrough));
> 
> I don't think the fallthrough attribute is needed here.  Same for the
> sample.

Thanks, done.


> > +    case 8:
> > +        /* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 8 */
> 
> ABI < 9

Good catch, done.

–Günther

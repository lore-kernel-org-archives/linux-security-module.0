Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6CF364951
	for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026279; cv=none; b=bUrlU0lStZD9NkYSdQNAlNkVt9+3wZh+4GFjINi0aYflBLvxZRd2xTxnW+dmzpMFCrOTFWDFs6c2dY9ipJGsg66osimeWN2rkk/dWRsEYfBZ3lqbe3Kv7a/sqx3L7R40Du/7DgurbbABurfzpRJp0EMRLCJpUCGk5EpYTUQwxog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026279; c=relaxed/simple;
	bh=xllOcR5BH45es7E1inNUV7zKooIzTzVSmSuoU+RuRGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lN/tPMwLZMy1j5HvetkocbYz07IOi79VdYqZzetzSpmidRqwtsaN8w17DUePYS7lFLPQUM5Bmj4foVrFTvKQ6T5+XjYZYgn+PqJx4km7WvmYABhVDZ+Lv1FCPiAnz8h9jVHznvCgOOv1VI/UlqPGHZwkK9TEIl5bUSx8PkQsKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YL8GJ4+6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YL8GJ4+6"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b41b545d9so2635166f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774026276; x=1774631076; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UDkIMBlvCm6NHVVAzpyR7sppm0kV2ooO7CHlWm0fQf8=;
        b=YL8GJ4+6HoJeibYviT6TapPe65vXuO9RlOqoW5nKOLcMnZl+A/IHhSKRG2WmQsAAPl
         jFlitLmsoI+qN1cC8rW8mjCcobAvBI1zJCyET2/WrfKUiVLBZy3mi1iKtvOBItK2xZ22
         c/giiwWwbyHmmlOIuT9fDJEUAQ4EsIRa06F9YT8hudnHYLMPC39Ye7S4jZwaomHHWOsT
         rAcAsrBsgSSMhtNTT8RXBPMM6tV3lzpJuDUGHbe3BTk6BRNiepari06wOMS4wXUeCAk2
         15vuzT31EH0LsPX1GFy6lsdJkArgoMawa4kA7ch4k24kBOHojG+XdaSUMdgRUQwF9yIB
         NhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774026276; x=1774631076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDkIMBlvCm6NHVVAzpyR7sppm0kV2ooO7CHlWm0fQf8=;
        b=r9Z3V+oJyLsipyRrkvMrnrjrJPeQ8zV8epXwmkdZUges9SzQ5ZsiqvN/695pk3n8Ps
         uGbllSahwThM3Wg2F0SwDMLc6I6pXlgGpqc0qjLwUp6ffEFDO2NPDTaNq7siKZZwusBs
         nmNoR6Z3T2guQM3KZLLF4ij+iKEkdFZDTMVTyOBwb4uhbOu5rjvjGnk0NkvLIOQ0RXAR
         19yEEnfIJbGA0Yfzk8Krr3eAZsDAHxRqzLQCAqPedSMvseYCS8FJ0zvUQdbLf9FloryJ
         nl9ltf+rpLGpGCJRgoHzu522+uDCodIcSESjbicx+bW76h+rnxZVPIXjRFGN/wcBbvci
         lXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyTw2U3swVV8OU1CbU/K15Mw07JU6WvJLPFaGlGBTWSXiFXEnLETtKWGx5jDxnpNdj1SXQdlu6wdci/gie6AIelRH4kdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAqQe0OwUGlItPb3qMjRqUHMK8vS3vDkE0WbSl6CbukIkp1Kr4
	c+lrmlqOb1jJIR6E7S90V7kq+6kqJV5WtBhnKOdBxtg9NJoNa2uHeQKn
X-Gm-Gg: ATEYQzwJlMOi5wpe2csDriBHiFozBGyLJnba/8IopHpqvgInKrvGLjW5ubLhmiS+Hua
	P8CU1dUpl/Rn5EzoZ7XHlrRhLMNDzFX1DbH+QOXiXyaAcvDKFMTCcNfLA6lEcTUSO/z1I1ONOnr
	IFRX4FVvjEqd3JLzuS9ekz7XccSSafzl4VG+UDhlvsHcJB0R8oDai1PgLVpkHtlOp8iOGX3PJsM
	04EprNBS9Q+2YOSJqmP9DKs9f4BDm9E9eKiYrs1g6UuCrgRWDGFZrmevPoXvZY1s58KFXz9ZL0v
	5xfy/Ggs92ycBshY7kLD7Jy5+P2tpyi1EFhAQAKc+oakueIjlyt2u442AcOcO5aNv2uIitsHdzg
	MVPZT4Z0lyb5dWbZAsjRfZ1MtzEin56ZZATqNZBd/O3Y32gVtEQkLMjymn9siwxJsZQj+JxmkG4
	yEGyl/VANLkdBpZkOByREDLRRYpqz/R7v2tf4rw87ACONWZfmE
X-Received: by 2002:a05:6000:2906:b0:43b:509c:4275 with SMTP id ffacd0b85a97d-43b6423bf47mr6591394f8f.16.1774026275838;
        Fri, 20 Mar 2026 10:04:35 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6471a27csm8300788f8f.36.2026.03.20.10.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 10:04:35 -0700 (PDT)
Date: Fri, 20 Mar 2026 18:04:34 +0100
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
	Tahera Fahimi <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v6 9/9] landlock: Document FS access right for pathname
 UNIX sockets
Message-ID: <20260320.b9253ffb71ec@gnoack.org>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-10-gnoack3000@gmail.com>
 <20260318.geom7Taxahpi@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318.geom7Taxahpi@digikod.net>

On Wed, Mar 18, 2026 at 05:54:19PM +0100, Mickaël Salaün wrote:
> Please always add some minimal description.

Done.

> Also, as already requested, could you run the check-linux.sh all on each
> patch?  That would avoid me to fix things like the date (which would now
> be OK because of the new patch in my next branch, but still).

Will do.


> On Sun, Mar 15, 2026 at 11:21:50PM +0100, Günther Noack wrote:
> > Cc: Justin Suess <utilityemal77@gmail.com>
> > Cc: Mickaël Salaün <mic@digikod.net>
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >  Documentation/userspace-api/landlock.rst | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index 13134bccdd39..e60ebd07c5cc 100644
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
> > @@ -127,6 +128,11 @@ version, and only use the available subset of access rights:
> >          /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
> >          ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
> >                                   LANDLOCK_SCOPE_SIGNAL);
> > +        __attribute__((fallthrough));
> 
> Case 6 should be handled too:
> 
>   case 6 ... 8:

Thank you, good catch!

> 
> > +    case 7:
> > +    case 8:
> > +        /* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
> > +        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
> >      }
> >  

-Günther

Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C07153BF7;
	Fri, 24 Jan 2025 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734710; cv=none; b=hG+W031P1SYL1CpM9UbxxAL7LPyemd3Zd8oWuQdZyOziZXj/g3+S+BrlLghQ5LrLDBpIgZcS7eZqVgQNjiMwR8U9NTLkdiqO5IY63GQrNoID4ISiG0y4nyiWdcdYrhDhXidIpX/2ZZ46twKDtcA/1H4KpHfvJWuwgRruZ9+ojHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734710; c=relaxed/simple;
	bh=yRy2s0e1Z+ZDfmz1TcHigjaXKIThLGARkuKtw12QB+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxfR54CNmLMx6DA74h0DE1sgL9hKOsquoS1zm1GuyxtpIJL7Y+I6JjmLBHxqx/E7tENsLQCMQLbCSrT0x7OjyVOf2XbfqSV4Spi7NUxeS1kVMGp3dX/sMj5br9/n9+eU5UaPmj4PGP3gavh/+K6aLZVKWvn55HhrOD/SEtwmf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbSd4cOj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbSd4cOj"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso465211666b.1;
        Fri, 24 Jan 2025 08:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737734707; x=1738339507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep67rpoRuEVEyqhGNJimWrXnqXU/pe8ygYkG9Ga64Sc=;
        b=UbSd4cOjyrsUKjhg9b37QW6rTO6GR5WXW8X4lSIWJPIFwz5LkxowVkgoKf77khH93d
         X83lmFnBqpobsRBseLsW39DbkPXv8zaevforFIahMlskDQFNt9Ezq88F0JPoyP7em/jt
         a31/VHwanXYOGxJiIfKbgd+KCEOHEJYNfhZVqHm/guR3Gph7zk5xJRedUl1Q/0YXE5vB
         ofV8z7+Y3JrNNv93SHQvMHXfXl9L0rpXsxbdhoEoHa/his6rL9hRh/bIFJfWM8l6Ow1t
         oFTWMW9mtAhBYNhC0xua8SITRHijPcBKYykuSUOVBArc268do7MUjaPhdaahLufmACUJ
         dCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737734707; x=1738339507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep67rpoRuEVEyqhGNJimWrXnqXU/pe8ygYkG9Ga64Sc=;
        b=jZLXUmOeogA67ATfRKSZv/TYAcmZ8JEXUh9UOXySBmFBjYVJBERhzGBDhTln2aQ6WO
         hSWFNPOR7sdfN32T/HDbLWZJDTTVV7P80h6HPJyF+plsbWx2LL+OiGPRsGxTqfvuGFPe
         sw4NDV54MryL/pFl7HIiK87YI1yDuR5/lf3ynYQWckTmZQd6Ba56+w8JYsfl8sUSk4LC
         FYh8/v1996cUJrzinTQ5aEzg3OCZ+N2juhF6w/KD+Z3Rn2A+3Rk1lugO/hGPsVx9a0yk
         v9GnztXt1AgTTrODvS6b/70CoU4REWcBnnJrBcMyzfp0In5pESdk2IDt9bDTcZq8Ya37
         cqtg==
X-Forwarded-Encrypted: i=1; AJvYcCV8BpOcbzOp2p2GaGctgJk70vDIRpS0yhCx7wa4BkljeAGOv75Go0m1h8V/f07CmDJa4ya6Rp0iZzH9/is=@vger.kernel.org, AJvYcCVkFBqfnrnfI3ozUBetjh6NWcYE8nhruYRbkdkoMfM2I+DwKE857NrZLl8DayWYD14bXhnryQz5WKUf6yWqnOFPSsZVDRMm@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgE+L7z5YkSRfS5zdc6yEVYmS4jnVq3vnrTg2Pv0SD8Gk5NYY
	1xf8t0IO5HgTtaL0VjpL4QcNZGCEbzSxA7kkazXjisjkH9J5brIcYbLZ7HoXkgOctGqfh9G2dhP
	e0JatkVQXiY9yYSLhPEvkfXwbkok=
X-Gm-Gg: ASbGncuF9Uz6AkuqwdWKHOLAIjAZGk2FW0JN4ll7O61S81erusSP4mw5PDMDCu30lWf
	EUoe/ixE1IJB1Zb/3HoPuvWhLaE2yyd+2dLQQxfIgxx/b+1cjm7ko+xR5c3QQSFtCJy190rOxjn
	AP9dn22XSX7lHkOc/fb52n
X-Google-Smtp-Source: AGHT+IEPVeoqXlGzZJCPr29hfo2swSm8eh2Y24LMKYK9uZi+nOCEhDy7imqLobXvhfFNpZ5CuBeSb7sblVLvHm1g9M4=
X-Received: by 2002:a17:907:7da5:b0:aab:8a9d:6d81 with SMTP id
 a640c23a62f3a-ab38b3afad9mr3045025566b.44.1737734706287; Fri, 24 Jan 2025
 08:05:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123194208.2660-1-tanyaagarwal25699@gmail.com> <20250124.Zohthoogh7aN@digikod.net>
In-Reply-To: <20250124.Zohthoogh7aN@digikod.net>
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Date: Fri, 24 Jan 2025 21:34:54 +0530
X-Gm-Features: AWEUYZl2OIepWB_sPQsqtPWSM40nZldYY-UOdmqWEV1k5Ob5HZGN2TADpAF90_g
Message-ID: <CAPdGtUycV9MPdy=h4ZKA+t5D0Q0ya+8ipA2acVSU=PPgrNDuMw@mail.gmail.com>
Subject: Re: [PATCH] landlock: fix grammar and spelling error
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: zohar@linux.ibm.com, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 5:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Fri, Jan 24, 2025 at 01:12:10AM +0530, Tanya Agarwal wrote:
> > From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> >
> > Fix grammar and spelling error in landlock module comments that were
> > identified using the codespell tool.
> > No functional changes - documentation only.
> >
> > Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>
> I think Mimi's tag was for the IMA part, so I'll remove it.
>
> > ---
> > Original discussion:
> > https://lore.kernel.org/all/20250112072925.1774-1-tanyaagarwal25699@gma=
il.com
> >
> > This patch set is split into individual patches for each LSM
> > to facilitate easier review by respective maintainers.
> >
> >  security/landlock/ruleset.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> > index a93bdbf52fff..c464d1f84792 100644
> > --- a/security/landlock/ruleset.c
> > +++ b/security/landlock/ruleset.c
> > @@ -121,7 +121,7 @@ create_rule(const struct landlock_id id,
> >               return ERR_PTR(-ENOMEM);
> >       RB_CLEAR_NODE(&new_rule->node);
> >       if (is_object_pointer(id.type)) {
> > -             /* This should be catched by insert_rule(). */
> > +             /* This should have been caught by insert_rule(). */
> >               WARN_ON_ONCE(!id.key.object);
> >               landlock_get_object(id.key.object);
> >       }
>
> Thanks, I'll take it in my tree.

Thanks Mickael.

Regards,
Tanya

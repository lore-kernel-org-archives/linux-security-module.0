Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7241D5CDB
	for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638583; cv=none; b=dAtETGtKs6hk8ac/zcZ68OqXNZLn90wcm0fFv54akq91YQwQk2c9qBdmlj1U7IK3bXYlfUP2ErIDUREIbrn1fo0dUM67rGlEdQQanahH9ch+SopqJBhP0x6tJiAXNTAivxaLeieJFKjtt2/+pf7lLP2rTWSpMZKUEKHwUpnDFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638583; c=relaxed/simple;
	bh=hWy1NNmb+wDtSIi4PW/nVnogw+nRN5uXUX33xLXpMkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYCeZnA/T71jpR1exoYQgU4ZaH5istmoYv42i7yShAmVMGlOmsyu+42aanaEioJX1gCOjKrtop//u3940gB4IyuG13yVFwYumzryusrXwD6anLpFnD9EcFKVk2Yc0roEX1SmkuSWi6ydER46lBPrePnITIhpf43/AvxJdcXCbF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VCkHgt/J; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VCkHgt/J"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fef1d35589so13855877b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741638579; x=1742243379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDUgfGNw9ICwKZepnDkVTHAQdOKERWg4DcwDZnus3D8=;
        b=VCkHgt/JZaaPTIXA8KjXEbI/hOwbz0aOVcm/oBCsfOFjj6uJr0x5WBJDnoWAsMMxvO
         Exp+6wdYV9OaAKx9zo6vTBRZEKbonGGANBBFg0IWysKG7StkZfwI6dLqzKp75MmiKb+j
         KW4aq4+WJZeX9+pqCPAx9T/KelJWUbF/2OGOnnC19dNeNQegA5WMs6cqrbndgbfiaZpi
         FWDovvyZQvAOiC3FVMW0UbRTGJF9YNGCxX7VMkh3JlNhl9eacFHYVkjtAfbgo1t1g2Go
         IyuG3jXM8xPopjWsa/DN9XwtNNtmHscFyFgt7wbyELF2ZwI741u8ak0+gJVjIz/M9cys
         f5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741638579; x=1742243379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDUgfGNw9ICwKZepnDkVTHAQdOKERWg4DcwDZnus3D8=;
        b=Oew1MwsDiY9E6JcbKOy50uFmD2PnWUTR+wjfC1uIop1yKjVzxLLvL3qSGSegK1B4OW
         456wXgZ/cQikXDhYJ6xphYYBiWXe0QbzfnoB+2fRezzlKy7wj1R4zSt+WxzE0dAmm8Pm
         bVkilZeSGhn0DMSDnYVd+8dVAGiwETWF3f8W5PE07Z4jH0694mmPwzrNY67z44nwB+LZ
         n+sspcbn1dIYzwvdojd2X6AgRtYdge9pNtOExH3KC3ANZI+pwjkD8ZEsrWZJPHXxbQqV
         ALZ/fI+xhKZSmlMICZ6BrBl2x14ob/NvE2rxhxbBopqI1CTrgv6z98FpdqDCLhpj1yEK
         3nhg==
X-Forwarded-Encrypted: i=1; AJvYcCXYH2/m6yO/+wNSoYZIuLyjS9GgajwL4f1bRqR2Djfh/zyCk0HS/jXQWw+Oxgnb8aXulRHrRcYrDuHkur0VFIP8GfIb1/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytY5OM3YCtVGNr6WzTYpQWAu2kdJ6UEKFHu3YNOgNapCE9qlZp
	8aaFpIe4jEY8SYdMdpUUvYA9c4spGbykiUnAzwfQrhgoHNgn6qh0mal6hah5FkZXLrNWeH6TrvX
	rQJHH1awulhPW2B1zdLM+we+d2pvNjgQzbxgV
X-Gm-Gg: ASbGnct3fNSCVZIC40YtA/OYGd3JuaWA70HkvbbEG/sGFPvFdT9exvwR9RdvdB24WSA
	6TIQVFVozDJuUJPB/CtTOjasCwZVbLoK+tKVYAoRH3e6KHrp5JU5qPSbq7+s9MgRNx6JXfqQkjr
	1ErFAL4f1NvZyeB7W/ZqRI/F6bLzWsjCOvH3Cp
X-Google-Smtp-Source: AGHT+IHo9iy1GNgVzKJMJvK8t10zpvURWG53DXUjC0ljR28U670/ZoBhoVEa4msK2fl4fpIGkvkg9EPXy5FjpxcyQvg=
X-Received: by 2002:a05:690c:25c9:b0:6fb:5498:70fa with SMTP id
 00721157ae682-6febf2fc84dmr218686397b3.18.1741638579693; Mon, 10 Mar 2025
 13:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304222304.214704-2-paul@paul-moore.com> <20250309.5ddca2aac3f6@gnoack.org>
In-Reply-To: <20250309.5ddca2aac3f6@gnoack.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Mar 2025 16:29:29 -0400
X-Gm-Features: AQ5f1Jo6QOPoGUFGOIb3gjnWMhzQIShhWRjzY8eEyp8Wz0ElgezHE72pke3O1VI
Message-ID: <CAHC9VhQRWOJkSTsYDGHArmm212CW+EOia-b0hR_r9HrCxspLcg@mail.gmail.com>
Subject: Re: [RFC PATCH] MAINTAINERS: add an explicit credentials entry
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 7:12=E2=80=AFAM G=C3=BCnther Noack <gnoack3000@gmail=
.com> wrote:
>
> Hello Paul and Serge!
>
> On Tue, Mar 04, 2025 at 05:23:05PM -0500, Paul Moore wrote:
> > The lack of an explicit credential (kernel/cred.c) entry has caused
> > confusion in the past among new, and not-so-new developers, about where
> > to send credential patches for discussion and merging.  Those patches
> > that are sent can often rot on the mailing lists for months as there
> > is no clear maintainer tasked with reviewing and merging patches.
> >
> > I'm volunteering for the cred maintainer role to try and reduce the
> > confusion and help cred patches find their way up to Linus' tree.  As
> > there generally aren't a lot of cred patches I'll start with simply
> > folding them into the LSM tree, but if this changes I'll setup a
> > dedicated cred tree.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 896a307fa065..68e4656c15ea 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6139,6 +6139,14 @@ L:     linux-input@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/hid/hid-creative-sb0540.c
> >
> > +CREDENTIALS
> > +M:   Paul Moore <paul@paul-moore.com>
> > +L:   linux-security-module@vger.kernel.org
> > +S:   Supported
> > +T:   git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.g=
it
> > +F:   include/linux/cred.h
> > +F:   kernel/cred.c
>
> Maybe also add the documentation:
>
> +F:     Documentation/security/credentials.rst
>
> This documents the prepare_creds()/commit_creds()/abort_creds()
> "transactional" API that tasks should use to change credentials.

Thanks.  Serge already posted a patch to add the doc page, we should be all=
 set.

> Acked-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
>
> Thank you both for stepping up to establish a clearer ownership for
> credentials!  There is a need for authoritative decisions in that
> area, and it has been difficult to find the right contacts for
> credentials on earlier patches as well, such as:
>
> https://lore.kernel.org/all/20240805-remove-cred-transfer-v2-0-a2aa1d45e6=
b8@google.com/
> (patch by Jann Horn: "get rid of cred_transfer")
>
> https://lore.kernel.org/all/20250221184417.27954-2-gnoack3000@gmail.com/
> (patch by me, multithreaded Landlock enablement)

Yeah, the cred_transfer/keyctl issue is particularly nasty and needs
to be revisited.  If memory serves there was still a compatibility
issue with Jann's patch, but we may want to consider merging that into
-next just to see if userspace still cares.  It's on my todo list to
take a closer look when I have the time.

--=20
paul-moore.com

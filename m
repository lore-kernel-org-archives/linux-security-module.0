Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907F1C57A9
	for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391674; cv=none; b=G/HiSvbHrT1H/FoSYdkcpOeomAvn6UhXyUKCXwb7e6kRsQ82SMTQXoFHiG3hmnzbY73W5Ev0ZU7TB04O+nKLxXtnvAUQusxblJnzIpjrdMafgz+9QKMWEXVJ3+xc9fqXGJqRDoA8rxgwS5IwAU8HabcHmKBUl1tE1l0JeyyvES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391674; c=relaxed/simple;
	bh=gxlFIuTWsq0Qr40nIziAcZuthi1icltxFBU/0xp0M1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqMbITqaf+cglenmHoaSJ5116hWyXbHX+HZo8xwyIEJ6U4tF6dL1ijy2IRNf3rRMlqoYgLAUG/8D+9ucdZD1Ce941pxU91E1h1IGU68pg7yIZj2j1KjV1GUWy3NztklA1tK9XfR9EfODR2ZVO5D56Fjkni1TN6TWtvqUg4Jjluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx5/Sg1r; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx5/Sg1r"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso3319802276.0
        for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 02:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726391671; x=1726996471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BFdj5y/sop/rbcS7l4POgR+aZBaaEXxmhVXxcqjxcSs=;
        b=Kx5/Sg1rgKvDHOD2jPhkkeckM7y3t2X73LrxT48tOYVw/T8jJLOvtJYPPvtcVo62Wl
         btAM4/0+dQmel6tdQvJhRagn028NjMLFW59VeY+r5GgXcYbQqsvrblqpb1o55zjfoWC9
         Or5cukNeuh+t6qUql7kxIC8gNmPoO3QcSnIpNJCGtWatTPDDFEPIV+/WH3ywcqhrVOTD
         YIwkHWHDZI8kD+smk0nw2Wc4eCVijpQjejfljhhplAuJ7IN837FQJT9qpkWGTPmIJLNO
         tqcdX07yIk7OxS8vrqEneU3U+EbSQfLh4yqFL4NdKgkgYhll8JUZlnn3Fwvrfb/cODAs
         LWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726391671; x=1726996471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFdj5y/sop/rbcS7l4POgR+aZBaaEXxmhVXxcqjxcSs=;
        b=pSNrW6/bAZUxHmDRV5XaDmHiWhsBHgINea/ku+WMoHknFw5LikQS/h46670uKIWUyX
         yQnmuHbxjidZMg7Mds2QkyewMAiyHFNr2wlnF/0q875rvb2xL7hiJowdwpxiAWUXdQVS
         rPXVQ9K1/cQTdaKo8WV2mrM3koinJgb8uPRu7P8cHoolAf9RwS4bdwU6QhvgpHxP2sLe
         pZiggYmWi6QJFBjAqrBAt2G8rZz41dWGkS+bv5DpaunrCUqsh+oMTsgyX3m0Nilf/cLf
         RYwVyZ/JuRmgemcRzTXQtkN7etGVGm2IziP/2jq3b/97NSqW7RvYitJFsZ8gSwvdshv3
         E84w==
X-Gm-Message-State: AOJu0YyHXEN3yxHXIjHRk+vwFTA6wMtPfo5fXarao+CoJbkKN7qKNK8Z
	ILpIYAsB/94wnKRqmsreXwo+PpOGej1TcCaXG5dKLt6qq3pkvNgQC7Y6Kuo8BMquKICHTTqha3e
	cPT+p/5LB1+Oin6nETCAo3WZ1sLagnwFy
X-Google-Smtp-Source: AGHT+IEmEojHxoAhnhHpIEqYGq5oWjPYMH8oeJngzSHR6tYyU805zEnSxh9IQlQuQyvxsA+sr7Wv6cxWm2hp3IbW6AM=
X-Received: by 2002:a05:690c:4783:b0:6d6:7c9a:bf5b with SMTP id
 00721157ae682-6dbb6b9b18dmr84480137b3.35.1726391671633; Sun, 15 Sep 2024
 02:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913234840.1318655-1-luca.boccassi@gmail.com> <049ea228-dd20-4a15-961f-ae560a7ed715@linux.microsoft.com>
In-Reply-To: <049ea228-dd20-4a15-961f-ae560a7ed715@linux.microsoft.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Sun, 15 Sep 2024 11:14:20 +0200
Message-ID: <CAMw=ZnR1_QfZrXqa7eiMXF9Jv4k6ZiZLUUfy9gM2OnGNw67AOg@mail.gmail.com>
Subject: Re: [PATCH] ipe: allow secondary and platform keyrings to
 install/update policies
To: Fan Wu <wufan@linux.microsoft.com>
Cc: linux-security-module@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Sept 2024 at 06:27, Fan Wu <wufan@linux.microsoft.com> wrote:
>
>
>
> On 9/13/2024 4:48 PM, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <bluca@debian.org>
> >
> ...
> >
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > ---
> >   security/ipe/policy.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> > index d8e7db857a2e..cac304dc86c2 100644
> > --- a/security/ipe/policy.c
> > +++ b/security/ipe/policy.c
> > @@ -169,9 +169,15 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
> >                       goto err;
> >               }
> >
> > -             rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len, NULL,
> > +             rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
> > +                                         VERIFY_USE_SECONDARY_KEYRING,
> >                                           VERIFYING_UNSPECIFIED_SIGNATURE,
> >                                           set_pkcs7_data, new);
> > +             if (rc == -ENOKEY)
> > +                     rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
> > +                                                 VERIFY_USE_PLATFORM_KEYRING,
> > +                                                 VERIFYING_UNSPECIFIED_SIGNATURE,
> > +                                                 set_pkcs7_data, new);
> >               if (rc)
> >                       goto err;
> >       } else {
>
> Hi Luca,
>
> This patch looks good to me. My only thought is, like what we currently
> have for dm-verity, should we also add two kconfigs to enable to use
> these two keyrings respectively?

Sure no problem, sent v2 with the added kconfigs.

Unlike dm-verity the default is "yes" for both though: it's been quite
a pain to get all distributions to enable the dm-verity kconfigs for
the keyrings, given they are quite hidden and a niche use case and
general distro maintainers don't go and look for these options, but
likewise it made signed dm-verity unusable on general purpose distros
without them. I'd like to avoid repeating the same plight. This way if
one doesn't want them they can disable them, but the default if IPE is
enabled is to use them.

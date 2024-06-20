Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548FD1B9AC9;
	Thu, 20 Jun 2024 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908218; cv=none; b=GPqfHWsnufoywImIwniGNV5cAWRZ4J1Q/DZh03t3YL++4GBySlNRl32bsIbaZPEb5wmB8gzUKjbgkX9tIUcWh3AhiuZEx0zOpCXr2fUz2gG5r2390fbiE6WFX/njUuI7sKGmYPGP0G0Yp/WnhQYi3vfeISt5GSz/twigtF+Dgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908218; c=relaxed/simple;
	bh=23zcJ+d5OKU7OHuj9SbbJQlzUz7TBJgSFQthjCH4jb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRE5a+GKHghkzGtZgkPY4s0ndhxlu6LnQC+v8GyRpFOzACP59/1bG1sw+Es4DkHv0xtgZYbdQq8z3mMYV0G4OWZX51JjTZ5MVwe6i7dkj5XrX3sg3Gzq1wL1z8DHuWnyUQQret25eNaevV/5nkQ9/36tQFRf7KdeqxY/QAl0UZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXnwqsB5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXnwqsB5"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d1d45ba34so1333428a12.3;
        Thu, 20 Jun 2024 11:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718908214; x=1719513014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m1gMzA5fnD2sjUydDvpKr3zIKxDfhIqLd68Kj5jrIU=;
        b=LXnwqsB5iPRnchjSY2vjhQ/pVftZbmIqWQ/vP/1KdYAvhiTzKQ0wy3+X0ZptsTeUjO
         QsAN9M5B7OGhIwU3oKvOZAP6cePlVzYJi45PeuOfcodc/h7ooTF/LeYeTWl6lNgXNPvo
         /HRD1inp8skJMpOtteHWbMwPpNQ+08gk29ftkR9b4zOgorvvU2xmsbwcmDRQWerUsr/H
         DetjbbsWv7F5NuExSe2ZJaxv0oRMsjKbPae7BdOIQZLFzK9fTmDMtoSAFAhw6bExqG9V
         q5kC6LGXkS8f8WWcAHWP9MQhHgnGvaQTwfEYKxPF6buRWyi9G9dtbI0EkNk2e3qx1ss0
         76fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718908214; x=1719513014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6m1gMzA5fnD2sjUydDvpKr3zIKxDfhIqLd68Kj5jrIU=;
        b=CaUev5EJwiGj09LrSDNPAzY56DcLVjuDx6uHWck/rbsHCungwAGTrT97fgK2MlNt74
         Rw9NyQ7QPa8OpC2EqMgyG7FIpZ4hA6bPJqtKjP1ya2LwPxXLfkoCCVT4PCcTQ+t+FyB+
         XNHSGnzDZakm5+L9B7R6xqmZGPsEpM1l0vy09GxhBeO+zWZ+H2sCZy4FzPHaSGxAXvU0
         HKE0FcX14sjIZFzSs2BINzHUukRJTR+vD02A1Qa1KcLmbt+nQgU/i4HR6zJqfFHL8WMy
         MCHk6gRBCME4HjR/lcTCg1NCsjwrYFFPnbws3O3XkL+UmORnY14yRCCWQ31ILQbZI9vJ
         gFEA==
X-Forwarded-Encrypted: i=1; AJvYcCUdANxfwyHnj/rGvqKCZgYkUvB2M0WtDOHsHFI7keZ0/hC3W5oefRo2cyKOSXi7f3SGuZpATxbhrjDo8x7epktWdMLDo/IhGuuCWPAhicMZQDb6ijK+bK8CPFlqOYCkLhjTbAHCAhOpTHDuPz7oezebvUTd
X-Gm-Message-State: AOJu0YwrHqOgHc3xhS4mAs1g+vQdrxitEBPy5oO40btde6FqrZJkarfp
	5x9S92oUMyFPGX3MuS1YOumPpFdHxCb5/gof1J0LygNE/qUk9n2pRBEramXwOguiVN8cHDabdWu
	U2VdYi0Kwm38H/s2tW1EaWVUNlBw=
X-Google-Smtp-Source: AGHT+IHUEaMNwS1/lDslY7n8j8o8MmR5UldgYWqZCqrHZCOG6gHMWvb41UggkniTgZec+c4o1IZNVFbioZ/sL6VxoI0=
X-Received: by 2002:a17:907:1686:b0:a6f:b428:30fa with SMTP id
 a640c23a62f3a-a6fb4283167mr368999466b.59.1718908214436; Thu, 20 Jun 2024
 11:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620171528.167997-1-mjguzik@gmail.com> <155a24f7-8059-49b0-93fa-94bcdc058621@amd.com>
In-Reply-To: <155a24f7-8059-49b0-93fa-94bcdc058621@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 20 Jun 2024 20:30:02 +0200
Message-ID: <CAGudoHFsqDS-5ELmy=t2fdQ2Xrk8q+xyfCkZPpb4XA-+6HOpNA@mail.gmail.com>
Subject: Re: [PATCH v2] apparmor: try to avoid refing the label in apparmor_file_open
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 8:23=E2=80=AFPM Neeraj Upadhyay <Neeraj.Upadhyay@am=
d.com> wrote:
>
>
>
> On 6/20/2024 10:45 PM, Mateusz Guzik wrote:
> > apparmor: try to avoid refing the label in apparmor_file_open
> >
> > If the label is not stale (which is the common case), the fact that the
> > passed file object holds a reference can be leverged to avoid the
>
> Minor: Typo 'leveraged'
>
> > ref/unref cycle. Doing so reduces performance impact of apparmor on
> > parallel open() invocations.
> >
> > When benchmarking on a 24-core vm using will-it-scale's open1_process
> > ("Separate file open"), the results are (ops/s):
> > before: 6092196
> > after:  8309726 (+36%)
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
>
>
> Trying to understand the changes done here. So, while the file cred can b=
e updated
> async to the task (referring to the comment from John here [1]), the file=
 cred label
> cannot change during apparmor_file_open() execution?
>

Refing a label retains racy vs refing it.

On stock code you can test the flag, determine it's not stale, grab
the ref and have it become stale immediately after. My patch avoids
the atomic dance for the common case, does not alter anything
correctness-wise AFAICS.

I am assuming the race is tolerated and checking here is only done to
make sure the new label is seen eventually.

Not having the race is possible with a bunch of trickery like seqc,
but so far does not look like this is necessary.

>
> Reviewed-by: Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
>
>
> Thanks
> Neeraj
>
> [1] https://lore.kernel.org/lkml/9bfaeec2-535d-4401-8244-7560f660a065@can=
onical.com/
>
>
> >
> > v2:
> > - reword the commit message
> >
> > If you want any changes made to it can you just do them on your own
> > accord? :) Will be faster for both of us than another mail trip.
> >
> >  security/apparmor/include/cred.h | 20 ++++++++++++++++++++
> >  security/apparmor/lsm.c          |  5 +++--
> >  2 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/apparmor/include/cred.h b/security/apparmor/inclu=
de/cred.h
> > index 58fdc72af664..7265d2f81dd5 100644
> > --- a/security/apparmor/include/cred.h
> > +++ b/security/apparmor/include/cred.h
> > @@ -63,6 +63,26 @@ static inline struct aa_label *aa_get_newest_cred_la=
bel(const struct cred *cred)
> >       return aa_get_newest_label(aa_cred_raw_label(cred));
> >  }
> >
> > +static inline struct aa_label *aa_get_newest_cred_label_condref(const =
struct cred *cred,
> > +                                                             bool *nee=
dput)
> > +{
> > +     struct aa_label *l =3D aa_cred_raw_label(cred);
> > +
> > +     if (unlikely(label_is_stale(l))) {
> > +             *needput =3D true;
> > +             return aa_get_newest_label(l);
> > +     }
> > +
> > +     *needput =3D false;
> > +     return l;
> > +}
> > +
> > +static inline void aa_put_label_condref(struct aa_label *l, bool needp=
ut)
> > +{
> > +     if (unlikely(needput))
> > +             aa_put_label(l);
> > +}
> > +
> >  /**
> >   * aa_current_raw_label - find the current tasks confining label
> >   *
> > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > index 2cea34657a47..4bf87eac4a56 100644
> > --- a/security/apparmor/lsm.c
> > +++ b/security/apparmor/lsm.c
> > @@ -461,6 +461,7 @@ static int apparmor_file_open(struct file *file)
> >       struct aa_file_ctx *fctx =3D file_ctx(file);
> >       struct aa_label *label;
> >       int error =3D 0;
> > +     bool needput;
> >
> >       if (!path_mediated_fs(file->f_path.dentry))
> >               return 0;
> > @@ -477,7 +478,7 @@ static int apparmor_file_open(struct file *file)
> >               return 0;
> >       }
> >
> > -     label =3D aa_get_newest_cred_label(file->f_cred);
> > +     label =3D aa_get_newest_cred_label_condref(file->f_cred, &needput=
);
> >       if (!unconfined(label)) {
> >               struct mnt_idmap *idmap =3D file_mnt_idmap(file);
> >               struct inode *inode =3D file_inode(file);
> > @@ -494,7 +495,7 @@ static int apparmor_file_open(struct file *file)
> >               /* todo cache full allowed permissions set and state */
> >               fctx->allow =3D aa_map_file_to_perms(file);
> >       }
> > -     aa_put_label(label);
> > +     aa_put_label_condref(label, needput);
> >
> >       return error;
> >  }



--=20
Mateusz Guzik <mjguzik gmail.com>

Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0F835CB87
	for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890882; cv=pass; b=u51uTUdDd4zGTgBuwipNDr5HyiFLm7Es7I1yOJozM/Hy+VVakImnqkmMfSqPVG9buYhR1NT3Jw9udJrrBIqzNZiagbY04a4Nwbux6RTvUT1YZlR3myyHel4DeHiBrsXl2rCjLZvIHNZUBBuMxAM1FJRwUMN4dxqEoJnyirs/azc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890882; c=relaxed/simple;
	bh=VSyvBWjhdMjZtiAiJ7JWmp9FMaJmuwVICnrjKsUWJ4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPluGj9Oy2Hwu/f/V2TRf5N2ETwpiWT1VHcgN5AzyCGGNy7A++vld6SEc//4bUoJ/N0Jh5J9EB/ABgWmr5wlpbqr7wZy1DgBqRltgiVZ6/QCd0lomtow2mubEhup8USTx+GvZZET/E9KcNghPi+ga5gg0ukZwSRpkvpJS1ANOqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AsCQDq4d; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AsCQDq4d"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-6028bb29cc9so133101137.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 20:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773890879; cv=none;
        d=google.com; s=arc-20240605;
        b=OGml8BFD37UMe2AdpV4Fm4WFcMKkvGML7ad4rWv5ahubOIHITT50YjD7+KQWUSFdyy
         30vSJI1NbxKrU+oXc3AkmM74S+dxAxzdduDmXFU+g2xDUOalZPTQArIikTsyNMbTIxF+
         V+vQTR7GOq3+PwAHMZC+dRGvD/uNcbnV/pgduUUFsnfl/oDbkUhkwDlU/av+CPBDRB5z
         OsORm2fIvYQwYzIE9ZrEc+Zz37UsQO5Db9caCnC/KW6Xk0/kZ6RObEmVlojCeIzIoHby
         Iy0Rx2I6gxmeDnmfNaAaRVxGkBZ8KYEXRsYlLu8awaLptU/dlnEfu4xsoAM8t07zmRXl
         ljBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KwN6OdURA4jnEiYulF2GKwWLLkDnlaYj3NDTXeXZltw=;
        fh=HYrOAD8NGcTW8qbWYfbZ/HVpmoFNp35jIjxCcd0Qh5k=;
        b=iDclYyjFPHhKtKmoiStdG9BuojQ9vNR+ZUndDGZtk/gCCoplINF8aTYWhuKf04pS9c
         JZXhmT1+gamgIg89SW1Gb3jw9J6V1QA4jrJ7PE7e8futykk7dluEs73AfKF/0toymcp7
         PdPruy7CQU4nWWg4oqrqnrruVY+C9OW97FE1Cjl+TO1NYBK3mLiuhi7sawbG09uhQoy+
         Sb57wrg6FEbALt5L3785LOD77IRngTt12iaW0TWpvhZMdN4K7kCEPc9s+slIaN7cW8hN
         0HkfFngzhNR5hzF04muFm47kJ8R5XFvF5h/Z8VawxBPvRReeeuhw1owUmLv2eoKAPD3I
         p9HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773890879; x=1774495679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwN6OdURA4jnEiYulF2GKwWLLkDnlaYj3NDTXeXZltw=;
        b=AsCQDq4drYM95UF8MyOkzGaDcA/OaZaWzHo2YksT4zfVWFxZ8otmztqTIvy3Yw46ds
         mcyjfMDyvEryRMQ7Kc4Vtx1TZqnAGmrHmlhEaEMQ2IW80LS96Hg/3G887dsqC3swwfrw
         NH9pPsHhDpcACBNYCJu7+ipQd7t9c38MRE0vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773890879; x=1774495679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KwN6OdURA4jnEiYulF2GKwWLLkDnlaYj3NDTXeXZltw=;
        b=cnsEWLIY3z+ZRPaH2MgMZ5lOHCZfcjWBzwiFzLmIlS0+wxqig6/CTuWcegeTAiF2DB
         xyGFhhMbnd0qgpiESxVBuvXzU2E5U0AFgyc77iAVsORXlifmkqAVv0Pj3WzpKM/1iGKp
         B/u0Sf3KjNnbLaoeYZP2tjuyJc77jEJqFI4t5tcDD7FmwSyCVqfMOZ1ZMaaxi7wQp8gn
         XhJHIs5xlQiDoyEsQnCIYjwbBNUNx0KgO7CFROOS5mwU4Ca2IgGGtU4o5IRvYlbfphVm
         bb7NXwJQWjJv83s1twYoUTSoOlrQOLLg5PsplmBI4qDSr0dHmXFCKmTiy8bEgDXQ7qHA
         0Emg==
X-Forwarded-Encrypted: i=1; AJvYcCXdk7Ktrl3rfsMqmB8UJGJIY2EJHozEe62qYGVt3JcABYbFURtLADoVMoicdEHzO6oaxmsEpUBEIjjcIKrB5gCR/mXpVm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziVMWb0qSFO2Z4WD6k0BBlaUtrDfnXcNKWSFyeEA3+1fqx/ugH
	/vDikCeNyQdRZl2i/Ky05dev7Daoxu4GYGOgY+c3HdC0Zu25XjngKHfVPLtiKgIrtIq7/sRxt/H
	f+wuprwG+EWvcf6RAJR8LGIIE0RA6NYZs2QgMZvjCuzQbdBkOJnhNoA==
X-Gm-Gg: ATEYQzz7wSUFg7BXnZv8MVKHxz5cjjqtpitArT3zhY7qAEkfpK0dT93BVg8/2MRkdmx
	uCX638kPe6dXATSYzQ9vH0VSflVnTBz3lboECKfei/gMQpW5HWkQN9shNfCkoRh8AKH6jcYbP+i
	cnoK0LIHorpDrKvFJD2uzRYHyriuWafj4H9DhubLb3eaQ6IAWuaNfgyka/eGyKyktYi3wkLv4YD
	7zJrxpi7iXkG5pRehQK6AfLisqsYQxUw8AEdc6G70thHQKiRXltk0J3J6bnZc5pCkSzFDy8pGyM
	55RGMg6Q
X-Received: by 2002:a05:6102:3e19:b0:602:9900:8dd9 with SMTP id
 ada2fe7eead31-60299008f3bmr717301137.35.1773890878878; Wed, 18 Mar 2026
 20:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303024025.37916-1-gaoyanwei.tx@gmail.com> <CAJ-EccNLTuj74vKsNQFnOSXgjdyRpUrFVARsuqn6VNatQu33WA@mail.gmail.com>
In-Reply-To: <CAJ-EccNLTuj74vKsNQFnOSXgjdyRpUrFVARsuqn6VNatQu33WA@mail.gmail.com>
From: Micah Morton <mortonm@chromium.org>
Date: Wed, 18 Mar 2026 20:27:47 -0700
X-Gm-Features: AaiRm50fjZ8pLnlsQVkRA0IwVdNrfN7rDrbptS4LEmaUZaPQIJhn7PBJxywSIOA
Message-ID: <CAJ-EccNveP4AQYec-GYpvgrQhe=d=ruUnBxE7xS5D1Q=jspZdw@mail.gmail.com>
Subject: Re: [PATCH v1] security/safesetid: fix comment and error handling
To: "yanwei.gao" <gaoyanwei.tx@gmail.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 1:49=E2=80=AFPM Micah Morton <mortonm@chromium.org>=
 wrote:
>
> On Mon, Mar 2, 2026 at 6:40=E2=80=AFPM yanwei.gao <gaoyanwei.tx@gmail.com=
> wrote:
> >
> > - Fix comment in lsm.c: use CAP_SETGID instead of CAP_SETUID in the
> >   GID capability check comment to match the actual logic.
> > - In handle_policy_update(), set err =3D -EINVAL and goto out_free_buf
> >   when policy type is neither UID nor GID, so the error is returned
> >   to the caller instead of only logging.
> > - In safesetid_init_securityfs(), return ret directly when
> >   policy_dir creation fails instead of goto error (no cleanup needed
> >   at that point).
> >
> > Signed-off-by: yanwei.gao <gaoyanwei.tx@gmail.com>
> > ---
> >  security/safesetid/lsm.c        | 2 +-
> >  security/safesetid/securityfs.c | 4 +++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > index d5fb949050dd..a7b68e65996c 100644
> > --- a/security/safesetid/lsm.c
> > +++ b/security/safesetid/lsm.c
> > @@ -128,7 +128,7 @@ static int safesetid_security_capable(const struct =
cred *cred,
> >                 if (setid_policy_lookup((kid_t){.gid =3D cred->gid}, IN=
VALID_ID, GID) =3D=3D SIDPOL_DEFAULT)
> >                         return 0;
> >                 /*
> > -                * Reject use of CAP_SETUID for functionality other tha=
n calling
> > +                * Reject use of CAP_SETGID for functionality other tha=
n calling
> Looks good.
> >                  * set*gid() (e.g. setting up userns gid mappings).
> >                  */
> >                 pr_warn("Operation requires CAP_SETGID, which is not av=
ailable to GID %u for operations besides approved set*gid transitions\n",
> > diff --git a/security/safesetid/securityfs.c b/security/safesetid/secur=
ityfs.c
> > index a71e548065a9..50682abd342b 100644
> > --- a/security/safesetid/securityfs.c
> > +++ b/security/safesetid/securityfs.c
> > @@ -224,6 +224,8 @@ static ssize_t handle_policy_update(struct file *fi=
le,
> >         } else {
> >                 /* Error, policy type is neither UID or GID */
> >                 pr_warn("error: bad policy type");
> > +               err =3D -EINVAL;
> > +               goto out_free_buf;
>
> This makes sense to me and matches how things are done in the
> functions above in verify_ruleset() and parse_policy_line().
>
> Is this code actually reachable? I guess if verify_ruleset returns
> -EINVAL due to a bad policy type value the code still hits this spot?
>
> >         }
> >         err =3D len;
> >
> > @@ -321,7 +323,7 @@ int __init safesetid_init_securityfs(void)
> >         policy_dir =3D securityfs_create_dir("safesetid", NULL);
> >         if (IS_ERR(policy_dir)) {
> >                 ret =3D PTR_ERR(policy_dir);
> > -               goto error;
> > +               return ret;
>
> We still need the `securityfs_remove(policy_dir)` call to clean up the
> dir created with `policy_dir =3D securityfs_create_dir("safesetid",
> NULL)` don't we?

I guess securityfs_remove() just returns right away if the
'policy_dir' pointer IS_ERR, so either way is fine. I don't really see
a reason to change this though.. seems better to err on the side of
calling the securityfs_remove() function even if its currently a
no-op.

>
> >         }
> >
> >         uid_policy_file =3D securityfs_create_file("uid_allowlist_polic=
y", 0600,
> > --
> > 2.43.5
> >

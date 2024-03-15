Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353D45BE7
	for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520961; cv=none; b=WrfN4aDOCgtCwjTj0XwymiV7QslHPficJB6fTUSOuaa6bhPWi75PBr+LKSSWwzOjd7KLa2Tw4FprKrBPySxycW/+7xMSZjb7oOSPq5TBF7sh2k9o1G4Goe55fRzyoYkl6Pml+l90u+jpnBaiVSWwQBBXqtpHUb4qL+an9IMpvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520961; c=relaxed/simple;
	bh=J5oMlEU1U6UfP0jrBeuropat7L7sbrGp2O70JVoMCFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0IKJfHPn6rZYnxEEt30zfxQXLHwIt4GS79kH602Ir0timhlvkG69qJcIdxhKLuMlfV/LdqGsfNXQbrqM+UKwM5lflpoyicKLv4zy3BSdxArxNRzKUhw21M0MyuYidc4N1VG5FbT0oVqJoAE3A2TASUaZE41OMASamOp2n/n0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eIVRNs1Q; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eIVRNs1Q"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc73148611so2429748276.3
        for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710520958; x=1711125758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H07gqoqiHhyXpKdPpOzTJjF2W0vO4lvoWppMqc9TUqs=;
        b=eIVRNs1QN1BfXHzauS4bEp5v7R2MSZ9EcP3uK5DfvueFicnuiw3kd/a0N83JkzuT0/
         wcRYSfDogW4UN3F4dKQ6sJ9qzD6d9dvRtsbTNI2kvhg7X4NXtdoi1KGsUH+1UDJDUBVu
         17krgKb0wQdE61g1KZh5IK6VN+Fr8OkoV5FmITDKWKNOw3T9b/etqJmLx5v8T2hxdsSM
         TDNsUVYwgLIuZ1tVV/FpH0j9sNrJWp+YWI2tLi4dyzJ9EAJIDJ3TjrgWjZVSP63KxxmE
         xOH5fQ+gGkhRFEVL9kcIFkRx4Ra5cIE1KLmxR+xjf7AMotUU/4Ytu5j+JqCTZb81hNWD
         DLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710520958; x=1711125758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H07gqoqiHhyXpKdPpOzTJjF2W0vO4lvoWppMqc9TUqs=;
        b=k1Sw77qKINb1++0DdkqWDelhz0XnNnJf7zTECNQfgJPE5mg0XB8ilP8rtUaarAmqQ6
         I51jXzn0KSt9+E64tt7AiTxyROMUeiNkFzM2aVM23vHTBLlGtpj306j+XsSc+RomnEKL
         eS4aEox7nFHi1y2Xijvq1WBunOcNhPNCy4MXp82hhE4pSBcwMsqBjUbfovwcdF1SYsYn
         Vyqk6LEzlznWme6RQXgKbuQm4lPVksjT9G7SLcLvO44IckOo2JIDpi6ebiIAlEySe+HS
         eUaIBNpeOm37sQ4bjS8jN6WlYhSGUQfjT0VshyHZkcA5vaQz+kZGIQGDf2iS7f6GIsWZ
         texg==
X-Forwarded-Encrypted: i=1; AJvYcCWCi4IJvj4v+4YoMslD/j5DNfX4xrWRcD+rGuBFsbeC3XBZmv7h7PNOtInUUUahH7kY+/49dbamyF1CS17qEqpPNQTi/sVzDRLuRCITCwF8R/paz1/Q
X-Gm-Message-State: AOJu0YyWPAR34tcR8E7j35nmvBVKSptBzKOYEAQvmvrHXWGL9OaRIl4a
	1fwjueFPPzh94Z4cvPjGeWK9m5NIrLBTgUnrW2bBnywBHPQBDQZJauOjwmeB6xdNOMMlvK8LSkw
	MrEsPbwiICxToRD8U9P/JhjLxGIwQIv+1R9NfDckU/lKBZ6w=
X-Google-Smtp-Source: AGHT+IH4P4eNKAhpo5rcVLOdZL276IDsnMSC0q0I10EAKgS09tCOvxtt00k40cyq6P9b56jSoKq4cZagJdRyTGb7NVQ=
X-Received: by 2002:a25:ce41:0:b0:dcb:f5f9:c062 with SMTP id
 x62-20020a25ce41000000b00dcbf5f9c062mr5912385ybe.14.1710520958524; Fri, 15
 Mar 2024 09:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314022202.599471-2-paul@paul-moore.com> <20240315150208.GA307433@mail.hallyn.com>
 <7956284d-5687-465d-bbcc-d45435dac42e@schaufler-ca.com> <20240315161345.GA309097@mail.hallyn.com>
 <CAHC9VhS245LRsa3DhdkZ-u3+qvroygsyBm2q5mZWkOW8eOKOdQ@mail.gmail.com> <20240315162831.GA309358@mail.hallyn.com>
In-Reply-To: <20240315162831.GA309358@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Mar 2024 12:42:27 -0400
Message-ID: <CAHC9VhRNG-uxJRTtbRO9o-G6F9JGWWtM8hR_ofFRzrcBRxDcUg@mail.gmail.com>
Subject: Re: [PATCH] lsm: handle the NULL buffer case in lsm_fill_user_ctx()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 12:28=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Fri, Mar 15, 2024 at 12:19:05PM -0400, Paul Moore wrote:
> > On Fri, Mar 15, 2024 at 12:13=E2=80=AFPM Serge E. Hallyn <serge@hallyn.=
com> wrote:
> > > On Fri, Mar 15, 2024 at 09:08:47AM -0700, Casey Schaufler wrote:
> > > > On 3/15/2024 8:02 AM, Serge E. Hallyn wrote:
> > > > > On Wed, Mar 13, 2024 at 10:22:03PM -0400, Paul Moore wrote:
> > > > >> Passing a NULL buffer into the lsm_get_self_attr() syscall is a =
valid
> > > > >> way to quickly determine the minimum size of the buffer needed t=
o for
> > > > >> the syscall to return all of the LSM attributes to the caller.
> > > > >> Unfortunately we/I broke that behavior in commit d7cf3412a9f6
> > > > >> ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()=
")
> > > > >> such that it returned an error to the caller; this patch restore=
s the
> > > > >> original desired behavior of using the NULL buffer as a quick wa=
y to
> > > > >> correctly size the attribute buffer.
> > > > >>
> > > > >> Cc: stable@vger.kernel.org
> > > > >> Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into=
 lsm_fill_user_ctx()")
> > > > >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > >> ---
> > > > >>  security/security.c | 8 +++++++-
> > > > >>  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > >>
> > > > >> diff --git a/security/security.c b/security/security.c
> > > > >> index 5b2e0a15377d..7e118858b545 100644
> > > > >> --- a/security/security.c
> > > > >> +++ b/security/security.c
> > > > >> @@ -780,7 +780,9 @@ static int lsm_superblock_alloc(struct super=
_block *sb)
> > > > >>   * @id: LSM id
> > > > >>   * @flags: LSM defined flags
> > > > >>   *
> > > > >> - * Fill all of the fields in a userspace lsm_ctx structure.
> > > > >> + * Fill all of the fields in a userspace lsm_ctx structure.  If=
 @uctx is NULL
> > > > >> + * simply calculate the required size to output via @utc_len an=
d return
> > > > >> + * success.
> > > > >>   *
> > > > >>   * Returns 0 on success, -E2BIG if userspace buffer is not larg=
e enough,
> > > > >>   * -EFAULT on a copyout error, -ENOMEM if memory can't be alloc=
ated.
> > > > >> @@ -799,6 +801,10 @@ int lsm_fill_user_ctx(struct lsm_ctx __user=
 *uctx, u32 *uctx_len,
> > > > >>            goto out;
> > > > >>    }
> > > > >>
> > > > >> +  /* no buffer - return success/0 and set @uctx_len to the req =
size */
> > > > >> +  if (!uctx)
> > > > >> +          goto out;
> > > > > If the user just passes in *uctx_len=3D0, then they will get -E2B=
IG
> > > > > but still will get the length in *uctx_len.
> > > >
> > > > Yes.
> > > >
> > > > > To use it this new way, they have to first set *uctx_len to a
> > > > > value larger than nctx_len could possibly be, else they'll...
> > > > > still get -E2BIG.
> > > >
> > > > Not sure I understand the problem. A return of 0 or E2BIG gets the
> > > > caller the size.
> > >
> > > The problem is that there are two ways of doing the same thing, with
> > > different behavior.  People are bound to get it wrong at some point,
> > > and it's more corner cases to try and maintain (once we start).
> >
> > I have a different perspective on this, you can supply either a NULL
> > buffer and/or a buffer that is too small, including a size of zero,
> > and you'll get back an -E2BIG and a minimum buffer size.  What's the
> > old wisdom, be conservative in what you send and liberal in what you
> > accept?
>
> But if you pass a NULL uctx, then surely you should send *uctx_len=3D0.
> And that is already handled.

Why should we assume that userspace is always going to behave a
certain way?  Userspace is going to do crazy stuff, that's a given, I
just want to make sure that we protect ourselves against the really
crazy stuff, and if we can do something useful with the moderately
crazy stuff I think we should.

> What you are adding is that the user can pass NULL uctx, but a large
> uctx_len value.
>
> Perhaps should change my objection, and say that I would prefer the
> comment fix to suggest passing in uctx_len=3D0 and uctx=3DNULL, and expec=
t
> a -E2BIG.  The NULL check can stay (though I still think it should
> return -E2BIG).
>
> Because with the current comment update, the user may pass in
> uctx=3DNULL, but the actual rv will change between 0 and -E2BIG
> depending on the uctx_len they sent in.  Which is whack, since
> the incoming value means nothing.

I think that's a desirable behavior, if you pass in a NULL buffer
we'll provide you with the required size and return -E2BIG if the size
you gave us was too small, and zero/success if the size you provided
was adequate.

Maybe I'm being stupid and this really is "whack", but you've got to
help me understand what harm can come from the behavior above.

--=20
paul-moore.com

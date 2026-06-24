Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F5D272801
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jun 2026 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305288; cv=pass; b=HpgQ3RtdmAQGl4tmAHkp6Ka32XJqiysEQKCPTSIxwC1dSg2K/DlJWjY/JJEugSUPqpD3mUu08tFvFxOcOfvo2K37/A3/ms32rsPyByfEJYr7AKkZ3hZ8x6PVopAS6+4t0zk3Hmm4+AcGhSjcvSvNWAWceRyMgF4zuNSc41B2avk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305288; c=relaxed/simple;
	bh=pxB1RzcJJa+gQrBBYi7aLW8N/XE6eWDcEJTxyghqYAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSpx504D7jv+IjntZ1xVINrpeqSElkyiXY+QViPgURBE/kwpJnRArUTHX8JRwpY2eqwHIjE5gkWueVtaFuE4qWX2U1rBP+IRne7ADm6GPBeVgaHmBdRL1cMZlpZdFXLAO0WlTYLu+GJJYNP/MnY5SP6IKj4yo9JIiKxKgSK+PVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0KZ0Qw7; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0KZ0Qw7"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69eb8b6bea8so434870eaf.3
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jun 2026 05:48:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782305286; cv=none;
        d=google.com; s=arc-20240605;
        b=d+W6bSaQuKTkMpzIkMjP9WnjbPA32GsMV+XzXD4IRRQzwXvyP7Up/LDYh8qnzjxsuX
         9KSD3RlAoDY2Pcb1bli1ccvBPCOBu4yIpivHFWbtwdvNZa4t63JxmPnE8Yk4GaAQ0Mtn
         GFX+jkuIxMiMsN0jTWPOzjN+iVdQv2l4gqUIAeRo1cJf7N27dTvDMsR2LUR1VwUVU+52
         L7aV/vT396ttRLVaiN6816SxAmztBJDmNpR6NX1lKmQRAuKvsVMT77dxV/XZokqac/O4
         VKntKqOTr3WxrigZJEbKO9+K9UZKotBDR6+SkInEDTwcFQuFTW46trHOWr45Huzsmjrd
         HfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e4nkw9X8z4GQDmnEzz60K8qb7+KgBLROK67Wqi3HONQ=;
        fh=3uwa9F0n9agDaAMDbcl3sU0hjHZ0yKlqTvbe2SXhpL4=;
        b=Nf0RUvsvOKhl0x+b2AcydI2y/HCkY6ugdTYItSQWJUyE/GfZ9mSPLLesuMo1ZCpDsj
         eTxI4fwp/Lb3XjCSPANyzkY5FzD2uOcpftvulpAL8p/gubkmH0PkQJp55r0+aX3oXAe+
         YXv+6xLxQcgXqnzkhItiVW6rQwrCQJIQ6M4CcTB2p57EQak/dZK36Q+YqfHMjitbsoaS
         ItLKLtd+tWZ/p5vc5gmcEzPbtbRr6Q20+6eeGzSt2jEwTGydxSTgg4pnuoRK71Tl7KjS
         Qd5fiaMBFR7MmH4aXRWcNUag5W/9KRsmyQ6XaVrdUKcXQCTuABwgY0izYSS/i4ZgUeby
         Bghg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782305286; x=1782910086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4nkw9X8z4GQDmnEzz60K8qb7+KgBLROK67Wqi3HONQ=;
        b=l0KZ0Qw7IeLmEdGw7R+PKo807sqCgEGphligyOIFom2iguHp9KLMRCm9nSUptpK7xm
         9sDmQG893jCUwYYwoH2q1CCGZ1bOhe2HmUjRFCCm/IJu9itPe8784EjzIv0+i2Lvia5E
         zRLp8YUIEmiolxKDVoKi00qHq1u3OvhmvQe3ILp0vtwZJLzzHrKvNnr93EShiyFcb/I0
         RRxQH2ywDFV+imzhAbgi5aP06qka1Qbq+bKe4nfxfHnG3myT95Bn5dY/EZuKh4SYg+Am
         HhTULt52qDfaxkwSTpeAGk1Qtbp7zEYkqEZkuhOw4ZtaTSIbW7PmwYdASnMard9oUKNy
         Tu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305286; x=1782910086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e4nkw9X8z4GQDmnEzz60K8qb7+KgBLROK67Wqi3HONQ=;
        b=l9hTAlDjLsjIfONzH0axnES0RICsRPYIic/ihsN0gToxmQVnZaSPtx9FSnL5WaygDB
         XA6K3G6nRPkjmGPAb4pvWBBZdJ7S3ndlnjmVu2UlmohaWB9+arGhrKqtHEZ92uAtZduA
         jXk1Z0iedSheDTqmqMa1Ul0QQ/4rQnFy2QuLn0EZ7HRF4LUjC2vzHa1Yy0noOV2GpVF8
         EzMU6bjx/7rUyf12I0c/glwWikr3bDnkIA/6eQ7rTAoRXP75iFZizJJasxoxKn6OiQyd
         8L4B2LAGfDn/zqSQCqbvTfRkObFqyC76cvT0M1kEfdOtEFPNLepa4m4UsLnBuJWHyzpy
         t9gQ==
X-Forwarded-Encrypted: i=1; AFNElJ/irPhqGvA3uqUqv0T9Q+pxFiW30gWD1Kp5CsQjbHrsLhIprfXVHIi/gtCGeCaznC+Dh2imvGX6ccxjcUIoEiTUFbA2kBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdm0tH7EQn1XNPrmo6ZkU7o6AwMys1/aML1T/1ZoXKcMVESfD
	XinoBHktYnpODV5vHTXnBoXCE3NxIFNQeBsE9Cl7FQfBV3St68USTI9/hyxGkcoXUu6rK91vxkJ
	xk1Lf1Q0dGTGFZ2d5YmwL8m2JrbkuW5UfLSO0
X-Gm-Gg: AfdE7cnUZ9AkVhY+JPMeE/9ax2gJE1QFbBKyRLbx+gmvkEd/CyjNiGtspWOqVaRHbej
	8+qx2ZIfoB6Cl7J+3eNKddocOulUj4KqAMOdBLiQJExz967fj8MjLriPBZxWlcIiRiNffMsSVpA
	SU0MDmM87AZ2x4If6GhlyBkToqbdqcj/uJO/+9AvUPTB6+VmdSBzNmJuob/OW1u3Zy5MmehlbOg
	FGRMz1JXfm+5ICMAm2DgsYAU27+NZ31BqFC7Lv1K97ArXAI8QcwQWID6qu4XZaHHYesaC629Q==
X-Received: by 2002:a05:6820:1c8f:b0:6a0:f319:6903 with SMTP id
 006d021491bc7-6a122eac1eemr1928539eaf.6.1782305285702; Wed, 24 Jun 2026
 05:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623050127.48247-1-flyingpeng@tencent.com> <ajpVtFfp0ZxJUVc6@google.com>
In-Reply-To: <ajpVtFfp0ZxJUVc6@google.com>
From: Hao Peng <flyingpenghao@gmail.com>
Date: Wed, 24 Jun 2026 20:47:54 +0800
X-Gm-Features: AVVi8Cck4N0jVjEBdPt8z2NiUeKsXPaI3_32OPjsZRgozvDz876iAwOZ4EQ56xc
Message-ID: <CAPm50a+dn6RrSMpED-KzO2+TPkizyhhsv3=sNmS1jjLC3t81=g@mail.gmail.com>
Subject: Re: [PATCH] landlock: shrink tsync works[] on partial allocation failure
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: mic@digikod.net, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 5:45=E2=80=AFPM G=C3=BCnther Noack <gnoack@google.c=
om> wrote:
>
> Hello Peng!
>
> Thanks for your patch!
>
> On Tue, Jun 23, 2026 at 01:01:27PM +0800, Peng Hao wrote:
> > When the per-slot kzalloc fails mid-loop in tsync_works_grow_by(), the
> > already-enlarged s->works array keeps uninitialized trailing entries.
> > Shrink the array back to its used size on the error path so no waste
> > is carried over: free it outright when nothing has been allocated yet,
> > otherwise try a shrinking krealloc_array() (keep the larger array if
> > the shrink fails, since tsync_works_release() honors s->capacity).
> >
> > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > ---
> >  security/landlock/tsync.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> > index c5730bbd..356ce94b 100644
> > --- a/security/landlock/tsync.c
> > +++ b/security/landlock/tsync.c
> > @@ -272,9 +272,23 @@ static int tsync_works_grow_by(struct tsync_works =
*s, size_t n, gfp_t flags)
> >               work =3D kzalloc_obj(*work, flags);
> >               if (!work) {
> >                       /*
> > -                      * Leave the object in a consistent state,
> > -                      * but return an error.
> > +                      * Leave the object in a consistent state, but re=
turn
> > +                      * an error.  Shrink @s->works back to its used s=
ize to
> > +                      * avoid carrying uninitialized trailing entries.=
  A
> > +                      * shrinking krealloc_array() should normally suc=
ceed,
> > +                      * but if it does not we simply keep the larger a=
rray;
> > +                      * tsync_works_release() iterates only up to capa=
city.
> >                        */
> > +                     if (i =3D=3D 0) {
> > +                             kfree(s->works);
> > +                             s->works =3D NULL;
> > +                     } else {
> > +                             works =3D krealloc_array(s->works, i,
> > +                                                    sizeof(s->works[0]=
),
> > +                                                    flags | __GFP_NOWA=
RN);
> > +                             if (works)
> > +                                     s->works =3D works;
> > +                     }
> >                       s->capacity =3D i;
> >                       return -ENOMEM;
> >               }
>
> Can you please clarify your motivation for this?
>
> To paraphrase my understanding
>
> * You are not addressing a logic bug
>
>   The invariant for that data structure is that s->size <=3D s->capacity
>   and s->capacity <=3D number of elements in the array <=3D number of
>   sibling threads.
>
>   If the array is slightly larger than the capacity, that does not break
>   the invariant and should not result in out-of-bounds accesses.
>
> * You are addressing that the array is a bit larger than the capacity
>
>   This is in the case where kzalloc_obj() failed.  We set the capacity
>   to i (making sure that only the objects 0 to i-1 are being looked at),
>   and we return an error.  Sure, the array is overallocated a little
>   bit, but now that we are returning an error, the caller will
>   fast-track to abort the tsync due to ENOMEM and the array does anyway
>   get released very soon now.
>
>
> The state where we use slightly more memory (with number of entries <=3D
> number of sibling threads) is supposed to be very transient.
>
> Is the delay between raising the error and the final kfree() long enough
> that you have seen it cause problems in practice?
>
> Thanks,
> =E2=80=94G=C3=BCnther

You are right; the time between the error being triggered and the call to
kfree() is very short, so this patch is of little significance.

Thanks.

Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014F50A6D
	for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531138; cv=none; b=ucJ2mYTj5njoAti4b1c78LITan7j7or/ewPqqk4p95irgMZA+V3U5eIFSBIYhH/6O+JNgAsZI60w/eTpW2yx16gwPiVQW6xNjvFn+7jtCTuLUZHzzoI0tZ2+0m4Mq0zgW/2CLH3atw177zF6nzWyHbiHYcVLV+rbg6qlaric4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531138; c=relaxed/simple;
	bh=/ZgpRI4AF6gwCPK4c8uHtQHAKedmDPFs545dBq4SAB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ad2ck+zGmtLgaeCiE36mtCkTUV2e1RFlzNSNQKwtKLq+fNiNzZVBnt6p9QOJLAO2uFDKACJYlzcHfJ21FfAwn7afhJtmUobaUmCcPPiU/wq+jGbKR9mHE3xePq0E9d4iUKed7bOdRF9zccyBqwg/8/ADQcvwehew94rTmi1pDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rkfs5UmN; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rkfs5UmN"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso2320152276.1
        for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710531134; x=1711135934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtMX+4fb7hnGZr895IF2XxyKiAiwhcHtQMm/xfgh7Lc=;
        b=Rkfs5UmN1pIhOqWV0R4E4coIubAq1fN3sUdvjews+JlvnO3gv37WA2Wpm4uINQ7HC9
         +SPsLBBXNIb8RosSwrT4aeZ4Mg56jJbpKJOGaILY4vRL4XJk9zeQb/9gMS2A4WIVD1tW
         FsvLdy2Go16iG1gYXyJ0aXZ27tc/2M2GKaHb7vUvYDTE9VHLYHoN9oPnglk3X12Uc+Nq
         ZVGtt7XulS6sUkHbuiludTa27nr4XiTAvXVqeqledUeIcptRtDRCL3C/rwy083XPzzPU
         h46Heinz8sE6jzpM4pai3ZCUFPC2yaYXQvRcX2VEfaF5RgeTQd8s4X0Jwo1/ENp7EQ8+
         dN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710531134; x=1711135934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtMX+4fb7hnGZr895IF2XxyKiAiwhcHtQMm/xfgh7Lc=;
        b=B5ld+mvZ5uaAki5vq+5tKzF8n1chf2g5M0J12vf9t8nJ4sBOzfWNwMMGIObn/LGNc8
         5bDhDFDfZdsa3958Ixz6FPjpMLnLr5u90WCHp7FkxEn1gIlWgxBN3St8DOLRUYw5mVxD
         uskEl4ZRii8VFTtjBhQ/tJRk2n04wbfE99ziX6J/5+/efl4kxo0Jlf+4bugC01jQ5NHo
         O2wI1Nrbvexnn9gtUwtlYwucB68MnaW85u2g+p+1UM8JZD5GjLklq3y4iRwtGD3X+M3C
         q84ce4cfEBsaLh3Pe6CRFmEtITKeU0JYCrFHUPhfdQw+HYK81hJOhwMDnApZhE2AQ7PG
         R53A==
X-Forwarded-Encrypted: i=1; AJvYcCVm55ZCLDbXS4n2JOekocWY8C8/IaQK0P1s3QlCJZYBnACCrgJl2zDSant4C4TT0C7HKO744ntlF/V0dOYVmvOsiMH7eUeM1JphoHg2dderGJN+ycfB
X-Gm-Message-State: AOJu0Yz/13p9PSR2GmtoVtWyvgICe0E5AJM/UBOyrsP6NRm/te5GNNG7
	qpHQVkcDOkWQ50fuMrxlQ0JOjxlMKeq8keqPzMNe7Mc98Tq0FhhUWLcsKspAxyz7LUNWS2mG1SN
	acCM3OTuvbBge7AIcL2ZnGCGw8KhScB2Lzks9VtxpCCzybtw=
X-Google-Smtp-Source: AGHT+IFpLY4it3Gmmcs3EmaovZvOBkGpadzGqT37JjzqTeOsajRBr4cuVib5FkCPRJyjCY4lJpvIt5scdPUg1ikCxF4=
X-Received: by 2002:a25:acc5:0:b0:dcf:313d:d4ab with SMTP id
 x5-20020a25acc5000000b00dcf313dd4abmr5757251ybd.54.1710531133481; Fri, 15 Mar
 2024 12:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314022202.599471-2-paul@paul-moore.com> <20240315150208.GA307433@mail.hallyn.com>
 <7956284d-5687-465d-bbcc-d45435dac42e@schaufler-ca.com> <20240315161345.GA309097@mail.hallyn.com>
 <CAHC9VhS245LRsa3DhdkZ-u3+qvroygsyBm2q5mZWkOW8eOKOdQ@mail.gmail.com>
 <20240315162831.GA309358@mail.hallyn.com> <CAHC9VhRNG-uxJRTtbRO9o-G6F9JGWWtM8hR_ofFRzrcBRxDcUg@mail.gmail.com>
 <20240315170052.GA310015@mail.hallyn.com>
In-Reply-To: <20240315170052.GA310015@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Mar 2024 15:32:02 -0400
Message-ID: <CAHC9VhQ6jmDDa10d56mSAqsYeXqNNm7yFD7gaFfh7YmyVVp3gw@mail.gmail.com>
Subject: Re: [PATCH] lsm: handle the NULL buffer case in lsm_fill_user_ctx()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 1:00=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Fri, Mar 15, 2024 at 12:42:27PM -0400, Paul Moore wrote:
> > On Fri, Mar 15, 2024 at 12:28=E2=80=AFPM Serge E. Hallyn <serge@hallyn.=
com> wrote:
> > > On Fri, Mar 15, 2024 at 12:19:05PM -0400, Paul Moore wrote:
> > > > On Fri, Mar 15, 2024 at 12:13=E2=80=AFPM Serge E. Hallyn <serge@hal=
lyn.com> wrote:
> > > > > On Fri, Mar 15, 2024 at 09:08:47AM -0700, Casey Schaufler wrote:
> > > > > > On 3/15/2024 8:02 AM, Serge E. Hallyn wrote:
> > > > > > > On Wed, Mar 13, 2024 at 10:22:03PM -0400, Paul Moore wrote:
> > > > > > >> Passing a NULL buffer into the lsm_get_self_attr() syscall i=
s a valid
> > > > > > >> way to quickly determine the minimum size of the buffer need=
ed to for
> > > > > > >> the syscall to return all of the LSM attributes to the calle=
r.
> > > > > > >> Unfortunately we/I broke that behavior in commit d7cf3412a9f=
6
> > > > > > >> ("lsm: consolidate buffer size handling into lsm_fill_user_c=
tx()")
> > > > > > >> such that it returned an error to the caller; this patch res=
tores the
> > > > > > >> original desired behavior of using the NULL buffer as a quic=
k way to
> > > > > > >> correctly size the attribute buffer.
> > > > > > >>
> > > > > > >> Cc: stable@vger.kernel.org
> > > > > > >> Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling =
into lsm_fill_user_ctx()")
> > > > > > >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > > > >> ---
> > > > > > >>  security/security.c | 8 +++++++-
> > > > > > >>  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > > > >>
> > > > > > >> diff --git a/security/security.c b/security/security.c
> > > > > > >> index 5b2e0a15377d..7e118858b545 100644
> > > > > > >> --- a/security/security.c
> > > > > > >> +++ b/security/security.c
> > > > > > >> @@ -780,7 +780,9 @@ static int lsm_superblock_alloc(struct s=
uper_block *sb)
> > > > > > >>   * @id: LSM id
> > > > > > >>   * @flags: LSM defined flags
> > > > > > >>   *
> > > > > > >> - * Fill all of the fields in a userspace lsm_ctx structure.
> > > > > > >> + * Fill all of the fields in a userspace lsm_ctx structure.=
  If @uctx is NULL
> > > > > > >> + * simply calculate the required size to output via @utc_le=
n and return
> > > > > > >> + * success.
> > > > > > >>   *
> > > > > > >>   * Returns 0 on success, -E2BIG if userspace buffer is not =
large enough,
> > > > > > >>   * -EFAULT on a copyout error, -ENOMEM if memory can't be a=
llocated.
> > > > > > >> @@ -799,6 +801,10 @@ int lsm_fill_user_ctx(struct lsm_ctx __=
user *uctx, u32 *uctx_len,
> > > > > > >>            goto out;
> > > > > > >>    }
> > > > > > >>
> > > > > > >> +  /* no buffer - return success/0 and set @uctx_len to the =
req size */
> > > > > > >> +  if (!uctx)
> > > > > > >> +          goto out;
> > > > > > > If the user just passes in *uctx_len=3D0, then they will get =
-E2BIG
> > > > > > > but still will get the length in *uctx_len.
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > > To use it this new way, they have to first set *uctx_len to a
> > > > > > > value larger than nctx_len could possibly be, else they'll...
> > > > > > > still get -E2BIG.
> > > > > >
> > > > > > Not sure I understand the problem. A return of 0 or E2BIG gets =
the
> > > > > > caller the size.
> > > > >
> > > > > The problem is that there are two ways of doing the same thing, w=
ith
> > > > > different behavior.  People are bound to get it wrong at some poi=
nt,
> > > > > and it's more corner cases to try and maintain (once we start).
> > > >
> > > > I have a different perspective on this, you can supply either a NUL=
L
> > > > buffer and/or a buffer that is too small, including a size of zero,
> > > > and you'll get back an -E2BIG and a minimum buffer size.  What's th=
e
> > > > old wisdom, be conservative in what you send and liberal in what yo=
u
> > > > accept?
> > >
> > > But if you pass a NULL uctx, then surely you should send *uctx_len=3D=
0.
> > > And that is already handled.
> >
> > Why should we assume that userspace is always going to behave a
> > certain way?  Userspace is going to do crazy stuff, that's a given, I
> > just want to make sure that we protect ourselves against the really
> > crazy stuff, and if we can do something useful with the moderately
> > crazy stuff I think we should.
> >
> > > What you are adding is that the user can pass NULL uctx, but a large
> > > uctx_len value.
> > >
> > > Perhaps should change my objection, and say that I would prefer the
> > > comment fix to suggest passing in uctx_len=3D0 and uctx=3DNULL, and e=
xpect
> > > a -E2BIG.  The NULL check can stay (though I still think it should
> > > return -E2BIG).
> > >
> > > Because with the current comment update, the user may pass in
> > > uctx=3DNULL, but the actual rv will change between 0 and -E2BIG
> > > depending on the uctx_len they sent in.  Which is whack, since
> > > the incoming value means nothing.
> >
> > I think that's a desirable behavior, if you pass in a NULL buffer
> > we'll provide you with the required size and return -E2BIG if the size
> > you gave us was too small, and zero/success if the size you provided
> > was adequate.
> >
> > Maybe I'm being stupid and this really is "whack", but you've got to
> > help me understand what harm can come from the behavior above.
>
> Returning success if uctx=3D=3DNULL and uctx_len is big enough sends the
> message that this -sending a non-zero length and uctx=3DNULL is a
> recommended use case.  It should not be a recommended use.

I would argue that simply tolerating a given input and recommending
its use are two different things.  I'm not sure we're officially
recommending any particular usage, we just describe how the syscall
works and we let userspace do as they see fit within those
constraints.

> If the user wants to find out the size of the buffer, they can already
> do so more reliably in the pre-existing way, passing in a *length=3D0 (an=
d
> a NULL or random uctx).  I say more reliable, because they can predict
> the function return value in this case: -E2BIG.

As you well know, there is nothing preventing that use case.

> So the only way uctx=3D=3DNULL and uctx_len!=3D0 should happen is by acci=
dent,
> and in that case sending back 'success' is misleading.

Noted, but I disagree primarily on the grounds that this implies both
a preference for a particular use case (see above) as well as the
impossibility of understanding the intention behind all of the
userspace applications that may make use of this in the future.

> > ...  What's the
> > old wisdom, be conservative in what you send and liberal in what you
> > accept?
>
> If you've received garbage, you should let the sender know, rather than
> return 'success' in the hopes that it wasn't important.
>
> But anyway I'll stop here - it doesn't break anything directly, I just
> think it's a bad API with the potential for future harder to spot bugs.

Fair enough, thank you for the review and debate.

For others tuning into this thread, I believe it is important to
mention that this patch restored an API behavior that had been in
existence for several months (all?) of the original patchset's life;
the best time to suggest changes to that behavior was during those ~16
months.  If we were to change the API behavior now, we would need to
have some demonstrated harm, e.g. 32-bit/64-bit ABI incompatibility,
to consider a change.

--=20
paul-moore.com

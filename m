Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAC9481A3
	for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519561; cv=none; b=XFkSMTr4q8raqEOi4gB8wJqUH+JETPlsH3Z4YAgJ/x2ws+9tgB54prLxNG7S5uFQWy89U/ZskxMsrlh4fbONiHJdQpS28Tl0nyX1w8ms0s7Yo0rzXyLaG+4rditB8B3ssN8ECTESpRQFg+HUjYypDQWlC/iymNIMiN9JxSLFJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519561; c=relaxed/simple;
	bh=4/DbjDa3e3xF2X1/qXxo7luY0jnFhXgjsvn9dlHTOtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbORpA9d+2Ed1+bOtX1siQPAtA+peGfB6cuEgjT5bpJ5FK7HFLUMcXJs94yT/e4BlrkNT9J5ADcRz0+Uvi4+AmGTzbcVsJ+nxZMaHAvJLcwY3ZwkhkTm5mbwYcnenwaXyLo6AkCU2NoMh5HkdKV4cr0/XMqjlVRS/3DjnuEIW/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ubbo3NG4; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ubbo3NG4"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so2016444276.2
        for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710519556; x=1711124356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpqVOPnTA7d3Wx5FtTkXIkNetoNkwXWVCHLT+793scw=;
        b=Ubbo3NG47UoplUhCT+2wLnKioPhOiC+SKSKie2ECWmjheem6fMuI78pn/Se26tnde4
         CuRLW8sFCN3F5WH9nmZA0QySdQIUS8v4rFb/chMsGjuSMpGO0r9N8mUlK865PlOUyNdT
         YRIzew+2T0tR5wVT02aeQI9mlso9B1ZMnJRjsHrjYW1CTtNuaNAJmSitAWM4ljWTcgL6
         sooLzPY6rU59S0s4e27u43BtoZKRkNplwOWePC2HTOq/BvOnxg9VFkK6zwtot1fFjnDm
         6LP41LTwV6ynuM7MXhx2V58c5UHdvM5qfqAGQHIOi7Ef4zryCeBilhZxMdylEoYcFgWN
         3sJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710519556; x=1711124356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpqVOPnTA7d3Wx5FtTkXIkNetoNkwXWVCHLT+793scw=;
        b=Btx5QBSdqtCIwKHfURdmZR9vo0kZOZzzJ9vEPjGCZIqDsfvUWyZNuGzvOy6wrSb9zX
         zCA7ak6RyYGykNtVSUwua8vZcqiJLLF9OVzR2uv18Fo7HdIJkRz5h2EYtzs2XY/BewzP
         t5yE7lm64mX1xfPMqKDyvfPv68tKbgRx+ceggJf+7Fsf8X4fzDY7DjokF85KvADDcIvX
         Pu2byn/0P4l7vPuYDILW2+GJO4bl0+8YYJsgLrvRcDE2ZCwwsZ1Bn0e+K056W5BTdHRE
         EEc2oDhJUpVW1xvK2ldy3XCh8kzGdTZYtNWzD5gMOre5OQSAd8KQ+hUJyoIjHpcXOnY7
         Ch+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBR8mzUZG1ybxQ37bXul8PT5ipkgxXD9bQRqWm+C5h+REILRN8Zc2qraLyAGo7svATMRe+Gn0Y4sinQOvk59sn0Z1l8KF8qcl7YsgCiWxqSI8+RtdJ
X-Gm-Message-State: AOJu0YzBwFK7cDWcUUSXZ6q5v5ZUBPygRWwn9nDUKZRN51eBko4ZrPe1
	I+X6/ai7LR/mlTA1GwX4YG4T9UJgl0ERSg/63fR5EUQXnBEP0bAC/CveJL864EWaOORPmT9FFOx
	jUdoP7Hg7QBgviEhupFGx+ZIZ4H/ZaCBRZoxUt5TQa75Hdka5FA==
X-Google-Smtp-Source: AGHT+IEC2mU7APitabgJ7NuhlgzkegEs6wg/E1S/p4WFYfKx2O8NWmetgFwWpGIjtC71eHm1m2/QZPErbq0ZTyFGsc8=
X-Received: by 2002:a25:a547:0:b0:dc6:cf96:2956 with SMTP id
 h65-20020a25a547000000b00dc6cf962956mr5414498ybi.44.1710519555762; Fri, 15
 Mar 2024 09:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314022202.599471-2-paul@paul-moore.com> <20240315150208.GA307433@mail.hallyn.com>
 <7956284d-5687-465d-bbcc-d45435dac42e@schaufler-ca.com> <20240315161345.GA309097@mail.hallyn.com>
In-Reply-To: <20240315161345.GA309097@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Mar 2024 12:19:05 -0400
Message-ID: <CAHC9VhS245LRsa3DhdkZ-u3+qvroygsyBm2q5mZWkOW8eOKOdQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: handle the NULL buffer case in lsm_fill_user_ctx()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 12:13=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Fri, Mar 15, 2024 at 09:08:47AM -0700, Casey Schaufler wrote:
> > On 3/15/2024 8:02 AM, Serge E. Hallyn wrote:
> > > On Wed, Mar 13, 2024 at 10:22:03PM -0400, Paul Moore wrote:
> > >> Passing a NULL buffer into the lsm_get_self_attr() syscall is a vali=
d
> > >> way to quickly determine the minimum size of the buffer needed to fo=
r
> > >> the syscall to return all of the LSM attributes to the caller.
> > >> Unfortunately we/I broke that behavior in commit d7cf3412a9f6
> > >> ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
> > >> such that it returned an error to the caller; this patch restores th=
e
> > >> original desired behavior of using the NULL buffer as a quick way to
> > >> correctly size the attribute buffer.
> > >>
> > >> Cc: stable@vger.kernel.org
> > >> Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into lsm=
_fill_user_ctx()")
> > >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >> ---
> > >>  security/security.c | 8 +++++++-
> > >>  1 file changed, 7 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/security/security.c b/security/security.c
> > >> index 5b2e0a15377d..7e118858b545 100644
> > >> --- a/security/security.c
> > >> +++ b/security/security.c
> > >> @@ -780,7 +780,9 @@ static int lsm_superblock_alloc(struct super_blo=
ck *sb)
> > >>   * @id: LSM id
> > >>   * @flags: LSM defined flags
> > >>   *
> > >> - * Fill all of the fields in a userspace lsm_ctx structure.
> > >> + * Fill all of the fields in a userspace lsm_ctx structure.  If @uc=
tx is NULL
> > >> + * simply calculate the required size to output via @utc_len and re=
turn
> > >> + * success.
> > >>   *
> > >>   * Returns 0 on success, -E2BIG if userspace buffer is not large en=
ough,
> > >>   * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated=
.
> > >> @@ -799,6 +801,10 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uc=
tx, u32 *uctx_len,
> > >>            goto out;
> > >>    }
> > >>
> > >> +  /* no buffer - return success/0 and set @uctx_len to the req size=
 */
> > >> +  if (!uctx)
> > >> +          goto out;
> > > If the user just passes in *uctx_len=3D0, then they will get -E2BIG
> > > but still will get the length in *uctx_len.
> >
> > Yes.
> >
> > > To use it this new way, they have to first set *uctx_len to a
> > > value larger than nctx_len could possibly be, else they'll...
> > > still get -E2BIG.
> >
> > Not sure I understand the problem. A return of 0 or E2BIG gets the
> > caller the size.
>
> The problem is that there are two ways of doing the same thing, with
> different behavior.  People are bound to get it wrong at some point,
> and it's more corner cases to try and maintain (once we start).

I have a different perspective on this, you can supply either a NULL
buffer and/or a buffer that is too small, including a size of zero,
and you'll get back an -E2BIG and a minimum buffer size.  What's the
old wisdom, be conservative in what you send and liberal in what you
accept?

--=20
paul-moore.com

Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD212F5A1
	for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977612; cv=none; b=KxaogoB0LbzV7ICZ9KvETPY82g5uuv2teNRwfWTDGsi8ZTveu4qxk0K7aeHvrMyg30ou6PvUGufSyLiRo8pQLbKTYlQcpWkF4cuMTI7TdAZOLhqiQlHspjtyoepSh6wKuZR/OkoXNzGB6/UH/NLxL6IiYunjU7wuR4YuF8q/Kvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977612; c=relaxed/simple;
	bh=pehUlEWHJhuRq9lM7KavvQJzY5vJpoSwudZUjolrSuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t99WvdIYapsRQRGLDuM0hakRXvo/Hq6+aqm4jkxqOGAJkmMQb+VN4X3teoNbrZWsGS5fxaCZ43iXLE4tiQt6/xieyUwA2Q4pJRGqW/rtdo7T0AI3Zso7uO6b49gZ73wnvxb4ewjuKn1SCmTQT5qSg8KApQHm9FiTqJXo6/s0dec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Vu0ltbrW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Vu0ltbrW"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-607dec82853so37055887b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 12:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708977610; x=1709582410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMyH3X6y0ghY91KBV/IXMi8hinan8vTup4YSJD234YQ=;
        b=Vu0ltbrWtBfntQBiqMOXofE/xsoZFs0qnwabmBXg2gZBbRjxNb2r8hC4eBn7FLc99M
         un+ei2VMF9y1YGWnSzSkbs4S7suJNMbjP9H/iEaFRHCjYr4Guni2+3X0H8zN/YElaMED
         Sq1pRyIao3TGcVuFlDUKXP5TZ3WlSSOLr3/d41LYh4cCYppPD8KcSN9xSENfirqlR4vO
         1ypQKraoUEHU0IunmWgzNrVuC/wWapFmyXTfJzjhUTRPfhxpJh46vq/rrGz2xbTViXY0
         wr9YPFH7+jduOS2vyzwn5QF8cU8fBQg05UboGcEtoydnqTQpNWuHf7bU5O8MDs1O8xDe
         4HvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708977610; x=1709582410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMyH3X6y0ghY91KBV/IXMi8hinan8vTup4YSJD234YQ=;
        b=huEbp2DwgAuzRAjth5kx9xMW7SKolPiQcZ90waZTH0mEeEudDrXKCcFEhWQ99svccO
         GINqNW5+zStE9nKmWo57E7NXxq/pH5hmGPbcWY6U9ZR+RqEXGDCPLtqKi2sO9ykZjCz7
         0fzaYmZ9EFquJbo5I3Z0JNyfiecedRrttM8oGANpMVjc2w0o3XrcFtEBhCY7LAMSBuA2
         0fBEv470qLuyVQw7hMABP+gwlGyFdHClkm2rFDcE5HB/ApkZUpRhrFra0CvmcWBztAzC
         dbI8ib7gT7nNadROsKyoA1hX/wjPzHwBBUXkyhecU3bPcifxotNL2pwU4Pw566REL3H7
         v1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUgjmwLHs6l0rsqtJ0itNRSMGMIoQiI5edVXuxoFNhX9zRdOV91wBibvsbcY9lLAak/NJfRN6Bfqa6dLzICXM+Dy/EM/6GmIvGrY+AY6acfWmISiT6s
X-Gm-Message-State: AOJu0Yz9NvDsKoM+zIMtvhbhKmPbrQMGON09HjhOBQ2jwmMcnC7jwKOy
	7+PRxevH1cL7t4+Hvga8ZrqRwEy5w8zjZW2XxOmrPXU0Z0mhf0ehDHkZXLhZPyRhNOTtUYcV0nP
	YcOGPiW9kj5rY8KHmKz1YSCSE+UyNz7RUC1c1
X-Google-Smtp-Source: AGHT+IH9gi+JHHei3aslePPRBmX+ggOjwi0k4abScoUltl6mqfTgxhLuJg5zV2FSQNlPizp/84gScLMILBMR1UO0cxY=
X-Received: by 2002:a25:8b89:0:b0:dc6:bbbc:80e4 with SMTP id
 j9-20020a258b89000000b00dc6bbbc80e4mr206159ybl.4.1708977610011; Mon, 26 Feb
 2024 12:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
 <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
In-Reply-To: <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Feb 2024 14:59:59 -0500
Message-ID: <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@dig=
ikod.net> wrote:
> >
> > aa_getprocattr() may not initialize the value's pointer in some case.
> > As for proc_pid_attr_read(), initialize this pointer to NULL in
> > apparmor_getselfattr() to avoid an UAF in the kfree() call.
> >
> > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: John Johansen <john.johansen@canonical.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > ---
> >  security/apparmor/lsm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> If you like John, I can send this up to Linus with the related SELinux
> fix, I would just need an ACK from you.

Reviewed-by: Paul Moore <paul@paul-moore.com>

This patch looks good to me, and while we've still got at least two
(maybe three?) more weeks before v6.8 is tagged, I think it would be
good to get this up to Linus ASAP.  I'll hold off for another day, but
if we don't see any comment from John I'll go ahead and merge this and
send it up to Linus with the SELinux fix; I'm sure John wouldn't be
happy if v6.8 went out the door without this fix.

> > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > index 98e1150bee9d..9a3dcaafb5b1 100644
> > --- a/security/apparmor/lsm.c
> > +++ b/security/apparmor/lsm.c
> > @@ -784,7 +784,7 @@ static int apparmor_getselfattr(unsigned int attr, =
struct lsm_ctx __user *lx,
> >         int error =3D -ENOENT;
> >         struct aa_task_ctx *ctx =3D task_ctx(current);
> >         struct aa_label *label =3D NULL;
> > -       char *value;
> > +       char *value =3D NULL;
> >
> >         switch (attr) {
> >         case LSM_ATTR_CURRENT:
> > --
> > 2.43.0

--=20
paul-moore.com

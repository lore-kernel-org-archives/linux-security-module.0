Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492EC55794
	for <linux-security-module@vger.kernel.org>; Fri,  8 Mar 2024 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895786; cv=none; b=dDUlPpcBbhUIrz9tT2Om71oJ4HRhksaMmj4zTQBXxVgFWGAsFYfj+Rhf9ig0eIFpDkEMs5HnA9jL7vZtFDuo/sYHyNBzIqxSE/qJ4vs3csE5WanNZYHxGhnBh/rbGYuoiTg6PbtQ2y55YTY/h/ogAUrzeqgkF2ORpOPDGr7GSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895786; c=relaxed/simple;
	bh=ZJKrLL22A7H4JxricotzzoWXArs2LWgdGGY0bhUgfj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s9f0wEKSUf4tTcxnDsPflUGwbzqz7itRde3Z581jIFT4zofZELo3erlfmvSjN+6nnmybAiEz1ZokmVqkToKlwd3/122uusDYCcO0Zfd3NLIb7D1I8IaocWBijyLMYlVoriFo5kQOrhFnQOwPJrnVTiN4OkQpKtDwp3YnFBejo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xAeWWqFG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xAeWWqFG"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso3758309276.0
        for <linux-security-module@vger.kernel.org>; Fri, 08 Mar 2024 03:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709895784; x=1710500584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNJ3BotNWwVrqapBf4UjRIQk6oxTmFA1CYe6YAxf1wg=;
        b=xAeWWqFG93TUqQNXjs+/enCQoho1xOcYTY9fJmv2Pl2R9gjY9Pmmx/59i42PhsdYwS
         5qb9FvEmYpZ7mklY7Xvad6GOyW8L1jI1vFg69ymR8RqxK2AYh/zVb4GHnJBBUf+w6grT
         2y+UT/1VbcXejbuSXMbDM/p80uFE3K42noB//e1NnPuRgTaB+zlZuEHFZkeYNQ5UZuQ9
         tfR6Lqu4NO8JpGPeGn+VAoNf8l14T/FK0Vz1U8K6M0zDVaBautTjP7O7/XZZTS/u43od
         dEn1TVSTY9IzZBUGXUHH3DV7xGU1MQXNwBBMNiqID5W8gG5E+UDQGhQdwgf+CQeHj4p3
         5TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895784; x=1710500584;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MNJ3BotNWwVrqapBf4UjRIQk6oxTmFA1CYe6YAxf1wg=;
        b=dK42z6NaK0TkmNE0cMpUGfyYyUvNWDTG8UJc7fr8JF10Y/AXnCGFR83S/q4uDGMdH0
         AL1aIHdynoCMMn4x66JjTCust4lxxHmjrCeium9sXzAz2kD358RK/p71wtJsZ2VjvLLa
         hYbEu6cL889o3PzDIDt31WqUpbfVV+2Zdd6Yw8gfSDxtZPMLJBTDwSdV7glu2E7ysuJh
         L6aUMZR9B1/8kLc4hELKcGLprbAnL2AuP5kEyPPEJy9HkUouNMjmvSq4SkOeo1Cxd0Oj
         QHt1OXxSiT/VgPEAo110ZZGNW/2q+adfp3xFIR3n8y2S1PkUNf119RT+IKPsDTxTP5kA
         zQAg==
X-Forwarded-Encrypted: i=1; AJvYcCXO3fAXhk2xg21g7wrByhJKxIKvnJ/lhiTCnoyNuuaHtgM9p/f6QFpmH4nA8zlHgofOJbecLFykIobvflqq3b+8hOtn5Aj5qSOOl9oB4J5m4I3p7yd9
X-Gm-Message-State: AOJu0YzgAptC/MKr/sAr9+r1xdH2kPY+/fUHe6D+wduZ+I5gCs4Vh8r+
	1ivpEZA/wNEpmaws7V4eMF3BRSM2a1L+KiQjRx4tG5knugMMMFUVI8wesLhrPbJnY2przLOiWjT
	elg==
X-Google-Smtp-Source: AGHT+IHGcBZeWomIzIFwBfiOMFlxUFOTFyc9Ir8QWf3t3gN0b20h6ulZiuDs4iuC0WQMN8fZn6ZxBI8oY4E=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:154c:b0:dbd:b4e8:1565 with SMTP id
 r12-20020a056902154c00b00dbdb4e81565mr1138104ybu.4.1709895784371; Fri, 08 Mar
 2024 03:03:04 -0800 (PST)
Date: Fri, 8 Mar 2024 12:03:01 +0100
In-Reply-To: <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219183539.2926165-1-mic@digikod.net> <ZedgzRDQaki2B8nU@google.com>
 <20240306.zoochahX8xai@digikod.net> <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
 <20240307-hinspiel-leselust-c505bc441fe5@brauner> <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com> <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area> <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
Message-ID: <ZervrVoHfZzAYZy4@google.com>
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Chinner <david@fromorbit.com>, Paul Moore <paul@paul-moore.com>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 08:02:13AM +0100, Arnd Bergmann wrote:
> On Fri, Mar 8, 2024, at 00:09, Dave Chinner wrote:
> > On Thu, Mar 07, 2024 at 03:40:44PM -0500, Paul Moore wrote:
> >> On Thu, Mar 7, 2024 at 7:57=E2=80=AFAM G=C3=BCnther Noack <gnoack@goog=
le.com> wrote:
> >> I need some more convincing as to why we need to introduce these new
> >> hooks, or even the vfs_masked_device_ioctl() classifier as originally
> >> proposed at the top of this thread.  I believe I understand why
> >> Landlock wants this, but I worry that we all might have different
> >> definitions of a "safe" ioctl list, and encoding a definition into the
> >> LSM hooks seems like a bad idea to me.
> >
> > I have no idea what a "safe" ioctl means here. Subsystems already
> > restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, so
> > "safe" clearly means something different here.
>=20
> That was my problem with the first version as well, but I think
> drawing the line between "implemented in fs/ioctl.c" and
> "implemented in a random device driver fops->unlock_ioctl()"
> seems like a more helpful definition.

Yes, sorry for the confusion - that is exactly what I meant to say with "sa=
fe".:

Those are the IOCTL commands implemented in fs/ioctl.c which do not go thro=
ugh
f_ops->unlocked_ioctl (or the compat equivalent).

We want to give people a way with Landlock so that they can restrict the us=
e of
device-driver implemented IOCTLs, but where they can keep using the bulk of
more harmless IOCTLs in fs/ioctl.c.

> This won't just protect from calling into drivers that are lacking
> a CAP_SYS_ADMIN check, but also from those that end up being
> harmful regardless of the ioctl command code passed into them
> because of stupid driver bugs.

Exactly -- there is a surprising number of f_ops->unlocked_ioctl implementa=
tions
that already run various resource management and locking logic before even
looking at the command number.  That means that even the command numbers th=
at
are not implemented there are executing code in the driver layer, before th=
e
IOCTL returns with an error.

So the f_ops->unlocked_ioctl() invocation is in itself increasing the surfa=
ce of
exposed functionality, even completely independent of the command number.  =
Which
makes the invocation of f_ops->unlocked_ioctl() a security boundary that we
would like to restrict.

=E2=80=94G=C3=BCnther

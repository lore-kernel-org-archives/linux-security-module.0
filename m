Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CB81D8DFB
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737747737; cv=none; b=fRI87PesDLm05vHecHNWrjBvs/496HLo7vyDRaKUgPg83ygyTXEh6P/9wVhbH1kB3zAku1hXT/thDvI0MzFNwyvjGhd7Rt0cQmSnFx5uvtF1bXpzZQoPbjrYz7Y6LFsm/n440+6Ji3HMuBaLfkEH7R/Pr/ll//QHUA5iDXNWdAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737747737; c=relaxed/simple;
	bh=LOcZP2MWkunMU5CaG97gBeceOs7WzhpkJ/ocePxIe1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQVRMicTbABSWkhcUemb3oEzr/fLotmkj9Cob+4fQDGb6hi44RuEMey6M3MYqh+56f4uKgIYpP73WHfob7892ZhkkmoCASBQnjrEPLWKqZ/xLtTMW5wA4W6jyMs2xRK4SHlUt8c7tY7rUT7YaUDRDQTWpJn8lAL5AVwCjIue76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I+bkXlXM; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I+bkXlXM"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e53a5ff2233so4690252276.3
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 11:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737747734; x=1738352534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMBH0ZhxbkV5DY/rNSu8ZUcKmjgqBQkrkiUCCucIEnI=;
        b=I+bkXlXM11cEDteH/vZicxyAXdR1jONZaObQaPAdScXJpTXFgwma9JFwltmCRV9tRM
         zDFgPVCDrml3dny1Fn993kHc3yTkIGUHqJiesSS7tZO0bMc4m2HU0YKgr9wAm2xOhZwF
         pXuEfjjT0dXKQh3/cwFFOvCiRj8j24/N9sJUXfmWbCCaUGcLlDJGnT0Jl6z3OvtX+T3P
         0D173Vq2b6HgbQtaziDsGw6Kh+/YfSooFFniyAGgppUdoCrKF2I+kYZ/Vcy1yoh9kUzp
         RRGxrVmpRsyefPe2zqt2n2efsskS1w7cpNvKNpil4vEm0IM5+G2fxP/Uc5SmlnGGO4Q7
         p7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737747734; x=1738352534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMBH0ZhxbkV5DY/rNSu8ZUcKmjgqBQkrkiUCCucIEnI=;
        b=beYhUuj/xFBwmxokmS6zzQ9vLhmbsSrhCFDnubj2SRsF3Y3XrVtDQebL2PiSJfE1Dn
         bJuJDoPmSmhcWdVxErt/X9Z8db3zMc6JPZVHLYKjrfAjl59E/FRd6k5ExXQR6eSo9wS9
         cyJ7h1ZPES9EcPO1AAVHqLGobaaoDMyIonk4qK9pblECdoER8/z/KIEGvMRGO1FEOu09
         gebSRmTpmovVm97jrOQGI4ZJmuKvEB0KT76RCoDBIMG85tovVW2XeASnaUvSkHfGIyo7
         kLFcksg38d+nt/NLNBLKP04nsbP2ceMY13xVh/AwQs7u4g+/tHO9kVBZsquga+ZNcHPx
         7i8A==
X-Forwarded-Encrypted: i=1; AJvYcCVyQdVGdu7FH9UDcHGEYRKZ5qrKZDhnQCcgM2Mrs90uo4fheIq/sz/3o9Z7bQF5him90kBTapFqdkuPcpsGRuQFbKdV08M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuX5PE1eqM45Qb+9TMN81YBP7pRrzWBw+xRLTfyNb1tQGN6hjW
	z6DX3cTW3lgLB9v0GEcdRa7bcHn8Df4N2xzoXi7njWsM05B+X/TfvENuN4nsS8Wq1tX880hwqo8
	O9n5F/dfh7sUBLtwLwftUoowPI+PK8kg/eXQh
X-Gm-Gg: ASbGncvqFExobAv7G3v9mMgrFIGtgeNRfGXPUIgX6Z4gAY+Cls6XqE7XDgMl0y1n3Ht
	Ndv9vnFZCyKxI7ynsQkCJ2NFR8gd5CyN/K/jIRCjpm/Xr9yA9e3fQU9g54jW7
X-Google-Smtp-Source: AGHT+IEB80AwOAr20lltcMAVYj2Q5O/O1syKcaxZw94Eb3ZwUGhoxZjS+paX2hYaNHohU8nJATBsBX2CgfJhqQkR3iY=
X-Received: by 2002:a05:690c:9b0d:b0:6e5:aaf7:68d0 with SMTP id
 00721157ae682-6f6eb688c7dmr272043147b3.18.1737747734626; Fri, 24 Jan 2025
 11:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675f513a.050a0220.37aaf.0106.GAE@google.com> <20241217182657.10080-2-leocstone@gmail.com>
 <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com>
 <CAHC9VhRektpFHeUirRP8MH3NkmHWyy4BLcrDpy9zJH=ZJD4gRw@mail.gmail.com> <CAJ-EccNAzKwJt_wyRDWCrfP2dkBExsWumBGoNbfxG506erCoRg@mail.gmail.com>
In-Reply-To: <CAJ-EccNAzKwJt_wyRDWCrfP2dkBExsWumBGoNbfxG506erCoRg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 24 Jan 2025 14:42:03 -0500
X-Gm-Features: AWEUYZlFKKS7fQP2G2RpvOJtE8colSf6iojK44CDH4fQJbEDVBri3iOJY7LrA84
Message-ID: <CAHC9VhRWjSmMGDD9TARk6Xw+-+rJH_N5UeO6BqpAmfEtRcS87Q@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: check size of writes
To: Micah Morton <mortonm@chromium.org>
Cc: Leo Stone <leocstone@gmail.com>, 
	syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:24=E2=80=AFPM Micah Morton <mortonm@chromium.org>=
 wrote:
> On Sat, Jan 4, 2025 at 7:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > On Wed, Dec 18, 2024 at 4:51=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Dec 17, 2024 at 1:27=E2=80=AFPM Leo Stone <leocstone@gmail.co=
m> wrote:
> > > >
> > > > syzbot attempts to write a buffer with a large size to a sysfs entr=
y
> > > > with writes handled by handle_policy_update(), triggering a warning
> > > > in kmalloc.
> > > >
> > > > Check the size specified for write buffers before allocating.
> > > >
> > > > Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4eb7a741b32160200=
43a
> > > > Signed-off-by: Leo Stone <leocstone@gmail.com>
> > > > ---
> > > > v2: Make the check in handle_policy_update() to also cover
> > > > safesetid_uid_file_write(). Thanks for your feedback.
> > > > v1: https://lore.kernel.org/all/20241216030213.246804-2-leocstone@g=
mail.com/
> > > > ---
> > > >  security/safesetid/securityfs.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > >
> > > Looks okay to me.  Micah, are you planning to merge this patch, or
> > > would you like me to take it via the LSM tree?
> > >
> > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > >
> > > I'm going to tag this to come back to it in a week or so in case we
> > > don't hear from Micah, but if you don't see any further replies Leo,
> > > feel free to send a gentle nudge ;)
> >
> > I'm going to go ahead and merge this into lsm/dev, if Micah has a
> > problem with that I can always remove/revert if needed.
> >
> > We may need to revisit safesetid's documented support status, but
> > that's a topic for another day.
>
> Sorry guys, I missed this one. I usually just check in weekly on my
> linux-security-users filter in my email inbox and see if any
> discussions include 'SafeSetID'.
>
> I must have skimmed over 'lsm: check size of writes' thinking it was a
> generic LSM patch rather than something specific to SafeSetID.
>
> I'll have to adjust my email settings so that emails which directly
> list me on the CC are sent to a specific folder for me to check more
> closely.

No worries, I'm just happy to hear you're still around and looking out
for patches :)

I'm assuming you are okay with that patch?  If not we still have time
to fix it up.

--=20
paul-moore.com

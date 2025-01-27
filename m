Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA15FDA7
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jan 2025 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737993938; cv=none; b=SspqKOx9sVak19keLmQ3GnMUWB83Nj5vN6vf3wprugic0boJ07fIYx8caRFksa02bwMzPzqs1ej87NWpe/yoDLemUTMBIFey4Zv+50pfk1Gd9hLUa6GGhMGdG9dN3seZrjWePBDn5TRg0Z+ZYqe2wmveBic13XwLzBv+ielRlLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737993938; c=relaxed/simple;
	bh=i8c9XUT2+PzdjjlJqgShCr3BS0twHVG+rrMukwPmjXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMJQkkdFVA/oFYTp6hWze0Bhfok/EOyij1e207ycR4T3C3Uow+nbsxuIrkGnYO7i8yKgIXYGainUZu5z4hpEEUcVb7hSUhYzO8+0FDgsIh3H/rqlhaS83rJYaLRpabf7ROwmWQXyesy8ClzAIsHZMHpFDq6AQGpuISosYdNCmgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ErTrLXht; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ErTrLXht"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e44654ae3so761391066b.1
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jan 2025 08:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737993935; x=1738598735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpT9nnLdkMtNx9of9sdla+BsN/9HUUmlb0E1+ZPiNUI=;
        b=ErTrLXhtiNUbP2yOqzZhYn7FZL+kPOxP5whrP+Nb1JV8yyi73wLAFLQ8z+nqLK9azQ
         dgaUM9GuH42jQflaIVR5sbfpt6i5ryYQY41Pk+XpeCindiJ8R4NLDZGAhcKGbvmNaEw2
         n75xNsd93/Q/bdXDpE2/jf83BKTIJUdI9DaXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737993935; x=1738598735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpT9nnLdkMtNx9of9sdla+BsN/9HUUmlb0E1+ZPiNUI=;
        b=Gv1PnAJAaA8zLJ0o52FBiscSDdqCG+SaViHzm7rVfOjjzrrQQLnzLnpkjDqME5jpYY
         2M3LN3tsxrSRsQfuWDaGvheII4VqlQkyft1fv9oXzgKwdIDKJHvp5EUYBYKuaEqKDQXO
         Cvq+JRdWVLidYkOulT4iJ6s4NO11KtQE3R96gI9rTaSGo/d5o7HYVDilz7mZn+Xf69BI
         /x7L8X4qDYw3cma1gIfDkvU2+7W3B9SgwSD7asdK2S6beNzEDgApgIMU/rG2LJ3HefqN
         0YjxT2mbcwNxy0AmGKx1bh52V1xCRJKlzjaikFEKAPpUngDMLRp0AusK01Q665U5vnMn
         Fliw==
X-Forwarded-Encrypted: i=1; AJvYcCVjJQxRl05OTRGyhoEn8O4LU73lALzgx7/As6IziuLWuxKOq6HJSDFJAHKJ4yuthin8lXULhtwZL7d0OTG/vnZDlKSOXEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7OzjZvf/5mqd0h7cv+gFOL/UfviXBKC0Y2eojJsisc0sbXtSk
	/YBQ2zDDP40nWugmf/wi1I799Z81zEjD+3KFbb3qAcVW9THG4iBOT/OWY2P8Y4N9ctqfYh+eNI5
	PlQaX+qgimL1KHgz5B91lfwpghrSBqkIN2MWD
X-Gm-Gg: ASbGncuwsUci+62x4IkBsSqqzUYhAhfOvbmBp/RZlPv9eXv0K1T9+A09DU1nCj6g2y6
	TjRavI9Exu2r+HIc/47sKMSRGhB1zQK2G6bt6/066/eWBeu9tHTO7xJTD0J+H6qM=
X-Google-Smtp-Source: AGHT+IH8UQ9s0x/USGO0ryiQc9PoqsKinsvKKDrHxxpETYg9vi2Jrkbsn+qDx03ChJA7t95EQVwRMvRx62Nw6vV2TFE=
X-Received: by 2002:a17:907:9721:b0:aa6:5ec2:966c with SMTP id
 a640c23a62f3a-ab38b0b9124mr3844518066b.7.1737993934834; Mon, 27 Jan 2025
 08:05:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675f513a.050a0220.37aaf.0106.GAE@google.com> <20241217182657.10080-2-leocstone@gmail.com>
 <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com>
 <CAHC9VhRektpFHeUirRP8MH3NkmHWyy4BLcrDpy9zJH=ZJD4gRw@mail.gmail.com>
 <CAJ-EccNAzKwJt_wyRDWCrfP2dkBExsWumBGoNbfxG506erCoRg@mail.gmail.com> <CAHC9VhRWjSmMGDD9TARk6Xw+-+rJH_N5UeO6BqpAmfEtRcS87Q@mail.gmail.com>
In-Reply-To: <CAHC9VhRWjSmMGDD9TARk6Xw+-+rJH_N5UeO6BqpAmfEtRcS87Q@mail.gmail.com>
From: Micah Morton <mortonm@chromium.org>
Date: Mon, 27 Jan 2025 08:05:23 -0800
X-Gm-Features: AWEUYZkKXdJ9ubv_M4ZYFiQ5BjY4CQZBPGs-ZqVDpV7v3-GtiFvWjA4GFb2c-f0
Message-ID: <CAJ-EccNE7O-Y_Ay-0udWR1vQ-6qcVihmSb7f1SyhbMP7TKdgpA@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: check size of writes
To: Paul Moore <paul@paul-moore.com>
Cc: Leo Stone <leocstone@gmail.com>, 
	syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 11:42=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Fri, Jan 24, 2025 at 2:24=E2=80=AFPM Micah Morton <mortonm@chromium.or=
g> wrote:
> > On Sat, Jan 4, 2025 at 7:49=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > >
> > > On Wed, Dec 18, 2024 at 4:51=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Tue, Dec 17, 2024 at 1:27=E2=80=AFPM Leo Stone <leocstone@gmail.=
com> wrote:
> > > > >
> > > > > syzbot attempts to write a buffer with a large size to a sysfs en=
try
> > > > > with writes handled by handle_policy_update(), triggering a warni=
ng
> > > > > in kmalloc.
> > > > >
> > > > > Check the size specified for write buffers before allocating.
> > > > >
> > > > > Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.co=
m
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4eb7a741b321602=
0043a
> > > > > Signed-off-by: Leo Stone <leocstone@gmail.com>
> > > > > ---
> > > > > v2: Make the check in handle_policy_update() to also cover
> > > > > safesetid_uid_file_write(). Thanks for your feedback.
> > > > > v1: https://lore.kernel.org/all/20241216030213.246804-2-leocstone=
@gmail.com/
> > > > > ---
> > > > >  security/safesetid/securityfs.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > >
> > > > Looks okay to me.  Micah, are you planning to merge this patch, or
> > > > would you like me to take it via the LSM tree?
> > > >
> > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > I'm going to tag this to come back to it in a week or so in case we
> > > > don't hear from Micah, but if you don't see any further replies Leo=
,
> > > > feel free to send a gentle nudge ;)
> > >
> > > I'm going to go ahead and merge this into lsm/dev, if Micah has a
> > > problem with that I can always remove/revert if needed.
> > >
> > > We may need to revisit safesetid's documented support status, but
> > > that's a topic for another day.
> >
> > Sorry guys, I missed this one. I usually just check in weekly on my
> > linux-security-users filter in my email inbox and see if any
> > discussions include 'SafeSetID'.
> >
> > I must have skimmed over 'lsm: check size of writes' thinking it was a
> > generic LSM patch rather than something specific to SafeSetID.
> >
> > I'll have to adjust my email settings so that emails which directly
> > list me on the CC are sent to a specific folder for me to check more
> > closely.
>
> No worries, I'm just happy to hear you're still around and looking out
> for patches :)
>
> I'm assuming you are okay with that patch?  If not we still have time
> to fix it up.

Yes, looks good to me!

>
> --
> paul-moore.com

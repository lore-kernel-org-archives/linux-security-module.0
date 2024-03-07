Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39BD3D988
	for <linux-security-module@vger.kernel.org>; Thu,  7 Mar 2024 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709854539; cv=none; b=DYaSLSsWtw+fxbGe9GLO2YOXYoxYCP6zmIpiEr8va+sQZ1gDUm0AbBAwBK9XgrhgLdmpRcPYSc0Yxd30FESK9xKvwUO443nR1tzcN64lAe5IF/NczFQGko2E/nDVhATx3OYWAHDQjPd2RRM4GZPlVeXPRSB52ClZ90eja51ch84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709854539; c=relaxed/simple;
	bh=njY2lknGUPjlZ/Y4D816ZCYT5Nqe46D+l814JgKXZP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByBgxj/UvUbLMv7Rl/6ye/1jeFnHvKMyA24RZgctZhRrCVbDV7iSdK3HOZz9f8RL0EmynO6SzkMMTJMDMM/UIMxdTv2PZ1p2ZRCwyIt7IwlKLFtphLunlqKHYDGL6E3ngjQHa40uruwOG+NM3vjXNTuTUH8OaCbcB3xikjmR2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BRGf41P8; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BRGf41P8"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso1508131276.3
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2024 15:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709854536; x=1710459336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNtL5CD8puTpQSdVaD0jHpw+y7n9IUqqlnVoWEtCBL0=;
        b=BRGf41P82HsTvkXyo2JNGJj+LB/0rs1SYZIqMsBlWlC7RZmh44lC652HQhSdV+keOd
         XH4xcPqiGcvXvzV8dpYR05vth5BsmoNcndqgi3wdrm1fPvUoICxsai94UGJMFuyFJDHF
         pQS5k3afj73Lk5eNQv8XRnKnP7n0AQnkhVUp+IBoc1ClMKlZeH7G1FKH4oGZ8sf7xug1
         jihrRlDfL9gCD+pjVhl5TTBJXkwoQGhmN0gfn9NlzWnHVmofClPUj/qUKRXnRFQDd5nX
         C1hXJ+/BlBKS+I9u1QkR878iVFataCO1lXP78+4gBLzTiIWUjEFELaD97x7SmPVlnKzp
         euEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709854536; x=1710459336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNtL5CD8puTpQSdVaD0jHpw+y7n9IUqqlnVoWEtCBL0=;
        b=WvC/h8ZjfHIEmUtDU8rdsZpgJMCcrV6wZM7EGkMX9jzn9OJWT405TUxhGxqIZ8Y+h5
         MGZNKZ5x2hut7M+u+HqjuAJkXLH8/ZZFGadMBe/DZajFo+fztgER6QaT+4brov6jvLtn
         yI2LbRtUnG9uU5YpbCGigxixKZUOCmLyA7RXi1dBWh0MyWmR71B45qJsfjvTU6ZiYI2q
         1h9TyMnWR+a7o2CZvvQAyg3LOqF4XdZZum/tVXNb8D5lZ4YPXW2e3fXQdwfhpkcZgTcm
         StsXuhVr2eDF5kD1PxaINIUHeQZj2EQC5VSw1IxtOigQHuzokY/hGqxmJZwIfigEY9LF
         3/xA==
X-Forwarded-Encrypted: i=1; AJvYcCVpciZbJ49ASxShekT3wQcHXNcx/uvDiGsWr0iJB5zCCw9zoio3IB2unv+AUFQH0HI1//32bMMem8yY4XBq+96gK6QYAvHGjm5FGv6f7Zhf0+/775Kv
X-Gm-Message-State: AOJu0YwYzcLcd0EWQ5UYrkygGNU1GIV7vduaBP0uAYWALJDxat5llFHX
	j94rC7qGuTNqXHdfRFFCe5splwoOTWY1sh2v1oiOgF6l53sXHrwi6Ok4VY66h6XlcyVa1HYph43
	MhwEKxYcBQ+wqIa/RLA2iHrMCvdvIv/v6WR6k
X-Google-Smtp-Source: AGHT+IHkLUNDkeGWk2UDprvqJoyAAWj/+UG6z3dHHUumDjNkflGrkgzvjDHpcuCjMGR9LSonnO4t3xhJraJPxjHKlhE=
X-Received: by 2002:a25:9f81:0:b0:dc6:c510:df6b with SMTP id
 u1-20020a259f81000000b00dc6c510df6bmr17669276ybq.55.1709854536495; Thu, 07
 Mar 2024 15:35:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219.chu4Yeegh3oo@digikod.net> <20240219183539.2926165-1-mic@digikod.net>
 <ZedgzRDQaki2B8nU@google.com> <20240306.zoochahX8xai@digikod.net>
 <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com> <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com> <Zem5tnB7lL-xLjFP@google.com>
 <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com> <ZepJDgvxVkhZ5xYq@dread.disaster.area>
In-Reply-To: <ZepJDgvxVkhZ5xYq@dread.disaster.area>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Mar 2024 18:35:25 -0500
Message-ID: <CAHC9VhSMONVsPT0k0kJOaAWQzpx2JCLYYosCX+k9g0PN8NQyMw@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
To: Dave Chinner <david@fromorbit.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 6:09=E2=80=AFPM Dave Chinner <david@fromorbit.com> w=
rote:
> On Thu, Mar 07, 2024 at 03:40:44PM -0500, Paul Moore wrote:
> > On Thu, Mar 7, 2024 at 7:57=E2=80=AFAM G=C3=BCnther Noack <gnoack@googl=
e.com> wrote:
> > > On Thu, Mar 07, 2024 at 01:21:48PM +0100, Arnd Bergmann wrote:
> > > > On Thu, Mar 7, 2024, at 13:15, Christian Brauner wrote:
> > > > > On Wed, Mar 06, 2024 at 04:18:53PM +0100, Arnd Bergmann wrote:
> > > > >> On Wed, Mar 6, 2024, at 14:47, Micka=C3=ABl Sala=C3=BCn wrote:
> > > > >> >
> > > > >> > Arnd, Christian, Paul, are you OK with this new hook proposal?
> > > > >>
> > > > >> I think this sounds better. It would fit more closely into
> > > > >> the overall structure of the ioctl handlers with their multiple
> > > > >> levels, where below vfs_ioctl() calling into f_ops->unlocked_ioc=
tl,
> > > > >> you have the same structure for sockets and blockdev, and
> > > > >> then additional levels below that and some weirdness for
> > > > >> things like tty, scsi or cdrom.
> > > > >
> > > > > So an additional security hook called from tty, scsi, or cdrom?
> > > > > And the original hook is left where it is right now?
> > > >
> > > > For the moment, I think adding another hook in vfs_ioctl()
> > > > and the corresponding compat path would do what Micka=C3=ABl
> > > > wants. Beyond that, we could consider having hooks in
> > > > socket and block ioctls if needed as they are easy to
> > > > filter out based on inode->i_mode.
> > > >
> > > > The tty/scsi/cdrom hooks would be harder to do, let's assume
> > > > for now that we don't need them.
> > >
> > > Thank you all for the help!
> > >
> > > Yes, tty/scsi/cdrom are just examples.  We do not need special featur=
es for
> > > these for Landlock right now.
> > >
> > > What I would do is to invoke the new LSM hook in the following two pl=
aces in
> > > fs/ioctl.c:
> > >
> > > 1) at the top of vfs_ioctl()
> > > 2) at the top of ioctl_compat()
> > >
> > > (Both of these functions are just invoking the f_op->unlocked_ioctl()=
 and
> > > f_op->compat_ioctl() operations with a safeguard for that being a NUL=
L pointer.)
> > >
> > > The intent is that the new hook gets called everytime before an ioctl=
 is sent to
> > > these IOCTL operations in f_op, so that the LSM can distinguish clean=
ly between
> > > the "safe" IOCTLs that are implemented fully within fs/ioctl.c and th=
e
> > > "potentially unsafe" IOCTLs which are implemented by these hooks (as =
it is
> > > unrealistic for us to holistically reason about the safety of all pos=
sible
> > > implementations).
> > >
> > > The alternative approach where we try to do the same based on the exi=
sting LSM
> > > IOCTL hook resulted in the patch further up in this mail thread - it =
involves
> > > maintaining a list of "safe" IOCTL commands, and it is difficult to g=
uarantee
> > > that these lists of IOCTL commands stay in sync.
> >
> > I need some more convincing as to why we need to introduce these new
> > hooks, or even the vfs_masked_device_ioctl() classifier as originally
> > proposed at the top of this thread.  I believe I understand why
> > Landlock wants this, but I worry that we all might have different
> > definitions of a "safe" ioctl list, and encoding a definition into the
> > LSM hooks seems like a bad idea to me.
>
> I have no idea what a "safe" ioctl means here. Subsystems already
> restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, so
> "safe" clearly means something different here.

That's the point I was trying to make.  I'm not sure exactly what
G=C3=BCnther meant either (I was simply copying his idea of a "safe" ioctl,
complete with all of the associations around the double quotes), which
helps underscore the idea that different groups are likely to have
different ideas of what ioctls they want to allow based on their
security model, environment, etc.

> > At this point in time, I think I'd rather see LSMs that care about
> > ioctls maintaining their own list of "safe" ioctls and after a while
> > if it looks like everyone is in agreement (VFS folks, individual LSMs,
> > etc.) we can look into either an ioctl classifier or multiple LSM
> > ioctl hooks focused on different categories of ioctls.
>
> From the perspective of a VFS and subsystem developer, I really have
> no clue what would make a "safe" ioctl from a LSM perspective ...

We also need to keep in mind that we have multiple LSM implementations
and we need to support different ideas around how to control access to
ioctls, including which ioctls are "safe" for multiple definitions of
the word.

> ... and I
> very much doubt an LSM developer has any clue whether deep, dark
> subsystem ioctls are "safe" to allow, or even what would stop
> working if they decided something was not "safe".

... or for those LSMs with configurable security policies, which
ioctls are allowed by the LSM's policy developer to fit their
particular needs.

> This just seems like a complex recipe for creating unusable and/or
> impossible to configure/secure systems to me.

FWIW, Android has been using the existing LSM ioctl controls for
several years now to help increase the security of Android devices.

https://security.googleblog.com/2016/07/protecting-android-with-more-linux.=
html
https://kernsec.org/files/lss2015/vanderstoep.pdf

--=20
paul-moore.com

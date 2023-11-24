Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CivbeWF1"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB5610E3
	for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 05:02:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cb92becbf6so26307157b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 05:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700830940; x=1701435740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QLdx6V0Pi5RjnCun1VCFK5ZInXyA7/UKfeRX+qbzaM=;
        b=CivbeWF1MAKfShm2G1ASkUe/eBMnKMPBVUq6ifIIlxFEVYgPvp4bGtrKWxiuQRpUmJ
         RXmLV7rg5bTpT5OkStg0VO1ImmIsWeEtRvv7F14+/394+J98it1LcEhnrM3rHaZcApVx
         w7un0UPhIXEqtGtF1gpKwDjcCPxaWxnL1Cz4IqCgrEcjJKvrm7zOisSNLeiP9oiHb5d+
         EFbQ5/YnoCC8fvXTD0EckOKwWcP4RPfLQgPxVKRBiWBG6v5TYYh3aS3/duocOGlutL3r
         +0ttd7YJZ7TTqDRBq2cEvLLGWmNBa2214ROiAB2qnFBFDPHuPmQl3MUW8TgR3a13nhHZ
         AAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700830940; x=1701435740;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7QLdx6V0Pi5RjnCun1VCFK5ZInXyA7/UKfeRX+qbzaM=;
        b=FrGgfcCDoHY4mZ8sCKk5MU5F2zZPQX8x3vGB9DMdMHw4YL2w5cWDhDTi1qwBY+YgTX
         ts6fd972uYb94VtQ7xgG/IvpkqyQipEua8BKt41ao6P4HswIgAtynxL/926gtKs3oQ44
         L6qGhnNc0omv4XthIrnugnEXwURT0NybX9lH3f4KJO9RgWNvjyKVkoGH8Uky1jJdl/ZV
         hrWmO9oTQc9xkkIBiTXiYpI79vHaLsu5jY5CuIAAol6WnjXpg15TToT6wWzQQZvF+ivx
         Ze2ttl97UgoEldoIoM3yaJ4a+ZmQE8ibTlgCgNbYrg9KE651hSRu9iTM2YLH+yDW7rb4
         hMeg==
X-Gm-Message-State: AOJu0Ywbj2EaHTKxR7Utmx4vMznbOaaUq3k0N5oZsWdi9SkNP0SHKs8h
	J9+bo4L81rEYmpwZUXjBoyu2oZxsLbk=
X-Google-Smtp-Source: AGHT+IHngrcQ9tnVfhXBbFbWqQBX4q2a3/yEkCYmKDpByMVhWjObjAFao9FxKzNDjzH/yqw6LZP4sWZ/4xM=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a81:5758:0:b0:5ce:1b3f:f20d with SMTP id
 l85-20020a815758000000b005ce1b3ff20dmr59290ywb.3.1700830940574; Fri, 24 Nov
 2023 05:02:20 -0800 (PST)
Date: Fri, 24 Nov 2023 14:02:12 +0100
In-Reply-To: <20231117.aen7feDah5aD@digikod.net>
Message-Id: <ZWCe1FnVVlYQmQFG@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com> <20231116.haW5ca7aiyee@digikod.net>
 <ZVd8RP01oNc5K92c@google.com> <20231117.aen7feDah5aD@digikod.net>
Subject: Re: [PATCH v4 0/7] Landlock: IOCTL support
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 09:44:31PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Nov 17, 2023 at 03:44:20PM +0100, G=C3=BCnther Noack wrote:
> > On Thu, Nov 16, 2023 at 04:49:09PM -0500, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > On Fri, Nov 03, 2023 at 04:57:10PM +0100, G=C3=BCnther Noack wrote:
> > > And patch the landlock_create_ruleset() helper with that:
> > >=20
> > > -	if (!fs_access_mask && !net_access_mask)
> > > +	if (WARN_ON_ONCE(!fs_access_mask) && !net_access_mask)
> > > 		return ERR_PTR(-ENOMSG);
> >=20
> > Why would you want to warn on the case where fs_access_mask is zero?
>=20
> Because in my suggestion the real check is moved/copied to
> landlock_expand_fs_access(), which is called before, and it should then
> not be possible to have this case here.

Oh, I see, I misread that code.  I guess it does not apply to the version t=
hat
we ended up with.


> > > >  * When LANDLOCK_ACCESS_FS_IOCTL is granted on a file hierarchy,
> > > >    should this grant the permission to use *any* IOCTL?  (Right now=
,
> > > >    it is any IOCTL except for the ones covered by the IOCTL groups,
> > > >    and it's a bit weird that the scope of LANDLOCK_ACCESS_FS_IOCTL
> > > >    becomes smaller when other access rights are also handled.
> > >=20
> > > Are you suggesting to handle differently this right if it is applied =
to
> > > a directory?
> >=20
> > No - this applies to files as well.  I am suggesting that granting
> > LANDLOCK_ACCESS_FS_IOCTL on a file or file hierarchy should always give=
 access
> > to *all* ioctls, both the ones in the synthetic groups and the remainin=
g ones.
> >=20
> > Let me spell out the scenario:
> >=20
> > Steps to reproduce:
> >   - handle: LANDLOCK_ACCESS_FS_IOCTL | LANDLOCK_ACCESS_FS_READ_FILE
> >   - permit: LANDLOCK_ACCESS_FS_IOCTL
> >             on file f
> >   - open file f (for write-only)
> >   - attempt to use ioctl(fd, FIOQSIZE, ...)
> >=20
> > With this patch set:
> >   - ioctl(fd, FIOQSIZE, ...) fails,
> >     because FIOQSIZE is part of IOCTL_CMD_G1
> >     and because LANDLOCK_ACCESS_FS_READ_FILE is handled,
> >     IOCTL_CMD_G1 is only unlocked through LANDLOCK_ACCESS_FS_READ_FILE
>=20
> Correct, and it looks consistent to me.
>=20
> >=20
> > Alternative proposal:
> >   - ioctl(fd, FIOQSIZE, ...) should maybe work,
> >     because LANDLOCK_ACCESS_FS_IOCTL is permitted on f
> >=20
> >     Implementation-wise, this would mean to add
> >=20
> >     expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_IOCTL, ioctl_group=
s)
> >=20
> >     to expand_all_ioctl().
> >=20
> > I feel that this alternative might be less surprising, because granting=
 the
> > IOCTL right would grant all the things that were restricted when handli=
ng the
> > IOCTL right, and it would be more "symmetric".
> >=20
> > What do you think?
>=20
> I though that we discussed about that and we agree that it was the way
> to go. Cf. the table of handled/allowed/not-allowed.

We can go with the current implementation as well, I don't feel very strong=
ly
about it.


> Why would LANDLOCK_ACCESS_FS_IOCTL grant access to FIOQSIZE in the case
> of a directory but not a file? These would be two different semantics.

If the ruleset were enforced in that proposal, as in the example above, it =
would
not distinguish whether the affected filesystem paths are files or director=
ies.

If LANDLOCK_ACCESS_FS_IOCTL is handled, the semantics would be:

  * If you permit LANDLOCK_ACCESS_FS_READ_FILE on a directory or file,
    it would become possible to use these ioctl commands on the affected fi=
les
    which are relevant and harmless for reading files.  (As before)

  * If you permit LANDLOCK_ACCESS_FS_IOCTL on a directory or file,
    it would become possible to use *all* ioctl commands on the affected fi=
les.

    (That is the difference.  In the current implementation, this only affe=
cts
     the ioctl commands which are *not* in the synthetic groups.  In the
     alternative proposal, it would affect *all* ioctl commands.

     I think this might be simpler to reason about, because the set of ioct=
l
     commands which are affected by permitting(!) LANDLOCK_ACCESS_FS_IOCTL =
would
     always be the same (namely, all ioctl commands), and it would not be
     dependent on whether other access rights are handled.)


I don't think it is at odds with the backwards-compatibility concerns which=
 we
previously discussed.  The synthetic groups still exist, it's just the
"permitting LANDLOCK_ACCESS_FS_IOCTL on a file or directory" which affects =
a
different set of IOCTL commands.


> > > If the scope of LANDLOCK_ACCESS_FS_IOCTL is well documented, that sho=
uld
> > > be OK. But maybe we should rename this right to something like
> > > LANDLOCK_ACCESS_FS_IOCTL_DEFAULT to make it more obvious that it hand=
les
> > > IOCTLs that are not handled by other access rights?
> >=20
> > Hmm, I'm not convinced this is a good name.  It makes sense in the cont=
ext of
> > allowing "all the other ioctls" for a file or file hierarchy, but when =
setting
> > LANDLOCK_ACCESS_FS_IOCTL in handled_access_fs, that flag turns off *all=
* ioctls,
> > so "default" doesn't seem appropriate to me.
>=20
> It should turn off all IOCTLs that are not handled by another access
> right.  The handled access rights should be expanded the same way as the
> allowed access rights.

If you handle LANDLOCK_ACCESS_FS_IOCTL, and you don't permit anything on fi=
les
or directories, all IOCTL commands will be forbidden, independent of what e=
lse
is handled.

The opposite is not true:

If you handle LANDLOCK_ACCESS_FS_READ_FILE, and you don't handle
LANDLOCK_ACCESS_FS_IOCTL, all IOCTL commands will happily work.

So if you see it through that lens, you could say that it is only the
LANDLOCK_ACCESS_FS_IOCTL bit in the "handled" mask which forbids any IOCTL
commands at all.


I hope this makes sense.  It's not my intent to open this
backwards-compatibility can of worms from scratch... :)

=E2=80=94G=C3=BCnther

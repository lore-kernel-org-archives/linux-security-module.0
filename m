Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxLMiVZ5"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC98E
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 06:39:41 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db53f73eefeso2626189276.0
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 06:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702046380; x=1702651180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLPrPlRC/jF0nP5OepG9UJkON+cxtp9F2akZQ1W/45M=;
        b=oxLMiVZ5ESZFvgYjopDVMGbba9ejN+CPeftMCZoRAiJh6WD32kbp44omSArT1Z7wun
         UrG/SZpzvj7FEfIYvQ/jReIhG0h7oL44299KC+TWOnowEf7QaGaWricLslPu2uAG0yF3
         cihm67Pc8jjvAGEEy9mXMbJb5g1OM/ryrSjo53bncRlkxlRGDuvo5wszB+dV45spO0Zp
         dqvjbFAMyuI1AqWfWkBHLBLa1mzygUBCjj40ZjgZ/zTFRzBl7SGhBeMqbMKjVqvVGgGC
         crBlTOif+6vp49FKXD+nKU9dJR/wuwWUimVmuXcjQSOXfK3yU/iMZzx0Gt2kh/KEsamK
         5eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702046380; x=1702651180;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eLPrPlRC/jF0nP5OepG9UJkON+cxtp9F2akZQ1W/45M=;
        b=HgdQe3dvTjcXDI8OI72Kh0hsms0kG2YiDDUw/dQAJuloiab4nwGsJ5Rbf3BoXUhApX
         oXfyn1yIl5gjG4vG6mX8OHn00YjIhe2+N2h8mcooQK+AefN9JIIU/Zxmtc6Ox/Eom7xd
         A1bcEeCXA55SjaEQXbu43ReHNUXZXOInNBSzb4r5gZ81XsXG7JP+gH80zLL9xhFLU10V
         l4tJ6yoe6ca8bodWVkbLVu8mRx5+avnZCovAvEOGy00SYBYGMzF7yC2Y+n34Uj/nFFYL
         DwCRXScs23pvDFXrA6boORXH8i+NHpS12jDHorvLyqtNG4O7zlQGySzO7s/mBKP6rTS3
         CXNA==
X-Gm-Message-State: AOJu0YzG7G0UjH/Vu4GeBiILLhSrwAR1z58jjCreq1xRAr3g2zJK5q8v
	b2pRswOrfmMobH/kpEu7shan/eHGV8s=
X-Google-Smtp-Source: AGHT+IFpvc/9PgTXyF2DsXaPeWoBnrJ6NurxGpd/gOUYl6tVZigpLNaS5Rj80hjDid1VK8IakjitjNFrV/g=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:a25:b904:0:b0:d9a:e3d9:99bd with SMTP id
 x4-20020a25b904000000b00d9ae3d999bdmr643ybj.5.1702046380625; Fri, 08 Dec 2023
 06:39:40 -0800 (PST)
Date: Fri, 8 Dec 2023 15:39:30 +0100
In-Reply-To: <20231130.eipai4uXighe@digikod.net>
Message-Id: <ZXMqordGs31R7oGR@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com> <20231116.haW5ca7aiyee@digikod.net>
 <ZVd8RP01oNc5K92c@google.com> <20231117.aen7feDah5aD@digikod.net>
 <ZWCe1FnVVlYQmQFG@google.com> <20231130.eipai4uXighe@digikod.net>
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

On Thu, Nov 30, 2023 at 10:26:47AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Nov 24, 2023 at 02:02:12PM +0100, G=C3=BCnther Noack wrote:
> > On Fri, Nov 17, 2023 at 09:44:31PM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > I don't think it is at odds with the backwards-compatibility concerns w=
hich we
> > previously discussed.  The synthetic groups still exist, it's just the
> > "permitting LANDLOCK_ACCESS_FS_IOCTL on a file or directory" which affe=
cts a
> > different set of IOCTL commands.
>=20
> It would not be a backward-compatibility issue, but it would make
> LANDLOCK_ACCESS_FS_IOCTL too powerful even if we get safer/better access
> rights. Furthermore, reducing the scope of LANDLOCK_ACCESS_FS_IOCTL with
> new handled access rights should better inform end encourage developers
> to drop LANDLOCK_ACCESS_FS_IOCTL when it is not strictly needed.
> It would be useful to explain this rationale in the commit message.
> See https://lore.kernel.org/all/20231020.moefooYeV9ei@digikod.net/

Done; I added a section to the commit message.


> > > > > If the scope of LANDLOCK_ACCESS_FS_IOCTL is well documented, that=
 should
> > > > > be OK. But maybe we should rename this right to something like
> > > > > LANDLOCK_ACCESS_FS_IOCTL_DEFAULT to make it more obvious that it =
handles
> > > > > IOCTLs that are not handled by other access rights?
> > > >=20
> > > > Hmm, I'm not convinced this is a good name.  It makes sense in the =
context of
> > > > allowing "all the other ioctls" for a file or file hierarchy, but w=
hen setting
> > > > LANDLOCK_ACCESS_FS_IOCTL in handled_access_fs, that flag turns off =
*all* ioctls,
> > > > so "default" doesn't seem appropriate to me.
> > >=20
> > > It should turn off all IOCTLs that are not handled by another access
> > > right.  The handled access rights should be expanded the same way as =
the
> > > allowed access rights.
> >=20
> > If you handle LANDLOCK_ACCESS_FS_IOCTL, and you don't permit anything o=
n files
> > or directories, all IOCTL commands will be forbidden, independent of wh=
at else
> > is handled.
> >=20
> > The opposite is not true:
> >=20
> > If you handle LANDLOCK_ACCESS_FS_READ_FILE, and you don't handle
> > LANDLOCK_ACCESS_FS_IOCTL, all IOCTL commands will happily work.
> >=20
> > So if you see it through that lens, you could say that it is only the
> > LANDLOCK_ACCESS_FS_IOCTL bit in the "handled" mask which forbids any IO=
CTL
> > commands at all.
>=20
> Handling LANDLOCK_ACCESS_FS_IOCTL does make all IOCTLs denied by
> default. However, to allow IOCTLs, developers may need to allow
> LANDLOCK_ACCESS_FS_IOCTL or another access right according to the
> underlying semantic.
>=20
> It would be useful to add an example with your table in the
> documentation, for instance with LANDLOCK_ACCESS_FS_READ_FILE (handled
> or not handled, with LANDLOCK_ACCESS_FS_IOCTL or not, allowed on a file
> or not...).

Added an example to the documentation.

=E2=80=94G=C3=BCnther

Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE80EB64DD
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Aug 2023 07:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjHGHj4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Aug 2023 03:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHGHjz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Aug 2023 03:39:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0D510D4
        for <linux-security-module@vger.kernel.org>; Mon,  7 Aug 2023 00:39:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cf4cb742715so4529489276.2
        for <linux-security-module@vger.kernel.org>; Mon, 07 Aug 2023 00:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691393993; x=1691998793;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UakthhRqjuS9eULCLw0dwO4qFxBtDfrW9aBy9ZYJwW4=;
        b=BZYkU8O2xHTNLKdk8L1LxR+b8rUJ80v1w8k17u+QHZJRXgyNC+muyc18n1lqvYxi8U
         q+z2GEJXdIhv+bosEggphQWQMx7Lsor2g/rza+dDG2J6XH5etFRari+9Jp9eNVg73PUY
         PcBqzP5yWUqzNArl7dgF8dacWir7sRmpniHslSiu6lDP8rDU0s/2sEvdQbeLHWp5nSRD
         b7VoeyZZJkhJ4ZueZJvz5IW9Kr95fXAHBZWG4P5yZywyXxrlAPcx1/Jnu+HyRpkQJuWS
         zckkKuLAFXEUYHU5y6rXcXpKszn3sVjJyF5PE5UzW+7ScRLYtfMPehGqsElnqu9TMFgT
         RaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691393993; x=1691998793;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UakthhRqjuS9eULCLw0dwO4qFxBtDfrW9aBy9ZYJwW4=;
        b=k1Oxriq42anR4Tek5XihtHY7KiQRwOZywnOFZwSZrTw+C5+KVLdqTy2TuE/zd1USpr
         VyRkwn7/5qpvK80yX7cagQCGHNuZvNLRcS1//XbuofUlI0+a19okttOML2JN+pv1MvM0
         HA0rAPWSif2aSuHCkTjPGmGjkOjIgvVYyVCicPDua0T/P8Refo4jlWBGaVzELZsEBF/+
         25GqS6gETjyRWXO3vKBLphwayWm+Wk8/qZCwXKEypuxkkNFMxxLYQIoyvK0ft/Ltgjcp
         Ofe+7vPj8FM+jfPVodzdTRxeT5wdbmaDQUTJxsSu1xCqja1aGPe1LUqZfnY3BTn8KLpm
         W+qA==
X-Gm-Message-State: AOJu0Yxnieruatn3820HJEhKsSXEISrBWNvyJ2laHjKGNgt1AMTPpL2p
        /qYuhN0vMorbAcjzI+Sw30fo9Ja2Rz8=
X-Google-Smtp-Source: AGHT+IGo8dX/NNJDcQQVPb9WEUi9fieH4w5S+K8noAJbM6DbQQtUZPhfByDS/IX7IGznRXCVjmRDTorzO2A=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:5a00:cb76:4f2a:6df])
 (user=gnoack job=sendgmr) by 2002:a05:6902:1363:b0:d0d:cce3:d32d with SMTP id
 bt3-20020a056902136300b00d0dcce3d32dmr51921ybb.6.1691393993469; Mon, 07 Aug
 2023 00:39:53 -0700 (PDT)
Date:   Mon, 7 Aug 2023 09:39:50 +0200
In-Reply-To: <be5ac5ab-2b00-b896-27fc-14c30f938622@digikod.net>
Message-Id: <ZNCfxozBIkDIj9R3@google.com>
Mime-Version: 1.0
References: <20230502171755.9788-1-gnoack3000@gmail.com> <20230502171755.9788-4-gnoack3000@gmail.com>
 <be5ac5ab-2b00-b896-27fc-14c30f938622@digikod.net>
Subject: Re: [RFC 3/4] selftests/landlock: Test ioctl support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello!

Thanks for the review!

On Mon, Jun 19, 2023 at 04:42:17PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On 02/05/2023 19:17, G=C3=BCnther Noack wrote:
> > Exercise the use of Landlock's ioctl restriction: If ioctl is
> > restricted, the use of ioctl fails with a freshly opened /dev/tty
> > file.
> >=20
> > Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > ---
> >   tools/testing/selftests/landlock/fs_test.c | 62 +++++++++++++++++++++=
+
> >   1 file changed, 62 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing=
/selftests/landlock/fs_test.c
> > index fdd7d439ce4..1f827604374 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -3655,6 +3655,68 @@ TEST(memfd_ftruncate)
> >   	ASSERT_EQ(0, close(fd));
> >   }
> > +/*
> > + * Invokes ioctl(2) and returns its errno or 0.
> > + * The provided fd needs to be a tty for this to work.
> > + */
> > +static int test_tty_ioctl(int fd)
> > +{
> > +	struct winsize ws;
> > +
> > +	if (ioctl(fd, TIOCGWINSZ, &ws) < 0)
> > +		return errno;
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Attempt ioctl on /dev/tty0 and /dev/tty1,
> > + * with file descriptors opened before and after landlocking.
> > + */
> > +TEST_F_FORK(layout1, ioctl)
> > +{
> > +	const struct rule rules[] =3D {
> > +		{
> > +			.path =3D "/dev/tty1",
> > +			.access =3D LANDLOCK_ACCESS_FS_IOCTL,
> > +		},
> > +		/* Implicitly: No ioctl access on /dev/tty0. */
>=20
> We should create a new PTS mount point, create a new session, and use tha=
t
> for tests to limit the dependency on the test environment and not mess wi=
th
> it.

I have pondered this, and I feel that this is unnecessarily complicating th=
e
test.  The mechanism that I intend to test here is just the general filteri=
ng of
IOCTL commands, but not TTYs specifically.  TTYs are a common use case for
IOCTLs, but they are not the only one.

If you are not strongly opposed to it, I would rather look for a different =
IOCTL
command that works on a different file, where we don't need any special set=
 up?
That would simplify the test and exercise the same functionality in the end=
.
Does that sounds reasonable?


> > +		{},
> > +	};
> > +	const __u64 handled =3D LANDLOCK_ACCESS_FS_IOCTL;
> > +	int ruleset_fd;
> > +	int old_tty0_fd, tty0_fd, tty1_fd;
> > +
> > +	old_tty0_fd =3D open("/dev/tty0", O_RDWR);
> > +	ASSERT_LE(0, old_tty0_fd);
> > +
> > +	/* Checks that ioctl works before landlocking. */
> > +	EXPECT_EQ(0, test_tty_ioctl(old_tty0_fd));
> > +
> > +	/* Enable Landlock. */
>=20
> Enable*s*

Done.


> > +	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
> > +	ASSERT_LE(0, ruleset_fd);
> > +	enforce_ruleset(_metadata, ruleset_fd);
> > +	ASSERT_EQ(0, close(ruleset_fd));
> > +
> > +	/* Checks that ioctl with existing FD works after landlocking. */
> > +	EXPECT_EQ(0, test_tty_ioctl(old_tty0_fd));
> > +
> > +	/* Checks that same ioctl fails when file is opened after landlocking=
. */
> > +	tty0_fd =3D open("/dev/tty0", O_RDWR);
> > +	ASSERT_LE(0, tty0_fd);
> > +	EXPECT_EQ(EACCES, test_tty_ioctl(tty0_fd));
> > +
> > +	/* Checks that same ioctl fails when file is opened after landlocking=
. */
> > +	tty1_fd =3D open("/dev/tty1", O_RDWR);
> > +	ASSERT_LE(0, tty1_fd);
> > +	EXPECT_EQ(0, test_tty_ioctl(tty1_fd));
>=20
> /dev, or rather the test PTS mount point, and its parent, should also be
> tested. We can use three layers in the same test for that.

We've already tested the inheritance of access rights across different
directories and mount points in other tests.  I feel that exercising it in =
all
combinations of access rights and inheritance mechanisms makes the tests ha=
rder
to understand and maintain, and does not give us much additional confidence=
 on
top of what we already have.  What balance do you want to find there?

Thanks,
=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof

Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3248CA0FE6
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Sep 2023 13:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbjIANgP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Sep 2023 09:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349766AbjIANgO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Sep 2023 09:36:14 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0357810D5
        for <linux-security-module@vger.kernel.org>; Fri,  1 Sep 2023 06:36:11 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-52a0f6f7a3bso3103303a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 Sep 2023 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693575369; x=1694180169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs96RkX0Bs6rVbSS5Vlf14y81FA8kuiJnqayrwEbecQ=;
        b=dKRgxqOZGKu63Rw4FJrDude6R/e+npStAq5wo/2ASjM0liCuvsw0V1Ma+dED6Xjvrj
         kXbszk5nELDOT3C92ayLb9cJ7jNlpt8MZoxfpIGJ4x03yUVLF0xbI2HlEfKKlAtC0prj
         PGjT5FCrqb5L1xr36jqPFIWdCmh6ySy9EeLifP7RMPZ8ED2zpGGUQw2Quyk4A98ZXs0Y
         ksbhSwxbgZVSNT7GQP+jWSqZeANq74axo1Vc095yNQHv6+JXFzXfD6DrHBHobxOOzo4w
         WsvuOJfd+LH5PYKdOhjlSTaGxmIXX/OPPnKc1CXQPALt1f/xNicBi90FRQXqGBvItsBP
         qJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693575369; x=1694180169;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hs96RkX0Bs6rVbSS5Vlf14y81FA8kuiJnqayrwEbecQ=;
        b=WnPzB5nPssfWUwZhrNI5HtOQkE2WLX8xIf/yUl1eb5rs7qlv/xHrSSmF8RVnPfh1u/
         fu/ppstnKSjYCzKybJKkbzQybeFO8xfS3SkkkjbPgKBYUaNWdssjPvJxObcklbZjVMmy
         t98hVrAPPJQf/xGUlQVnckQIHUDvAcLAyiTUUNLKvGiVB4o8Exkk23P0KUmMnNVWCKbn
         lDTiaJgmioqUfhPCvPoaHlMcIA7Skp+0Zk7y+DK/oRKObInbTrif+4KEQxZ18uyQ2w9H
         YwHTAo/MHENowEnn87U3VFMIv+KWwSJ5WrGbFCMBJBNJKCzJcyVdqJQ0GnZslXyqJSEi
         /3kw==
X-Gm-Message-State: AOJu0Yz8+L6iMqqjg3iig5n7znTc6yM7iPj6OFmqM4n4ykLmxqKeifsl
        M1AJJcWhsvbB91IeQT0JFaQ3EZiX9zU=
X-Google-Smtp-Source: AGHT+IGiFKa3PCjqpf7I5iosL5+T4ukZZPg+2WmP+4QgF490P0QuVsIKcJMTlUKtCTXXjrDlVBJGz9fet/w=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:bd96:fa13:5419:ea62])
 (user=gnoack job=sendgmr) by 2002:aa7:cd6f:0:b0:52a:f5f:8574 with SMTP id
 ca15-20020aa7cd6f000000b0052a0f5f8574mr87797edb.1.1693575369494; Fri, 01 Sep
 2023 06:36:09 -0700 (PDT)
Date:   Fri, 1 Sep 2023 15:35:59 +0200
In-Reply-To: <20230825.ohtoh6aivahX@digikod.net>
Message-Id: <20230901133559.gazeeteejw2ebpxm@google.com>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com> <20230814172816.3907299-3-gnoack@google.com>
 <20230818.HopaLahS0qua@digikod.net> <ZOjN7dub5QGJOzSX@google.com> <20230825.ohtoh6aivahX@digikod.net>
Subject: Re: [PATCH v3 2/5] selftests/landlock: Test ioctl support
From:   "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To:     "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello!

On Fri, Aug 25, 2023 at 07:07:01PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Aug 25, 2023 at 05:51:09PM +0200, G=C3=BCnther Noack wrote:
> > Hello!
> >=20
> > On Fri, Aug 18, 2023 at 07:06:07PM +0200, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > On Mon, Aug 14, 2023 at 07:28:13PM +0200, G=C3=BCnther Noack wrote:
> > > > @@ -3639,7 +3639,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
> > > >  	};
> > > >  	int fd, ruleset_fd;
> > > > =20
> > > > -	/* Enable Landlock. */
> > > > +	/* Enables Landlock. */
> > > >  	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules)=
;
> > > >  	ASSERT_LE(0, ruleset_fd);
> > > >  	enforce_ruleset(_metadata, ruleset_fd);
> > > > @@ -3732,6 +3732,96 @@ TEST(memfd_ftruncate)
> > > >  	ASSERT_EQ(0, close(fd));
> > > >  }
> > >=20
> > > We should also check with O_PATH to make sure the correct error is
> > > returned (and not EACCES).
> >=20
> > Is this remark referring to the code before it or after it?
> >=20
> > My interpretation is that you are asking to test that test_fioqsize_ioc=
tl() will
> > return errnos correctly?  Do I understand that correctly?  (I think tha=
t would
> > be a little bit overdone, IMHO - it's just a test utility of ~10 lines =
after
> > all, which is below the threshold where it can be verified by staring a=
t it for
> > a bit. :))
>=20
> I was refering to the previous memfd_ftruncate test, which is changed
> with a next patch. We should check the access rights tied (and checkd)
> to FD (i.e. truncate and ioctl) opened with O_PATH.

OK, I added a test that checks ioctl(2) and ftruncate(2) on files that
were opened with O_PATH, both before and after enabling Landlock.
ftruncate() and ioctl() always give an EBADF error, both before and
after enabling Landlock (as described in open(2) in the section about
O_PATH).

A bit outside of the IOCTL path set scope:

I was surprised that it is even possible to successfully open a file
with O_PATH, even after Landlock is enabled and restricts all it can
in that file hierarchy.  This lets you detect that a file exists, even
when that file is in a directory whose contents you are otherwise not
permitted to list due to Landlock.

The logic for that is in the get_required_file_open_access() function.
Should we add a "LANDLOCK_ACCESS_FS_PATH_FILE" right, which would work
similar to LANDLOCK_ACCESS_FS_READ_FILE and
LANDLOCK_ACCESS_FS_WRITE_FILE, so that this can be restricted?

=E2=80=94G=C3=BCnther


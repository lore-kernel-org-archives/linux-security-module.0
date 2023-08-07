Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFF2EB64DD
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Aug 2023 09:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjHGJlm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Aug 2023 05:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHGJll (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Aug 2023 05:41:41 -0400
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A3010FC
        for <linux-security-module@vger.kernel.org>; Mon,  7 Aug 2023 02:41:39 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RKBCz6j93zMqPd2;
        Mon,  7 Aug 2023 09:41:35 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RKBCz3J1ZzMppKd;
        Mon,  7 Aug 2023 11:41:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1691401295;
        bh=xGwI/a1X+n13R/RgE2Lzi1WsON3csuBmAR0tfi327V0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEfAaXPR9BRV1Y6DQCxneLb/jfoP+pkdKi3jUDiV1l41Y+IQ/Xk1yFFj6jXSkYK5O
         WBEzgrI4+rl70bBonV4UdrEPv9PxbLEzdWmdSw4zffDHP7+zDjpvdqwWDI1ZxX8Y98
         UkRE/+MTBo8TOM8EiZyWpp/m2/KeBPGzaPq8Mxy8=
Date:   Mon, 7 Aug 2023 11:41:48 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [RFC 3/4] selftests/landlock: Test ioctl support
Message-ID: <20230807.thiepaW9ooWu@digikod.net>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
 <20230502171755.9788-4-gnoack3000@gmail.com>
 <be5ac5ab-2b00-b896-27fc-14c30f938622@digikod.net>
 <ZNCfxozBIkDIj9R3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNCfxozBIkDIj9R3@google.com>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 07, 2023 at 09:39:50AM +0200, Günther Noack wrote:
> Hello!
> 
> Thanks for the review!
> 
> On Mon, Jun 19, 2023 at 04:42:17PM +0200, Mickaël Salaün wrote:
> > On 02/05/2023 19:17, Günther Noack wrote:
> > > Exercise the use of Landlock's ioctl restriction: If ioctl is
> > > restricted, the use of ioctl fails with a freshly opened /dev/tty
> > > file.
> > > 
> > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > ---
> > >   tools/testing/selftests/landlock/fs_test.c | 62 ++++++++++++++++++++++
> > >   1 file changed, 62 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > > index fdd7d439ce4..1f827604374 100644
> > > --- a/tools/testing/selftests/landlock/fs_test.c
> > > +++ b/tools/testing/selftests/landlock/fs_test.c
> > > @@ -3655,6 +3655,68 @@ TEST(memfd_ftruncate)
> > >   	ASSERT_EQ(0, close(fd));
> > >   }
> > > +/*
> > > + * Invokes ioctl(2) and returns its errno or 0.
> > > + * The provided fd needs to be a tty for this to work.
> > > + */
> > > +static int test_tty_ioctl(int fd)
> > > +{
> > > +	struct winsize ws;
> > > +
> > > +	if (ioctl(fd, TIOCGWINSZ, &ws) < 0)
> > > +		return errno;
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * Attempt ioctl on /dev/tty0 and /dev/tty1,
> > > + * with file descriptors opened before and after landlocking.
> > > + */
> > > +TEST_F_FORK(layout1, ioctl)
> > > +{
> > > +	const struct rule rules[] = {
> > > +		{
> > > +			.path = "/dev/tty1",
> > > +			.access = LANDLOCK_ACCESS_FS_IOCTL,
> > > +		},
> > > +		/* Implicitly: No ioctl access on /dev/tty0. */
> > 
> > We should create a new PTS mount point, create a new session, and use that
> > for tests to limit the dependency on the test environment and not mess with
> > it.
> 
> I have pondered this, and I feel that this is unnecessarily complicating the
> test.  The mechanism that I intend to test here is just the general filtering of
> IOCTL commands, but not TTYs specifically.  TTYs are a common use case for
> IOCTLs, but they are not the only one.
> 
> If you are not strongly opposed to it, I would rather look for a different IOCTL
> command that works on a different file, where we don't need any special set up?
> That would simplify the test and exercise the same functionality in the end.
> Does that sounds reasonable?

Yes, simpler is better.

> 
> 
> > > +		{},
> > > +	};
> > > +	const __u64 handled = LANDLOCK_ACCESS_FS_IOCTL;
> > > +	int ruleset_fd;
> > > +	int old_tty0_fd, tty0_fd, tty1_fd;
> > > +
> > > +	old_tty0_fd = open("/dev/tty0", O_RDWR);
> > > +	ASSERT_LE(0, old_tty0_fd);
> > > +
> > > +	/* Checks that ioctl works before landlocking. */
> > > +	EXPECT_EQ(0, test_tty_ioctl(old_tty0_fd));
> > > +
> > > +	/* Enable Landlock. */
> > 
> > Enable*s*
> 
> Done.
> 
> 
> > > +	ruleset_fd = create_ruleset(_metadata, handled, rules);
> > > +	ASSERT_LE(0, ruleset_fd);
> > > +	enforce_ruleset(_metadata, ruleset_fd);
> > > +	ASSERT_EQ(0, close(ruleset_fd));
> > > +
> > > +	/* Checks that ioctl with existing FD works after landlocking. */
> > > +	EXPECT_EQ(0, test_tty_ioctl(old_tty0_fd));
> > > +
> > > +	/* Checks that same ioctl fails when file is opened after landlocking. */
> > > +	tty0_fd = open("/dev/tty0", O_RDWR);
> > > +	ASSERT_LE(0, tty0_fd);
> > > +	EXPECT_EQ(EACCES, test_tty_ioctl(tty0_fd));
> > > +
> > > +	/* Checks that same ioctl fails when file is opened after landlocking. */
> > > +	tty1_fd = open("/dev/tty1", O_RDWR);
> > > +	ASSERT_LE(0, tty1_fd);
> > > +	EXPECT_EQ(0, test_tty_ioctl(tty1_fd));
> > 
> > /dev, or rather the test PTS mount point, and its parent, should also be
> > tested. We can use three layers in the same test for that.
> 
> We've already tested the inheritance of access rights across different
> directories and mount points in other tests.  I feel that exercising it in all
> combinations of access rights and inheritance mechanisms makes the tests harder
> to understand and maintain, and does not give us much additional confidence on
> top of what we already have.  What balance do you want to find there?

Indeed. It should be notted that this new IOCTL access right will be the
first one to directly apply to both files and directories.  It should
then have the same scope as LANDLOCK_ACCESS_FS_READ i.e., apply to the
target directory itself and files/directories beneath it.

We then need to test a directory's IOCTL, for instance using FIOQSIZE.

What about this two rules and related access checks, combined with
already-opened FD?
- dir_s1d1: always denied (negative test)
- file1_s1d1: allowed with a rule (checks ACCESS_FILE)
- dir_s2d1: allowed with a rule (checks directory right)

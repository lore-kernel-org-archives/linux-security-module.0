Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0919EB64D9
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Jun 2023 14:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjFSOmW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Jun 2023 10:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjFSOmV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Jun 2023 10:42:21 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D79AA
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 07:42:19 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QlCCZ2XRMzMpnwC;
        Mon, 19 Jun 2023 14:42:18 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QlCCY4mGBzMqLGY;
        Mon, 19 Jun 2023 16:42:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1687185738;
        bh=IIvkgIR4vC8uOyaM3p4I7a8MQ+bwvqtTR2HLOVtYS0I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MEtzv9FSyiKtK8jjfnbZR1SJHDpxVSrnAZqPwimWuw584Z4jOfWODdEr7wCmmLfPS
         s8KUgZhC+HwUZ1zt7CP/Iq26GCjGvvFvfpYnWM1JYXANRPlEwAtfNirtYS5qcbd919
         wpYayWua2klUjUsrWNtYA+3MgV+WYGCJXPyTO4pE=
Message-ID: <be5ac5ab-2b00-b896-27fc-14c30f938622@digikod.net>
Date:   Mon, 19 Jun 2023 16:42:17 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [RFC 3/4] selftests/landlock: Test ioctl support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
 <20230502171755.9788-4-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230502171755.9788-4-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 02/05/2023 19:17, Günther Noack wrote:
> Exercise the use of Landlock's ioctl restriction: If ioctl is
> restricted, the use of ioctl fails with a freshly opened /dev/tty
> file.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   tools/testing/selftests/landlock/fs_test.c | 62 ++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index fdd7d439ce4..1f827604374 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -3655,6 +3655,68 @@ TEST(memfd_ftruncate)
>   	ASSERT_EQ(0, close(fd));
>   }
>   
> +/*
> + * Invokes ioctl(2) and returns its errno or 0.
> + * The provided fd needs to be a tty for this to work.
> + */
> +static int test_tty_ioctl(int fd)
> +{
> +	struct winsize ws;
> +
> +	if (ioctl(fd, TIOCGWINSZ, &ws) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +/*
> + * Attempt ioctl on /dev/tty0 and /dev/tty1,
> + * with file descriptors opened before and after landlocking.
> + */
> +TEST_F_FORK(layout1, ioctl)
> +{
> +	const struct rule rules[] = {
> +		{
> +			.path = "/dev/tty1",
> +			.access = LANDLOCK_ACCESS_FS_IOCTL,
> +		},
> +		/* Implicitly: No ioctl access on /dev/tty0. */

We should create a new PTS mount point, create a new session, and use 
that for tests to limit the dependency on the test environment and not 
mess with it.


> +		{},
> +	};
> +	const __u64 handled = LANDLOCK_ACCESS_FS_IOCTL;
> +	int ruleset_fd;
> +	int old_tty0_fd, tty0_fd, tty1_fd;
> +
> +	old_tty0_fd = open("/dev/tty0", O_RDWR);
> +	ASSERT_LE(0, old_tty0_fd);
> +
> +	/* Checks that ioctl works before landlocking. */
> +	EXPECT_EQ(0, test_tty_ioctl(old_tty0_fd));
> +
> +	/* Enable Landlock. */

Enable*s*

> +	ruleset_fd = create_ruleset(_metadata, handled, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Checks that ioctl with existing FD works after landlocking. */
> +	EXPECT_EQ(0, test_tty_ioctl(old_tty0_fd));
> +
> +	/* Checks that same ioctl fails when file is opened after landlocking. */
> +	tty0_fd = open("/dev/tty0", O_RDWR);
> +	ASSERT_LE(0, tty0_fd);
> +	EXPECT_EQ(EACCES, test_tty_ioctl(tty0_fd));
> +
> +	/* Checks that same ioctl fails when file is opened after landlocking. */
> +	tty1_fd = open("/dev/tty1", O_RDWR);
> +	ASSERT_LE(0, tty1_fd);
> +	EXPECT_EQ(0, test_tty_ioctl(tty1_fd));

/dev, or rather the test PTS mount point, and its parent, should also be 
tested. We can use three layers in the same test for that.


> +
> +	/* Close all TTY file descriptors. */
> +	ASSERT_EQ(0, close(old_tty0_fd));
> +	ASSERT_EQ(0, close(tty0_fd));
> +	ASSERT_EQ(0, close(tty1_fd));
> +}
> +
>   /* clang-format off */
>   FIXTURE(layout1_bind) {};
>   /* clang-format on */

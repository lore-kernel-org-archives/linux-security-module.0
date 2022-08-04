Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC54C19F2A
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Aug 2022 16:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiHDQPX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiHDQPW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Aug 2022 12:15:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6205D38BD
        for <linux-security-module@vger.kernel.org>; Thu,  4 Aug 2022 09:15:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e13so221619edj.12
        for <linux-security-module@vger.kernel.org>; Thu, 04 Aug 2022 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Tca0LvqUpsJdMFZfr/VDwWEfy5/s8PD5FyAyQnfcz9U=;
        b=IrR0Ab+lPKxoCx5/1tTJoV6t7p/zBkVm97SQHGEzr8jqUrHPB9Fk6rOb6Z5zUbMh+x
         /uEWWU7uK9hjjnh17LqAgVmpPjJSBEWv27AALC5oj9dpjPvhS9gY9WOS/BLfY4z3ZEqh
         ibHkfyZXYu+TgJ+2wRCv5ooPvsqKZPS1n5tDc1eMkVCugK3d+wliB73E8MJidguHAigc
         43zSFRopyTjZYETHCOdbDLOanJLDbddkM6S5u6NDngkL4B/VIK9VOKOpKYj+51L6AAXL
         n3cABnwK/uUOvzXTUhh3/iW5gzSQ+iUmbUbe1rv9/ywcssYOpvA3HhX/u/StCbr1t+kY
         VU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Tca0LvqUpsJdMFZfr/VDwWEfy5/s8PD5FyAyQnfcz9U=;
        b=6NmZ9hQBEkIuCkf94jjpvAC+DHiWqh0PU18O+SZM1SE0FY2SX4n09E0FAa+PLMjsGY
         6Bd0Om7rweFVAtNgUYOhx9nUPC8+Gcp2mncqbO8gXUX0mp/Ewczl85HRpXOeeQ7I42ly
         QhL3jX/7LuqJvXXtb1mNGDv4YAO0WIx0rHT8ldJlMC+OxGT4orXbnQDl0i/p5kucf5ho
         vPnaXbAeiHT8orStcNs8RZXbLTYC56GCjgYdFskMtJoYru3BufPbWrO71A2/tu/f3sRQ
         v6DyM+DNKrcPuZcUwwygp7JcbpSa55X5MjF21fUeJiGdRwPaZN2+MK/TsXlZd0miGV2e
         xXLA==
X-Gm-Message-State: ACgBeo3QUE+c/o8zgEOus2GG7r62O7Q2eedxOcxwbUcmXoiknEvNnKBx
        HRcO8eT+cSaapgCwWa11Qno=
X-Google-Smtp-Source: AA6agR73hmq5jhDe6mP/D2dlLcZ7wlaWgEv9XNRoOwHurBYFir46IX5KaWTGBBxV+bDpOmLmOu/G4w==
X-Received: by 2002:a05:6402:1681:b0:43d:2e92:63d with SMTP id a1-20020a056402168100b0043d2e92063dmr2813329edv.253.1659629718720;
        Thu, 04 Aug 2022 09:15:18 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id d27-20020a170906305b00b00722e8c47cc9sm472932ejd.181.2022.08.04.09.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:15:18 -0700 (PDT)
Date:   Thu, 4 Aug 2022 18:15:16 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2 2/4] selftests/landlock: Selftests for file truncation
 support
Message-ID: <YuvwlJy4/hHYwxsR@nuc>
References: <20220712211405.14705-1-gnoack3000@gmail.com>
 <20220712211405.14705-3-gnoack3000@gmail.com>
 <ce29d7e4-dc0a-db53-e130-b73f270bc16f@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce29d7e4-dc0a-db53-e130-b73f270bc16f@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 29, 2022 at 11:39:40AM +0200, Mickaël Salaün wrote:
>
> On 12/07/2022 23:14, Günther Noack wrote:
> > These tests exercise the following truncation operations:
> >
> > * truncate() and trunate64() (truncate by path)
> > * ftruncate() and ftruncate64() (truncate by file descriptor)
> > * open with the O_TRUNC flag
> > * special case: creat(), which is open with O_CREAT|O_WRONLY|O_TRUNC.
> >
> > in the following scenarios:
> >
> > * Files with read, write and truncate rights.
> > * Files with read and truncate rights.
> > * Files with the truncate right.
> > * Files without the truncate right.
> >
> > In particular, the following scenarios are enforced with the test:
> >
> > * The truncate right is required to use ftruncate,
> >    even when the thread already has the right to write to the file.
> > * open() with O_TRUNC requires the truncate right, if it truncates a file.
> >    open() already checks security_path_truncate() in this case,
> >    and it required no additional check in the Landlock LSM's file_open hook.
> > * creat() requires the truncate right
> >    when called with an existing filename.
> > * creat() does *not* require the truncate right
> >    when it's creating a new file.
> >
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > Link: https://lore.kernel.org/all/20220707200612.132705-3-gnoack3000@gmail.com/
> > ---
> >   tools/testing/selftests/landlock/fs_test.c | 238 +++++++++++++++++++++
> >   1 file changed, 238 insertions(+)
> >
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index cb77eaa01c91..1e5660118bce 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -3023,6 +3023,244 @@ TEST_F_FORK(layout1, proc_pipe)
> >   	ASSERT_EQ(0, close(pipe_fds[1]));
> >   }
> > +TEST_F_FORK(layout1, truncate)
> > +{
> > +	const char *file_rwt = file1_s1d1;
>
> You can make file_rwt (and others) const too:
> const char *const file_rwt = file1_s1d1;

Done.

>
>
> > +	const char *file_rw = file2_s1d1;
> > +	const char *file_rt = file1_s1d2;
> > +	const char *file_t = file2_s1d2;
> > +	const char *file_none = file1_s1d3;
> > +	const char *dir_t = dir_s2d1;
> > +	const char *file_in_dir_t = file1_s2d1;
> > +	const struct rule rules[] = {
> > +		{
> > +			.path = file_rwt,
> > +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> > +				  LANDLOCK_ACCESS_FS_WRITE_FILE |
> > +				  LANDLOCK_ACCESS_FS_TRUNCATE,
> > +		},
> > +		{
> > +			.path = file_rw,
> > +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> > +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> > +		},
> > +		{
> > +			.path = file_rt,
> > +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> > +				  LANDLOCK_ACCESS_FS_TRUNCATE,
> > +		},
> > +		{
> > +			.path = file_t,
> > +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> > +		},
> > +		// Implicitly: No access rights for file_none.
> > +		{
> > +			.path = dir_t,
> > +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> > +		},
> > +		{},
> > +	};
> > +	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
> > +			      LANDLOCK_ACCESS_FS_WRITE_FILE |
> > +			      LANDLOCK_ACCESS_FS_TRUNCATE;
> > +	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
> > +	struct stat statbuf;
> > +	int reg_fd;
> > +
> > +	ASSERT_LE(0, ruleset_fd);
> > +	enforce_ruleset(_metadata, ruleset_fd);
> > +	ASSERT_EQ(0, close(ruleset_fd));
> > +
> > +	/* Checks read, write and truncate rights: truncate and ftruncate work. */
> > +	reg_fd = open(file_rwt, O_WRONLY | O_CLOEXEC);
> > +	ASSERT_LE(0, reg_fd);
> > +	EXPECT_EQ(0, ftruncate(reg_fd, 10));
> > +	EXPECT_EQ(0, ftruncate64(reg_fd, 20));
> > +	ASSERT_EQ(0, close(reg_fd));
>
> Could you add the same ftruncate* checks with a O_RDONLY FD?

Done.

Side note: ftruncate(2) on a read-only FD returns EINVAL because the
FD must be writable. (This happens independent of LSM policies.)

>
>
> > +
> > +	EXPECT_EQ(0, truncate(file_rwt, 10));
> > +	EXPECT_EQ(0, truncate64(file_rwt, 20));
> > +
> > +	reg_fd = open(file_rwt, O_WRONLY | O_TRUNC | O_CLOEXEC);
> > +	ASSERT_LE(0, reg_fd);
> > +	ASSERT_EQ(0, close(reg_fd));
> > +
> > +	reg_fd = open(file_rwt, O_RDONLY | O_TRUNC | O_CLOEXEC);
> > +	ASSERT_LE(0, reg_fd);
> > +	ASSERT_EQ(0, close(reg_fd));
>
> I'm not sure if it would be worth it, but can you try to move these checks
> in a standalone helper (like test_execute) that could be use for all/most
> scenarios?

Thanks for the suggestion, this has simplified the tests a lot!

I created additional helpers test_truncate(), test_ftruncate() and
test_creat() which call the corresponding syscalls, do necessary
file-descriptor cleanups and which just return the errno or 0, as it
was already done by test_open().

So the tests are now basically just a sequence of

  EXPECT_EQ(EACCES, test_something(...));

calls, with differing operations exercised and expected errors.

>
>
> > +
> > +	/* Checks read and write rights: no truncate variant works. */
> > +	reg_fd = open(file_rw, O_WRONLY | O_CLOEXEC);
> > +	ASSERT_LE(0, reg_fd);
> > +	EXPECT_EQ(-1, ftruncate(reg_fd, 10));
> > +	EXPECT_EQ(EACCES, errno);
> > +	EXPECT_EQ(-1, ftruncate64(reg_fd, 20));
> > +	EXPECT_EQ(EACCES, errno);
> > +	ASSERT_EQ(0, close(reg_fd));
> > +
> > +	EXPECT_EQ(-1, truncate(file_rw, 10));
> > +	EXPECT_EQ(EACCES, errno);
> > +	EXPECT_EQ(-1, truncate64(file_rw, 20));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	EXPECT_EQ(-1, open(file_rw, O_WRONLY | O_TRUNC | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	EXPECT_EQ(-1, open(file_rw, O_RDONLY | O_TRUNC | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	/* Checks read and truncate right: truncate works, also with open(2). */
>
> "right*s*" ? Just keep it consistent with other comments.

Done.

>
>
> > +	EXPECT_EQ(-1, open(file_rt, O_WRONLY | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	EXPECT_EQ(0, truncate(file_rt, 10));
> > +	EXPECT_EQ(0, truncate64(file_rt, 20));
> > +
> > +	reg_fd = open(file_rt, O_RDONLY | O_TRUNC | O_CLOEXEC);
> > +	ASSERT_LE(0, reg_fd);
> > +	ASSERT_EQ(0, fstat(reg_fd, &statbuf));
> > +	EXPECT_EQ(0, statbuf.st_size);
> > +	ASSERT_EQ(0, close(reg_fd));
>
> Why checking fstat? And why only here?

Fixed; you are right, this was a bit inconsistent and just made it more confusing.

>
>
> > +
> > +	/* Checks truncate right: truncate works, but can't open file. */
> > +	EXPECT_EQ(-1, open(file_t, O_WRONLY | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	EXPECT_EQ(0, truncate(file_t, 10));
> > +	EXPECT_EQ(0, truncate64(file_t, 20));
> > +
> > +	EXPECT_EQ(-1, open(file_t, O_RDONLY | O_TRUNC | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	/* Checks "no rights" case: No form of truncation works. */
>
> Nit: Do we need an "s" if there is none?

I believe plural is correct after "no", as in "no dogs allowed".

>
>
> > +	EXPECT_EQ(-1, open(file_none, O_WRONLY | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	EXPECT_EQ(-1, truncate(file_none, 10));
> > +	EXPECT_EQ(EACCES, errno);
> > +	EXPECT_EQ(-1, truncate64(file_none, 20));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	EXPECT_EQ(-1, open(file_none, O_RDONLY | O_TRUNC | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	/* Checks truncate right on directory:  */
> > +	EXPECT_EQ(-1, open(file_in_dir_t, O_WRONLY | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	EXPECT_EQ(0, truncate(file_in_dir_t, 10));
> > +	EXPECT_EQ(0, truncate64(file_in_dir_t, 20));
> > +
> > +	EXPECT_EQ(-1, open(file_in_dir_t, O_RDONLY | O_TRUNC | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +}
> > +
> > +/*
> > + * Exercises file truncation when it's not restricted,
> > + * as it was the case before LANDLOCK_ACCESS_FS_TRUNCATE existed.
> > + */
> > +TEST_F_FORK(layout1, truncate_unhandled)
>
> Could you merge these truncate_unhandled tests with TEST_F_FORK(layout1,
> truncate)? You can use it as a first layer of rules. This will make sure
> that nested stacking with different handled access rights works as expected.

I have attempted this, but the layering of rules quickly made it
difficult to reason about the test (it's more difficult to track which
files has which rights). I would prefer to test these concerns
separate from each other, so that each test exercises a less
complicated scenario and is easier to reason about.

I see that layering is already exercised in other tests in fs_test.c.
I imagine that the kernel code for that works the same for the entire
bitmask, so testing it for truncate specifically probably wouldn't
give us that much additional confidence?

Please let me know if you feel strongly about it, in case I'm
overlooking a complication.

>
>
> > +{
> > +	const char *file_r = file1_s1d1;
> > +	const char *file_w = file2_s1d1;
> > +	const char *file_none = file1_s1d2;
> > +	const struct rule rules[] = {
> > +		{
> > +			.path = file_r,
> > +			.access = LANDLOCK_ACCESS_FS_READ_FILE,
> > +		},
> > +		{
> > +			.path = file_w,
> > +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> > +		},
> > +		// Implicitly: No rights for file_none.
> > +		{},
> > +	};
> > +	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
> > +			      LANDLOCK_ACCESS_FS_WRITE_FILE;
> > +	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
> > +	int reg_fd;
> > +
> > +	ASSERT_LE(0, ruleset_fd);
> > +	enforce_ruleset(_metadata, ruleset_fd);
> > +	ASSERT_EQ(0, close(ruleset_fd));
> > +
> > +	/* Checks read right: truncation should work through truncate and open. */
> > +	EXPECT_EQ(0, truncate(file_r, 10));
> > +	EXPECT_EQ(0, truncate64(file_r, 20));
> > +
> > +	reg_fd = open(file_r, O_RDONLY | O_TRUNC | O_CLOEXEC);
> > +	ASSERT_LE(0, reg_fd);
> > +	ASSERT_EQ(0, close(reg_fd));
> > +
> > +	EXPECT_EQ(-1, open(file_r, O_WRONLY | O_TRUNC | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	/* Checks write right: truncation should work through truncate, ftruncate and open. */
> > +	EXPECT_EQ(0, truncate(file_w, 10));
> > +	EXPECT_EQ(0, truncate64(file_w, 20));
> > +
> > +	EXPECT_EQ(-1, open(file_w, O_RDONLY | O_TRUNC | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	reg_fd = open(file_w, O_WRONLY | O_TRUNC | O_CLOEXEC);
> > +	ASSERT_LE(0, reg_fd);
> > +	ASSERT_EQ(0, close(reg_fd));
> > +
> > +	reg_fd = open(file_w, O_WRONLY);
> > +	ASSERT_LE(0, reg_fd);
> > +	EXPECT_EQ(0, ftruncate(reg_fd, 10));
> > +	EXPECT_EQ(0, ftruncate64(reg_fd, 20));
> > +	ASSERT_EQ(0, close(reg_fd));
> > +
> > +	/* Checks "no rights" case: truncate works but all open attempts fail. */
> > +	EXPECT_EQ(0, truncate(file_none, 10));
> > +	EXPECT_EQ(0, truncate64(file_none, 20));
> > +
> > +	EXPECT_EQ(-1, open(file_none, O_RDONLY | O_TRUNC | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	EXPECT_EQ(-1, open(file_none, O_WRONLY | O_TRUNC | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	EXPECT_EQ(-1, open(file_none, O_WRONLY | O_CLOEXEC));
> > +	EXPECT_EQ(EACCES, errno);
> > +}
> > +
> > +/* Exercises creat(), which is equivalent to an open with O_CREAT|O_WRONLY|O_TRUNC. */
> > +TEST_F_FORK(layout1, truncate_creat)
>
> You can merge these truncate_creat tests too in TEST_F_FORK(layout1,
> truncate) (without dedicated layer though).

Done.

I added an additional file f1 under s3d1 in layout1, so that it would
be easy to exercise. (The creat tests rely on the rights being given
on the parent directory, because they unlink the file at some point.)

>
>
> > +{
> > +	const struct rule rules[] = {
> > +		{
> > +			.path = dir_s1d1,
> > +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> > +		},
> > +		{}
> > +	};
> > +	const __u64 handled = LANDLOCK_ACCESS_FS_WRITE_FILE |
> > +			      LANDLOCK_ACCESS_FS_TRUNCATE;
> > +	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
> > +	int reg_fd;
> > +
> > +	ASSERT_LE(0, ruleset_fd);
> > +	enforce_ruleset(_metadata, ruleset_fd);
> > +	ASSERT_EQ(0, close(ruleset_fd));
> > +
> > +	/* Checks creating a new file: This should work even without the truncate right. */
> > +	ASSERT_EQ(0, unlink(file1_s1d1));
> > +
> > +	reg_fd = creat(file1_s1d1, 0600);
> > +	ASSERT_LE(0, reg_fd);
> > +	ASSERT_EQ(0, close(reg_fd));
> > +
> > +	/*
> > +	 * Checks creating a file over an existing one:
> > +	 * This should fail. It would truncate the file, and we don't have that right.
> > +	 */
> > +	EXPECT_EQ(-1, creat(file2_s1d1, 0600));
> > +	EXPECT_EQ(EACCES, errno);
> > +}
> > +
> >   /* clang-format off */
> >   FIXTURE(layout1_bind) {};
> >   /* clang-format on */

--

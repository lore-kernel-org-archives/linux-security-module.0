Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F0CC19F2D
	for <linux-security-module@archiver.kernel.org>; Sat, 13 Aug 2022 10:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiHMKH7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 13 Aug 2022 06:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbiHMKH7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 13 Aug 2022 06:07:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8565DDFE0
        for <linux-security-module@vger.kernel.org>; Sat, 13 Aug 2022 03:07:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qn6so5713615ejc.11
        for <linux-security-module@vger.kernel.org>; Sat, 13 Aug 2022 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=WpPE74zzzUw30rL3cB0AN//HhwqDLceRRgWhL2z0N68=;
        b=YlY3+qAGXEWtoAQsKXhgbLZiHIJHdgUtIxK6HnV0t/KDvsxp0NrmfcdNkLex1tQCH2
         GhIJ48JBNvu+hiDchArv0nmbNJQNzwaMYd9B+BoGxBtGB2C1d1fyYje5Lmki7sLUYrKn
         ORI5Efyoy9Ajzsvq5X5EzjwK22wKk4m01jXlBqDEjYdzOWvQk47ZJtCGz0s5jeJGCn8y
         EG2Oa8W0jP1Oi57d6vWws3yK7lBnvEU+hde+aiayh1+0nFEBv3p6WYswzBYfywhhN1uY
         mz1V+kV67EyMa0ojZqLraniQz3dumPegDk5Fbu9mAzset8vydWCVXUR0wtS2QQuQI7Xk
         K9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=WpPE74zzzUw30rL3cB0AN//HhwqDLceRRgWhL2z0N68=;
        b=st2iebiJe8tuiwUkPPPK3yvxZ5U/U4s+eFL3/G0oToPDoJFlxZNbWS/Vh4bsJbUj0/
         NzjaWsY26ZmuhXs73+trH8Jvt6ecoKZPW86RgeVxHGxTnDqP3972U84pn2GO7b12hrqw
         l7p+k5zKfAmEPhZTTyhTldt4fmEC9mW9tCDhjVQ+gNn1Ujmq4cc4S4wuRHHZY6GXEFDM
         V3eHGYF4FXZ1xQnJYONSypPbCTvezgtUq6rK3HzT5X/EKjEsOM2dmbxZRoXx9S9atG5o
         +z7L/HrGCdEIUs6vsdsDTXckzMTNGEJ6hKDKmG0JfKmlOkDeiPcYkgqCII0JAeMR98lE
         yoHw==
X-Gm-Message-State: ACgBeo07fbnQW48HnZicCvHeThCPzoxVf/LMNEdTiC9d85OwgbcMFsKM
        pub248sr6zEQWRf7C3B4HuU=
X-Google-Smtp-Source: AA6agR6liU71XgIrpO1zCE4d8OpSBm4LSvlwp0Gdit+NuWrNUzT5ebmOA+CKbapYunGMoiOIq89W1w==
X-Received: by 2002:a17:906:7e43:b0:72b:52de:b039 with SMTP id z3-20020a1709067e4300b0072b52deb039mr5165918ejr.198.1660385275675;
        Sat, 13 Aug 2022 03:07:55 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id n18-20020aa7c452000000b0043ba437fe04sm2810411edr.78.2022.08.13.03.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 03:07:55 -0700 (PDT)
Date:   Sat, 13 Aug 2022 12:07:53 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3 2/4] selftests/landlock: Selftests for file truncation
 support
Message-ID: <Yvd3+fy+mDBop+YA@nuc>
References: <20220804193746.9161-1-gnoack3000@gmail.com>
 <20220804193746.9161-3-gnoack3000@gmail.com>
 <40ad7781-a94d-7be2-e5b9-64b6893a669e@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40ad7781-a94d-7be2-e5b9-64b6893a669e@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 11, 2022 at 06:59:38PM +0200, Mickaël Salaün wrote:
>
> On 04/08/2022 21:37, Günther Noack wrote:
> > These tests exercise the following truncation operations:
> >
> > * truncate() (truncate by path)
> > * ftruncate() (truncate by file descriptor)
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
> > ---
> >   tools/testing/selftests/landlock/fs_test.c | 204 +++++++++++++++++++++
> >   1 file changed, 204 insertions(+)
> >
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index cb77eaa01c91..3e84bae7e83a 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -58,6 +58,7 @@ static const char file1_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f1";
> >   static const char file2_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f2";
> >   static const char dir_s3d1[] = TMP_DIR "/s3d1";
> > +static const char file1_s3d1[] = TMP_DIR "/s3d1/f1";
> >   /* dir_s3d2 is a mount point. */
> >   static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
> >   static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
> > @@ -83,6 +84,7 @@ static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
> >    * │           ├── f1
> >    * │           └── f2
> >    * └── s3d1
> > + *     ├── f1
> >    *     └── s3d2
> >    *         └── s3d3
> >    */
> > @@ -208,6 +210,7 @@ static void create_layout1(struct __test_metadata *const _metadata)
> >   	create_file(_metadata, file1_s2d3);
> >   	create_file(_metadata, file2_s2d3);
> > +	create_file(_metadata, file1_s3d1);
> >   	create_directory(_metadata, dir_s3d2);
> >   	set_cap(_metadata, CAP_SYS_ADMIN);
> >   	ASSERT_EQ(0, mount("tmp", dir_s3d2, "tmpfs", 0, "size=4m,mode=700"));
> > @@ -230,6 +233,7 @@ static void remove_layout1(struct __test_metadata *const _metadata)
> >   	EXPECT_EQ(0, remove_path(file1_s2d2));
> >   	EXPECT_EQ(0, remove_path(file1_s2d1));
> > +	EXPECT_EQ(0, remove_path(file1_s3d1));
> >   	EXPECT_EQ(0, remove_path(dir_s3d3));
> >   	set_cap(_metadata, CAP_SYS_ADMIN);
> >   	umount(dir_s3d2);
> > @@ -3023,6 +3027,206 @@ TEST_F_FORK(layout1, proc_pipe)
> >   	ASSERT_EQ(0, close(pipe_fds[1]));
> >   }
> > +/* Opens the file, invokes ftruncate(2) and returns the errno or 0. */
> > +static int test_ftruncate(struct __test_metadata *const _metadata,
> > +			  const char *const path, int flags)
> > +{
> > +	int res, err, fd;
> > +
> > +	fd = open(path, flags | O_CLOEXEC);
> > +	ASSERT_LE(0, fd);
> > +
> > +	res = ftruncate(fd, 10);
> > +	err = errno;
> > +	ASSERT_EQ(0, close(fd));
> > +
> > +	if (res < 0)
> > +		return err;
> > +	return 0;
> > +}
> > +
> > +/* Invokes truncate(2) and returns the errno or 0. */
> > +static int test_truncate(const char *const path)
> > +{
> > +	if (truncate(path, 10) < 0)
> > +		return errno;
> > +	return 0;
> > +}
> > +
> > +/* Invokes creat(2) and returns the errno or 0. */
> > +static int test_creat(struct __test_metadata *const _metadata,
> > +		      const char *const path, mode_t mode)
> > +{
> > +	int fd = creat(path, mode);
> > +
> > +	if (fd < 0)
> > +		return errno;
> > +	ASSERT_EQ(0, close(fd));
>
> test_creat() contains an ASSERT, which would only print this line, which
> would not help much if it is called multiple times, which is the case. I
> prefer not passing _metadata but only returning errno or 0 and handling the
> ASSERT in layout1.truncate* . It is not the case everywhere but we should
> try to follow this rule as much as possible.

Thanks, that's a good point that the line number attribution becomes confusing.

I changed these ASSERT_EQ() calls to just return the errno directly.


> > +	return 0;
> > +}
> > +
> > +TEST_F_FORK(layout1, truncate)
> > +{
> > +	const char *const file_rwt = file1_s1d1;
> > +	const char *const file_rw = file2_s1d1;
> > +	const char *const file_rt = file1_s1d2;
> > +	const char *const file_t = file2_s1d2;
> > +	const char *const file_none = file1_s1d3;
> > +	const char *const dir_t = dir_s2d1;
> > +	const char *const file_in_dir_t = file1_s2d1;
> > +	const char *const dir_w = dir_s3d1;
> > +	const char *const file_in_dir_w = file1_s3d1;
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
> > +		{
> > +			.path = dir_w,
> > +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> > +		},
> > +		{},
> > +	};
> > +	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
> > +			      LANDLOCK_ACCESS_FS_WRITE_FILE |
> > +			      LANDLOCK_ACCESS_FS_TRUNCATE;
> > +	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
> > +
> > +	ASSERT_LE(0, ruleset_fd);
> > +	enforce_ruleset(_metadata, ruleset_fd);
> > +	ASSERT_EQ(0, close(ruleset_fd));
> > +
> > +	/*
> > +	 * Checks read, write and truncate rights: truncation works.
> > +	 *
> > +	 * Note: Independent of Landlock, ftruncate(2) on read-only
> > +	 * file descriptors never works.
> > +	 */
> > +	EXPECT_EQ(0, test_ftruncate(_metadata, file_rwt, O_WRONLY));
>
> Other than following the original Google Test documentation, what is the
> advantage to use EXPECT? Don't you think it would be harder to debug a bunch
> of failed expect?

<This is maybe slightly philosophical, which means that I have no hard
proof for any of this, but I'm happy to discuss it :)>

I think at the root, most test frameworks agree that the test output
should ideally be a list of mostly-independent test scenarios together
with their failure statuses.

I think it is actually *easier* to debug a bunch of failed
expectations if they fail at the same time: When multiple of these
scenarios fail at the same time, that would give you a hint that
something more fundamental is broken, whereas when only one of them
fails, you'd know that it is a problem specific to the test scenario
at hand.

> What is the reason for other test frameworks to not
> implement EXPECT?

The way that the different test frameworks try to achieve this "table
of scenarios" output is different:

The JUnit/xUnit-style frameworks only have an ASSERT-equivalent, and I
think in these testing cultures there is a greater emphasis on having
a separate test function for each exercised scenario. That way, you
still end up with a long table of test scenarios with their failure
statuses. -- But that is not the test structure that we have here in
the Landlock selftests.

In Googletest, or in the Go test framework, there is a distinction
between ASSERT and EXPECT, and people are more encouraged to test
multiple similar scenarios in the same function (in Go, they call it a
"table driven test"). It works as well, as long as people take care
that the scenarios that are tested together don't accidentally depend
on each others left-over state.

I'm not sure why some test frameworks do this with assert-only and
others distinguish between assert and expect.

I *suspect* that in C and C++, it is more difficult to factor out
shared test setup code than in Java or Python, and so people tend to
write bigger test functions that exercise more scenarios at once, and
then the distinction between assert and expect became more useful.

<end of philosophical derail>


> How Chromium or other Google code really use it? Genuine questions.

This is how Chromium uses it:

https://source.chromium.org/search?q=ASSERT_EQ (~6000 hits)
https://source.chromium.org/search?q=EXPECT_EQ (~5800 hits)

This is how Absl uses it (from the website: "Abseil is an open source
collection of C++ libraries drawn from the most fundamental pieces of
Google’s internal codebase."):

https://github.com/abseil/abseil-cpp/search?q=EXPECT_EQ (163 results)
https://github.com/abseil/abseil-cpp/search?q=ASSERT_EQ (24 results)

In Chromium, there are clearly some corners where they use ASSERT
exclusively. In Abseil, I think it gets used more in the spirit of the
framework, but it's also a smaller codebase.


**To make a constructive proposal**:

I think that using EXPECT improves debuggability in case of a test
failure, but both with EXPECT and with ASSERT, the tests will give the
same guarantee that the code works, so I feel that this should not be
blocking the truncate patch... so I'd just go and convert it all to
ASSERTs, it'll be consistent with the surrounding tests, and we can
have that EXPECT/ASSERT discussion separately if you like. Does that
sound good?

>
>
> > +	EXPECT_EQ(EINVAL, test_ftruncate(_metadata, file_rwt, O_RDONLY));
> > +	EXPECT_EQ(0, test_truncate(file_rwt));
> > +	EXPECT_EQ(0, test_open(file_rwt, O_WRONLY | O_TRUNC));
> > +	EXPECT_EQ(0, test_open(file_rwt, O_RDONLY | O_TRUNC));
> > +
> > +	/* Checks read and write rights: no truncate variant works. */
> > +	EXPECT_EQ(EACCES, test_ftruncate(_metadata, file_rw, O_WRONLY));
> > +	EXPECT_EQ(EINVAL, test_ftruncate(_metadata, file_rw, O_RDONLY));
> > +	EXPECT_EQ(EACCES, test_truncate(file_rw));
> > +	EXPECT_EQ(EACCES, test_open(file_rw, O_WRONLY | O_TRUNC));
> > +	EXPECT_EQ(EACCES, test_open(file_rw, O_RDONLY | O_TRUNC));
> > +
> > +	/*
> > +	 * Checks read and truncate rights: truncation works.
> > +	 *
> > +	 * Note: Files opened in O_RDONLY can get truncated as part of
> > +	 * the same operation.
> > +	 */
> > +	EXPECT_EQ(0, test_open(file_rt, O_RDONLY));
> > +	EXPECT_EQ(0, test_open(file_rt, O_RDONLY | O_TRUNC));
> > +	EXPECT_EQ(EACCES, test_open(file_rt, O_WRONLY));
> > +	EXPECT_EQ(EACCES, test_open(file_rt, O_WRONLY));
> > +	EXPECT_EQ(0, test_truncate(file_rt));
> > +
> > +	/* Checks truncate right: truncate works, but can't open file. */
> > +	EXPECT_EQ(EACCES, test_open(file_t, O_WRONLY));
> > +	EXPECT_EQ(EACCES, test_open(file_t, O_RDONLY));
> > +	EXPECT_EQ(EACCES, test_open(file_t, O_WRONLY | O_TRUNC));
> > +	EXPECT_EQ(EACCES, test_open(file_t, O_RDONLY | O_TRUNC));
> > +	EXPECT_EQ(0, test_truncate(file_t));
> > +
> > +	/* Checks "no rights" case: No form of truncation works. */
> > +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY));
> > +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY));
> > +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
> > +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
> > +	EXPECT_EQ(EACCES, test_truncate(file_none));
> > +
> > +	/* Checks truncate right on directory: truncate works on contained files */
> > +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_WRONLY));
> > +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_RDONLY));
> > +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_WRONLY | O_TRUNC));
> > +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_RDONLY | O_TRUNC));
> > +	EXPECT_EQ(0, test_truncate(file_in_dir_t));
> > +
> > +	/*
> > +	 * Checks creat in dir_w: This requires the truncate right
> > +	 * when overwriting an existing file, but does not require it
> > +	 * when the file is new.
> > +	 */
> > +	EXPECT_EQ(EACCES, test_creat(_metadata, file_in_dir_w, 0600));
> > +
> > +	ASSERT_EQ(0, unlink(file_in_dir_w));
> > +	EXPECT_EQ(0, test_creat(_metadata, file_in_dir_w, 0600));
> > +}
> > +
> > +/*
> > + * Exercises file truncation when it's not restricted,
> > + * as it was the case before LANDLOCK_ACCESS_FS_TRUNCATE existed.
> > + */
> > +TEST_F_FORK(layout1, truncate_unhandled)
> > +{
> > +	const char *const file_r = file1_s1d1;
> > +	const char *const file_w = file2_s1d1;
> > +	const char *const file_none = file1_s1d2;
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
> > +
> > +	ASSERT_LE(0, ruleset_fd);
> > +	enforce_ruleset(_metadata, ruleset_fd);
> > +	ASSERT_EQ(0, close(ruleset_fd));
> > +
> > +	/* Checks read right: truncation should work through truncate and open. */
> > +	EXPECT_EQ(0, test_truncate(file_r));
> > +	EXPECT_EQ(0, test_open(file_r, O_RDONLY | O_TRUNC));
> > +	EXPECT_EQ(EACCES, test_open(file_r, O_WRONLY | O_TRUNC));
> > +
> > +	/* Checks write right: truncation should work through truncate, ftruncate and open. */
> > +	EXPECT_EQ(0, test_truncate(file_w));
> > +	EXPECT_EQ(0, test_ftruncate(_metadata, file_w, O_WRONLY));
> > +	EXPECT_EQ(EACCES, test_open(file_w, O_RDONLY | O_TRUNC));
> > +	EXPECT_EQ(0, test_open(file_w, O_WRONLY | O_TRUNC));
> > +
> > +	/* Checks "no rights" case: truncate works but all open attempts fail. */
> > +	EXPECT_EQ(0, test_truncate(file_none));
> > +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
> > +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
> > +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY));
> > +}
>
> These tests looks good!

Thanks!

>
> > +
> >   /* clang-format off */
> >   FIXTURE(layout1_bind) {};
> >   /* clang-format on */

--

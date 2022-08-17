Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6477AC25B08
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Aug 2022 19:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241599AbiHQTgD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Aug 2022 15:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbiHQTfb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Aug 2022 15:35:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAD158527
        for <linux-security-module@vger.kernel.org>; Wed, 17 Aug 2022 12:35:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i14so26254385ejg.6
        for <linux-security-module@vger.kernel.org>; Wed, 17 Aug 2022 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=zOx5hxZzW46/RSVcw9tWDEjETYTNXNnkzG0F7zbnNII=;
        b=YXIwGdIUetsulXG7TW049a1OwaN13NG4QWVoonzs5/0HQScmrhOpJ9C2mfmWEYJbUS
         2TfMd2yd9/IG3+1P0ItAnMbwqt2tSETlC38lPXcJWlVtHyFCFvVeI2t56/lZoOtlSRCg
         Rs8kmqq4wIWHkpCfStQDClZKyaS2OId5oG+xzPnTdcxl/5auDi4G16pqhsWj9v5HYp+A
         GufxR6q+Hwziyoz6LE0pYwNSSIPv1ZULdlWxr5rgQ0jlBnurl3FGcMbXUKujL72a3oB6
         OS9F0iB/e8IhgvvM/lekEfEmRMinnudtXUjy7YPeBSfe1m96Ir08aMCEvD5rRNZ7ZYqQ
         d+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=zOx5hxZzW46/RSVcw9tWDEjETYTNXNnkzG0F7zbnNII=;
        b=oUqI6y79oroUGsheO7YJ2s71PaOB0ozQC5632oy2Pzhel5JoFp//PqUYVKoFSzyN29
         ws9FupLGLYbXoGGYes4g6Z/ovkiBL/bHBIIZUsJmfrcRBJ0UAYz95yf4meZZO1/k6PJX
         hcN22gCU+V8/orTvMxvPTScnjF8sZKHd8xCzQs4iQWt5fXtj+xgbdB6ObcfZSRpoAIOk
         3wQnwi8BxTjvfZZQPDyR26iRJG7ecYx0E5QlEHkmbhKh77VKz4qZa0dXaR1C447cxIH+
         kTuwIwBmISJbd8oFNAYadpCPBWG5/YfVp+B1cgQXMYUWXnmTfNFKdYRc82tV32CkBFGH
         bPLQ==
X-Gm-Message-State: ACgBeo0Ac0kT6tX4XQgiQxhlBiV3UTs+xGMkzuhZuYs1jAF/R3ZTGZ3D
        6llNamis8wI0EHYwxb9Zi8g=
X-Google-Smtp-Source: AA6agR7yGzJccTKx0TDV5NgIhRMOj3NtH5ZKiMWenQFa1JBEVxc+iXBq34PLFXdUyFE7V/gD4iiUVw==
X-Received: by 2002:a17:906:9b15:b0:730:d10f:a932 with SMTP id eo21-20020a1709069b1500b00730d10fa932mr17470675ejc.304.1660764928235;
        Wed, 17 Aug 2022 12:35:28 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906328500b00731219a2797sm7098467ejw.210.2022.08.17.12.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 12:35:27 -0700 (PDT)
Date:   Wed, 17 Aug 2022 21:35:25 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v4 2/4] selftests/landlock: Selftests for file truncation
 support
Message-ID: <Yv1C/bAD5b5fMgVg@nuc>
References: <20220814192603.7387-1-gnoack3000@gmail.com>
 <20220814192603.7387-3-gnoack3000@gmail.com>
 <6ed7d884-89cb-546f-db0a-1c16209f1c29@digikod.net>
 <Yv0ssfnx8BcUf0Lp@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yv0ssfnx8BcUf0Lp@nuc>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 17, 2022 at 08:00:17PM +0200, Günther Noack wrote:
> On Tue, Aug 16, 2022 at 07:08:20PM +0200, Mickaël Salaün wrote:
> > On 14/08/2022 21:26, Günther Noack wrote:
> > > +/*
> > > + * Opens the file and invokes ftruncate(2).
> > > + *
> > > + * Returns the errno of ftruncate if ftruncate() fails.
> > > + * Returns EBADFD if open() or close() fail (should not happen).
> > > + * Returns 0 if ftruncate(), open() and close() were successful.
> > > + */
> > > +static int test_ftruncate(struct __test_metadata *const _metadata,
> >
> > _metadata is no longer needed. Same for test_creat().
>
> Thanks, well spotted!
>
> >
> >
> > > +			  const char *const path, int flags)
> > > +{
> > > +	int res, err, fd;
> > > +
> > > +	fd = open(path, flags | O_CLOEXEC);
> > > +	if (fd < 0)
> > > +		return EBADFD;
> >
> > Instead of EBADFD, which is a valid open(2) error, you can use ENOSYS and
> > add a comment explaining that we are not interested by this open(2) error
> > code but only the ftruncate(2) one because we are sure opening such path is
> > allowed or because open(2) is already tested before calls to
> > test_ftruncate().
>
> Changed to ENOSYS and added a comment in the code and as function documentation.
>
> The explanation follows the reasoning that callers must guarantee that
> open() and close() will work, in order to test ftruncate() correctly.
> If open() or close() fail, we return ENOSYS.
>
> Technically EBADFD does not get returned by open(2) according to the
> man page, but I changed it to ENOSYS anyway (EBADF and EBADFD are easy
> to mix up).

The more I think about it, the more I feel that test_ftruncate() in its current
form was a mistake:

  * In reality, we just care about the ftruncate() result, not about open().
  * The tests became slightly confusing and asymmetric because some
    places could call test_ftruncate() while others would call test_open()
  * Trying open(..., O_RDONLY) + ftruncate() is also confusing in tests,
    because that never works anyway (ftruncate() only works on writable fds)

So: I'm contemplating to use a different approach instead:

  * Open a writable FD for each file *before enforcing Landlock*.
  * *Then* enforce Landlock (now some of these files can't be opened any more)
  * Then try ftruncate() with the previously opened file descriptor.

As a result,

  * we have some new repetitive but simple code for opening file descriptors
  * we remove the long version of test_ftruncate() with all its error case
    complication and replace it with a trivial one that takes an already-opened
    file descriptor.

This way, each block in the test now checks the following things:

  * check truncate(file)
  * check ftruncate(file_fd) <--- passing the FD!
  * check open(file, O_RDONLY|O_TRUNC)
  * check open(file, O_WRONLY|O_TRUNC)

It's now easy to see in the tests that the result from truncate() and
ftruncate() is always the same. The complication of worrying whether open()
works before ftruncate() is also gone (so no more special open() checks needed
before checking ftruncate()). I removed the testing of ftruncate() on read-only
file descriptors, because that is forbidden in the ftruncate() manpage anyway
and always returns EINVAL independent of Landlock.

I feel that this helps clarify the tests, even if it undoes some of your
comments about expecting open() to work before ftruncate().

Does that approach look reasonable to you?

I might just send you a patch version with that variant I think - this might be
clearer in code than in my textual description here. :)

—Günther

>
> > > +
> > > +	res = ftruncate(fd, 10);
> > > +	err = errno;
> > > +
> > > +	if (close(fd) != 0)
> > > +		return EBADFD;
> >
> > Why not returning errno? See test_open_rel() comments.
>
> OK, changed to return errno for consistency, with the same comment.
>
> >
> >
> > > +
> > > +	if (res < 0)
> > > +		return err;
> > > +	return 0;
> > > +}
> > > +
> > > +/* Invokes truncate(2) and returns the errno or 0. */
> > > +static int test_truncate(const char *const path)
> > > +{
> > > +	if (truncate(path, 10) < 0)
> > > +		return errno;
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * Invokes creat(2) and returns its errno or 0.
> > > + * Closes the opened file descriptor on success.
> > > + * Returns EBADFD if close() returns an error (should not happen).
> > > + */
> > > +static int test_creat(struct __test_metadata *const _metadata,
> > > +		      const char *const path, mode_t mode)
> > > +{
> > > +	int fd = creat(path, mode);
> > > +
> > > +	if (fd < 0)
> > > +		return errno;
> > > +
> > > +	if (close(fd) < 0)
> > > +		return EBADFD;
> >
> > Why not returning errno?
>
> Done. (Same)
>
> > > +		// Implicitly: No access rights for file_none.
> >
> > Please use /* */ comments everywhere.
>
> Done. (in both places)
>
> > > +	/*
> > > +	 * Checks read, write and truncate rights: truncation works.
> > > +	 *
> > > +	 * Note: Independent of Landlock, ftruncate(2) on read-only
> > > +	 * file descriptors never works.
> > > +	 */
> > > +	EXPECT_EQ(0, test_ftruncate(_metadata, file_rwt, O_WRONLY));
> > > +	EXPECT_EQ(EINVAL, test_ftruncate(_metadata, file_rwt, O_RDONLY));
> > > +	EXPECT_EQ(0, test_truncate(file_rwt));
> > > +	EXPECT_EQ(0, test_open(file_rwt, O_WRONLY | O_TRUNC));
> >
> > Could you please interleave the test_open() and test_ftruncate() with the
> > same open flags, and start with test_open() to make sure assumptions are
> > correct (cf. previous comment about test_ftruncate)? Like this (everywhere):
> >
> > EXPECT_EQ(0, test_open(file_rwt, O_RDONLY | O_TRUNC));
> > EXPECT_EQ(EINVAL, test_ftruncate(file_rwt, O_RDONLY));
> > EXPECT_EQ(0, test_open(file_rwt, O_WRONLY | O_TRUNC));
> > EXPECT_EQ(0, test_ftruncate(file_rwt, O_WRONLY));
> > EXPECT_EQ(0, test_truncate(file_rwt));
>
> OK, I ordered it like that.
>
> When calling
>
>   EXPECT_EQ(foo, test_ftruncate(...));
>
> and "foo" is not ENOSYS (which it should never be!), then that alone
> is enough to guarantee that the open() in test_ftruncate worked, so in
> a sense this is already tested implicitly.
>
> The only thing to make sure is to never *expect* ENOSYS from
> test_ftruncate(), but I documented in test_ftruncate() now that it is
> better to use test_open() for testing the result of open().
>
> >
> >
> > > +	EXPECT_EQ(0, test_open(file_rwt, O_RDONLY | O_TRUNC));
> > > +
> > > +	/* Checks read and write rights: no truncate variant works. */
> > > +	EXPECT_EQ(EACCES, test_ftruncate(_metadata, file_rw, O_WRONLY));
> > > +	EXPECT_EQ(EINVAL, test_ftruncate(_metadata, file_rw, O_RDONLY));
> > > +	EXPECT_EQ(EACCES, test_truncate(file_rw));
> > > +	EXPECT_EQ(EACCES, test_open(file_rw, O_WRONLY | O_TRUNC));
> > > +	EXPECT_EQ(EACCES, test_open(file_rw, O_RDONLY | O_TRUNC));
> > > +
> > > +	/*
> > > +	 * Checks read and truncate rights: truncation works.
> > > +	 *
> > > +	 * Note: Files opened in O_RDONLY can get truncated as part of
> > > +	 * the same operation.
> > > +	 */
> > > +	EXPECT_EQ(0, test_open(file_rt, O_RDONLY));
> > > +	EXPECT_EQ(0, test_open(file_rt, O_RDONLY | O_TRUNC));
> >
> > Why not a test_ftruncate() check here?
>
> The twist here is, althrough truncate() works, ftruncate() cannot
> truncate the file in this case:
>
> (a) when trying to open the file for writing, Landlock policy keeps
>     you from doing that (tested with test_open).
>
> (b) when opening the file read-only, that works, but read-only fds can
>     never be ftruncated (explained in the man page).
>
> It's slightly surprising when just glancing over the test, so I added
> the check for extra clarity:
>
> EXPECT_EQ(EINVAL, test_ftruncate(file_rt, O_RDONLY));
>
> The check for test_open with O_WRONLY was already there.
>
> > > +	EXPECT_EQ(EACCES, test_open(file_rt, O_WRONLY));
> > > +	EXPECT_EQ(EACCES, test_open(file_rt, O_WRONLY));
> >
> > There is a missing "| O_TRUNC"
>
> Well spotted! Fixed.
>
> > > +	EXPECT_EQ(0, test_truncate(file_rt));
> > > +
> > > +	/* Checks truncate right: truncate works, but can't open file. */
> > > +	EXPECT_EQ(EACCES, test_open(file_t, O_WRONLY));
> > > +	EXPECT_EQ(EACCES, test_open(file_t, O_RDONLY));
> > > +	EXPECT_EQ(EACCES, test_open(file_t, O_WRONLY | O_TRUNC));
> > > +	EXPECT_EQ(EACCES, test_open(file_t, O_RDONLY | O_TRUNC));
> > > +	EXPECT_EQ(0, test_truncate(file_t));
> > > +
> > > +	/* Checks "no rights" case: No form of truncation works. */
> > > +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY));
> > > +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY));
> > > +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
> > > +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
> > > +	EXPECT_EQ(EACCES, test_truncate(file_none));
> > > +
> > > +	/* Checks truncate right on directory: truncate works on contained files */
> > > +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_WRONLY));
> > > +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_RDONLY));
> > > +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_WRONLY | O_TRUNC));
> > > +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_RDONLY | O_TRUNC));
> > > +	EXPECT_EQ(0, test_truncate(file_in_dir_t));
> > > +
> > > +	/*
> > > +	 * Checks creat in dir_w: This requires the truncate right
> > > +	 * when overwriting an existing file, but does not require it
> > > +	 * when the file is new.
> > > +	 */
> > > +	EXPECT_EQ(EACCES, test_creat(_metadata, file_in_dir_w, 0600));
> > > +
> > > +	ASSERT_EQ(0, unlink(file_in_dir_w));
> > > +	EXPECT_EQ(0, test_creat(_metadata, file_in_dir_w, 0600));
> > > +}
> > > +
> > > +/*
> > > + * Exercises file truncation when it's not restricted,
> > > + * as it was the case before LANDLOCK_ACCESS_FS_TRUNCATE existed.
> > > + */
> > > +TEST_F_FORK(layout1, truncate_unhandled)
> >
> > Can you move layout1.truncate_unhandled tests before layout1.truncate?
>
> Done.
>
> >
> >
> > > +{
> > > +	const char *const file_r = file1_s1d1;
> > > +	const char *const file_w = file2_s1d1;
> > > +	const char *const file_none = file1_s1d2;
> > > +	const struct rule rules[] = {
> > > +		{
> > > +			.path = file_r,
> > > +			.access = LANDLOCK_ACCESS_FS_READ_FILE,
> > > +		},
> > > +		{
> > > +			.path = file_w,
> > > +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> > > +		},
> > > +		// Implicitly: No rights for file_none.
> > > +		{},
> > > +	};
> > > +	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
> > > +			      LANDLOCK_ACCESS_FS_WRITE_FILE;
> > > +	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
> > > +
> > > +	ASSERT_LE(0, ruleset_fd);
> > > +	enforce_ruleset(_metadata, ruleset_fd);
> > > +	ASSERT_EQ(0, close(ruleset_fd));
> > > +
> > > +	/* Checks read right: truncation should work through truncate and open. */
> > > +	EXPECT_EQ(0, test_truncate(file_r));
> >
> > We should be consistent to also check with test_ftruncate() (and order the
> > EXPECT checks appropriately).
>
> Added.
>
> >
> >
> > > +	EXPECT_EQ(0, test_open(file_r, O_RDONLY | O_TRUNC));
> > > +	EXPECT_EQ(EACCES, test_open(file_r, O_WRONLY | O_TRUNC));
> > > +
> > > +	/* Checks write right: truncation should work through truncate, ftruncate and open. */
> >
> > Please align to 80 columns.
>
> Done.
>
> >
> >
> > > +	EXPECT_EQ(0, test_truncate(file_w));
> > > +	EXPECT_EQ(0, test_ftruncate(_metadata, file_w, O_WRONLY));
> > > +	EXPECT_EQ(EACCES, test_open(file_w, O_RDONLY | O_TRUNC));
> > > +	EXPECT_EQ(0, test_open(file_w, O_WRONLY | O_TRUNC));
> > > +
> > > +	/* Checks "no rights" case: truncate works but all open attempts fail. */
> > > +	EXPECT_EQ(0, test_truncate(file_none));
> > > +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
> > > +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
> > > +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY));
> >
> > Can you test with test_creat() here?
>
> Added.
>
> Thanks for the careful review!
> —Günther
>
> --

--

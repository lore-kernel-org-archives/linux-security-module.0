Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45619C25B0E
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Aug 2022 17:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiHPRI3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Aug 2022 13:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbiHPRI1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Aug 2022 13:08:27 -0400
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B942F389
        for <linux-security-module@vger.kernel.org>; Tue, 16 Aug 2022 10:08:23 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M6czn62X1zMqDYN;
        Tue, 16 Aug 2022 19:08:21 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4M6czn0wsjzlnbwT;
        Tue, 16 Aug 2022 19:08:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1660669701;
        bh=1Yn49E52MiEOSwMRObZYq01kF3e3oREnhzos29cu5Fs=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=v0RW6YcmvUE3nFtMWDIHXoTp9zjUaJMbCeTmz/vBugkw3QrEo7fDrcwSNRkn6c5hj
         9iXicLsz0rS+d6dCsmVzowmZGCvFFHaJy5O2eS4UlFtXLsmkmphdi04iw9H5uX9o7h
         hz8YZVs+UeANofT3a18w0vmVp9x3QMS8CoQZ3PVA=
Message-ID: <6ed7d884-89cb-546f-db0a-1c16209f1c29@digikod.net>
Date:   Tue, 16 Aug 2022 19:08:20 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
References: <20220814192603.7387-1-gnoack3000@gmail.com>
 <20220814192603.7387-3-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v4 2/4] selftests/landlock: Selftests for file truncation
 support
In-Reply-To: <20220814192603.7387-3-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 14/08/2022 21:26, Günther Noack wrote:
> These tests exercise the following truncation operations:
> 
> * truncate() (truncate by path)
> * ftruncate() (truncate by file descriptor)
> * open with the O_TRUNC flag
> * special case: creat(), which is open with O_CREAT|O_WRONLY|O_TRUNC.
> 
> in the following scenarios:
> 
> * Files with read, write and truncate rights.
> * Files with read and truncate rights.
> * Files with the truncate right.
> * Files without the truncate right.
> 
> In particular, the following scenarios are enforced with the test:
> 
> * The truncate right is required to use ftruncate,
>    even when the thread already has the right to write to the file.
> * open() with O_TRUNC requires the truncate right, if it truncates a file.
>    open() already checks security_path_truncate() in this case,
>    and it required no additional check in the Landlock LSM's file_open hook.
> * creat() requires the truncate right
>    when called with an existing filename.
> * creat() does *not* require the truncate right
>    when it's creating a new file.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   tools/testing/selftests/landlock/fs_test.c | 219 +++++++++++++++++++++
>   1 file changed, 219 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index cb77eaa01c91..7a2ce6cd1a5a 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -58,6 +58,7 @@ static const char file1_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f1";
>   static const char file2_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f2";
>   
>   static const char dir_s3d1[] = TMP_DIR "/s3d1";
> +static const char file1_s3d1[] = TMP_DIR "/s3d1/f1";
>   /* dir_s3d2 is a mount point. */
>   static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
>   static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
> @@ -83,6 +84,7 @@ static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
>    * │           ├── f1
>    * │           └── f2
>    * └── s3d1
> + *     ├── f1
>    *     └── s3d2
>    *         └── s3d3
>    */
> @@ -208,6 +210,7 @@ static void create_layout1(struct __test_metadata *const _metadata)
>   	create_file(_metadata, file1_s2d3);
>   	create_file(_metadata, file2_s2d3);
>   
> +	create_file(_metadata, file1_s3d1);
>   	create_directory(_metadata, dir_s3d2);
>   	set_cap(_metadata, CAP_SYS_ADMIN);
>   	ASSERT_EQ(0, mount("tmp", dir_s3d2, "tmpfs", 0, "size=4m,mode=700"));
> @@ -230,6 +233,7 @@ static void remove_layout1(struct __test_metadata *const _metadata)
>   	EXPECT_EQ(0, remove_path(file1_s2d2));
>   	EXPECT_EQ(0, remove_path(file1_s2d1));
>   
> +	EXPECT_EQ(0, remove_path(file1_s3d1));
>   	EXPECT_EQ(0, remove_path(dir_s3d3));
>   	set_cap(_metadata, CAP_SYS_ADMIN);
>   	umount(dir_s3d2);
> @@ -3023,6 +3027,221 @@ TEST_F_FORK(layout1, proc_pipe)
>   	ASSERT_EQ(0, close(pipe_fds[1]));
>   }
>   
> +/*
> + * Opens the file and invokes ftruncate(2).
> + *
> + * Returns the errno of ftruncate if ftruncate() fails.
> + * Returns EBADFD if open() or close() fail (should not happen).
> + * Returns 0 if ftruncate(), open() and close() were successful.
> + */
> +static int test_ftruncate(struct __test_metadata *const _metadata,

_metadata is no longer needed. Same for test_creat().


> +			  const char *const path, int flags)
> +{
> +	int res, err, fd;
> +
> +	fd = open(path, flags | O_CLOEXEC);
> +	if (fd < 0)
> +		return EBADFD;

Instead of EBADFD, which is a valid open(2) error, you can use ENOSYS 
and add a comment explaining that we are not interested by this open(2) 
error code but only the ftruncate(2) one because we are sure opening 
such path is allowed or because open(2) is already tested before calls 
to test_ftruncate().


> +
> +	res = ftruncate(fd, 10);
> +	err = errno;
> +
> +	if (close(fd) != 0)
> +		return EBADFD;

Why not returning errno? See test_open_rel() comments.


> +
> +	if (res < 0)
> +		return err;
> +	return 0;
> +}
> +
> +/* Invokes truncate(2) and returns the errno or 0. */
> +static int test_truncate(const char *const path)
> +{
> +	if (truncate(path, 10) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +/*
> + * Invokes creat(2) and returns its errno or 0.
> + * Closes the opened file descriptor on success.
> + * Returns EBADFD if close() returns an error (should not happen).
> + */
> +static int test_creat(struct __test_metadata *const _metadata,
> +		      const char *const path, mode_t mode)
> +{
> +	int fd = creat(path, mode);
> +
> +	if (fd < 0)
> +		return errno;
> +
> +	if (close(fd) < 0)
> +		return EBADFD;

Why not returning errno?


> +	return 0;
> +}
> +
> +TEST_F_FORK(layout1, truncate)
> +{
> +	const char *const file_rwt = file1_s1d1;
> +	const char *const file_rw = file2_s1d1;
> +	const char *const file_rt = file1_s1d2;
> +	const char *const file_t = file2_s1d2;
> +	const char *const file_none = file1_s1d3;
> +	const char *const dir_t = dir_s2d1;
> +	const char *const file_in_dir_t = file1_s2d1;
> +	const char *const dir_w = dir_s3d1;
> +	const char *const file_in_dir_w = file1_s3d1;
> +	const struct rule rules[] = {
> +		{
> +			.path = file_rwt,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE |
> +				  LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		{
> +			.path = file_rw,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{
> +			.path = file_rt,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		{
> +			.path = file_t,
> +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		// Implicitly: No access rights for file_none.

Please use /* */ comments everywhere.


> +		{
> +			.path = dir_t,
> +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		{
> +			.path = dir_w,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{},
> +	};
> +	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +			      LANDLOCK_ACCESS_FS_WRITE_FILE |
> +			      LANDLOCK_ACCESS_FS_TRUNCATE;
> +	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/*
> +	 * Checks read, write and truncate rights: truncation works.
> +	 *
> +	 * Note: Independent of Landlock, ftruncate(2) on read-only
> +	 * file descriptors never works.
> +	 */
> +	EXPECT_EQ(0, test_ftruncate(_metadata, file_rwt, O_WRONLY));
> +	EXPECT_EQ(EINVAL, test_ftruncate(_metadata, file_rwt, O_RDONLY));
> +	EXPECT_EQ(0, test_truncate(file_rwt));
> +	EXPECT_EQ(0, test_open(file_rwt, O_WRONLY | O_TRUNC));

Could you please interleave the test_open() and test_ftruncate() with 
the same open flags, and start with test_open() to make sure assumptions 
are correct (cf. previous comment about test_ftruncate)? Like this 
(everywhere):

EXPECT_EQ(0, test_open(file_rwt, O_RDONLY | O_TRUNC));
EXPECT_EQ(EINVAL, test_ftruncate(file_rwt, O_RDONLY));
EXPECT_EQ(0, test_open(file_rwt, O_WRONLY | O_TRUNC));
EXPECT_EQ(0, test_ftruncate(file_rwt, O_WRONLY));
EXPECT_EQ(0, test_truncate(file_rwt));


> +	EXPECT_EQ(0, test_open(file_rwt, O_RDONLY | O_TRUNC));
> +
> +	/* Checks read and write rights: no truncate variant works. */
> +	EXPECT_EQ(EACCES, test_ftruncate(_metadata, file_rw, O_WRONLY));
> +	EXPECT_EQ(EINVAL, test_ftruncate(_metadata, file_rw, O_RDONLY));
> +	EXPECT_EQ(EACCES, test_truncate(file_rw));
> +	EXPECT_EQ(EACCES, test_open(file_rw, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_rw, O_RDONLY | O_TRUNC));
> +
> +	/*
> +	 * Checks read and truncate rights: truncation works.
> +	 *
> +	 * Note: Files opened in O_RDONLY can get truncated as part of
> +	 * the same operation.
> +	 */
> +	EXPECT_EQ(0, test_open(file_rt, O_RDONLY));
> +	EXPECT_EQ(0, test_open(file_rt, O_RDONLY | O_TRUNC));

Why not a test_ftruncate() check here?


> +	EXPECT_EQ(EACCES, test_open(file_rt, O_WRONLY));
> +	EXPECT_EQ(EACCES, test_open(file_rt, O_WRONLY));

There is a missing "| O_TRUNC"


> +	EXPECT_EQ(0, test_truncate(file_rt));
> +
> +	/* Checks truncate right: truncate works, but can't open file. */
> +	EXPECT_EQ(EACCES, test_open(file_t, O_WRONLY));
> +	EXPECT_EQ(EACCES, test_open(file_t, O_RDONLY));
> +	EXPECT_EQ(EACCES, test_open(file_t, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_t, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(0, test_truncate(file_t));
> +
> +	/* Checks "no rights" case: No form of truncation works. */
> +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_truncate(file_none));
> +
> +	/* Checks truncate right on directory: truncate works on contained files */
> +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_WRONLY));
> +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_RDONLY));
> +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(0, test_truncate(file_in_dir_t));
> +
> +	/*
> +	 * Checks creat in dir_w: This requires the truncate right
> +	 * when overwriting an existing file, but does not require it
> +	 * when the file is new.
> +	 */
> +	EXPECT_EQ(EACCES, test_creat(_metadata, file_in_dir_w, 0600));
> +
> +	ASSERT_EQ(0, unlink(file_in_dir_w));
> +	EXPECT_EQ(0, test_creat(_metadata, file_in_dir_w, 0600));
> +}
> +
> +/*
> + * Exercises file truncation when it's not restricted,
> + * as it was the case before LANDLOCK_ACCESS_FS_TRUNCATE existed.
> + */
> +TEST_F_FORK(layout1, truncate_unhandled)

Can you move layout1.truncate_unhandled tests before layout1.truncate?


> +{
> +	const char *const file_r = file1_s1d1;
> +	const char *const file_w = file2_s1d1;
> +	const char *const file_none = file1_s1d2;
> +	const struct rule rules[] = {
> +		{
> +			.path = file_r,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE,
> +		},
> +		{
> +			.path = file_w,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		// Implicitly: No rights for file_none.
> +		{},
> +	};
> +	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +			      LANDLOCK_ACCESS_FS_WRITE_FILE;
> +	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Checks read right: truncation should work through truncate and open. */
> +	EXPECT_EQ(0, test_truncate(file_r));

We should be consistent to also check with test_ftruncate() (and order 
the EXPECT checks appropriately).


> +	EXPECT_EQ(0, test_open(file_r, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_r, O_WRONLY | O_TRUNC));
> +
> +	/* Checks write right: truncation should work through truncate, ftruncate and open. */

Please align to 80 columns.


> +	EXPECT_EQ(0, test_truncate(file_w));
> +	EXPECT_EQ(0, test_ftruncate(_metadata, file_w, O_WRONLY));
> +	EXPECT_EQ(EACCES, test_open(file_w, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(0, test_open(file_w, O_WRONLY | O_TRUNC));
> +
> +	/* Checks "no rights" case: truncate works but all open attempts fail. */
> +	EXPECT_EQ(0, test_truncate(file_none));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY));

Can you test with test_creat() here?


> +}
> +
>   /* clang-format off */
>   FIXTURE(layout1_bind) {};
>   /* clang-format on */

Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29526C19F29
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Jul 2022 09:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiG2JkQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Jul 2022 05:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiG2JkB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Jul 2022 05:40:01 -0400
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29EE8688A
        for <linux-security-module@vger.kernel.org>; Fri, 29 Jul 2022 02:39:44 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LvMtQ322YzMq7s4;
        Fri, 29 Jul 2022 11:39:42 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4LvMtP3cjJzlrKcY;
        Fri, 29 Jul 2022 11:39:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1659087582;
        bh=lQW1tdn9+P/b45WGvLJoiZ1C3gp+TFBK5/BOBECTNUM=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=kKDDppRNW5wSrCPnS+m/v17b3lbqsp2UopW/pxIX/fccZvozN7sb/rYX7LKTMn1wH
         mg3uw/DB205ndIoEzA0VvPDH0zrt3PpMDEVipypDU2Psdd4lOlTXP8HjDSDLSh5eLG
         ervP2u/mSf/4qezRCSpwjwI5W41p1GZr2G/hDsfw=
Message-ID: <ce29d7e4-dc0a-db53-e130-b73f270bc16f@digikod.net>
Date:   Fri, 29 Jul 2022 11:39:40 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
References: <20220712211405.14705-1-gnoack3000@gmail.com>
 <20220712211405.14705-3-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v2 2/4] selftests/landlock: Selftests for file truncation
 support
In-Reply-To: <20220712211405.14705-3-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 12/07/2022 23:14, Günther Noack wrote:
> These tests exercise the following truncation operations:
> 
> * truncate() and trunate64() (truncate by path)
> * ftruncate() and ftruncate64() (truncate by file descriptor)
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
> Link: https://lore.kernel.org/all/20220707200612.132705-3-gnoack3000@gmail.com/
> ---
>   tools/testing/selftests/landlock/fs_test.c | 238 +++++++++++++++++++++
>   1 file changed, 238 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index cb77eaa01c91..1e5660118bce 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -3023,6 +3023,244 @@ TEST_F_FORK(layout1, proc_pipe)
>   	ASSERT_EQ(0, close(pipe_fds[1]));
>   }
>   
> +TEST_F_FORK(layout1, truncate)
> +{
> +	const char *file_rwt = file1_s1d1;

You can make file_rwt (and others) const too:
const char *const file_rwt = file1_s1d1;


> +	const char *file_rw = file2_s1d1;
> +	const char *file_rt = file1_s1d2;
> +	const char *file_t = file2_s1d2;
> +	const char *file_none = file1_s1d3;
> +	const char *dir_t = dir_s2d1;
> +	const char *file_in_dir_t = file1_s2d1;
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
> +		{
> +			.path = dir_t,
> +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		{},
> +	};
> +	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +			      LANDLOCK_ACCESS_FS_WRITE_FILE |
> +			      LANDLOCK_ACCESS_FS_TRUNCATE;
> +	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
> +	struct stat statbuf;
> +	int reg_fd;
> +
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Checks read, write and truncate rights: truncate and ftruncate work. */
> +	reg_fd = open(file_rwt, O_WRONLY | O_CLOEXEC);
> +	ASSERT_LE(0, reg_fd);
> +	EXPECT_EQ(0, ftruncate(reg_fd, 10));
> +	EXPECT_EQ(0, ftruncate64(reg_fd, 20));
> +	ASSERT_EQ(0, close(reg_fd));

Could you add the same ftruncate* checks with a O_RDONLY FD?


> +
> +	EXPECT_EQ(0, truncate(file_rwt, 10));
> +	EXPECT_EQ(0, truncate64(file_rwt, 20));
> +
> +	reg_fd = open(file_rwt, O_WRONLY | O_TRUNC | O_CLOEXEC);
> +	ASSERT_LE(0, reg_fd);
> +	ASSERT_EQ(0, close(reg_fd));
> +
> +	reg_fd = open(file_rwt, O_RDONLY | O_TRUNC | O_CLOEXEC);
> +	ASSERT_LE(0, reg_fd);
> +	ASSERT_EQ(0, close(reg_fd));

I'm not sure if it would be worth it, but can you try to move these 
checks in a standalone helper (like test_execute) that could be use for 
all/most scenarios?


> +
> +	/* Checks read and write rights: no truncate variant works. */
> +	reg_fd = open(file_rw, O_WRONLY | O_CLOEXEC);
> +	ASSERT_LE(0, reg_fd);
> +	EXPECT_EQ(-1, ftruncate(reg_fd, 10));
> +	EXPECT_EQ(EACCES, errno);
> +	EXPECT_EQ(-1, ftruncate64(reg_fd, 20));
> +	EXPECT_EQ(EACCES, errno);
> +	ASSERT_EQ(0, close(reg_fd));
> +
> +	EXPECT_EQ(-1, truncate(file_rw, 10));
> +	EXPECT_EQ(EACCES, errno);
> +	EXPECT_EQ(-1, truncate64(file_rw, 20));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	EXPECT_EQ(-1, open(file_rw, O_WRONLY | O_TRUNC | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	EXPECT_EQ(-1, open(file_rw, O_RDONLY | O_TRUNC | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	/* Checks read and truncate right: truncate works, also with open(2). */

"right*s*" ? Just keep it consistent with other comments.


> +	EXPECT_EQ(-1, open(file_rt, O_WRONLY | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	EXPECT_EQ(0, truncate(file_rt, 10));
> +	EXPECT_EQ(0, truncate64(file_rt, 20));
> +
> +	reg_fd = open(file_rt, O_RDONLY | O_TRUNC | O_CLOEXEC);
> +	ASSERT_LE(0, reg_fd);
> +	ASSERT_EQ(0, fstat(reg_fd, &statbuf));
> +	EXPECT_EQ(0, statbuf.st_size);
> +	ASSERT_EQ(0, close(reg_fd));

Why checking fstat? And why only here?


> +
> +	/* Checks truncate right: truncate works, but can't open file. */
> +	EXPECT_EQ(-1, open(file_t, O_WRONLY | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	EXPECT_EQ(0, truncate(file_t, 10));
> +	EXPECT_EQ(0, truncate64(file_t, 20));
> +
> +	EXPECT_EQ(-1, open(file_t, O_RDONLY | O_TRUNC | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	/* Checks "no rights" case: No form of truncation works. */

Nit: Do we need an "s" if there is none?


> +	EXPECT_EQ(-1, open(file_none, O_WRONLY | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	EXPECT_EQ(-1, truncate(file_none, 10));
> +	EXPECT_EQ(EACCES, errno);
> +	EXPECT_EQ(-1, truncate64(file_none, 20));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	EXPECT_EQ(-1, open(file_none, O_RDONLY | O_TRUNC | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	/* Checks truncate right on directory:  */
> +	EXPECT_EQ(-1, open(file_in_dir_t, O_WRONLY | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	EXPECT_EQ(0, truncate(file_in_dir_t, 10));
> +	EXPECT_EQ(0, truncate64(file_in_dir_t, 20));
> +
> +	EXPECT_EQ(-1, open(file_in_dir_t, O_RDONLY | O_TRUNC | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +}
> +
> +/*
> + * Exercises file truncation when it's not restricted,
> + * as it was the case before LANDLOCK_ACCESS_FS_TRUNCATE existed.
> + */
> +TEST_F_FORK(layout1, truncate_unhandled)

Could you merge these truncate_unhandled tests with TEST_F_FORK(layout1, 
truncate)? You can use it as a first layer of rules. This will make sure 
that nested stacking with different handled access rights works as expected.


> +{
> +	const char *file_r = file1_s1d1;
> +	const char *file_w = file2_s1d1;
> +	const char *file_none = file1_s1d2;
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
> +	int reg_fd;
> +
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Checks read right: truncation should work through truncate and open. */
> +	EXPECT_EQ(0, truncate(file_r, 10));
> +	EXPECT_EQ(0, truncate64(file_r, 20));
> +
> +	reg_fd = open(file_r, O_RDONLY | O_TRUNC | O_CLOEXEC);
> +	ASSERT_LE(0, reg_fd);
> +	ASSERT_EQ(0, close(reg_fd));
> +
> +	EXPECT_EQ(-1, open(file_r, O_WRONLY | O_TRUNC | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	/* Checks write right: truncation should work through truncate, ftruncate and open. */
> +	EXPECT_EQ(0, truncate(file_w, 10));
> +	EXPECT_EQ(0, truncate64(file_w, 20));
> +
> +	EXPECT_EQ(-1, open(file_w, O_RDONLY | O_TRUNC | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	reg_fd = open(file_w, O_WRONLY | O_TRUNC | O_CLOEXEC);
> +	ASSERT_LE(0, reg_fd);
> +	ASSERT_EQ(0, close(reg_fd));
> +
> +	reg_fd = open(file_w, O_WRONLY);
> +	ASSERT_LE(0, reg_fd);
> +	EXPECT_EQ(0, ftruncate(reg_fd, 10));
> +	EXPECT_EQ(0, ftruncate64(reg_fd, 20));
> +	ASSERT_EQ(0, close(reg_fd));
> +
> +	/* Checks "no rights" case: truncate works but all open attempts fail. */
> +	EXPECT_EQ(0, truncate(file_none, 10));
> +	EXPECT_EQ(0, truncate64(file_none, 20));
> +
> +	EXPECT_EQ(-1, open(file_none, O_RDONLY | O_TRUNC | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	EXPECT_EQ(-1, open(file_none, O_WRONLY | O_TRUNC | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +
> +	EXPECT_EQ(-1, open(file_none, O_WRONLY | O_CLOEXEC));
> +	EXPECT_EQ(EACCES, errno);
> +}
> +
> +/* Exercises creat(), which is equivalent to an open with O_CREAT|O_WRONLY|O_TRUNC. */
> +TEST_F_FORK(layout1, truncate_creat)

You can merge these truncate_creat tests too in TEST_F_FORK(layout1, 
truncate) (without dedicated layer though).


> +{
> +	const struct rule rules[] = {
> +		{
> +			.path = dir_s1d1,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{}
> +	};
> +	const __u64 handled = LANDLOCK_ACCESS_FS_WRITE_FILE |
> +			      LANDLOCK_ACCESS_FS_TRUNCATE;
> +	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
> +	int reg_fd;
> +
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Checks creating a new file: This should work even without the truncate right. */
> +	ASSERT_EQ(0, unlink(file1_s1d1));
> +
> +	reg_fd = creat(file1_s1d1, 0600);
> +	ASSERT_LE(0, reg_fd);
> +	ASSERT_EQ(0, close(reg_fd));
> +
> +	/*
> +	 * Checks creating a file over an existing one:
> +	 * This should fail. It would truncate the file, and we don't have that right.
> +	 */
> +	EXPECT_EQ(-1, creat(file2_s1d1, 0600));
> +	EXPECT_EQ(EACCES, errno);
> +}
> +
>   /* clang-format off */
>   FIXTURE(layout1_bind) {};
>   /* clang-format on */

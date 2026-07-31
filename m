Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6532E6BC
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533397; cv=none; b=qpugYAa3HpYGS3ISTOfo5IoMdAAvvpodhogozyvdmKkunqByIi7KDZIGjly/Hc96Nf5ICsK2DcM7CBjA/XXLoNria27aT3aJtOpt8INrLTSbcobWuB6xLlnGpneY/F+NO6t89rlqi1+mR/xQns+R2eSbEr4sv9ujNWc3MeAlf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533397; c=relaxed/simple;
	bh=VCVCabQwRWiuQI/Q2JyLhZwjraM5uFo0maym4YXu/VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpvCsDK/V64mBiGKhqjwbQQKDyLYRfHr1nBx8t7UQ0aFBY8g5nSiMnFkUhAUTL0Ibk25VwW0c6aHZP9W4m3DH0+8aP+m2ZGnj2bjP/dQRqEZLeiPPU3oIcE0orNHBvGabun9StYx9zcqn5fxJGY4SM/J4ERWUL1noqLUFm5IvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RDdIWcLy; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RDdIWcLy"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBfNV2c9Nzdvl;
	Fri, 31 Jul 2026 23:29:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785533386;
	bh=8BAhBUyfOKqc6OgSFLSs5ny4L83swhnbcXvuMD633z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDdIWcLyj9BBJQ8F0Ytu/JQd6ChDTUX6Z/kLA5kLACSMRnOp2pdCeCgf0Ec7ApxHD
	 nlxDQan7d4xQv1cBA6IP7qo9S3QnvJuBowGZxMKJuwyz/5N6dR6wZDivozUoQ+gmbF
	 perBDj81omuA9BjTf8hoKkgtNbWPGp9kV7lt1SzI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBfNT5nlnzTYv;
	Fri, 31 Jul 2026 23:29:45 +0200 (CEST)
Date: Fri, 31 Jul 2026 23:29:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: gnoack3000@gmail.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 2/3] selftests/landlock: Test
 LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Message-ID: <20260731.ChohN2vub4ah@digikod.net>
References: <20260717220320.1030123-1-utilityemal77@gmail.com>
 <20260717220320.1030123-3-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717220320.1030123-3-utilityemal77@gmail.com>
X-Infomaniak-Routing: alpha

These tests are good.

Please run clang-format on these files.

Also, we can use the same max_layres pattern to check the errno and the
state of NNP for the calling thread (when the call failed).

On Fri, Jul 17, 2026 at 06:03:18PM -0400, Justin Suess wrote:
> Check that a successful landlock_restrict_self(2) call with
> LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS sets no_new_privs without a prior
> prctl(2) call nor CAP_SYS_ADMIN, that a failed call leaves the attribute
> unchanged, and that LANDLOCK_RESTRICT_SELF_TSYNC extends it to sibling
> threads.  Also check that this flag requires a ruleset, and update the
> restrict_self_checks_ordering EPERM checks since this flag is now
> checked before the flags validity.
> 
> Update the ABI version and last-flag checks accordingly.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  tools/testing/selftests/landlock/base_test.c  | 65 +++++++++++++++++--
>  tools/testing/selftests/landlock/tsync_test.c | 33 ++++++++++
>  2 files changed, 93 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index cbd3c1669951..2d4903588903 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -76,7 +76,7 @@ TEST(abi_version)
>  	const struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(11, landlock_create_ruleset(NULL, 0,
>  					      LANDLOCK_CREATE_RULESET_VERSION));
>  
>  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> @@ -255,8 +255,15 @@ TEST(restrict_self_checks_ordering)
>  
>  	/* Checks unprivileged enforcement without no_new_privs. */
>  	drop_caps(_metadata);
> -	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
> +	ASSERT_EQ(-1, landlock_restrict_self(
> +			      -1, ~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
>  	ASSERT_EQ(EPERM, errno);
> +	/*
> +	 * LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS fulfills the no_new_privs /
> +	 * CAP_SYS_ADMIN requirement, so the invalid flags are checked first.
> +	 */
> +	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
> +	ASSERT_EQ(EINVAL, errno);
>  	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
>  	ASSERT_EQ(EPERM, errno);
>  	ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
> @@ -288,7 +295,7 @@ TEST(restrict_self_fd)
>  	EXPECT_EQ(EBADFD, errno);
>  }
>  
> -TEST(restrict_self_fd_logging_flags)
> +TEST(restrict_self_fd_flags)
>  {
>  	int fd;
>  
> @@ -302,11 +309,16 @@ TEST(restrict_self_fd_logging_flags)
>  	EXPECT_EQ(-1, landlock_restrict_self(
>  			      fd, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
>  	EXPECT_EQ(EBADFD, errno);
> +
> +	/* LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS requires a ruleset FD. */
> +	EXPECT_EQ(-1, landlock_restrict_self(
> +			      fd, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
> +	EXPECT_EQ(EBADFD, errno);
>  }
>  
> -TEST(restrict_self_logging_flags)
> +TEST(restrict_self_flags)

The test renames must be mentioned in the commit message.

>  {
> -	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_TSYNC;
> +	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
>  
>  	/* Tests invalid flag combinations. */
>  
> @@ -349,6 +361,18 @@ TEST(restrict_self_logging_flags)
>  				      LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON));
>  	EXPECT_EQ(EBADF, errno);
>  
> +	/* LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS requires a ruleset FD. */
> +
> +	EXPECT_EQ(-1, landlock_restrict_self(
> +			      -1, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
> +	EXPECT_EQ(EBADF, errno);
> +
> +	EXPECT_EQ(-1,
> +		  landlock_restrict_self(
> +			  -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
> +				      LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
> +	EXPECT_EQ(EBADF, errno);
> +
>  	/* Tests with an invalid ruleset_fd. */
>  
>  	EXPECT_EQ(-1, landlock_restrict_self(
> @@ -359,6 +383,37 @@ TEST(restrict_self_logging_flags)
>  			     -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
>  }
>  
> +TEST(restrict_self_no_new_privs)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
> +	};
> +	const int ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	/*
> +	 * The calling thread does not need CAP_SYS_ADMIN nor an explicit
> +	 * prctl(2) PR_SET_NO_NEW_PRIVS call.
> +	 */
> +	drop_caps(_metadata);
> +	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
> +
> +	/* Checks that a failed call does not set no_new_privs. */
> +	EXPECT_EQ(-1, landlock_restrict_self(
> +			      -1, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
> +	EXPECT_EQ(EBADF, errno);
> +	EXPECT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
> +
> +	/* Checks that a successful call sets no_new_privs. */
> +	ASSERT_EQ(0, landlock_restrict_self(
> +			     ruleset_fd, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
> +	EXPECT_EQ(1, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
> +
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
>  TEST(ruleset_fd_io)
>  {
>  	struct landlock_ruleset_attr ruleset_attr = {
> diff --git a/tools/testing/selftests/landlock/tsync_test.c b/tools/testing/selftests/landlock/tsync_test.c
> index 9cf1491bbaaf..d5336186b2c7 100644
> --- a/tools/testing/selftests/landlock/tsync_test.c
> +++ b/tools/testing/selftests/landlock/tsync_test.c
> @@ -90,6 +90,39 @@ TEST(multi_threaded_success)
>  	EXPECT_EQ(0, close(ruleset_fd));
>  }
>  
> +TEST(multi_threaded_no_new_privs)
> +{
> +	pthread_t t1, t2;
> +	bool no_new_privs1, no_new_privs2;
> +	const int ruleset_fd = create_ruleset(_metadata);
> +
> +	disable_caps(_metadata);
> +
> +	ASSERT_EQ(0, pthread_create(&t1, NULL, idle, &no_new_privs1));
> +	ASSERT_EQ(0, pthread_create(&t2, NULL, idle, &no_new_privs2));
> +
> +	/* No prior prctl(2) PR_SET_NO_NEW_PRIVS call. */
> +	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
> +
> +	EXPECT_EQ(0, landlock_restrict_self(
> +			     ruleset_fd,
> +			     LANDLOCK_RESTRICT_SELF_TSYNC |
> +				     LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
> +
> +	EXPECT_EQ(1, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
> +
> +	ASSERT_EQ(0, pthread_cancel(t1));
> +	ASSERT_EQ(0, pthread_cancel(t2));
> +	ASSERT_EQ(0, pthread_join(t1, NULL));
> +	ASSERT_EQ(0, pthread_join(t2, NULL));
> +
> +	/* The no_new_privs flag was enabled on all threads. */
> +	EXPECT_TRUE(no_new_privs1);
> +	EXPECT_TRUE(no_new_privs2);
> +
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
>  TEST(multi_threaded_success_despite_diverging_domains)
>  {
>  	pthread_t t1, t2;
> -- 
> 2.54.0
> 

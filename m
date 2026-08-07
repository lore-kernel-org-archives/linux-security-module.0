Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4B346FB3
	for <linux-security-module@vger.kernel.org>; Fri,  7 Aug 2026 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099710; cv=none; b=QN/IBs7z9ChxPyKNhG8Ft3mUx2ZYvluDq254dmyQuQAW5FoZ9Cz5sB0LayTJoO2unkK2rqEDyh6htelVSKagMMBBIZvbDKnFd4erHw+KHlAqGVhFPZY3r1w4P8WCydKAt4mpePbCc9sFJsKKMXCmjX06dbBMlGJusZ6YCegIpjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099710; c=relaxed/simple;
	bh=l3H1Q4FJoSPfS9X8EqkeQshXCiu1f1SRaplVODlqAwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMmMEkGjGlwCLG8MYpqzJo4KEM8qdyULMNn4oJjej918TG//KppZbEvhlhY+/1OuyWrUmH5A5pvTGFnz/cva8oKpXgtWzJZ3cMWwp2Ce8zs4cEvnd+vfQdcv92RERrAlYH4JRULfFR88A3XxaszPPMfhroMjOTAiN0l+flQ1Iy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=MgOc+biH; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="MgOc+biH"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hGgq62VDgzjfm;
	Fri,  7 Aug 2026 12:48:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786099698;
	bh=e5CldnONL4XAKy5zptLeP4a9ujhnvb6820JYbpYmSfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgOc+biHKpwPm7oblOkoQTP40JYoxjqQ6NbmKNL9J7iupFzS465Q90oL+AKfAKHYG
	 IZhYg5cXuC3jeBgtm+rYxrlG0Muwa71cs/uJqykE+8pI/Xqi8ez76XZnIRnELvP6w8
	 4Nfz/9OIWz8nYOYAi1Z1qIlreZPxGQGFV8cxnmCg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hGgq54wqVzZ5C;
	Fri,  7 Aug 2026 12:48:17 +0200 (CEST)
Date: Fri, 7 Aug 2026 12:48:11 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: gnoack3000@gmail.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/4] selftests/landlock: Test
 LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Message-ID: <20260807.eeCah8noh7Ad@digikod.net>
References: <20260803223109.707353-1-utilityemal77@gmail.com>
 <20260803223109.707353-3-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803223109.707353-3-utilityemal77@gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Aug 03, 2026 at 06:31:06PM -0400, Justin Suess wrote:
> Check that a successful landlock_restrict_self(2) call with
> LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS sets no_new_privs without a prior
> prctl(2) call nor CAP_SYS_ADMIN, that a failed call from both an
> invalid ruleset and hitting the layer maximum leaves the attribute
> unchanged, and that LANDLOCK_RESTRICT_SELF_TSYNC extends it to sibling
> threads.  Also check that this flag requires a ruleset, and update the
> restrict_self_checks_ordering EPERM checks since this flag is now
> checked before the flags validity.
> 
> Finally, rename restrict_self_fd_logging_flags to
> restrict_self_fd_flags, and restrict_self_logging_flags to
> restrict_self_flags to indicate that non-logging flags are now tested.
> 
> Update the ABI version and last-flag checks accordingly.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
> 
> Notes:
>     v2->v3:
>     - Run clang-format
>     - Add max-layers tests (base_test and tsync_test) checking E2BIG and
>       that a failed call leaves no_new_privs unchanged
>     - Mention the test renames in the commit message
>     - Match comment style of surrounding tests
> 
>  tools/testing/selftests/landlock/base_test.c  | 99 ++++++++++++++++++-
>  tools/testing/selftests/landlock/tsync_test.c | 72 ++++++++++++++
>  2 files changed, 166 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index cbd3c1669951..c8ed165a32ed 100644
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
> @@ -277,6 +284,41 @@ TEST(restrict_self_checks_ordering)
>  	ASSERT_EQ(0, close(ruleset_fd));
>  }
>  
> +TEST(restrict_self_max_layers)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
> +	};
> +	struct landlock_path_beneath_attr path_beneath_attr = {
> +		.allowed_access = LANDLOCK_ACCESS_FS_EXECUTE,
> +		.parent_fd = -1,
> +	};
> +	const int ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	path_beneath_attr.parent_fd =
> +		open("/tmp", O_PATH | O_NOFOLLOW | O_DIRECTORY | O_CLOEXEC);
> +	ASSERT_LE(0, path_beneath_attr.parent_fd);
> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> +				       &path_beneath_attr, 0));
> +	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
> +
> +	/* Enforces the maximum number of allowed layers. */
> +	for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++)
> +		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> +
> +	/* Enforces one too many rulesets. */
> +	drop_caps(_metadata);
> +	ASSERT_EQ(-1, landlock_restrict_self(
> +			      ruleset_fd, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
> +	ASSERT_EQ(E2BIG, errno);
> +
> +	/* Checks that the failed call did not set no_new_privs. */
> +	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
>  TEST(restrict_self_fd)
>  {
>  	int fd;
> @@ -288,7 +330,7 @@ TEST(restrict_self_fd)
>  	EXPECT_EQ(EBADFD, errno);
>  }
>  
> -TEST(restrict_self_fd_logging_flags)
> +TEST(restrict_self_fd_flags)
>  {
>  	int fd;
>  
> @@ -302,11 +344,16 @@ TEST(restrict_self_fd_logging_flags)
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
>  {
> -	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_TSYNC;
> +	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
>  
>  	/* Tests invalid flag combinations. */
>  
> @@ -349,6 +396,17 @@ TEST(restrict_self_logging_flags)
>  				      LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON));
>  	EXPECT_EQ(EBADF, errno);
>  
> +	/* LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS requires a ruleset FD. */
> +
> +	EXPECT_EQ(-1, landlock_restrict_self(
> +			      -1, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
> +	EXPECT_EQ(EBADF, errno);
> +
> +	EXPECT_EQ(-1, landlock_restrict_self(
> +			      -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
> +					  LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
> +	EXPECT_EQ(EBADF, errno);
> +
>  	/* Tests with an invalid ruleset_fd. */
>  
>  	EXPECT_EQ(-1, landlock_restrict_self(
> @@ -359,6 +417,37 @@ TEST(restrict_self_logging_flags)
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
> index 9cf1491bbaaf..afa4a8222248 100644
> --- a/tools/testing/selftests/landlock/tsync_test.c
> +++ b/tools/testing/selftests/landlock/tsync_test.c
> @@ -90,6 +90,78 @@ TEST(multi_threaded_success)
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
> +TEST(multi_threaded_no_new_privs_max_layers)
> +{
> +	pthread_t t1, t2;
> +	bool no_new_privs1, no_new_privs2;
> +	const int ruleset_fd = create_ruleset(_metadata);
> +
> +	/* Enforces the maximum number of allowed layers. */
> +	for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++)
> +		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> +
> +	ASSERT_EQ(0, pthread_create(&t1, NULL, idle, &no_new_privs1));
> +	ASSERT_EQ(0, pthread_create(&t2, NULL, idle, &no_new_privs2));
> +
> +	disable_caps(_metadata);
> +
> +	/* No prior prctl(2) PR_SET_NO_NEW_PRIVS call. */
> +	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
> +
> +	ASSERT_EQ(-1,
> +		  landlock_restrict_self(ruleset_fd,
> +					 LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS |
> +						 LANDLOCK_RESTRICT_SELF_TSYNC));
> +	ASSERT_EQ(E2BIG, errno);
> +
> +	/* Checks that the failed call did not set no_new_privs. */
> +	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
> +
> +	ASSERT_EQ(0, pthread_cancel(t1));
> +	ASSERT_EQ(0, pthread_cancel(t2));
> +	ASSERT_EQ(0, pthread_join(t1, NULL));
> +	ASSERT_EQ(0, pthread_join(t2, NULL));
> +
> +	/* The no_new_privs flag was not enabled on any thread. */
> +	EXPECT_FALSE(no_new_privs1);
> +	EXPECT_FALSE(no_new_privs2);
> +
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}

multi_threaded_{success,no_new_privs{,_max_layers} should be test
variants to factor out the code.

> +
>  TEST(multi_threaded_success_despite_diverging_domains)
>  {
>  	pthread_t t1, t2;
> -- 
> 2.54.0
> 

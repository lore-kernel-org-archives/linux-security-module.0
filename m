Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853C4C53210
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Jan 2023 15:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbjACP5Q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Jan 2023 10:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjACP44 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Jan 2023 10:56:56 -0500
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B4511C23
        for <linux-security-module@vger.kernel.org>; Tue,  3 Jan 2023 07:56:53 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Nmcmg40T9zMrC3X;
        Tue,  3 Jan 2023 16:56:51 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Nmcmf6MBSz56Z;
        Tue,  3 Jan 2023 16:56:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1672761411;
        bh=8pQo0r2XgVE5DKYTPDyAEmheaXvQTv6ccmvR17qId8A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iAbUO/9x8JhvZIa31SOcwb6fgXAwqsjpx7jOrgele2BwQqPTIWkPLgXUt77LG5tem
         YI/MHWjBwMcHksmNVUq4jo63qEsDCqj9o42yl8Mn/OFrBxr4ISzunlub7CrmaSB6D8
         Uydg5pDa8W2C371grtmxV4UC1DnbV+/dFHVXIwYA=
Message-ID: <c7fa3003-89af-d311-baa4-071aa76962b3@digikod.net>
Date:   Tue, 3 Jan 2023 16:56:31 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v3 1/1] selftests/landlock: skip ptrace_test according to
 YAMA
Content-Language: en-US
To:     jeffxu@chromium.org
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
References: <20221227140244.1041292-1-jeffxu@google.com>
 <20221227140244.1041292-2-jeffxu@google.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221227140244.1041292-2-jeffxu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Please run clang-format-14 -i ptrace_test.c

On 27/12/2022 15:02, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> Add check for yama setting for ptrace_test.
> 
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>   .../testing/selftests/landlock/ptrace_test.c  | 173 ++++++++++++------
>   1 file changed, 112 insertions(+), 61 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index c28ef98ff3ac..0056815deef8 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -60,6 +60,23 @@ static int test_ptrace_read(const pid_t pid)
>   	return 0;
>   }
>   
> +static int get_yama_ptrace_scope(void)
> +{
> +	int ret = -1;
> +	char buf[2] = {};
> +	int fd = open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
> +
> +	if (fd < 0)
> +		return 0;
> +
> +	if (read(fd, &buf, 1) < 0)
> +		return -1;
> +
> +	ret = atoi(buf);
> +	close(fd);
> +	return ret;
> +}
> +
>   /* clang-format off */
>   FIXTURE(hierarchy) {};
>   /* clang-format on */
> @@ -69,6 +86,7 @@ FIXTURE_VARIANT(hierarchy)
>   	const bool domain_both;
>   	const bool domain_parent;
>   	const bool domain_child;
> +	const int  yama_ptrace_scope_max_supported;

This is not used anymore.

>   };
>   
>   /*
> @@ -93,6 +111,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_without_domain) {
>   	.domain_both = false,
>   	.domain_parent = false,
>   	.domain_child = false,
> +	.yama_ptrace_scope_max_supported = 0,
>   };
>   
>   /*
> @@ -110,6 +129,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_one_domain) {
>   	.domain_both = false,
>   	.domain_parent = false,
>   	.domain_child = true,
> +	.yama_ptrace_scope_max_supported = 1,
>   };
>   
>   /*
> @@ -126,6 +146,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_parent_domain) {
>   	.domain_both = false,
>   	.domain_parent = true,
>   	.domain_child = false,
> +	.yama_ptrace_scope_max_supported = 0,
>   };
>   
>   /*
> @@ -143,6 +164,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_sibling_domain) {
>   	.domain_both = false,
>   	.domain_parent = true,
>   	.domain_child = true,
> +	.yama_ptrace_scope_max_supported = 2,
>   };
>   
>   /*
> @@ -160,6 +182,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_sibling_domain) {
>   	.domain_both = true,
>   	.domain_parent = false,
>   	.domain_child = false,
> +	.yama_ptrace_scope_max_supported = 0,
>   };
>   
>   /*
> @@ -178,6 +201,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_nested_domain) {
>   	.domain_both = true,
>   	.domain_parent = false,
>   	.domain_child = true,
> +	.yama_ptrace_scope_max_supported = 1,
>   };
>   
>   /*
> @@ -196,6 +220,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_nested_and_parent_domain) {
>   	.domain_both = true,
>   	.domain_parent = true,
>   	.domain_child = false,
> +	.yama_ptrace_scope_max_supported = 0,
>   };
>   
>   /*
> @@ -216,6 +241,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_domain) {
>   	.domain_both = true,
>   	.domain_parent = true,
>   	.domain_child = true,
> +	.yama_ptrace_scope_max_supported = 2,
>   };
>   
>   FIXTURE_SETUP(hierarchy)
> @@ -232,8 +258,20 @@ TEST_F(hierarchy, trace)
>   	pid_t child, parent;
>   	int status, err_proc_read;
>   	int pipe_child[2], pipe_parent[2];
> +	int yama_ptrace_scope;
>   	char buf_parent;
>   	long ret;
> +	bool can_trace_child, can_trace_parent;
> +
> +	yama_ptrace_scope = get_yama_ptrace_scope();
> +	ASSERT_LE(0, yama_ptrace_scope);
> +
> +	if (yama_ptrace_scope >= 3)
> +		SKIP(return, "Yama forbids any ptrace use (scope %d)", yama_ptrace_scope);
> +
> +	can_trace_child = !variant->domain_parent && (yama_ptrace_scope < 2);
> +	can_trace_parent = !variant->domain_child && (yama_ptrace_scope < 1);
> +	TH_LOG("can_trace_child:%d, can_trace_parent:%d", can_trace_child, can_trace_parent);

No need to log this because tests may already be marked as skipped.

>   
>   	/*
>   	 * Removes all effective and permitted capabilities to not interfere
> @@ -258,6 +296,7 @@ TEST_F(hierarchy, trace)
>   
>   		ASSERT_EQ(0, close(pipe_parent[1]));
>   		ASSERT_EQ(0, close(pipe_child[0]));
> +
>   		if (variant->domain_child)
>   			create_domain(_metadata);
>   
> @@ -265,43 +304,47 @@ TEST_F(hierarchy, trace)
>   		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
>   
>   		/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
> -		err_proc_read = test_ptrace_read(parent);
> -		ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
> -		if (variant->domain_child) {

You only need to replace this check with !can_trace_parent.

> -			EXPECT_EQ(-1, ret);
> -			EXPECT_EQ(EPERM, errno);
> -			EXPECT_EQ(EACCES, err_proc_read);
> -		} else {
> -			EXPECT_EQ(0, ret);
> -			EXPECT_EQ(0, err_proc_read);
> -		}
> -		if (ret == 0) {
> -			ASSERT_EQ(parent, waitpid(parent, &status, 0));
> -			ASSERT_EQ(1, WIFSTOPPED(status));
> -			ASSERT_EQ(0, ptrace(PTRACE_DETACH, parent, NULL, 0));
> +		if (can_trace_parent) {

The previous check should be enough.

> +			err_proc_read = test_ptrace_read(parent);
> +			ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
> +			if (variant->domain_child) {
> +				EXPECT_EQ(-1, ret);
> +				EXPECT_EQ(EPERM, errno);
> +				EXPECT_EQ(EACCES, err_proc_read);
> +			} else {
> +				EXPECT_EQ(0, ret);
> +				EXPECT_EQ(0, err_proc_read);
> +			}
> +			if (ret == 0) {
> +				ASSERT_EQ(parent, waitpid(parent, &status, 0));
> +				ASSERT_EQ(1, WIFSTOPPED(status));
> +				ASSERT_EQ(0, ptrace(PTRACE_DETACH, parent, NULL, 0));
> +			}
>   		}
>   
>   		/* Tests child PTRACE_TRACEME. */
> -		ret = ptrace(PTRACE_TRACEME);
> -		if (variant->domain_parent) {

Ditto, replace with !can_trace_child.

> -			EXPECT_EQ(-1, ret);
> -			EXPECT_EQ(EPERM, errno);
> -		} else {
> -			EXPECT_EQ(0, ret);
> +		if (can_trace_child) {

The previous check should be enough.

> +			ret = ptrace(PTRACE_TRACEME);
> +			if (variant->domain_parent) {
> +				EXPECT_EQ(-1, ret);
> +				EXPECT_EQ(EPERM, errno);
> +			} else {
> +				EXPECT_EQ(0, ret);
> +			}
> +
> +			/*
> +			 * Signals that the PTRACE_ATTACH test is done and the
> +			 * PTRACE_TRACEME test is ongoing.
> +			 */
> +			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> +
> +			if (!variant->domain_parent)
> +				ASSERT_EQ(0, raise(SIGSTOP));
> +
> +			/* Waits for the parent PTRACE_ATTACH test. */
> +			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
>   		}
>   
> -		/*
> -		 * Signals that the PTRACE_ATTACH test is done and the
> -		 * PTRACE_TRACEME test is ongoing.
> -		 */
> -		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> -
> -		if (!variant->domain_parent) {

Ditto, replace with can_trace_child.

> -			ASSERT_EQ(0, raise(SIGSTOP));
> -		}
> -
> -		/* Waits for the parent PTRACE_ATTACH test. */
> -		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));

Should not be removed.

>   		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
>   		return;
>   	}
> @@ -318,42 +361,50 @@ TEST_F(hierarchy, trace)
>   	 * Waits for the child to test PTRACE_ATTACH on the parent and start
>   	 * testing PTRACE_TRACEME.
>   	 */
> -	ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
> -
> -	/* Tests child PTRACE_TRACEME. */
> -	if (!variant->domain_parent) {

ditto

> -		ASSERT_EQ(child, waitpid(child, &status, 0));
> -		ASSERT_EQ(1, WIFSTOPPED(status));
> -		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
> -	} else {
> -		/* The child should not be traced by the parent. */
> -		EXPECT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
> -		EXPECT_EQ(ESRCH, errno);
> -	}
> +	if (can_trace_child) {
> +		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
>   
> -	/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. */
> -	err_proc_read = test_ptrace_read(child);
> -	ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
> -	if (variant->domain_parent) {

ditto

> -		EXPECT_EQ(-1, ret);
> -		EXPECT_EQ(EPERM, errno);
> -		EXPECT_EQ(EACCES, err_proc_read);
> -	} else {
> -		EXPECT_EQ(0, ret);
> -		EXPECT_EQ(0, err_proc_read);
> -	}
> -	if (ret == 0) {
> -		ASSERT_EQ(child, waitpid(child, &status, 0));
> -		ASSERT_EQ(1, WIFSTOPPED(status));
> -		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
> +		/* Tests child PTRACE_TRACEME. */
> +		if (!variant->domain_parent) {
> +			ASSERT_EQ(child, waitpid(child, &status, 0));
> +			ASSERT_EQ(1, WIFSTOPPED(status));
> +			ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
> +		} else {
> +			/* The child should not be traced by the parent. */
> +			EXPECT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
> +			EXPECT_EQ(ESRCH, errno);
> +		}
> +
> +		/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. */
> +		err_proc_read = test_ptrace_read(child);
> +		ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
> +		if (variant->domain_parent) {
> +			EXPECT_EQ(-1, ret);
> +			EXPECT_EQ(EPERM, errno);
> +			EXPECT_EQ(EACCES, err_proc_read);
> +		} else {
> +			EXPECT_EQ(0, ret);
> +			EXPECT_EQ(0, err_proc_read);
> +		}
> +		if (ret == 0) {
> +			ASSERT_EQ(child, waitpid(child, &status, 0));
> +			ASSERT_EQ(1, WIFSTOPPED(status));
> +			ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
> +		}
> +
> +		/* Signals that the parent PTRACE_ATTACH test is done. */
> +		ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
>   	}
>   
> -	/* Signals that the parent PTRACE_ATTACH test is done. */
> -	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));

ditto

>   	ASSERT_EQ(child, waitpid(child, &status, 0));
>   	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
>   	    WEXITSTATUS(status) != EXIT_SUCCESS)
>   		_metadata->passed = 0;
> +
> +	if (yama_ptrace_scope > 0)
> +		SKIP(return, "Incomplete tests due to Yama restrictions (ptrace_scope:%d)",

For consistency, please change to " (scope %d)"

> +			yama_ptrace_scope);
> +
>   }
>   
>   TEST_HARNESS_MAIN

Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B407EC3DA71
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Dec 2022 18:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiLOShM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Dec 2022 13:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiLOSgn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Dec 2022 13:36:43 -0500
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ECC22B1B
        for <linux-security-module@vger.kernel.org>; Thu, 15 Dec 2022 10:34:50 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NY19h38GNzMpnRZ;
        Thu, 15 Dec 2022 19:34:48 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4NY19g5vGczMptnJ;
        Thu, 15 Dec 2022 19:34:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1671129288;
        bh=k5QH6se0vLsINiRxRFKBTNr8NZdu2UwyIgle4Dc48zc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L/Lm3G1Si+7oM1gj+WwRjTtzAUzG2Dc9Lso7D1udEKd2T5Eve8B7LIW91NGhvtm77
         fL+qfALTPpX5rUgr0eSG26hqQbhsKQlqXEw4CIR2EzVJbqkPe/ZtDMnolt4h51DbRT
         aKjpTcYMWvwzUM/HMRQjAS2o+2PKMKBTQmeTrgwE=
Message-ID: <43c925e3-ce72-3ba1-15cf-6fbb34c485f1@digikod.net>
Date:   Thu, 15 Dec 2022 19:34:47 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2 1/1] selftests/landlock: skip ptrace_test according to
 YAMA
Content-Language: en-US
To:     jeffxu@chromium.org
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        Jeff Xu <jeffxu@google.com>
References: <20221213185816.3942853-1-jeffxu@chromium.org>
 <20221213185816.3942853-2-jeffxu@chromium.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221213185816.3942853-2-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is much better! We can tailor a bit more the tests though.

On 13/12/2022 19:58, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> Add check for yama setting for ptrace_test.
> 
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>   .../testing/selftests/landlock/ptrace_test.c  | 34 +++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index c28ef98ff3ac..8565a25a9587 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -60,6 +60,24 @@ static int test_ptrace_read(const pid_t pid)
>   	return 0;
>   }
>   
> +static int get_ptrace_scope(void)

Please rename to get_yama_ptrace_scope().

> +{
> +	int ret = -1;
> +	char buf[2];
> +	int fd = open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
> +
> +	if (fd < 0)
> +		return 0;
> +
> +	if (read(fd, &buf, 1) < 0)
> +		return -1;
> +
> +	buf[1] = '\0';

You can replace that with `char buf[2] = {};`


> +	ret = atoi(buf);
> +	close(fd);
> +	return ret;
> +}
> +
>   /* clang-format off */
>   FIXTURE(hierarchy) {};
>   /* clang-format on */
> @@ -69,6 +87,7 @@ FIXTURE_VARIANT(hierarchy)
>   	const bool domain_both;
>   	const bool domain_parent;
>   	const bool domain_child;
> +	const int  yama_value;

Please rename to yama_ptrace_scope_max and remove the extra space.

>   };
>   
>   /*
> @@ -93,6 +112,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_without_domain) {
>   	.domain_both = false,
>   	.domain_parent = false,
>   	.domain_child = false,
> +	.yama_value = 0,
>   };
>   
>   /*
> @@ -110,6 +130,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_one_domain) {
>   	.domain_both = false,
>   	.domain_parent = false,
>   	.domain_child = true,
> +	.yama_value = 1,
>   };
>   
>   /*
> @@ -126,6 +147,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_parent_domain) {
>   	.domain_both = false,
>   	.domain_parent = true,
>   	.domain_child = false,
> +	.yama_value = 0,
>   };
>   
>   /*
> @@ -143,6 +165,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_sibling_domain) {
>   	.domain_both = false,
>   	.domain_parent = true,
>   	.domain_child = true,
> +	.yama_value = 2,
>   };
>   
>   /*
> @@ -160,6 +183,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_sibling_domain) {
>   	.domain_both = true,
>   	.domain_parent = false,
>   	.domain_child = false,
> +	.yama_value = 0,
>   };
>   
>   /*
> @@ -178,6 +202,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_nested_domain) {
>   	.domain_both = true,
>   	.domain_parent = false,
>   	.domain_child = true,
> +	.yama_value = 1,
>   };
>   
>   /*
> @@ -196,6 +221,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_nested_and_parent_domain) {
>   	.domain_both = true,
>   	.domain_parent = true,
>   	.domain_child = false,
> +	.yama_value = 0,
>   };
>   
>   /*
> @@ -216,6 +242,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_domain) {
>   	.domain_both = true,
>   	.domain_parent = true,
>   	.domain_child = true,
> +	.yama_value = 2,
>   };
>   
>   FIXTURE_SETUP(hierarchy)
> @@ -232,9 +259,16 @@ TEST_F(hierarchy, trace)
>   	pid_t child, parent;
>   	int status, err_proc_read;
>   	int pipe_child[2], pipe_parent[2];
> +	int yama;

Please rename to yama_ptrace_scope.


>   	char buf_parent;
>   	long ret;
>   
> +	yama = get_ptrace_scope();
> +	ASSERT_LE(0, yama);
> +
> +	if (variant->yama_value < yama)

if (yama_ptrace_scope >= 3)

> +		SKIP(return, "unsupported yama value %d", yama);

"Yama forbids any ptrace use (scope 3)"


This check skips the whole test, whereas the issues with Yama are about:
- a child process tracing its parent;
- the PTRACE_TRACEME case.

I think the main remaining parts to change is the `if 
(variant->domain_*` checks to extend with the yama_ptrace_scope_max check.

However, it is useful to highlight that a test didn't fully covered 
Landlock checks. I think the best approach is to call SKIP() at the end 
of TEST_F(hierarchy, trace) if yama_ptrace_scope >= 1 . This way, we 
test as much as possible (Landlock and Yama) and we mark the "tampered" 
tests as skipped.


> +
>   	/*
>   	 * Removes all effective and permitted capabilities to not interfere
>   	 * with cap_ptrace_access_check() in case of PTRACE_MODE_FSCREDS.

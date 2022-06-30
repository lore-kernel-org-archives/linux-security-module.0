Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E02EC433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Jun 2022 15:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbiF3PRK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 30 Jun 2022 11:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbiF3PRK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Jun 2022 11:17:10 -0400
X-Greylist: delayed 427 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 08:17:07 PDT
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [IPv6:2001:1600:4:17::190c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7753533360
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jun 2022 08:17:07 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LYhZr1yMQzMq2ZH;
        Thu, 30 Jun 2022 17:09:56 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4LYhZq2tQDzlqV0g;
        Thu, 30 Jun 2022 17:09:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1656601796;
        bh=63iqEsGcqCsAdI9g+P0VLeO7BD6vQ9pa/m2XM0oe8V4=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=h2c98TbJoAqKyEc0lRWEFjKbGg9BP0Jx7ep766eQIeSK2AAnkF84uU3ww0SkIfXEA
         IN5hTqdKeDyeqLGeakPGyJQsQ0Iv+zR4EvhkAfAo8aXKFe6t8mdar3iczRv4JmT29K
         QV38dItU0HIe5NNVzCJ13EOX5lREByj/mh8AlrYw=
Message-ID: <8925580b-1243-f6df-edaa-db9b8bec07db@digikod.net>
Date:   Thu, 30 Jun 2022 17:09:54 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>
Cc:     linux-security-module@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
References: <20220628222941.2642917-1-jeffxu@google.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH] selftests/landlock: skip ptrace_test when YAMA is enabled
In-Reply-To: <20220628222941.2642917-1-jeffxu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Jeff,

Thanks for this patch. Here are some comments:

On 29/06/2022 00:29, Jeff Xu wrote:
> ptrace_test assumes YAMA is disabled, skip it if YAMA is enabled.
> 
> Cc: Jorge Lucangeli Obes <jorgelo@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mickaël Salaün <mic@digikod.net>
> Tested-by: Jeff Xu <jeffxu@google.com>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> Change-Id: I623742ca9f20ec706a38c92f6c0bab755f73578f
> ---
>   .../testing/selftests/landlock/ptrace_test.c  | 49 +++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index c28ef98ff3ac..ef2d36f56764 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -226,6 +226,44 @@ FIXTURE_TEARDOWN(hierarchy)
>   {
>   }
>   

Please move these new helpers after test_ptrace_read() and make them static.

> +int open_sysfs(const char *path, int flags, int *fd)
> +{
> +	*fd = open(path, flags);
> +
> +	if (fd < 0)
> +		return -1;
> +
> +	return 0;
> +}

open_sysfs() can be replaced with a call to open(). This makes the code 
simpler.

> +
> +int read_sysfs_int_fd(int fd, int *val)
> +{
> +	char buf[2];
> +
> +	if (read(fd, buf, sizeof(buf)) < 0)

I guess `read(fd, buf, 1)` should be enough and it enables keeping the 
final '\0'. A comment should state that this helper only read the first 
digit (which is enough for Yama).

> +		return -1;
> +
> +	buf[sizeof(buf) - 1] = '\0';

Use `char buf[2] = {};` instead.

> +	*val = atoi(buf);
> +	return 0;
> +}

Same for read_sysfs_int_fd(), you can inline the code in read_sysfs_int().

> +
> +int read_sysfs_int(const char *path, int *val)
> +{
> +	int fd;
> +
> +	if (open_sysfs(path, O_RDONLY, &fd) != 0)
> +		return -1;
> +
> +	if (read_sysfs_int_fd(fd, val) != 0) {
> +		close(fd);
> +		return -1;
> +	}
> +
> +	close(fd);
> +	return 0;
> +}
> +
>   /* Test PTRACE_TRACEME and PTRACE_ATTACH for parent and child. */
>   TEST_F(hierarchy, trace)
>   {
> @@ -235,6 +273,17 @@ TEST_F(hierarchy, trace)
>   	char buf_parent;
>   	long ret;
>   
> +	int ptrace_val;
> +
> +	ASSERT_EQ(0, read_sysfs_int("/proc/sys/kernel/yama/ptrace_scope",
> +				    &ptrace_val));

This is a good test but it fail if Yama is not built in the kernel.

For now, I think you can create two helpers named something like 
is_yama_restricting() and is_yama_denying() (for admin-only attach).

> +	if (ptrace_val != 0) {

Some tests should work even if ptrace_val == 1. SKIP() should only be 
called when the test would fail. Can you please check all tests with all 
Yama values?

> +		/*
> +		 * Yama's scoped ptrace is presumed disabled.  If enabled, skip.
> +		 */
> +		SKIP(return, "yama is enabled, skip current test");
> +	}
> +
>   	/*
>   	 * Removes all effective and permitted capabilities to not interfere
>   	 * with cap_ptrace_access_check() in case of PTRACE_MODE_FSCREDS.

Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A616C32772
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Aug 2022 12:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiHVM4Q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Aug 2022 08:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHVM4P (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Aug 2022 08:56:15 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AB418359
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 05:56:12 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MBC621MgmzMq0t2;
        Mon, 22 Aug 2022 14:56:10 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MBC606y77zlh8Ts;
        Mon, 22 Aug 2022 14:56:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661172970;
        bh=NTgn+GUbi4XOqLkT2fQsXBCAJYtABmn0YdbNd0LIMnk=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=B1ES+nkloF5pU6m6tgkn4oMGGb4UTYVCZ4n81PTsWcFcya4dPImGnXFHrjRG6iKZQ
         KMY3zuWoqbjMEYYQOXX1hEljnTMbw2yUKpECtoOYnV8eL9nzKVCKR+qZ4gkRG1TPlW
         xbsgjBv0KhRACjt+dfQamI4uMEvjG1aBrvLfwJmM=
Message-ID: <2728a73c-a3f9-d8f5-9264-9437d6eeda02@digikod.net>
Date:   Mon, 22 Aug 2022 14:55:58 +0200
MIME-Version: 1.0
User-Agent: 
To:     jeffxu@google.com
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        Jeff Xu <jeffxu@chromium.org>
References: <20220820004547.2135627-1-jeffxu@google.com>
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH] selftests/landlock: skip overlayfs test when kernel not
 support it
In-Reply-To: <20220820004547.2135627-1-jeffxu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 20/08/2022 02:45, jeffxu@google.com wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> Overlayfs can be disabled in kernel config, causing related tests to fail.
> Add check for overlayfs’s supportability at runtime, so we can call SKIP()
> when needed.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>   tools/testing/selftests/landlock/fs_test.c | 56 ++++++++++++++++++++--
>   1 file changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 21a2ce8fa739..f604165dbd21 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -11,6 +11,7 @@
>   #include <fcntl.h>
>   #include <linux/landlock.h>
>   #include <sched.h>
> +#include <stdio.h>
>   #include <string.h>
>   #include <sys/capability.h>
>   #include <sys/mount.h>
> @@ -3398,12 +3399,53 @@ static const char (*merge_sub_files[])[] = {
>    *         └── work
>    */
>   
> +static char *fgrep(FILE *inf, const char *str)

Please move these two helpers just before prepare_layout(). I plan to 
use them for other filesystems.


> +{
> +	char line[256];

I guess we can safely set this array size to 32 for now.


> +	int slen = strlen(str);
> +
> +	while (!feof(inf)) {
> +		if (!fgets(line, 256, inf))

Please use sizeof(line)

> +			break;
> +		if (strncmp(line, str, slen))
> +			continue;
> +
> +		return strdup(line);

No need to duplicate the string, just return a boolean.


> +	}
> +
> +	return NULL;
> +}
> +
> +static bool check_overlayfs_support(void)

Can be renamed to supports_overlayfs().


> +{
> +	FILE *inf = fopen("/proc/filesystems", "r");

Just move the fopen() call at the end of variable declaration and add a 
const.


> +	char *res;
> +	bool ret = false;
> +
> +	if (!inf)
> +		return false;

Let's assume that a failed attempt to open /proc/filesystems means the 
filesystem is supported (default behavior). This can help detect such 
missing file (which should not happen). You can add a comment to explain 
the rational.


> +
> +	res = fgrep(inf, "nodev\toverlay\n");
> +
> +	if (res) {
> +		ret = true;
> +		free(res);
> +	}
> +
> +	fclose(inf);
> +
> +	return ret;
> +}
> +
>   /* clang-format off */
>   FIXTURE(layout2_overlay) {};
>   /* clang-format on */
>   
>   FIXTURE_SETUP(layout2_overlay)
>   {
> +	int rc;

Let's stick to "ret".


> +	bool support;

s/support/is_supported/


> +
>   	prepare_layout(_metadata);
>   
>   	create_directory(_metadata, LOWER_BASE);
> @@ -3431,9 +3473,17 @@ FIXTURE_SETUP(layout2_overlay)
>   	create_directory(_metadata, MERGE_DATA);
>   	set_cap(_metadata, CAP_SYS_ADMIN);
>   	set_cap(_metadata, CAP_DAC_OVERRIDE);
> -	ASSERT_EQ(0, mount("overlay", MERGE_DATA, "overlay", 0,
> -			   "lowerdir=" LOWER_DATA ",upperdir=" UPPER_DATA
> -			   ",workdir=" UPPER_WORK));
> +
> +	rc = mount("overlay", MERGE_DATA, "overlay", 0,
> +			"lowerdir=" LOWER_DATA ",upperdir=" UPPER_DATA
> +			",workdir=" UPPER_WORK);

Please format with clang-format-14, otherwise I'll do it myself.


> +	if (rc < 0) {

Please check errno with ASSERT_EQ() to differentiate from a skippable 
mount and an unexpected error. The next TH_LOG() would then not be needed.


> +		TH_LOG("mount overlay failed: errorno=%s", strerror(errno));
> +		support = check_overlayfs_support();
> +		ASSERT_FALSE(support);

ASSERT_FALSE(supports_overlayfs());

> +		SKIP(return, "overlayfs is not supported");
> +	}
> +

Please keep these clear_cap() calls just after the mount call.

>   	clear_cap(_metadata, CAP_DAC_OVERRIDE);
>   	clear_cap(_metadata, CAP_SYS_ADMIN);
>   }

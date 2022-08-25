Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FC3C04AA5
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Aug 2022 08:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiHYIXr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Aug 2022 04:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiHYIXp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Aug 2022 04:23:45 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA7DA5984
        for <linux-security-module@vger.kernel.org>; Thu, 25 Aug 2022 01:23:42 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MCwwD5krpzMpyf6;
        Thu, 25 Aug 2022 10:23:40 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MCwwD34Qwzlh8TW;
        Thu, 25 Aug 2022 10:23:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661415820;
        bh=5Fw9bi+YQMIFuhusVZTR+LnPrytnMfmlaaT/CADLfJU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=A7gMDVB1Z4X8BJ1UsYwOY7bAdtPUuQDRSWnro7DkiQqsdTzcT17uY2P8kgL4QqVsk
         utabyI5OHHu/K6/+aBF/w8RHRjS7t3uEaRSJOgAcdDRWNtsfFzl6kWvNFLQ1zOArzg
         zEq15RKL4ZvIEGv2I3GYxmLDSNJ0m6l7VR0i9gaw=
Message-ID: <ccadad07-53a6-e86e-602b-1d5615a5f9e4@digikod.net>
Date:   Thu, 25 Aug 2022 10:23:39 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     jeffxu@chromium.org
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org
References: <20220824015852.32257-1-jeffxu@chromium.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v5] selftests/landlock: Skip overlayfs tests not supported
In-Reply-To: <20220824015852.32257-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

As discussed for the v4, the next version of this patch needs a 
TEST_F_FORK() fix.

Please add a link to the previous patch (lore.kernel.org) for each new 
version.


On 24/08/2022 03:58, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> overlayfs can be disabled in the kernel configuration (which is the case
> for chromeOS), causing related tests to fail.  Skip such tests when an
> overlayfs mount operation failed because the running kernel doesn't
> support this file system.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> ---
>   tools/testing/selftests/landlock/fs_test.c | 54 ++++++++++++++++++++--
>   1 file changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 21a2ce8fa739..645304d9fe98 100644
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
> @@ -169,6 +170,42 @@ static int remove_path(const char *const path)
>   	return err;
>   }
>   
> +static bool fgrep(FILE *file, const char *str)
> +{
> +	char line[32];
> +	int str_len = strlen(str);
> +
> +	while (!feof(file)) {
> +		if (!fgets(line, sizeof(line), file))
> +			break;
> +		if (strncmp(line, str, str_len))
> +			continue;
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool supports_overlayfs(void)
> +{
> +	bool ret;
> +	FILE *file = fopen("/proc/filesystems", "r");
> +
> +	/*
> +	 * A failed attempt to open /proc/filesystems
> +	 * implies that the file system is supported (default
> +	 * behavior). This can help detect such unattended issue
> +	 * (which should not happen)."
> +	 */
> +	if (!file)
> +		return true;
> +
> +	ret = fgrep(file, "nodev\toverlay\n");
> +	fclose(file);
> +	return ret;
> +}
> +
>   static void prepare_layout(struct __test_metadata *const _metadata)
>   {
>   	disable_caps(_metadata);
> @@ -3404,6 +3441,8 @@ FIXTURE(layout2_overlay) {};
>   
>   FIXTURE_SETUP(layout2_overlay)
>   {
> +	int ret, err;
> +
>   	prepare_layout(_metadata);
>   
>   	create_directory(_metadata, LOWER_BASE);
> @@ -3431,11 +3470,20 @@ FIXTURE_SETUP(layout2_overlay)
>   	create_directory(_metadata, MERGE_DATA);
>   	set_cap(_metadata, CAP_SYS_ADMIN);
>   	set_cap(_metadata, CAP_DAC_OVERRIDE);
> -	ASSERT_EQ(0, mount("overlay", MERGE_DATA, "overlay", 0,
> -			   "lowerdir=" LOWER_DATA ",upperdir=" UPPER_DATA
> -			   ",workdir=" UPPER_WORK));
> +
> +	ret = mount("overlay", MERGE_DATA, "overlay", 0,
> +		   "lowerdir=" LOWER_DATA ",upperdir=" UPPER_DATA
> +		   ",workdir=" UPPER_WORK);
> +	err = errno;
>   	clear_cap(_metadata, CAP_DAC_OVERRIDE);
>   	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	if (ret == -1) {
> +		ASSERT_EQ(ENODEV, err);
> +		ASSERT_FALSE(supports_overlayfs());
> +		SKIP(return, "overlayfs is not supported");
> +	}
> +	ASSERT_EQ(0, ret);
>   }
>   
>   FIXTURE_TEARDOWN(layout2_overlay)
> 
> base-commit: 50cd95ac46548429e5bba7ca75cc97d11a697947

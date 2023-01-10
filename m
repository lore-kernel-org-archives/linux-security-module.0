Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C570C54EBC
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Jan 2023 18:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbjAJS4x (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Jan 2023 13:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239806AbjAJSzs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Jan 2023 13:55:48 -0500
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74160532A7
        for <linux-security-module@vger.kernel.org>; Tue, 10 Jan 2023 10:54:14 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ns0N43qMGzMpy2g;
        Tue, 10 Jan 2023 19:54:12 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Ns0N33FsZz56k;
        Tue, 10 Jan 2023 19:54:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1673376852;
        bh=NSYhMRkp6uBa44nx5N8tWFuFGoTHwSDIy512s1+mYeU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SuyQ/gqPIYM7WyFLrJwH/K9Cha1pfMmgp5KTDFy6DOCERzxCEsYgGHBUiL/pnCyYc
         XlfFinjrdqDAjKvNkePlUGqktwnJx+nOotpNf2wy1ejXTk0SX49HYbWvvscEb62rKa
         oxOUx78oE2tsRbKqAMMhTr6bfwVh9NJQKBinPmK4=
Message-ID: <3b2f9db2-9937-4f46-9aed-e1d3821d5832@digikod.net>
Date:   Tue, 10 Jan 2023 19:54:10 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v7 1/1] selftests/landlock: skip overlayfs test when
 kernel not support it
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc:     Guenter Roeck <groeck@google.com>, jeffxu@chromium.org,
        Shuah Khan <shuah@kernel.org>, jorgelo@chromium.org,
        keescook@chromium.org, linux-security-module@vger.kernel.org,
        groeck@chromium.org, gnoack@google.com
References: <20221229210236.3151723-1-jeffxu@google.com>
 <20221229210236.3151723-2-jeffxu@google.com>
 <CABXOdTc3QsT9+bfvk0SSzC-xkKB5UT90e3125guarYoaU231og@mail.gmail.com>
 <242994a4-c209-f877-f77f-7a2adf14dd74@digikod.net>
 <CALmYWFuWjsP2PxgqH006QB5hrN_fDoGS1zOefiToWNOz_Mmd4g@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CALmYWFuWjsP2PxgqH006QB5hrN_fDoGS1zOefiToWNOz_Mmd4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 09/01/2023 22:59, Jeff Xu wrote:
> Hi Mickaël
> Please see inline.
> 
> On Mon, Jan 9, 2023 at 8:05 AM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> Please refresh with clang-format-14.
>>
> My installation has clang-format version 15, but changes are quite big
> if I use it,
> do you still want me to use it ?

That's fine, this patch is almost good, I'll run clang-format-14 on the 
final one.

> 
>> You might want to update the subject to:
>> selftests/landlock: Skip overlayfs tests when not supported
>>
> OK.
> 
>>
>> On 29/12/2022 22:41, Guenter Roeck wrote:
>>> On Thu, Dec 29, 2022 at 1:02 PM <jeffxu@chromium.org> wrote:
>>>>
>>>> From: Jeff Xu <jeffxu@google.com>
>>>>
>>>> Overlayfs can be disabled in kernel config, causing related tests to
>>>> fail. Add check for overlayfs’s supportability at runtime,
>>>> so we can call SKIP() when needed.
>>>>
>>>> Signed-off-by: Jeff Xu <jeffxu@google.com>
>>>
>>> Reviewed-by: Guenter Roeck <groeck@chromium.org>
>>>
>>>> ---
>>>>    tools/testing/selftests/landlock/fs_test.c | 51 ++++++++++++++++++++++
>>>>    1 file changed, 51 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
>>>> index 21a2ce8fa739..34095fe2419b 100644
>>>> --- a/tools/testing/selftests/landlock/fs_test.c
>>>> +++ b/tools/testing/selftests/landlock/fs_test.c
>>>> @@ -11,6 +11,7 @@
>>>>    #include <fcntl.h>
>>>>    #include <linux/landlock.h>
>>>>    #include <sched.h>
>>>> +#include <stdio.h>
>>>>    #include <string.h>
>>>>    #include <sys/capability.h>
>>>>    #include <sys/mount.h>
>>>> @@ -62,6 +63,7 @@ static const char dir_s3d1[] = TMP_DIR "/s3d1";
>>>>    static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
>>>>    static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
>>>>
>>>> +static const char proc_filesystems[] = "/proc/filesystems";
>>
>> You can inline this string in the fopen() call for now.
>>
> Done.
> 
>>
>>>>    /*
>>>>     * layout1 hierarchy:
>>>>     *
>>>> @@ -169,6 +171,43 @@ static int remove_path(const char *const path)
>>>>           return err;
>>>>    }
>>>>
>>>> +static bool fgrep(FILE *inf, const char *str)
>>>> +{
>>>> +       char line[32];
>>>> +       int slen = strlen(str);
>>>> +
>>>> +       while (!feof(inf)) {
>>>> +               if (!fgets(line, sizeof(line), inf))
>>>> +                       break;
>>>> +               if (strncmp(line, str, slen))
>>>> +                       continue;
>>>> +
>>>> +               return true;
>>>> +       }
>>>> +
>>>> +       return false;
>>>> +}
>>>> +
>>>> +static bool supports_overlayfs(void)
>>
>> You can move this two functions just before mkdir_parents().
>>
> Done.
> 
>>
>>>> +{
>>>> +       bool res;
>>>> +       FILE *inf = fopen(proc_filesystems, "r");
>>>> +
>>>> +       /*
>>>> +        * If fopen failed, return supported.
>>>> +        * This help detect missing file (shall not
>>>> +        * happen).
>>
>> You can make this comment fit in two lines, with 80 columns.
>>
> Done.
> 
>>>> +        */
>>>> +       if (!inf)
>>>> +               return true;
>>>> +
>>>> +       res = fgrep(inf, "nodev\toverlay\n");
>>>> +       fclose(inf);
>>>> +
>>>> +       return res;
>>>> +}
>>>> +
>>>> +
>>>>    static void prepare_layout(struct __test_metadata *const _metadata)
>>>>    {
>>>>           disable_caps(_metadata);
>>>> @@ -3404,6 +3443,9 @@ FIXTURE(layout2_overlay) {};
>>>>
>>>>    FIXTURE_SETUP(layout2_overlay)
>>>>    {
>>>> +       if (!supports_overlayfs())
>>>> +               SKIP(return, "overlayfs is not supported");
>>>> +
>>>>           prepare_layout(_metadata);
>>>>
>>>>           create_directory(_metadata, LOWER_BASE);
>>>> @@ -3440,6 +3482,9 @@ FIXTURE_SETUP(layout2_overlay)
>>>>
>>>>    FIXTURE_TEARDOWN(layout2_overlay)
>>>>    {
>>>> +       if (!supports_overlayfs())
>>>> +               SKIP(return, "overlayfs is not supported");
>>
>> This looks good to me except the multiple supports_overlayfs() calls.
>> Only the FIXTURE_SETUP() should be required. I guess some modifications
>> of kselftest_harness.h are need to support that. I'd like to avoid
>> touching TEST_F_FORK() which should be part of kselftest_harness.h
>>
>>
> In kselftest_harness.h,  SKIP() only applies within the function scope (
> FIXTURE_SETUP(), TEST_F_FORK(), FIXTURE_TEARDOWN())
> 
> If we want to apply the skip logic to all remaining steps of the testcase,
> I think we should do it with a dedicated environment check hook
> (FIXTURE_ENV_CHECK),
> called before FIXTURE_SETUP(), if the environment check fails, all of
> the remaining
> test steps will be skipped. In this way, once the env check pass,
> the remaining test case should also be passing, or if env check fails,
> there is no need to
> delete the resource since no setup is called.
> 
> However,  this requires change to the kselftest_harness.h, I do think it needs
> to be a separate feature and commit (we can adopt fs_test to be the
> first user)

Looks good to me, implementing this FIXTURE_ENV_CHECK (or something 
similar) will be cleaner.

Shuah, what do you think about that?


> 
> Best regards,
> Jeff
> 
>>>> +
>>>>           EXPECT_EQ(0, remove_path(lower_do1_fl3));
>>>>           EXPECT_EQ(0, remove_path(lower_dl1_fl2));
>>>>           EXPECT_EQ(0, remove_path(lower_fl1));
>>>> @@ -3471,6 +3516,9 @@ FIXTURE_TEARDOWN(layout2_overlay)
>>>>
>>>>    TEST_F_FORK(layout2_overlay, no_restriction)
>>>>    {
>>>> +       if (!supports_overlayfs())
>>>> +               SKIP(return, "overlayfs is not supported");
>>>> +
>>>>           ASSERT_EQ(0, test_open(lower_fl1, O_RDONLY));
>>>>           ASSERT_EQ(0, test_open(lower_dl1, O_RDONLY));
>>>>           ASSERT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
>>>> @@ -3634,6 +3682,9 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
>>>>           size_t i;
>>>>           const char *path_entry;
>>>>
>>>> +       if (!supports_overlayfs())
>>>> +               SKIP(return, "overlayfs is not supported");
>>>> +
>>>>           /* Sets rules on base directories (i.e. outside overlay scope). */
>>>>           ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1_base);
>>>>           ASSERT_LE(0, ruleset_fd);
>>>> --
>>>> 2.39.0.314.g84b9a713c41-goog
>>>>

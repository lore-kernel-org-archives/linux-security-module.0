Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B063BC54EBD
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Jan 2023 16:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjAIQGC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Jan 2023 11:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjAIQFp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Jan 2023 11:05:45 -0500
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1CC1D0D4
        for <linux-security-module@vger.kernel.org>; Mon,  9 Jan 2023 08:05:43 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NrJh56f2XzMq2gf;
        Mon,  9 Jan 2023 17:05:41 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NrJh50YxJz56W;
        Mon,  9 Jan 2023 17:05:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1673280341;
        bh=b197yRNO6V9Rh0FzpoxJ/Pg4OHY7by4vmXfNLhlVWLc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ynGxZh78KUP4zJZy27T6cqVHMJky4MBZK8JmVMvsWS60yUM9K2q2ZGx+STaC8gXH1
         1mYmIX6JjdapfE162UqVFspqtlGeDYKV60Y5aR63w2oAp4r8xKpXtdLer3HM36KFQ4
         awVREPLbatCz1W0JUqZLpymRMc23uIf/t/183zqc=
Message-ID: <242994a4-c209-f877-f77f-7a2adf14dd74@digikod.net>
Date:   Mon, 9 Jan 2023 17:05:40 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v7 1/1] selftests/landlock: skip overlayfs test when
 kernel not support it
Content-Language: en-US
To:     Guenter Roeck <groeck@google.com>, jeffxu@chromium.org,
        Shuah Khan <shuah@kernel.org>
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
References: <20221229210236.3151723-1-jeffxu@google.com>
 <20221229210236.3151723-2-jeffxu@google.com>
 <CABXOdTc3QsT9+bfvk0SSzC-xkKB5UT90e3125guarYoaU231og@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CABXOdTc3QsT9+bfvk0SSzC-xkKB5UT90e3125guarYoaU231og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Please refresh with clang-format-14.

You might want to update the subject to:
selftests/landlock: Skip overlayfs tests when not supported


On 29/12/2022 22:41, Guenter Roeck wrote:
> On Thu, Dec 29, 2022 at 1:02 PM <jeffxu@chromium.org> wrote:
>>
>> From: Jeff Xu <jeffxu@google.com>
>>
>> Overlayfs can be disabled in kernel config, causing related tests to
>> fail. Add check for overlayfs’s supportability at runtime,
>> so we can call SKIP() when needed.
>>
>> Signed-off-by: Jeff Xu <jeffxu@google.com>
> 
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> 
>> ---
>>   tools/testing/selftests/landlock/fs_test.c | 51 ++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
>> index 21a2ce8fa739..34095fe2419b 100644
>> --- a/tools/testing/selftests/landlock/fs_test.c
>> +++ b/tools/testing/selftests/landlock/fs_test.c
>> @@ -11,6 +11,7 @@
>>   #include <fcntl.h>
>>   #include <linux/landlock.h>
>>   #include <sched.h>
>> +#include <stdio.h>
>>   #include <string.h>
>>   #include <sys/capability.h>
>>   #include <sys/mount.h>
>> @@ -62,6 +63,7 @@ static const char dir_s3d1[] = TMP_DIR "/s3d1";
>>   static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
>>   static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
>>
>> +static const char proc_filesystems[] = "/proc/filesystems";

You can inline this string in the fopen() call for now.


>>   /*
>>    * layout1 hierarchy:
>>    *
>> @@ -169,6 +171,43 @@ static int remove_path(const char *const path)
>>          return err;
>>   }
>>
>> +static bool fgrep(FILE *inf, const char *str)
>> +{
>> +       char line[32];
>> +       int slen = strlen(str);
>> +
>> +       while (!feof(inf)) {
>> +               if (!fgets(line, sizeof(line), inf))
>> +                       break;
>> +               if (strncmp(line, str, slen))
>> +                       continue;
>> +
>> +               return true;
>> +       }
>> +
>> +       return false;
>> +}
>> +
>> +static bool supports_overlayfs(void)

You can move this two functions just before mkdir_parents().


>> +{
>> +       bool res;
>> +       FILE *inf = fopen(proc_filesystems, "r");
>> +
>> +       /*
>> +        * If fopen failed, return supported.
>> +        * This help detect missing file (shall not
>> +        * happen).

You can make this comment fit in two lines, with 80 columns.

>> +        */
>> +       if (!inf)
>> +               return true;
>> +
>> +       res = fgrep(inf, "nodev\toverlay\n");
>> +       fclose(inf);
>> +
>> +       return res;
>> +}
>> +
>> +
>>   static void prepare_layout(struct __test_metadata *const _metadata)
>>   {
>>          disable_caps(_metadata);
>> @@ -3404,6 +3443,9 @@ FIXTURE(layout2_overlay) {};
>>
>>   FIXTURE_SETUP(layout2_overlay)
>>   {
>> +       if (!supports_overlayfs())
>> +               SKIP(return, "overlayfs is not supported");
>> +
>>          prepare_layout(_metadata);
>>
>>          create_directory(_metadata, LOWER_BASE);
>> @@ -3440,6 +3482,9 @@ FIXTURE_SETUP(layout2_overlay)
>>
>>   FIXTURE_TEARDOWN(layout2_overlay)
>>   {
>> +       if (!supports_overlayfs())
>> +               SKIP(return, "overlayfs is not supported");

This looks good to me except the multiple supports_overlayfs() calls. 
Only the FIXTURE_SETUP() should be required. I guess some modifications 
of kselftest_harness.h are need to support that. I'd like to avoid 
touching TEST_F_FORK() which should be part of kselftest_harness.h


>> +
>>          EXPECT_EQ(0, remove_path(lower_do1_fl3));
>>          EXPECT_EQ(0, remove_path(lower_dl1_fl2));
>>          EXPECT_EQ(0, remove_path(lower_fl1));
>> @@ -3471,6 +3516,9 @@ FIXTURE_TEARDOWN(layout2_overlay)
>>
>>   TEST_F_FORK(layout2_overlay, no_restriction)
>>   {
>> +       if (!supports_overlayfs())
>> +               SKIP(return, "overlayfs is not supported");
>> +
>>          ASSERT_EQ(0, test_open(lower_fl1, O_RDONLY));
>>          ASSERT_EQ(0, test_open(lower_dl1, O_RDONLY));
>>          ASSERT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
>> @@ -3634,6 +3682,9 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
>>          size_t i;
>>          const char *path_entry;
>>
>> +       if (!supports_overlayfs())
>> +               SKIP(return, "overlayfs is not supported");
>> +
>>          /* Sets rules on base directories (i.e. outside overlay scope). */
>>          ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1_base);
>>          ASSERT_LE(0, ruleset_fd);
>> --
>> 2.39.0.314.g84b9a713c41-goog
>>

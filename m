Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B80FC4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Dec 2022 10:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiLPKPO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 16 Dec 2022 05:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiLPKPN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Dec 2022 05:15:13 -0500
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78A2120A7
        for <linux-security-module@vger.kernel.org>; Fri, 16 Dec 2022 02:15:10 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NYQ2h4KVVzMqnWc;
        Fri, 16 Dec 2022 11:15:08 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4NYQ2g57NJzMptpV;
        Fri, 16 Dec 2022 11:15:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1671185708;
        bh=lu0bgzqb5m6H1HNQETsmO+m9l5n3PIK0jTx80uAPpus=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qto7xvxAWa7InOsvf0QieR9TXVJ6oXwEgQbi40FZglIQYMDhd5LSt+bH0sVm1h+Xq
         9ti8wD67C1lf+fVy4U4WbKqTQ3Mp58SnX99QiJvf4/+UxCE25eaXX2lsdBfFVa/zeM
         NmT3b9SasMui2od+vhNZwuXFr5vDxmtIE0S/tO+M=
Message-ID: <48358983-6224-a1fd-07fa-8ddd81392201@digikod.net>
Date:   Fri, 16 Dec 2022 11:15:07 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2 1/1] selftests/landlock: skip ptrace_test according to
 YAMA
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>
Cc:     jeffxu@chromium.org, jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org
References: <20221213185816.3942853-1-jeffxu@chromium.org>
 <20221213185816.3942853-2-jeffxu@chromium.org>
 <43c925e3-ce72-3ba1-15cf-6fbb34c485f1@digikod.net>
 <CALmYWFurtUhVqibcPyBXF=pcWRDtDfe3HxMJRGKe29dEAOtVLg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CALmYWFurtUhVqibcPyBXF=pcWRDtDfe3HxMJRGKe29dEAOtVLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 15/12/2022 21:34, Jeff Xu wrote:
> Hi Mickaël
> Thanks for reviewing.
> 
> On Thu, Dec 15, 2022 at 10:34 AM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> This is much better! We can tailor a bit more the tests though.
>>
>> On 13/12/2022 19:58, jeffxu@chromium.org wrote:
>>> From: Jeff Xu <jeffxu@google.com>
>>>
>>> Add check for yama setting for ptrace_test.
>>>
>>> Signed-off-by: Jeff Xu <jeffxu@google.com>
>>> ---
>>>    .../testing/selftests/landlock/ptrace_test.c  | 34 +++++++++++++++++++
>>>    1 file changed, 34 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
>>> index c28ef98ff3ac..8565a25a9587 100644
>>> --- a/tools/testing/selftests/landlock/ptrace_test.c
>>> +++ b/tools/testing/selftests/landlock/ptrace_test.c
>>> @@ -60,6 +60,24 @@ static int test_ptrace_read(const pid_t pid)
>>>        return 0;
>>>    }
>>>
>>> +static int get_ptrace_scope(void)
>>
>> Please rename to get_yama_ptrace_scope().
>>
> Done.
> 
>>> +{
>>> +     int ret = -1;
>>> +     char buf[2];
>>> +     int fd = open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
>>> +
>>> +     if (fd < 0)
>>> +             return 0;
>>> +
>>> +     if (read(fd, &buf, 1) < 0)
>>> +             return -1;
>>> +
>>> +     buf[1] = '\0';
>>
>> You can replace that with `char buf[2] = {};`
>>
> Done.
> The Compiler seems to be getting a lot smarter :) Thanks.
> 
>>
>>> +     ret = atoi(buf);
>>> +     close(fd);
>>> +     return ret;
>>> +}
>>> +
>>>    /* clang-format off */
>>>    FIXTURE(hierarchy) {};
>>>    /* clang-format on */
>>> @@ -69,6 +87,7 @@ FIXTURE_VARIANT(hierarchy)
>>>        const bool domain_both;
>>>        const bool domain_parent;
>>>        const bool domain_child;
>>> +     const int  yama_value;
>>
>> Please rename to yama_ptrace_scope_max and remove the extra space.
>>
> why _max ?  yama_ptrace_scope_current is more proporate ?
> FYI: This is the current sysctl setting.

In response to your other email, yama_ptrace_scope_max_supported looks 
good too.

> 
>>>    };
>>>
>>>    /*
>>> @@ -93,6 +112,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_without_domain) {
>>>        .domain_both = false,
>>>        .domain_parent = false,
>>>        .domain_child = false,
>>> +     .yama_value = 0,
>>>    };
>>>
>>>    /*
>>> @@ -110,6 +130,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_one_domain) {
>>>        .domain_both = false,
>>>        .domain_parent = false,
>>>        .domain_child = true,
>>> +     .yama_value = 1,
>>>    };
>>>
>>>    /*
>>> @@ -126,6 +147,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_parent_domain) {
>>>        .domain_both = false,
>>>        .domain_parent = true,
>>>        .domain_child = false,
>>> +     .yama_value = 0,
>>>    };
>>>
>>>    /*
>>> @@ -143,6 +165,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_sibling_domain) {
>>>        .domain_both = false,
>>>        .domain_parent = true,
>>>        .domain_child = true,
>>> +     .yama_value = 2,
>>>    };
>>>
>>>    /*
>>> @@ -160,6 +183,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_sibling_domain) {
>>>        .domain_both = true,
>>>        .domain_parent = false,
>>>        .domain_child = false,
>>> +     .yama_value = 0,
>>>    };
>>>
>>>    /*
>>> @@ -178,6 +202,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_nested_domain) {
>>>        .domain_both = true,
>>>        .domain_parent = false,
>>>        .domain_child = true,
>>> +     .yama_value = 1,
>>>    };
>>>
>>>    /*
>>> @@ -196,6 +221,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_nested_and_parent_domain) {
>>>        .domain_both = true,
>>>        .domain_parent = true,
>>>        .domain_child = false,
>>> +     .yama_value = 0,
>>>    };
>>>
>>>    /*
>>> @@ -216,6 +242,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_domain) {
>>>        .domain_both = true,
>>>        .domain_parent = true,
>>>        .domain_child = true,
>>> +     .yama_value = 2,
>>>    };
>>>
>>>    FIXTURE_SETUP(hierarchy)
>>> @@ -232,9 +259,16 @@ TEST_F(hierarchy, trace)
>>>        pid_t child, parent;
>>>        int status, err_proc_read;
>>>        int pipe_child[2], pipe_parent[2];
>>> +     int yama;
>>
>> Please rename to yama_ptrace_scope.
>>
> Done.
> 
> 
>>
>>>        char buf_parent;
>>>        long ret;
>>>
>>> +     yama = get_ptrace_scope();
>>> +     ASSERT_LE(0, yama);
>>> +
>>> +     if (variant->yama_value < yama)
>>
>> if (yama_ptrace_scope >= 3)
>>
>>> +             SKIP(return, "unsupported yama value %d", yama);
>>
>> "Yama forbids any ptrace use (scope 3)"
>>
>>
> why comparing with  3?  the test will  skip particular hierarchy,
> according to current
> sysctl yama_ptrace setting.

The idea is to run the tests as much as possible, but in the case of a 
scope of 3, any ptrace is denied. However, it would indeed be better to 
integrate this third value in the following `if (variant->domain_*` 
checks, like for the other scopes.


> 
> For example: when kernel.yama.ptrace_scope = 1 the result will be like:
> localhost /usr/local/bin # ./ptrace_test
> TAP version 13
> 1..8
> # Starting 8 tests from 9 test cases.
> #  RUN           hierarchy.allow_without_domain.trace ...
> #      SKIP      unsupported yama value 1
> #            OK  hierarchy.allow_without_domain.trace
> ok 1 # SKIP unsupported yama value 1
> #  RUN           hierarchy.allow_with_one_domain.trace ...
> #            OK  hierarchy.allow_with_one_domain.trace
> ok 2 hierarchy.allow_with_one_domain.trace
> #  RUN           hierarchy.deny_with_parent_domain.trace ...
> #      SKIP      unsupported yama value 1
> #            OK  hierarchy.deny_with_parent_domain.trace
> ok 3 # SKIP unsupported yama value 1
> #  RUN           hierarchy.deny_with_sibling_domain.trace ...
> #            OK  hierarchy.deny_with_sibling_domain.trace
> ok 4 hierarchy.deny_with_sibling_domain.trace
> #  RUN           hierarchy.allow_sibling_domain.trace ...
> #      SKIP      unsupported yama value 1
> #            OK  hierarchy.allow_sibling_domain.trace
> ok 5 # SKIP unsupported yama value 1
> #  RUN           hierarchy.allow_with_nested_domain.trace ...
> #            OK  hierarchy.allow_with_nested_domain.trace
> ok 6 hierarchy.allow_with_nested_domain.trace
> #  RUN           hierarchy.deny_with_nested_and_parent_domain.trace ...
> #      SKIP      unsupported yama value 1
> #            OK  hierarchy.deny_with_nested_and_parent_domain.trace
> ok 7 # SKIP unsupported yama value 1
> #  RUN           hierarchy.deny_with_forked_domain.trace ...
> #            OK  hierarchy.deny_with_forked_domain.trace
> ok 8 hierarchy.deny_with_forked_domain.trace
> # PASSED: 8 / 8 tests passed.
> # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:4 error:0
> 
> when yama.ptrace_scope is 2:
> localhost /usr/local/bin # sysctl kernel.yama.ptrace_scope=2
> kernel.yama.ptrace_scope = 2
> localhost /usr/local/bin # ./ptrace_test
> TAP version 13
> 1..8
> # Starting 8 tests from 9 test cases.
> #  RUN           hierarchy.allow_without_domain.trace ...
> #      SKIP      unsupported yama value 2
> #            OK  hierarchy.allow_without_domain.trace
> ok 1 # SKIP unsupported yama value 2
> #  RUN           hierarchy.allow_with_one_domain.trace ...
> #      SKIP      unsupported yama value 2
> #            OK  hierarchy.allow_with_one_domain.trace
> ok 2 # SKIP unsupported yama value 2
> #  RUN           hierarchy.deny_with_parent_domain.trace ...
> #      SKIP      unsupported yama value 2
> #            OK  hierarchy.deny_with_parent_domain.trace
> ok 3 # SKIP unsupported yama value 2
> #  RUN           hierarchy.deny_with_sibling_domain.trace ...
> #            OK  hierarchy.deny_with_sibling_domain.trace
> ok 4 hierarchy.deny_with_sibling_domain.trace
> #  RUN           hierarchy.allow_sibling_domain.trace ...
> #      SKIP      unsupported yama value 2
> #            OK  hierarchy.allow_sibling_domain.trace
> ok 5 # SKIP unsupported yama value 2
> #  RUN           hierarchy.allow_with_nested_domain.trace ...
> #      SKIP      unsupported yama value 2
> #            OK  hierarchy.allow_with_nested_domain.trace
> ok 6 # SKIP unsupported yama value 2
> #  RUN           hierarchy.deny_with_nested_and_parent_domain.trace ...
> #      SKIP      unsupported yama value 2
> #            OK  hierarchy.deny_with_nested_and_parent_domain.trace
> ok 7 # SKIP unsupported yama value 2
> #  RUN           hierarchy.deny_with_forked_domain.trace ...
> #            OK  hierarchy.deny_with_forked_domain.trace
> ok 8 hierarchy.deny_with_forked_domain.trace
> # PASSED: 8 / 8 tests passed.
> # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:6 error:0
> 
>> This check skips the whole test, whereas the issues with Yama are about:
>> - a child process tracing its parent;
>> - the PTRACE_TRACEME case.
>>
>> I think the main remaining parts to change is the `if
>> (variant->domain_*` checks to extend with the yama_ptrace_scope_max check.
>>
>> However, it is useful to highlight that a test didn't fully cover
>> Landlock checks. I think the best approach is to call SKIP() at the end
>> of TEST_F(hierarchy, trace) if yama_ptrace_scope >= 1 . This way, we
>> test as much as possible (Landlock and Yama) and we mark the "tampered"
>> tests as skipped.
>>
> I believe the test case should not have a lot of branches and logic
> (if/else), which makes
> the test case more complex and harder to read.  By that reason, SKIP()
> is better at beginning
> of the testcase.

I agree in a general case, but here all the branches already exist to 
test all possible Landlock combinations. Adding Yama's ptrace scope will 
only update the existing branch conditions.


> 
> Another reason is resource cleanup.  When SKIP() is not at the
> beginning of tests,
> the cleanup logic can get much more complicated because there are more
> combinations of resource cleanup to
> to be dealt with, after SKIP().

All the logic for resource cleanup is already in place.

> 
> Therefore I do not believe in "tests as much as possible" in a single
> test, I would rather have a
> dedicated test for the situation.

The current test code already covers all possible combinations, so it is 
just a matter of extending the branch conditions. You can update these 
checks using dedicated booleans:
- can_trace_child = !variant->domain_parent && (yama_ptrace_scope < 2);
- can_trace_parent = !variant->domain_child && (yama_ptrace_scope < 1);

…and at the end of all the hierarchy.trace tests add:
if (yama_ptrace_scope > 0)
	SKIP(return, "Incomplete tests due to Yama restrictions (ptrace_scope: 
%d)", yama_ptrace_scope);

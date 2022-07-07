Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3642C43334
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Jul 2022 14:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiGGOYI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiGGOYH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Jul 2022 10:24:07 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7942715
        for <linux-security-module@vger.kernel.org>; Thu,  7 Jul 2022 07:24:05 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LdzDd2n9TzMqFtp;
        Thu,  7 Jul 2022 16:24:01 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4LdzDc71C0zln2Gb;
        Thu,  7 Jul 2022 16:24:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1657203841;
        bh=c2T73G/oD3h2FObyodYc936lU/03TXlWFYRvqppR8d8=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=i38UJ+C+PyTt29nueB50zY9D7E3uqPSFJg53O7jDxEK2sg5lws2toOoNE+Bp77HEO
         h6tNCLACbPcOhmqwSX3ic4lmvdQ9QFo8pSjChgw11XwgFYTsYN7FYPQ9YatRm2J4tf
         Xofe+f5ueENIxXUe1GcXK+OZ8WJXP7/9P+tg31D8=
Message-ID: <9428441c-8189-e7c4-1308-ea15c80ba7c1@digikod.net>
Date:   Thu, 7 Jul 2022 16:24:00 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>
Cc:     linux-security-module@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
References: <20220628222941.2642917-1-jeffxu@google.com>
 <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
 <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH] selftests/landlock: skip ptrace_test when YAMA is enabled
In-Reply-To: <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 05/07/2022 23:49, Jeff Xu wrote:
> Hi Mickaël
> 
> Thank you for your review, please see my response below.
> 
>> Hi Jeff,
>>
>> Thanks for this patch. Here are some comments:
>>
>> On 29/06/2022 00:29, Jeff Xu wrote:
>>> ptrace_test assumes YAMA is disabled, skip it if YAMA is enabled.
>>>
>>> Cc: Jorge Lucangeli Obes <jorgelo@chromium.org>
>>> Cc: Guenter Roeck <groeck@chromium.org>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Mickaël Salaün <mic@digikod.net>
>>> Tested-by: Jeff Xu <jeffxu@google.com>
>>> Signed-off-by: Jeff Xu <jeffxu@google.com>
>>> Change-Id: I623742ca9f20ec706a38c92f6c0bab755f73578f
>>> ---
>>>    .../testing/selftests/landlock/ptrace_test.c  | 49 +++++++++++++++++++
>>>    1 file changed, 49 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
>>> index c28ef98ff3ac..ef2d36f56764 100644
>>> --- a/tools/testing/selftests/landlock/ptrace_test.c
>>> +++ b/tools/testing/selftests/landlock/ptrace_test.c
>>> @@ -226,6 +226,44 @@ FIXTURE_TEARDOWN(hierarchy)
>>>    {
>>>    }
>>>
>>
>> Please move these new helpers after test_ptrace_read() and make them static.
>>
>>> +int open_sysfs(const char *path, int flags, int *fd)
>>> +{
>>> +     *fd = open(path, flags);
>>> +
>>> +     if (fd < 0)
>>> +             return -1;
>>> +
>>> +     return 0;
>>> +}
>>
>> open_sysfs() can be replaced with a call to open(). This makes the code
>> simpler.
>>
>>> +
>>> +int read_sysfs_int_fd(int fd, int *val)
>>> +{
>>> +     char buf[2];
>>> +
>>> +     if (read(fd, buf, sizeof(buf)) < 0)
>>
>> I guess `read(fd, buf, 1)` should be enough and it enables keeping the
>> final '\0'. A comment should state that this helper only read the first
>> digit (which is enough for Yama).
>>
>>> +             return -1;
>>> +
>>> +     buf[sizeof(buf) - 1] = '\0';
>>
>> Use `char buf[2] = {};` instead.
>>
>>> +     *val = atoi(buf);
>>> +     return 0;
>>> +}
>>
> 
> Thanks, I will revise the code, my original thought is to extend it as
> a common utility function to parse an int, let me finish it in the
> next iteration of patch.
> 
>> Same for read_sysfs_int_fd(), you can inline the code in read_sysfs_int().
>> This is a good test but it fail if Yama is not built in the kernel.
>>
> I don't have a kernel built without yama, so my original thought is to
> fail it and whoever has the need can fix it. What is your thought on this ?

The current status is that all tests should pass with a minimal kernel 
configuration (cf. the test config file). Yama is an exception for these 
tests, not the norm, so you also need to test against a kernel without Yama.


> 
>> For now, I think you can create two helpers named something like
>> is_yama_restricting() and is_yama_denying() (for admin-only attach).
>>
> Can you please clarify on the difference/implementation on those 2 ?

They should check for the different values of ptrace_scope: 
https://docs.kernel.org/admin-guide/LSM/Yama.html
- is_yama_restricting() should return true if ptrace_scope == 1
- is_yama_denying() should return true if ptrace_scope >= 2

Restricted ptrace only forbids a child process to ptrace its parents. 
There is no specific restriction for a parent to ptrace its children.

Ptracing is always denied if ptrace_scope >= 2 (without specific 
capabilties, which is the case for these tests).

> 
>>> +     if (ptrace_val != 0) {
>>
>> Some tests should work even if ptrace_val == 1. SKIP() should only be
>> called when the test would fail. Can you please check all tests with all
>> Yama values?
> Sure, below are yama cases with testing result:
> =====================================
> case 0 - classic ptrace permissions: a process can PTRACE_ATTACH to any other
>      process running under the same uid, as long as it is dumpable (i.e.
>      did not transition uids, start privileged, or have called
>      prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TRACEME is
>      unchanged.
> 
> Test: All passing
> ======================================
> Case 1 - restricted ptrace: a process must have a predefined relationship
>      with the inferior it wants to call PTRACE_ATTACH on. By default,
>      this relationship is that of only its descendants when the above
>      classic criteria is also met. To change the relationship, an
>      inferior can call prctl(PR_SET_PTRACER, debugger, ...) to declare
>      an allowed debugger PID to call PTRACE_ATTACH on the inferior.
>      Using PTRACE_TRACEME is unchanged.
> 
> Test:
> // Base_test: 7/7 pass.
> // Fs_test 46/48 pass
> //.   not ok 47 layout2_overlay.no_restriction
> //.   not ok 48 layout2_overlay.same_content_different_file
> //  Ptrace_test 4/8 pass
> // #          FAIL  hierarchy.allow_without_domain.trace
> // #          FAIL  hierarchy.deny_with_parent_domain.trace
> // #          FAIL  hierarchy.allow_sibling_domain.trace
> // #          FAIL  hierarchy.deny_with_nested_and_parent_domain.trace
> ====================================================
> Case 2 - admin-only attach: only processes with CAP_SYS_PTRACE may use ptrace
>      with PTRACE_ATTACH, or through children calling PTRACE_TRACEME.
> Case 3 - no attach: no processes may use ptrace with PTRACE_ATTACH nor via
>      PTRACE_TRACEME. Once set, this sysctl value cannot be changed.
> Test: *case2 and case3 have the same results:
> // Base_test: 7/7 pass.
> // Fs_test 46/48 pass
> //.   not ok 47 layout2_overlay.no_restriction
> //.   not ok 48 layout2_overlay.same_content_different_file
> //  Ptrace 2/8 pass
> //.  ok 4 hierarchy.deny_with_sibling_domain.trace
> //.  ok 8 hierarchy.deny_with_forked_domain.trace
> // the other 6 tests failed with timeout.
> ===============================================
> 
> Do you know why fs_test (47,48) is failing when yama value = 1,2,3 ?

These are all the overlayfs tests but I don't know why they are failing 
with Yama. Could you please pinpoint the exact(s) failing ASSERT? 
(Whatever my following comments, this would be valuable to know the issue.)


> 
> FOR SKIP,  it might be messy to add SKIP after checking variant names
> in TEST_F(), (too many if/else , which make it less readable),
> ideally this should be when or before FIXTURE_VARIANT_ADD() is called.
> or somehow refactor the code to remove the variant check in TEST_F()
> 
> Is there a better way  ?

OK, let's follow another approach.

The first alternative would be to disable Yama for all the Landlock 
ptrace tests. You'll first need to save the current Yama settings and 
restore it after each test, even if they failed. I think this 
alternative makes sense because Landlock tests should not be about Yama.

The second alternative would be to test with and without Yama, with 
different Yama settings. That would also require to disable Yama for 1/3 
or 1/4 of tests. The downside of this alternative is that it requires 3 
or 4 times variants, and it actually test Yama, which is not the goal of 
the Landlock tests.

Anyway, you also need to update the comment about Yama in the current tests.

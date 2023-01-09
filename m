Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C8AC54EBD
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Jan 2023 15:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAIP31 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Jan 2023 10:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjAIP3K (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Jan 2023 10:29:10 -0500
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F1F1AD
        for <linux-security-module@vger.kernel.org>; Mon,  9 Jan 2023 07:29:08 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NrHsr5PfdzMqkP2;
        Mon,  9 Jan 2023 16:29:04 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4NrHsq6gxrzMpyD3;
        Mon,  9 Jan 2023 16:29:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1673278144;
        bh=V2L+PDt1S+pXbITmy8mN4asb6hGvAbTyoEgUxr4CuIg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FMNItWbOPfGc4edUBoT/IduZA2Kf/FFH/f4+MDCSwEYuenCIaIDqXHUzlrnoZeCMB
         yVhHO/7Yanjm1RBoenlRR06xAh2hjJac1O6mMgyxqrwMo0DIY1hbueC3If31HYYUFa
         IqcQIskEGYEdXxbpAg4kVPQwCfASHekCTYSx45aM=
Message-ID: <9ff9997d-f2f2-bb72-9993-132d3c45ae32@digikod.net>
Date:   Mon, 9 Jan 2023 16:29:03 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v4 1/1] selftests/landlock: skip ptrace_test according to
 YAMA
Content-Language: en-US
To:     Guenter Roeck <groeck@google.com>, Jeff Xu <jeffxu@google.com>
Cc:     jeffxu@chromium.org, jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com
References: <20230103190314.3882177-1-jeffxu@google.com>
 <20230103190314.3882177-2-jeffxu@google.com>
 <CABXOdTdf=0C3G4C4CTwAvx3wUQ1RZ_tFuO40LUQMDHCZr7wZmQ@mail.gmail.com>
 <CALmYWFv2H95EuEzCHrs76L3nT39A_UbdHNqUBrQ3PdnLtXfOvw@mail.gmail.com>
 <CABXOdTfzyAx1Nzg_D+EQzn9EV9jyrmAFhU0HEcw5A5a8iV49Zg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CABXOdTfzyAx1Nzg_D+EQzn9EV9jyrmAFhU0HEcw5A5a8iV49Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Looks good and agree with Guenter's suggestions

On 04/01/2023 04:40, Guenter Roeck wrote:
> On Tue, Jan 3, 2023 at 3:50 PM Jeff Xu <jeffxu@google.com> wrote:
>>
>> Thanks for the comments.
>> I agree with most comments, but need Michael to chime in/confirm on below:
>>
>> On Tue, Jan 3, 2023 at 12:12 PM Guenter Roeck <groeck@google.com> wrote:
>>>
>>> On Tue, Jan 3, 2023 at 11:03 AM <jeffxu@chromium.org> wrote:
>>>>
>>>> From: Jeff Xu <jeffxu@google.com>
>>>>
>>>> Add check for yama setting for ptrace_test.
>>>>
>>>> Signed-off-by: Jeff Xu <jeffxu@google.com>
>>>> ---
>>>>   .../testing/selftests/landlock/ptrace_test.c  | 48 ++++++++++++++++---
>>>>   1 file changed, 42 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
>>>> index c28ef98ff3ac..379f5ddf6c3f 100644
>>>> --- a/tools/testing/selftests/landlock/ptrace_test.c
>>>> +++ b/tools/testing/selftests/landlock/ptrace_test.c
>>>> @@ -60,6 +60,23 @@ static int test_ptrace_read(const pid_t pid)
>>>>          return 0;
>>>>   }
>>>>
>>>> +static int get_yama_ptrace_scope(void)
>>>> +{
>>>> +       int ret = -1;
>>>
>>> Unnecessary initialization
>>>
>>>> +       char buf[2] = {};
>>>
>>> Unnecessary initialization
>>>
>> buf was used later by atoi(), and atoi needs a string, because the
>> function only reads one byte in read(),
>> so it needs to add buf[1] = '\0'. In V2, there was a comment  to
>> change the buf[1] = '\0' to char buf[2] = {},
>> my understanding is that the compiler is smart enough and will
>> optimize the initialization to write 0 on the
>> memory  (since this is char and length is 2, and less then the size of int)
>>
> 
> Good point.
> 
> Guenter

Looks good to me with the other suggestions applied.


> 
>>>> +       int fd = open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
>>>> +
>>>> +       if (fd < 0)
>>>> +               return 0;
>>>> +
>>>> +       if (read(fd, &buf, 1) < 0)
>>>
>>> buf is an array, & is thus unnecessary. Also, if the file is empty,
>>> the return value would be 0.
>>>
>>>> +               return -1;
>>>
>>> leaking file descriptor
>>>
>>>> +
>>>> +       ret = atoi(buf);
>>>> +       close(fd);
>>>> +       return ret;
>>>> +}
>>>> +
>>>>   /* clang-format off */
>>>>   FIXTURE(hierarchy) {};
>>>>   /* clang-format on */
>>>> @@ -232,8 +249,20 @@ TEST_F(hierarchy, trace)
>>>>          pid_t child, parent;
>>>>          int status, err_proc_read;
>>>>          int pipe_child[2], pipe_parent[2];
>>>> +       int yama_ptrace_scope;
>>>>          char buf_parent;
>>>>          long ret;
>>>> +       bool can_trace_child, can_trace_parent;
>>>> +
>>>> +       yama_ptrace_scope = get_yama_ptrace_scope();
>>>> +       ASSERT_LE(0, yama_ptrace_scope);
>>>> +
>>>> +       if (yama_ptrace_scope >= 3)
>>>> +               SKIP(return, "Yama forbids any ptrace use (scope %d)",
>>>> +                          yama_ptrace_scope);
>>>> +
>>>> +       can_trace_child = !variant->domain_parent && (yama_ptrace_scope < 2);
>>>> +       can_trace_parent = !variant->domain_child && (yama_ptrace_scope < 1);
>>>>
>>>
>>> Unnecessary ( ).
>>>
>>> It is difficult to understand the context. yama_ptrace_scope == 2 is
>>> YAMA_SCOPE_CAPABILITY, and yama_ptrace_scope == 1 is
>>> YAMA_SCOPE_RELATIONAL. I for my part have no idea how that relates to
>>> child/parent permissions. Also, I have no idea why the negation
>>> (can_trace_child = !variant->domain_parent) is necessary, and what its
>>> functional impact might be. Someone else will have to chime in here.
>>>
>> I will copy the definition of the constant definition from yama_lsm.c
>> But I agree this code is difficult to understand, I'm now lost on why
>> we need the negation too.
>>
>>>>          /*
>>>>           * Removes all effective and permitted capabilities to not interfere
>>>> @@ -258,6 +287,7 @@ TEST_F(hierarchy, trace)
>>>>
>>>>                  ASSERT_EQ(0, close(pipe_parent[1]));
>>>>                  ASSERT_EQ(0, close(pipe_child[0]));
>>>> +
>>>
>>> Unnecessary whitespace change
>>>
>>>>                  if (variant->domain_child)
>>>
>>> Why not change this code ?
>>>
>>>>                          create_domain(_metadata);
>>>>
>> create_domain actually applies the landlocked policy to the
>> (child/parent) process.
>> This is part of the setup of the testcase, so it is needed.
>>
>>
>>>> @@ -267,7 +297,7 @@ TEST_F(hierarchy, trace)
>>>>                  /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
>>>>                  err_proc_read = test_ptrace_read(parent);
>>>>                  ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
>>>> -               if (variant->domain_child) {
>>>> +               if (!can_trace_parent) {
>>>>                          EXPECT_EQ(-1, ret);
>>>>                          EXPECT_EQ(EPERM, errno);
>>>>                          EXPECT_EQ(EACCES, err_proc_read);
>>>> @@ -283,7 +313,7 @@ TEST_F(hierarchy, trace)
>>>>
>>>>                  /* Tests child PTRACE_TRACEME. */
>>>>                  ret = ptrace(PTRACE_TRACEME);
>>>> -               if (variant->domain_parent) {
>>>> +               if (!can_trace_child) {
>>>>                          EXPECT_EQ(-1, ret);
>>>>                          EXPECT_EQ(EPERM, errno);
>>>>                  } else {
>>>> @@ -296,12 +326,12 @@ TEST_F(hierarchy, trace)
>>>>                   */
>>>>                  ASSERT_EQ(1, write(pipe_child[1], ".", 1));
>>>>
>>>> -               if (!variant->domain_parent) {
>>>> +               if (can_trace_child)
>>>>                          ASSERT_EQ(0, raise(SIGSTOP));
>>>> -               }
>>>>
>>>>                  /* Waits for the parent PTRACE_ATTACH test. */
>>>>                  ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
>>>> +
>>>
>>> Unnecessary whitespace change
>>>
>>>>                  _exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
>>>>                  return;
>>>>          }
>>>> @@ -321,7 +351,7 @@ TEST_F(hierarchy, trace)
>>>>          ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
>>>>
>>>>          /* Tests child PTRACE_TRACEME. */
>>>> -       if (!variant->domain_parent) {
>>>> +       if (can_trace_child) {
>>>>                  ASSERT_EQ(child, waitpid(child, &status, 0));
>>>>                  ASSERT_EQ(1, WIFSTOPPED(status));
>>>>                  ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
>>>> @@ -334,7 +364,7 @@ TEST_F(hierarchy, trace)
>>>>          /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. */
>>>>          err_proc_read = test_ptrace_read(child);
>>>>          ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
>>>> -       if (variant->domain_parent) {
>>>> +       if (!can_trace_child) {
>>>>                  EXPECT_EQ(-1, ret);
>>>>                  EXPECT_EQ(EPERM, errno);
>>>>                  EXPECT_EQ(EACCES, err_proc_read);
>>>> @@ -350,10 +380,16 @@ TEST_F(hierarchy, trace)
>>>>
>>>>          /* Signals that the parent PTRACE_ATTACH test is done. */
>>>>          ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
>>>> +
>>>
>>> Unnecessary whitespace change
>>>
>>>>          ASSERT_EQ(child, waitpid(child, &status, 0));
>>>>          if (WIFSIGNALED(status) || !WIFEXITED(status) ||
>>>>              WEXITSTATUS(status) != EXIT_SUCCESS)
>>>>                  _metadata->passed = 0;
>>>> +
>>>> +       if (yama_ptrace_scope > 0)
>>>> +               SKIP(return,
>>>> +                          "Incomplete tests due to Yama restrictions (scope %d)",
>>>> +                          yama_ptrace_scope);
>>>>   }
>>>>
>>>>   TEST_HARNESS_MAIN
>>>> --
>>>> 2.39.0.314.g84b9a713c41-goog
>>>>

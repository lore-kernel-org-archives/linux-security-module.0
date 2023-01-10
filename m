Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DD0C46467
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Jan 2023 20:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjAJUmk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Jan 2023 15:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjAJUmd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Jan 2023 15:42:33 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFF44C726
        for <linux-security-module@vger.kernel.org>; Tue, 10 Jan 2023 12:42:31 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h192so9076800pgc.7
        for <linux-security-module@vger.kernel.org>; Tue, 10 Jan 2023 12:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnsSgJFnxKaVJ1pf8crOpL9EJrck0WZjbRc/IhRKIVo=;
        b=DHNeVs1pigFQI3i/w1D35bcHB/y7JWyW/VSn97f5YPvrWFaZJgs8kWB3ygU6z1U1Sr
         ZSHuxWfZWZ+83kd5hkvnM6e5XrkD9XRutD98QSHtB8Lb+gsPf1HThuNzkhbojkX3A41p
         SHi8xQKRn/7W+mMNp3X4F1T+huAh7aop59N1TMz1gIvV2HTboXeeCTJd16ITyUup3k32
         kDOOcvSCuzN83yMjKGwA8tP/GTJf7T8Yq1kgH9PJAf9Vspoh6FuCBIet+tFfuXjlWSJw
         m7Jw1ztrQLmdN6xASMhebUn+wIwuYuhOPKHYZbFDvtLj1WG5kKH8Qlbw/rq4z49VzGC8
         L39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnsSgJFnxKaVJ1pf8crOpL9EJrck0WZjbRc/IhRKIVo=;
        b=sQYkY1P5yZPb8tuI/TJLvNwTkwhMkPIS5jV5/1SEiWElIt51SWwi95EMfTskIf7NXE
         uJW7HfqX+uB83yVsLyfZpMb0OBMKWY755dyTYfLhyL3go3XeqVScs8+TliD8NM0df3D6
         5g+8gJbZm/6lX/1WJ5o8RQC8fw/31FB4yMba18LS03/SZcEzSl7kCuRVMbXrkn68PIgO
         Y83SESF9pX8xCi++KUFm+DE+uAiM22TIYNv9+P7Sx7j4zluAna1b9zDhqXQYUmbVBTOt
         p6nwifut6b1QzVKBFqo5xsmaGFa2tIZGdjVqc64k6lvLxQ6JdSTqA8Z1S6A9FriDs2UD
         bKdQ==
X-Gm-Message-State: AFqh2kreiCFHgMzllkIyqgSFvVbWgGga/vULv/fMyL3m4g5z0PKKrlJs
        RKXpwmen9GTAQEWWHUcmosa9Poj8pbaua+Kz8udVVg==
X-Google-Smtp-Source: AMrXdXvvSERUEUIlKkQsM2cvPMRkImDPBMAO2rgtwjlgw2G2TMDNZgXcl/MB0wpwP++VP5QEhhy5X4hGg0hWVXTIQyo=
X-Received: by 2002:a63:fe4b:0:b0:479:1b56:9065 with SMTP id
 x11-20020a63fe4b000000b004791b569065mr6258086pgj.249.1673383350651; Tue, 10
 Jan 2023 12:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20230103190314.3882177-1-jeffxu@google.com> <20230103190314.3882177-2-jeffxu@google.com>
 <CABXOdTdf=0C3G4C4CTwAvx3wUQ1RZ_tFuO40LUQMDHCZr7wZmQ@mail.gmail.com>
 <CALmYWFv2H95EuEzCHrs76L3nT39A_UbdHNqUBrQ3PdnLtXfOvw@mail.gmail.com>
 <CABXOdTfzyAx1Nzg_D+EQzn9EV9jyrmAFhU0HEcw5A5a8iV49Zg@mail.gmail.com>
 <9ff9997d-f2f2-bb72-9993-132d3c45ae32@digikod.net> <CALmYWFuGGwSXkahtZ3OFwUzbJ4n00gvLtPyNVOPiK6iHsoP93g@mail.gmail.com>
 <62128847-8063-f658-7c8e-dd15cb2314c1@digikod.net>
In-Reply-To: <62128847-8063-f658-7c8e-dd15cb2314c1@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 10 Jan 2023 12:41:53 -0800
Message-ID: <CALmYWFt-r_hJyPgnXVtTXo_j73ci2g4D=USP1WWi_70JNNx4tw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] selftests/landlock: skip ptrace_test according to YAMA
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Guenter Roeck <groeck@google.com>, jeffxu@chromium.org,
        jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 10, 2023 at 11:04 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
>
>
> On 09/01/2023 23:50, Jeff Xu wrote:
> > On Mon, Jan 9, 2023 at 7:29 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.ne=
t> wrote:
> >>
> >> Looks good and agree with Guenter's suggestions
> >>
> >> On 04/01/2023 04:40, Guenter Roeck wrote:
> >>> On Tue, Jan 3, 2023 at 3:50 PM Jeff Xu <jeffxu@google.com> wrote:
> >>>>
> >>>> Thanks for the comments.
> >>>> I agree with most comments, but need Michael to chime in/confirm on =
below:
> >>>>
> >>>> On Tue, Jan 3, 2023 at 12:12 PM Guenter Roeck <groeck@google.com> wr=
ote:
> >>>>>
> >>>>> On Tue, Jan 3, 2023 at 11:03 AM <jeffxu@chromium.org> wrote:
> >>>>>>
> >>>>>> From: Jeff Xu <jeffxu@google.com>
> >>>>>>
> >>>>>> Add check for yama setting for ptrace_test.
> >>>>>>
> >>>>>> Signed-off-by: Jeff Xu <jeffxu@google.com>
> >>>>>> ---
> >>>>>>    .../testing/selftests/landlock/ptrace_test.c  | 48 ++++++++++++=
++++---
> >>>>>>    1 file changed, 42 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tool=
s/testing/selftests/landlock/ptrace_test.c
> >>>>>> index c28ef98ff3ac..379f5ddf6c3f 100644
> >>>>>> --- a/tools/testing/selftests/landlock/ptrace_test.c
> >>>>>> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> >>>>>> @@ -60,6 +60,23 @@ static int test_ptrace_read(const pid_t pid)
> >>>>>>           return 0;
> >>>>>>    }
> >>>>>>
> >>>>>> +static int get_yama_ptrace_scope(void)
> >>>>>> +{
> >>>>>> +       int ret =3D -1;
> >>>>>
> >>>>> Unnecessary initialization
> >>>>>
> >>>>>> +       char buf[2] =3D {};
> >>>>>
> >>>>> Unnecessary initialization
> >>>>>
> >>>> buf was used later by atoi(), and atoi needs a string, because the
> >>>> function only reads one byte in read(),
> >>>> so it needs to add buf[1] =3D '\0'. In V2, there was a comment  to
> >>>> change the buf[1] =3D '\0' to char buf[2] =3D {},
> >>>> my understanding is that the compiler is smart enough and will
> >>>> optimize the initialization to write 0 on the
> >>>> memory  (since this is char and length is 2, and less then the size =
of int)
> >>>>
> >>>
> >>> Good point.
> >>>
> >>> Guenter
> >>
> >> Looks good to me with the other suggestions applied.
> >>
> >>
> >>>
> >>>>>> +       int fd =3D open("/proc/sys/kernel/yama/ptrace_scope", O_RD=
ONLY);
> >>>>>> +
> >>>>>> +       if (fd < 0)
> >>>>>> +               return 0;
> >>>>>> +
> >>>>>> +       if (read(fd, &buf, 1) < 0)
> >>>>>
> >>>>> buf is an array, & is thus unnecessary. Also, if the file is empty,
> >>>>> the return value would be 0.
> >>>>>
> >>>>>> +               return -1;
> >>>>>
> >>>>> leaking file descriptor
> >>>>>
> >>>>>> +
> >>>>>> +       ret =3D atoi(buf);
> >>>>>> +       close(fd);
> >>>>>> +       return ret;
> >>>>>> +}
> >>>>>> +
> >>>>>>    /* clang-format off */
> >>>>>>    FIXTURE(hierarchy) {};
> >>>>>>    /* clang-format on */
> >>>>>> @@ -232,8 +249,20 @@ TEST_F(hierarchy, trace)
> >>>>>>           pid_t child, parent;
> >>>>>>           int status, err_proc_read;
> >>>>>>           int pipe_child[2], pipe_parent[2];
> >>>>>> +       int yama_ptrace_scope;
> >>>>>>           char buf_parent;
> >>>>>>           long ret;
> >>>>>> +       bool can_trace_child, can_trace_parent;
> >>>>>> +
> >>>>>> +       yama_ptrace_scope =3D get_yama_ptrace_scope();
> >>>>>> +       ASSERT_LE(0, yama_ptrace_scope);
> >>>>>> +
> >>>>>> +       if (yama_ptrace_scope >=3D 3)
> >>>>>> +               SKIP(return, "Yama forbids any ptrace use (scope %=
d)",
> >>>>>> +                          yama_ptrace_scope);
> >>>>>> +
> >>>>>> +       can_trace_child =3D !variant->domain_parent && (yama_ptrac=
e_scope < 2);
> >>>>>> +       can_trace_parent =3D !variant->domain_child && (yama_ptrac=
e_scope < 1);
> >>>>>>
> >>>>>
> >>>>> Unnecessary ( ).
> >>>>>
> >>>>> It is difficult to understand the context. yama_ptrace_scope =3D=3D=
 2 is
> >>>>> YAMA_SCOPE_CAPABILITY, and yama_ptrace_scope =3D=3D 1 is
> >>>>> YAMA_SCOPE_RELATIONAL. I for my part have no idea how that relates =
to
> >>>>> child/parent permissions. Also, I have no idea why the negation
> >>>>> (can_trace_child =3D !variant->domain_parent) is necessary, and wha=
t its
> >>>>> functional impact might be. Someone else will have to chime in here=
.
> >>>>>
> >>>> I will copy the definition of the constant definition from yama_lsm.=
c
>
> Good point.
>
> >>>> But I agree this code is difficult to understand, I'm now lost on wh=
y
> >>>> we need the negation too.
> >>>>
> > Hi Micka=C3=ABl
> >
> > Can you check the above comment please ?
> > I also find it difficult to understand how can_trace_child is set.
> >
> > On this line:
> > can_trace_child =3D !variant->domain_parent &&
> >    yama_ptrace_scope < 2;
> >
> > it translates to
> > can_trace_child is true when 1> && 2>
> > 1> when parent process don't have landlock policy
>
> This is because a landlocked process can only trace a process in the
> same domain or one beneath it. So if a parent process is in its own
> domain (whereas the child is not, see the diagrams close to the
> FIXTURE_VARIANT definitions), it should not be able to trace the child.
>
> This check is not new.
>
>
> > 2> yama_ptrace_scope =3D 0 or 1.
>
> A parent can only trace one of its children up to YAMA_SCOPE_RELATIONAL.
>
> >
> > My question is:
> > When the parent process has a landlock policy, and 2 is true,
> > the parent can also trace the child process, right ?
> > So 1> is not necessary in theory ?
>
> When a parent process *shares* a domain with a child, yes it can trace
> it. However when a parent process is in a domain not shared with the
> child, it cannot trace it. This is why there is domain_both,
> domain_parent and domain_child variants.
>
Thanks for clarification.
I'm adding below comments to help readers:

can_trace_child: if a parent process can trace its child process.
There are two conditions concerning landlock:
1> the parent and child processes are in the same landlock domain or
        one beneath it (case: domain_both =3D true).
2> yama allows tracing children (up to YAMA_SCOPE_RELATIONAL).
Both 1 and 2 need to be met for can_trace_child to be true.
If a parent process has its own domain not shared with the child
process (case:domain_parent =3D true), then the parent can't trace the
child.

can_trace_parent: if a child process can trace its parent process.
There are two conditions concerning landlock:
1> the parent and child process are in the same landlock domain or
        one beneath it.(case: domain_both =3D true).
2> yama is disabled (YAMA_SCOPE_DISABLED).
Both 1 and 2 need to be met for can_trace_parent to be true.
If a child process has its own domain not shared with the parent
process (case:domain_child =3D true, then the child can't trace the
parent.

>
> >
> > As reference:  the latest code (after updating the rest of comments in =
V7)
> > can be found at patchset 8 of
> > https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/4084253
> >
> > Thanks
> > Jeff
> >
> >>>>>>           /*
> >>>>>>            * Removes all effective and permitted capabilities to n=
ot interfere
> >>>>>> @@ -258,6 +287,7 @@ TEST_F(hierarchy, trace)
> >>>>>>
> >>>>>>                   ASSERT_EQ(0, close(pipe_parent[1]));
> >>>>>>                   ASSERT_EQ(0, close(pipe_child[0]));
> >>>>>> +
> >>>>>
> >>>>> Unnecessary whitespace change
> >>>>>
> >>>>>>                   if (variant->domain_child)
> >>>>>
> >>>>> Why not change this code ?
> >>>>>
> >>>>>>                           create_domain(_metadata);
> >>>>>>
> >>>> create_domain actually applies the landlocked policy to the
> >>>> (child/parent) process.
> >>>> This is part of the setup of the testcase, so it is needed.
> >>>>
> >>>>
> >>>>>> @@ -267,7 +297,7 @@ TEST_F(hierarchy, trace)
> >>>>>>                   /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on t=
he parent. */
> >>>>>>                   err_proc_read =3D test_ptrace_read(parent);
> >>>>>>                   ret =3D ptrace(PTRACE_ATTACH, parent, NULL, 0);
> >>>>>> -               if (variant->domain_child) {
> >>>>>> +               if (!can_trace_parent) {
> >>>>>>                           EXPECT_EQ(-1, ret);
> >>>>>>                           EXPECT_EQ(EPERM, errno);
> >>>>>>                           EXPECT_EQ(EACCES, err_proc_read);
> >>>>>> @@ -283,7 +313,7 @@ TEST_F(hierarchy, trace)
> >>>>>>
> >>>>>>                   /* Tests child PTRACE_TRACEME. */
> >>>>>>                   ret =3D ptrace(PTRACE_TRACEME);
> >>>>>> -               if (variant->domain_parent) {
> >>>>>> +               if (!can_trace_child) {
> >>>>>>                           EXPECT_EQ(-1, ret);
> >>>>>>                           EXPECT_EQ(EPERM, errno);
> >>>>>>                   } else {
> >>>>>> @@ -296,12 +326,12 @@ TEST_F(hierarchy, trace)
> >>>>>>                    */
> >>>>>>                   ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> >>>>>>
> >>>>>> -               if (!variant->domain_parent) {
> >>>>>> +               if (can_trace_child)
> >>>>>>                           ASSERT_EQ(0, raise(SIGSTOP));
> >>>>>> -               }
> >>>>>>
> >>>>>>                   /* Waits for the parent PTRACE_ATTACH test. */
> >>>>>>                   ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1)=
);
> >>>>>> +
> >>>>>
> >>>>> Unnecessary whitespace change
> >>>>>
> >>>>>>                   _exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FA=
ILURE);
> >>>>>>                   return;
> >>>>>>           }
> >>>>>> @@ -321,7 +351,7 @@ TEST_F(hierarchy, trace)
> >>>>>>           ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
> >>>>>>
> >>>>>>           /* Tests child PTRACE_TRACEME. */
> >>>>>> -       if (!variant->domain_parent) {
> >>>>>> +       if (can_trace_child) {
> >>>>>>                   ASSERT_EQ(child, waitpid(child, &status, 0));
> >>>>>>                   ASSERT_EQ(1, WIFSTOPPED(status));
> >>>>>>                   ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, =
0));
> >>>>>> @@ -334,7 +364,7 @@ TEST_F(hierarchy, trace)
> >>>>>>           /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child=
. */
> >>>>>>           err_proc_read =3D test_ptrace_read(child);
> >>>>>>           ret =3D ptrace(PTRACE_ATTACH, child, NULL, 0);
> >>>>>> -       if (variant->domain_parent) {
> >>>>>> +       if (!can_trace_child) {
> >>>>>>                   EXPECT_EQ(-1, ret);
> >>>>>>                   EXPECT_EQ(EPERM, errno);
> >>>>>>                   EXPECT_EQ(EACCES, err_proc_read);
> >>>>>> @@ -350,10 +380,16 @@ TEST_F(hierarchy, trace)
> >>>>>>
> >>>>>>           /* Signals that the parent PTRACE_ATTACH test is done. *=
/
> >>>>>>           ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> >>>>>> +
> >>>>>
> >>>>> Unnecessary whitespace change
> >>>>>
> >>>>>>           ASSERT_EQ(child, waitpid(child, &status, 0));
> >>>>>>           if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> >>>>>>               WEXITSTATUS(status) !=3D EXIT_SUCCESS)
> >>>>>>                   _metadata->passed =3D 0;
> >>>>>> +
> >>>>>> +       if (yama_ptrace_scope > 0)
> >>>>>> +               SKIP(return,
> >>>>>> +                          "Incomplete tests due to Yama restricti=
ons (scope %d)",
> >>>>>> +                          yama_ptrace_scope);
> >>>>>>    }
> >>>>>>
> >>>>>>    TEST_HARNESS_MAIN
> >>>>>> --
> >>>>>> 2.39.0.314.g84b9a713c41-goog
> >>>>>>

Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3ABC54EBD
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Jan 2023 22:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjAIWvw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Jan 2023 17:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjAIWvj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Jan 2023 17:51:39 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1099D19C39
        for <linux-security-module@vger.kernel.org>; Mon,  9 Jan 2023 14:51:32 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c26so2932584pfp.10
        for <linux-security-module@vger.kernel.org>; Mon, 09 Jan 2023 14:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DArKiNtecyVZC4IB/sajK07ywvFj3RTI418Mgd908yA=;
        b=ZX7gdlltZ15DqQxoV/V9xelOrAtYZ8o7/0ZrWDIPFykBizSunsKM4TBUkJ8B59rKPI
         yiWI9e9TaqP5+JgNWBiemxWRqS0RU96rnargvygRc8wRlj8RHIbGZmZs6nQdtMhrpXRo
         EHGlk5Od8psrG/GXIOO1o0usGvKHUfhh6U2UpIyAhjNbDE7du/fI4RqUvmMbuDRWdLRp
         OqlT4wfj6NkfMqxio1PdWHM8eXIZVEbCxCV5M2+RMLp08zXWE3pGGglqZBoWV0pIPiFM
         1H6+CJrIW7tDcJ+4cEffmYCLGv8FnyyBnzhCq9ywY18C5B5zNQ/RDSetY7wUEnPGZQHr
         c2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DArKiNtecyVZC4IB/sajK07ywvFj3RTI418Mgd908yA=;
        b=IzzGYIPZ7ydJSUN1EenjjgycM65JD7Xm2cXY0h+FW31JshHF10kYNtf4XPa+moKfUi
         3EmLTJrDD27WTelHEQ+WXbO4A1cOhgO1KmIFCYCaUYqQh004ozXJ0iFyGpyrZqcTf2u7
         DW1hdumCXx4zNkhFF89aZFPnl2C56G+z1o2qpFj6KWouRV3vlRnJMkeG6Q+JRRbVbcs/
         R8qtQJ+09W0U7fQrgYPw1UF2zom2qcxnU5FK+f5CAealwI+WviEEBenOpIWXZTymLODj
         SYBeYq7bLUt/vxzIw0LJeyrcbZGXJDDPLNiXbouMg9q3bQ5GnJe59iLIWUuaKmMDy2K2
         VO9A==
X-Gm-Message-State: AFqh2kp6FAXrxYGGYO4K8h76afwpSpGwd2VIDxIzm7xFFZarxIcFg9Gr
        IAmBH/VVcU2DB+wexaSGQ4IUDdDwLxm7cy90zl2kFg==
X-Google-Smtp-Source: AMrXdXtbS8t0WUNY/yuUDAEM1jilXchXdz1r91FY/x/9hH1r2rIytkiHvHyCw8syVvHeKG5Q7YxYTsWLZuKsfH75/Dk=
X-Received: by 2002:aa7:85c3:0:b0:582:e4ec:d72e with SMTP id
 z3-20020aa785c3000000b00582e4ecd72emr1756424pfn.3.1673304691813; Mon, 09 Jan
 2023 14:51:31 -0800 (PST)
MIME-Version: 1.0
References: <20230103190314.3882177-1-jeffxu@google.com> <20230103190314.3882177-2-jeffxu@google.com>
 <CABXOdTdf=0C3G4C4CTwAvx3wUQ1RZ_tFuO40LUQMDHCZr7wZmQ@mail.gmail.com>
 <CALmYWFv2H95EuEzCHrs76L3nT39A_UbdHNqUBrQ3PdnLtXfOvw@mail.gmail.com>
 <CABXOdTfzyAx1Nzg_D+EQzn9EV9jyrmAFhU0HEcw5A5a8iV49Zg@mail.gmail.com> <9ff9997d-f2f2-bb72-9993-132d3c45ae32@digikod.net>
In-Reply-To: <9ff9997d-f2f2-bb72-9993-132d3c45ae32@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Mon, 9 Jan 2023 14:50:53 -0800
Message-ID: <CALmYWFuGGwSXkahtZ3OFwUzbJ4n00gvLtPyNVOPiK6iHsoP93g@mail.gmail.com>
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

On Mon, Jan 9, 2023 at 7:29 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
> Looks good and agree with Guenter's suggestions
>
> On 04/01/2023 04:40, Guenter Roeck wrote:
> > On Tue, Jan 3, 2023 at 3:50 PM Jeff Xu <jeffxu@google.com> wrote:
> >>
> >> Thanks for the comments.
> >> I agree with most comments, but need Michael to chime in/confirm on be=
low:
> >>
> >> On Tue, Jan 3, 2023 at 12:12 PM Guenter Roeck <groeck@google.com> wrot=
e:
> >>>
> >>> On Tue, Jan 3, 2023 at 11:03 AM <jeffxu@chromium.org> wrote:
> >>>>
> >>>> From: Jeff Xu <jeffxu@google.com>
> >>>>
> >>>> Add check for yama setting for ptrace_test.
> >>>>
> >>>> Signed-off-by: Jeff Xu <jeffxu@google.com>
> >>>> ---
> >>>>   .../testing/selftests/landlock/ptrace_test.c  | 48 +++++++++++++++=
+---
> >>>>   1 file changed, 42 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/=
testing/selftests/landlock/ptrace_test.c
> >>>> index c28ef98ff3ac..379f5ddf6c3f 100644
> >>>> --- a/tools/testing/selftests/landlock/ptrace_test.c
> >>>> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> >>>> @@ -60,6 +60,23 @@ static int test_ptrace_read(const pid_t pid)
> >>>>          return 0;
> >>>>   }
> >>>>
> >>>> +static int get_yama_ptrace_scope(void)
> >>>> +{
> >>>> +       int ret =3D -1;
> >>>
> >>> Unnecessary initialization
> >>>
> >>>> +       char buf[2] =3D {};
> >>>
> >>> Unnecessary initialization
> >>>
> >> buf was used later by atoi(), and atoi needs a string, because the
> >> function only reads one byte in read(),
> >> so it needs to add buf[1] =3D '\0'. In V2, there was a comment  to
> >> change the buf[1] =3D '\0' to char buf[2] =3D {},
> >> my understanding is that the compiler is smart enough and will
> >> optimize the initialization to write 0 on the
> >> memory  (since this is char and length is 2, and less then the size of=
 int)
> >>
> >
> > Good point.
> >
> > Guenter
>
> Looks good to me with the other suggestions applied.
>
>
> >
> >>>> +       int fd =3D open("/proc/sys/kernel/yama/ptrace_scope", O_RDON=
LY);
> >>>> +
> >>>> +       if (fd < 0)
> >>>> +               return 0;
> >>>> +
> >>>> +       if (read(fd, &buf, 1) < 0)
> >>>
> >>> buf is an array, & is thus unnecessary. Also, if the file is empty,
> >>> the return value would be 0.
> >>>
> >>>> +               return -1;
> >>>
> >>> leaking file descriptor
> >>>
> >>>> +
> >>>> +       ret =3D atoi(buf);
> >>>> +       close(fd);
> >>>> +       return ret;
> >>>> +}
> >>>> +
> >>>>   /* clang-format off */
> >>>>   FIXTURE(hierarchy) {};
> >>>>   /* clang-format on */
> >>>> @@ -232,8 +249,20 @@ TEST_F(hierarchy, trace)
> >>>>          pid_t child, parent;
> >>>>          int status, err_proc_read;
> >>>>          int pipe_child[2], pipe_parent[2];
> >>>> +       int yama_ptrace_scope;
> >>>>          char buf_parent;
> >>>>          long ret;
> >>>> +       bool can_trace_child, can_trace_parent;
> >>>> +
> >>>> +       yama_ptrace_scope =3D get_yama_ptrace_scope();
> >>>> +       ASSERT_LE(0, yama_ptrace_scope);
> >>>> +
> >>>> +       if (yama_ptrace_scope >=3D 3)
> >>>> +               SKIP(return, "Yama forbids any ptrace use (scope %d)=
",
> >>>> +                          yama_ptrace_scope);
> >>>> +
> >>>> +       can_trace_child =3D !variant->domain_parent && (yama_ptrace_=
scope < 2);
> >>>> +       can_trace_parent =3D !variant->domain_child && (yama_ptrace_=
scope < 1);
> >>>>
> >>>
> >>> Unnecessary ( ).
> >>>
> >>> It is difficult to understand the context. yama_ptrace_scope =3D=3D 2=
 is
> >>> YAMA_SCOPE_CAPABILITY, and yama_ptrace_scope =3D=3D 1 is
> >>> YAMA_SCOPE_RELATIONAL. I for my part have no idea how that relates to
> >>> child/parent permissions. Also, I have no idea why the negation
> >>> (can_trace_child =3D !variant->domain_parent) is necessary, and what =
its
> >>> functional impact might be. Someone else will have to chime in here.
> >>>
> >> I will copy the definition of the constant definition from yama_lsm.c
> >> But I agree this code is difficult to understand, I'm now lost on why
> >> we need the negation too.
> >>
Hi Micka=C3=ABl

Can you check the above comment please ?
I also find it difficult to understand how can_trace_child is set.

On this line:
can_trace_child =3D !variant->domain_parent &&
  yama_ptrace_scope < 2;

it translates to
can_trace_child is true when 1> && 2>
1> when parent process don't have landlock policy
2> yama_ptrace_scope =3D 0 or 1.

My question is:
When the parent process has a landlock policy, and 2 is true,
the parent can also trace the child process, right ?
So 1> is not necessary in theory ?

As reference:  the latest code (after updating the rest of comments in V7)
can be found at patchset 8 of
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
4084253

Thanks
Jeff

> >>>>          /*
> >>>>           * Removes all effective and permitted capabilities to not =
interfere
> >>>> @@ -258,6 +287,7 @@ TEST_F(hierarchy, trace)
> >>>>
> >>>>                  ASSERT_EQ(0, close(pipe_parent[1]));
> >>>>                  ASSERT_EQ(0, close(pipe_child[0]));
> >>>> +
> >>>
> >>> Unnecessary whitespace change
> >>>
> >>>>                  if (variant->domain_child)
> >>>
> >>> Why not change this code ?
> >>>
> >>>>                          create_domain(_metadata);
> >>>>
> >> create_domain actually applies the landlocked policy to the
> >> (child/parent) process.
> >> This is part of the setup of the testcase, so it is needed.
> >>
> >>
> >>>> @@ -267,7 +297,7 @@ TEST_F(hierarchy, trace)
> >>>>                  /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the =
parent. */
> >>>>                  err_proc_read =3D test_ptrace_read(parent);
> >>>>                  ret =3D ptrace(PTRACE_ATTACH, parent, NULL, 0);
> >>>> -               if (variant->domain_child) {
> >>>> +               if (!can_trace_parent) {
> >>>>                          EXPECT_EQ(-1, ret);
> >>>>                          EXPECT_EQ(EPERM, errno);
> >>>>                          EXPECT_EQ(EACCES, err_proc_read);
> >>>> @@ -283,7 +313,7 @@ TEST_F(hierarchy, trace)
> >>>>
> >>>>                  /* Tests child PTRACE_TRACEME. */
> >>>>                  ret =3D ptrace(PTRACE_TRACEME);
> >>>> -               if (variant->domain_parent) {
> >>>> +               if (!can_trace_child) {
> >>>>                          EXPECT_EQ(-1, ret);
> >>>>                          EXPECT_EQ(EPERM, errno);
> >>>>                  } else {
> >>>> @@ -296,12 +326,12 @@ TEST_F(hierarchy, trace)
> >>>>                   */
> >>>>                  ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> >>>>
> >>>> -               if (!variant->domain_parent) {
> >>>> +               if (can_trace_child)
> >>>>                          ASSERT_EQ(0, raise(SIGSTOP));
> >>>> -               }
> >>>>
> >>>>                  /* Waits for the parent PTRACE_ATTACH test. */
> >>>>                  ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> >>>> +
> >>>
> >>> Unnecessary whitespace change
> >>>
> >>>>                  _exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILU=
RE);
> >>>>                  return;
> >>>>          }
> >>>> @@ -321,7 +351,7 @@ TEST_F(hierarchy, trace)
> >>>>          ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
> >>>>
> >>>>          /* Tests child PTRACE_TRACEME. */
> >>>> -       if (!variant->domain_parent) {
> >>>> +       if (can_trace_child) {
> >>>>                  ASSERT_EQ(child, waitpid(child, &status, 0));
> >>>>                  ASSERT_EQ(1, WIFSTOPPED(status));
> >>>>                  ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0))=
;
> >>>> @@ -334,7 +364,7 @@ TEST_F(hierarchy, trace)
> >>>>          /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. *=
/
> >>>>          err_proc_read =3D test_ptrace_read(child);
> >>>>          ret =3D ptrace(PTRACE_ATTACH, child, NULL, 0);
> >>>> -       if (variant->domain_parent) {
> >>>> +       if (!can_trace_child) {
> >>>>                  EXPECT_EQ(-1, ret);
> >>>>                  EXPECT_EQ(EPERM, errno);
> >>>>                  EXPECT_EQ(EACCES, err_proc_read);
> >>>> @@ -350,10 +380,16 @@ TEST_F(hierarchy, trace)
> >>>>
> >>>>          /* Signals that the parent PTRACE_ATTACH test is done. */
> >>>>          ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> >>>> +
> >>>
> >>> Unnecessary whitespace change
> >>>
> >>>>          ASSERT_EQ(child, waitpid(child, &status, 0));
> >>>>          if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> >>>>              WEXITSTATUS(status) !=3D EXIT_SUCCESS)
> >>>>                  _metadata->passed =3D 0;
> >>>> +
> >>>> +       if (yama_ptrace_scope > 0)
> >>>> +               SKIP(return,
> >>>> +                          "Incomplete tests due to Yama restriction=
s (scope %d)",
> >>>> +                          yama_ptrace_scope);
> >>>>   }
> >>>>
> >>>>   TEST_HARNESS_MAIN
> >>>> --
> >>>> 2.39.0.314.g84b9a713c41-goog
> >>>>

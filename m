Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27200C3DA7D
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Jan 2023 23:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbjACXuM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Jan 2023 18:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237861AbjACXuL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Jan 2023 18:50:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E4813F26
        for <linux-security-module@vger.kernel.org>; Tue,  3 Jan 2023 15:50:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 60-20020a17090a0fc200b002264ebad204so11102313pjz.1
        for <linux-security-module@vger.kernel.org>; Tue, 03 Jan 2023 15:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YrkDxrB1ZsObfaGLcNvq1Cq4y8JdHutjst2B41HaInQ=;
        b=h0i2lSCzomrUfFv1GsxmnjO7InN+anI8QPBSeq8BdEviQYV5SipXOJTrN3LsaKEMiJ
         BODyKxEeOKgG4F0brrbZlk1WyJUhw2rK15WohkHu4aFOygW7S2xFBzElKHyi6VcqzTED
         thQNhVd0UFMDdxEATV9Yf4rLm8Xg7lCaiBu/8VwVDqmY30Vy2FqSDHYcYmm15fhmoDS2
         eE7fkYdXO3nyebYCZkvW4+TXoAlgjS/0go5Tls1Ih6LXDgFa96ksZ56HFF/vlaukhXNU
         Fq5FMMgrHo0BG0/86c2llz2+aGA/oDcUH02mPuoB2uIWJfOeHlBUaM/Sh81oxEMMyRNk
         kzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrkDxrB1ZsObfaGLcNvq1Cq4y8JdHutjst2B41HaInQ=;
        b=h/y1WqL9Kq/nPyrx1r5ar3TPm4tJWxWBIeEDS5cg4eDcFb4ha+V4vxuGHSZ5hoAXHG
         vU7KXeJHn6rTcHpDfEE7A0ijjaMHs15r5eRe2H7E2YGEUKtJkFrTtk90wRzyd4a9WmIo
         oRBpdjnJqnfZzx7n6WjbmIhMq2pZbEtCV6Y6Iz/8itPU5+J2XO9Az4caO0AIfVi1r7Ft
         XBqdHHC0AwdeRYf8+5BFaJd/SPF9u7ODqPxAG9lJjCS+HmUI+ub6EOXSJFfW1lwuLr2h
         K8ElIXrLLKI+UfMKQdQPZzsU29dTWPpb2FI0iOuvko3cc1GU9kf1HgoVMfjpCHNPkpdO
         596g==
X-Gm-Message-State: AFqh2koQWbbPx4K+sSapLDwOKjT/iz6rRTElttwyVN5+l+eF46+rKW6o
        PPU8n0ftsB3y01tfot+R4dw4qMcVKmLVo08XwAm04w==
X-Google-Smtp-Source: AMrXdXs5Oz7sBpdLhMNthlLHRSpVU5ZUHdlPja+9WRlbpW8srr3Ugu46wA5aOjT2XE9pzYhBakvvkRYxr4okXOwGX0Y=
X-Received: by 2002:a17:902:b70c:b0:192:6b66:e2c with SMTP id
 d12-20020a170902b70c00b001926b660e2cmr1588276pls.112.1672789808642; Tue, 03
 Jan 2023 15:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20230103190314.3882177-1-jeffxu@google.com> <20230103190314.3882177-2-jeffxu@google.com>
 <CABXOdTdf=0C3G4C4CTwAvx3wUQ1RZ_tFuO40LUQMDHCZr7wZmQ@mail.gmail.com>
In-Reply-To: <CABXOdTdf=0C3G4C4CTwAvx3wUQ1RZ_tFuO40LUQMDHCZr7wZmQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 3 Jan 2023 15:49:31 -0800
Message-ID: <CALmYWFv2H95EuEzCHrs76L3nT39A_UbdHNqUBrQ3PdnLtXfOvw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] selftests/landlock: skip ptrace_test according to YAMA
To:     Guenter Roeck <groeck@google.com>
Cc:     jeffxu@chromium.org, mic@digikod.net, jorgelo@chromium.org,
        keescook@chromium.org, linux-security-module@vger.kernel.org,
        groeck@chromium.org, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks for the comments.
I agree with most comments, but need Michael to chime in/confirm on below:

On Tue, Jan 3, 2023 at 12:12 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Tue, Jan 3, 2023 at 11:03 AM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@google.com>
> >
> > Add check for yama setting for ptrace_test.
> >
> > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > ---
> >  .../testing/selftests/landlock/ptrace_test.c  | 48 ++++++++++++++++---
> >  1 file changed, 42 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> > index c28ef98ff3ac..379f5ddf6c3f 100644
> > --- a/tools/testing/selftests/landlock/ptrace_test.c
> > +++ b/tools/testing/selftests/landlock/ptrace_test.c
> > @@ -60,6 +60,23 @@ static int test_ptrace_read(const pid_t pid)
> >         return 0;
> >  }
> >
> > +static int get_yama_ptrace_scope(void)
> > +{
> > +       int ret = -1;
>
> Unnecessary initialization
>
> > +       char buf[2] = {};
>
> Unnecessary initialization
>
buf was used later by atoi(), and atoi needs a string, because the
function only reads one byte in read(),
so it needs to add buf[1] = '\0'. In V2, there was a comment  to
change the buf[1] = '\0' to char buf[2] = {},
my understanding is that the compiler is smart enough and will
optimize the initialization to write 0 on the
memory  (since this is char and length is 2, and less then the size of int)

> > +       int fd = open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
> > +
> > +       if (fd < 0)
> > +               return 0;
> > +
> > +       if (read(fd, &buf, 1) < 0)
>
> buf is an array, & is thus unnecessary. Also, if the file is empty,
> the return value would be 0.
>
> > +               return -1;
>
> leaking file descriptor
>
> > +
> > +       ret = atoi(buf);
> > +       close(fd);
> > +       return ret;
> > +}
> > +
> >  /* clang-format off */
> >  FIXTURE(hierarchy) {};
> >  /* clang-format on */
> > @@ -232,8 +249,20 @@ TEST_F(hierarchy, trace)
> >         pid_t child, parent;
> >         int status, err_proc_read;
> >         int pipe_child[2], pipe_parent[2];
> > +       int yama_ptrace_scope;
> >         char buf_parent;
> >         long ret;
> > +       bool can_trace_child, can_trace_parent;
> > +
> > +       yama_ptrace_scope = get_yama_ptrace_scope();
> > +       ASSERT_LE(0, yama_ptrace_scope);
> > +
> > +       if (yama_ptrace_scope >= 3)
> > +               SKIP(return, "Yama forbids any ptrace use (scope %d)",
> > +                          yama_ptrace_scope);
> > +
> > +       can_trace_child = !variant->domain_parent && (yama_ptrace_scope < 2);
> > +       can_trace_parent = !variant->domain_child && (yama_ptrace_scope < 1);
> >
>
> Unnecessary ( ).
>
> It is difficult to understand the context. yama_ptrace_scope == 2 is
> YAMA_SCOPE_CAPABILITY, and yama_ptrace_scope == 1 is
> YAMA_SCOPE_RELATIONAL. I for my part have no idea how that relates to
> child/parent permissions. Also, I have no idea why the negation
> (can_trace_child = !variant->domain_parent) is necessary, and what its
> functional impact might be. Someone else will have to chime in here.
>
I will copy the definition of the constant definition from yama_lsm.c
But I agree this code is difficult to understand, I'm now lost on why
we need the negation too.

> >         /*
> >          * Removes all effective and permitted capabilities to not interfere
> > @@ -258,6 +287,7 @@ TEST_F(hierarchy, trace)
> >
> >                 ASSERT_EQ(0, close(pipe_parent[1]));
> >                 ASSERT_EQ(0, close(pipe_child[0]));
> > +
>
> Unnecessary whitespace change
>
> >                 if (variant->domain_child)
>
> Why not change this code ?
>
> >                         create_domain(_metadata);
> >
create_domain actually applies the landlocked policy to the
(child/parent) process.
This is part of the setup of the testcase, so it is needed.


> > @@ -267,7 +297,7 @@ TEST_F(hierarchy, trace)
> >                 /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
> >                 err_proc_read = test_ptrace_read(parent);
> >                 ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
> > -               if (variant->domain_child) {
> > +               if (!can_trace_parent) {
> >                         EXPECT_EQ(-1, ret);
> >                         EXPECT_EQ(EPERM, errno);
> >                         EXPECT_EQ(EACCES, err_proc_read);
> > @@ -283,7 +313,7 @@ TEST_F(hierarchy, trace)
> >
> >                 /* Tests child PTRACE_TRACEME. */
> >                 ret = ptrace(PTRACE_TRACEME);
> > -               if (variant->domain_parent) {
> > +               if (!can_trace_child) {
> >                         EXPECT_EQ(-1, ret);
> >                         EXPECT_EQ(EPERM, errno);
> >                 } else {
> > @@ -296,12 +326,12 @@ TEST_F(hierarchy, trace)
> >                  */
> >                 ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> >
> > -               if (!variant->domain_parent) {
> > +               if (can_trace_child)
> >                         ASSERT_EQ(0, raise(SIGSTOP));
> > -               }
> >
> >                 /* Waits for the parent PTRACE_ATTACH test. */
> >                 ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> > +
>
> Unnecessary whitespace change
>
> >                 _exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
> >                 return;
> >         }
> > @@ -321,7 +351,7 @@ TEST_F(hierarchy, trace)
> >         ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
> >
> >         /* Tests child PTRACE_TRACEME. */
> > -       if (!variant->domain_parent) {
> > +       if (can_trace_child) {
> >                 ASSERT_EQ(child, waitpid(child, &status, 0));
> >                 ASSERT_EQ(1, WIFSTOPPED(status));
> >                 ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
> > @@ -334,7 +364,7 @@ TEST_F(hierarchy, trace)
> >         /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. */
> >         err_proc_read = test_ptrace_read(child);
> >         ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
> > -       if (variant->domain_parent) {
> > +       if (!can_trace_child) {
> >                 EXPECT_EQ(-1, ret);
> >                 EXPECT_EQ(EPERM, errno);
> >                 EXPECT_EQ(EACCES, err_proc_read);
> > @@ -350,10 +380,16 @@ TEST_F(hierarchy, trace)
> >
> >         /* Signals that the parent PTRACE_ATTACH test is done. */
> >         ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> > +
>
> Unnecessary whitespace change
>
> >         ASSERT_EQ(child, waitpid(child, &status, 0));
> >         if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> >             WEXITSTATUS(status) != EXIT_SUCCESS)
> >                 _metadata->passed = 0;
> > +
> > +       if (yama_ptrace_scope > 0)
> > +               SKIP(return,
> > +                          "Incomplete tests due to Yama restrictions (scope %d)",
> > +                          yama_ptrace_scope);
> >  }
> >
> >  TEST_HARNESS_MAIN
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >

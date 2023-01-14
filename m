Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFEBC54EBE
	for <linux-security-module@archiver.kernel.org>; Sat, 14 Jan 2023 02:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjANCD0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Jan 2023 21:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjANCDZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Jan 2023 21:03:25 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44B18B52D
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jan 2023 18:03:23 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c26so12983498pfp.10
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jan 2023 18:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwgAKeOI7A94Xvi9KexBt8/SPzPdsMO8DHg2D1kLGHY=;
        b=Wd/cV9Ee2etY3+vKpdQLsp0EyKpitmvJsKWXpEudjiKn3LvJhM40F+YeADF9qf4bv+
         0elGOYZJGnAUhAAXJEK0N29GlvULHG/6xDPvpbTafnIQ0kS6FcpnodS+BTpZbmGuNNFV
         7Pe9oGnaeYXElcg8X8aUi/FSMy84kAhd4WnwXiCscYMCaW9aBHKmSlJjSWrKgx2E2kEv
         f6R0wBrwAnBvTCZrr0DBSJqT1ZymJm9Jk77/ZWQIZ8V/es1bHSQZ6MFeX8Cd8szLwjFK
         3XMaA6yLxhWTdKSk2L3tQhH+Pu32jlpBvcql3bDZWQg66Z+DdH4+42VggmcE2osXUlZM
         NtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwgAKeOI7A94Xvi9KexBt8/SPzPdsMO8DHg2D1kLGHY=;
        b=BDQXtgcvlLLRBXQV+u179mTGZEDwFOap3dsMhmL0Xes0jJwTtWLX3qCpTnwfXb0if0
         oND73dHTNXSV/8XlZq0U/cfcCDMH+VQMYLWtGJ1tCwTEYwi5mwkJSxORWO8iEC1CfY+f
         9bKvjSF4290QhIL0+KSikIAqtnFT7jWkuZ+3jQlU/BxLCZCeIB/ZzjPwWVwQGS/eY8WM
         THG+NRBX1Fv4cBeAD2CnM2WLpz3AvdA3JJ3XtIBDwYwks9LPklcNoBta3x36H2OCGcsz
         ag0Hvz8wrC9kDmugLD9IhbxMcxYaEb19bk3eCeyEofckAqNaeDtoKimaOCGWOCsiUOiH
         qyEQ==
X-Gm-Message-State: AFqh2krMRI0k9vUuCF+p0r+QC2z3KTCnh4MVZAuNMEL+fr7KU86oCU5O
        HKtnnJHkl6xo0LU8RCS5P9PGiYE0GTgQn3qdo0jIzITTGVwI95HM
X-Google-Smtp-Source: AMrXdXspl8aZUAQzxsCEqiGHtZYnVMD7GW82WymHFqiUMI8DIxt+G8N7TlkapPrn+BA/CzoKpLOUxz3z1Vcc5tz7aZo=
X-Received: by 2002:a63:180c:0:b0:479:3a88:5e0 with SMTP id
 y12-20020a63180c000000b004793a8805e0mr4040987pgl.466.1673661802672; Fri, 13
 Jan 2023 18:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20230113050755.1277736-2-jeffxu@google.com> <20230113175308.50900-1-mic@digikod.net>
 <2985dea2-e9ac-2416-3065-0713723f6280@digikod.net>
In-Reply-To: <2985dea2-e9ac-2416-3065-0713723f6280@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 13 Jan 2023 18:02:44 -0800
Message-ID: <CALmYWFs2bJBqWvt7pu4e=U=55J36WLdaLLgiv+ZmrZWRJE5KCg@mail.gmail.com>
Subject: Re: [PATCH] selftests/landlock: Improve ptrace_test with Yama
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     gnoack@google.com, groeck@chromium.org, jorgelo@chromium.org,
        keescook@chromium.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Done.
Thank you for double checking the read operation.
The test case is more complete with that.
-Jeff

On Fri, Jan 13, 2023 at 10:12 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
>
>
> On 13/01/2023 18:53, Micka=C3=ABl Sala=C3=BCn wrote:
> > I found some issues running this new ptrace_test. Indeed, Yama doesn't
> > restrict PTRACE_MODE_READ whereas Landlock does. I also changed some
> > comments and socpe conditions. In fact, the final SKIP() wasn't a good
> > idea because it masks such potential errors; let's only use a log
> > message instead. I also removed the first SKIP() because we want
> > everything to be tested, and the MODE_READ does still matter anyway.
> >
> > Please review this patch and squash it in yours.
> >
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20230113175308.50900-1-mic@digikod.net
> > ---
> >   .../testing/selftests/landlock/ptrace_test.c  | 106 ++++++++++-------=
-
> >   1 file changed, 57 insertions(+), 49 deletions(-)
> >
> > diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/tes=
ting/selftests/landlock/ptrace_test.c
> > index c9d9f3001d0f..3c3ba37bf8ec 100644
> > --- a/tools/testing/selftests/landlock/ptrace_test.c
> > +++ b/tools/testing/selftests/landlock/ptrace_test.c
> > @@ -19,7 +19,7 @@
> >
> >   #include "common.h"
> >
> > -/* copy from yama_lsm.c */
> > +/* Copied from security/yama/yama_lsm.c */
> >   #define YAMA_SCOPE_DISABLED 0
> >   #define YAMA_SCOPE_RELATIONAL 1
> >   #define YAMA_SCOPE_CAPABILITY 2
> > @@ -70,7 +70,7 @@ static int get_yama_ptrace_scope(void)
> >   {
> >       int ret;
> >       char buf[2] =3D {};
> > -     int fd =3D open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
> > +     const int fd =3D open("/proc/sys/kernel/yama/ptrace_scope", O_RDO=
NLY);
> >
> >       if (fd < 0)
> >               return 0;
> > @@ -260,46 +260,48 @@ TEST_F(hierarchy, trace)
> >       int yama_ptrace_scope;
> >       char buf_parent;
> >       long ret;
> > -     bool can_trace_child, can_trace_parent;
> > +     bool can_read_child, can_trace_child, can_read_parent, can_trace_=
parent;
> >
> >       yama_ptrace_scope =3D get_yama_ptrace_scope();
> >       ASSERT_LE(0, yama_ptrace_scope);
> >
> > -     if (yama_ptrace_scope >=3D YAMA_SCOPE_NO_ATTACH)
> > -             SKIP(return, "Yama forbids any ptrace use (scope %d)",
> > -                        yama_ptrace_scope);
> > +     if (yama_ptrace_scope > YAMA_SCOPE_DISABLED)
> > +             TH_LOG("Incomplete tests due to Yama restrictions (scope =
%d)",
> > +                    yama_ptrace_scope);
> >
> >       /*
> > -      * can_trace_child: if a parent process can trace its child proce=
ss.
> > -      *
> > -      * There are two conditions concerning landlock:
> > -      * 1> the parent and child processes are in the same landlock dom=
ain or
> > -      *      one beneath it (case: domain_both =3D true).
> > -      * 2> yama allows tracing children (up to YAMA_SCOPE_RELATIONAL).
> > -      * Both 1 and 2 need to be met for can_trace_child to be true.
> > -      *
> > -      * If a parent process has its own domain not shared with the chi=
ld
> > -      * process (case:domain_parent =3D true), then the parent can't t=
race the
> > -      * child.
> > +      * can_read_child is true if a parent process can read its child
> > +      * process, which is only the case when the parent process is not
> > +      * isolated from the child with a dedicated Landlock domain.
> >        */
> > -     can_trace_child =3D !variant->domain_parent &&
> > -                       yama_ptrace_scope < YAMA_SCOPE_CAPABILITY;
> > +     can_read_child =3D !variant->domain_parent;
> >
> >       /*
> > -      * can_trace_parent: if a child process can trace its parent proc=
ess.
> > -      *
> > -      * There are two conditions concerning landlock:
> > -      * 1> the parent and child process are in the same landlock domai=
n or
> > -      *      one beneath it.(case: domain_both =3D true).
> > -      * 2> yama is disabled (YAMA_SCOPE_DISABLED).
> > -      * Both 1 and 2 need to be met for can_trace_parent to be true.
> > -      *
> > -      * If a child process has its own domain not shared with the pare=
nt
> > -      * process (case:domain_child =3D true, then the child can't trac=
e the
> > -      * parent.
> > +      * can_trace_child is true if a parent process can trace its chil=
d
> > +      * process.  This depends on two conditions:
> > +      * - The parent process is not isolated from the child with a ded=
icated
> > +      *   Landlock domain.
> > +      * - Yama allows tracing children (up to YAMA_SCOPE_RELATIONAL).
> >        */
> > -     can_trace_parent =3D !variant->domain_child &&
> > -                        yama_ptrace_scope < YAMA_SCOPE_RELATIONAL;
> > +     can_trace_child =3D can_read_child &&
> > +                       yama_ptrace_scope <=3D YAMA_SCOPE_RELATIONAL;
> > +
> > +     /*
> > +      * can_read_parent is true if a child process can read its parent
> > +      * process, which is only the case when the child process is not
> > +      * isolated from the parent with a dedicated Landlock domain.
> > +      */
> > +     can_read_parent =3D !variant->domain_child;
> > +
> > +     /*
> > +      * can_trace_parent is true if a child process can trace its pare=
nt
> > +      * process.  This depends on two conditions:
> > +      * - The child process is not isolated from the parent with a ded=
icated
> > +      *   Landlock domain.
> > +      * - Yama is disabled (YAMA_SCOPE_DISABLED).
> > +      */
> > +     can_trace_parent =3D can_read_parent &&
> > +                        yama_ptrace_scope <=3D YAMA_SCOPE_DISABLED;
> >
> >       /*
> >        * Removes all effective and permitted capabilities to not interf=
ere
> > @@ -330,16 +332,21 @@ TEST_F(hierarchy, trace)
> >               /* Waits for the parent to be in a domain, if any. */
> >               ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> >
> > -             /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent=
. */
> > +             /* Tests PTRACE_MODE_READ on the parent. */
> >               err_proc_read =3D test_ptrace_read(parent);
> > +             if (can_read_parent) {
> > +                     EXPECT_EQ(0, err_proc_read);
> > +             } else {
> > +                     EXPECT_EQ(EACCES, err_proc_read);
> > +             }
> > +
> > +             /* Tests PTRACE_ATTACH on the parent. */
> >               ret =3D ptrace(PTRACE_ATTACH, parent, NULL, 0);
> > -             if (!can_trace_parent) {
> > +             if (can_trace_parent) {
> > +                     EXPECT_EQ(0, ret);
> > +             } else {
> >                       EXPECT_EQ(-1, ret);
> >                       EXPECT_EQ(EPERM, errno);
> > -                     EXPECT_EQ(EACCES, err_proc_read);
> > -             } else {
> > -                     EXPECT_EQ(0, ret);
> > -                     EXPECT_EQ(0, err_proc_read);
> >               }
> >               if (ret =3D=3D 0) {
> >                       ASSERT_EQ(parent, waitpid(parent, &status, 0));
> > @@ -349,11 +356,11 @@ TEST_F(hierarchy, trace)
> >
> >               /* Tests child PTRACE_TRACEME. */
> >               ret =3D ptrace(PTRACE_TRACEME);
> > -             if (!can_trace_child) {
> > +             if (can_trace_child) {
> > +                     EXPECT_EQ(0, ret);
> > +             } else {
> >                       EXPECT_EQ(-1, ret);
> >                       EXPECT_EQ(EPERM, errno);
> > -             } else {
> > -                     EXPECT_EQ(0, ret);
> >               }
> >
> >               /*
> > @@ -396,17 +403,23 @@ TEST_F(hierarchy, trace)
> >               EXPECT_EQ(ESRCH, errno);
> >       }
> >
> > -     /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. */
> > +     /* Tests PTRACE_MODE_READ on the child. */
> >       err_proc_read =3D test_ptrace_read(child);
> > +     if (can_read_child) {
> > +             EXPECT_EQ(0, err_proc_read);
> > +     } else {
> > +             EXPECT_EQ(EACCES, err_proc_read);
> > +     }
> > +
> > +     /* Tests PTRACE_ATTACH on the child. */
> >       ret =3D ptrace(PTRACE_ATTACH, child, NULL, 0);
> >       if (!can_trace_child) {
>
> I forgot to inverse the !can_trace_child condition to make it more
> consistent with the rest. Please update it for your next patch.
>
>
> >               EXPECT_EQ(-1, ret);
> >               EXPECT_EQ(EPERM, errno);
> > -             EXPECT_EQ(EACCES, err_proc_read);
> >       } else {
> >               EXPECT_EQ(0, ret);
> > -             EXPECT_EQ(0, err_proc_read);
> >       }
> > +
> >       if (ret =3D=3D 0) {
> >               ASSERT_EQ(child, waitpid(child, &status, 0));
> >               ASSERT_EQ(1, WIFSTOPPED(status));
> > @@ -419,11 +432,6 @@ TEST_F(hierarchy, trace)
> >       if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> >           WEXITSTATUS(status) !=3D EXIT_SUCCESS)
> >               _metadata->passed =3D 0;
> > -
> > -     if (yama_ptrace_scope > 0)
> > -             SKIP(return,
> > -                        "Incomplete tests due to Yama restrictions (sc=
ope %d)",
> > -                        yama_ptrace_scope);
> >   }
> >
> >   TEST_HARNESS_MAIN

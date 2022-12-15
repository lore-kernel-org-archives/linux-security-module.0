Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC3CC4332F
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Dec 2022 20:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiLOUes (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Dec 2022 15:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLOUer (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Dec 2022 15:34:47 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16FC25C8
        for <linux-security-module@vger.kernel.org>; Thu, 15 Dec 2022 12:34:46 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q71so398835pgq.8
        for <linux-security-module@vger.kernel.org>; Thu, 15 Dec 2022 12:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/uvsRpfxFN7h8ykssYfZlHDov5Ddd0DeBoCdvqzcnk=;
        b=aXMNp//DplymB/dkZP2WyXjWa8+BuAHF20iyqp7aNJjamx7vxkoM1Bpiur1DV6ep4b
         RA+Zxa/MDPeMnAaY5WJFx5RU6a1+gR1iKnxLXs7ZVmvZum4Od3qpbyQMe7ApjIZHg1xZ
         tpV/LN+DvlL+5Q2iZPJIZNXBQ177Pzz3ReiFR/qfSpMo6cS7Ke+tIsDdPd1JKzhJqVwJ
         hMqhFBVs24+bKCyG//QQkRocjZ+eHf7k1uP073fi7yijjRa2bOZFZQwoKY4fWjRGtqP4
         7onXrvOUYtOaHrXh2Oa8g5EKZT1xXzSlV5LL+Z6fmap5raRG3Fl7z++Urc0cBHYjzjqI
         0lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/uvsRpfxFN7h8ykssYfZlHDov5Ddd0DeBoCdvqzcnk=;
        b=yiAdkqrW4WtK9IouND2g3rTcI0oyMU4fhHHWYXEChNb5XkVMKKXvkQLYXWpGSDLa1C
         t6QSonpe2ZDElkg0HAH7mUWxy1bl//DjgnQTO3II8ugiuW9Mqyihz2JWY/bSgkUG9r9A
         Ud0OdSWoVaTsHbEsWc38IDhP8TBJJ7KP6kygxr+4/NY9ziZ1U8o9Eb8sZwM3n63INA/I
         2Mm/91z19SFqwqliALpKj6wJ9SWAEjlJ55Zl09IKZsjKkc7xzG4Cq5aOdANcaG7yqDDo
         2AXC6SNyxlQAkeSW2JJcvEdkpfOW2lutb+jzT5yyYtBpNg5MmrdPfwQYQP1kZgrHB1ky
         Wphg==
X-Gm-Message-State: ANoB5pkzeM3flLsmz/U7IMqRGG9LsVOZOFD0m8STTXproZ8FBH5hDe/Y
        BF+b63E0yD1cQ5X/uztHgEnZMwTiaMO8cOReX66AG5XB04hKeMJwxNU=
X-Google-Smtp-Source: AA0mqf75q6m1Vh8sr//Z7e6bRwq/tW8zYB9VPgEuJI/lGoVka9kW1rOQKVHUn0pRopiBL87j14BdLWuAo7jwg/vLkQg=
X-Received: by 2002:a63:5823:0:b0:479:3a88:5e0 with SMTP id
 m35-20020a635823000000b004793a8805e0mr901954pgb.466.1671136486043; Thu, 15
 Dec 2022 12:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20221213185816.3942853-1-jeffxu@chromium.org> <20221213185816.3942853-2-jeffxu@chromium.org>
 <43c925e3-ce72-3ba1-15cf-6fbb34c485f1@digikod.net>
In-Reply-To: <43c925e3-ce72-3ba1-15cf-6fbb34c485f1@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 15 Dec 2022 12:34:08 -0800
Message-ID: <CALmYWFurtUhVqibcPyBXF=pcWRDtDfe3HxMJRGKe29dEAOtVLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selftests/landlock: skip ptrace_test according to YAMA
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     jeffxu@chromium.org, jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Micka=C3=ABl
Thanks for reviewing.

On Thu, Dec 15, 2022 at 10:34 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
>
> This is much better! We can tailor a bit more the tests though.
>
> On 13/12/2022 19:58, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > Add check for yama setting for ptrace_test.
> >
> > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > ---
> >   .../testing/selftests/landlock/ptrace_test.c  | 34 ++++++++++++++++++=
+
> >   1 file changed, 34 insertions(+)
> >
> > diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/tes=
ting/selftests/landlock/ptrace_test.c
> > index c28ef98ff3ac..8565a25a9587 100644
> > --- a/tools/testing/selftests/landlock/ptrace_test.c
> > +++ b/tools/testing/selftests/landlock/ptrace_test.c
> > @@ -60,6 +60,24 @@ static int test_ptrace_read(const pid_t pid)
> >       return 0;
> >   }
> >
> > +static int get_ptrace_scope(void)
>
> Please rename to get_yama_ptrace_scope().
>
Done.

> > +{
> > +     int ret =3D -1;
> > +     char buf[2];
> > +     int fd =3D open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
> > +
> > +     if (fd < 0)
> > +             return 0;
> > +
> > +     if (read(fd, &buf, 1) < 0)
> > +             return -1;
> > +
> > +     buf[1] =3D '\0';
>
> You can replace that with `char buf[2] =3D {};`
>
Done.
The Compiler seems to be getting a lot smarter :) Thanks.

>
> > +     ret =3D atoi(buf);
> > +     close(fd);
> > +     return ret;
> > +}
> > +
> >   /* clang-format off */
> >   FIXTURE(hierarchy) {};
> >   /* clang-format on */
> > @@ -69,6 +87,7 @@ FIXTURE_VARIANT(hierarchy)
> >       const bool domain_both;
> >       const bool domain_parent;
> >       const bool domain_child;
> > +     const int  yama_value;
>
> Please rename to yama_ptrace_scope_max and remove the extra space.
>
why _max ?  yama_ptrace_scope_current is more proporate ?
FYI: This is the current sysctl setting.

> >   };
> >
> >   /*
> > @@ -93,6 +112,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_without_domain)=
 {
> >       .domain_both =3D false,
> >       .domain_parent =3D false,
> >       .domain_child =3D false,
> > +     .yama_value =3D 0,
> >   };
> >
> >   /*
> > @@ -110,6 +130,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_one_domai=
n) {
> >       .domain_both =3D false,
> >       .domain_parent =3D false,
> >       .domain_child =3D true,
> > +     .yama_value =3D 1,
> >   };
> >
> >   /*
> > @@ -126,6 +147,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_parent_dom=
ain) {
> >       .domain_both =3D false,
> >       .domain_parent =3D true,
> >       .domain_child =3D false,
> > +     .yama_value =3D 0,
> >   };
> >
> >   /*
> > @@ -143,6 +165,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_sibling_do=
main) {
> >       .domain_both =3D false,
> >       .domain_parent =3D true,
> >       .domain_child =3D true,
> > +     .yama_value =3D 2,
> >   };
> >
> >   /*
> > @@ -160,6 +183,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_sibling_domain=
) {
> >       .domain_both =3D true,
> >       .domain_parent =3D false,
> >       .domain_child =3D false,
> > +     .yama_value =3D 0,
> >   };
> >
> >   /*
> > @@ -178,6 +202,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_nested_do=
main) {
> >       .domain_both =3D true,
> >       .domain_parent =3D false,
> >       .domain_child =3D true,
> > +     .yama_value =3D 1,
> >   };
> >
> >   /*
> > @@ -196,6 +221,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_nested_and=
_parent_domain) {
> >       .domain_both =3D true,
> >       .domain_parent =3D true,
> >       .domain_child =3D false,
> > +     .yama_value =3D 0,
> >   };
> >
> >   /*
> > @@ -216,6 +242,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_dom=
ain) {
> >       .domain_both =3D true,
> >       .domain_parent =3D true,
> >       .domain_child =3D true,
> > +     .yama_value =3D 2,
> >   };
> >
> >   FIXTURE_SETUP(hierarchy)
> > @@ -232,9 +259,16 @@ TEST_F(hierarchy, trace)
> >       pid_t child, parent;
> >       int status, err_proc_read;
> >       int pipe_child[2], pipe_parent[2];
> > +     int yama;
>
> Please rename to yama_ptrace_scope.
>
Done.


>
> >       char buf_parent;
> >       long ret;
> >
> > +     yama =3D get_ptrace_scope();
> > +     ASSERT_LE(0, yama);
> > +
> > +     if (variant->yama_value < yama)
>
> if (yama_ptrace_scope >=3D 3)
>
> > +             SKIP(return, "unsupported yama value %d", yama);
>
> "Yama forbids any ptrace use (scope 3)"
>
>
why comparing with  3?  the test will  skip particular hierarchy,
according to current
sysctl yama_ptrace setting.

For example: when kernel.yama.ptrace_scope =3D 1 the result will be like:
localhost /usr/local/bin # ./ptrace_test
TAP version 13
1..8
# Starting 8 tests from 9 test cases.
#  RUN           hierarchy.allow_without_domain.trace ...
#      SKIP      unsupported yama value 1
#            OK  hierarchy.allow_without_domain.trace
ok 1 # SKIP unsupported yama value 1
#  RUN           hierarchy.allow_with_one_domain.trace ...
#            OK  hierarchy.allow_with_one_domain.trace
ok 2 hierarchy.allow_with_one_domain.trace
#  RUN           hierarchy.deny_with_parent_domain.trace ...
#      SKIP      unsupported yama value 1
#            OK  hierarchy.deny_with_parent_domain.trace
ok 3 # SKIP unsupported yama value 1
#  RUN           hierarchy.deny_with_sibling_domain.trace ...
#            OK  hierarchy.deny_with_sibling_domain.trace
ok 4 hierarchy.deny_with_sibling_domain.trace
#  RUN           hierarchy.allow_sibling_domain.trace ...
#      SKIP      unsupported yama value 1
#            OK  hierarchy.allow_sibling_domain.trace
ok 5 # SKIP unsupported yama value 1
#  RUN           hierarchy.allow_with_nested_domain.trace ...
#            OK  hierarchy.allow_with_nested_domain.trace
ok 6 hierarchy.allow_with_nested_domain.trace
#  RUN           hierarchy.deny_with_nested_and_parent_domain.trace ...
#      SKIP      unsupported yama value 1
#            OK  hierarchy.deny_with_nested_and_parent_domain.trace
ok 7 # SKIP unsupported yama value 1
#  RUN           hierarchy.deny_with_forked_domain.trace ...
#            OK  hierarchy.deny_with_forked_domain.trace
ok 8 hierarchy.deny_with_forked_domain.trace
# PASSED: 8 / 8 tests passed.
# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:4 error:0

when yama.ptrace_scope is 2:
localhost /usr/local/bin # sysctl kernel.yama.ptrace_scope=3D2
kernel.yama.ptrace_scope =3D 2
localhost /usr/local/bin # ./ptrace_test
TAP version 13
1..8
# Starting 8 tests from 9 test cases.
#  RUN           hierarchy.allow_without_domain.trace ...
#      SKIP      unsupported yama value 2
#            OK  hierarchy.allow_without_domain.trace
ok 1 # SKIP unsupported yama value 2
#  RUN           hierarchy.allow_with_one_domain.trace ...
#      SKIP      unsupported yama value 2
#            OK  hierarchy.allow_with_one_domain.trace
ok 2 # SKIP unsupported yama value 2
#  RUN           hierarchy.deny_with_parent_domain.trace ...
#      SKIP      unsupported yama value 2
#            OK  hierarchy.deny_with_parent_domain.trace
ok 3 # SKIP unsupported yama value 2
#  RUN           hierarchy.deny_with_sibling_domain.trace ...
#            OK  hierarchy.deny_with_sibling_domain.trace
ok 4 hierarchy.deny_with_sibling_domain.trace
#  RUN           hierarchy.allow_sibling_domain.trace ...
#      SKIP      unsupported yama value 2
#            OK  hierarchy.allow_sibling_domain.trace
ok 5 # SKIP unsupported yama value 2
#  RUN           hierarchy.allow_with_nested_domain.trace ...
#      SKIP      unsupported yama value 2
#            OK  hierarchy.allow_with_nested_domain.trace
ok 6 # SKIP unsupported yama value 2
#  RUN           hierarchy.deny_with_nested_and_parent_domain.trace ...
#      SKIP      unsupported yama value 2
#            OK  hierarchy.deny_with_nested_and_parent_domain.trace
ok 7 # SKIP unsupported yama value 2
#  RUN           hierarchy.deny_with_forked_domain.trace ...
#            OK  hierarchy.deny_with_forked_domain.trace
ok 8 hierarchy.deny_with_forked_domain.trace
# PASSED: 8 / 8 tests passed.
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:6 error:0

> This check skips the whole test, whereas the issues with Yama are about:
> - a child process tracing its parent;
> - the PTRACE_TRACEME case.
>
> I think the main remaining parts to change is the `if
> (variant->domain_*` checks to extend with the yama_ptrace_scope_max check=
.
>
> However, it is useful to highlight that a test didn't fully cover
> Landlock checks. I think the best approach is to call SKIP() at the end
> of TEST_F(hierarchy, trace) if yama_ptrace_scope >=3D 1 . This way, we
> test as much as possible (Landlock and Yama) and we mark the "tampered"
> tests as skipped.
>
I believe the test case should not have a lot of branches and logic
(if/else), which makes
the test case more complex and harder to read.  By that reason, SKIP()
is better at beginning
of the testcase.

Another reason is resource cleanup.  When SKIP() is not at the
beginning of tests,
the cleanup logic can get much more complicated because there are more
combinations of resource cleanup to
to be dealt with, after SKIP().

Therefore I do not believe in "tests as much as possible" in a single
test, I would rather have a
dedicated test for the situation.

Thoughts ?

>
> > +
> >       /*
> >        * Removes all effective and permitted capabilities to not interf=
ere
> >        * with cap_ptrace_access_check() in case of PTRACE_MODE_FSCREDS.

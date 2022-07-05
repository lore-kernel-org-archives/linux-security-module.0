Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4248BC433EF
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Jul 2022 21:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiGEVtt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Jul 2022 17:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiGEVts (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Jul 2022 17:49:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097385F73
        for <linux-security-module@vger.kernel.org>; Tue,  5 Jul 2022 14:49:48 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w185so8998671pfb.4
        for <linux-security-module@vger.kernel.org>; Tue, 05 Jul 2022 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tjX2w9M7EFtHsZFZhsx3c4SCQweNBQqkhUorHIIQxAQ=;
        b=HvXl6ClLvedc6raRJMhoNGimAYSs25KyzKad82UhTKWnzhCAy6nlXOgA1UQDZ1NrTV
         zPGWl+PeNp4sb233HYvM+9DCsFBdX4kvrqSAKK2BJ0wAwDTqybVQQUk7h4fA4eWYI64Q
         8jGUF0W3R7nF3rOFFWaGr72lUVe06uB49zvw25PfzIR8mNLali9dOCJHKCQpjU8wGiTp
         sLjs4tau82CNnSwcpSFCJUUt6F5WQPEbtP+4gFnaztZCyaqQA3N4p6xjIsZviDMTH9K8
         XUFR684AvlhXWXxfUfgodVrhU/7JTQxgBX47cmYetqrTK1fQo0uyseI2Z9b55jU2fk4k
         +OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tjX2w9M7EFtHsZFZhsx3c4SCQweNBQqkhUorHIIQxAQ=;
        b=Qf7sU1EUD0u/eOJNHkjGUSJjxb0wtTxZaFe6orEtwVadpmaSkGHNzo7FJ2b483v622
         /z0UV0kTMQub2sc4RvV/Tm0L+yObLbznP3NEp1RLL5zCP8Zqh7XfWTxdhOeFMDj6eDJz
         8uLcNvbxKqx3njefOeYQbgZA639Gw5i6l6JcZZ1RzE9E7nIzIOjGp+JhmiSMKQwTMAor
         YWyz0HbzW6/SPOlG1Lm+OYA46HS79z65J/fs4T+mouNKsLDR4gYcQn/ILpKVArzRri57
         iVAZ7UZ7HVoeQLZWnY1CeXNDjYK+6ogyecfcnI6nboZ/HBVeCup1iE6/7SHDzWI+z043
         pPFg==
X-Gm-Message-State: AJIora8kdSIua7Gxsw3k7ujT219kA2z/zS7x5bH9WgaPI0Ylqvv5l/m4
        s/Jf0EbDzazapgex2w92qR7WeU2NqZiiigelj16/Og==
X-Google-Smtp-Source: AGRyM1u7nssJEQxEFORZ2ICttHs8r1YyjWRqLPtub3pQnl8k0K2Gx+kfiDCwO149Qd4zDix1vqAvmMixnvUAtxJ31D4=
X-Received: by 2002:aa7:8883:0:b0:525:6b0a:b23d with SMTP id
 z3-20020aa78883000000b005256b0ab23dmr43165296pfe.82.1657057787103; Tue, 05
 Jul 2022 14:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220628222941.2642917-1-jeffxu@google.com> <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
In-Reply-To: <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 5 Jul 2022 14:49:11 -0700
Message-ID: <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/landlock: skip ptrace_test when YAMA is enabled
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Micka=C3=ABl

Thank you for your review, please see my response below.

> Hi Jeff,
>
> Thanks for this patch. Here are some comments:
>
> On 29/06/2022 00:29, Jeff Xu wrote:
> > ptrace_test assumes YAMA is disabled, skip it if YAMA is enabled.
> >
> > Cc: Jorge Lucangeli Obes <jorgelo@chromium.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > Tested-by: Jeff Xu <jeffxu@google.com>
> > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > Change-Id: I623742ca9f20ec706a38c92f6c0bab755f73578f
> > ---
> >   .../testing/selftests/landlock/ptrace_test.c  | 49 ++++++++++++++++++=
+
> >   1 file changed, 49 insertions(+)
> >
> > diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/tes=
ting/selftests/landlock/ptrace_test.c
> > index c28ef98ff3ac..ef2d36f56764 100644
> > --- a/tools/testing/selftests/landlock/ptrace_test.c
> > +++ b/tools/testing/selftests/landlock/ptrace_test.c
> > @@ -226,6 +226,44 @@ FIXTURE_TEARDOWN(hierarchy)
> >   {
> >   }
> >
>
> Please move these new helpers after test_ptrace_read() and make them stat=
ic.
>
> > +int open_sysfs(const char *path, int flags, int *fd)
> > +{
> > +     *fd =3D open(path, flags);
> > +
> > +     if (fd < 0)
> > +             return -1;
> > +
> > +     return 0;
> > +}
>
> open_sysfs() can be replaced with a call to open(). This makes the code
> simpler.
>
> > +
> > +int read_sysfs_int_fd(int fd, int *val)
> > +{
> > +     char buf[2];
> > +
> > +     if (read(fd, buf, sizeof(buf)) < 0)
>
> I guess `read(fd, buf, 1)` should be enough and it enables keeping the
> final '\0'. A comment should state that this helper only read the first
> digit (which is enough for Yama).
>
> > +             return -1;
> > +
> > +     buf[sizeof(buf) - 1] =3D '\0';
>
> Use `char buf[2] =3D {};` instead.
>
> > +     *val =3D atoi(buf);
> > +     return 0;
> > +}
>

Thanks, I will revise the code, my original thought is to extend it as
a common utility function to parse an int, let me finish it in the
next iteration of patch.

> Same for read_sysfs_int_fd(), you can inline the code in read_sysfs_int()=
.
> This is a good test but it fail if Yama is not built in the kernel.
>
I don't have a kernel built without yama, so my original thought is to
fail it and whoever has the need can fix it. What is your thought on this ?

> For now, I think you can create two helpers named something like
> is_yama_restricting() and is_yama_denying() (for admin-only attach).
>
Can you please clarify on the difference/implementation on those 2 ?

> > +     if (ptrace_val !=3D 0) {
>
> Some tests should work even if ptrace_val =3D=3D 1. SKIP() should only be
> called when the test would fail. Can you please check all tests with all
> Yama values?
Sure, below are yama cases with testing result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
case 0 - classic ptrace permissions: a process can PTRACE_ATTACH to any oth=
er
    process running under the same uid, as long as it is dumpable (i.e.
    did not transition uids, start privileged, or have called
    prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TRACEME is
    unchanged.

Test: All passing
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Case 1 - restricted ptrace: a process must have a predefined relationship
    with the inferior it wants to call PTRACE_ATTACH on. By default,
    this relationship is that of only its descendants when the above
    classic criteria is also met. To change the relationship, an
    inferior can call prctl(PR_SET_PTRACER, debugger, ...) to declare
    an allowed debugger PID to call PTRACE_ATTACH on the inferior.
    Using PTRACE_TRACEME is unchanged.

Test:
// Base_test: 7/7 pass.
// Fs_test 46/48 pass
//.   not ok 47 layout2_overlay.no_restriction
//.   not ok 48 layout2_overlay.same_content_different_file
//  Ptrace_test 4/8 pass
// #          FAIL  hierarchy.allow_without_domain.trace
// #          FAIL  hierarchy.deny_with_parent_domain.trace
// #          FAIL  hierarchy.allow_sibling_domain.trace
// #          FAIL  hierarchy.deny_with_nested_and_parent_domain.trace
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Case 2 - admin-only attach: only processes with CAP_SYS_PTRACE may use ptra=
ce
    with PTRACE_ATTACH, or through children calling PTRACE_TRACEME.
Case 3 - no attach: no processes may use ptrace with PTRACE_ATTACH nor via
    PTRACE_TRACEME. Once set, this sysctl value cannot be changed.
Test: *case2 and case3 have the same results:
// Base_test: 7/7 pass.
// Fs_test 46/48 pass
//.   not ok 47 layout2_overlay.no_restriction
//.   not ok 48 layout2_overlay.same_content_different_file
//  Ptrace 2/8 pass
//.  ok 4 hierarchy.deny_with_sibling_domain.trace
//.  ok 8 hierarchy.deny_with_forked_domain.trace
// the other 6 tests failed with timeout.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Do you know why fs_test (47,48) is failing when yama value =3D 1,2,3 ?

FOR SKIP,  it might be messy to add SKIP after checking variant names
in TEST_F(), (too many if/else , which make it less readable),
ideally this should be when or before FIXTURE_VARIANT_ADD() is called.
or somehow refactor the code to remove the variant check in TEST_F()

Is there a better way  ?

Thanks
Best Regards,
Jeff



On Thu, Jun 30, 2022 at 8:31 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
>
> On 29/06/2022 00:29, Jeff Xu wrote:
> > ptrace_test assumes YAMA is disabled, skip it if YAMA is enabled.
> >
> > Cc: Jorge Lucangeli Obes <jorgelo@chromium.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > Tested-by: Jeff Xu <jeffxu@google.com>
>
> I guess we assume that Signed-off-by implies Tested-by, so you can
> remove this Tested-by.
>
> > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > Change-Id: I623742ca9f20ec706a38c92f6c0bab755f73578f
>
> Please remove this Change-Id too.

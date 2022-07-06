Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03943C43334
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Jul 2022 23:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiGFXmQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Jul 2022 19:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbiGFXmB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Jul 2022 19:42:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69BB2CE15
        for <linux-security-module@vger.kernel.org>; Wed,  6 Jul 2022 16:42:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e16so3179780pfm.11
        for <linux-security-module@vger.kernel.org>; Wed, 06 Jul 2022 16:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vwwdZ2fP1UVZmO57D1mqd5DMh9/cGanDM/yWeofOBB8=;
        b=HXhsRLjNcAdSNBCMPnn8uTMcRGkSzCmOslY6oJ8F3aJ1au86E5TTKS1M6ZpxFTZkWS
         fS0jl0Y7IhcjWop0GhVASBwr17+mC106Re6MdKOsndwD0bvMdNrh85kN7VAGYC84c+id
         JGqOoAcsz4wAKYvN7uTa2U2AvFodltT/odqkZ3bGxpduIBMlyprcSx5K+E61F/umvnBN
         +fDoyG8ElFy84QoGNW9xj2P8ErPaPkethL2XwY4O0xqfsNeMygg1ickSpsnTfdPHhlbi
         75hOEyRgvSN/4HCgJAc/W73kL9Ceqqc22dXK0O/vDjyWLeEvUg/qglnqxloiLtWH9HSa
         st/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vwwdZ2fP1UVZmO57D1mqd5DMh9/cGanDM/yWeofOBB8=;
        b=XGig8sQzMNEpzNhrtiB/KNWUcZRMhHONjmpIdj3ILVAxuWX0yyTo+v7qu7MVOY5zeU
         799YD715/2rq1CtkTPzTzZOK7WBQNp9E0Fdp5j9Gvw3GJ3bQZoedQILqLidwcoz6LBZx
         BKcLJGREhXRAjQD4+h+me3Fp3oMOOisq7dagm2UiB8NtAOh4p3wlCR/O1lmihlcDIbmo
         niUiYl1Br/DMwQ9Wk+vJ0gGFc06iIi7p46SQ3K8sZJF6UHJbM6kaxvUzIb27z56HhzT2
         m73b+jbCdpplwVvwSKPetiE/NxOtqZ5b7L+gsm3CUXiMpZLG4nteVsE1KlMKeoWNaJ+F
         wLJQ==
X-Gm-Message-State: AJIora/nfYhI6ojd5hRfaHeslRNZGTjnaGv1BBg/bzQw+Bs/WAISqhIc
        u3Dx2pjpeHycR6xdd+YpJyMgWW+HBH9L04Q1mZcqNg==
X-Google-Smtp-Source: AGRyM1ugcCpXnL4qo4ZqEc+QoA8wPgzX0CPzASOI52vjcIbNGVDVWNpsQ5HxSJWbVPjZHb3XskTJ/XfkEOlUqqEYRgM=
X-Received: by 2002:aa7:8883:0:b0:525:6b0a:b23d with SMTP id
 z3-20020aa78883000000b005256b0ab23dmr49502147pfe.82.1657150919937; Wed, 06
 Jul 2022 16:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220628222941.2642917-1-jeffxu@google.com> <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
 <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
In-Reply-To: <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 6 Jul 2022 16:41:24 -0700
Message-ID: <CALmYWFs2gv-z8W=vNpQf6G32VHd=ptGQ4cx+ahcEPtf6Y4UC0A@mail.gmail.com>
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

A correction (resend with plain text)

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> case 0 - classic ptrace permissions: a process can PTRACE_ATTACH to any o=
ther
>     process running under the same uid, as long as it is dumpable (i.e.
>     did not transition uids, start privileged, or have called
>     prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TRACEME is
>     unchanged.

// Base_test: 7/7 pass.
// Fs_test 46/48 pass
//.   not ok 47 layout2_overlay.no_restriction
//.   not ok 48 layout2_overlay.same_content_different_file
//  Ptrace 8/8 pass

Note: 47,48 of fs_test are failing for all YAMA config values (0-3)


On Tue, Jul 5, 2022 at 2:49 PM Jeff Xu <jeffxu@google.com> wrote:
>
> Hi Micka=C3=ABl
>
> Thank you for your review, please see my response below.
>
> > Hi Jeff,
> >
> > Thanks for this patch. Here are some comments:
> >
> > On 29/06/2022 00:29, Jeff Xu wrote:
> > > ptrace_test assumes YAMA is disabled, skip it if YAMA is enabled.
> > >
> > > Cc: Jorge Lucangeli Obes <jorgelo@chromium.org>
> > > Cc: Guenter Roeck <groeck@chromium.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > Tested-by: Jeff Xu <jeffxu@google.com>
> > > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > > Change-Id: I623742ca9f20ec706a38c92f6c0bab755f73578f
> > > ---
> > >   .../testing/selftests/landlock/ptrace_test.c  | 49 ++++++++++++++++=
+++
> > >   1 file changed, 49 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/t=
esting/selftests/landlock/ptrace_test.c
> > > index c28ef98ff3ac..ef2d36f56764 100644
> > > --- a/tools/testing/selftests/landlock/ptrace_test.c
> > > +++ b/tools/testing/selftests/landlock/ptrace_test.c
> > > @@ -226,6 +226,44 @@ FIXTURE_TEARDOWN(hierarchy)
> > >   {
> > >   }
> > >
> >
> > Please move these new helpers after test_ptrace_read() and make them st=
atic.
> >
> > > +int open_sysfs(const char *path, int flags, int *fd)
> > > +{
> > > +     *fd =3D open(path, flags);
> > > +
> > > +     if (fd < 0)
> > > +             return -1;
> > > +
> > > +     return 0;
> > > +}
> >
> > open_sysfs() can be replaced with a call to open(). This makes the code
> > simpler.
> >
> > > +
> > > +int read_sysfs_int_fd(int fd, int *val)
> > > +{
> > > +     char buf[2];
> > > +
> > > +     if (read(fd, buf, sizeof(buf)) < 0)
> >
> > I guess `read(fd, buf, 1)` should be enough and it enables keeping the
> > final '\0'. A comment should state that this helper only read the first
> > digit (which is enough for Yama).
> >
> > > +             return -1;
> > > +
> > > +     buf[sizeof(buf) - 1] =3D '\0';
> >
> > Use `char buf[2] =3D {};` instead.
> >
> > > +     *val =3D atoi(buf);
> > > +     return 0;
> > > +}
> >
>
> Thanks, I will revise the code, my original thought is to extend it as
> a common utility function to parse an int, let me finish it in the
> next iteration of patch.
>
> > Same for read_sysfs_int_fd(), you can inline the code in read_sysfs_int=
().
> > This is a good test but it fail if Yama is not built in the kernel.
> >
> I don't have a kernel built without yama, so my original thought is to
> fail it and whoever has the need can fix it. What is your thought on this=
 ?
>
> > For now, I think you can create two helpers named something like
> > is_yama_restricting() and is_yama_denying() (for admin-only attach).
> >
> Can you please clarify on the difference/implementation on those 2 ?
>
> > > +     if (ptrace_val !=3D 0) {
> >
> > Some tests should work even if ptrace_val =3D=3D 1. SKIP() should only =
be
> > called when the test would fail. Can you please check all tests with al=
l
> > Yama values?
> Sure, below are yama cases with testing result:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> case 0 - classic ptrace permissions: a process can PTRACE_ATTACH to any o=
ther
>     process running under the same uid, as long as it is dumpable (i.e.
>     did not transition uids, start privileged, or have called
>     prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TRACEME is
>     unchanged.
>
> Test: All passing
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Case 1 - restricted ptrace: a process must have a predefined relationship
>     with the inferior it wants to call PTRACE_ATTACH on. By default,
>     this relationship is that of only its descendants when the above
>     classic criteria is also met. To change the relationship, an
>     inferior can call prctl(PR_SET_PTRACER, debugger, ...) to declare
>     an allowed debugger PID to call PTRACE_ATTACH on the inferior.
>     Using PTRACE_TRACEME is unchanged.
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
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> Case 2 - admin-only attach: only processes with CAP_SYS_PTRACE may use pt=
race
>     with PTRACE_ATTACH, or through children calling PTRACE_TRACEME.
> Case 3 - no attach: no processes may use ptrace with PTRACE_ATTACH nor vi=
a
>     PTRACE_TRACEME. Once set, this sysctl value cannot be changed.
> Test: *case2 and case3 have the same results:
> // Base_test: 7/7 pass.
> // Fs_test 46/48 pass
> //.   not ok 47 layout2_overlay.no_restriction
> //.   not ok 48 layout2_overlay.same_content_different_file
> //  Ptrace 2/8 pass
> //.  ok 4 hierarchy.deny_with_sibling_domain.trace
> //.  ok 8 hierarchy.deny_with_forked_domain.trace
> // the other 6 tests failed with timeout.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Do you know why fs_test (47,48) is failing when yama value =3D 1,2,3 ?
>
> FOR SKIP,  it might be messy to add SKIP after checking variant names
> in TEST_F(), (too many if/else , which make it less readable),
> ideally this should be when or before FIXTURE_VARIANT_ADD() is called.
> or somehow refactor the code to remove the variant check in TEST_F()
>
> Is there a better way  ?
>
> Thanks
> Best Regards,
> Jeff
>
>
>
> On Thu, Jun 30, 2022 at 8:31 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net=
> wrote:
> >
> >
> > On 29/06/2022 00:29, Jeff Xu wrote:
> > > ptrace_test assumes YAMA is disabled, skip it if YAMA is enabled.
> > >
> > > Cc: Jorge Lucangeli Obes <jorgelo@chromium.org>
> > > Cc: Guenter Roeck <groeck@chromium.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > Tested-by: Jeff Xu <jeffxu@google.com>
> >
> > I guess we assume that Signed-off-by implies Tested-by, so you can
> > remove this Tested-by.
> >
> > > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > > Change-Id: I623742ca9f20ec706a38c92f6c0bab755f73578f
> >
> > Please remove this Change-Id too.

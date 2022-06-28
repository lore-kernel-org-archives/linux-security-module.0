Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B238C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Jun 2022 17:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiF1RV4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiF1RVz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jun 2022 13:21:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E555387BF
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 10:21:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 354B561937
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 17:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B69C385A5
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656436913;
        bh=G08nxu9pR0SdDwYkOrLJkjRjDe4pJV4sDxmgPMS3Y3Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zp+gii3TSdcru6Ohw42TpoQdv5G2/DGxPHqqpDlPhjtAvZiJ4O1lDBqDDN5nabbz1
         b/lrNV5OMONg7mbHjnGaB1fyzqyGU50pwhrmA7rnntkCQ4dqAGiZAX1dRmFXebqPNg
         eLT4phDVQZNfeP+vzdl6jF8YQ7FRpJWVv+8Lgp/mNgfKL17o6KuOvXKh978UCrMz2C
         CM5Z7tSbbb1jFVk+7MeWG348x8dZxizdwvcmJTgN97BzokcNFhNjR07O3K9O6qXRns
         tD2xJvMI1TWgPdlzbccC/vFSqyE52eMicLwrY2wari+K7FAC6JMRQC7IEzkWjKB7qr
         D4yYlGSDr9dpA==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2ef5380669cso124195217b3.9
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 10:21:53 -0700 (PDT)
X-Gm-Message-State: AJIora/LgMxhwA3aMeGNXz9Ct7fjDHcE1uoMf3x0l1pBPTn16dLofiXW
        g4jQbScC1uk4hvvJge/yZ3Z0183yw455Qu3WcZQr5w==
X-Google-Smtp-Source: AGRyM1sUL/xvNELPokn0K6KV1lrMddoRYK7yFjIJI1ZwpIj27mMpJne+iMkNV+quNvZHtfiopav8nH2CrCMgjWipyG8=
X-Received: by 2002:a81:59c1:0:b0:31b:7f09:4f57 with SMTP id
 n184-20020a8159c1000000b0031b7f094f57mr19905503ywb.204.1656436912659; Tue, 28
 Jun 2022 10:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220628161948.475097-1-kpsingh@kernel.org> <20220628171325.ccbylrqhygtf2dlx@wittgenstein>
 <CACYkzJ4kWFwC82EAhtEYcMBPNe49zXd+uPBt1i09mVwLnoh0Bw@mail.gmail.com>
In-Reply-To: <CACYkzJ4kWFwC82EAhtEYcMBPNe49zXd+uPBt1i09mVwLnoh0Bw@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 28 Jun 2022 19:21:42 +0200
X-Gmail-Original-Message-ID: <CACYkzJ766xv-9+jLg9mNZtdbLN3n=J+Y5ep4BjpS+vzv2B2auQ@mail.gmail.com>
Message-ID: <CACYkzJ766xv-9+jLg9mNZtdbLN3n=J+Y5ep4BjpS+vzv2B2auQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/5] Add bpf_getxattr
To:     Christian Brauner <brauner@kernel.org>
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 28, 2022 at 7:20 PM KP Singh <kpsingh@kernel.org> wrote:
>
> On Tue, Jun 28, 2022 at 7:13 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Jun 28, 2022 at 04:19:43PM +0000, KP Singh wrote:
> > > v4 -> v5
> > >
> > > - Fixes suggested by Andrii
> > >
> > > v3 -> v4
> > >
> > > - Fixed issue incorrect increment of arg counter
> > > - Removed __weak and noinline from kfunc definiton
> > > - Some other minor fixes.
> > >
> > > v2 -> v3
> > >
> > > - Fixed missing prototype error
> > > - Fixes suggested by other Joanne and Kumar.
> > >
> > > v1 -> v2
> > >
> > > - Used kfuncs as suggested by Alexei
> > > - Used Benjamin Tissoires' patch from the HID v4 series to add a
> > >   sleepable kfunc set (I sent the patch as a part of this series as it
> > >   seems to have been dropped from v5) and acked it. Hope this is okay.
> > > - Added support for verifying string constants to kfuncs
> >
> > Hm, I mean this isn't really giving any explanation as to why you are
> > doing this. There's literally not a single sentence about the rationale?
> > Did you accidently forget to put that into the cover letter? :)
>
>
> Yes, actually I did forget to copy paste :)
>
> Foundation for building more complex security policies using the
> BPF LSM as presented in LSF/MM/BPF:
>
> http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-xattr.pdf\

And my copy paste skills are getting worse (with the back-slash removed):

http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-xattr.pdf

>
> See: https://lore.kernel.org/bpf/20220624045636.3668195-1-kpsingh@kernel.org/
>
>
> >
> > >
> > >
> > >
> > > Benjamin Tissoires (1):
> > >   btf: Add a new kfunc set which allows to mark a function to be
> > >     sleepable
> > >
> > > KP Singh (4):
> > >   bpf: kfunc support for ARG_PTR_TO_CONST_STR
> > >   bpf: Allow kfuncs to be used in LSM programs
> > >   bpf: Add a bpf_getxattr kfunc
> > >   bpf/selftests: Add a selftest for bpf_getxattr
> > >
> > >  include/linux/bpf_verifier.h                  |  2 +
> > >  include/linux/btf.h                           |  2 +
> > >  kernel/bpf/btf.c                              | 43 ++++++++-
> > >  kernel/bpf/verifier.c                         | 89 +++++++++++--------
> > >  kernel/trace/bpf_trace.c                      | 42 +++++++++
> > >  .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++
> > >  tools/testing/selftests/bpf/progs/xattr.c     | 37 ++++++++
> > >  7 files changed, 229 insertions(+), 40 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/xattr.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/xattr.c
> > >
> > > --
> > > 2.37.0.rc0.161.g10f37bed90-goog
> > >

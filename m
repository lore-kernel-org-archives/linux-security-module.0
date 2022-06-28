Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733BAC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Jun 2022 17:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiF1Rxi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiF1RxR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jun 2022 13:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA553A446
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 10:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D7C1619CC
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 17:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA67C341CA
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 17:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656438754;
        bh=1CFWsHDyBFCdk9FMXqZqtRxlJwOD4QYi3VLp5L9waFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BCxJVxRxNIvf878wioP92nIRzTDhLQJrXig5WEBroiYB/kVtUw7aznYFX2/Pr7oy4
         VcM+Bvs/DfZeKQ5TYWNGkm1xwm3OKQ1w5eQZbkJYjvPeDKlmKWfwFhSCdc5LHYEDqV
         UiT4O2bgPfk9tpmFDjAMDtsDITn4xtZIwSYPTkKc7flUI7UUpzve6EiuAurjImAfp7
         TRb5v3FnpQmTkRpj4bIH/3MWWUAWVLlwHyNr6/PJ+J9qjczlRIoI1W3ADbyjVNH02o
         smWHLt/gbva1MfV5XNYFroFZ6PkKiBoh5+5RL4Ua2RDqryXcjZppYzwWLhc/uSciZf
         L/hoFskcccFUw==
Received: by mail-yb1-f178.google.com with SMTP id l11so23450856ybu.13
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 10:52:34 -0700 (PDT)
X-Gm-Message-State: AJIora/gMMXBj3l7S3TlwXNQ0y9CDdspti06/js8liGLSfRqa075LSjS
        TtUXIVW9RJBixTpdLtYB3ujjj8rqWR8PPMCLLGG8Zw==
X-Google-Smtp-Source: AGRyM1sPwROEYpARjmuZt7KnRCmkADqIZe/mLmQImXBKPlGfyx79CeXHkdgcwtsTldmt0vI4w1n6oI7l1gAz2DhnFDI=
X-Received: by 2002:a25:9a48:0:b0:669:b51a:5b8d with SMTP id
 r8-20020a259a48000000b00669b51a5b8dmr20982749ybo.404.1656438753522; Tue, 28
 Jun 2022 10:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220628161948.475097-1-kpsingh@kernel.org> <20220628161948.475097-6-kpsingh@kernel.org>
 <20220628173344.h7ihvyl6vuky5xus@wittgenstein>
In-Reply-To: <20220628173344.h7ihvyl6vuky5xus@wittgenstein>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 28 Jun 2022 19:52:22 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5ij9rth_v3KQrCVYsQr2STBEWq1EAzkDb5D06CoRRSjA@mail.gmail.com>
Message-ID: <CACYkzJ5ij9rth_v3KQrCVYsQr2STBEWq1EAzkDb5D06CoRRSjA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for bpf_getxattr
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

On Tue, Jun 28, 2022 at 7:33 PM Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Jun 28, 2022 at 04:19:48PM +0000, KP Singh wrote:
> > A simple test that adds an xattr on a copied /bin/ls and reads it back
> > when the copied ls is executed.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++++++++++

[...]

> > +SEC("lsm.s/bprm_committed_creds")
> > +void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
> > +{
> > +     struct task_struct *current = bpf_get_current_task_btf();
> > +     char dir_xattr_value[64] = {0};
> > +     int xattr_sz = 0;
> > +
> > +     xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> > +                             bprm->file->f_path.dentry->d_inode, XATTR_NAME,
> > +                             dir_xattr_value, 64);
>
> Yeah, this isn't right. You're not accounting for the caller's userns
> nor for the idmapped mount. If this is supposed to work you will need a
> variant of vfs_getxattr() that takes the mount's idmapping into account
> afaict. See what needs to happen after do_getxattr().

Thanks for taking a look.

So, If I understand correctly, we don't need xattr_permission (and
other checks in
vfs_getxattr) here as the BPF programs run as CAP_SYS_ADMIN.

but...

So, Is this bit what's missing then?

error = vfs_getxattr(mnt_userns, d, kname, ctx->kvalue, ctx->size);
if (error > 0) {
    if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
(strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
        posix_acl_fix_xattr_to_user(mnt_userns, d_inode(d),
            ctx->kvalue, error);
    if (ctx->size && copy_to_user(ctx->value, ctx->kvalue, error))
        error = -EFAULT;
}
else if (error == -ERANGE && ctx->size >= XATTR_SIZE_MAX) {
    /* The file system tried to returned a value bigger
than XATTR_SIZE_MAX bytes. Not possible. */
    error = -E2BIG;
}

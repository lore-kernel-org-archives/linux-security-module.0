Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F566C43334
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jun 2022 00:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbiFJAzu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbiFJAzu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Jun 2022 20:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68742506DB
        for <linux-security-module@vger.kernel.org>; Thu,  9 Jun 2022 17:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05BE7615D2
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jun 2022 00:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6317DC34115
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jun 2022 00:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654822548;
        bh=tPPcB6qg2ZDplGPe5r34eX0A1FBrYHTtZQ+pNqpv4cA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rN5vKZT7vMn0D59pBjQMR6mer6VECxTn1hYov3KEh5snnj1z7CwMg13lMNf9o7IUA
         lF9I8W0oA15/RX9rX7hvXCCv6D4Gl/uuANjLnuDTJt36EPbFmvkXNUfMUw3eIyRTqQ
         KPez9+0cjELSSt72zYM5K+D/Lp0VG4PW3Z/U4PGvGDcTkxetZJyTohPfopkrwDUQJ5
         874N91QIlhffz1T9+T+DvffzZLX8R8lnFhW/tw8vQlh8uWmCcaMqLiAXD2pvRPgWVq
         zEzffesV+lvotIb7YSb5M59646RksweW82+DEAsqhuW5kQVqkgpxB8TMt0GCCplgPT
         mm5MjSG1/tlAA==
Received: by mail-yb1-f174.google.com with SMTP id r3so10386067ybr.6
        for <linux-security-module@vger.kernel.org>; Thu, 09 Jun 2022 17:55:48 -0700 (PDT)
X-Gm-Message-State: AOAM533f63oyOTIhnAc6dWY14Q8izR/Ucau1+mnUgjz2OVQ+21b0ES+1
        BK+YI3gw2pMHunr4sB3kVo7lIEkoWJQaFmBYA9lKVg==
X-Google-Smtp-Source: ABdhPJyUNbhO6WzB5L/SFE1CmuOEdZh1ZSad2If7CbByV6A9zwXVh1jSuEqwGjwBpyNA794D0lNgL1YDOJF2KTfy2ZM=
X-Received: by 2002:a5b:10b:0:b0:654:74c1:61cf with SMTP id
 11-20020a5b010b000000b0065474c161cfmr43467397ybx.42.1654822547386; Thu, 09
 Jun 2022 17:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220609234601.2026362-1-kpsingh@kernel.org> <CAADnVQJSijXmDG0C+U101ahgOYTmHEuyBu_=CS87rJ9GchFQyA@mail.gmail.com>
In-Reply-To: <CAADnVQJSijXmDG0C+U101ahgOYTmHEuyBu_=CS87rJ9GchFQyA@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 10 Jun 2022 02:55:36 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4L=SxggPxrqEC1yzv-DzM1-w0ZPo-E1HPE-8ob-r0UTw@mail.gmail.com>
Message-ID: <CACYkzJ4L=SxggPxrqEC1yzv-DzM1-w0ZPo-E1HPE-8ob-r0UTw@mail.gmail.com>
Subject: Re: [PATCH linux-next] security: Fix side effects of default BPF LSM hooks
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 10, 2022 at 2:44 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 9, 2022 at 4:46 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > BPF LSM currently has a default implementation for each LSM hooks which
> > return a default value defined in include/linux/lsm_hook_defs.h. These
> > hooks should have no functional effect when there is no BPF program
> > loaded to implement the hook logic.
> >
> > Some LSM hooks treat any return value of the hook as policy decision
> > which results in destructive side effects.
> >
> > This issue and the effects were reported to me by Jann Horn:
> >
> > For a system configured with CONFIG_BPF_LSM and the bpf lsm is enabled
> > (via lsm= or CONFIG_LSM) an unprivileged user can vandalize the system
> > by removing the security.capability xattrs from binaries, preventing
> > them from working normally:
> >
> > $ getfattr -d -m- /bin/ping
> > getfattr: Removing leading '/' from absolute path names
> > security.capability=0sAQAAAgAgAAAAAAAAAAAAAAAAAAA=
> >
> > $ setfattr -x security.capability /bin/ping
> > $ getfattr -d -m- /bin/ping
> > $ ping 1.2.3.4
> > $ ping google.com
> > $ echo $?
> > 2
> >
> > The above reproduces with:
> >
> > cat /sys/kernel/security/lsm
> > capability,apparmor,bpf
>
> Why is this bpf related?
> apparmor doesn't have that hook,
> while capability returns 0.
> So bpf's default==0 doesn't change the situation.
>
> Just
> cat /sys/kernel/security/lsm
> capability
>
> would reproduce the issue?
> what am I missing?

capability does not define the inode_removexattr LSM hook:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/commoncap.c#n1449

It's only when the return value of the hook is 1, it checks for
cap_inode_removexattr.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/security.c#n1408

Only 3 LSMs define the hook (bpf, smack and selinux):

fgrep -R LSM_HOOK_INIT *  | grep inode_removexattr
selinux/hooks.c: LSM_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
smack/smack_lsm.c: LSM_HOOK_INIT(inode_removexattr, smack_inode_removexattr),

The BPF LSM default hooks intend to provide no side-effects when the
LSM is enabled and
for the hooks that the patch updates, there is a side-effect.

Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06F3C433FE
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Nov 2022 18:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiKKSxH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 11 Nov 2022 13:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiKKSxG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Nov 2022 13:53:06 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9372631DD0
        for <linux-security-module@vger.kernel.org>; Fri, 11 Nov 2022 10:53:05 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z3so4187889iof.3
        for <linux-security-module@vger.kernel.org>; Fri, 11 Nov 2022 10:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ouP/s1i13pW/WnLRCKmXreOXzmmuMMjrVEnF5fjihQ=;
        b=Us0/MlsKJ4OW33U5IH0afDolq/vVUV1Qx0kQsEtfxHKsMBjx9b865n9dpmYV3EkF3j
         th8iKrez0qBK50uc5q65e83d2lcvvyFFKnFsDLkZg1vUZsqJ8CZlmXLetQhdyKvyQGjO
         RCkrvpPaGNsHrZ/ocCvsFeMr1+/QcOspJFRse7bmCxss3I9Y1RleV4YKdxBMRuJhqifh
         Kk4IzYnPVbwwncc/e0i/d4fJR0BoBRckqu3CN10XPDU6gi0EoTs+4zEmDJWdZ+sPoOmx
         uOfrGAt+/DH1y9B1a0Z3Ko6+imZT+mvSoqnpASihn8mh3ba6tmJ1yMkrHqXPAJyHDAYH
         ugRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ouP/s1i13pW/WnLRCKmXreOXzmmuMMjrVEnF5fjihQ=;
        b=a6qjHxmV79eZiOtJ+ZlXSSyeN1K37nlTeR5O4g+b9bvQT8mtxG1Zj2Ou5pMSBagt3t
         Cv2XDMUcZLIDx9ddJT9lsUJ430PjQ9os1eQYm8NJu1z0i4iJ0W8TVQYw1NithHX6h7Bn
         NDP+BLKvYwdR67D1u8JmP/Qz93vpPHQJV5OjIcJvnYRrTSD5uw1e/7yTcqbO4CLtLuv4
         iNKICJpsOR31MCOvLQXAfmQnOrI4qGYn66IbXrdS6oFsDfhukUyC6KJKuVobRx8PaDIp
         H/X7hyrU6CAfFwNi8UbYz2F+XpTJJdafnNGVB5xZsocult5xLX7zpjWIweSB6g1uoBt2
         3TQA==
X-Gm-Message-State: ANoB5pkyvTK3k8dIyjIpxtUSErVyUZoPuzLaLUOqqRcd54XqfdxnpcdA
        Fm/gVdDkGr2uwrTJ8bE1QKW/rBtVHkqFGQY/pewZweq/Xtc3m3M+
X-Google-Smtp-Source: AA0mqf5/RZzUbjpyAgwaCSIdwMocYINV3kyLiRKC6sqkaRn6UM7WpSdSYkmRmhYnLHVsukAfZmLNWOhytcuPW8rfZFA=
X-Received: by 2002:a6b:3bcb:0:b0:6c0:db74:7be1 with SMTP id
 i194-20020a6b3bcb000000b006c0db747be1mr1558174ioa.92.1668192784809; Fri, 11
 Nov 2022 10:53:04 -0800 (PST)
MIME-Version: 1.0
References: <1668160371-39153-1-git-send-email-wangyufen@huawei.com> <CAHC9VhQL0rV608+kJCAcRGHnfo1QLa5g2faws1_Mitipi1wjNQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQL0rV608+kJCAcRGHnfo1QLa5g2faws1_Mitipi1wjNQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 11 Nov 2022 10:52:54 -0800
Message-ID: <CAKH8qBvKSV0Y5PuxiBwuOmyFFXMSZmOOQHSQ0LgvBXJDA+6xNw@mail.gmail.com>
Subject: Re: [PATCH] net: fix memory leak in security_sk_alloc()
To:     Paul Moore <paul@paul-moore.com>
Cc:     Wang Yufen <wangyufen@huawei.com>,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, martin.lau@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 11, 2022 at 7:08 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Nov 11, 2022 at 4:32 AM Wang Yufen <wangyufen@huawei.com> wrote:
> >
> > kmemleak reports this issue:
> >
> > unreferenced object 0xffff88810b7835c0 (size 32):
> >   comm "test_progs", pid 270, jiffies 4294969007 (age 1621.315s)
> >   hex dump (first 32 bytes):
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     03 00 00 00 03 00 00 00 0f 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<00000000376cdeab>] kmalloc_trace+0x27/0x110
> >     [<000000003bcdb3b6>] selinux_sk_alloc_security+0x66/0x110
> >     [<000000003959008f>] security_sk_alloc+0x47/0x80
> >     [<00000000e7bc6668>] sk_prot_alloc+0xbd/0x1a0
> >     [<0000000002d6343a>] sk_alloc+0x3b/0x940
> >     [<000000009812a46d>] unix_create1+0x8f/0x3d0
> >     [<000000005ed0976b>] unix_create+0xa1/0x150
> >     [<0000000086a1d27f>] __sock_create+0x233/0x4a0
> >     [<00000000cffe3a73>] __sys_socket_create.part.0+0xaa/0x110
> >     [<0000000007c63f20>] __sys_socket+0x49/0xf0
> >     [<00000000b08753c8>] __x64_sys_socket+0x42/0x50
> >     [<00000000b56e26b3>] do_syscall_64+0x3b/0x90
> >     [<000000009b4871b8>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > The issue occurs in the following scenarios:
> >
> > unix_create1()
> >   sk_alloc()
> >     sk_prot_alloc()
> >       security_sk_alloc()
> >         call_int_hook()
> >           hlist_for_each_entry()
> >             entry1->hook.sk_alloc_security
> >             <-- selinux_sk_alloc_security() succeeded,
> >             <-- sk->security alloced here.
> >             entry2->hook.sk_alloc_security
> >             <-- bpf_lsm_sk_alloc_security() failed
> >       goto out_free;
> >         ...    <-- the sk->security not freed, memleak
> >
> > To fix, if security_sk_alloc() failed and sk->security not null,
> > goto out_free_sec to reclaim resources.
> >
> > I'm not sure whether this fix makes sense, but if hook lists don't
> > support this usage, might need to modify the
> > "tools/testing/selftests/bpf/progs/lsm_cgroup.c" test case.
>
> The core problem is that the LSM is not yet fully stacked (work is
> actively going on in this space) which means that some LSM hooks do
> not support multiple LSMs at the same time; unfortunately the
> networking hooks fall into this category.
>
> While there can only be one LSM which manages the sock::sk_security
> field by defining a sk_alloc_security hook, it *should* be possible
> for other LSMs to to leverage the socket hooks, e.g.
> security_socket_bind(), as long as they don't manipulate any of the
> sock::sk_security state.
>
> I would suggest modifying the ".../bpf/progs/lsm_cgroup.c" test until
> the LSM supports stacking the networking hooks.

Agreed. Let's add some code to skip the test when it runs in the
environments that already have non-bpf lsms installed?

> --
> paul-moore.com

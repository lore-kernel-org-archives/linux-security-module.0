Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717E2C433FE
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Nov 2022 15:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiKKPLL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 11 Nov 2022 10:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiKKPKf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Nov 2022 10:10:35 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C46586A
        for <linux-security-module@vger.kernel.org>; Fri, 11 Nov 2022 07:08:54 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id j6-20020a4ab1c6000000b004809a59818cso698912ooo.0
        for <linux-security-module@vger.kernel.org>; Fri, 11 Nov 2022 07:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OTbT3PnKCiUHyfv/DLAnEwQTnkKfhzprbkWm2faBINA=;
        b=0CuK/RQWb+6cesOMC2bHN3caOL8MIHgULsf+RU5GPH++iNgae8xrq9k85A6TMio74A
         yvHJi+W7M6pMwE/ialWcG4lVtrQjHemuNZe/pw9/lt0bd1hQqW4Fcxam3DZS8jNTpwYw
         sdbuD0x2zRLPb2JhDbOYdvBZQfvOLBq1//tP7mOJbPP5oY2ruxYfkCxG+l8uHQZPXhfO
         nJ7nNFpUBZV+maEoLDVy3Uk26oftfoEBN817JMxn8uYDXXdvW71UbVZcTu4XEZ+62ql6
         Fy4x2wVLfjXeGjGnbi5ADKJwCQCfqV0LWaGlIC5tVvVNLEaKistBZTi1saNa6rKM72fP
         UeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTbT3PnKCiUHyfv/DLAnEwQTnkKfhzprbkWm2faBINA=;
        b=oOOrisSgg9YDQZ12WWoNwfzkPcG5USV+LJO+oBBlRUj0/MEfWkR4NXOJDLSMKPkxfo
         1EEZAIm4bBkv0vS+fPMX6jyhXPh8RwFVM7DHtowB3D16WyRaXBZBG+NhxektMxJruiEK
         7R0cacQ1Q4hQqhp8bJRhs+sxtz3/4wkG8GzSKF0q6wPLu/pqlJ/LucTANMcc42eBC6WR
         N/BVYhGxegGCxsN7ZIoWnwajm/Cqq1PKHZ5RZeCju9H7ye5ryxEKkxfp3rOASKAiPeZp
         W2RJ7qwNILqv0Sk/qpNEkQCejda4unKItMdPKmtR910rKR9MCsfNMjP5rCw+SvsuFYEu
         wNmw==
X-Gm-Message-State: ANoB5plqtxhtbdr6gyk74tiVVtjUVgscORCzdcIF3U+3JoPHZRjb6UVB
        wmb6IsbjRFwGqPiI/v0hujH+ZEP0w966KTgsWmAI
X-Google-Smtp-Source: AA0mqf6usvNxkFdKnLz1F3rhVx/l4KFR/MdRYkmqCc+FBzoTMnlbkTF92jaLMMPS9V5d0rnwQIPI1VDo2/G9YkiW+RM=
X-Received: by 2002:a4a:e2c3:0:b0:480:7fd1:1875 with SMTP id
 l3-20020a4ae2c3000000b004807fd11875mr1044707oot.24.1668179333851; Fri, 11 Nov
 2022 07:08:53 -0800 (PST)
MIME-Version: 1.0
References: <1668160371-39153-1-git-send-email-wangyufen@huawei.com>
In-Reply-To: <1668160371-39153-1-git-send-email-wangyufen@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Nov 2022 10:08:42 -0500
Message-ID: <CAHC9VhQL0rV608+kJCAcRGHnfo1QLa5g2faws1_Mitipi1wjNQ@mail.gmail.com>
Subject: Re: [PATCH] net: fix memory leak in security_sk_alloc()
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, martin.lau@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 11, 2022 at 4:32 AM Wang Yufen <wangyufen@huawei.com> wrote:
>
> kmemleak reports this issue:
>
> unreferenced object 0xffff88810b7835c0 (size 32):
>   comm "test_progs", pid 270, jiffies 4294969007 (age 1621.315s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     03 00 00 00 03 00 00 00 0f 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000376cdeab>] kmalloc_trace+0x27/0x110
>     [<000000003bcdb3b6>] selinux_sk_alloc_security+0x66/0x110
>     [<000000003959008f>] security_sk_alloc+0x47/0x80
>     [<00000000e7bc6668>] sk_prot_alloc+0xbd/0x1a0
>     [<0000000002d6343a>] sk_alloc+0x3b/0x940
>     [<000000009812a46d>] unix_create1+0x8f/0x3d0
>     [<000000005ed0976b>] unix_create+0xa1/0x150
>     [<0000000086a1d27f>] __sock_create+0x233/0x4a0
>     [<00000000cffe3a73>] __sys_socket_create.part.0+0xaa/0x110
>     [<0000000007c63f20>] __sys_socket+0x49/0xf0
>     [<00000000b08753c8>] __x64_sys_socket+0x42/0x50
>     [<00000000b56e26b3>] do_syscall_64+0x3b/0x90
>     [<000000009b4871b8>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The issue occurs in the following scenarios:
>
> unix_create1()
>   sk_alloc()
>     sk_prot_alloc()
>       security_sk_alloc()
>         call_int_hook()
>           hlist_for_each_entry()
>             entry1->hook.sk_alloc_security
>             <-- selinux_sk_alloc_security() succeeded,
>             <-- sk->security alloced here.
>             entry2->hook.sk_alloc_security
>             <-- bpf_lsm_sk_alloc_security() failed
>       goto out_free;
>         ...    <-- the sk->security not freed, memleak
>
> To fix, if security_sk_alloc() failed and sk->security not null,
> goto out_free_sec to reclaim resources.
>
> I'm not sure whether this fix makes sense, but if hook lists don't
> support this usage, might need to modify the
> "tools/testing/selftests/bpf/progs/lsm_cgroup.c" test case.

The core problem is that the LSM is not yet fully stacked (work is
actively going on in this space) which means that some LSM hooks do
not support multiple LSMs at the same time; unfortunately the
networking hooks fall into this category.

While there can only be one LSM which manages the sock::sk_security
field by defining a sk_alloc_security hook, it *should* be possible
for other LSMs to to leverage the socket hooks, e.g.
security_socket_bind(), as long as they don't manipulate any of the
sock::sk_security state.

I would suggest modifying the ".../bpf/progs/lsm_cgroup.c" test until
the LSM supports stacking the networking hooks.

-- 
paul-moore.com

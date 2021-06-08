Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C006C4743F
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jun 2021 01:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5872F6128A
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jun 2021 01:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFHB5S (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Jun 2021 21:57:18 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:43559 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhFHB5Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Jun 2021 21:57:16 -0400
Received: by mail-ed1-f43.google.com with SMTP id s6so22630935edu.10
        for <linux-security-module@vger.kernel.org>; Mon, 07 Jun 2021 18:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=naMy3KseuYkM/xQcd2IbBYqGQlT32iktAcbk8eY3cyw=;
        b=XGXf8FHk7CnXBPLV/Zpz42V/plnd4FEOwny2Mc8Y5vBZegfZCFkhoY7mZufrpTaQw0
         75nzann6j8pz1oZ/q/pu4EPNa8S0leVS65fqftP1MZ1H5SmaTVKL6b3OiKCUdShRVFQV
         XMiNe9GHBAlJtE5gMPCeWcPVtmFO8txtia6QFg2uqUtwKtqx2fsILnWofAcR959FQZs0
         N41sigatk08/zA7nZedXnkeu9y6TryhDftCtuciVxFVVnmZky0LcBtAu+5aWZjHPjQlk
         6juteQf7Dzse5h7v46gyS7+k6ehEzooO+DwVsC+CEV2MwTu4qcL2RKabPMk7ApbkscfO
         I5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=naMy3KseuYkM/xQcd2IbBYqGQlT32iktAcbk8eY3cyw=;
        b=BJHPMZwg1ovVtWQAGRWExk1JXWsMdZBsyYu7eDDrw1nRpLHvzq338ZO3UHDU4kx5ZS
         wHtvo5hKb1xZGbhkC0lVSwSUZpS9hB0UpRw0eSmMeoQ42EwlSZRsDOPJ7VGJ08jxNCl8
         Se/5Gj/yTcESroEJQLVzXDh7uNJDPXnHMqP7PFxwWr7ZEtOyRLoM3U2BMU0NY37WfXcB
         SgoKl/3aH1zC8MlCqBZ6WIdBNnYeUUjyxvsjcfUaTRzkAYQ0+hztLtrhWSSGyiS1OPBt
         YFTeBYx+S27gBJQnUqlDearyrk7vIC+VCOCbbg3h/Se8xoF60hGOyiIa6DV9trW/GAEI
         PZFQ==
X-Gm-Message-State: AOAM531/uoNkFjXktLE19Ci72P42jL0fht2qsIUXak4FHZWgybYrrmgy
        XCxKETqe5NbFDnwX7LWwvSL9wwkJWy6CbzagcNvi
X-Google-Smtp-Source: ABdhPJxapa6MMZ1cEp4xopqty3tK8ADP1xyRBHTBLG5KUyzd8alOMK7AJZXCveKxHiFiEwHA59QceNDZMh9mgmGTM9g=
X-Received: by 2002:aa7:c7cd:: with SMTP id o13mr23049215eds.269.1623117246428;
 Mon, 07 Jun 2021 18:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210608015158.3848878-1-sunnanyong@huawei.com>
In-Reply-To: <20210608015158.3848878-1-sunnanyong@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Jun 2021 21:53:55 -0400
Message-ID: <CAHC9VhTqDjN1VwakrYZznaMVTyqkEKcYLo=bPtHsOXugS_mexQ@mail.gmail.com>
Subject: Re: [PATCH] net: ipv4: fix memory leak in netlbl_cipsov4_add_std
To:     Nanyong Sun <sunnanyong@huawei.com>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 7, 2021 at 9:19 PM Nanyong Sun <sunnanyong@huawei.com> wrote:
>
> Reported by syzkaller:
> BUG: memory leak
> unreferenced object 0xffff888105df7000 (size 64):
> comm "syz-executor842", pid 360, jiffies 4294824824 (age 22.546s)
> hex dump (first 32 bytes):
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> backtrace:
> [<00000000e67ed558>] kmalloc include/linux/slab.h:590 [inline]
> [<00000000e67ed558>] kzalloc include/linux/slab.h:720 [inline]
> [<00000000e67ed558>] netlbl_cipsov4_add_std net/netlabel/netlabel_cipso_v4.c:145 [inline]
> [<00000000e67ed558>] netlbl_cipsov4_add+0x390/0x2340 net/netlabel/netlabel_cipso_v4.c:416
> [<0000000006040154>] genl_family_rcv_msg_doit.isra.0+0x20e/0x320 net/netlink/genetlink.c:739
> [<00000000204d7a1c>] genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
> [<00000000204d7a1c>] genl_rcv_msg+0x2bf/0x4f0 net/netlink/genetlink.c:800
> [<00000000c0d6a995>] netlink_rcv_skb+0x134/0x3d0 net/netlink/af_netlink.c:2504
> [<00000000d78b9d2c>] genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
> [<000000009733081b>] netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
> [<000000009733081b>] netlink_unicast+0x4a0/0x6a0 net/netlink/af_netlink.c:1340
> [<00000000d5fd43b8>] netlink_sendmsg+0x789/0xc70 net/netlink/af_netlink.c:1929
> [<000000000a2d1e40>] sock_sendmsg_nosec net/socket.c:654 [inline]
> [<000000000a2d1e40>] sock_sendmsg+0x139/0x170 net/socket.c:674
> [<00000000321d1969>] ____sys_sendmsg+0x658/0x7d0 net/socket.c:2350
> [<00000000964e16bc>] ___sys_sendmsg+0xf8/0x170 net/socket.c:2404
> [<000000001615e288>] __sys_sendmsg+0xd3/0x190 net/socket.c:2433
> [<000000004ee8b6a5>] do_syscall_64+0x37/0x90 arch/x86/entry/common.c:47
> [<00000000171c7cee>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> The memory of doi_def->map.std pointing is allocated in
> netlbl_cipsov4_add_std, but no place has freed it. It should be
> freed in cipso_v4_doi_free which frees the cipso DOI resource.
>
> Fixes: 96cb8e3313c7a ("[NetLabel]: CIPSOv4 and Unlabeled packet integration")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>  net/ipv4/cipso_ipv4.c | 1 +
>  1 file changed, 1 insertion(+)

Nice catch, thanks for fixing this.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index d6e3a92841e3..099259fc826a 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -471,6 +471,7 @@ void cipso_v4_doi_free(struct cipso_v4_doi *doi_def)
>                 kfree(doi_def->map.std->lvl.local);
>                 kfree(doi_def->map.std->cat.cipso);
>                 kfree(doi_def->map.std->cat.local);
> +               kfree(doi_def->map.std);
>                 break;
>         }
>         kfree(doi_def);
> --
> 2.18.0.huawei.25

-- 
paul moore
www.paul-moore.com

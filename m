Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7F7C48BE0
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Jun 2021 17:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367736136D
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Jun 2021 17:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhFKRil (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFKRik (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Jun 2021 13:38:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39305C061574
        for <linux-security-module@vger.kernel.org>; Fri, 11 Jun 2021 10:36:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f5so33013507eds.0
        for <linux-security-module@vger.kernel.org>; Fri, 11 Jun 2021 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kicSdfyPUPG0oZw0Yyms2mDBTb2EqDMsn04Ocyed7OA=;
        b=xB5cCJAthgJGLgDcW5FU+YuJlwc9WkRntsmvFSTnAC8U6tvjQ5SDTlmFxMTNrH1pSp
         X+L07kyYXu8Tz+dl1ZA6u6m0+mb9UDaM4ofl5hLaFgJlZoiA3ue6VvFqv96WlefCBOse
         HqKqcBp+bsDnAtZbcDTAaOIGvRUZ4dxXVQEc0G6D1wXMqiUZwLI2P3qiwDFMrH214BeJ
         DHtTrO/kvGwCqketn8SYpwictc/Hf/z+NyBnso7vry4ONhbf4uTTK4/R4wRCA5cg9NWs
         9xGNVVcP6ZP0T1l0ldjLugscRSXyvQ59DibfLXUvflBIyDwSn1MXCy+anjNcIxMjNzUz
         X7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kicSdfyPUPG0oZw0Yyms2mDBTb2EqDMsn04Ocyed7OA=;
        b=P8uA1cvOBuX0/sIG22djdmQZ0eb+JxPdzCLNmYdilH+blMAUHyN553Tib/y5dBnKCx
         wWXT6DtYioqqRgNBR2JTaHFQb0VUJa2CSILh0/mdCeHWKI67Jie5A8WY3wRUo7nsISg+
         xQi3nCjWATeojNX+qwLmQx/yM8R3QyRTidynXZtCl/fmuSfOAgtTwCQ4HCYRcAD0feZm
         tzMtW73QztoZuWTNPSSJImzTKTfpp4sUQZjJ5ZV17HWBG1Fe6nz31njsKNCcz+m6cBun
         bbABZzj6EvXfLo/HjW3BsAmmYFrhtjQmlqmgRK2hVx9EFP7b159W+WqBz59WzS9ZXn97
         RUdQ==
X-Gm-Message-State: AOAM530XDdZ/CnrpeabTzGGKPBhWvL1RsD20zgeatIjJdYPQ6+XTQpji
        rIun6X3r6CVBCFaeIzxtyF3S1VHzIMYcb0XPI1b3
X-Google-Smtp-Source: ABdhPJwxcUeB13OSebDiZwZ8pswKPJkD8oPnqPRTubV8D4BitINoO9F6PgQpRJGMuHWIf1jckj+ZuaRPqDN+Jb03uc4=
X-Received: by 2002:aa7:c0d3:: with SMTP id j19mr5029543edp.196.1623432998161;
 Fri, 11 Jun 2021 10:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210611082119.2117194-1-liushixin2@huawei.com>
In-Reply-To: <20210611082119.2117194-1-liushixin2@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Jun 2021 13:36:27 -0400
Message-ID: <CAHC9VhTEYjQjFH9D4ozFbYcg=6ebMeVgN2dmYvb0ifdvadc2fA@mail.gmail.com>
Subject: Re: [PATCH -next v2] netlabel: Fix memory leak in netlbl_mgmt_add_common
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 11, 2021 at 3:50 AM Liu Shixin <liushixin2@huawei.com> wrote:
>
> Hulk Robot reported memory leak in netlbl_mgmt_add_common.
> The problem is non-freed map in case of netlbl_domhsh_add() failed.
>
> BUG: memory leak
> unreferenced object 0xffff888100ab7080 (size 96):
>   comm "syz-executor537", pid 360, jiffies 4294862456 (age 22.678s)
>   hex dump (first 32 bytes):
>     05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     fe 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01  ................
>   backtrace:
>     [<0000000008b40026>] netlbl_mgmt_add_common.isra.0+0xb2a/0x1b40
>     [<000000003be10950>] netlbl_mgmt_add+0x271/0x3c0
>     [<00000000c70487ed>] genl_family_rcv_msg_doit.isra.0+0x20e/0x320
>     [<000000001f2ff614>] genl_rcv_msg+0x2bf/0x4f0
>     [<0000000089045792>] netlink_rcv_skb+0x134/0x3d0
>     [<0000000020e96fdd>] genl_rcv+0x24/0x40
>     [<0000000042810c66>] netlink_unicast+0x4a0/0x6a0
>     [<000000002e1659f0>] netlink_sendmsg+0x789/0xc70
>     [<000000006e43415f>] sock_sendmsg+0x139/0x170
>     [<00000000680a73d7>] ____sys_sendmsg+0x658/0x7d0
>     [<0000000065cbb8af>] ___sys_sendmsg+0xf8/0x170
>     [<0000000019932b6c>] __sys_sendmsg+0xd3/0x190
>     [<00000000643ac172>] do_syscall_64+0x37/0x90
>     [<000000009b79d6dc>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Fixes: 63c416887437 ("netlabel: Add network address selectors to the NetLabel/LSM domain mapping")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
> v1->v2: According to Dongliang's and Paul's advices, simplify the code.
>
>  net/netlabel/netlabel_mgmt.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/net/netlabel/netlabel_mgmt.c b/net/netlabel/netlabel_mgmt.c
> index e664ab990941..fa9e68e5f826 100644
> --- a/net/netlabel/netlabel_mgmt.c
> +++ b/net/netlabel/netlabel_mgmt.c
> @@ -76,6 +76,7 @@ static const struct nla_policy netlbl_mgmt_genl_policy[NLBL_MGMT_A_MAX + 1] = {
>  static int netlbl_mgmt_add_common(struct genl_info *info,
>                                   struct netlbl_audit *audit_info)
>  {
> +       void * pmap = NULL;

You should use the 'void *pmap = NULL;' style that is used in the rest
of this function, and most everywhere in the kernel.

>         int ret_val = -EINVAL;
>         struct netlbl_domaddr_map *addrmap = NULL;
>         struct cipso_v4_doi *cipsov4 = NULL;
> @@ -175,6 +176,8 @@ static int netlbl_mgmt_add_common(struct genl_info *info,
>                         ret_val = -ENOMEM;
>                         goto add_free_addrmap;
>                 }
> +
> +               pmap = map;

There is no need for the extra vertical whitespace here.

>                 map->list.addr = addr->s_addr & mask->s_addr;
>                 map->list.mask = mask->s_addr;
>                 map->list.valid = 1;
> @@ -183,14 +186,13 @@ static int netlbl_mgmt_add_common(struct genl_info *info,
>                         map->def.cipso = cipsov4;
>
>                 ret_val = netlbl_af4list_add(&map->list, &addrmap->list4);
> -               if (ret_val != 0) {
> -                       kfree(map);
> -                       goto add_free_addrmap;
> -               }
> +               if (ret_val != 0)
> +                       goto add_free_map;
>
>                 entry->family = AF_INET;
>                 entry->def.type = NETLBL_NLTYPE_ADDRSELECT;
>                 entry->def.addrsel = addrmap;
> +

Please don't add extra vertical whitespace here.

>  #if IS_ENABLED(CONFIG_IPV6)
>         } else if (info->attrs[NLBL_MGMT_A_IPV6ADDR]) {
>                 struct in6_addr *addr;
> @@ -223,6 +225,8 @@ static int netlbl_mgmt_add_common(struct genl_info *info,
>                         ret_val = -ENOMEM;
>                         goto add_free_addrmap;
>                 }
> +
> +               pmap = map;

Same thing, no extra vertical whitespace please.

-- 
paul moore
www.paul-moore.com

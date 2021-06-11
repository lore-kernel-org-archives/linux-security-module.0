Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769A8C48BD1
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Jun 2021 02:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E3561285
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Jun 2021 02:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFKCbr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Jun 2021 22:31:47 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:45718 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhFKCbq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Jun 2021 22:31:46 -0400
Received: by mail-pf1-f173.google.com with SMTP id d16so3190642pfn.12;
        Thu, 10 Jun 2021 19:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AKU124jU/u06/XqITKyhGdyjgwHpz1y19GKnJe70/50=;
        b=Fzd+9ay/my62ld1LfHLOT9s0mdEJYwyL+xSYOozDWoaFF7N6NIzgDH6+61AlORTrn4
         cchKq8nuZnE9/bCSK7zUZoic4PBVaRbx6y7aD+tULv8JiYfqOb942D1ZCHQ6a4TnH3wX
         3KfMkkEQ2Pp+whm7/Q5ImzqXw2Hk75/BYZj4r08Xm7AvlofuEB+oVuOaR/pl1PBoHA6m
         ZcVRlwR1Swmn+pC2zTxPHE6oy+vaobauFcbnxSHzwlYaULUPv9M78sKvvzVvs1itCxNG
         1MqTyhOFQoJ6+hdJDAxCPJM+Jg4uqbksTx3W/TUcc7VmRvAgJVEN0na2WJm/nKjVz6F4
         j9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AKU124jU/u06/XqITKyhGdyjgwHpz1y19GKnJe70/50=;
        b=oykq0BmBkt8cwQDjB283bIfuKWlCsCFcqikn9H9KWpz+c94XBoZ+4AJIGAEBy246NG
         bvx5HGZNkiPLkG9knEsca+p74v0iqK6p2iZjSdEG06hmC9Fdeb/mf9TETVftUjS8Ls+c
         BaFziTZzRC/Xk0Rx5FsGiiTh/rXHTQnRWD0O0/jXD6PipcEu6D/v2KSpqrEtZ6sGKtKQ
         nSJjpL47yFMG6OFbr79cdiqFh24mNyK+zPD6wWx9BnEBcHFY2NwYpld4c9YPNeRrwgbN
         JXprv1ie3HA5zG2HxY545I9KvdXnowBVNFhw4LcoAaxz6FFKpRsmzxoWWqb0JLqv8K0i
         U94Q==
X-Gm-Message-State: AOAM530fqbM1obMnHAO5Mr5JjH9ZwhEmkpthxLKbjIuwhH/nyjw8/UJj
        UsOfVMsP0ZRst433SEgYklrhWk3i4/vUTDU5
X-Google-Smtp-Source: ABdhPJwiGSeqwF9faWHvjK33uS9mdi3TKiOgnJyIWzJ40zYtTtoGSDqc6JjpUcs2B9JpG6fMr1TdNQ==
X-Received: by 2002:a62:860a:0:b029:2ec:81e1:23e4 with SMTP id x10-20020a62860a0000b02902ec81e123e4mr5894381pfd.11.1623378519956;
        Thu, 10 Jun 2021 19:28:39 -0700 (PDT)
Received: from raspberrypi ([125.141.84.155])
        by smtp.gmail.com with ESMTPSA id 65sm3586605pfu.159.2021.06.10.19.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 19:28:39 -0700 (PDT)
Date:   Fri, 11 Jun 2021 03:28:35 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        austindh.kim@gmail.com
Subject: [PATCH] audit: remove unnecessary 'ret' initialization
Message-ID: <20210611022835.GA1031@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Austin Kim <austin.kim@lge.com>

The variable 'ret' is set to 0 when declared.
The 'ret' is unused until it is set to 0 again.

So it had better remove unnecessary initialization.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 security/lsm_audit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 82ce14933513..5a5016ef43b0 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -119,7 +119,6 @@ int ipv6_skb_to_auditdata(struct sk_buff *skb,
 		return -EINVAL;
 	ad->u.net->v6info.saddr = ip6->saddr;
 	ad->u.net->v6info.daddr = ip6->daddr;
-	ret = 0;
 	/* IPv6 can have several extension header before the Transport header
 	 * skip them */
 	offset = skb_network_offset(skb);
-- 
2.20.1


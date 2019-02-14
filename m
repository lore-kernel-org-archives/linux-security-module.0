Return-Path: <SRS0=hpNi=QV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A406AC43381
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Feb 2019 16:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F350222DC
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Feb 2019 16:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfBNQno (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:43:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56188 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfBNQno (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Feb 2019 11:43:44 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ECACB14D5DEF0;
        Thu, 14 Feb 2019 08:43:43 -0800 (PST)
Date:   Thu, 14 Feb 2019 08:43:43 -0800 (PST)
Message-Id: <20190214.084343.1138362153341500718.davem@davemloft.net>
To:     s-nazarov@yandex.ru
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, paul@paul-moore.com
Subject: Re: [PATCH] NETWORKING: avoid use IPCB in cipso_v4_error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <6691891549984203@myt5-a323eb993ef7.qloud-c.yandex.net>
References: <34948711549920080@myt1-06117f29c1ea.qloud-c.yandex.net>
        <CAHC9VhSDot+uNDi7ULoT7dry4FW9Jgp=NcqDh6TmA=z--kmqkA@mail.gmail.com>
        <6691891549984203@myt5-a323eb993ef7.qloud-c.yandex.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Feb 2019 08:43:44 -0800 (PST)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Nazarov Sergey <s-nazarov@yandex.ru>
Date: Tue, 12 Feb 2019 18:10:03 +0300

> Since cipso_v4_error might be called from different network stack layers, we can't safely use icmp_send there.
> icmp_send copies IP options with ip_option_echo, which uses IPCB to take access to IP header compiled data.
> But after commit 971f10ec ("tcp: better TCP_SKB_CB layout to reduce cache line misses"), IPCB can't be used
> above IP layer.
> This patch fixes the problem by creating in cipso_v4_error a local copy of compiled IP options and using it with
> introduced __icmp_send function. This looks some overloaded, but in quite rare error conditions only.
> 
> The original discussion is here:
> https://lore.kernel.org/linux-security-module/16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net/
> 
> Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>

This problem is not unique to Cipso, net/atm/clip.c's error handler
has the same exact issue.

I didn't scan more of the tree, there are probably a couple more
locations as well.

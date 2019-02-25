Return-Path: <SRS0=Ku0V=RA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7590CC43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 01:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFAE21019
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 01:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfBYBd3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 24 Feb 2019 20:33:29 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33468 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfBYBd3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 24 Feb 2019 20:33:29 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 42A8D14D6678D;
        Sun, 24 Feb 2019 17:33:29 -0800 (PST)
Date:   Sun, 24 Feb 2019 17:33:28 -0800 (PST)
Message-Id: <20190224.173328.1032826011262803545.davem@davemloft.net>
To:     s-nazarov@yandex.ru
Cc:     paul@paul-moore.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org
Subject: Re: [PATCH v2 0/2] NETWORKING: avoid use IPCB in cipso_v4_error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <33533951550857169@myt3-2475c4d2af83.qloud-c.yandex.net>
References: <20190218.172544.1436352995315454863.davem@davemloft.net>
        <8873761550853329@myt6-67cd1de25d8a.qloud-c.yandex.net>
        <33533951550857169@myt3-2475c4d2af83.qloud-c.yandex.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 24 Feb 2019 17:33:29 -0800 (PST)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Nazarov Sergey <s-nazarov@yandex.ru>
Date: Fri, 22 Feb 2019 20:39:29 +0300

> The original discussion is here:
> https://lore.kernel.org/linux-security-module/16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net/
> 
> Changes in v2:
> - original patch divided on 2 parts: add __icmp_send function, fix cipso_v4_error
> - add __ip_option_compile not using icmp_send in case nof error

Your changes are lacking proper signoffs.

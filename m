Return-Path: <SRS0=Ku0V=RA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ECCC43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 22:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE92920643
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 22:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfBYWd5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:33:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47240 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfBYWd5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Feb 2019 17:33:57 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0EB7714EF987A;
        Mon, 25 Feb 2019 14:33:56 -0800 (PST)
Date:   Mon, 25 Feb 2019 14:33:55 -0800 (PST)
Message-Id: <20190225.143355.245256286926542053.davem@davemloft.net>
To:     s-nazarov@yandex.ru
Cc:     paul@paul-moore.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org
Subject: Re: [PATCH v2 1/2] NETWORKING: avoid use IPCB in cipso_v4_error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <52295911551111855@myt5-f1576e7b5bad.qloud-c.yandex.net>
References: <33533951550857169@myt3-2475c4d2af83.qloud-c.yandex.net>
        <20190224.173328.1032826011262803545.davem@davemloft.net>
        <52295911551111855@myt5-f1576e7b5bad.qloud-c.yandex.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Feb 2019 14:33:56 -0800 (PST)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Nazarov Sergey <s-nazarov@yandex.ru>
Date: Mon, 25 Feb 2019 19:24:15 +0300

> Add __icmp_send function having ip_options struct parameter
> 
> Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>

Applied with Subject line fixes up.  This commit doesn't even make
changes to cipse_v4_error().

Anyone who ACK'd this change or added their Reviewed-by did not read
this email and are just rubber stamping crap.


Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBB7C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 01:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D87217D9
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 01:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfBSBZs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:25:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57082 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfBSBZs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Feb 2019 20:25:48 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 881F3108DE857;
        Mon, 18 Feb 2019 17:25:47 -0800 (PST)
Date:   Mon, 18 Feb 2019 17:25:44 -0800 (PST)
Message-Id: <20190218.172544.1436352995315454863.davem@davemloft.net>
To:     s-nazarov@yandex.ru
Cc:     paul@paul-moore.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] NETWORKING: avoid use IPCB in cipso_v4_error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1122331550497151@iva7-d29a8296bc3c.qloud-c.yandex.net>
References: <20190215.120009.1549205062473501080.davem@davemloft.net>
        <CAHC9VhRys7Efm=aQqph2ug9c8Ryra9imEG66avjeEeY8QZWTqw@mail.gmail.com>
        <1122331550497151@iva7-d29a8296bc3c.qloud-c.yandex.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Feb 2019 17:25:47 -0800 (PST)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Nazarov Sergey <s-nazarov@yandex.ru>
Date: Mon, 18 Feb 2019 16:39:11 +0300

> I think, it would not be a good solution, if I will analyze all
> subsystems using icmp_send, because I do not have enough knowledge
> for this.  I propose to add a new function, for example,
> ismp_send_safe, something like that:

Please don't do this.

Solve the problem properly by auditing each case, there aren't a lot and
it is not too difficult to see the upcall sites.

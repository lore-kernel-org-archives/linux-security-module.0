Return-Path: <SRS0=JoCX=A2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117CEC433E4
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 14:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9A320658
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 14:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgGOOpn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgGOOpn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Jul 2020 10:45:43 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30CCC061755;
        Wed, 15 Jul 2020 07:45:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4BEAE12A03D09;
        Wed, 15 Jul 2020 07:45:42 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:45:39 -0700 (PDT)
Message-Id: <20200715.074539.677001786168267326.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     paul@paul-moore.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] cipso: Remove unused inline functions
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200715021846.34096-1-yuehaibing@huawei.com>
References: <20200715021846.34096-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 15 Jul 2020 07:45:42 -0700 (PDT)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 15 Jul 2020 10:18:46 +0800

> They are not used any more since commit b1edeb102397 ("netlabel: Replace
> protocol/NetLabel linking with refrerence counts")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.

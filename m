Return-Path: <SRS0=t1H7=6H=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF65C55191
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Apr 2020 02:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C0B2075A
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Apr 2020 02:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgDWCzR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 Apr 2020 22:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgDWCzR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Apr 2020 22:55:17 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE71C03C1AA;
        Wed, 22 Apr 2020 19:55:17 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A8BC3127AFC5F;
        Wed, 22 Apr 2020 19:55:16 -0700 (PDT)
Date:   Wed, 22 Apr 2020 19:55:16 -0700 (PDT)
Message-Id: <20200422.195516.1807680263283768229.davem@davemloft.net>
To:     carnil@debian.org
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        paul@paul-moore.com, kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlabel: Kconfig: Update reference for NetLabel Tools
 project
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200422190753.2077110-1-carnil@debian.org>
References: <20200422190753.2077110-1-carnil@debian.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 22 Apr 2020 19:55:16 -0700 (PDT)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Salvatore Bonaccorso <carnil@debian.org>
Date: Wed, 22 Apr 2020 21:07:53 +0200

> The NetLabel Tools project has moved from http://netlabel.sf.net to a
> GitHub. Update to directly refer to the new home for the tools.
> 
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>

Applied.

Return-Path: <SRS0=Ul/Y=CS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E13FC43461
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Sep 2020 03:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4523B20EDD
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Sep 2020 03:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIIDFD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Sep 2020 23:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730108AbgIIDFA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Sep 2020 23:05:00 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2532FC061573;
        Tue,  8 Sep 2020 20:05:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0042511E3E4C3;
        Tue,  8 Sep 2020 19:48:11 -0700 (PDT)
Date:   Tue, 08 Sep 2020 20:04:58 -0700 (PDT)
Message-Id: <20200908.200458.328284475983758086.davem@davemloft.net>
To:     wanghai38@huawei.com
Cc:     paul@paul-moore.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH net-next] netlabel: Fix some kernel-doc warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200908140543.25514-1-wanghai38@huawei.com>
References: <20200908140543.25514-1-wanghai38@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Tue, 08 Sep 2020 19:48:12 -0700 (PDT)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Wang Hai <wanghai38@huawei.com>
Date: Tue, 8 Sep 2020 22:05:43 +0800

> Fixes the following W=1 kernel build warning(s):
> 
> net/netlabel/netlabel_calipso.c:438: warning: Excess function parameter 'audit_secid' description in 'calipso_doi_remove'
> net/netlabel/netlabel_calipso.c:605: warning: Excess function parameter 'reg' description in 'calipso_req_delattr'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Applied.

Return-Path: <SRS0=zmOV=CG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768DCC433E2
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Aug 2020 16:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58531207DF
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Aug 2020 16:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgH1QJO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1QJO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Aug 2020 12:09:14 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E63CC061264;
        Fri, 28 Aug 2020 09:09:14 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7FE321287C095;
        Fri, 28 Aug 2020 08:52:26 -0700 (PDT)
Date:   Fri, 28 Aug 2020 09:09:12 -0700 (PDT)
Message-Id: <20200828.090912.720183995781297697.davem@davemloft.net>
To:     alex.dewar90@gmail.com
Cc:     paul@paul-moore.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] netlabel: remove unused param from
 audit_log_format()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200828135523.12867-1-alex.dewar90@gmail.com>
References: <CAHC9VhRtTykJVze_93ed+n+v14Ai9J5Mbre9nGEc2rkqbqKc_g@mail.gmail.com>
        <20200828135523.12867-1-alex.dewar90@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Aug 2020 08:52:26 -0700 (PDT)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Alex Dewar <alex.dewar90@gmail.com>
Date: Fri, 28 Aug 2020 14:55:23 +0100

> Commit d3b990b7f327 ("netlabel: fix problems with mapping removal")
> added a check to return an error if ret_val != 0, before ret_val is
> later used in a log message. Now it will unconditionally print "...
> res=1". So just drop the check.
> 
> Addresses-Coverity: ("Dead code")
> Fixes: d3b990b7f327 ("netlabel: fix problems with mapping removal")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
> v2: Still print the res field, because it's useful (Paul)

Applied to net-next, thank you.

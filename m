Return-Path: <SRS0=p5JF=63=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2005C2D0F8
	for <linux-security-module@archiver.kernel.org>; Wed, 13 May 2020 01:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA8A20714
	for <linux-security-module@archiver.kernel.org>; Wed, 13 May 2020 01:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgEMBNu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 May 2020 21:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgEMBNu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 May 2020 21:13:50 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A57C061A0C;
        Tue, 12 May 2020 18:13:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8FD151287B5DC;
        Tue, 12 May 2020 18:13:45 -0700 (PDT)
Date:   Tue, 12 May 2020 18:13:42 -0700 (PDT)
Message-Id: <20200512.181342.2250607825098375089.davem@davemloft.net>
To:     pabeni@redhat.com
Cc:     netdev@vger.kernel.org, kuba@kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        ppandit@redhat.com, matthew.sheets@gd-ms.com
Subject: Re: [PATCH net] netlabel: cope with NULL catmap
From:   David Miller <davem@davemloft.net>
In-Reply-To: <07d99ae197bfdb2964931201db67b6cd0b38db5b.1589276729.git.pabeni@redhat.com>
References: <07d99ae197bfdb2964931201db67b6cd0b38db5b.1589276729.git.pabeni@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 May 2020 18:13:45 -0700 (PDT)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 12 May 2020 14:43:14 +0200

> The cipso and calipso code can set the MLS_CAT attribute on
> successful parsing, even if the corresponding catmap has
> not been allocated, as per current configuration and external
> input.
> 
> Later, selinux code tries to access the catmap if the MLS_CAT flag
> is present via netlbl_catmap_getlong(). That may cause null ptr
> dereference while processing incoming network traffic.
> 
> Address the issue setting the MLS_CAT flag only if the catmap is
> really allocated. Additionally let netlbl_catmap_getlong() cope
> with NULL catmap.
> 
> Reported-by: Matthew Sheets <matthew.sheets@gd-ms.com>
> Fixes: 4b8feff251da ("netlabel: fix the horribly broken catmap functions")
> Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the secattr.")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Applied and queued up for -stable, thanks.

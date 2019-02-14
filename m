Return-Path: <SRS0=hpNi=QV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85932C10F04
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Feb 2019 18:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9E52083E
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Feb 2019 18:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="oZzXiuXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbfBNSOI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:14:08 -0500
Received: from forward500o.mail.yandex.net ([37.140.190.195]:60930 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388972AbfBNSOI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Feb 2019 13:14:08 -0500
Received: from mxback21g.mail.yandex.net (mxback21g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:321])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 61FBA602AD;
        Thu, 14 Feb 2019 21:14:05 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback21g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id mC393i3HhK-E3Jm7YCS;
        Thu, 14 Feb 2019 21:14:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1550168044;
        bh=eYG4sRk+C9s432oxOV4ltqmANe2jjsw5BO4KOcBzxVg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=oZzXiuXm9Idbzr+i5nPTvPvWVPiPBlAv5OxeMusuS/xLyvdUZM7FOYD6dRIc8pOzG
         YQsA9jL1LdpbXtt7Tdk2QQ0gt2kD1QJxzOx+vyvjj9BpkMOWFp2pqQg0ujgcD5X1CB
         MI5JN/tWLDojucT1kxS3UGMDT2jpPL0v4JUBUJdE=
Authentication-Results: mxback21g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva6-7bf5cb2fcad9.qloud-c.yandex.net with HTTP;
        Thu, 14 Feb 2019 21:14:03 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>
In-Reply-To: <20190214.084343.1138362153341500718.davem@davemloft.net>
References: <34948711549920080@myt1-06117f29c1ea.qloud-c.yandex.net>
        <CAHC9VhSDot+uNDi7ULoT7dry4FW9Jgp=NcqDh6TmA=z--kmqkA@mail.gmail.com>
        <6691891549984203@myt5-a323eb993ef7.qloud-c.yandex.net> <20190214.084343.1138362153341500718.davem@davemloft.net>
Subject: Re: [PATCH] NETWORKING: avoid use IPCB in cipso_v4_error
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 14 Feb 2019 21:14:03 +0300
Message-Id: <372221550168043@iva6-7bf5cb2fcad9.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Now the problem comes from TCP layer only. Is the IP over ATM operates over IP layer?

14.02.2019, 19:43, "David Miller" <davem@davemloft.net>:
> From: Nazarov Sergey <s-nazarov@yandex.ru>
> Date: Tue, 12 Feb 2019 18:10:03 +0300
>
>>  Since cipso_v4_error might be called from different network stack layers, we can't safely use icmp_send there.
>>  icmp_send copies IP options with ip_option_echo, which uses IPCB to take access to IP header compiled data.
>>  But after commit 971f10ec ("tcp: better TCP_SKB_CB layout to reduce cache line misses"), IPCB can't be used
>>  above IP layer.
>>  This patch fixes the problem by creating in cipso_v4_error a local copy of compiled IP options and using it with
>>  introduced __icmp_send function. This looks some overloaded, but in quite rare error conditions only.
>>
>>  The original discussion is here:
>>  https://lore.kernel.org/linux-security-module/16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net/
>>
>>  Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
>
> This problem is not unique to Cipso, net/atm/clip.c's error handler
> has the same exact issue.
>
> I didn't scan more of the tree, there are probably a couple more
> locations as well.

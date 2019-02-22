Return-Path: <SRS0=OQ6N=Q5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F55FC43381
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 17:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E33A206B6
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 17:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="snZQJGU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfBVRje (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:39:34 -0500
Received: from forward501o.mail.yandex.net ([37.140.190.203]:57401 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbfBVRje (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Feb 2019 12:39:34 -0500
Received: from mxback16o.mail.yandex.net (mxback16o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::67])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 865811E806E1;
        Fri, 22 Feb 2019 20:39:31 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback16o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id WqByUPjdOh-dTVi4KeV;
        Fri, 22 Feb 2019 20:39:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1550857170;
        bh=VnhnVVVH7AkKeRsYirSsd3Ju9l2A/lmVfmH1Dfs1wi4=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=snZQJGU5h+XyRYbLf8parOaDkam7f99Itg2ZaXMd/+DgyXqml/1U3bPv6WrO9dDoY
         uu/Mh/pyphEyiAPsV1GJS0AkCiQh03popz/427cKTr8ag2BW07vFtNq5gnuEtl7EGi
         voX/1d6mWlLn8bXsgn+MsRIoTYMnJ++EBQV8N/aM=
Authentication-Results: mxback16o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt3-2475c4d2af83.qloud-c.yandex.net with HTTP;
        Fri, 22 Feb 2019 20:39:29 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     David Miller <davem@davemloft.net>
Cc:     "paul@paul-moore.com" <paul@paul-moore.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
In-Reply-To: <8873761550853329@myt6-67cd1de25d8a.qloud-c.yandex.net>
References: <20190215.120009.1549205062473501080.davem@davemloft.net>
                <CAHC9VhRys7Efm=aQqph2ug9c8Ryra9imEG66avjeEeY8QZWTqw@mail.gmail.com>
                <1122331550497151@iva7-d29a8296bc3c.qloud-c.yandex.net> <20190218.172544.1436352995315454863.davem@davemloft.net> <8873761550853329@myt6-67cd1de25d8a.qloud-c.yandex.net>
Subject: [PATCH v2 0/2] NETWORKING: avoid use IPCB in cipso_v4_error
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 22 Feb 2019 20:39:29 +0300
Message-Id: <33533951550857169@myt3-2475c4d2af83.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The original discussion is here:
https://lore.kernel.org/linux-security-module/16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net/

Changes in v2:
- original patch divided on 2 parts: add __icmp_send function, fix cipso_v4_error
- add __ip_option_compile not using icmp_send in case nof error
---
 include/net/icmp.h    |    9 ++++++++-
 include/net/ip.h      |    2 ++
 net/ipv4/cipso_ipv4.c |   17 +++++++++++++++--
 net/ipv4/icmp.c       |    7 ++++---
 net/ipv4/ip_options.c |   22 +++++++++++++++++-----
 5 files changed, 46 insertions(+), 11 deletions(-)


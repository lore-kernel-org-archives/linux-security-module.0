Return-Path: <SRS0=OQ6N=Q5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD67CC43381
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 16:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0B72070B
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 16:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="XAG57Xip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfBVQff (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:35:35 -0500
Received: from forward500o.mail.yandex.net ([37.140.190.195]:58126 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbfBVQff (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Feb 2019 11:35:35 -0500
Received: from mxback12g.mail.yandex.net (mxback12g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:91])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 1904D60176;
        Fri, 22 Feb 2019 19:35:32 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback12g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id YvpkpNmxm7-ZTZKnNxQ;
        Fri, 22 Feb 2019 19:35:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1550853330;
        bh=V3o45Ytf3p3mPNz1U1h0fwqBSudVNYihF92NiszsSUo=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=XAG57XipNklVHkKSDEU9s0EX/outbEDEtti7DVinY7L/vNDXJcpzE1nZKgfSg+Dbk
         ptvHvoK6JRPcUBMyLNQEoCQMLuK+8mJIOwFS4yr2PR9uMjXaNg746avSX3y0V/fyz+
         vPbm3RvhE0h0KLjITyKEQ1WAuCUJ8UV9Hm+rMNL4=
Authentication-Results: mxback12g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt6-67cd1de25d8a.qloud-c.yandex.net with HTTP;
        Fri, 22 Feb 2019 19:35:29 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     David Miller <davem@davemloft.net>
Cc:     "paul@paul-moore.com" <paul@paul-moore.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
In-Reply-To: <20190218.172544.1436352995315454863.davem@davemloft.net>
References: <20190215.120009.1549205062473501080.davem@davemloft.net>
        <CAHC9VhRys7Efm=aQqph2ug9c8Ryra9imEG66avjeEeY8QZWTqw@mail.gmail.com>
        <1122331550497151@iva7-d29a8296bc3c.qloud-c.yandex.net> <20190218.172544.1436352995315454863.davem@davemloft.net>
Subject: Re: [PATCH] NETWORKING: avoid use IPCB in cipso_v4_error
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 22 Feb 2019 19:35:29 +0300
Message-Id: <8873761550853329@myt6-67cd1de25d8a.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I tried to analyze the cases of using icmp_send in kernel. It indirectly used by many protocols:
ARP, IP, UDP, Netfilter, IPVS, IPIP, GRE over IP, CLIP, XFRM, CIPSOv4.
Different IP tunnels and XFRM operating directly over IP layer and if using own skb->cb data,
having IP header data in front of it. CLIP uses icmp_send for packets from arp queue only.
So, If I right, only TCP layer moves IP header data and only CIPSOv4 operates on both IP and
TCP layers now. 

19.02.2019, 04:25, "David Miller" <davem@davemloft.net>:
> From: Nazarov Sergey <s-nazarov@yandex.ru>
> Date: Mon, 18 Feb 2019 16:39:11 +0300
>
>>  I think, it would not be a good solution, if I will analyze all
>>  subsystems using icmp_send, because I do not have enough knowledge
>>  for this. I propose to add a new function, for example,
>>  ismp_send_safe, something like that:
>
> Please don't do this.
>
> Solve the problem properly by auditing each case, there aren't a lot and
> it is not too difficult to see the upcall sites.

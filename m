Return-Path: <SRS0=ihUA=PX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AACC43387
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 17:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47E920657
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 17:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="u7bNY+4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfAORO1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:14:27 -0500
Received: from forward103o.mail.yandex.net ([37.140.190.177]:39153 "EHLO
        forward103o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728566AbfAORO1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Jan 2019 12:14:27 -0500
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 12:14:26 EST
Received: from mxback15j.mail.yandex.net (mxback15j.mail.yandex.net [IPv6:2a02:6b8:0:1619::91])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 09E075F83319
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jan 2019 20:06:25 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback15j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 6TRAB6xMWK-6OxaYo6x;
        Tue, 15 Jan 2019 20:06:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1547571984;
        bh=h4lpOmn8d+Y3GNhIhtma3XNkvjs/AfuKxZCGanEQ9Yk=;
        h=From:To:Subject:Date:Message-Id;
        b=u7bNY+4VijSZHIpx5xXx5DnBvNWHnKKGb8g6WNFru7V8X4LmhpmzNqP/oe3FpLWa1
         zojt9/IlJ4Ndu3X0vpeay35OcJjkBYLRhg97TnT6iXz/JCrbscr7Db7CTYwBOS7dZ1
         hfLllAx0fCO+JZB8CuG3rJe/i6/5F9dt3tDkYR1A=
Authentication-Results: mxback15j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-890ba5c2334a.qloud-c.yandex.net with HTTP;
        Tue, 15 Jan 2019 20:06:24 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     linux-security-module@vger.kernel.org
Subject: Kernel memory corruption in CIPSO labeled TCP packets processing.
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 15 Jan 2019 20:06:24 +0300
Message-Id: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello!
Security modules (selinux, smack) use icmp_send for discarded incorrectly labeled network packets.
This could be on TCP level too (security_sock_rcv_skb -> cipso_v4_error for INET stream connection, for example).
icmp_send calls ip_option_echo, which uses IPCB to take compiled IP options.
After moving IP header data to the end of the struct tcp_skb_cb (since 3.18 kernel), this could lead to
kernel memory corruption when IP options copying.
This patch fix a bug, but I'm not sure, that this is a best solution. Perhaps someone more familiar with the
linux TCP/IP stack will offer a better one.
Thanks.

--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -679,7 +679,8 @@ void icmp_send(struct sk_buff *skb_in, i
 					  iph->tos;
 	mark = IP4_REPLY_MARK(net, skb_in->mark);
 
-	if (ip_options_echo(&icmp_param->replyopts.opt.opt, skb_in))
+	if (__ip_options_echo(&icmp_param->replyopts.opt.opt, skb_in,
+			ip_hdr(skb_in)->protocol == IPPROTO_TCP ? &TCP_SKB_CB(skb_in)->header.h4.opt : &IPCB(skb_in)->opt))
 		goto out_unlock;


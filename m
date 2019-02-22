Return-Path: <SRS0=OQ6N=Q5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C63C43381
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 17:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058E9206BA
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 17:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="inIW2UE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfBVRoE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:44:04 -0500
Received: from forward501j.mail.yandex.net ([5.45.198.251]:50729 "EHLO
        forward501j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727430AbfBVRoE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Feb 2019 12:44:04 -0500
Received: from mxback20j.mail.yandex.net (mxback20j.mail.yandex.net [IPv6:2a02:6b8:0:1619::114])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id A22DA33801C6;
        Fri, 22 Feb 2019 20:43:59 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback20j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id yiHEw8J9WJ-hvomR2fb;
        Fri, 22 Feb 2019 20:43:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1550857438;
        bh=H7m3LnaTgD03cJ6q26K1IaQWT2eXiOos88md3Aw0epw=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=inIW2UE1ijbZVEIqnT7yJo+BgFSiLksl4joDQAvE8hUlJ4IN2MKtabfXXTJsNXOxY
         FuqvDZ/gzhSyfqJqqrvtotxh1IOjbu7zKJzo1tX9S7QzN/f8yfeeILEzNkDQtt1cKX
         RPoh1tc+YbI+hn5zthUNQxU5VKXgBsxkNZNc5ybA=
Authentication-Results: mxback20j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt3-1179f584969c.qloud-c.yandex.net with HTTP;
        Fri, 22 Feb 2019 20:43:57 +0300
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
Subject: Re: [PATCH v2 1/2] NETWORKING: avoid use IPCB in cipso_v4_error
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 22 Feb 2019 20:43:57 +0300
Message-Id: <9748781550857437@myt3-1179f584969c.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add __icmp_send function having ip_options struct parameter
---
 include/net/icmp.h    |    9 ++++++++-
 net/ipv4/icmp.c       |    7 ++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/icmp.h b/include/net/icmp.h
index 6ac3a5b..e0f709d 100644
--- a/include/net/icmp.h
+++ b/include/net/icmp.h
@@ -22,6 +22,7 @@
 
 #include <net/inet_sock.h>
 #include <net/snmp.h>
+#include <net/ip.h>
 
 struct icmp_err {
   int		errno;
@@ -39,7 +40,13 @@ struct icmp_err {
 struct sk_buff;
 struct net;
 
-void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info);
+void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
+		 const struct ip_options *opt);
+static inline void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
+{
+	__icmp_send(skb_in, type, code, info, &IPCB(skb_in)->opt);
+}
+
 int icmp_rcv(struct sk_buff *skb);
 int icmp_err(struct sk_buff *skb, u32 info);
 int icmp_init(void);
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 065997f..3f24414 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -570,7 +570,8 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
  *			MUST reply to only the first fragment.
  */
 
-void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
+void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
+		 const struct ip_options *opt)
 {
 	struct iphdr *iph;
 	int room;
@@ -691,7 +692,7 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 					  iph->tos;
 	mark = IP4_REPLY_MARK(net, skb_in->mark);
 
-	if (ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in))
+	if (__ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in, opt))
 		goto out_unlock;
 
 
@@ -742,7 +743,7 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 	local_bh_enable();
 out:;
 }
-EXPORT_SYMBOL(icmp_send);
+EXPORT_SYMBOL(__icmp_send);
 
 
 static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
---

Return-Path: <SRS0=Ku0V=RA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8157FC43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 16:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1732D2083D
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 16:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="iyCNh9HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfBYQYV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:24:21 -0500
Received: from forward500j.mail.yandex.net ([5.45.198.250]:58442 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727684AbfBYQYV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Feb 2019 11:24:21 -0500
Received: from mxback19j.mail.yandex.net (mxback19j.mail.yandex.net [IPv6:2a02:6b8:0:1619::95])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id D7A6F11C17B4;
        Mon, 25 Feb 2019 19:24:16 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback19j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id baqPwYKFFv-OF1eataE;
        Mon, 25 Feb 2019 19:24:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1551111856;
        bh=RbQFsHbfgaKGnwDtKHd+fgkwRH2XIk4TRkcnvu6pJes=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=iyCNh9HOpWdP7WVFtiY10rm42P19s6SOMXghY0wjVjy0aC51VAzI4iD+D4/WJVO8z
         Nkx7pK5KSpiJuQ58SC/OFohyA1TfBq/28bgrbjLQaIk2Wd7jUUDjYqJmacXbhPoo7Q
         Pc0KZrS1B6LnA7XCDp0lSTxdeNNkcfStxwDy7qko=
Authentication-Results: mxback19j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-f1576e7b5bad.qloud-c.yandex.net with HTTP;
        Mon, 25 Feb 2019 19:24:15 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     David Miller <davem@davemloft.net>
Cc:     "paul@paul-moore.com" <paul@paul-moore.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
In-Reply-To: <20190224.173328.1032826011262803545.davem@davemloft.net>
References: <20190218.172544.1436352995315454863.davem@davemloft.net>
                <8873761550853329@myt6-67cd1de25d8a.qloud-c.yandex.net>
                <33533951550857169@myt3-2475c4d2af83.qloud-c.yandex.net> <20190224.173328.1032826011262803545.davem@davemloft.net>
Subject: [PATCH v2 1/2] NETWORKING: avoid use IPCB in cipso_v4_error
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 25 Feb 2019 19:24:15 +0300
Message-Id: <52295911551111855@myt5-f1576e7b5bad.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add __icmp_send function having ip_options struct parameter

Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
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


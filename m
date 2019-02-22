Return-Path: <SRS0=OQ6N=Q5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0645C10F00
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 17:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C266020700
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 17:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SOOlU7iD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfBVRuy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:50:54 -0500
Received: from forward500j.mail.yandex.net ([5.45.198.250]:41623 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbfBVRux (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Feb 2019 12:50:53 -0500
Received: from mxback20j.mail.yandex.net (mxback20j.mail.yandex.net [IPv6:2a02:6b8:0:1619::114])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 1B56711C1211;
        Fri, 22 Feb 2019 20:50:50 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback20j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id fRFHKTA5Kf-onoagYCf;
        Fri, 22 Feb 2019 20:50:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1550857849;
        bh=NnVu9Ytzp4iOcB0eRByhSscZMhdVglqrlL0EAhqQ9Ac=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=SOOlU7iDXZXwueCJ6h7ndzwRshb6WdugxQPhmEEKokpT7NWFwjXeH8cjBk3g1KP4S
         o1qG1qU4BtxrLqtt2J3gzG+e8M2L6x0KSkhKLqHNtZrGpP/09ae0vQwxm6T0L6MV0C
         PVu1ZWytDAWz8wCENfZTtZ8bL6gVic8ZGTY4g1ps=
Authentication-Results: mxback20j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-23a37bc8251c.qloud-c.yandex.net with HTTP;
        Fri, 22 Feb 2019 20:50:49 +0300
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
Subject: Re: [PATCH v2 2/2] NETWORKING: avoid use IPCB in cipso_v4_error
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 22 Feb 2019 20:50:49 +0300
Message-Id: <25203411550857849@sas1-23a37bc8251c.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Extract IP options in cipso_v4_error and use __icmp_send.
---
 include/net/ip.h      |    2 ++
 net/ipv4/cipso_ipv4.c |   17 +++++++++++++++--
 net/ipv4/ip_options.c |   22 +++++++++++++++++-----
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 8866bfc..f0e8d06 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -667,6 +667,8 @@ static inline int ip_options_echo(struct net *net, struct ip_options *dopt,
 }
 
 void ip_options_fragment(struct sk_buff *skb);
+int __ip_options_compile(struct net *net, struct ip_options *opt,
+			 struct sk_buff *skb, __be32 *info);
 int ip_options_compile(struct net *net, struct ip_options *opt,
 		       struct sk_buff *skb);
 int ip_options_get(struct net *net, struct ip_options_rcu **optp,
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 777fa3b..eff86a7 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1735,13 +1735,26 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
  */
 void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 {
+	unsigned char optbuf[sizeof(struct ip_options) + 40];
+	struct ip_options *opt = (struct ip_options *)optbuf;
+
 	if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
 		return;
 
+	/*
+	 * We might be called above the IP layer,
+	 * so we can not use icmp_send and IPCB here.
+	 */
+
+	memset(opt, 0, sizeof(struct ip_options));
+	opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
+	if (__ip_options_compile(dev_net(skb->dev), opt, skb, NULL))
+		return;
+
 	if (gateway)
-		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, opt);
 	else
-		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, opt);
 }
 
 /**
diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index ed194d4..32a3504 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -251,8 +251,9 @@ static void spec_dst_fill(__be32 *spec_dst, struct sk_buff *skb)
  * If opt == NULL, then skb->data should point to IP header.
  */
 
-int ip_options_compile(struct net *net,
-		       struct ip_options *opt, struct sk_buff *skb)
+int __ip_options_compile(struct net *net,
+			 struct ip_options *opt, struct sk_buff *skb,
+			 __be32 *info)
 {
 	__be32 spec_dst = htonl(INADDR_ANY);
 	unsigned char *pp_ptr = NULL;
@@ -468,11 +469,22 @@ int ip_options_compile(struct net *net,
 		return 0;
 
 error:
-	if (skb) {
-		icmp_send(skb, ICMP_PARAMETERPROB, 0, htonl((pp_ptr-iph)<<24));
-	}
+	if (info)
+		*info = htonl((pp_ptr-iph)<<24);
 	return -EINVAL;
 }
+
+int ip_options_compile(struct net *net,
+		       struct ip_options *opt, struct sk_buff *skb)
+{
+	int ret;
+	__be32 info;
+
+	ret = __ip_options_compile(net, opt, skb, &info);
+	if (ret != 0 && skb)
+		icmp_send(skb, ICMP_PARAMETERPROB, 0, info);
+	return ret;
+}
 EXPORT_SYMBOL(ip_options_compile);
 
 /*
---

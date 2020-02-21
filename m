Return-Path: <SRS0=8B0L=4J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183D4C35647
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Feb 2020 11:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B8A222C4
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Feb 2020 11:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ak0TCNc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgBUL3E (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:29:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57404 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727513AbgBUL2p (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Feb 2020 06:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582284524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=leGu2vftUGPfPVaePqQJmsHbI2GoxR4hxMsr03GFDDo=;
        b=Ak0TCNc4YnEzbp9cT6oDu3jNwRgioL2Aav3cD2hTEIWN7qVpItr0BXDYb4EnU7pC2Mlh8c
        f8OQC3ceHePyBuGtjRsEQYA4VqUM43rWziYYVBnaAdYgKHkBFoMqsywlhvQ3nRJJfDGCDM
        L9Y8HiXmF5+dju5xU702W7nctg5OnG0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-1ql5m6UhOviZrKK6uDGPpg-1; Fri, 21 Feb 2020 06:28:42 -0500
X-MC-Unique: 1ql5m6UhOviZrKK6uDGPpg-1
Received: by mail-wr1-f70.google.com with SMTP id t6so901377wru.3
        for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2020 03:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=leGu2vftUGPfPVaePqQJmsHbI2GoxR4hxMsr03GFDDo=;
        b=gpXhA5JMRMvccWXg+Oa0P8JmO9et79JcLOFjthjoOz4pOgXlWOLk+GeVqYBlY6kalt
         nKF48O7T4z8vCf7xrxi/Lu7A9Dt92oqHVKYBWQVOMs1kwIHfUaBv2QfMZy9PcJPFzQYd
         rGVG6JDBhlr0XP2MPA/uo5dUt+CATjlrr0mIGE6ShWntUU0++j7SCADNBENbXiJ9J8v3
         OjdALSHtLwiZFP8S0P1ut8IY5/MpBovUlhG61O8Nuo4dp3nAW4yFgcsKbNU2jhM9heqO
         Sn0U6268sAhsviV7ZA3T9mFTiaCIIgze42jAt0MkRGiPA6bjSbx/LrBJexiQl3tF50Ga
         k6eA==
X-Gm-Message-State: APjAAAWINr+SuyL51pktUhCc9Iedgf4thC8PxoEN4H/BMSzobIRgx7Lu
        UR6CWqM658dTsY+F7zMi84405whlglSCwNGw1K8nJT+5Vfvmja3pVguSpl1AqETsTjN7AvzrY0J
        8p9HhgkaUC8uygxaOgMS1HcqF90u4Zcnc1ZG0
X-Received: by 2002:a5d:538e:: with SMTP id d14mr50171471wrv.358.1582284521807;
        Fri, 21 Feb 2020 03:28:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpigxZVCabTqXi0Dp83mSJlYtrChLQUry58+gL+r8n8CHFpPJ+m2ty2tYlWkrhlbzsM2FfGA==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr50171449wrv.358.1582284521543;
        Fri, 21 Feb 2020 03:28:41 -0800 (PST)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id a26sm3408087wmm.18.2020.02.21.03.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 03:28:41 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH net] ipv4: ensure rcu_read_lock() in cipso_v4_error()
Date:   Fri, 21 Feb 2020 12:28:38 +0100
Message-Id: <20200221112838.11324-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Similarly to commit c543cb4a5f07 ("ipv4: ensure rcu_read_lock() in
ipv4_link_failure()"), __ip_options_compile() must be called under rcu
protection.

Fixes: 3da1ed7ac398 ("net: avoid use IPCB in cipso_v4_error")
Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 net/ipv4/cipso_ipv4.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 376882215919..0bd10a1f477f 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1724,6 +1724,7 @@ void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 {
 	unsigned char optbuf[sizeof(struct ip_options) + 40];
 	struct ip_options *opt = (struct ip_options *)optbuf;
+	int res;
 
 	if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
 		return;
@@ -1735,7 +1736,11 @@ void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 
 	memset(opt, 0, sizeof(struct ip_options));
 	opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
-	if (__ip_options_compile(dev_net(skb->dev), opt, skb, NULL))
+	rcu_read_lock();
+	res = __ip_options_compile(dev_net(skb->dev), opt, skb, NULL);
+	rcu_read_unlock();
+
+	if (res)
 		return;
 
 	if (gateway)
-- 
2.24.1


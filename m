Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055A0C83F1E
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Aug 2023 13:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbjH2Nfz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Aug 2023 09:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjH2NfD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Aug 2023 09:35:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E811610CE;
        Tue, 29 Aug 2023 06:34:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE51165847;
        Tue, 29 Aug 2023 13:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069FCC433B8;
        Tue, 29 Aug 2023 13:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693316062;
        bh=YrwCpJZSWC1PZyYZHEuMGl4rPreiRh68+7VqcMTGVJs=;
        h=From:To:Cc:Subject:Date:From;
        b=jiQ8jTTn93MIDdoU+hVisL8LcZDf6KwScyQyig0hzAP+VYfWJfW4Qdr0zPXlSZhhv
         CL7dEo9w+aW3qeHuXZ5qBw4GSLYeX+Tkxt3SQuWCqfk175F4H5Q2XhytdLbg42wp1D
         zFbFQQHRvRBqAV6mkAB97Xev2z+hhbhm8rKRr+N1Y0jY/DEfnyqBkk2QoIcDiOUZZm
         qzOuIvScmhVCaMiRtfJAFv3zqgjP1OkP4JZ3r+71s4i6KNFuc/1thVJvNK0Betorvu
         WTnCSFQ4/amND1ZV+3VXnaMdSfM2qzMli8Hr1JE4sEiJfStDi0VyZQkUJTW4iy0DT2
         cZpVoGBnuwVYQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Mastykin <dmastykin@astralinux.ru>,
        Paul Moore <paul@paul-moore.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 1/5] netlabel: fix shift wrapping bug in netlbl_catmap_setlong()
Date:   Tue, 29 Aug 2023 09:34:14 -0400
Message-Id: <20230829133419.520830-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.323
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Dmitry Mastykin <dmastykin@astralinux.ru>

[ Upstream commit b403643d154d15176b060b82f7fc605210033edd ]

There is a shift wrapping bug in this code on 32-bit architectures.
NETLBL_CATMAP_MAPTYPE is u64, bitmap is unsigned long.
Every second 32-bit word of catmap becomes corrupted.

Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlabel/netlabel_kapi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 15fe2120b3109..14c3d640f94b9 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -871,7 +871,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 
 	offset -= iter->startbit;
 	idx = offset / NETLBL_CATMAP_MAPSIZE;
-	iter->bitmap[idx] |= bitmap << (offset % NETLBL_CATMAP_MAPSIZE);
+	iter->bitmap[idx] |= (NETLBL_CATMAP_MAPTYPE)bitmap
+			     << (offset % NETLBL_CATMAP_MAPSIZE);
 
 	return 0;
 }
-- 
2.40.1


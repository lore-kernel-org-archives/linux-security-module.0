Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566ABC433EF
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Nov 2021 01:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C1E619E5
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Nov 2021 01:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbhKIBUd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Nov 2021 20:20:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242035AbhKIBRT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Nov 2021 20:17:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5729D61A53;
        Tue,  9 Nov 2021 01:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636420024;
        bh=ULKQ63rfbo3UsSQPS/WJaTvKPIUI/gelpcCUQyW5j8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKX8uE7N23yh7RmtA0dKJIGzCvxhAgVAUlMihGkPdTNSs88ODkwmX0Fugn4r9Jh7P
         qtds3CRYUEgx5RDQyrVy9b7gjBST7QA6tHcLiqgeTuxr1JWN4/ox0beo3OqiWppuM+
         eLwT5H9us4atK5OnELEmWjNmj5/YzERCpASgbKjnBb5ur8AYEfWfFPYpWWrTkzsaTu
         Cbz/4s3rZX/RKF3jFnbCkXg0jCJzTuTpNhcgxEjAjowVEripO9W2h2pzmyqGdioaLx
         xjCRlEye463wL2dHPbwVMmHM5nuMh0CP2jSFu/JK9XbxN3YDnj6Eotav1OcXIcKeO1
         iBxrxtZ4RsdKg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     wangzhitong <wangzhitong@uniontech.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, paul@paul-moore.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 08/39] NET: IPV4: fix error "do not initialise globals to 0"
Date:   Mon,  8 Nov 2021 20:06:18 -0500
Message-Id: <20211109010649.1191041-8-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109010649.1191041-1-sashal@kernel.org>
References: <20211109010649.1191041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: wangzhitong <wangzhitong@uniontech.com>

[ Upstream commit db9c8e2b1e246fc2dc20828932949437793146cc ]

this patch fixes below Errors reported by checkpatch
    ERROR: do not initialise globals to 0
    +int cipso_v4_rbm_optfmt = 0;

Signed-off-by: wangzhitong <wangzhitong@uniontech.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/cipso_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index e8b8dd1cb1576..75908722de47a 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -87,7 +87,7 @@ struct cipso_v4_map_cache_entry {
 static struct cipso_v4_map_cache_bkt *cipso_v4_cache;
 
 /* Restricted bitmap (tag #1) flags */
-int cipso_v4_rbm_optfmt = 0;
+int cipso_v4_rbm_optfmt;
 int cipso_v4_rbm_strictvalid = 1;
 
 /*
-- 
2.33.0


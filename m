Return-Path: <SRS0=N365=CX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8E3C43461
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Sep 2020 03:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544B6206DC
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Sep 2020 03:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgINDzl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 13 Sep 2020 23:55:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgINDzV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 13 Sep 2020 23:55:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 47903B950912B593501C;
        Mon, 14 Sep 2020 11:55:16 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 11:55:08 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>
CC:     <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] dh key: convert to use be32_add_cpu()
Date:   Mon, 14 Sep 2020 12:17:47 +0800
Message-ID: <20200914041747.3701948-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Convert cpu_to_be32(be32_to_cpu(E1) + E2) to use be32_add_cpu().

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 security/keys/dh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index 1abfa70ed6e1..2635cb8a4561 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -186,7 +186,7 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 
 		dlen -= h;
 		dst += h;
-		counter = cpu_to_be32(be32_to_cpu(counter) + 1);
+		be32_add_cpu(&counter, 1);
 	}
 
 	return 0;
-- 
2.25.1


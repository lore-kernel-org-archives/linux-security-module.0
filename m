Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C75C433E9
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 21:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1CB64F7A
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 21:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhCDVIm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Mar 2021 16:08:42 -0500
Received: from forward106j.mail.yandex.net ([5.45.198.249]:43562 "EHLO
        forward106j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232783AbhCDVIQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Mar 2021 16:08:16 -0500
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Mar 2021 16:08:16 EST
Received: from myt6-08ca0b879dee.qloud-c.yandex.net (myt6-08ca0b879dee.qloud-c.yandex.net [IPv6:2a02:6b8:c12:12a2:0:640:8ca:b87])
        by forward106j.mail.yandex.net (Yandex) with ESMTP id C8FA011A1E2F;
        Fri,  5 Mar 2021 00:00:35 +0300 (MSK)
Received: from myt4-1dda227af9a8.qloud-c.yandex.net (myt4-1dda227af9a8.qloud-c.yandex.net [2a02:6b8:c00:3c83:0:640:1dda:227a])
        by myt6-08ca0b879dee.qloud-c.yandex.net (mxback/Yandex) with ESMTP id bEfUEi5c0f-0ZIevlLw;
        Fri, 05 Mar 2021 00:00:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1614891635;
        bh=3rPjrwxrEVgpaHB6N+yIOThtPeCym9diXjVw4FDmECw=;
        h=Cc:To:From:Subject:Message-ID:Date;
        b=cYH/WGh/nsLedP2wO/CjgN3E/AGld+4Hk1beGyAzfZWtD9+e4BnyifesugkLw9EOT
         0/vhRAP0EfIk2uc0kcCskyp58BI4RMJg/zn5UoXNfFGliczxlfGrBFIo8Zj7payQGN
         L1DY868k85fpB3bA7oklRCejupAP81UNKcUfIJxc=
Authentication-Results: myt6-08ca0b879dee.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt4-1dda227af9a8.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id rq1LZBqaSJ-0YnqNlXL;
        Fri, 05 Mar 2021 00:00:34 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Message-ID: <a93d1b4c1d027d037ec341eabfc8e7920e589a49.camel@yandex.ru>
Subject: [PATCH] CIPSO: Fix unaligned memory access in cipso_v4_gentag_hdr
From:   Seergey Nazarov <s-nazarov@yandex.ru>
To:     linux-security-module@vger.kernel.org
Cc:     paul@paul-moore.com
Date:   Fri, 05 Mar 2021 00:00:32 +0300
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

We need to use put_unaligned when writing 32-bit DOI value
in cipso_v4_gentag_hdr to avoid unaligned memory access.

Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
---
 net/ipv4/cipso_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 471d33a..28dfe40 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1162,7 +1162,7 @@ static void cipso_v4_gentag_hdr(const struct
cipso_v4_doi *doi_def,
 {
 	buf[0] = IPOPT_CIPSO;
 	buf[1] = CIPSO_V4_HDR_LEN + len;
-	*(__be32 *)&buf[2] = htonl(doi_def->doi);
+	put_unaligned_be32(doi_def->doi, (__be32 *)&buf[2]);
 }
 
 /**
-- 
1.8.3.1



Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15479C433F5
	for <linux-security-module@archiver.kernel.org>; Thu, 12 May 2022 06:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350149AbiELGUV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 May 2022 02:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347424AbiELGUU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 May 2022 02:20:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12AB222C35
        for <linux-security-module@vger.kernel.org>; Wed, 11 May 2022 23:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2e8X21nKPcQgvz9UXWL0zk5b2nxs/yzM+chK1IEMLUc=; b=2MKwxhq9nb12lfCnhV8S2gM9N3
        lggxlkyENL6qMd5FdBo4sqB9wUmAt0j5YI5xyiH5sA1R6gNsutmcnhuriv8ytSMZXoH+TSioQgeYj
        9wx318SuaxeHLkH7Qu3rpRLQ0k0NLUePsCnNVjttxUeETL/6LKotGFXtGoVrYL88nR159kgxslvBH
        /KQ3oT3fVSBllKT376BLPsag0JZ380sY2tEqMM/qT5YCyZ3cNi+SCuNMqObv9JTAXtefaf9deFihA
        wh7bRKaTHX7beYlA7+b/6vnltIwAG0CrSRIgGrI0IA0y42AAcBF+rWoKLkz5SHhPHz+iiL9hmU2t7
        gDWbEY+w==;
Received: from [2001:4bb8:184:7881:71e:a8b6:a4d4:1744] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1np2BM-00ANOv-Nl; Thu, 12 May 2022 06:20:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     keescook@chromium.org
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org
Subject: [PATCH] loadpin: stop using bdevname
Date:   Thu, 12 May 2022 08:20:14 +0200
Message-Id: <20220512062014.1826835-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use the %pg format specifier to save on stack consuption and code size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 security/loadpin/loadpin.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e3..ad4e6756c0386 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -78,11 +78,8 @@ static void check_pinning_enforcement(struct super_block *mnt_sb)
 	 * device, allow sysctl to change modes for testing.
 	 */
 	if (mnt_sb->s_bdev) {
-		char bdev[BDEVNAME_SIZE];
-
 		ro = bdev_read_only(mnt_sb->s_bdev);
-		bdevname(mnt_sb->s_bdev, bdev);
-		pr_info("%s (%u:%u): %s\n", bdev,
+		pr_info("%pg (%u:%u): %s\n", mnt_sb->s_bdev,
 			MAJOR(mnt_sb->s_bdev->bd_dev),
 			MINOR(mnt_sb->s_bdev->bd_dev),
 			ro ? "read-only" : "writable");
-- 
2.30.2


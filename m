Return-Path: <SRS0=gDDV=6W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F26DC54E49
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 09:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB34208CA
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 09:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hy8jbfxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgEHJWr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 May 2020 05:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgEHJWp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 May 2020 05:22:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC34C05BD43;
        Fri,  8 May 2020 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=v2d8pva8LsFTXWqDIrLlQ4NNcDJbw9ZGB5N3mHruM2Q=; b=hy8jbfxBdHRLA63hXlAM8XAENS
        gGYr4RCSkaLOb23GrcvL4ap/hgUcbFR8px9M6FibgZvYzAORKvw5/sirIfzb5hrJzqKwdHvTH+U5u
        bgYMzjpOchyC1Pz5lekkCleC8Dz+efnHbIdY/QNpHZ81n0St9GOqsfAhf5C7zW2mWet1EG9W6P56g
        vWlKWTXudBRjvFIR7/a62Ghnrn4rjNJg0YslRaiU4qwZC0jHHKt0VNdk1GRK1ttGG564UqqnqtLAN
        55ahucBgZ5nf0aZHmcGyH2MErwpXIjAl9pV7vyPv3caHKDphDIeyRJRyhoGuDCJw/druVeDSa2FSR
        jSvB6nXA==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWzDR-000084-0I; Fri, 08 May 2020 09:22:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 08/11] integrity/ima: switch to using __kernel_read
Date:   Fri,  8 May 2020 11:22:19 +0200
Message-Id: <20200508092222.2097-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508092222.2097-1-hch@lst.de>
References: <20200508092222.2097-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

__kernel_read has a bunch of additional sanity checks, and this moves
the set_fs out of non-core code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 security/integrity/iint.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index e12c4900510f6..1d20003243c3f 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -188,19 +188,7 @@ DEFINE_LSM(integrity) = {
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count)
 {
-	mm_segment_t old_fs;
-	char __user *buf = (char __user *)addr;
-	ssize_t ret;
-
-	if (!(file->f_mode & FMODE_READ))
-		return -EBADF;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = __vfs_read(file, buf, count, &offset);
-	set_fs(old_fs);
-
-	return ret;
+	return __kernel_read(file, addr, count, &offset);
 }
 
 /*
-- 
2.26.2


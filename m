Return-Path: <SRS0=gDDV=6W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C88C47247
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 09:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8E9208CA
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 09:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jvP7+X5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgEHJWb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 May 2020 05:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgEHJWa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 May 2020 05:22:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B98C05BD43;
        Fri,  8 May 2020 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=w8+H/WdMyxnhfLBjBxD8TC1RnBnytabQkaUnuZkvk7I=; b=jvP7+X5X7VRIMwCYgT7LNK0AFl
        XUjK6E9jLYjSPhdxBhk4e8cjUgzYRdfPmgcekEHtrCLFzVPVYOmflEAT2tytuFBAuKLvPZ7vgUuHV
        QxZDMpCoN65mGRvFviWLQwZpYYk3P5CsK/ASiV/YnKIG47vuwlVqXAwfcZsYnDtD0k2LIT4i3cv7q
        ucYZnJ3na83YU8pBMu9hGVaES8VRMgpT72itohPncZ+s92Bgutanx8IQ714uW/Yfx0SDflH/R8uz6
        QdXGcn6rKYt/thKQ3KxVSThheOBqc+odYus2izfMSzKAfdauHUpKYV+EI1/LJxXhiNo0WOgpTCJie
        heeDjR6g==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWzDB-0008J4-QF; Fri, 08 May 2020 09:22:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 02/11] fs: check FMODE_WRITE in __kernel_write
Date:   Fri,  8 May 2020 11:22:13 +0200
Message-Id: <20200508092222.2097-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508092222.2097-1-hch@lst.de>
References: <20200508092222.2097-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

We still need to check if the fѕ is open write, even for the low-level
helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index d5aaf3a4198b9..d5c754080e5a5 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -505,6 +505,8 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	const char __user *p;
 	ssize_t ret;
 
+	if (!(file->f_mode & FMODE_WRITE))
+		return -EBADF;
 	if (!(file->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
 
-- 
2.26.2


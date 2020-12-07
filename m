Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B1FC1B0D9
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6AB238E5
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgLGQef (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:34:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727666AbgLGQed (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=otYj369xse9R2kbOApLqBDn6NdlRsKHBl6lYbw3xZEw=;
        b=asruxKtDPeoygh/SIkjx53TersoRBxm879j14KtQ2kxtL2yenvDvyQD43PU/cWglrLzNu2
        cQ2QA/+M0WqHquLD9He2cQ6JstjShdYvjxh/P9ImxaV/Ztai4FYmXlw4toAxIUW6Bd3aNC
        9CuR67+AM3qxWRe4634Fn7lDXMk9tVU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-1GmrjITdPVmWCIMn5pmI8Q-1; Mon, 07 Dec 2020 11:33:03 -0500
X-MC-Unique: 1GmrjITdPVmWCIMn5pmI8Q-1
Received: by mail-ej1-f72.google.com with SMTP id g18so4035608eje.1
        for <linux-security-module@vger.kernel.org>; Mon, 07 Dec 2020 08:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otYj369xse9R2kbOApLqBDn6NdlRsKHBl6lYbw3xZEw=;
        b=OK08DoXNZ5z7C9D6w9JSWzJKxEhHxjvgIeoOpRtxYY8iO2s/apyEu9bXwvkM2iEP5s
         0Ic47RwiqBO8z4rOaGISVA1QWW1DKOqRrcUkqulvuFST6nPJhm90iArUk/t5FcKQ563e
         PpcdyWaVkegVUYTXnF+wXq61QLn7x0O4GVu/MLgTmJ/DKGsEnSZp2E/2ke56V5ezpYTb
         RB7NdX6edCges9DBx679q9THZDvo4YRPOYXf9IdH/c1q+mzujnvWtP5UYGKCrentCgz3
         itd5ReBZMllSPBYShwa5jQs9SyHgp+DS1aMUVraXtUFpbAVgfqYNvnrFft0i5c7+CJsc
         v9pA==
X-Gm-Message-State: AOAM533c4+tmibBwwAehkr5Bl8z0KZG7KSa6y8GixfpJEaJDAVqVGvj6
        B8zqlmPo+853kxSa30fowKXPuwsVVzBKmcShLPysND9DQ2I+xB+By9GwpAR17XYkPj2bX2hrUcL
        tEQBRR8esMXkZoIy3MPetVyZP4s54Qeh+gpXn
X-Received: by 2002:a17:906:c83b:: with SMTP id dd27mr19881673ejb.356.1607358782442;
        Mon, 07 Dec 2020 08:33:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygw9J/iNohcy2imBMmRfiewi1ytt2qnsha6UorIQb1JISBnH+1nxrUZXhES5TAxxlwjwkJkQ==
X-Received: by 2002:a17:906:c83b:: with SMTP id dd27mr19881657ejb.356.1607358782244;
        Mon, 07 Dec 2020 08:33:02 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:01 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] vfs: verify source area in vfs_dedupe_file_range_one()
Date:   Mon,  7 Dec 2020 17:32:47 +0100
Message-Id: <20201207163255.564116-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Call remap_verify_area() on the source file as well as the destination.

When called from vfs_dedupe_file_range() the check as already been
performed, but not so if called from layered fs (overlayfs, etc...)

Could ommit the redundant check in vfs_dedupe_file_range(), but leave for
now to get error early (for fear of breaking backward compatibility).

This call shouldn't be performance sensitive.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/remap_range.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index e6099beefa97..77dba3a49e65 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -456,8 +456,16 @@ loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 	if (ret)
 		return ret;
 
+	/*
+	 * This is redundant if called from vfs_dedupe_file_range(), but other
+	 * callers need it and it's not performance sesitive...
+	 */
+	ret = remap_verify_area(src_file, src_pos, len, false);
+	if (ret)
+		goto out_drop_write;
+
 	ret = remap_verify_area(dst_file, dst_pos, len, true);
-	if (ret < 0)
+	if (ret)
 		goto out_drop_write;
 
 	ret = -EPERM;
-- 
2.26.2


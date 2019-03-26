Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACF7C4360F
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D832087C
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IireMRZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfCZS2r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:47 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:40430 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732832AbfCZS2q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:46 -0400
Received: by mail-qk1-f201.google.com with SMTP id l187so12368393qkd.7
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i92ao4UQPXz3UyfztS9poQmhL/y3JHZOqS1ytGgJ0IM=;
        b=IireMRZbHx4vA3G+/KY1Qp86vmqOO6m0TVHgQHNQc+DBPoZ/Ypi0LkIWmaO3+z2s/m
         5C1L/OQacdr55cpK+BtdpqB1jMJ3ddX/JBAV/dGbD35Qq1bdCKpTUIiOuFos3WkJG+KT
         TtE03CjoZl4K4rqofSP9GDPM85kvl055ArYJIhbb7HiLBrrphd/IP0YCb7aRPM+WYo0q
         gqP37V6kBTTxQd2WlFY2084Ber08eBTVOKVw7PeBKH9Io3PY3hSK0lbKZky3cv9WE65z
         s+r4hpr41eMuC74315P0niUfnwjt0AqBQ9TfKQ+j6wrbZNXrQlm3aGZQxASMtyXGY5bI
         YDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i92ao4UQPXz3UyfztS9poQmhL/y3JHZOqS1ytGgJ0IM=;
        b=VLixh84Txh77eZpfzs6ks/kGbnnIeToH3fs6LPhDqyR9MKPT9xMdDGpEE31gxkchKS
         h/yUqgRDrYJunpCqPMvnZE04zt8CF/Pc7xyNR/EcjW2F6Da2pCJ7dy1HQ34W2vSFkSfF
         l7fQWwiyun2Ph5LIyv77pHz6ia9TW3RmF1AR85994QkivciUzqh4S2GDNv9Hx69GIFDR
         manUR3arO4ett0dx8RDe3pNMqYm42IZqjc8VHjZvlnLGw4vn0uaPP+2XJa9Ht5pk7RXB
         RyVcupN7mA2WZx7YkPM+ZGGpqxvdCgjvVNbBU5OXhuGM3T8LOiJjFLpSFB5o+fqU1ovS
         04FQ==
X-Gm-Message-State: APjAAAUlyPOWlD5nMBtpwPwpXUio5zIGVf87021pcPxRQxcAseTThoz+
        hqGQb3QWL0poQoZCpVejeICqKWxCqurLmH7f0UMTew==
X-Google-Smtp-Source: APXvYqypggcG2fCExyn/1b0Jk74TXG8U+m5+z6/9Pu2BcIHAegaLxb67Ayhs7PmQ7gKNqObF+HrvkXaEizoEZ77vQGVIgw==
X-Received: by 2002:a0c:d413:: with SMTP id t19mr26692906qvh.8.1553624925174;
 Tue, 26 Mar 2019 11:28:45 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:36 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 20/25] Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Disallow access to /proc/kcore when the kernel is locked down to prevent
access to cryptographic data. This is limited to lockdown
confidentiality mode and is still permitted in integrity mode.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 fs/proc/kcore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index bbcc185062bb..1c556a453569 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -518,6 +518,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 static int open_kcore(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/proc/kcore", LOCKDOWN_CONFIDENTIALITY))
+		return -EPERM;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
-- 
2.21.0.392.gf8f6787159e-goog


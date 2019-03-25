Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA65C43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A26D20830
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+RZtfwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfCYWKH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:07 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:47437 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbfCYWKG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:06 -0400
Received: by mail-ot1-f73.google.com with SMTP id f103so7286931otf.14
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 15:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ygaOrSdGppBoGAldn3hUkJE8lcWsQcCZCWtpw82yF68=;
        b=i+RZtfwaKLR130wCLRb0HRymzdLNQBWhz+srVgbkCp9K8LknbtrDAqydUBeEgC5PYu
         fnT3mEAivXx9uic+ygjbI3e5pxjK1yV/0DcAuNdWX9OPgA6g6gO9YbexTjTND6xoxCFf
         zr+Kp0VN5iTtYFaLXddfDrhpjuz5OGaWd+luD86y0OZt0+BmMPy90A72xF102YLr3S9C
         FWNjkgqE/opaoDSRU6COJmi3j4Bsvaf4Zm7Cv1CU5n2uDHBIL0dnftmouTyuQCLZOnPV
         HpaEeKMZ3XXG7u7ehSia+ZDkEtj0nyzYCPhlmGR9E2S5yToBdfc6Bfkj749OaiJmWGqX
         V5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ygaOrSdGppBoGAldn3hUkJE8lcWsQcCZCWtpw82yF68=;
        b=uPqZ0E0jtu1ppDDu9/OylLyAagPN1xnXg83S/q8uI7D32dQ+Ls1D6MvpKiBfJcQ0DF
         ge90eOLE+PsG/BopmkeeBldQUdQGbhNBaoMVA8p4BwsNL+i1QRLdpaTj/sCpAo4whuLj
         xN7aUKj7HrYHlDQpYOLkXZORCiG55B+MbIJyQjAXV0FsAaz/CrLyXW5FihFYijIjJLyd
         6dRBqBlNqVvTw6K4Wz2Vdxy2x3sKsmA/+ZPYOoVrwzGF/eKxPnSlgVmhmXOsiiXTytq3
         JbZ/bFGhZcQf2ZUSjgqR1CN9jzzbqVZLFThcBEcjeOhlz3fpp5Z6Y+uMglqC9McMVwsl
         ZQsw==
X-Gm-Message-State: APjAAAWGhxlADV88j0vNRP4NdnxqF/44YilpNRO286alwoWxdv0zoE9A
        42CwDBEOCFxYotLLfB3UfnMpekgv2ZO1HGnWvqMmfw==
X-Google-Smtp-Source: APXvYqxWRxJS0tYMf4ijmDG93Tsc3sg3PK4wbeYvffPhJv83p8zt89FWps1s8R7sAC0k7avkHGTndLwNZWuBzSLisWNS9g==
X-Received: by 2002:aca:c3cc:: with SMTP id t195mr12721683oif.151.1553551805976;
 Mon, 25 Mar 2019 15:10:05 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:30 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 03/27] Restrict /dev/{mem,kmem,port} when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <matthewgarrett@google.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Allowing users to read and write to core kernel memory makes it possible
for the kernel to be subverted, avoiding module loading restrictions, and
also to steal cryptographic information.

Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
been locked down to prevent this.

Also disallow /dev/port from being opened to prevent raw ioport access and
thus DMA from being used to accomplish the same thing.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
Cc: x86@kernel.org
---
 drivers/char/mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..0a2f2e75d5f4 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -786,6 +786,8 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/dev/mem,kmem,port"))
+		return -EPERM;
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
-- 
2.21.0.392.gf8f6787159e-goog


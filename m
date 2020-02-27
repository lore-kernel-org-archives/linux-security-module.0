Return-Path: <SRS0=gx/C=4P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B9AC4BA24
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Feb 2020 13:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C275246A0
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Feb 2020 13:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="odm+PZjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgB0NT5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:19:57 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.68]:21340 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729088AbgB0NT5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Feb 2020 08:19:57 -0500
X-Greylist: delayed 1441 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2020 08:19:56 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 32921219C0
        for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2020 06:55:53 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7IhljWJ9zXVkQ7IhljrOqU; Thu, 27 Feb 2020 06:55:53 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4zTfqHtNR+JOFw1AL/0V9Tg2bWk099xhAe7F5IWAr+A=; b=odm+PZjBgpSmbCka5oSybjWmj2
        TDatQyzhvlKp3qcc8uuPHnf2AD33gqeg49yXELgZeBhZ2x1es6HcFQrsef7lCeVKA3J+7neryuzhS
        SqkY26fKqf36icZ8VgkCxFnUPTkhPXqC7Fh9FleYq9pZTqXoWlDGvUZAdq60rr+CWSUu1fK27gkwT
        pL0ewQDQmbhgqxQrhrt8e4MAzozEeyig2V7xgCvAa+bu+VB5VzJiHjiayhXVngkup4zBe0pNPyCTt
        CPjgMXIOkloq3w7pI4GjG7odckJ2B0DnZhS7Q4FjYPgKxJp9VKyAJKDcHz6M38ilzvkuTbyl+Ne00
        kEFCS15Q==;
Received: from [201.166.157.75] (port=39906 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j7Ihh-000gWF-C4; Thu, 27 Feb 2020 06:55:50 -0600
Date:   Thu, 27 Feb 2020 06:58:41 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] security: integrity: Replace zero-length array with
 flexible-array member
Message-ID: <20200227125841.GA23703@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.166.157.75
X-Source-L: No
X-Exim-ID: 1j7Ihh-000gWF-C4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.166.157.75]:39906
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 security/integrity/ima/ima.h   | 2 +-
 security/integrity/integrity.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 64317d95363e..da4246ee7e35 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -95,7 +95,7 @@ struct ima_template_entry {
 	u8 digest[TPM_DIGEST_SIZE];	/* sha1 or md5 measurement hash */
 	struct ima_template_desc *template_desc; /* template descriptor */
 	u32 template_data_len;
-	struct ima_field_data template_data[0];	/* template related data */
+	struct ima_field_data template_data[];	/* template related data */
 };
 
 struct ima_queue_entry {
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 543d277c7e48..3c7e8b902256 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -103,7 +103,7 @@ struct ima_digest_data {
 		} ng;
 		u8 data[2];
 	} xattr;
-	u8 digest[0];
+	u8 digest[];
 } __packed;
 
 /*
@@ -115,7 +115,7 @@ struct signature_v2_hdr {
 	uint8_t	hash_algo;	/* Digest algorithm [enum hash_algo] */
 	__be32 keyid;		/* IMA key identifier - not X509/PGP specific */
 	__be16 sig_size;	/* signature size */
-	uint8_t sig[0];		/* signature payload */
+	uint8_t sig[];		/* signature payload */
 } __packed;
 
 /* integrity data associated with an inode */
-- 
2.25.0


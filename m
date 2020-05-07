Return-Path: <SRS0=9z6D=6V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A456AC38A24
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 19:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78314218AC
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 19:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879054;
	bh=TZeZW0+jfLlh4ZcEbv2LeoEqpPZMjTCgCitS0tjDun8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=yVeKQInjEGmhgsK8P3J6oo1uVnaBgqVpKPxS6mL5gWVqgbmZiQ8FJ7+xOE65PB48l
	 5Fjpjay9eUxmYJ6W04Hsxi0VNdnG9mn+RyAR1/ckP4MSTpG7MMI76Xcv+oGzq1IW8e
	 8z+7wEjh3DBPQgECVkROqX/IvE/fdhNfqMVQNycE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgEGTRd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 May 2020 15:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgEGTRd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 May 2020 15:17:33 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C32A21835;
        Thu,  7 May 2020 19:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879052;
        bh=TZeZW0+jfLlh4ZcEbv2LeoEqpPZMjTCgCitS0tjDun8=;
        h=Date:From:To:Cc:Subject:From;
        b=BOuwfW0y3gjqHMtue8yu0YfM2wr9KuUYdQ3Ijgzdyg0YG0Bh4kArsZPf/Q0JfZTnz
         j3qBjujXHQFDfHMYW9J1OghpLwKiwHEqdjhgBPEgWGP7xXMM09hKEkHO4ahQ5m8T01
         CQmAzxBNFcoFdP5bbOLUAxk0NounFW1Qjqw3f4a4=
Date:   Thu, 7 May 2020 14:21:59 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ima: Replace zero-length array with flexible-array
Message-ID: <20200507192159.GA16250@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 security/integrity/integrity.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 298b73794d8b..16c1894c29bb 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -107,7 +107,7 @@ struct ima_digest_data {
 		} ng;
 		u8 data[2];
 	} xattr;
-	u8 digest[0];
+	u8 digest[];
 } __packed;
 
 /*
@@ -119,7 +119,7 @@ struct signature_v2_hdr {
 	uint8_t	hash_algo;	/* Digest algorithm [enum hash_algo] */
 	__be32 keyid;		/* IMA key identifier - not X509/PGP specific */
 	__be16 sig_size;	/* signature size */
-	uint8_t sig[0];		/* signature payload */
+	uint8_t sig[];		/* signature payload */
 } __packed;
 
 /* integrity data associated with an inode */


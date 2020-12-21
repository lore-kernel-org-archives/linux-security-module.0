Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20EEC433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Dec 2020 03:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E0A123103
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Dec 2020 03:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgLUDrU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 20 Dec 2020 22:47:20 -0500
Received: from casper.infradead.org ([90.155.50.34]:38478 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgLUDrT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 20 Dec 2020 22:47:19 -0500
X-Greylist: delayed 1143 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Dec 2020 22:47:19 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1wn+qnkPDAZUCQEYEI3B57TLhs2MEwZtEb8Tmd7HIcY=; b=XMTNKkqIkf5IAPiefdOzcpLDuC
        +rabIa4lNXH/SKOP2FeRyquZlDiM2Q7iodYJsu/hRxoI9tmuImIZjb8Fmsf/EAg4G7FZsRGKZzao0
        q+t7cmDDuc/qtgoR8kJYRGaIx7EvlvGwkZ8uXAuNIKmDa5bsbXCEXLccT1oZNQ73f5xvBxopPTcgI
        7K0GFihJ5wWUSL91pDPnRA4KcBHNhG7pFevmMnjdOZDIM01uGRU+xFA5LiXOYsrdWTg/uIJ/T/JBw
        Knuc0phLeB1gnuqyse+L+n81twh2HI+G3ipTnO3GKdpjPp9M/e4zPJ9wJ2gYedQn6C9WpLhLskuOy
        BSSwDGtA==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krBr4-0007Fx-KH; Mon, 21 Dec 2020 03:27:27 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2] security: ima: delete a repeated word in comments
Date:   Sun, 20 Dec 2020 19:27:20 -0800
Message-Id: <20201221032720.11325-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Drop a repeated word in comments.
{the}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
v2: rebase

 security/integrity/ima/ima_policy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201218.orig/security/integrity/ima/ima_policy.c
+++ linux-next-20201218/security/integrity/ima/ima_policy.c
@@ -781,7 +781,7 @@ static int __init ima_init_arch_policy(v
  * ima_init_policy - initialize the default measure rules.
  *
  * ima_rules points to either the ima_default_rules or the
- * the new ima_policy_rules.
+ * new ima_policy_rules.
  */
 void __init ima_init_policy(void)
 {

Return-Path: <SRS0=PbfF=BR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635DFC433E0
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Aug 2020 16:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398EA20866
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Aug 2020 16:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F7lDqC3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgHGQvP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGQvP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Aug 2020 12:51:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A54C061756;
        Fri,  7 Aug 2020 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6UugUgEElgv8wyP2hA9PnQaXqq5icyYCf5spyffiXKw=; b=F7lDqC3MU1GawLQXO5Pj9MQCHg
        ncRIGejFqJlY52LxQuJbl4faqUOt0e8niTIFje/egtoaB+fjKTNejKRRyyNDuV4RaeWTF+UOmy5HO
        32YswRnEb0LDi3XT/ovxkPQj4FlwlwVvxw1em0godFkl/Qu8McUzbIrYBxkAa2PJX94M+W4JfiOY7
        0+hZNyJ2TnAOqJhdc1MGxNyh/ircKoGxm+Gv0JttIszmOCxPdm+rnM/NGUSDiA21p4S+CyXaHykJP
        VufNjJJh9D2CTuDWY8+fKB7MH8+fsnjQWhF28tiYu/WtiquuWHtGsKFyIYYV7dfSoqvtE4gKNZ9zz
        oLJ+bZTA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k45aL-0004Ez-40; Fri, 07 Aug 2020 16:51:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH] security: ima: delete a repeated word in comments
Date:   Fri,  7 Aug 2020 09:51:09 -0700
Message-Id: <20200807165109.3811-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
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
 security/integrity/ima/ima_policy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200731.orig/security/integrity/ima/ima_policy.c
+++ linux-next-20200731/security/integrity/ima/ima_policy.c
@@ -719,7 +719,7 @@ static int __init ima_init_arch_policy(v
  * ima_init_policy - initialize the default measure rules.
  *
  * ima_rules points to either the ima_default_rules or the
- * the new ima_policy_rules.
+ * new ima_policy_rules.
  */
 void __init ima_init_policy(void)
 {

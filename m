Return-Path: <SRS0=TKeG=AU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7103C433E0
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Jul 2020 06:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F32206C3
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Jul 2020 06:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="biInM4kE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGIGTy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:19:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37902 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGIGTx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Jul 2020 02:19:53 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7E12A20B4909;
        Wed,  8 Jul 2020 23:19:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E12A20B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594275592;
        bh=KhZwoc2SCUpP770b/4tJ58Uu4y08B6iRQ7dPnzlnwD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=biInM4kEQS4NasN3kKHheyzTLbgnWBk3+nP4pxVXoeom740lgyOMok/eZzqruVW/W
         coKsxQVN7PgraddnY4TqjfhoM4CZjn1SiNZSKl8pP3QTwmg/IlJWrkJQQR3NuOK0Yz
         dLQ/EdLr9q0zm5BXLSpPbt9F78sbINTo4tG+vJLY=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v3 01/12] ima: Have the LSM free its audit rule
Date:   Thu,  9 Jul 2020 01:19:00 -0500
Message-Id: <20200709061911.954326-2-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Ask the LSM to free its audit rule rather than directly calling kfree().
Both AppArmor and SELinux do additional work in their audit_rule_free()
hooks. Fix memory leaks by allowing the LSMs to perform necessary work.

Fixes: b16942455193 ("ima: use the lsm policy update notifier")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Cc: Janne Karhunen <janne.karhunen@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---

* v3
  - No change
* v2
  - Fixed build warning by dropping the 'return -EINVAL' from
    the stubbed out security_filter_rule_free() since it has a void
    return type
  - Added Mimi's Reviewed-by
  - Developed a follow-on patch to rename security_filter_rule_*()
    functions, to address Casey's request, but I'll submit it
    independently of this patch series since it is somewhat unrelated

 security/integrity/ima/ima.h        | 5 +++++
 security/integrity/ima/ima_policy.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 4515975cc540..59ec28f5c117 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -420,6 +420,7 @@ static inline void ima_free_modsig(struct modsig *modsig)
 #ifdef CONFIG_IMA_LSM_RULES
 
 #define security_filter_rule_init security_audit_rule_init
+#define security_filter_rule_free security_audit_rule_free
 #define security_filter_rule_match security_audit_rule_match
 
 #else
@@ -430,6 +431,10 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return -EINVAL;
 }
 
+static inline void security_filter_rule_free(void *lsmrule)
+{
+}
+
 static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
 					     void *lsmrule)
 {
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 66aa3e17a888..d7c268c2b0ce 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -258,7 +258,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 	int i;
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		kfree(entry->lsm[i].rule);
+		security_filter_rule_free(entry->lsm[i].rule);
 		kfree(entry->lsm[i].args_p);
 	}
 	kfree(entry);
-- 
2.25.1


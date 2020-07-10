Return-Path: <SRS0=LBP9=AV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B763C433DF
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jul 2020 20:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34CE2075D
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jul 2020 20:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FxikLX5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgGJUiN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:38:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40346 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgGJUiM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Jul 2020 16:38:12 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id B75D220B4908;
        Fri, 10 Jul 2020 13:38:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B75D220B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594413491;
        bh=0SK4PPdilwulgPG7L8UmTifG2QAI5iiarEIkym++hEQ=;
        h=From:To:Cc:Subject:Date:From;
        b=FxikLX5X3jSA30gaiOMVOjwn5KRKnXFPTs4kGypha6jg3m66WH93C/Ka2g76Hif9j
         dnQHkSn+WMIvw4/oigLTtTJTMeNI2aTGPo0cZLWR4XFQv2iUFKg214vyEkkn/Xvbd4
         YfILkumt3t/QZGhmX0dIqDASIRsqOuAAMh1ByEgA=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v2] ima: Rename internal audit rule functions
Date:   Fri, 10 Jul 2020 15:37:50 -0500
Message-Id: <20200710203750.89323-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Rename IMA's internal audit rule functions from security_filter_rule_*()
to ima_filter_rule_*(). This avoids polluting the security_* namespace,
which is typically reserved for general security subsystem
infrastructure.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Suggested-by: Casey Schaufler <casey@schaufler-ca.com>
---

* v2
  - Rebased onto v3 of prereq series
  - Renamed the functions to ima_filter_rule_*(), instead of
    ima_audit_rule_*(), at Mimi's request
  - Didn't pick up Casey's Reviewed-by on v1 since nearly every line of
    the patch changed. Although, I suspect he'll be equally as happy with
    the new names in v2.

Developed on top of next-integrity-testing, commit cd1d8603df60 ("IMA:
Add audit log for failure conditions"), plus this patch series:

 [PATCH v3 00/12] ima: Fix rule parsing bugs and extend KEXEC_CMDLINE rule support
 https://lore.kernel.org/linux-integrity/20200709061911.954326-1-tyhicks@linux.microsoft.com/T/#t

This patch has dependencies on the above patch series.

Tested with and without CONFIG_IMA_LSM_RULES enabled by attempting to
load IMA policy with rules containing the subj_role=foo conditional.
Build logs are clean in both configurations. The IMA policy was first
loaded without and then with a valid AppArmor profile named "foo". The
behavior is the same before and after this patch is applied:

                  | CONFIG_IMA_LSM_RULES=n   | CONFIG_IMA_LSM_RULES=y
-----------------------------------------------------------------------
 Without Profile  |  IMA policy load fails   | IMA policy load fails
 With Profile     |  IMA policy load fails   | IMA policy load succeeds

 security/integrity/ima/ima.h        | 16 +++++++--------
 security/integrity/ima/ima_policy.c | 30 +++++++++++++----------------
 2 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 576ae2c6d418..38043074ce5e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -413,24 +413,24 @@ static inline void ima_free_modsig(struct modsig *modsig)
 /* LSM based policy rules require audit */
 #ifdef CONFIG_IMA_LSM_RULES
 
-#define security_filter_rule_init security_audit_rule_init
-#define security_filter_rule_free security_audit_rule_free
-#define security_filter_rule_match security_audit_rule_match
+#define ima_filter_rule_init security_audit_rule_init
+#define ima_filter_rule_free security_audit_rule_free
+#define ima_filter_rule_match security_audit_rule_match
 
 #else
 
-static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
-					    void **lsmrule)
+static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
+				       void **lsmrule)
 {
 	return -EINVAL;
 }
 
-static inline void security_filter_rule_free(void *lsmrule)
+static inline void ima_filter_rule_free(void *lsmrule)
 {
 }
 
-static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
-					     void *lsmrule)
+static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
+					void *lsmrule)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2e87154c9296..c5eda02e5f51 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -258,7 +258,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 	int i;
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		security_filter_rule_free(entry->lsm[i].rule);
+		ima_filter_rule_free(entry->lsm[i].rule);
 		kfree(entry->lsm[i].args_p);
 	}
 }
@@ -308,10 +308,9 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 		 */
 		entry->lsm[i].args_p = NULL;
 
-		security_filter_rule_init(nentry->lsm[i].type,
-					  Audit_equal,
-					  nentry->lsm[i].args_p,
-					  &nentry->lsm[i].rule);
+		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
+				     nentry->lsm[i].args_p,
+				     &nentry->lsm[i].rule);
 		if (!nentry->lsm[i].rule)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				entry->lsm[i].args_p);
@@ -495,18 +494,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
-							rule->lsm[i].type,
-							Audit_equal,
-							rule->lsm[i].rule);
+			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+						   Audit_equal,
+						   rule->lsm[i].rule);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = security_filter_rule_match(secid,
-							rule->lsm[i].type,
-							Audit_equal,
-							rule->lsm[i].rule);
+			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
+						   Audit_equal,
+						   rule->lsm[i].rule);
 		default:
 			break;
 		}
@@ -901,10 +898,9 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 		return -ENOMEM;
 
 	entry->lsm[lsm_rule].type = audit_type;
-	result = security_filter_rule_init(entry->lsm[lsm_rule].type,
-					   Audit_equal,
-					   entry->lsm[lsm_rule].args_p,
-					   &entry->lsm[lsm_rule].rule);
+	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
+				      entry->lsm[lsm_rule].args_p,
+				      &entry->lsm[lsm_rule].rule);
 	if (!entry->lsm[lsm_rule].rule) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
-- 
2.25.1


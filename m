Return-Path: <SRS0=CLHo=AE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75361C433E3
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505C320720
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZMJQIK5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbgFWAeU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:34:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47458 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731908AbgFWAeR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jun 2020 20:34:17 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6AF7320B7192;
        Mon, 22 Jun 2020 17:34:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6AF7320B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592872457;
        bh=MjvOfyC6Kyxg10ZaMXyzh7KFkvoHbtJZoncaooevfJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZMJQIK5k+SfaBZZH7Dc85cfB2xfcW5vhv9kMZtgIOrFC3fbI7kiTZI8aY5jeTgYWV
         r5aGhGDwBRHwyCwLooaDvqj8I2M9Mv2VOcjvwfo7nav/A/dD8ftKyJPSpffky6KOKN
         cuvl5LehN0NUd1D7o1SHs5uvyHlcx5X60fnG8Gyw=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 05/12] ima: Fail rule parsing when buffer hook functions have an invalid action
Date:   Mon, 22 Jun 2020 19:32:29 -0500
Message-Id: <20200623003236.830149-6-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Buffer based hook functions, such as KEXEC_CMDLINE and KEY_CHECK, can
only measure. The process_buffer_measurement() function quietly ignores
all actions except measure so make this behavior clear at the time of
policy load.

The parsing of the keyrings conditional had a check to ensure that it
was only specified with measure actions but the check should be on the
hook function and not the keyrings conditional since
"appraise func=KEY_CHECK" is not a valid rule.

Fixes: b0935123a183 ("IMA: Define a new hook to measure the kexec boot command line arguments")
Fixes: 5808611cccb2 ("IMA: Add KEY_CHECK func to measure keys")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 36 +++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ee5152ecd3d9..ecc234b956a2 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -979,6 +979,39 @@ static void check_template_modsig(const struct ima_template_desc *template)
 #undef MSG
 }
 
+static bool ima_validate_rule(struct ima_rule_entry *entry)
+{
+	if (entry->action == UNKNOWN)
+		return false;
+
+	if (entry->flags & IMA_FUNC) {
+		switch (entry->func) {
+		case NONE:
+		case FILE_CHECK:
+		case MMAP_CHECK:
+		case BPRM_CHECK:
+		case CREDS_CHECK:
+		case POST_SETATTR:
+		case MODULE_CHECK:
+		case FIRMWARE_CHECK:
+		case KEXEC_KERNEL_CHECK:
+		case KEXEC_INITRAMFS_CHECK:
+		case POLICY_CHECK:
+			break;
+		case KEXEC_CMDLINE:
+		case KEY_CHECK:
+			if (entry->action & ~(MEASURE | DONT_MEASURE))
+				return false;
+
+			break;
+		default:
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 {
 	struct audit_buffer *ab;
@@ -1156,7 +1189,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			keyrings_len = strlen(args[0].from) + 1;
 
 			if ((entry->keyrings) ||
-			    (entry->action != MEASURE) ||
 			    (entry->func != KEY_CHECK) ||
 			    (keyrings_len < 2)) {
 				result = -EINVAL;
@@ -1362,7 +1394,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			break;
 		}
 	}
-	if (!result && (entry->action == UNKNOWN))
+	if (!result && !ima_validate_rule(entry))
 		result = -EINVAL;
 	else if (entry->action == APPRAISE)
 		temp_ima_appraise |= ima_appraise_flag(entry->func);
-- 
2.25.1


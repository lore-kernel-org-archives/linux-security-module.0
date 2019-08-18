Return-Path: <SRS0=Scbz=WO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DBEC3A59F
	for <linux-security-module@archiver.kernel.org>; Sun, 18 Aug 2019 23:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011C52187F
	for <linux-security-module@archiver.kernel.org>; Sun, 18 Aug 2019 23:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfHRX6m (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 18 Aug 2019 19:58:42 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfHRX6m (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 18 Aug 2019 19:58:42 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 636B42901B9E0AE3EC22;
        Mon, 19 Aug 2019 00:58:41 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.36) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 19 Aug 2019 00:58:32 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <zohar@linux.ibm.com>,
        <dmitry.kasatkin@huawei.com>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [WIP][RFC][PATCH 2/3] lsm notifier: distinguish between state change and policy change
Date:   Mon, 19 Aug 2019 01:57:44 +0200
Message-ID: <20190818235745.1417-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818235745.1417-1-roberto.sassu@huawei.com>
References: <20190818235745.1417-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch introduces a new event type called LSM_STATE_CHANGE to
distinguish between state change and policy change.

The purpose of this patch is to let upper LSMs know when they can get the
label assigned by the lower LSMs (e.g. SELinux) with
security_secid_to_secctx().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 drivers/infiniband/core/device.c | 2 +-
 include/linux/security.h         | 1 +
 security/selinux/avc.c           | 2 +-
 security/selinux/selinuxfs.c     | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 187d7820cfaf..743a51fd775a 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -824,7 +824,7 @@ static void ib_policy_change_task(struct work_struct *work)
 static int ib_security_change(struct notifier_block *nb, unsigned long event,
 			      void *lsm_data)
 {
-	if (event != LSM_POLICY_CHANGE)
+	if (event != LSM_POLICY_CHANGE && event != LSM_STATE_CHANGE)
 		return NOTIFY_DONE;
 
 	schedule_work(&ib_policy_change_work);
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f7441abbf42..f868193e0115 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -75,6 +75,7 @@ struct timezone;
 
 enum lsm_event {
 	LSM_POLICY_CHANGE,
+	LSM_STATE_CHANGE,
 };
 
 /* These functions are in security/commoncap.c */
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 8346a4f7c5d7..3af9c6ebe580 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -982,7 +982,7 @@ int avc_ss_reset(struct selinux_avc *avc, u32 seqno)
 	avc_flush(avc);
 
 	for (c = avc_callbacks; c; c = c->next) {
-		if (c->events & AVC_CALLBACK_RESET) {
+		if (c->events & AVC_CALLBACK_RESET && seqno) {
 			tmprc = c->callback(AVC_CALLBACK_RESET);
 			/* save the first error encountered for the return
 			   value and continue processing the callbacks */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 6f195c7915de..76c34261e740 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -178,7 +178,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 		selnl_notify_setenforce(new_value);
 		selinux_status_update_setenforce(state, new_value);
 		if (!new_value)
-			call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
+			call_blocking_lsm_notifier(LSM_STATE_CHANGE, NULL);
 	}
 	length = count;
 out:
-- 
2.17.1


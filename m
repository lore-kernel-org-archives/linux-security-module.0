Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793D2C636CD
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Feb 2023 05:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjBDFcm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 4 Feb 2023 00:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjBDFcm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Feb 2023 00:32:42 -0500
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83A9092ED5
        for <linux-security-module@vger.kernel.org>; Fri,  3 Feb 2023 21:32:41 -0800 (PST)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 31459wnJ011627;
        Fri, 3 Feb 2023 23:09:58 -0600
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 31459wqT011625;
        Fri, 3 Feb 2023 23:09:58 -0600
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 04/14] Implement CAP_TRUST capability.
Date:   Fri,  3 Feb 2023 23:09:44 -0600
Message-Id: <20230204050954.11583-5-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230204050954.11583-1-greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

TSEM was designed to support a Trust Orchestration System (TOS)
security architecture.  A TOS based system uses the concept of a
minimum Trusted Computing Base of utilities, referred to as trust
orchestrators, that maintain workloads in a trusted execution
state.  The trust orchestrators are thus, from a security
perspective, the most privileged assets on the platform.

Introduce the CAP_TRUST capability that is defined as a
capability that allows a process to alter the trust status of the
platform.  In a fully trust orchestrated system only the
orchestrators carry this capability bit.

In TSEM the CAP_TRUST capability allows the holder to access the
control plane of the LSM.  This ability allows subordinate
modeling domains to be created and managed.  Most principally the
CAP_TRUST capability allows the holder to designate whether or
not a process should be trusted or untrusted.

The proposed Integrity Measurement Architecture namespaces would
also be a candidate to use the CAP_TRUST capability.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 include/uapi/linux/capability.h     | 6 +++++-
 security/selinux/include/classmap.h | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 3d61a0ae055d..af677b534949 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -417,7 +417,11 @@ struct vfs_ns_cap_data {
 
 #define CAP_CHECKPOINT_RESTORE	40
 
-#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
+/* Allow modifications to the trust status of the system */
+
+#define CAP_TRUST	41
+
+#define CAP_LAST_CAP         CAP_TRUST
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index a3c380775d41..e8c497c16271 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -30,7 +30,7 @@
 		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
 		"checkpoint_restore"
 
-#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
+#if CAP_LAST_CAP > CAP_TRUST
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 
-- 
2.39.1


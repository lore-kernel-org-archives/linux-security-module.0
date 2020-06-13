Return-Path: <SRS0=NNx2=72=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F18C433E0
	for <linux-security-module@archiver.kernel.org>; Sat, 13 Jun 2020 02:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D81206A4
	for <linux-security-module@archiver.kernel.org>; Sat, 13 Jun 2020 02:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kEtciZBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgFMClq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Jun 2020 22:41:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54150 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgFMCli (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Jun 2020 22:41:38 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6D1A520B4785;
        Fri, 12 Jun 2020 19:41:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D1A520B4785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592016097;
        bh=bNdc4U/VTJDtcRp/g3v1Y+eSv6Ss10i7Sm+a4SYsn4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEtciZBnky8xzcdy61W0t1oH+SEDvfREdGt3kfQ5zWK7WGhu6dkMtNAfzwC6IRtIC
         HmYSP+GUITWFKpb3NuY7oh5LOnsrVg6G4d/N0qVrowJd0WC7LKgM6CDlbHttv7QF5B
         36jXNaGkAkwnbc2kC9HIUzluKrVLNK5TjMM6jDYc=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] LSM: Define workqueue for measuring security module state
Date:   Fri, 12 Jun 2020 19:41:30 -0700
Message-Id: <20200613024130.3356-6-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200613024130.3356-1-nramas@linux.microsoft.com>
References: <20200613024130.3356-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The data maintained by the security modules could be tampered with by
malware. The LSM needs to periodically query the state of
the security modules and measure the data when the state is changed.

Define a workqueue for handling this periodic query and measurement.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/security.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/security/security.c b/security/security.c
index e7175db5a093..3dad6766cb9d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -89,6 +89,11 @@ static __initdata struct lsm_info *exclusive;
 static struct lsm_info *security_state_lsms;
 static int security_state_lsms_count;
 
+static long security_state_timeout = 300000; /* 5 Minutes */
+static void security_state_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(security_state_delayed_work,
+			    security_state_handler);
+
 static __initdata bool debug;
 #define init_debug(...)						\
 	do {							\
@@ -294,6 +299,26 @@ static void __init initialize_security_state_lsms(void)
 	security_state_lsms_count = count;
 }
 
+static void initialize_security_state_monitor(void)
+{
+	if (security_state_lsms_count == 0)
+		return;
+
+	schedule_delayed_work(&security_state_delayed_work,
+			      msecs_to_jiffies(security_state_timeout));
+}
+
+static void security_state_handler(struct work_struct *work)
+{
+	int inx;
+
+	for (inx = 0; inx < security_state_lsms_count; inx++)
+		measure_security_state(&(security_state_lsms[inx]));
+
+	schedule_delayed_work(&security_state_delayed_work,
+			      msecs_to_jiffies(security_state_timeout));
+}
+
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
@@ -417,6 +442,7 @@ static void __init ordered_lsm_init(void)
 	}
 
 	initialize_security_state_lsms();
+	initialize_security_state_monitor();
 
 	kfree(ordered_lsms);
 }
-- 
2.27.0


Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67BBC4708C
	for <linux-security-module@archiver.kernel.org>; Fri, 28 May 2021 07:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67A561358
	for <linux-security-module@archiver.kernel.org>; Fri, 28 May 2021 07:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbhE1HkU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 May 2021 03:40:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3100 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhE1HkG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 May 2021 03:40:06 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FrxCQ06GHz6W0Cc;
        Fri, 28 May 2021 15:29:38 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 09:38:30 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 3/7] ima: Define new template field imode
Date:   Fri, 28 May 2021 09:38:08 +0200
Message-ID: <20210528073812.407936-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528073812.407936-1-roberto.sassu@huawei.com>
References: <20210528073812.407936-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch defines the new template field imode, which includes the
inode mode. It can be used by a remote verifier to verify the EVM portable
signature, if it was included with the template fields sig or evmsig.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/IMA-templates.rst  |  1 +
 security/integrity/ima/ima_template.c     |  2 ++
 security/integrity/ima/ima_template_lib.c | 22 ++++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index bf8ce4cf5878..65c1ce451d08 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -77,6 +77,7 @@ descriptors by adding their identifier to the format string
  - 'evmsig': the EVM portable signature;
  - 'iuid': the inode UID;
  - 'igid': the inode GID;
+ - 'imode': the inode mode;
 
 
 Below, there is the list of defined template descriptors:
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index a5ecd9e2581b..43784f2bf8bd 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -51,6 +51,8 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_uint},
 	{.field_id = "igid", .field_init = ima_eventinodegid_init,
 	 .field_show = ima_show_template_uint},
+	{.field_id = "imode", .field_init = ima_eventinodemode_init,
+	 .field_show = ima_show_template_uint},
 };
 
 /*
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 87b40f391739..3156fb34b1af 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -596,3 +596,25 @@ int ima_eventinodegid_init(struct ima_event_data *event_data,
 {
 	return ima_eventinodedac_init_common(event_data, field_data, false);
 }
+
+/*
+ *  ima_eventinodemode_init - include the inode mode as part of the template
+ *  data
+ */
+int ima_eventinodemode_init(struct ima_event_data *event_data,
+			    struct ima_field_data *field_data)
+{
+	struct inode *inode;
+	umode_t mode;
+
+	if (!event_data->file)
+		return 0;
+
+	inode = file_inode(event_data->file);
+	mode = inode->i_mode;
+	if (ima_canonical_fmt)
+		mode = cpu_to_le16(mode);
+
+	return ima_write_template_field_data((char *)&mode, sizeof(mode),
+					     DATA_FMT_UINT, field_data);
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index b0aaf109f386..6509af4a97ee 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -54,4 +54,6 @@ int ima_eventinodeuid_init(struct ima_event_data *event_data,
 			   struct ima_field_data *field_data);
 int ima_eventinodegid_init(struct ima_event_data *event_data,
 			   struct ima_field_data *field_data);
+int ima_eventinodemode_init(struct ima_event_data *event_data,
+			    struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.25.1


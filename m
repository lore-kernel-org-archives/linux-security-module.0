Return-Path: <SRS0=g/MA=77=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADC8C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jun 2020 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C430520776
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jun 2020 16:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgFRQHh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:07:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2336 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728008AbgFRQHh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jun 2020 12:07:37 -0400
Received: from lhreml716-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 6E01FC6A77EDF1299CED;
        Thu, 18 Jun 2020 17:07:35 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 18 Jun 2020 17:07:35 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 18 Jun 2020 18:07:34 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 06/11] evm: Allow setxattr() and setattr() if metadata digest won't change
Date:   Thu, 18 Jun 2020 18:04:53 +0200
Message-ID: <20200618160458.1579-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618160329.1263-2-roberto.sassu@huawei.com>
References: <20200618160329.1263-2-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

If metadata are immutable, they cannot be changed. If metadata are already
set to the final value before cp and tar restore the value from the source,
those applications display an error even if the operation is legitimate
(they don't change the value).

This patch determines whether setxattr()/setattr() change metadata and, if
not, allows the operations even if metadata are immutable.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_main.c | 72 +++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 30072030f05d..41cc6a4aaaab 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -18,6 +18,7 @@
 #include <linux/integrity.h>
 #include <linux/evm.h>
 #include <linux/magic.h>
+#include <linux/posix_acl_xattr.h>
 
 #include <crypto/hash.h>
 #include <crypto/hash_info.h>
@@ -305,6 +306,56 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
 	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
 }
 
+static int evm_xattr_acl_change(struct dentry *dentry, const char *xattr_name,
+				const void *xattr_value, size_t xattr_value_len)
+{
+	umode_t mode;
+	struct posix_acl *acl = NULL, *acl_res;
+	struct inode *inode = d_backing_inode(dentry);
+	int rc;
+
+	/* UID/GID in ACL have been already converted from user to init ns */
+	acl = posix_acl_from_xattr(&init_user_ns, xattr_value, xattr_value_len);
+	if (!acl)
+		return 1;
+
+	acl_res = acl;
+	rc = posix_acl_update_mode(inode, &mode, &acl_res);
+
+	posix_acl_release(acl);
+
+	if (rc)
+		return 1;
+
+	if (acl_res && inode->i_mode != mode)
+		return 1;
+
+	return 0;
+}
+
+static int evm_xattr_change(struct dentry *dentry, const char *xattr_name,
+			    const void *xattr_value, size_t xattr_value_len)
+{
+	char *xattr_data = NULL;
+	int rc = 0;
+
+	if (posix_xattr_acl(xattr_name))
+		return evm_xattr_acl_change(dentry, xattr_name, xattr_value,
+					    xattr_value_len);
+
+	rc = vfs_getxattr_alloc(dentry, xattr_name, &xattr_data, 0, GFP_NOFS);
+	if (rc < 0)
+		return 1;
+
+	if (rc == xattr_value_len)
+		rc = memcmp(xattr_value, xattr_data, rc);
+	else
+		rc = 1;
+
+	kfree(xattr_data);
+	return rc;
+}
+
 /*
  * evm_protect_xattr - protect the EVM extended attribute
  *
@@ -361,6 +412,10 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
 		return 0;
 
+	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
+	    !evm_xattr_change(dentry, xattr_name, xattr_value, xattr_value_len))
+		return 0;
+
 	if (evm_status != INTEGRITY_PASS)
 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
@@ -477,6 +532,19 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
 }
 
+static int evm_attr_change(struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = d_backing_inode(dentry);
+	unsigned int ia_valid = attr->ia_valid;
+
+	if ((!(ia_valid & ATTR_UID) || uid_eq(attr->ia_uid, inode->i_uid)) &&
+	    (!(ia_valid & ATTR_GID) || gid_eq(attr->ia_gid, inode->i_gid)) &&
+	    (!(ia_valid & ATTR_MODE) || attr->ia_mode == inode->i_mode))
+		return 0;
+
+	return 1;
+}
+
 /**
  * evm_inode_setattr - prevent updating an invalid EVM extended attribute
  * @dentry: pointer to the affected dentry
@@ -506,6 +574,10 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 	    (evm_status == INTEGRITY_FAIL_IMMUTABLE))
 		return 0;
 
+	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
+	    !evm_attr_change(dentry, attr))
+		return 0;
+
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 			    dentry->d_name.name, "appraise_metadata",
 			    integrity_status_msg[evm_status], -EPERM, 0);
-- 
2.17.1


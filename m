Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A77415A8;
	Tue, 29 Jul 2025 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780187; cv=none; b=QZ9FOC8o/DyRqnjNhJmmYMSczq+pTTab8zFHuA7Uyi/aoZVPLtq1qAGbNKFf9VBtGp77JyoBUSvAYh/ia6yrCVRCW6c8SwF6TKBUJ5J85wN8Li51TxZDIs8tnZGS5unwg4gki6rrKHn1iJxI18W7m22HLuCk6FWHNXerSIJ/QL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780187; c=relaxed/simple;
	bh=DW5aO2WkVqkdAYdyp4EwCSKfFo6OF+HWNk557USvI3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H8nncV0DxLcEwMfMfBpSg7vxf5r0dVDfP+ChdGHd28LVQwppeBel8I0qR8CZvTGJ3adktRbnVVJnswrAebPTuIga5zvMXhFz9VqER1cNZD1KPdETSYtx5Rm5l8r5c+OLl3JOuZxMcEApikMlp5Z81SHszORyPlRrcm8kOBO/bUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FOGWaqqY; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FOGWaqqY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753780176; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qbzRbm/1jyacBHJjAXitMRMfMoRh9hLlAQIMYXnu/dg=;
	b=FOGWaqqYx97Zma0xuHVr9q/CeKovfbzgU9fEUuaqh7Ocq+5x84ugXMgprAcrhWTjLN3XYsmC3naSsGfvuQsXtkTmSOJXhyLY489pjYLp5dTb/7SQfSk3JC8PAGFfrLQBq0f9R2tSNO1UKEa0DAb90NEqhVdYGRbmVOZaJmrkTCU=
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0WkPYu9q_1753780175 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Jul 2025 17:09:35 +0800
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] lsm: simplify security_inode_copy_up_xattr()
Date: Tue, 29 Jul 2025 17:09:33 +0800
Message-Id: <20250729090933.94942-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of function security_inode_copy_up_xattr can be
simplified to directly call call_int_hook().

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 security/security.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/security/security.c b/security/security.c
index 596d41818577..a5c2e5a8009f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2774,13 +2774,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
  */
 int security_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
-	int rc;
-
-	rc = call_int_hook(inode_copy_up_xattr, src, name);
-	if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
-		return rc;
-
-	return LSM_RET_DEFAULT(inode_copy_up_xattr);
+	return call_int_hook(inode_copy_up_xattr, src, name);
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
-- 
2.39.5 (Apple Git-154)


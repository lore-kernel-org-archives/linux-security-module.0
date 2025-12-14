Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F7F513;
	Sun, 14 Dec 2025 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765743348; cv=none; b=huTvMTzbN9A7kdYiwXlxIrqN+iHbh8L2dGnVoUCAUX11sd1iG1t5MHCnqjtM9POhcOLTk4B0zK3WhHL4+kPKYuBF7pAUrVAUTJ4bfT/M+7mtxsuvFxPm4uiS8ifsJFLeBP93lZJsMfw9ff44uOok+xBfncvCqqcwiRzzQExgCZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765743348; c=relaxed/simple;
	bh=ypqHuLQub2RrwjcyJxQWg21SCHY+McYMN7ETKR834O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKZ2lfbkE9bobeOIXk9CTwouu5bIrlQc1T04Btk48vjlKQ3i1BtfdRouW0OYTe+rnnTkiYOMNtMgpTWRftBdyBcuIyhJ5dhAjVYc5V6LvFsAOi7S5XVfhafSypACBHi/HMlZn5wvk3q8rNGqY06cI2t9lGS1/TcPqne8mhc/Bvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h2qCW0Om; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h2qCW0Om"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nXq4eDa9ZOJRogqDgUTwXOfDWJzpdxQ1e1ZLpTSzKPE=; b=h2qCW0OmHKPdDa7a5GmpZeR4ql
	JDkFqPl1WOIP4ToGTX+KZeJiPW4tt7fO7MfxanC4jHheyiqYUHWwKk3zx3f1zAjH4/8WXolQHXWDk
	EzySBvzUQl+lfOOBHHjaTsnIMIQstRjLXbfHe6F98pKBVI2c8j5LadwGLnxbGZLmc1hMT1nADWXcR
	aevJOBTYXI//jjcCFwhMjn7TyGnPLY0Jt/mmOnacJDar9GBNzNlCntl2dFRFC2SHRCj3kBwN1/ObN
	nVXgKxo5/HMLWg9o+AZ+rumHlAcP9aalUfmBRfiXgx1ktnsT2AZ7ZYWM9BZB5HrxZm+BXuOA3HdzX
	mM1I+TpA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUsVK-00000002iIM-1hRs;
	Sun, 14 Dec 2025 20:15:44 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: fix kernel-doc struct member names
Date: Sun, 14 Dec 2025 12:15:39 -0800
Message-ID: <20251214201539.2188497-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct struct member names to avoid kernel-doc warnings:

Warning: include/linux/lsm_hooks.h:83 struct member 'name' not described
 in 'lsm_id'
Warning: include/linux/lsm_hooks.h:183 struct member 'initcall_device' not
 described in 'lsm_info'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
 include/linux/lsm_hooks.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20251201.orig/include/linux/lsm_hooks.h
+++ linux-next-20251201/include/linux/lsm_hooks.h
@@ -73,7 +73,7 @@ struct lsm_static_calls_table {
 
 /**
  * struct lsm_id - Identify a Linux Security Module.
- * @lsm: name of the LSM, must be approved by the LSM maintainers
+ * @name: name of the LSM, must be approved by the LSM maintainers
  * @id: LSM ID number from uapi/linux/lsm.h
  *
  * Contains the information that identifies the LSM.
@@ -164,7 +164,7 @@ enum lsm_order {
  * @initcall_core: LSM callback for core_initcall() setup, optional
  * @initcall_subsys: LSM callback for subsys_initcall() setup, optional
  * @initcall_fs: LSM callback for fs_initcall setup, optional
- * @nitcall_device: LSM callback for device_initcall() setup, optional
+ * @initcall_device: LSM callback for device_initcall() setup, optional
  * @initcall_late: LSM callback for late_initcall() setup, optional
  */
 struct lsm_info {

Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D6614B97E
	for <linux-security-module@vger.kernel.org>; Tue, 14 Jan 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871365; cv=none; b=g4y4mGzfwNs302A8aiK/WYS54pn57BlNagApXWyOcMd9xIn5geQnpUhYMs+Y06l2WUqD10g7vHQjj+WB2Gaq25YbsrD+uKdnIJSK5zcPnZr6GUCZznN1ZInK8YGwGo6asnYHjOfGpHh2CMolbK+xtSPj/gPN50BQBiyGfHh50RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871365; c=relaxed/simple;
	bh=OzjxDewEwUoFmZDlqj/rXaQEJ3MlmH9gIL7xuLQfnAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rKq7wAr7kP0e2rTE3fd+Noaa328PNratqb9EFUNbiJ5ntm8mPpXSUu3feLkgT1w1gkPAbT6nlMJZe9j7Rn2tzvNN4XppQx/o9CEyNIQhkfYDjvwR/uP76B8iI4K9yX/1LRWLWl4iW+8R4mQHV1nFJwNd4Y01IiEesnthxjCWO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=arulpandiyan.vadivel@siemens.com header.b=kSY6Kd6P; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=arulpandiyan.vadivel@siemens.com header.b="kSY6Kd6P"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250114161552912679bbced8f49ab7
        for <linux-security-module@vger.kernel.org>;
        Tue, 14 Jan 2025 17:15:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=arulpandiyan.vadivel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=m13rf/fo4REE8bUbLVn7lVoeLJdU0fGKILMfr63i7Cc=;
 b=kSY6Kd6PqSMUpGfS9Ao+WemIrkK7BB9Pi0pT3G6L+xrlO8G6WSIBu/iCCN2+VLh6tMdB/1
 tSDuJ4hzCDNA3euc0yQOdCGmRFauReJa1xLk7QQJaOCWK5VLSMtil1A39P7uiTdYguMKQ29+
 UCz8zOE4nxTelLYAoBv5VxOcnFnthvgd/0Bot0stdK3LE5JPdD3M8R2NXIgGCk8sXm7rJTSH
 1wAKhaqx78BUr0xuTUNgA0UbgQEEnfOvz9x4S8ppJAXYBOAiPj6yqm/sG1NOUg+fZsT9P25V
 1eSbXAbVhiWXJSYLGCmwA+YuZRokG4OMcP0Epw/3HeHJ3O4EC+uEDtKQ==;
From: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
To: linux-security-module@vger.kernel.org
Cc: linux-modules@vger.kernel.org,
	cedric.hombourger@siemens.com,
	srikanth.krishnakar@siemens.com,
	Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
Subject: [PATCH] loadpin: remove MODULE_COMPRESS_NONE as it is no longer supported
Date: Tue, 14 Jan 2025 21:47:29 +0530
Message-Id: <20250114161729.77142-1-arulpandiyan.vadivel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328317:519-21489:flowmailer

Updated the MODULE_COMPRESS_NONE with MODULE_COMPRESS as it was no longer
available from kernel modules.

Fixes: c7ff693fa209 ("module: Split modules_install compression and in-kernel decompression")
Signed-off-by: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
---
Changes in v2:
Reword the commit message
Modify logic and add Fixes tag.
---
 security/loadpin/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 848f8b4a60190..d82bcdb34cc8a 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -16,7 +16,7 @@ config SECURITY_LOADPIN_ENFORCE
 	depends on SECURITY_LOADPIN
 	# Module compression breaks LoadPin unless modules are decompressed in
 	# the kernel.
-	depends on !MODULES || (MODULE_COMPRESS_NONE || MODULE_DECOMPRESS)
+	depends on !MODULES || (!MODULE_COMPRESS || MODULE_DECOMPRESS)
 	help
 	  If selected, LoadPin will enforce pinning at boot. If not
 	  selected, it can be enabled at boot with the kernel parameter
-- 
2.39.5


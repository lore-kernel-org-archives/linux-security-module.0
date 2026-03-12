Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9F23B9DBD;
	Thu, 12 Mar 2026 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308313; cv=none; b=K1ZdumkOOLMSpk52ZaEKzYtxumFSjLpud/MgXz4A2ss8tCJpu4KnobqbXNKNeNqDmL4wN1Z00N0yFOSgj0FsbQoMMZta2qdLh0aSE0txXJC0Wd94wU5N7diMON9gdy3WEL+k1FnCto+SURgi2mz9UIeUPyJ4BZVktiS3iuXDQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308313; c=relaxed/simple;
	bh=k6Cc1C8dyUH0st8JHqXMGzxC1H+AbW3PQfBuhV55l3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FjD7ZWkVe1tN7LIfKZ/OP4oiZZU4RY9KpheSVIjTZJboIWw7nXCpum/APgy1stI57FONspW/qCj0YHCNsv+vWoHGxL7KPyOTpvFl2HOhP4GY4Qd8Hwnzggd9KW+7rTdyZoTRcSOAr4x145Z9bwVlxpjbWwJNXurIra/dln61f8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b2898b-b734-7f0000032729-7f0000019a5c-1
	for <multiple-recipients>; Thu, 12 Mar 2026 10:38:19 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 12 Mar 2026 10:38:19 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] integrity: Fix spelling mistake TRUSTED_KEYRING
Date: Thu, 12 Mar 2026 10:35:58 +0100
Message-ID: <b4b205be8e2bd845c834ddb17517ca9e02d5820d.1773308088.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1773308299-02DC0A3D-DACBDE97/0/0
X-purgate-type: clean
X-purgate-size: 886
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

Fix minor spelling mistake "kerne{d -> l}".

Fixes: 9dc92c45177ab ("integrity: Define a trusted platform keyring")
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 security/integrity/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 916d4f2bfc441..328ea9f32035a 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -60,7 +60,7 @@ config INTEGRITY_PLATFORM_KEYRING
 	help
 	  Provide a separate, distinct keyring for platform trusted keys, which
 	  the kernel automatically populates during initialization from values
-	  provided by the platform for verifying the kexec'ed kerned image
+	  provided by the platform for verifying the kexec'ed kernel image
 	  and, possibly, the initramfs signature.
 
 config INTEGRITY_MACHINE_KEYRING
-- 
2.43.0


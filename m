Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731634343E7
	for <linux-security-module@vger.kernel.org>; Tue, 21 Jul 2026 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784633315; cv=none; b=W9D6iHL9OxgXo4nKzDbI2rgLwqKfCO933ihVFgeUHdL1HrzajAVxX3JuMN1AK42vAyTcCgdzUTSOubIFD7aMe8n2mQYMHItD+VJ0x2TnNIb1s9IhsTNmO3y2+3OqJuKSdnRgwYnMMy42ELDmwooe3dIHO7rGb8fRlq/DgEQ3ZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784633315; c=relaxed/simple;
	bh=+vWuWu6jOl20GJQKb4urnR3j5fpg9WhK/iOthgAMXlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNa96nGpLCvuYD7NF9xHe4P+lOyxoMQrbuuP1Hd4Q5aH00tbPqpsiUGNIy/moGWR8LLRu8E74n1mCXRnqtLGtN4BpBIs1HvmfyUYNxvPRnX+lpZRV8LgyxC5t3yHPPoqnGwHRB+2GinzZBvD+H5BizE7M8zyCgeEMh0Wos56oXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=0UZpko7M; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="0UZpko7M"
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 7D3AF440CDB;
	Tue, 21 Jul 2026 14:18:53 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1784632733;
	bh=+vWuWu6jOl20GJQKb4urnR3j5fpg9WhK/iOthgAMXlM=;
	h=From:To:Cc:Subject:Date:From;
	b=0UZpko7MP8j9VALTFJZq/3/KUexmNaLxtnYqCJlDXPilx+i8+215HTzvAmZN/ns3l
	 i7h89b6xRP7Z+9NqX3vTLf18bzGbzxjqE4g8C5UgA47dWY+tCFAJlijKEnC5diRZOb
	 cNx+SyLrCMaXO19hPSOP9FlKLHX0yjyNSOZwgBrYOW+8P6kKBv+zcBXfYF8EH/2Sqh
	 CbEjed1hka5WJi3cZoVVNBFFVhB27oGo85ePAvHPlwHef/bchQ5QngWYakctD3lout
	 dcKqmxPxzaBi2rxFJz6XQ0a6MrA8K9+yddGHK2f2ie67mfqkeMMey6xGxjaOHrWncN
	 eiO7tNFyG9/7Q==
From: Baruch Siach <baruch@tkos.co.il>
To: John Johansen <john.johansen@canonical.com>,
	John Johansen <john@apparmor.net>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] apparmor: update website link
Date: Tue, 21 Jul 2026 14:19:02 +0300
Message-ID: <2ce1d4ec18b2b47ee7ddd9c1ad7be68e185aa69c.1784632742.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apparmor.wiki.kernel.org redirects to the current website.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 security/apparmor/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index 1e3bd44643da..472aa38254be 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -11,7 +11,7 @@ config SECURITY_APPARMOR
 	  This enables the AppArmor security module.
 	  Required userspace tools (if they are not included in your
 	  distribution) and further information may be found at
-	  http://apparmor.wiki.kernel.org
+	  https://wiki.apparmor.net
 
 	  If you are unsure how to answer this question, answer N.
 
-- 
2.53.0


Received: from mail.tkos.co.il (unknown [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D874766A0
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827600; cv=none; b=JCundGu1ehCiO+xu8zVcJlYh+0SK0aBnp7/b9qaE7LJETp32Ve+dAYtUxBOEm2cs5k+kZQA1rNLjgFSsoe8N9yjZYjcKohBudCOwJANSyv2Cir3TmJbuw38wfw5Z3j1wFqc4IxtRQSP6ziI9X80dOPyiiYkQumoW5rEV4lXojYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827600; c=relaxed/simple;
	bh=TZ7OjH3W4Ct85Dzr7QWDunFb6AdHrBnkKJ9/HFtu3Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJSlIE4e5T+B/OqcbVcZfTrkUem/oPu89tTXP3pp3kirDLYBQJER5835a1fWpWIGg86lV8bTLW23yIhxy/ScqzJkGBbeV/MNWrLMiGGW+Gpi4lPDRxsvy96rpqqZqtFtrtSLzgPufQHyGeqIOd7G7AXxK/9Kl6AduyAH6+G0HcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=M+eq9ny2; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="M+eq9ny2"
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 54DDB440CDB;
	Thu, 23 Jul 2026 20:26:14 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1784827574;
	bh=TZ7OjH3W4Ct85Dzr7QWDunFb6AdHrBnkKJ9/HFtu3Bc=;
	h=From:To:Cc:Subject:Date:From;
	b=M+eq9ny22aHOS4ItN6iLHfuQNxwdsJoePksTgGqlmjgQ4KQFtXlw2hSxrMgs/0ryw
	 X20W5DFFGKqpyPOhQ+53oNurIo7PAw73DV5zVIkrDZ6Ac9hAgJLWOFTWZvdIcXXeZl
	 yhTeCTkm5f8CZo8OaP9Kpm663lYK6YAfLKdOb4ZaKghYn4t4TEYQ67E4bimfGiVEzh
	 FeF8C06x2royZiLtI8vAsm0Q7EBkT7eTIQQSwu/s+meMGiKh/86nspSt1LfMHyvM93
	 edVFPV8dRBjPQEssxSvRgb2Aj2g+svm4rI1B6oT9GZfWidWfDfGyNjc4cgxl15bFnx
	 1R8va4j9e0n6g==
From: Baruch Siach <baruch@tkos.co.il>
To: John Johansen <john.johansen@canonical.com>,
	John Johansen <john@apparmor.net>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] apparmor: switch website link to https
Date: Thu, 23 Jul 2026 20:25:54 +0300
Message-ID: <5bdb0bfc41a89f58bcf9aa3e0fe062090a1fb2bd.1784827554.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Should make harder for MITM to redirect to somewhere else.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
This could be considered v2 of the patch linked below, following
feedback.

  https://lore.kernel.org/all/2ce1d4ec18b2b47ee7ddd9c1ad7be68e185aa69c.1784632742.git.baruch@tkos.co.il/
---
 security/apparmor/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index 1e3bd44643da..e1bfd164a23a 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -11,7 +11,7 @@ config SECURITY_APPARMOR
 	  This enables the AppArmor security module.
 	  Required userspace tools (if they are not included in your
 	  distribution) and further information may be found at
-	  http://apparmor.wiki.kernel.org
+	  https://apparmor.wiki.kernel.org
 
 	  If you are unsure how to answer this question, answer N.
 
-- 
2.53.0


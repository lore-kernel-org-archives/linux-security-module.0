Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6092819AD89
	for <linux-security-module@vger.kernel.org>; Wed,  2 Jul 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450449; cv=none; b=ml0mNHUF+HWz0deKVv4bkq454OKl+gvUOwzU7yWVq3XIrrlrOIDThlywKQg/7AM6fID5jcaw/t+YQMoSvJmaiT8xPnVsPuR5rBUf1fST6IIlfzibAhTdk/HsAPRVGRPIUiAOYsOcEv1yo+I+tazFgMtlZ/5Q/mO2bloHbDwHD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450449; c=relaxed/simple;
	bh=+Wuff26qjQUt8vEfMRWti+nkcV8KWIWcO7gGAN7Knlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oR1VSpFl0xMmLEvbKH61XEA+ZfBEr4PMFviXaqGDwIZkQ2yzv6cyjjcvvNHuBrm1lDhrDXon1ioB83xhCCsqXJbJ/YYH1x+OecjsDAquXJe6W69ZgSJTa7TGYWXSKx70jDHPBA+C6WOMcrLF4Z9/gY/nKV1v31ekS1vNMmbVHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=DZto7X5J; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="DZto7X5J"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1751450446; x=1782986446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Wuff26qjQUt8vEfMRWti+nkcV8KWIWcO7gGAN7Knlk=;
  b=DZto7X5JREjqpe9LjIM4Pji4hV0ra6xRyOKYggbQU6NezaaTAaCeuOXv
   6BmuGZ4OgiETysc2gHkIJuphYi5ddHzDcMMHady9VQAYw21qrACsK9JhL
   x/mFCFbLRWlvbjaFWyTY41V/oeyPHgFWJ44t4VbTFvynHeD509hSwvo/0
   k=;
X-CSE-ConnectionGUID: AaKIvTECS+iED9gMRheY8w==
X-CSE-MsgGUID: QYIB2Y6XTL+NLAhwTZhVkw==
X-IronPort-AV: E=Sophos;i="6.16,281,1744063200"; 
   d="scan'208";a="2012176"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 02 Jul 2025 12:00:38 +0200
Received: from s76.. (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id E58C12F0A;
	Wed,  2 Jul 2025 12:00:37 +0200 (CEST)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-security-module@vger.kernel.org
Cc: "Andrew G . Morgan" <morgan@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
Subject: [PATCH v2 1/1] uapi: fix broken link in linux/capability.h
Date: Wed,  2 Jul 2025 12:00:21 +0200
Message-Id: <20250702100021.1849243-2-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702100021.1849243-1-ariel.otilibili-anieli@eurecom.fr>
References: <20250629120301.1702897-1-ariel.otilibili-anieli@eurecom.fr>
 <20250702100021.1849243-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The link to the libcap library is outdated. Instead, use a link to the
libcap2 library.

As well, give the complete reference of the POSIX compliance.

Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
Acked-by: Andrew G. Morgan <morgan@kernel.org>
Reviewed-by: Paul Moore <paul@paul-moore.com>
---
 include/uapi/linux/capability.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 2e21b5594f81..ea5a0899ecf0 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -6,9 +6,10 @@
  * Alexander Kjeldaas <astor@guardian.no>
  * with help from Aleph1, Roland Buresund and Andrew Main.
  *
- * See here for the libcap library ("POSIX draft" compliance):
+ * See here for the libcap2 library (compliant with Section 25 of
+ * the withdrawn POSIX 1003.1e Draft 17):
  *
- * ftp://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.6/
+ * https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/
  */
 
 #ifndef _UAPI_LINUX_CAPABILITY_H
-- 
2.34.1


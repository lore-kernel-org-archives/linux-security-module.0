Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE136E494
	for <linux-security-module@vger.kernel.org>; Wed,  4 Feb 2026 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770242296; cv=none; b=Oeig+omekwV/kLy/aYkxGAQkeoqEvgr30a7utd+lIF/HktwqADPm1KRlET5WZwwEVpdHfwpY/edLj46q5D4pCmhmp+lClfo9hVgUcuHa1L5Lt/bt7VQk/eeCk3QgYLYCsb0XSwsphaZjicfo5T9pqGJaoJDko/1XPooxQDLvtLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770242296; c=relaxed/simple;
	bh=8+OrDguITaw7DwFcP8pFM0C9cVGiMKHxcNldTVNveZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1ck8lFZWJf4qEdQeZDqS2ibWlbGiYk3wdWAebTPFbCiIkIfKWIggZJ36bNDGlrhw4CHj+TStSIlfnFp+6r0cygAnlr1gV+7CAES5vq7avkSMrIGnxb2qowmhLvWQUKMyR6p1YFQl7w/QfSayGpSZXVcTD+PmY8xByx/us7ayvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id ndQJvNTWgCxrGnkt5vTUoC; Wed, 04 Feb 2026 21:58:15 +0000
Received: from host2044.hostmonster.com ([67.20.76.238])
	by cmsmtp with ESMTPS
	id nkt4vnnWV2l0knkt4vFBi8; Wed, 04 Feb 2026 21:58:15 +0000
X-Authority-Analysis: v=2.4 cv=UfRRSLSN c=1 sm=1 tr=0 ts=6983c0f7
 a=O1AQXT3IpLm5MaED65xONQ==:117 a=uc9KWs4yn0V/JYYSH7YHpg==:17
 a=HzLeVaNsDn8A:10 a=z6gsHLkEAAAA:8 a=tC7oq3K1zRuVbcHPeZEA:9 a=ZXulRonScM0A:10
 a=iekntanDnrheIxGr1pkv:22
Received: from [66.118.46.62] (port=57402 helo=timdesk..)
	by host2044.hostmonster.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <tim.bird@sony.com>)
	id 1vnkt1-00000000dBW-3J8Z;
	Wed, 04 Feb 2026 14:58:11 -0700
From: Tim Bird <tim.bird@sony.com>
To: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-spdx@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Bird <tim.bird@sony.com>
Subject: [PATCH] AppArmor: Add missing SPDX id line to sig_names.h
Date: Wed,  4 Feb 2026 14:58:04 -0700
Message-ID: <20260204215804.1755382-1-tim.bird@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host2044.hostmonster.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sony.com
X-BWhitelist: no
X-Source-IP: 66.118.46.62
X-Source-L: No
X-Exim-ID: 1vnkt1-00000000dBW-3J8Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (timdesk..) [66.118.46.62]:57402
X-Source-Auth: tim@bird.org
X-Email-Count: 30
X-Org: HG=bhshared_hm;ORG=bluehost;
X-Source-Cap: YmlyZG9yZztiaXJkb3JnO2hvc3QyMDQ0Lmhvc3Rtb25zdGVyLmNvbQ==
X-Local-Domain: no
X-CMAE-Envelope: MS4xfCVz3CsftXO9XalSVc95sQ/FDLmWqLa3Ih0p8YKoX7JM9uDam4sxRCR0Bwgb/ER8aOUa3n5FYqwMp5yoOOZv8rdIBIjLn+MoGhgrn1Edpa3FoN+2YWw3
 Jni9tEQ0kWqRINN5egyUJBHoXg4/IdyeTcuXE1/ui/HYoxoqcFSY9NJfYWOMtbceqU1fYJaDXmUoPycwN2pKYUl4N4CSfl6rQgFs8zJbkxO3CnvwKkG1sORX

sig_names.h is missing an SPDX-License-Identifier line.
Add one with the ID of GPL-2.0-only. This matches all
the other files in AppArmor.

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 security/apparmor/include/sig_names.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/apparmor/include/sig_names.h b/security/apparmor/include/sig_names.h
index c772668cdc62..3f617c1a64cd 100644
--- a/security/apparmor/include/sig_names.h
+++ b/security/apparmor/include/sig_names.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 #include <linux/signal.h>
 #include "signal.h"
 
-- 
2.43.0


Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5228200132
	for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340450; cv=none; b=YLyyho/iCo8o7bUeyivuMjxPZT5jkz3qK1rsRdsY+xOEmtw5K/Dd3nl9RADCYPDrZ8AzbhDJtY5pTLqhrQsW44d8nJRNDFU4+XprI6nwdMyyPxaPfvbiBKT+GICXvWLbrN6Gx54Vh+3qDiKrE629qr6ep0svWsrhpa6bIShhB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340450; c=relaxed/simple;
	bh=LO+nPRcgFCl/CqnMRTsBmYeOSUEkZ4gnzB2zLfXo5XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFHLDEGUJuEWF8+lKLCt5d6sApSm13+jX0weCknZ79hTAhNrHV2q2OjItWosnOAmtDOICrxdot0bBtvJ4ZrRNjLFLjyb9jq2PavZDud+s7aNW5mPMIPvBBaHFVC6mlgFGhXvE+7D63HrHeotRvKY26Sw3GYdhGQ6YXqqfnTkL2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=tjOWFqxy; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="tjOWFqxy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EjRW9/xatcPJPaJuKdR3e0P1BmzGYemRAELaGvqMYlU=; b=tjOWFqxyhltIvfEXiv+aVP1Uya
	7gkzad9xmqx3q6j5AwwY+2yS0ugQpGDOoc7t61oVnX2/KLMtUOZR6QazYgwBdP25hVhmpCVzVAmYT
	m54Yd7pP9Og5YSzERZe6JiGlz1aab7+NC5AeOD2yaPrSUXo17MpluQA/qBmiRm2eHDM3qUkr+XvFx
	XR6LxFfjPOQOGfzdKJj20ax/lpLMKdaqVBoI3nwFND2IMiAXedQsCJh2We3HQjPK3qdyjbkjZKV8N
	0xTTV3/oopHt9T/NOf4BkPfZ4FJFtY7QbSgRQm3se0mXl/JbGTZZpYY0RcvMNUO3ZX0FKNDFQ9muh
	rQv+oqfA==;
Received: from 87-95-116-80.bb.dnainternet.fi ([87.95.116.80]:11529 helo=fedora..)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1uFf4K-00000007EOc-3dNo;
	Thu, 15 May 2025 23:20:40 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: linux-security-module@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] Fix variable type to be 'bool' instead of incorrect 'int'
Date: Thu, 15 May 2025 23:19:52 +0300
Message-ID: <20250515201952.3996-1-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 security/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 596d41818577..447adeeb15d0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -288,7 +288,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 /* Prepare LSM for initialization. */
 static void __init prepare_lsm(struct lsm_info *lsm)
 {
-	int enabled = lsm_allowed(lsm);
+	bool enabled = lsm_allowed(lsm);
 
 	/* Record enablement (to handle any following exclusive LSMs). */
 	set_enabled(lsm, enabled);
-- 
2.49.0


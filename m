Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77DF361DA5
	for <linux-security-module@vger.kernel.org>; Wed,  8 Apr 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775648621; cv=none; b=HWarGd02wbqRT5bsdPYMSkzQL8rfvde5Cbzrz0OApwaQmGhRyORArnbQy2NabsuoloQN9yEBZTm/NjhUDHB6VpoqkBtJv668tZDBy4s3g2kVUrPy6LpdSTTNuqJiWLmqgJVUZEUTNZ8p98xHphPTcSxneYm7mr1DTaYBpL/aSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775648621; c=relaxed/simple;
	bh=OlV4/AdWIdmHI47QWcgCIpNoNJb/6aggZ7ZIull97E0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzU+/rSskHCcuPS0DsaCgJHEN0FpITfdFw4k12n53Hi7qAjJUBu050PLrhWFqG9qxSWxE4sA4t8FUft0D4ChNaBsPkniDuxKjSC4jBB7nabiDW0ArbZngD5+fzMEWeuF/4z+Ad0Dd96AbBnxZPVa7A+vYQdJZvF3vAg8TE1Xguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FVkULGwB; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FVkULGwB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775648607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gTOxcbeZCi9Oi+mWFOi5LqRtKFOfjUVDHO1pOSezwpg=;
	b=FVkULGwBBpKx1ECJs1rPTd5mdgo4x2150muaXJQ9BbI/56oe+6qvPEaRnoNLBJ2Lcn2Cta
	nZoxJ7dYM4G0CajyNCM5t8wshOY4ymOpjC1XQ6k5lb4Rnyk5kMD0K+KnrPYDyhJNEdJ9Ei
	JYRKFb5gWM0drdRGhQkuLYJ3gNyiUlg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-security-module@vger.kernel.org,
	paul@paul-moore.com
Cc: jmorris@namei.org,
	serge@hallyn.com,
	linux-kernel@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Subject: [PATCH] security: remove BUG_ON in security_skb_classify_flow
Date: Wed,  8 Apr 2026 19:42:57 +0800
Message-ID: <20260408114257.298500-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A BPF program attached to the xfrm_decode_session hook can return a
non-zero value, which causes BUG_ON(rc) in security_skb_classify_flow()
to trigger a kernel panic.

Remove the BUG_ON and change the return type from void to int, so that
callers can optionally handle the error.

Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/4c4d04ba.6c12b.19c039b69e6.Coremail.kaiyanm@hust.edu.cn/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/security.h |  7 ++++---
 security/security.c      | 16 +++++++++++-----
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index ee88dd2d2d1f..6d210dc4c649 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1975,7 +1975,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       struct xfrm_policy *xp,
 				       const struct flowi_common *flic);
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid);
-void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic);
+int security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic);
 
 #else	/* CONFIG_SECURITY_NETWORK_XFRM */
 
@@ -2038,9 +2038,10 @@ static inline int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 	return 0;
 }
 
-static inline void security_skb_classify_flow(struct sk_buff *skb,
-					      struct flowi_common *flic)
+static inline int security_skb_classify_flow(struct sk_buff *skb,
+					     struct flowi_common *flic)
 {
+	return 0;
 }
 
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
diff --git a/security/security.c b/security/security.c
index a26c1474e2e4..26a34eb363c2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4990,12 +4990,18 @@ int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 	return call_int_hook(xfrm_decode_session, skb, secid, 1);
 }
 
-void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic)
+/**
+ * security_skb_classify_flow() - Set the flow's secid from the security label
+ * @skb: packet
+ * @flic: flow common structure to set
+ *
+ * Decode the packet in @skb and set the flow's secid in @flic.
+ *
+ * Return: Return 0 if successful.
+ */
+int security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic)
 {
-	int rc = call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid,
-			       0);
-
-	BUG_ON(rc);
+	return call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid, 0);
 }
 EXPORT_SYMBOL(security_skb_classify_flow);
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
-- 
2.43.0


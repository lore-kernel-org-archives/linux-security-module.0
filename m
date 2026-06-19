Received: from mail.networkname.de (mail.networkname.de [85.209.200.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DA732BF41
	for <linux-security-module@vger.kernel.org>; Fri, 19 Jun 2026 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.209.200.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781890095; cv=none; b=SR/clCEIfdQsTxIh+FJ1NLuyCmc7aOKjHrA3WVjzqwBMp8n+oLILF2cNS4XJR9ZoDRJMNwOOXsyS3h7cYokBiAs1Efgs4/1XAyWXL+ok7G2I7lwAB0e2sp9TkKband1QyAsJ/B9XV0xodON/VyRQE+XhKA9+vsKvZEjObDh1hNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781890095; c=relaxed/simple;
	bh=pXLOXDyktPNZ4j7jvcgylv2u1WSrTZFjQwgcojJTeiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lCshLpg578bKDVg8rnmzfv8mEbWc8LPZeviL7O3Io2YiWK7pLjt4ro5dV0mUPo4g4uQtG3z6VozSHyuWoklMc5vs56fQdB7fgfmX5fWFnLWSpGdGa0TZXXOEd6KQZR9b0lX4FU//CbnczDCOWEB2ZTT9EPX5Do3QryYhoAMChnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bevuta.com; spf=pass smtp.mailfrom=bevuta.com; dkim=pass (1024-bit key) header.d=bevuta.com header.i=@bevuta.com header.b=OD+ZWYyD; dkim=pass (1024-bit key) header.d=bevuta.com header.i=@bevuta.com header.b=AcWsFlAV; arc=none smtp.client-ip=85.209.200.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bevuta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bevuta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bevuta.com header.i=@bevuta.com header.b="OD+ZWYyD";
	dkim=pass (1024-bit key) header.d=bevuta.com header.i=@bevuta.com header.b="AcWsFlAV"
From: Sebastian Bockholt <sebastian.bockholt@bevuta.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bevuta.com; s=default;
	t=1781889607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yIi82l9z0rWRSCMmFnC+HVRZ8DFD0NIqV0m2Y2jpX1s=;
	b=OD+ZWYyDSP7MKRR5bzi+tUsPmQo6Yw66zS2JhwaZWFAR84kK7guZ1qNurdyfQGdLhEN+B+
	6gFguz7UaGTqaJZWBOFx4v1cOtZFiLYheaGI6QGFnN6dZUlT7vtz/VZ1Lybp0d+/25bm3H
	RmO/OOM9519o0RHRt4iBAVfNgeiSrXA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bevuta.com; s=default;
	t=1781889605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yIi82l9z0rWRSCMmFnC+HVRZ8DFD0NIqV0m2Y2jpX1s=;
	b=AcWsFlAVnrPpxtGl8Cl+fegjPBrGd0V5bT4NjgMEKCWY2VYFqVWnaUfRAnKud99hoFxVWN
	x8JjiOkhYf1gOeEM4bkVxD79YLz200K7hM6YEhMeWIdADno63J1ZiqpYHoPDi9Limu95fn
	ZvciGpUo7SSTMNxp7BjEWxJc6ncoBj4=
To: linux-security-module@vger.kernel.org
Cc: serge@hallyn.com,
	jmorris@namei.org,
	paul@paul-moore.com,
	Sebastian Bockholt <sebastian.bockholt@bevuta.com>
Subject: [PATCH] LSM: check if lsmprop_to_secctx call is supported by LSM
Date: Fri, 19 Jun 2026 19:19:45 +0200
Message-ID: <20260619171945.1617498-1-sebastian.bockholt@mail.networkname.de>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In include/linux/lsm_hook_defs.h, lsmprop_to_secctx is defined with
a default return value of -EOPNOTSUPP.
The function bpf_lsm_lsmprop_to_secctx, defined in
security/bpf/hooks.c, returns the hook's default value. Therefore,
directly returning the result of the bpf_lsm_lsmprop_to_secctx call
propagates an unchecked EOPNOTSUPP error.

Signed-off-by: Sebastian Bockholt <sebastian.bockholt@bevuta.com>
---
 security/security.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..9c63699d45fc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3954,12 +3954,16 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
 			       int lsmid)
 {
+	int error;
 	struct lsm_static_call *scall;
 
 	lsm_for_each_hook(scall, lsmprop_to_secctx) {
 		if (lsmid != LSM_ID_UNDEF && lsmid != scall->hl->lsmid->id)
 			continue;
-		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
+		error = scall->hl->hook.lsmprop_to_secctx(prop, cp);
+		if (error == -EOPNOTSUPP)
+			continue;
+		return error;
 	}
 	return LSM_RET_DEFAULT(lsmprop_to_secctx);
 }
-- 
2.54.0


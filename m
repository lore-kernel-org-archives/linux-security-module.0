Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D96A35F5EA
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995915; cv=none; b=Qq1uVAGowowxkg/7AmcPk8vG4ZIzVTxowiSZyQYRVPaVGc0MTMgbOMugqv7lfF40UqKoOHFbvxF/vx8tNOvsYMRa0XS0rIA79xJCaQQEDFMNY2IAV7Sq1KMiyLIMbSkr3htQyzpHJCROt/jJwdsgYLvtGjt1gciIy9S3ui44sf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995915; c=relaxed/simple;
	bh=Wo/GHpcFUES/YJYwUeX70/tLUX8I5Guw1lyBg8qAh7w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdRPp/hf/Yib2+Kay4+Vkuhx7PExCP9nTbKiHTqsUuq2Zf3uPe82VNTNpIqjd+jX5nXxYGHCEAdKaHKwJQtbtUrPB/rPurb1g372w+aVhM8dddT+wj36zcaacjHGDwyIHetmrDo7qGbsAge4X5a7Hdi7smgyfXITgyDgLRknVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dssrj8Ru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dssrj8Ru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497BB1F0089B
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790995913;
	bh=xLNvp/qu106v/oF4QwGCump9UbFNNHtgT6pF49IXsrk=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=dssrj8Ru6dK7FyOooPrqDzfnib2CD9DnmEi41Y3X95gZNONVtXoFTs53zsUnKaXOq
	 IvhHI3QhwRwQdXR+fClSCYg6M78O7xi09/XqlO80oWSGbXDDE1SNVF8F5opKjkrdAl
	 W7dPLrnpQer4GGOvfPE25r21PMSXhw1gpnGzHx6fM+IviI61SO6iMYGU5IbWBPJHoo
	 dOSNpMzQY+wzlO178qnQbYKPGsUJylJ+OFNRVnC+Js5pPZk9CY1MdwZmi6AeowKJho
	 rAgcJUh2f3DKMBxD957nR46dzXVuA1FrvoleCKPBga2V7WlR9jlCt/UfkmAeKYIbb0
	 rW5pz7WFm3Mbg==
From: Fan Wu <wufan@kernel.org>
To: linux-security-module@vger.kernel.org
Subject: [PATCH 5/6] ipe: fix enforcement audit
Date: Fri,  2 Oct 2026 19:51:34 -0700
Message-ID: <20261003025135.3666767-6-wufan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003025135.3666767-1-wufan@kernel.org>
References: <20261003025135.3666767-1-wufan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipe_audit_enforce() starts an audit buffer but writes the state change
with audit_log(), which logs its own record. Ending the unused buffer
then emits an extra empty AUDIT_MAC_STATUS record.

Remove the unused buffer and log the state change with audit_log()
alone.

Fixes: a68916eaedcd ("ipe: add permissive toggle")
Assisted-by: LLM
Signed-off-by: Fan Wu <wufan@kernel.org>
---
 security/ipe/audit.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index 5b4f24914c74..b6f8fb54085a 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -262,18 +262,10 @@ void ipe_audit_policy_load(const struct ipe_policy *const p)
  */
 void ipe_audit_enforce(bool new_enforce, bool old_enforce)
 {
-	struct audit_buffer *ab;
-
-	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_MAC_STATUS);
-	if (!ab)
-		return;
-
 	audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_STATUS,
 		  "enforcing=%d old_enforcing=%d auid=%u ses=%u"
 		  " enabled=1 old-enabled=1 lsm=ipe res=1",
 		  new_enforce, old_enforce,
 		  from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		  audit_get_sessionid(current));
-
-	audit_log_end(ab);
 }
-- 
2.55.0


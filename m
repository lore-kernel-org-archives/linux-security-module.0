Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FDD1DE8BF
	for <linux-security-module@vger.kernel.org>; Thu,  7 Nov 2024 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978772; cv=none; b=YaxYEIzig+Xs2qee33CAnq0uNiY9CwQVQ6SCKPzqtFoTL+6Cjwl4uuYk7BfVq5VNJy1K6FyoqQ9ScpKL0bpMY14S9VIwgnOeMVgfW49tnu4b0mYGAK9YgM5rwOeN/5hCgoINe+FBUKddeAYimsVvOkZmFbBnryUjF514db62Ir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978772; c=relaxed/simple;
	bh=tOA01gs5nPhL/vmNbtW+GIMrz7TJDXxOicvU7S/TnUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZsI5qqsFksttUSjHpUh+2ipUbiVXP9iPWl60S7UGb2JD1LQqjn9yRQLP5WmCN5fY3HFNuNlCCnG4xdg6ICN5ETb1PHN1jeJ+6IqRNXbOR5BYhiu0uumPc+l/O/3sCsWBUo2RvOSEa3yXvRGriLP+8LkJD6F4isGpTYtjzAzC9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SmGXQCHI; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SmGXQCHI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730978768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R9I7quaW8/F+28X0/jjvHTMqunMj8YXAmloyPwoMZ/s=;
	b=SmGXQCHIusoolfYfMOHg5DuBbqL/hF5Us3taZS5xeNi32QdaJ3IIWEfk/pQnxjtTujw9TG
	2NdgK9QjKA9nKM51FrfNVHEJ3U92GTkcHFoX1JVNgzfhr2KQuj50f9q69oZ63YjFpc+l5Z
	2uIyo2PUmRtCr6ifcZe/nkoV8SRaFaw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] apparmor: Remove unnecessary NULL check before kvfree()
Date: Thu,  7 Nov 2024 12:25:27 +0100
Message-ID: <20241107112526.2312-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since kvfree() already checks if its argument is NULL, an additional
check before calling kvfree() is unnecessary and can be removed.

Remove it and the following Coccinelle/coccicheck warning reported by
ifnullfree.cocci:

  WARNING: NULL check before some freeing functions is not needed

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/policy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 14df15e35695..ce1c96cb2aed 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -103,8 +103,7 @@ static void aa_free_pdb(struct aa_policydb *pdb)
 {
 	if (pdb) {
 		aa_put_dfa(pdb->dfa);
-		if (pdb->perms)
-			kvfree(pdb->perms);
+		kvfree(pdb->perms);
 		aa_free_str_table(&pdb->trans);
 		kfree(pdb);
 	}
-- 
2.47.0


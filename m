Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C82EC09D
	for <linux-security-module@vger.kernel.org>; Sat, 22 Nov 2025 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763812499; cv=none; b=RltyZ4NwggpACBQvtq4rD/6puXAUIOSJ1a2lc6YGZPxl0VCFpLPk2SGVC6ezzGblQI4hnuH4dLtkCBo+DEYapACqP9qT4vhzTbU3rxDxLRs01e04i6zbrhz6dcokygZKpDCLnXKRWPYKlWJz5H1/00SOgwQpGL1PYldmn/NRewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763812499; c=relaxed/simple;
	bh=eKR377DGkmJDTFxCOV23C/6C4r9mp620Aiozq6sQ/6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1HIs+zixc1VUj37EYDVX2LxAbuNCPvH3jXrPrBXa7uYip6c18J2GVw+X/KXBisNQI7Zapq/co4uaUO9ksrTXCokHTzvQ2gz4gGZjor42VtBH6BOZJy08azfWUpIAIHAE6XwbQR0O3Z1u2qWWRbcVw/+82Krtrh9YzTt7rRce4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gdib4nor; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gdib4nor"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763812495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tn0WNlFKxJqXDPNrqq2aWch7Feg2N+SSY8m45Wjhib8=;
	b=gdib4nor+HGS6Gq8xzPCIHmtAd0JP4PK5ZCVnZAMdctp6KOmCZn7IqaV+ziVXmT/4CRIRw
	xB+vc9QrSSfVMmLaMlyyANjFwFjhS5ltoi4hwLq1QeIYyvq82Rzo/Gno7UhVawZumovoA2
	DpY9SGUplRUg2t3I6OYoQLICzHgHnKY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] apparmor: replace sprintf with snprintf in aa_new_learning_profile
Date: Sat, 22 Nov 2025 12:54:46 +0100
Message-ID: <20251122115446.447925-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace unbounded sprintf() calls with snprintf() to prevent potential
buffer overflows in aa_new_learning_profile(). While the current code
works correctly, snprintf() is safer and follows secure coding best
practices.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/policy.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 50d5345ff5cb..b09323867fea 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -697,24 +697,27 @@ struct aa_profile *aa_new_learning_profile(struct aa_profile *parent, bool hat,
 	struct aa_profile *p, *profile;
 	const char *bname;
 	char *name = NULL;
+	size_t name_sz;
 
 	AA_BUG(!parent);
 
 	if (base) {
-		name = kmalloc(strlen(parent->base.hname) + 8 + strlen(base),
-			       gfp);
+		name_sz = strlen(parent->base.hname) + 8 + strlen(base);
+		name = kmalloc(name_sz, gfp);
 		if (name) {
-			sprintf(name, "%s//null-%s", parent->base.hname, base);
+			snprintf(name, name_sz, "%s//null-%s",
+				 parent->base.hname, base);
 			goto name;
 		}
 		/* fall through to try shorter uniq */
 	}
 
-	name = kmalloc(strlen(parent->base.hname) + 2 + 7 + 8, gfp);
+	name_sz = strlen(parent->base.hname) + 2 + 7 + 8;
+	name = kmalloc(name_sz, gfp);
 	if (!name)
 		return NULL;
-	sprintf(name, "%s//null-%x", parent->base.hname,
-		atomic_inc_return(&parent->ns->uniq_null));
+	snprintf(name, name_sz, "%s//null-%x", parent->base.hname,
+		 atomic_inc_return(&parent->ns->uniq_null));
 
 name:
 	/* lookup to see if this is a dup creation */
-- 
2.51.1


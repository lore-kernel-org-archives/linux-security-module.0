Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D8E2F1FE6
	for <linux-security-module@vger.kernel.org>; Wed, 22 Oct 2025 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125903; cv=none; b=WyLbUEp7uUjJb4nNgEBHl+x9+OC1awLgcW+FfDfngmZrMDNXWwP3vdQU3+B8Gabh+3GDZcbLUO5j7u8JOPdbWkpnJ8etysVSyLiyFFFHJzCe4lkGapSDFyPfmeANFokihAGmt5Dh6yQZYPwJVsNuU8yWNtVIh09LrH7LsaUXQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125903; c=relaxed/simple;
	bh=bxynnY7gqNmOi/aTMvKArHOmse4FQvgr7PXwb1Utuw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g486xljmSzA7nhfKxSaJrpZBkPiR5d9wiZhr0PMR7ff4pSQamPtqaSrT58H6SsEgLwYWRWgDdOdhap4eQtdUp+Hc3yf4tpSGJNuuj01Erw74JeGwmMyEEYID58QaHiqTbwnev9g5QmEj7Q3iA6zYn34gEkYVEl2wA/0cOi1Lxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HhA/VdfW; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HhA/VdfW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761125889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GL864tnGf0kR+752wc1z68vVTN9MWgo9+WclWIvl49M=;
	b=HhA/VdfWsXl45uRI7qP2es2Ham6joM7ZolFWnwcD7e1znItUk8gOFMe+K5SsLXpCotZQpx
	QJ3O2Z74hrxfl7cfYNffczU1LIJd6dUxYJA8chst6wXtWkH9QHsGm2QITJxhLaueoGaTBv
	rIezv6bLD49+LYRFH5j7jP0/P/mr7ZM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: replace sprintf with snprintf in aa_new_learning_profile
Date: Wed, 22 Oct 2025 11:37:18 +0200
Message-ID: <20251022093718.206271-2-thorsten.blum@linux.dev>
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
2.51.0


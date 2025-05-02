Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72316A395;
	Fri,  2 May 2025 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746150264; cv=none; b=XYblqQBb5Ph4CYlDgaOwqDqDNmQliqUQc6ARnTaF0qx5pQ2KtPTnjLlj7/4Zf/ZdVoRLud/Wm7HuWKsScm2u+tyZ2nSTLZ3FOsz+CQTAsjLzc8CZLioHKbaarqAx2npq/ufUpLDz/URRt8a9doAj1oM1kD8kkM+TYqaE0JJpjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746150264; c=relaxed/simple;
	bh=IVxp7Yu5gHHHf7AP0nwxRszOz7pwBk3LsvuldbE68cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qhP+8oyYTL3OQCc1Llwf0tt5W0IwJixW6lcWsVF/RG4yawIVMxgsvMyd9jDtvK0IEnMir21ktYhlUfRc8/+9PdxblVC0kSbNhFiWAOCsUk6T977CYzU0/zZ26iF9uPV6/iXKkp2N3U7f+0xcf/YirWjfnTkgwJGSDuaYNklEZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PCpGKJEq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PCpGKJEq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8k1YoWjzoru66xWAYll5rcEXKD9QKiu6qlbZ/gFH/98=; b=PCpGKJEqiJGiNpYGBkq+PrZvrZ
	Sn0OgsmC2VevD/UWgGBYT6S64aw/3JezmO8z0gEBCv6jsT8+V4g4er4jyFzzD+j1FYfS63WRMSmg5
	73iW0Uvy0mZ3Vz3HWoJ/z7gETFLr7i72kNxTndn+XPiKZERxHVXyg6Cakc/xeX9hdH86i7tVml0cL
	YBDC9beFe7DUsC/v2oVUJEjJj+uX8pIQvDlcGUZMbB/+oIPvXtHiw+C1TBhXB3mKNfyZcpOKnrqST
	fS/xwMY0Mx9uWfgWNIbMAMtAgrS4SBDjUSov5m6OHlHnrtBaVq+pqeix3bnRb6HzEXcoPj6awiy9y
	wbPbCspg==;
Received: from [50.39.124.201] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAfRt-00000000Wj5-3HzS;
	Fri, 02 May 2025 01:44:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] security/smack/smackfs: small kernel-doc fixes
Date: Thu,  1 May 2025 18:44:21 -0700
Message-ID: <20250502014421.682697-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add function short descriptions to the kernel-doc where missing.
Correct a verb and add ending periods to sentences.

smackfs.c:1080: warning: missing initial short description on line:
 * smk_net4addr_insert
smackfs.c:1343: warning: missing initial short description on line:
 * smk_net6addr_insert

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 security/smack/smackfs.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- linux-next-20250501.orig/security/smack/smackfs.c
+++ linux-next-20250501/security/smack/smackfs.c
@@ -1077,13 +1077,12 @@ static int smk_open_net4addr(struct inod
 }
 
 /**
- * smk_net4addr_insert
+ * smk_net4addr_insert - insert a new entry into the net4addrs list
  * @new : netlabel to insert
  *
- * This helper insert netlabel in the smack_net4addrs list
+ * This helper inserts netlabel in the smack_net4addrs list
  * sorted by netmask length (longest to smallest)
- * locked by &smk_net4addr_lock in smk_write_net4addr
- *
+ * locked by &smk_net4addr_lock in smk_write_net4addr.
  */
 static void smk_net4addr_insert(struct smk_net4addr *new)
 {
@@ -1340,13 +1339,12 @@ static int smk_open_net6addr(struct inod
 }
 
 /**
- * smk_net6addr_insert
+ * smk_net6addr_insert - insert a new entry into the net6addrs list
  * @new : entry to insert
  *
  * This inserts an entry in the smack_net6addrs list
  * sorted by netmask length (longest to smallest)
- * locked by &smk_net6addr_lock in smk_write_net6addr
- *
+ * locked by &smk_net6addr_lock in smk_write_net6addr.
  */
 static void smk_net6addr_insert(struct smk_net6addr *new)
 {

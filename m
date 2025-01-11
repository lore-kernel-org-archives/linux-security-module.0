Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F368BA4A
	for <linux-security-module@vger.kernel.org>; Sat, 11 Jan 2025 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736577201; cv=none; b=C3Hnc89xGJ1zOaITRjqb5lMn7AdAD1vTITMSiDDDzJXJfBBbH0g367wzNyEbG5jD8d86JdZwmfOfw1/IY30GklDnxNOPgjbflXvPiejGrC8xsLGWDKFI59TLIU+k0c8H5hbihxSUTGLrDTiayq0BvBHopcWDMDeL6TC7eRHATR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736577201; c=relaxed/simple;
	bh=swE8rnnPN/wJ8F1hsTE/jPt2DrRoVu8cFAK6q/05aTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSVxIkpOpZHltfeCYMymvVBuaiuJnNmOyzNNreqKxUQXibZwWVibcsDnJolrDI9aNqJgfLJLlOUtb7OwGzhZmZCMaSN1QyK9OWZXmFjzgAJ123ar+wHgg/GxBNF3YmZXw47uaZj/4eI1GAaeqow70TaP9jAKo20jKWc6eZ+QssQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OsCkex9+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OsCkex9+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SUtRf4NrQ68iNsgYmoMoJ7PJqbNoeWjULP5oUFfjAiQ=; b=OsCkex9+WnDoQtXfaM2imflC31
	Fw7rPZem9SX6a2XECYW6AggCdrnsebpyE/CqhCTfTFKILZ74uwNWBqRr+G7ADemGVUn64VK04Jl+9
	HhHyjfKeewY++eBka+7Lvk8mLLcfknJspjLg3IRXdWdXiZPJVIi54sL1pXeyg1oiTeny7zsiybb16
	iQTfTiLf/lke6O0cyIydQ7BNaUbaJhaJIARLGIp+S5tWByRGezLAA1j27blPfPmDyPHNxg0D8/yYA
	uguM7S3AU37QnlZX/CzAbRX/9zIOjnJwaA1SsKdWeEu+YXHqdvRWrcXdbw/hMfx6CXNDo2VrxIw0V
	Hd1tZMNg==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tWV3f-00000000I29-0Sjg;
	Sat, 11 Jan 2025 06:33:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-security-module@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Fan Wu <wufan@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] ipe: policy_fs: fix kernel-doc warnings
Date: Fri, 10 Jan 2025 22:33:18 -0800
Message-ID: <20250111063318.911062-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the "struct" keyword in kernel-doc when describing struct
ipefs_file. Add kernel-doc for the struct members also.

Don't use kernel-doc notation for 'policy_subdir'. kernel-doc does
not support documentation comments for data definitions.

This eliminates multiple kernel-doc warnings:

security/ipe/policy_fs.c:21: warning: cannot understand function prototype: 'struct ipefs_file '
security/ipe/policy_fs.c:407: warning: cannot understand function prototype: 'const struct ipefs_file policy_subdir[] = '

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Fan Wu <wufan@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
 security/ipe/policy_fs.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-next-20250108.orig/security/ipe/policy_fs.c
+++ linux-next-20250108/security/ipe/policy_fs.c
@@ -16,7 +16,11 @@
 #define MAX_VERSION_SIZE ARRAY_SIZE("65535.65535.65535")
 
 /**
- * ipefs_file - defines a file in securityfs.
+ * struct ipefs_file - defines a file in securityfs.
+ *
+ * @name: file name inside the policy subdirectory
+ * @access: file permissions
+ * @fops: &file_operations specific to this file
  */
 struct ipefs_file {
 	const char *name;
@@ -401,7 +405,7 @@ static const struct file_operations dele
 	.write = delete_policy,
 };
 
-/**
+/*
  * policy_subdir - files under a policy subdirectory
  */
 static const struct ipefs_file policy_subdir[] = {

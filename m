Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E630253F13;
	Fri,  9 May 2025 04:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746765704; cv=none; b=HqlCJQLZXuj77a4YhEW3WznHM3Y8V/EZFNi5YtfL4CE/KyGSryhlQReKEnOe+d3Jk4f/vy/T7SsamacnAH5FKBG9148/AufCsBbThwg5se20DFLoayCoMaPOfwmktF5CRqgm6cC+QakOLOEITgztUBRcG2pWa1+Fy+j6WYy1uNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746765704; c=relaxed/simple;
	bh=3edxz8UJvCdhHCRp2TOjM8ig6g223CyuT0yTe5tHLsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSXuP9Iw0/vN17pDi7E3/pI7T6DsGPEHIm8jMrxeExo+AWMjXtCFLbYRWaDgqqz7Zi/Lxjk0XLbK+BjOgmiyZeYWRWqMcr7J5ayFA7bm3ngUcjmvC25Vr0TA0ZyCCk8/JfzqwIN9JOmbI+jruuvtTeX2v0Oo69sfxnMtCOP3hO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=v9DkD+ef; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="v9DkD+ef"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6IFHmf1AcTFsFmks6s3usI7r1PYz1F8Xd8oZ6zYyLWw=; b=v9DkD+efDTqPiEjrByPYbEvuih
	sWugvzF4ZTeGl9ebpNkvg8SYhCNfK1i//0AYh3D4FUfg5YfAm2arylDLMfIQSRVEaqhTnOyvzlWr/
	4oIPBfHF88jTK1GKxYTyrDbP0QNzN3Fh7smfETln/uadx2GVEdxC3kODn9tvFq9m9TvkYOAcrU5EB
	wHX4u+3TcxUuWJ6vWZeGQeMwxG/cmNnUyPCTrTq5KlVwKdNHpqfNs7E3yzFHPHVKGL2j7O6MPKw6T
	hu3qqoMrSu//tSbC4qTvWRvwPc659ms05HXjcMSqOaZ1LbKUQuDhfkFzcEpU93Pa1bgdOT5Yr02+M
	v/IBz4SQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFYG-0000000A83g-0aSq;
	Fri, 09 May 2025 04:41:36 +0000
Date: Fri, 9 May 2025 05:41:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: alexjlzheng@gmail.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	greg@kroah.com, chrisw@osdl.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 8/8] evm_secfs: clear securityfs interactions
Message-ID: <20250509044136.GS2023217@ZenIV>
References: <20250508140438.648533-2-alexjlzheng@tencent.com>
 <20250509032326.GJ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509032326.GJ2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

From b0b8e25f92ec20e266859de5f823b4e39b8e2f9d Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 13 May 2024 23:44:12 -0600
Subject: [PATCH 8/8] evm_secfs: clear securityfs interactions

1) creation never returns NULL; error is reported as ERR_PTR()
2) no need to remove file before removing its parent

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/integrity/evm/evm_secfs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index 9b907c2fee60..b0d2aad27850 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -17,7 +17,6 @@
 #include "evm.h"
 
 static struct dentry *evm_dir;
-static struct dentry *evm_init_tpm;
 static struct dentry *evm_symlink;
 
 #ifdef CONFIG_EVM_ADD_XATTRS
@@ -286,7 +285,7 @@ static int evm_init_xattrs(void)
 {
 	evm_xattrs = securityfs_create_file("evm_xattrs", 0660, evm_dir, NULL,
 					    &evm_xattr_ops);
-	if (!evm_xattrs || IS_ERR(evm_xattrs))
+	if (IS_ERR(evm_xattrs))
 		return -EFAULT;
 
 	return 0;
@@ -301,21 +300,22 @@ static int evm_init_xattrs(void)
 int __init evm_init_secfs(void)
 {
 	int error = 0;
+	struct dentry *dentry;
 
 	evm_dir = securityfs_create_dir("evm", integrity_dir);
-	if (!evm_dir || IS_ERR(evm_dir))
+	if (IS_ERR(evm_dir))
 		return -EFAULT;
 
-	evm_init_tpm = securityfs_create_file("evm", 0660,
-					      evm_dir, NULL, &evm_key_ops);
-	if (!evm_init_tpm || IS_ERR(evm_init_tpm)) {
+	dentry = securityfs_create_file("evm", 0660,
+				      evm_dir, NULL, &evm_key_ops);
+	if (IS_ERR(dentry)) {
 		error = -EFAULT;
 		goto out;
 	}
 
 	evm_symlink = securityfs_create_symlink("evm", NULL,
 						"integrity/evm/evm", NULL);
-	if (!evm_symlink || IS_ERR(evm_symlink)) {
+	if (IS_ERR(evm_symlink)) {
 		error = -EFAULT;
 		goto out;
 	}
@@ -328,7 +328,6 @@ int __init evm_init_secfs(void)
 	return 0;
 out:
 	securityfs_remove(evm_symlink);
-	securityfs_remove(evm_init_tpm);
 	securityfs_remove(evm_dir);
 	return error;
 }
-- 
2.39.5


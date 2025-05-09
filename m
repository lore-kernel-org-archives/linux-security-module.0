Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF9B45038;
	Fri,  9 May 2025 04:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746765585; cv=none; b=ugdOdXgU3nZngV6AopA45kOYqH3NnYQ2Z8/qHMeaY7XbhGgTWTYD4PxJxWwNave8JUmXkx2ul+vi4NhiNkxH293wcT5cP/18BMG4hJAc0A3o+uU4EWJFDHOjKY7sY11LEfW97Lf9HSRNcKRSMdzTtXnFCwiC+Lz3e+91hxJglbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746765585; c=relaxed/simple;
	bh=dqQezu+eRddiIV3dqnlriGP0IzhXutR2sMfUUa2omHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNoBT05oRhV/Qzn8fESy7ZcknhmdD44fMbYj6Z8IWpsQoJ5CFp97qno05dos3bZEKK8xPrjEHiEHZW11HYesL8EsfT90Ef9A6mQHiIQ3JdHQZSdhj8bgLnw/ohKZmFXPlCZJWeZQnrjQ6Zbl693rUByD5cu1PNz2l3BXgrlHDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=t9ACFEZx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="t9ACFEZx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kTeqHSjSaCxSnUW+CsUi2qwMCnTpkA7HbYh8qxEfd2E=; b=t9ACFEZxSaybOgKjVsQ8K19+/W
	0HYHJR621AJ0liHDDoe0qGuL1uM0Mx1bZjqCT81Z5NcDvJqyzbL/VfGwesyYW0v610Ae3k++gWjMz
	S0UuKAVOid7zvv8qONBZfLbT84wiX89ZeJEL+FXJyDcyyowclyD/dzj9XsgX9iCyJo5J2jKNLF0+n
	8kOtlGUi+HaqtJRTrbwY5tEsBuVz4L7D+5ZnPW+opl4Wg96XfxDah8YuHplaN4+qdjm3D72SizmFT
	NQcmvffn864VLdn/2OW5z9hHBBpOIK57pCyubuBWUx4dvNb26uTdjjxDhSTgDkDkt4k+XY5i9pUX6
	/Q1jFZSA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFWL-0000000A7NK-3Ye7;
	Fri, 09 May 2025 04:39:37 +0000
Date: Fri, 9 May 2025 05:39:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: alexjlzheng@gmail.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	greg@kroah.com, chrisw@osdl.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 4/8] make securityfs_remove() remove the entire subtree
Message-ID: <20250509043937.GO2023217@ZenIV>
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

From 7b5a69f41094b9a4aff491d00e9b8515fa248cef Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 13 May 2024 23:36:53 -0600
Subject: [PATCH 4/8] make securityfs_remove() remove the entire subtree

... and fix the mount leak when anything's mounted there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/inode.c | 47 +++++++++++++----------------------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 19ab99feeee3..7604040d5c45 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -281,6 +281,12 @@ struct dentry *securityfs_create_symlink(const char *name,
 }
 EXPORT_SYMBOL_GPL(securityfs_create_symlink);
 
+static void remove_one(struct dentry *victim)
+{
+	if (victim->d_parent != victim->d_sb->s_root)
+		simple_release_fs(&mount, &mount_count);
+}
+
 /**
  * securityfs_remove - removes a file or directory from the securityfs filesystem
  *
@@ -293,51 +299,24 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
  * This function is required to be called in order for the file to be
  * removed. No automatic cleanup of files will happen when a module is
  * removed; you are responsible here.
+ *
+ * AV: when applied to directory it will take all children out; no need to call
+ * it for descendents if ancestor is getting killed.
  */
 void securityfs_remove(struct dentry *dentry)
 {
-	struct inode *dir;
-
 	if (IS_ERR_OR_NULL(dentry))
 		return;
 
-	dir = d_inode(dentry->d_parent);
-	inode_lock(dir);
-	if (simple_positive(dentry)) {
-		if (d_is_dir(dentry))
-			simple_rmdir(dir, dentry);
-		else
-			simple_unlink(dir, dentry);
-	}
-	inode_unlock(dir);
-	if (dir != dir->i_sb->s_root->d_inode)
-		simple_release_fs(&mount, &mount_count);
+	simple_pin_fs(&fs_type, &mount, &mount_count);
+	simple_recursive_removal(dentry, remove_one);
+	simple_release_fs(&mount, &mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
-static void remove_one(struct dentry *victim)
-{
-	if (victim->d_parent != victim->d_sb->s_root)
-		simple_release_fs(&mount, &mount_count);
-}
-
-/**
- * securityfs_recursive_remove - recursively removes a file or directory
- *
- * @dentry: a pointer to a the dentry of the file or directory to be removed.
- *
- * This function recursively removes a file or directory in securityfs that was
- * previously created with a call to another securityfs function (like
- * securityfs_create_file() or variants thereof.)
- */
 void securityfs_recursive_remove(struct dentry *dentry)
 {
-	if (IS_ERR_OR_NULL(dentry))
-		return;
-
-	simple_pin_fs(&fs_type, &mount, &mount_count);
-	simple_recursive_removal(dentry, remove_one);
-	simple_release_fs(&mount, &mount_count);
+	securityfs_remove(dentry);
 }
 EXPORT_SYMBOL_GPL(securityfs_recursive_remove);
 
-- 
2.39.5


Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1C82222BD;
	Fri,  9 May 2025 04:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746765611; cv=none; b=fmms+MzsQW27UPaHjBSooJsa5XoJDObkYwztRIRAjeQNjr3FlHk0Hl0tihk0gOh729KCrh7XzD3FbH8JPrFkEfyIeMhk/CtvS3Fd/P5R/tigfKiN0KZqON3EgePbCmY4fl/uWcT4hWHnjcCaLCGfTb/gYKEZsVrGGRDyGIKs/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746765611; c=relaxed/simple;
	bh=tKT5Y7uSPJyRSJPa0e0cPnqRlNj1ZCCKqrv/YC63OaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UstW8XTtfpyLZgXT66ZRPeuMBeftXKSe70U1ySBv5uudfwGLkUeUMPA6hvaWxJN3xQev6pvSsIjPaxXwz6fQyPBYXo9d1fIL8rXa+FWaVaWTr/pYzP0j574pzPA8lerdRcb6itvr7CmLPsQ3t4H5HO8Ie1RIle7rfPwA2Lpi8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wId+nLON; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wId+nLON"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fpUIqKLAOo1r+nN+BtO4DEjwDtDfMoYhD5NpDfCXsDQ=; b=wId+nLONzv6UUTt2UZIMf+sACr
	KFjD3odLWO5yME1QnD944RoCMr1lnexEekR6mdT0Bk5DAZZnOlZeTfvjLYmvEF1E6GKucr+JrrMEG
	fh7c96gXifC9ABgXp0il4vDK7z2pQ92e1tGhRQeDpg8AXuPPuiV1FJGch7x0l3a7wFC8Y8bd55aNB
	Q6wADrs6tnsIAhT9AqDFzalRItXgODdp85KFc1xXmliKVlyuhsMGxFdy5viO0x+BF0nqRc5H8Sb49
	SFRO7EvFQSBHHpzbBLVn2h50pBQHpgsqcWG5yoliXtkAsuQ+1mC+F3LB4Rna2oDCD2/tCmMMPDz/K
	hc5cdNUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFWj-0000000A7X7-0jho;
	Fri, 09 May 2025 04:40:01 +0000
Date: Fri, 9 May 2025 05:40:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: alexjlzheng@gmail.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	greg@kroah.com, chrisw@osdl.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 5/8] efi_secret: clean securityfs use up
Message-ID: <20250509044001.GP2023217@ZenIV>
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

From 3d85b8d99ead2537b8be972631a9c88e6814f18b Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 14 May 2024 08:53:07 -0600
Subject: [PATCH 5/8] efi_secret: clean securityfs use up

securityfs_remove() does take care of entire subtree now; no need
to mess with them individually.

NB: ->i_op replacement in there is still buggy.  One shouldn't
ever modify ->i_op of live accessible inode.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/virt/coco/efi_secret/efi_secret.c | 37 +++++------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/virt/coco/efi_secret/efi_secret.c b/drivers/virt/coco/efi_secret/efi_secret.c
index f2da4819ec3b..5946c5abeae8 100644
--- a/drivers/virt/coco/efi_secret/efi_secret.c
+++ b/drivers/virt/coco/efi_secret/efi_secret.c
@@ -31,8 +31,6 @@
 
 struct efi_secret {
 	struct dentry *secrets_dir;
-	struct dentry *fs_dir;
-	struct dentry *fs_files[EFI_SECRET_NUM_FILES];
 	void __iomem *secret_data;
 	u64 secret_data_len;
 };
@@ -119,10 +117,8 @@ static void wipe_memory(void *addr, size_t size)
 
 static int efi_secret_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct efi_secret *s = efi_secret_get();
 	struct inode *inode = d_inode(dentry);
 	struct secret_entry *e = (struct secret_entry *)inode->i_private;
-	int i;
 
 	if (e) {
 		/* Zero out the secret data */
@@ -132,10 +128,6 @@ static int efi_secret_unlink(struct inode *dir, struct dentry *dentry)
 
 	inode->i_private = NULL;
 
-	for (i = 0; i < EFI_SECRET_NUM_FILES; i++)
-		if (s->fs_files[i] == dentry)
-			s->fs_files[i] = NULL;
-
 	return simple_unlink(inode, dentry);
 }
 
@@ -186,15 +178,6 @@ static int efi_secret_map_area(struct platform_device *dev)
 static void efi_secret_securityfs_teardown(struct platform_device *dev)
 {
 	struct efi_secret *s = efi_secret_get();
-	int i;
-
-	for (i = (EFI_SECRET_NUM_FILES - 1); i >= 0; i--) {
-		securityfs_remove(s->fs_files[i]);
-		s->fs_files[i] = NULL;
-	}
-
-	securityfs_remove(s->fs_dir);
-	s->fs_dir = NULL;
 
 	securityfs_remove(s->secrets_dir);
 	s->secrets_dir = NULL;
@@ -209,7 +192,7 @@ static int efi_secret_securityfs_setup(struct platform_device *dev)
 	unsigned char *ptr;
 	struct secret_header *h;
 	struct secret_entry *e;
-	struct dentry *dent;
+	struct dentry *dent, *dir;
 	char guid_str[EFI_VARIABLE_GUID_LEN + 1];
 
 	ptr = (void __force *)s->secret_data;
@@ -232,8 +215,6 @@ static int efi_secret_securityfs_setup(struct platform_device *dev)
 	}
 
 	s->secrets_dir = NULL;
-	s->fs_dir = NULL;
-	memset(s->fs_files, 0, sizeof(s->fs_files));
 
 	dent = securityfs_create_dir("secrets", NULL);
 	if (IS_ERR(dent)) {
@@ -243,14 +224,13 @@ static int efi_secret_securityfs_setup(struct platform_device *dev)
 	}
 	s->secrets_dir = dent;
 
-	dent = securityfs_create_dir("coco", s->secrets_dir);
-	if (IS_ERR(dent)) {
+	dir = securityfs_create_dir("coco", s->secrets_dir);
+	if (IS_ERR(dir)) {
 		dev_err(&dev->dev, "Error creating coco securityfs directory entry err=%ld\n",
-			PTR_ERR(dent));
-		return PTR_ERR(dent);
+			PTR_ERR(dir));
+		return PTR_ERR(dir);
 	}
-	d_inode(dent)->i_op = &efi_secret_dir_inode_operations;
-	s->fs_dir = dent;
+	d_inode(dir)->i_op = &efi_secret_dir_inode_operations;
 
 	bytes_left = h->len - sizeof(*h);
 	ptr += sizeof(*h);
@@ -266,15 +246,14 @@ static int efi_secret_securityfs_setup(struct platform_device *dev)
 		if (efi_guidcmp(e->guid, NULL_GUID)) {
 			efi_guid_to_str(&e->guid, guid_str);
 
-			dent = securityfs_create_file(guid_str, 0440, s->fs_dir, (void *)e,
+			dent = securityfs_create_file(guid_str, 0440, dir, (void *)e,
 						      &efi_secret_bin_file_fops);
 			if (IS_ERR(dent)) {
 				dev_err(&dev->dev, "Error creating efi_secret securityfs entry\n");
 				ret = PTR_ERR(dent);
 				goto err_cleanup;
 			}
-
-			s->fs_files[i++] = dent;
+			i++;
 		}
 		ptr += e->len;
 		bytes_left -= e->len;
-- 
2.39.5


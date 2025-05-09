Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F832522B6;
	Fri,  9 May 2025 04:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746765682; cv=none; b=hTe0hTg90FWEaav3SFhNxNGgavrgYUgL/WldAd1NMvyoAYfwbqOuHTCgfU0sFLCaFfZkU1faGSfiGNxk6mVMptD/GfsKF6zFBwWVELHVN3QrPVz0rWFf0YI8QkVT/vZose/joPohQdd4dChR9Xa9IJoQcl8TxiAZmKHnolFOijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746765682; c=relaxed/simple;
	bh=SG1HkB1CroQNMMQVxFkVWmEr0jmoR+gJ7cCwJLKnMBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUTTN9gxJ8M5aP8b+uR3bfufAes9qUHYIdE8DZdVrirSZxuKtVVv56llbMiAAuNg4vC7D0BoIKjD+9hxIJQSKxONtHjxPUvRudOBvTdPper3Ky7ArvZCTU+45mhp69JeK43+YfCSwKEc9x+QqiuteLc+bKqyThOLABcAnWNbz+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=N8ufxr+U; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="N8ufxr+U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HR+VLuTu8jfyI5dUfy934VMN6WGObL+/+Fc82wI9xjU=; b=N8ufxr+UFYT97I4T+LZoXxHjJE
	eVEYj9tsyETZP4zR6TalUZcXWYy31tD2/bRimjcHZX2DZFrApcs0ucB+P7auwykyUBDk0juUZpkED
	5p6a5r4S3G3afJXKL7mEJxOn42rh18vUnHcaE3WdbGaFDusUZKeFakhKSf4P+gtjQDqARUdTlMdkY
	f2hYkroBMLti1bHS78/dXzv9G/zUdenXfC/VkcLNSGethn8Lxi5yXhxo8QpZ2aFTG9b1K5luupuhI
	cBy6HL4TEpRBO4lnVgifxWEhc3N0VPn7DH1Han32qmi7eacxJ8jnWuF4U64kfRtiNQUneg6YubOHn
	USMkSq/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFXq-0000000A7uR-3Sp6;
	Fri, 09 May 2025 04:41:10 +0000
Date: Fri, 9 May 2025 05:41:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: alexjlzheng@gmail.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	greg@kroah.com, chrisw@osdl.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 7/8] ima_fs: get rid of lookup-by-dentry stuff
Message-ID: <20250509044110.GR2023217@ZenIV>
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

From 35fa1b12f16a61b59886d5aae7e45af9d324a6f1 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 10 Mar 2025 12:30:20 -0400
Subject: [PATCH 7/8] ima_fs: get rid of lookup-by-dentry stuff

lookup_template_data_hash_algo() machinery is used to locate the
matching ima_algo_array[] element at read time; securityfs
allows to stash that into inode->i_private at object creation
time, so there's no need to bother

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/integrity/ima/ima_fs.c | 82 +++++++--------------------------
 1 file changed, 16 insertions(+), 66 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 8e2c132ce640..07efd71b6310 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -116,28 +116,6 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
 		seq_putc(m, *(char *)data++);
 }
 
-static struct dentry **ascii_securityfs_measurement_lists __ro_after_init;
-static struct dentry **binary_securityfs_measurement_lists __ro_after_init;
-static int securityfs_measurement_list_count __ro_after_init;
-
-static void lookup_template_data_hash_algo(int *algo_idx, enum hash_algo *algo,
-					   struct seq_file *m,
-					   struct dentry **lists)
-{
-	struct dentry *dentry;
-	int i;
-
-	dentry = file_dentry(m->file);
-
-	for (i = 0; i < securityfs_measurement_list_count; i++) {
-		if (dentry == lists[i]) {
-			*algo_idx = i;
-			*algo = ima_algo_array[i].algo;
-			break;
-		}
-	}
-}
-
 /* print format:
  *       32bit-le=pcr#
  *       char[n]=template digest
@@ -160,9 +138,10 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	algo_idx = ima_sha1_idx;
 	algo = HASH_ALGO_SHA1;
 
-	if (m->file != NULL)
-		lookup_template_data_hash_algo(&algo_idx, &algo, m,
-					       binary_securityfs_measurement_lists);
+	if (m->file != NULL) {
+		algo_idx = (unsigned long)file_inode(m->file)->i_private;
+		algo = ima_algo_array[algo_idx].algo;
+	}
 
 	/* get entry */
 	e = qe->entry;
@@ -256,9 +235,10 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	algo_idx = ima_sha1_idx;
 	algo = HASH_ALGO_SHA1;
 
-	if (m->file != NULL)
-		lookup_template_data_hash_algo(&algo_idx, &algo, m,
-					       ascii_securityfs_measurement_lists);
+	if (m->file != NULL) {
+		algo_idx = (unsigned long)file_inode(m->file)->i_private;
+		algo = ima_algo_array[algo_idx].algo;
+	}
 
 	/* get entry */
 	e = qe->entry;
@@ -412,57 +392,33 @@ static const struct seq_operations ima_policy_seqops = {
 };
 #endif
 
-static void __init remove_securityfs_measurement_lists(struct dentry **lists)
-{
-	kfree(lists);
-}
-
 static int __init create_securityfs_measurement_lists(void)
 {
-	char file_name[NAME_MAX + 1];
-	struct dentry *dentry;
-	u16 algo;
-	int i;
-
-	securityfs_measurement_list_count = NR_BANKS(ima_tpm_chip);
+	int count = NR_BANKS(ima_tpm_chip);
 
 	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
-		securityfs_measurement_list_count++;
+		count++;
 
-	ascii_securityfs_measurement_lists =
-	    kcalloc(securityfs_measurement_list_count, sizeof(struct dentry *),
-		    GFP_KERNEL);
-	if (!ascii_securityfs_measurement_lists)
-		return -ENOMEM;
-
-	binary_securityfs_measurement_lists =
-	    kcalloc(securityfs_measurement_list_count, sizeof(struct dentry *),
-		    GFP_KERNEL);
-	if (!binary_securityfs_measurement_lists)
-		return -ENOMEM;
-
-	for (i = 0; i < securityfs_measurement_list_count; i++) {
-		algo = ima_algo_array[i].algo;
+	for (int i = 0; i < count; i++) {
+		u16 algo = ima_algo_array[i].algo;
+		char file_name[NAME_MAX + 1];
+		struct dentry *dentry;
 
 		sprintf(file_name, "ascii_runtime_measurements_%s",
 			hash_algo_name[algo]);
 		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
-						ima_dir, NULL,
+						ima_dir, (void *)(uintptr_t)i,
 						&ima_ascii_measurements_ops);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 
-		ascii_securityfs_measurement_lists[i] = dentry;
-
 		sprintf(file_name, "binary_runtime_measurements_%s",
 			hash_algo_name[algo]);
 		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
-						ima_dir, NULL,
+						ima_dir, (void *)(uintptr_t)i,
 						&ima_measurements_ops);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
-
-		binary_securityfs_measurement_lists[i] = dentry;
 	}
 
 	return 0;
@@ -544,9 +500,6 @@ int __init ima_fs_init(void)
 	struct dentry *dentry;
 	int ret;
 
-	ascii_securityfs_measurement_lists = NULL;
-	binary_securityfs_measurement_lists = NULL;
-
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
 	if (IS_ERR(ima_dir))
 		return PTR_ERR(ima_dir);
@@ -601,9 +554,6 @@ int __init ima_fs_init(void)
 
 	return 0;
 out:
-	remove_securityfs_measurement_lists(ascii_securityfs_measurement_lists);
-	remove_securityfs_measurement_lists(binary_securityfs_measurement_lists);
-	securityfs_measurement_list_count = 0;
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
 
-- 
2.39.5


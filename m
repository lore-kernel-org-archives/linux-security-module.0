Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518724889B;
	Fri,  9 May 2025 04:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746765656; cv=none; b=eGSAE77tqKMQxR/Vwwzhg7LdCfAfQ6N0v/99Kp0xJksbUDgrLl4n1gWe2YyqGMXnz5Blh9N95TIKp8rmFJaT5SEDJMEBkrUEx8bthpvIeO4rZGCRKeI/Cp1niv26i/omrwhodGjW9DG0BxcweuGI/bV1vHo1B3JlsNANFACAA1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746765656; c=relaxed/simple;
	bh=hmvbaP32VL03KSoFyEzDTovmeU3Bqv7F1oYkmE6oOSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogMEPIHS27Dq3O7EzDeWnhmzALX1EZ7AT/Qwguc83kUzNPd0B9nIqp36u2h8YALoXIEHolfCpHYPyxCZn73UDOk/VV0tIYcp86tyuEVjXBD3Z+4s83EYJHih7BcDEkZuU6K14G46WKlfzAk47igEULcNccm3peomD0AgcPnlrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SFMQJr69; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SFMQJr69"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XZx7MWw+4eNAJqXKzRhLweRHBazmdSRHL3XZnetWUAo=; b=SFMQJr69etSqv9VI5uAuvFodJx
	HYReWsPC8+bvjVK+CKpC7COkrhXq/Z9TkwwFi3W50nNif5neGpb6Cn2Q52UmoPt8TqUeNkxECyyLo
	AYa0JBh1Qg4izJejZ4Ri16L0huSvT2oe7oeB6wpD/ZHLeCtxMiwbh7M67o9vMMlsC3xbHxl9VebnW
	p/Au41CET21dLTt2ivbBGV3ADfavnkUjjqJFn9HBBUeI+hgN1oomn8AQC1rCqKzTkjSCIdMEWk+FX
	45HzR7uMHkYnwU57FELlL2LIL8Mdn6egHFnhsJjwT9y34OvogWkZ8oSk6L9QYmFGnSnNQrbyvV+Jj
	vCSxOyMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFXT-0000000A7nr-1kri;
	Fri, 09 May 2025 04:40:47 +0000
Date: Fri, 9 May 2025 05:40:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: alexjlzheng@gmail.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	greg@kroah.com, chrisw@osdl.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 6/8] ima_fs: don't bother with removal of files in directory
 we'll be removing
Message-ID: <20250509044047.GQ2023217@ZenIV>
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

From 08433f2507554980bc891d8b17c1968c81cb144b Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 13 May 2024 23:41:51 -0600
Subject: [PATCH 6/8] ima_fs: don't bother with removal of files in directory
 we'll be removing

removal of parent takes all children out

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/integrity/ima/ima_fs.c | 54 +++++++++++----------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e4a79a9b2d58..8e2c132ce640 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -396,11 +396,6 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 
 static struct dentry *ima_dir;
 static struct dentry *ima_symlink;
-static struct dentry *binary_runtime_measurements;
-static struct dentry *ascii_runtime_measurements;
-static struct dentry *runtime_measurements_count;
-static struct dentry *violations;
-static struct dentry *ima_policy;
 
 enum ima_fs_flags {
 	IMA_FS_BUSY,
@@ -419,14 +414,7 @@ static const struct seq_operations ima_policy_seqops = {
 
 static void __init remove_securityfs_measurement_lists(struct dentry **lists)
 {
-	int i;
-
-	if (lists) {
-		for (i = 0; i < securityfs_measurement_list_count; i++)
-			securityfs_remove(lists[i]);
-
-		kfree(lists);
-	}
+	kfree(lists);
 }
 
 static int __init create_securityfs_measurement_lists(void)
@@ -553,6 +541,7 @@ static const struct file_operations ima_measure_policy_ops = {
 
 int __init ima_fs_init(void)
 {
+	struct dentry *dentry;
 	int ret;
 
 	ascii_securityfs_measurement_lists = NULL;
@@ -573,54 +562,45 @@ int __init ima_fs_init(void)
 	if (ret != 0)
 		goto out;
 
-	binary_runtime_measurements =
-	    securityfs_create_symlink("binary_runtime_measurements", ima_dir,
+	dentry = securityfs_create_symlink("binary_runtime_measurements", ima_dir,
 				      "binary_runtime_measurements_sha1", NULL);
-	if (IS_ERR(binary_runtime_measurements)) {
-		ret = PTR_ERR(binary_runtime_measurements);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
 		goto out;
 	}
 
-	ascii_runtime_measurements =
-	    securityfs_create_symlink("ascii_runtime_measurements", ima_dir,
+	dentry = securityfs_create_symlink("ascii_runtime_measurements", ima_dir,
 				      "ascii_runtime_measurements_sha1", NULL);
-	if (IS_ERR(ascii_runtime_measurements)) {
-		ret = PTR_ERR(ascii_runtime_measurements);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
 		goto out;
 	}
 
-	runtime_measurements_count =
-	    securityfs_create_file("runtime_measurements_count",
+	dentry = securityfs_create_file("runtime_measurements_count",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_measurements_count_ops);
-	if (IS_ERR(runtime_measurements_count)) {
-		ret = PTR_ERR(runtime_measurements_count);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
 		goto out;
 	}
 
-	violations =
-	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
+	dentry = securityfs_create_file("violations", S_IRUSR | S_IRGRP,
 				   ima_dir, NULL, &ima_htable_violations_ops);
-	if (IS_ERR(violations)) {
-		ret = PTR_ERR(violations);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
 		goto out;
 	}
 
-	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
+	dentry = securityfs_create_file("policy", POLICY_FILE_FLAGS,
 					    ima_dir, NULL,
 					    &ima_measure_policy_ops);
-	if (IS_ERR(ima_policy)) {
-		ret = PTR_ERR(ima_policy);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
 		goto out;
 	}
 
 	return 0;
 out:
-	securityfs_remove(ima_policy);
-	securityfs_remove(violations);
-	securityfs_remove(runtime_measurements_count);
-	securityfs_remove(ascii_runtime_measurements);
-	securityfs_remove(binary_runtime_measurements);
 	remove_securityfs_measurement_lists(ascii_securityfs_measurement_lists);
 	remove_securityfs_measurement_lists(binary_securityfs_measurement_lists);
 	securityfs_measurement_list_count = 0;
-- 
2.39.5


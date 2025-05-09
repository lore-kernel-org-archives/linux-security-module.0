Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0F23373D;
	Fri,  9 May 2025 04:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746765563; cv=none; b=MyOSEPmn+VzzazmABTyZtxkmhUdOdChteDvrb0bAcTeiDxOds+7YYgwiCU1Gol9cwVQBLCHEHTyT0l7Ffu5Me1qYeWjw99qCYbPtSv3wYE5Va5SNrjQx5g27KhtqTaLm0Fg1PP4vBEmKZjQWq2/936DBM1zryTd7AJ9CeppyhBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746765563; c=relaxed/simple;
	bh=EZQb8iIG/SHEbTjiz3fd7lizdcsokXmu2Bx8REH0cAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DILqPpEoB/ujbrCkbDib+DTMgwo22Vi0YHvgT+IfhsSofTQUUHUqk+MzeV8eJDTV1ouxJZ5Ls2V3hZ1sFi8H7nLlhChl/ehEoBTlULvg+lXjUTDJAqqQiXlDuWmKqvjlDht++D8xp+wEudWl8D5fEjZcqxSZ1E8S2RWiL85xYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZHN7QDsC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZHN7QDsC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3gdPMPoIlxA/FHWfFkpCmq+Eah3CFJnumJNyzeIIKis=; b=ZHN7QDsC5x/f4CMBsqVUV2nN6g
	uChGBpxxVA/FHLFcRcjm03cwViAlL0NLjVQ+t3mvWvqWaXxsKQbO32rCWxrvPq0YP33zDMZBiPL6j
	qgaLioiydcLINsxFtdlZinCY2zqcUkIWjqePNDIseurSyq6brpdhtq8gH0Y94TknS9cwC+/YtOWsY
	PCOrx+GEI5EuI7u2bSlzfTpeK8H2mZKDKQ+NS2BE60nKVwHmm5r359c4+yIQVg6L+TZ5MQFNoGKxN
	2NoNVV9V36jUta97nq+Qahb0xtNVkDnKTdCXHBkGKbQ9pEkHMw6bntsbwXEf69UoZFnd3QfIExVlS
	VFJqkk1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFVx-0000000A7Ih-3XQH;
	Fri, 09 May 2025 04:39:13 +0000
Date: Fri, 9 May 2025 05:39:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: alexjlzheng@gmail.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	greg@kroah.com, chrisw@osdl.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 3/8] fix locking in efi_secret_unlink()
Message-ID: <20250509043913.GN2023217@ZenIV>
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

From d332a8fcb3c1219f5e0ae1961a8ff4a4e3cd3bcc Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 14 May 2024 08:48:58 -0600
Subject: [PATCH 3/8] fix locking in efi_secret_unlink()

now we can just have it call simple_unlink() and be done with that

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/virt/coco/efi_secret/efi_secret.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/virt/coco/efi_secret/efi_secret.c b/drivers/virt/coco/efi_secret/efi_secret.c
index 1864f9f80617..f2da4819ec3b 100644
--- a/drivers/virt/coco/efi_secret/efi_secret.c
+++ b/drivers/virt/coco/efi_secret/efi_secret.c
@@ -136,15 +136,7 @@ static int efi_secret_unlink(struct inode *dir, struct dentry *dentry)
 		if (s->fs_files[i] == dentry)
 			s->fs_files[i] = NULL;
 
-	/*
-	 * securityfs_remove tries to lock the directory's inode, but we reach
-	 * the unlink callback when it's already locked
-	 */
-	inode_unlock(dir);
-	securityfs_remove(dentry);
-	inode_lock(dir);
-
-	return 0;
+	return simple_unlink(inode, dentry);
 }
 
 static const struct inode_operations efi_secret_dir_inode_operations = {
-- 
2.39.5


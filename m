Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF647322E;
	Fri,  9 May 2025 04:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746765537; cv=none; b=BIUWx8LPsJr4PxzzefGDGp8QU7bwnOLwrOZP7i4rSe3AGPP3oLrkAm+IkD61sGc4DragHpMw718lzxB/KWjl8bJsk69E6JZNHbwnUplLQQ1dT0IW+JlesLtpG0w7YGvJ8ki+OnRGgibjHpPhzu4ZWRYBCG9GjcOeyzPt6Gs50gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746765537; c=relaxed/simple;
	bh=4N6qGlFzEZ653iqywACVNjFOfUDYyZODQnI4muL6/IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyjXEK1+eZIaUHOqj7XMoWJpW9o60pahf71qefZHWEhXvNY+Ev6zui+6YQ423Lm2QVJSA4K6BFIbEEwo24ZN/aYEVxo4hmQsAXE42kREXTpXaojoWjX83vekxnRKKOpz5ozIOfFqf23JuQplICokJ3ie2Lre10zlvyQ6G+ppXts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZptpExIz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZptpExIz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aYiruGcuVJAFDdSWmWaqU5Kk5O2dQYBm2szAv6XmEM4=; b=ZptpExIzTr7gp8Kf12nGH6vvuV
	QZVBveZ3UyCzWHZavV70v0dV6yudsiykEYq4pEGrp6MJn2qn7g/1MqAxtInJWORyDlBtJ/wwvvfkB
	d+D24duLmAOyoduLtw5EsgoRPrMtb0fCx+tleal+tzTFgELTWcdZwIqLVj9g+bBJitscTGl4OPxuk
	xryiu9tT1jKLszh+ZubQiRm694wZexUU8j2HkD2b/t61Oco4cZyUpIr12Pzj9qZ2X81epnIU5z+lx
	6/mJUp9talgr9p65q2oTzt8NXRMD7YNYfmSAMsI/xrur/glPK8OxiO0O32d/u524kVYTLvbGF76uy
	PbCZd+aw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFVX-0000000A7EH-2E2f;
	Fri, 09 May 2025 04:38:47 +0000
Date: Fri, 9 May 2025 05:38:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: alexjlzheng@gmail.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	greg@kroah.com, chrisw@osdl.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 2/8] securityfs: pin filesystem only for objects directly in
 root
Message-ID: <20250509043847.GM2023217@ZenIV>
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

From 23947dd21a91b95208863c74d4dbc67d0027f43a Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 14 May 2024 08:46:00 -0600
Subject: [PATCH 2/8] securityfs: pin filesystem only for objects directly in
 root

Nothing on securityfs ever changes parents, so we don't need
to pin the internal mount if it's already pinned for parent.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/inode.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 58cc60c50498..19ab99feeee3 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -112,18 +112,20 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	struct dentry *dentry;
 	struct inode *dir, *inode;
 	int error;
+	bool pinned = false;
 
 	if (!(mode & S_IFMT))
 		mode = (mode & S_IALLUGO) | S_IFREG;
 
 	pr_debug("securityfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&fs_type, &mount, &mount_count);
-	if (error)
-		return ERR_PTR(error);
-
-	if (!parent)
+	if (!parent) {
+		error = simple_pin_fs(&fs_type, &mount, &mount_count);
+		if (error)
+			return ERR_PTR(error);
+		pinned = true;
 		parent = mount->mnt_root;
+	}
 
 	dir = d_inode(parent);
 
@@ -167,7 +169,8 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dentry = ERR_PTR(error);
 out:
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (pinned)
+		simple_release_fs(&mount, &mount_count);
 	return dentry;
 }
 
@@ -307,13 +310,15 @@ void securityfs_remove(struct dentry *dentry)
 			simple_unlink(dir, dentry);
 	}
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (dir != dir->i_sb->s_root->d_inode)
+		simple_release_fs(&mount, &mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
 static void remove_one(struct dentry *victim)
 {
-	simple_release_fs(&mount, &mount_count);
+	if (victim->d_parent != victim->d_sb->s_root)
+		simple_release_fs(&mount, &mount_count);
 }
 
 /**
-- 
2.39.5


Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9E322E;
	Fri,  9 May 2025 04:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746765486; cv=none; b=mOtgZrufHghXCOdAOPaj4SCe7uBF+KaGet4WYwe+5hFIwrJ6XgRokhcxa1Nj9qRA7wepB1pbsSMOPXbvNoGEW4Z06pjTUp7nCiAevbxqUklv8DCF0YKGPZ4jhRLy3VkqBTCGN81CmD5JwLeMwortHv7yy5qx/T7j3lSpzkmbYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746765486; c=relaxed/simple;
	bh=AIOkN5fc6Y5FC5lzNhMc+Gban8oQCRv8vKsXkG0T4dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNZiGGfBI7s1sjm7JZ5RZ6M+x93tRiBjR0kn2vcXBS1zklmUpa8vKBHII2eB30G3eRakOf0SjcHl/HAz/rHvF+aPvg1UjtIkcQ/IchdIOD8baHuEV2iQs9IonX/k4vEC/r7LMaMJU3ASIEeYE7/PN98HYLCUJjb/Z1PzCT/biOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ovJWG9tW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ovJWG9tW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bs7pZfusnIGIfbEbe6M4YzPBDpGQCHF9WnoQPSxGikM=; b=ovJWG9tWwQ+XjYaPjlLUI+JPDP
	B4I0KhvEkgPYpyPJep5sJGPWbrIpHj+SALB1dbTX7H6u6D/ZUt/fTu7WPl77mir9GovScmOZSS17J
	NF9QIoK5IWBoxffZ6smy5XEij+6Iz0+UulJMeSJ6yCw/x7mUeHQ8Og6bPXbIN+LRTr7cMrKZzA7Mn
	SMpcx+lbZHDIKv/cWrQS3peW0Y+C/4xfZJL4m5uYyAueBRI72TAt5a8Mmjtt+sEGOr3XQkbUV4cF3
	taooBTm5utVFdQ3HUEcW8+aPByAE+0G2ANz7NIFfN4r9EebCbRS4rLCSzyPwEcEc19NuwuL2Q469m
	tPEc0BnA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFUj-0000000A76p-2Mwl;
	Fri, 09 May 2025 04:37:57 +0000
Date: Fri, 9 May 2025 05:37:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: alexjlzheng@gmail.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	greg@kroah.com, chrisw@osdl.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 1/8] securityfs: don't pin dentries twice, once is enough...
Message-ID: <20250509043757.GL2023217@ZenIV>
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

From 5c463d47c814e16adb6e997a05ca5625df41152d Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Thu, 8 May 2025 23:38:01 -0400
Subject: [PATCH 1/8] securityfs: don't pin dentries twice, once is enough...

incidentally, securityfs_recursive_remove() is broken without that -
it leaks dentries, since simple_recursive_removal() does not expect
anything of that sort.  It could be worked around by dput() in
remove_one() callback, but it's easier to just drop that double-get
stuff.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index da3ab44c8e57..58cc60c50498 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -159,7 +159,6 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		inode->i_fop = fops;
 	}
 	d_instantiate(dentry, inode);
-	dget(dentry);
 	inode_unlock(dir);
 	return dentry;
 
@@ -306,7 +305,6 @@ void securityfs_remove(struct dentry *dentry)
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
-		dput(dentry);
 	}
 	inode_unlock(dir);
 	simple_release_fs(&mount, &mount_count);
-- 
2.39.5


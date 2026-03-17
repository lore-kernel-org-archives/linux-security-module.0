Received: from forward206d.mail.yandex.net (forward206d.mail.yandex.net [178.154.239.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968C3E1220
	for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757087; cv=none; b=jJfz2aa5LeGqp0tPYmXmnc4zT7dc5SAk1KSP8OCmg/WvzunzXdQV0RXtlS1KT30AC+IPnJ3jVNhLZ2ipwsPibIvpK92jxv3ATUTeSSnp/g8yQ+dp4Nvk9sQu4LelBDw9g8r+RqB0efDHMvkPZq8JNplGkO547ygdI8laLFePvRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757087; c=relaxed/simple;
	bh=p79DHuTVvXpJVoKH4N6hLSGQl4srZfNd9ILdtTievdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ov1//PWrX8RDUa5AvIXZE6l0EYN4PNM0922zhiNyLllLLeIqJS6tlg8dk4GoPQ3Ps2ALVBByt2Yl4m4kSfAm0e1roO1ahZY9VBoh8qjGdNooKXEUrseSdttKxRYCYPjZg5W+mZV/Ad5M2JPIETbYe9lKK774FKiaUem+PVLi4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=B0UGcTaJ; arc=none smtp.client-ip=178.154.239.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="B0UGcTaJ"
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward206d.mail.yandex.net (Yandex) with ESMTPS id 0621081B47
	for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 17:12:17 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:eaca:0:640:4fc0:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 646DFC0031;
	Tue, 17 Mar 2026 17:12:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7CN9g1DGn4Y0-VUny64Nu;
	Tue, 17 Mar 2026 17:12:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1773756729; bh=02qxw/jYqyGyMY6AFzmhUleDAePlUPAIrCUsUa+sZpc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=B0UGcTaJK3A2GH9TisR6JHxK5SGSKMc95xm9beGWX1XS4KYcSOvdncpD85f+jxJBH
	 10OlhFOjRl4mb+j07niqLe0vVfgBHr5YYQlbwgY3TV9CsNcOhoDxYdEwPX7smGCpl/
	 ii4As9aKrTebxASbL2EyxuBbYIgD9HkXSNaUg8TQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] securityfs: use kstrdup_const() to manage symlink targets
Date: Tue, 17 Mar 2026 17:11:35 +0300
Message-ID: <20260317141135.133339-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'target' argument of 'securityfs_create_symlink()' is (for
now at least) a compile-time constant, it may be reasonable to
use 'kstrdup_const()' / 'kree_const()' to manage 'i_link' member
of the corresponding inode in attempt to reuse .rodata instance
rather than making a copy.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 security/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 81fb5d6dd33e..080402367674 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -30,7 +30,7 @@ static int mount_count;
 static void securityfs_free_inode(struct inode *inode)
 {
 	if (S_ISLNK(inode->i_mode))
-		kfree(inode->i_link);
+		kfree_const(inode->i_link);
 	free_inode_nonrcu(inode);
 }
 
@@ -258,17 +258,17 @@ struct dentry *securityfs_create_symlink(const char *name,
 					 const struct inode_operations *iops)
 {
 	struct dentry *dent;
-	char *link = NULL;
+	const char *link = NULL;
 
 	if (target) {
-		link = kstrdup(target, GFP_KERNEL);
+		link = kstrdup_const(target, GFP_KERNEL);
 		if (!link)
 			return ERR_PTR(-ENOMEM);
 	}
 	dent = securityfs_create_dentry(name, S_IFLNK | 0444, parent,
-					link, NULL, iops);
+					(void *)link, NULL, iops);
 	if (IS_ERR(dent))
-		kfree(link);
+		kfree_const(link);
 
 	return dent;
 }
-- 
2.53.0


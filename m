Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0453446A6
	for <linux-security-module@vger.kernel.org>; Wed,  5 Nov 2025 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372652; cv=none; b=TaUpF8lRasDTyFalcb5lHsGsBdnZt7NLXRxhUQ6moVyIIli9WwZaOxetaUqPFyizhaDZ5lzQJlIyAhZaA73Ige6SE8gM70TAkN+HUIQOef2YNsWcjthsuPuDsfETAlbZkBI0C8Fgqs4D/fVpwei4dDxEW+j3+bOz6+5teOSuCxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372652; c=relaxed/simple;
	bh=d+6GABhhX6qdFUQptsJgpAYN/PEEUyC1RmNUJoTW+vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sVudlZV5s/i/6S2log6GOaJO69wml5McjymdesfyDbslgH8PeeSf+SAWAcwk5cj5/w6tCLaOovMDsjZWYtYgsDG2QVfw/gLiMBhwfyDYIYMSoZJKvVomeuAQJKvYk63BoVO/klkaAzI6DS7Di8p+z4hTL4TWQd8FV7nb8mnsFCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=loqbXXje; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="loqbXXje"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d1wbK4GJDzYdd;
	Wed,  5 Nov 2025 20:38:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1762371485;
	bh=SFTb5KCy/2+7VKIrPK8845ifDCLgH0t8yJLtdcU3XV4=;
	h=From:To:Cc:Subject:Date:From;
	b=loqbXXjeH7j9Xa8aBCgUPRba7a/Z9bjphSoAfexT86YOJHHirNZJbeeQ3PO/wzBkq
	 sUWI/LfMJqhKOOTn12m7HZS+Clb+C4y8aYbM9IAfvaNyghxTXafT5M5ehx+SBbVH5n
	 H3P3AShAS4VG5etaRKEySGCuTW1PTN5lMSGYB9iI=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4d1wbJ3bdRz6tY;
	Wed,  5 Nov 2025 20:38:04 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Edward Adam Davis <eadavis@qq.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Tingmao Wang <m@maowtm.org>,
	syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Subject: [PATCH v1] fs: Move might_sleep() annotation to iput_final()
Date: Wed,  5 Nov 2025 20:37:59 +0100
Message-ID: <20251105193800.2340868-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

iput() don't directly call any sleepable code but mostly checks flags
and decrement a reference counter before calling iput_final() and then
evict().

Some code might call iput() with guarantees that iput_final() will not
be called.  This is the case for Landlock's hook_sb_delete() where the
inode counter must de decremented while holding it with another
reference, see comment above the first iput() call.

Move the new might_sleep() call from iput() to iput_final().  The
alternative would be to manually decrement the counter without calling
iput(), but it doesn't seem right.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Edward Adam Davis <eadavis@qq.com>
Cc: Günther Noack <gnoack@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Max Kellermann <max.kellermann@ionos.com>
Cc: Tingmao Wang <m@maowtm.org>
Reported-by: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d32659.a70a0220.4f78.0012.GAE@google.com/
Fixes: 2ef435a872ab ("fs: add might_sleep() annotation to iput() and more")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

From hook_sb_delete():

	/*
	 * At this point, we own the ihold() reference that was
	 * originally set up by get_inode_object() and the
	 * __iget() reference that we just set in this loop
	 * walk.  Therefore the following call to iput() will
	 * not sleep nor drop the inode because there is now at
	 * least two references to it.
	 */
	iput(inode);

#syz test

---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 84f539497857..64120cb21e8b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1917,6 +1917,7 @@ static void iput_final(struct inode *inode)
 	const struct super_operations *op = inode->i_sb->s_op;
 	int drop;
 
+	might_sleep();
 	WARN_ON(inode_state_read(inode) & I_NEW);
 	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
 
@@ -1969,7 +1970,6 @@ static void iput_final(struct inode *inode)
  */
 void iput(struct inode *inode)
 {
-	might_sleep();
 	if (unlikely(!inode))
 		return;
 
-- 
2.51.0


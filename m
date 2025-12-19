Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B8F2D47E9
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766173173; cv=none; b=GJM+5TUML0+xqS3VpavdAh0Y1WV9cqwURwqyKMMJjr57f9PAyZy8AVgRfWovUqNSiu3toyFQxPbQvIn/41w7gN8PhzfZSPVh/W1sh8WHwww/+trpDUtqifwrzkQmwOHX2z1P03+vl0464Rp7Pqz1hpfV9ktgYFg1luQpc7uWico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766173173; c=relaxed/simple;
	bh=t92dIdfSqhdzDG627An/oOFhKh4WxiKN0dE8JVhVk6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dl/vYk/fkkyofRXJZgMV3o2klD5xREv28WLreV8TCSwX8YzFt9nEy1Gkh2/2RbPahNBDS/A9zdGTg+Dj8drmmK8NqALL3zSFd9ZfSufctwl/TUn9/vf5M9clczKua8QglmihSEyPikJkSv/m9VQ+Ft8yupUuxkSpRNpjmj8WU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nxAcH4zT; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nxAcH4zT"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dXyXT5jTHz175X;
	Fri, 19 Dec 2025 20:39:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766173161;
	bh=63ZFsrWGg8gwLyQQURU09o4dY1w3RavJr6jbG8bJWwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxAcH4zTG7Fthnhe5RIkUbNIX6lPb0cDVx/th6RvNo0cWgxbx/70DhJoSTPpYgaxQ
	 Td/9hqqqNYHunqkGAjpNLomq8vxDbis7SZIiw3kKQ68yY/6WKtSE5pJQDLFHHSsYpe
	 PpcWjBLAho7N8vAfF6GxIP3fhnCvqFLB8CnA3uDw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dXyXT2DDyzLkc;
	Fri, 19 Dec 2025 20:39:21 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: 
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v1 5/5] landlock: Fix formatting
Date: Fri, 19 Dec 2025 20:38:51 +0100
Message-ID: <20251219193855.825889-5-mic@digikod.net>
In-Reply-To: <20251219193855.825889-1-mic@digikod.net>
References: <20251219193855.825889-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Format with clang-format -i security/landlock/*.[ch]

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack3000@gmail.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Fixes: b4dbfd8653b3 ("Coccinelle-based conversion to use ->i_state accessors")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index fe794875ad46..e3c3a8a9ac27 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1314,7 +1314,8 @@ static void hook_sb_delete(struct super_block *const sb)
 		 * second call to iput() for the same Landlock object.  Also
 		 * checks I_NEW because such inode cannot be tied to an object.
 		 */
-		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode_state_read(inode) &
+		    (I_FREEING | I_WILL_FREE | I_NEW)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-- 
2.52.0


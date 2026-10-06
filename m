Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585DF38330A
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284348; cv=none; b=CvDwh3NCRSlZ1aVafoCR+ZA34Dzl/jYOj802eAoBdFknZJU+f/MBHhT3UYNvwxDqo2JGxhOkpPWM3/hqxfxug7gkEO4WDytpLKfipHCNhsOZ+IKy1gl4FKXqlr7td6iwZYeNfslXJgaj77kQupJgPkLlqVe9iRj5fhu5aZ2OEYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284348; c=relaxed/simple;
	bh=XiV6xG1npiZZohcYBnTsKS8zFVs5oWY3NSH57w/3i/8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SbNasgwEte17IJKOdvx+4lqfmv0k3OrEXzp9dAGBATvkMeQXGk8V9po1yPnoYFMF/5LK/Sg6Cpkl0XTAfKwFpf6iFUFphP2/ZhgO0y7aq9oMHDcKiJX0HqgWNEhNpP2eGPqA+zyxyjQG4jYu7diTp0yp2m4avYtCF3+We9Xb2F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NEMajOlh; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEMajOlh"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a01b112fa2so41402745e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 06 Oct 2026 03:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791284343; x=1791889143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GCL2kwqvqMf7Pnn8bIL4aRVI45jOsl7pXeTXhFkxfis=;
        b=NEMajOlhRH/koeuv/FwX+pANFoDWokLDUQ9APzWoSYU3lgvNgkvIdTpXUgeX1Jf6Bs
         XlfDTBsQlf+GpayC+Ndn0KU/op4Kt8GTA0WzrcMxXkToIer4FNX2mZv9wFvQKfXyFNII
         /3cTJwKwYFCb6ELozKCuUvCdkycDaDP/iHWUatsixr0A+GpFIrF6f2U8u2CQlUA7rSkB
         +MFOynMNVuck//oumgFv1pM/f4o5MNyQRMcYOCULlZBVka87UmqF3yW6EfMdQqoaB6IW
         LFRZ91M26LncrxGdKU3xV75uBBTprhzp02Y+zU+ZjxwODKGbqY9f1mqdK2q5EMNn28Ye
         zDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791284343; x=1791889143;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GCL2kwqvqMf7Pnn8bIL4aRVI45jOsl7pXeTXhFkxfis=;
        b=OjD4L5f0k58KJhtwka5XFP0slJ+pMzMISeWTzSMu2RSDN700S1yece0q7q8DMJGKdU
         40lmNuCmX91DHInzzl4mKMnBSnpueZ6qijeKzOlWfIFHbk9PKIqLZr97GKbl1jPwWice
         j/B1AJz8NXL8P/VeZiRSWbz23mOFxmt8JWs53wcnvEsN79BWkKbS6P+8ikcjJM3eOM+Q
         bxRFDhNtGe/ZJ+WZ8+vDDeuvF5qi+lyT8umrXjvUOeehbIHN7f/2iCgoQoy1KdlkSR+8
         s8ldK9FN27XGxtiInUDvAhcW5isOQrM1UK5ycVBUXdd705JcJXg9MDgVAn5vYpVsovpL
         JCZg==
X-Gm-Message-State: AFuF++mDOGKkmNztdPfmajXse4V5JMQxdL2WqmSk/vAQDjXZOHmqASka
	6qxyXH/Gt1XO4SCPkJt1TA34WalCnD40l7mIS19BqHnfwYpf2H2el2n8UuOaQa2z0tETQJA+QHN
	FBGN32Q==
X-Received: from wmpr24.prod.google.com ([2002:a05:600c:3218:b0:4a1:6dd0:53a])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:548a:b0:49f:c1a1:5222
 with SMTP id 5b1f17b1804b1-4a17b563ab6mr16426665e9.33.1791284343354; Tue, 06
 Oct 2026 03:59:03 -0700 (PDT)
Date: Tue,  6 Oct 2026 12:58:47 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006105847.2541190-1-gnoack@google.com>
Subject: [PATCH] landlock: Fix superblock use-after-free in release_inode()
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Without this fix, release_inode() (task 1) can race with a umount operation=
 in
hook_sb_delete() (task 2).  The order of operations in which the race occur=
s is:

* task 2: hook_sb_delete() arrives at the end of the function, waiting for
  landlock_superblock(sb)->inode_refs to become zero.
* task 1: release_inode(): does atomic_long_dec_and_test(), decrementing
  inode_refs to zero.
* task 2: gets woken up through some other means, sees that inode_refs is
  zero and returns.  The caller is the unmount operation and proceeds to
  release the superblock.
* task 1: Runs wake_up_var(&landlock_superblock(sb)->inode_refs),
  *dereferencing the sb_security on the freed-up superblock*.

Notably, wake_up_var() does not dereference the pointer passed to it, and
only uses it to determine an overapproximated set of tasks to wake up. So
while it's potentially possible for an attacker to provide a different
value for that pointer, this only results in the wrong set of tasks getting
woken up, and in this scenario, no further tasks are actually waiting.

Nevertheless, KASAN detects it as a slab-use-after-free read on
sb->s_security:

  BUG: KASAN: slab-use-after-free in release_inode+0x196/0x290
  Read of size 8 at addr ffff888103b6c0a8 by task repro/217
   release_inode+0x196/0x290
   landlock_put_object+0x71/0x90
   landlock_free_rules+0x38/0xc0
   landlock_put_ruleset+0x47/0x130
   fop_ruleset_release+0x33/0x40
   __fput+0x305/0x780
  Freed by task 54:
   kfree+0x11c/0x390
   process_scheduled_works+0x766/0xe50
   worker_thread+0x7bc/0xb20

The fix is to determine &landlock_superblock(inode->i_sb)->inode_refs only =
once
earlier in release_inode(), and later use that precalculated address for th=
e
wake_up_var() call, without having to dereference through the superblock.

Cc: stable@vger.kernel.org
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
Assisted-by: LLM
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 security/landlock/fs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index cab43892ec2f..0959e9f487e6 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -61,7 +61,7 @@ static void release_inode(struct landlock_object *const o=
bject)
 	__releases(object->lock)
 {
 	struct inode *const inode =3D object->underobj;
-	struct super_block *sb;
+	atomic_long_t *inode_refs;
=20
 	if (!inode) {
 		spin_unlock(&object->lock);
@@ -77,8 +77,8 @@ static void release_inode(struct landlock_object *const o=
bject)
 	 * Makes sure that if the filesystem is concurrently unmounted,
 	 * hook_sb_delete() will wait for us to finish iput().
 	 */
-	sb =3D inode->i_sb;
-	atomic_long_inc(&landlock_superblock(sb)->inode_refs);
+	inode_refs =3D &landlock_superblock(inode->i_sb)->inode_refs;
+	atomic_long_inc(inode_refs);
 	spin_unlock(&object->lock);
 	/*
 	 * Because object->underobj was not NULL, hook_sb_delete() and
@@ -92,8 +92,8 @@ static void release_inode(struct landlock_object *const o=
bject)
 	 */
=20
 	iput(inode);
-	if (atomic_long_dec_and_test(&landlock_superblock(sb)->inode_refs))
-		wake_up_var(&landlock_superblock(sb)->inode_refs);
+	if (atomic_long_dec_and_test(inode_refs))
+		wake_up_var(inode_refs);
 }
=20
 static const struct landlock_object_underops landlock_fs_underops =3D {
--=20
2.56.0.rc1.315.gc6ed9934b7-goog


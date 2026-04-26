Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423FF315D35
	for <linux-security-module@vger.kernel.org>; Sun, 26 Apr 2026 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777245832; cv=none; b=UlHXE7RTdcAUxFhhsXTt22itUTGCe7fYv77cJL41dJfWDtcSrFfxYApL86xSEaCD8gl01R9H4+IumyVcKbb4C6NcI9Qw8OHHJIriZgYZIW0z+DMq6QHSk+JucBFMLOqW0z4RTvaJ1Nw29YAEJKv6/nq4ke/lE1WswarSrxGd+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777245832; c=relaxed/simple;
	bh=3PfpSsq9PVqlOFmWLAB5WPbcbb7zy7cmiuYW1YK3Yac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sE0ZW+MsVjRl3XjkD4MbahUME6SlhpPqzx0hViEnaRj9lTrkDHF6mxd021017TK+GBkacnFeMveORqmgdSyEtsgqBcW1T5A2RbftUG+dDiLyZTUaF9lssRf/caq+EyKJfVNsll2wMNpRSIey4QvB0/eLZSqQHD4lC82FXdH7xcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R83f3coU; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R83f3coU"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8ef2118b478so583143185a.0
        for <linux-security-module@vger.kernel.org>; Sun, 26 Apr 2026 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777245830; x=1777850630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SMcVPLr/wbi2Q8Kaqf49orEV0Xtu1ZF/I9pLdpkPlEs=;
        b=R83f3coU1bE3WufNsrV+dbv02EBiCFDAJuGnn9wQEDCs7kjA+Yhud5f0dWS9S52VlR
         Ydyoo41RB51h1BOttZd0CaG+Ip62cX26fmzspW3tVo/kJ4ZOE9UqEodJfKxsSwqpwWIy
         Vn7yFD1JIONuHVCCd3dJX/WoJCKOuIKSQrqkOosuRZMVFINgENxHk0cIaxIFndf4EfwF
         GpnobeWEZOydLUDEdN0FLcmq+jsxTSIcPs4s2v8MJjTpuKL689Zaejse0rrO+ZjSb/mp
         ddTjJqBW4tgiTuthSsrqF4NVFnI4fO248ZN8IOu9/VHRXYn5aMfwiUYMrFJ9dbRbEcTJ
         eSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777245830; x=1777850630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMcVPLr/wbi2Q8Kaqf49orEV0Xtu1ZF/I9pLdpkPlEs=;
        b=JEn9db2jj2LqXeE6zr3MZcvP2WG3to6ZRVvbHg+8MbcnOtYJcIVnfAnGZCmo9Ua0tM
         2unDR3ylQjnsga1zM7VbjVb3tmOj7HTpAGsR1dsZjAho+9XMD256BGMKMbJTMTUzNut6
         7+/vmbgdhQYyjox2Pi6SV3Jw3Nadlv1qh/AnpzyZqmjQOfm4khdHTMNurkV1NhQ0MwXP
         GOCcldFARDXCjTBbwGdeUAMpToA+1Ld98RudbfTRXeH7/6vFA/grhbW8R5deowXoNFk1
         iWblvs8MLfke1gTAGts7qI7j8UAQz9AzOYosWW3MzWlRESPHD8mOOTdb13OYOiwdN5x5
         VPRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/OVWKGxka9DGKEKwtM+FHixS/wQ9aXWhf/hFcpLNAjmdxN5lSWgDBMAHSfsN1SbsVnygW7G0P0RNVSuLsYUCAd+hWf44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY14Iq5oSsfA73YsYjKVCS2gMND9StX33WSuTHZMsmQ6MGH0ig
	zwQ9lM9ZkqRHVVmYBwoYgxOKabCKBrmjzrJivdEYKzNpF/WovwpfOaaX
X-Gm-Gg: AeBDiesFLIk/WBfm7yW8ehj41H094Xy8tb6ViJ95K6sjVolDSsFC0fQ6dSgalmQW/gN
	KC5OyTWfsvr+9SmZTFwB1kjmMT++/febyzWRO0LKBHdh4m5Y2+pnn3oXDf9+wikYHi8TAF56Ogr
	CgcYhgNp+hYXljMrlq504rV75cuuJCIL4WijIdRUSTsdY2Tt9/knJZ7pziSfeK/fKu397IbqpWZ
	VD50LFMNi0BPBHvx4h0/9SQdFjE4NjudXdpdUMYcw5BVzMIhuausdVxDeinFLMh3bg8BgJNNlUd
	DmrBNGddtiHLFzMX8BI1m8EyHkrWYIUvBjQ5UxJ0tAxlGWX7L4SwzxS5JVFkDPwN+t8YeiDQUYI
	Q00krLxEwBkHeCW1NIbopTci5reAWgTooCQUhtxdbNozoeEbsBvAWJUE6/Z/ga8eMXyyGhvbbAz
	uJU8HrV6fJJUP2QxiHGrklM0TlXejBkXNeNTjx5ZTqwC+2u2Ebwc4ua2VFSOMFhVd3hTR2oQJdB
	px/CbKx+vqFcOh0MM0NAaXYXilSncY9HX/RmnL+ehTePfwj1X8u
X-Received: by 2002:a05:620a:46a9:b0:8db:de3:92a1 with SMTP id af79cd13be357-8e79208594dmr5861913385a.48.1777245830182;
        Sun, 26 Apr 2026 16:23:50 -0700 (PDT)
Received: from battery.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d93c2fffsm2383899085a.36.2026.04.26.16.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 16:23:49 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: don't reserve xattr slot when we won't fill it
Date: Sun, 26 Apr 2026 19:23:49 -0400
Message-ID: <20260426232349.844289-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move lsm_get_xattr_slot() below the SBLABEL_MNT check so we don't leave
a NULL-named slot in the array when returning -EOPNOTSUPP; filesystem
initxattrs() callbacks stop iterating at the first NULL ->name, silently
dropping xattrs installed by later LSMs.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 97801966bf32..4ff118a9395f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2966,7 +2966,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 {
 	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
-	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	struct xattr *xattr;
 	u32 newsid, clen;
 	u16 newsclass;
 	int rc;
@@ -2992,6 +2992,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	    !(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
+	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
 						   &context, &clen);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.53.0


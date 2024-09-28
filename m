Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494D19066B
	for <linux-security-module@vger.kernel.org>; Sat, 28 Sep 2024 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727490960; cv=none; b=b1xUHeCVr6h9cnEZJ3aRbT5egX68qDZ6GV7dUFvOUPPqkZq0Tu2geII2W9n8qc6cA+0j1Sx5nQ4qDJJm4mRiqQ8HzDhy2moW2NbFmpDLP50tPRJUdWl72IwONwymnW3z/wnqlV+PU8ovmEyB0yLrNDN09HgSJxzrH5QaeRUfFGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727490960; c=relaxed/simple;
	bh=4Fc1hGyR0IRQlVv9FqxTFemD9hR1cFALNCE3KE8kINU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XWD6s/n5Z4QlWyLvIl4LIy7o/55enCWNYXu7XlfSsWmA5aQoZl45ooZpnF+/gH5VggFCrUg0QvVEFhPYIv9xz5RlXqnQp+0Rui65XNsHHaSW03PxV+Tz56i5MJRFbw07InsZKdWeyej2Z3SssH6JM3WTeilmMT7mzIT6HMPynxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YyrWJUyG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YyrWJUyG"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b1335e4e4so25543715ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 27 Sep 2024 19:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727490958; x=1728095758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7QUo2UfHBHwtULhyXyrPoM+oTcN1a6xkeuEWkxttYA=;
        b=YyrWJUyG1RQZ6dJK+YZKEyWxTm2N7LvyNgBPKXqm7XDtgZn5oiQjjYdsZN2eU2ErsG
         6mE9l7FzX2t+OqABKd22lwgO4gRH6Yqtwi3y4OSVMO+k+N8v0VtyWTlHldmdtMZPF7Xm
         R5OkydOIjNzjWURUGeiX6Zhzc0zFnmv36ae1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727490958; x=1728095758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7QUo2UfHBHwtULhyXyrPoM+oTcN1a6xkeuEWkxttYA=;
        b=LdRCr8QwXRIqEtBYv2YUwuyw88C56Zv8Xtj5hTAps0kXZSSc2+Zdr2SjcVZBVaZGRz
         qOHqb6cjIX9NyyyyHiGhg98x+LnD3q5Z0ckQaxLL+Dxlx/O3gOI8UXvCxm5tYZsYcCpU
         26fXCIeY80hQEEoxWggZs3C2qJTtHj2stDy+r/8noSpeEUlbuuhjIrb7I40PRIxUvaOt
         2v/fir772u4kvTmyNf7YST/UpVleFnjF705F+n2Qd3QTW7cjEhu7sfXV9dAh6heRPBbv
         FnhqZZ9x1GgmI/y+9aAwzMmnW56WHcVNsR5ju9PjkXfD0f2A8kHI7tbq0V/zbpMYnf9f
         iAmg==
X-Forwarded-Encrypted: i=1; AJvYcCWWrLeQoQsl5x93FUa2oT8Wj1cgb671OTxZD+0+0+bTh9OYCVorIC/UvkODLGnyH1p2l+hnx+nK66mjXIT+YFWhr5/MyGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gTKZ1LyO/xQyiEP2PeAs3VER4SVwIgEQSETVwracrAsx1uSQ
	LxX2RSZom9+fSg+TiKYL3BtX1LCWtkPO8QgZJ6F1dsJ4w5cRXQSiUZh49NhBmw==
X-Google-Smtp-Source: AGHT+IEkKY1YGoCfGu4Ncyj/3NdBz6hGCG665Sn2uoO+GBceaQxUzDzjVTAs0hxPtoAI7Q2Zg1kpYA==
X-Received: by 2002:a17:902:e80a:b0:20b:59be:77b with SMTP id d9443c01a7336-20b59be09c4mr12977595ad.6.1727490957732;
        Fri, 27 Sep 2024 19:35:57 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d64asm19386165ad.178.2024.09.27.19.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 19:35:56 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	jmorris@namei.org,
	serge@hallyn.com,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Scott Mayhew <smayhew@redhat.com>,
	stable@kernel.org,
	Marek Gresko <marek.gresko@protonmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.15-v6.1] selinux,smack: don't bypass permissions check in  inode_setsecctx hook
Date: Fri, 27 Sep 2024 19:35:39 -0700
Message-Id: <20240928023539.154580-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Scott Mayhew <smayhew@redhat.com>

commit 76a0e79bc84f466999fa501fce5bf7a07641b8a7 upstream.

Marek Gresko reports that the root user on an NFS client is able to
change the security labels on files on an NFS filesystem that is
exported with root squashing enabled.

The end of the kerneldoc comment for __vfs_setxattr_noperm() states:

 *  This function requires the caller to lock the inode's i_mutex before it
 *  is executed. It also assumes that the caller will make the appropriate
 *  permission checks.

nfsd_setattr() does do permissions checking via fh_verify() and
nfsd_permission(), but those don't do all the same permissions checks
that are done by security_inode_setxattr() and its related LSM hooks do.

Since nfsd_setattr() is the only consumer of security_inode_setsecctx(),
simplest solution appears to be to replace the call to
__vfs_setxattr_noperm() with a call to __vfs_setxattr_locked().  This
fixes the above issue and has the added benefit of causing nfsd to
recall conflicting delegations on a file when a client tries to change
its security label.

Cc: stable@kernel.org
Reported-by: Marek Gresko <marek.gresko@protonmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218809
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Shivani: Modified to apply on v5.15.y-v6.1.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 security/selinux/hooks.c   | 4 ++--
 security/smack/smack_lsm.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 78f3da39b031..626d397c2f86 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6631,8 +6631,8 @@ static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen
  */
 static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_SELINUX,
-				     ctx, ctxlen, 0);
+	return __vfs_setxattr_locked(&init_user_ns, dentry, XATTR_NAME_SELINUX,
+				       ctx, ctxlen, 0, NULL);
 }
 
 static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c18366dbbfed..25995df15e82 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4714,8 +4714,8 @@ static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 
 static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_SMACK,
-				     ctx, ctxlen, 0);
+	return __vfs_setxattr_locked(&init_user_ns, dentry, XATTR_NAME_SMACK,
+				     ctx, ctxlen, 0, NULL);
 }
 
 static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
-- 
2.39.4


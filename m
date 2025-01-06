Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF5C1D90DD
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jan 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736207438; cv=none; b=EzOsI3JMoT8LhpYelFbo88V5WJ+nBy/DNDHuhhVAKEPdgc9yznfSFapHjvpMcsWdXjYDkGzkkTr+jndmWlUPhcCtNpNms7gLwDUh5chPo6gC2YpvNAo3mLF+SS1dJN4aWuEL9cnQlT69e8DlY/EQavp2FHSdRWxFeSBWi2F2GuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736207438; c=relaxed/simple;
	bh=iB6w2VVpKZ76xhbZkpMOignKIJANEGt87ztW5n2KRfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEnbJU76g+ICJ7c+fy5Xi8usi+VNoZoqADbpHSFDcwey5qrrvkpwsIvOAQ0TZ85gcZZEyqaT/lRzjcrvFTCAzXqznoO9CYwPxce43ExNrPUzuioMfA18lM0PvFAjEH3DEBCpT9fp1m7zByz74Sl6dhXUhh28ucW5QtMTo14Ez5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cxdv3l5y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cxdv3l5y"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2164b1f05caso211996285ad.3
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jan 2025 15:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736207436; x=1736812236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uiv3nlXhpFNKlT/zHDb3Vc4prA2G2s6FDKt7Irs340g=;
        b=Cxdv3l5y13YrjbUmH5LeYIFPN6Ww/s8OpvXIaFkjXlL7bO8nIl2eI12HEK7EGh0nJc
         ygBDBTDhiYzwuTB60fCf2fCbBL6+TeMW42Ut5dnz5Rhb4ZFG+0ydo6Ds6d1q78zfre2/
         wHbF92PNv0IvArUKNPt/SqVmdoIcerU/N/Gjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736207436; x=1736812236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiv3nlXhpFNKlT/zHDb3Vc4prA2G2s6FDKt7Irs340g=;
        b=eMZYXQQ4B+T+rxTK1I/N8Na8YLmwO/GNrFF+W0HaPbNt5FZYCUFIU3IZm5MFyVo8XZ
         BeTQzLzMP8aHdd2Jxs+M/1UlC139kzrQQi6OvW1pQt3X72yEVas7VQGuwU8vJWOn1Af2
         W8iAHtVqewP9hSDEfklODozNy0lN/a7GemO8MC+1nqwbeiH1Eizfk/4jGQaTIIM7WC0r
         7jOxcMO2ilexqyBL1EEMA99mmNJqG3Ba0RYaiU0Om/Usel6DTkQy8pGGJlNO0DNeODBn
         u79lzv7YoRga6jYNgq379AenZ+lNwOOKPsa18KV3xXVuAnPWyia4dVjhIXHvNCKrxf1Q
         NIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKfq4jedA2OLMfxAXYFfi0ImiwUZNeAnXZVAAG8J8fb54bl88jxyM0vPB+69yVAWqQTrd399G6seIR+/TEdGzTV7JZa7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsyPfRGEJM+gh+pLAnn+oKMIbz8C4LYPNcveFip8mV9eOsAiUh
	NzaKdhLktF1JZug1EmyvNWJOaGHWu0dmUi+Pd2a55ydGFDNcFnneQpB2E4IQug==
X-Gm-Gg: ASbGncv2NpgtDHNsSyBYYyWSL3wgBQdT4eHx6/g0fP1BfbC1Xwj4/+xcMpZehqsYEJK
	+v94Womm1hSEY22oxAaj7zLdVbbUZ6ekaYMnNzz1eTIU/DBw1wZ6uPvQppvtZx92dEveDypN+nY
	bSHZX0uA9uCjochph6XWpgGNk1oOkq8hr5PgZT9qYm6qmhM5M91MY1/2vWCByj+I0r5KtQchVFk
	aUDTVq/DM0G74KcXeXq4ia0VXDU7uk4C53raW0OyJvOK80GesoW78e9HP+ndCsMO4kSL543qcPl
	i3WFFfJdDA==
X-Google-Smtp-Source: AGHT+IH9SJmZBbMjz/aBJwhiN0mT7AF9qZCyUpGpRneRR3Mw4jIzVYhbxoOVjq6QcJJzfOA3nRI6Bw==
X-Received: by 2002:a17:902:ec86:b0:215:603e:214a with SMTP id d9443c01a7336-219e6e8c51emr768701785ad.1.1736207436209;
        Mon, 06 Jan 2025 15:50:36 -0800 (PST)
Received: from enlightened2.mtv.corp.google.com ([2620:15c:9d:4:d597:3a81:f139:970c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962c1bsm298594375ad.3.2025.01.06.15.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 15:50:35 -0800 (PST)
From: Shervin Oloumi <enlightened@chromium.org>
To: mic@digikod.net,
	viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	gnoack@google.com,
	shuah@kernel.org,
	jorgelo@chromium.org,
	allenwebb@chromium.org,
	Shervin Oloumi <enlightened@chromium.org>
Subject: [PATCH v2 1/2] fs: add loopback/bind mount specific security hook
Date: Mon,  6 Jan 2025 15:50:21 -0800
Message-ID: <20250106235022.3859523-1-enlightened@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main mount security hook (security_sb_mount) is called early in the
process before the mount type is determined and the arguments are
validated and converted to the appropriate format. Specifically, the
source path is surfaced as a string, which is not appropriate for
checking bind mount requests. For bind mounts the source should be
validated and passed as a path struct (same as destination), after the
mount type is determined. This allows the hook users to evaluate the
mount attributes without the need to perform any validations or
conversions out of band, which can introduce a TOCTOU race condition.

The newly introduced hook is invoked only if the security_sb_mount hook
passes, and only if the MS_BIND flag is detected. At this point the
source of the mount has been successfully converted to a path struct
using the kernel's kern_path API. This allows LSMs to target bind mount
requests at the right stage, and evaluate the attributes in the right
format, based on the type of mount.

This does not affect the functionality of the existing mount security
hooks, including security_sb_mount. The new hook, can be utilized as a
supplement to the main hook for further analyzing bind mount requests.
This means that there is still the option of only using the main hook
function, if all one wants to do is indiscriminately reject all bind
mount requests, regardless of the source and destination arguments.
However, if one needs to evaluate the source and destination of a bind
mount request before making a decision, this hook function should be
preferred. Of course, if a bind mount request does not make it past the
security_sb_mount check, the bind mount hook function is never invoked.

Signed-off-by: Shervin Oloumi <enlightened@chromium.org>
---

Changes since v1:
- Indicate whether the mount is recursive in the hook. This can be a
  factor when deciding if a mount should be allowed
- Add default capabilities function for the new hook in security.h. This
  is required for some tests to pass
- Reword the hook description to be more future proof
---
 fs/namespace.c                |  4 ++++
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  7 +++++++
 security/security.c           | 18 ++++++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 23e81c2a1e3f..535a1841c200 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2765,6 +2765,10 @@ static int do_loopback(struct path *path, const char *old_name,
 	if (err)
 		return err;
 
+	err = security_sb_bindmount(&old_path, path, recurse ? true : false);
+	if (err)
+		goto out;
+
 	err = -EINVAL;
 	if (mnt_ns_loop(old_path.dentry))
 		goto out;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index eb2937599cb0..94f5a3530b98 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -71,6 +71,8 @@ LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
 LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
 LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path,
 	 const char *type, unsigned long flags, void *data)
+LSM_HOOK(int, 0, sb_bindmount, const struct path *old_path,
+	 const struct path *path, bool recurse)
 LSM_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
 LSM_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
 	 const struct path *new_path)
diff --git a/include/linux/security.h b/include/linux/security.h
index cbdba435b798..d4a4c71865e3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -365,6 +365,7 @@ int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
 int security_sb_mount(const char *dev_name, const struct path *path,
 		      const char *type, unsigned long flags, void *data);
+int security_sb_bindmount(const struct path *old_path, const struct path *path, bool recurse);
 int security_sb_umount(struct vfsmount *mnt, int flags);
 int security_sb_pivotroot(const struct path *old_path, const struct path *new_path);
 int security_sb_set_mnt_opts(struct super_block *sb,
@@ -801,6 +802,12 @@ static inline int security_sb_mount(const char *dev_name, const struct path *pat
 	return 0;
 }
 
+static inline int security_sb_bindmount(const struct path *old_path,
+					const struct path *path, bool recurse)
+{
+	return 0;
+}
+
 static inline int security_sb_umount(struct vfsmount *mnt, int flags)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 09664e09fec9..c115d8627e2d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1564,6 +1564,24 @@ int security_sb_mount(const char *dev_name, const struct path *path,
 	return call_int_hook(sb_mount, dev_name, path, type, flags, data);
 }
 
+/**
+ * security_sb_bindmount() - Loopback/bind mount permission check
+ * @old_path: source of loopback/bind mount
+ * @path: mount point
+ * @recurse: true if recursive (MS_REC)
+ *
+ * Beyond any general mounting hooks, this check is performed on an initial
+ * loopback/bind mount (MS_BIND) with the mount source presented as a path
+ * struct in @old_path.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_sb_bindmount(const struct path *old_path, const struct path *path,
+			  bool recurse)
+{
+	return call_int_hook(sb_bindmount, old_path, path, recurse);
+}
+
 /**
  * security_sb_umount() - Check permission for unmounting a filesystem
  * @mnt: mounted filesystem

base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
-- 
2.47.1.613.gc27f4b7a9f-goog


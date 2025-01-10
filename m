Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8079205E10
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736475023; cv=none; b=DfgcLXrpxm8Ozk97pKvGq4VPdlaFJHENwbW6DGpT0qW93U0b/uaOILNxatvaONcmQS2Jas9yDsWVWCVckx5A1nbr4/NBk4Dn+PQksZ4l0SYdOOdJQVcjlubtn1W5SJ4OTuWahp5JrW6809QDiC8BQEk2GGSKbw0FUe2qdxhBSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736475023; c=relaxed/simple;
	bh=6Xr936BGfzj7ANxh42FuOw8BpzV56qcd1RxjRfzWy+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFu3tZ/4i8W1VDjuiLxye70ccYBDq6Oxal5ZXcpQmbTqk92SFJHXPAJyNzOYZjjjALe/zFrSvG5e4nkuSK+kOMh60l8BAkCRl6o4oZuxC1++23/LrBGNSBWEVPndG8qjc/ySJhn5ZiSLLTtNMnkHY3jVl+oLhOMgNIQ2ZvAxEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SPRZpr6J; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SPRZpr6J"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2161eb94cceso18911465ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 Jan 2025 18:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736475020; x=1737079820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMBIkLx5sS/Ywb+OT5vpiwEWkTKleUzUObUmLFQbgKM=;
        b=SPRZpr6JUYexXGyREemhz6qDP62pqVaigPytVrsIPbfV7BW6bZuZHU52a2w8M7eiE9
         TZogvSgoul3COK63l2lVmHntQdBFo5jx0GOFsgT9Rffun2CfVXeC/x70fcf2bZK5FjyV
         dvn4d2fcseBQg4GecmfIXX0azdN0ATKQ4lfiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736475020; x=1737079820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMBIkLx5sS/Ywb+OT5vpiwEWkTKleUzUObUmLFQbgKM=;
        b=chJIxv7yKlMyZq1V3DdlVEXNhx8nfnpT0I8WulgcKmLRSrTxx0rt2KI+aRIg6xixT6
         1FlanJMeoYRHHcHQfo+qJeMfwAFBW4KqjB1XreFQv4eh7MZEg0qxwrKjpxZP5AtAmPoy
         cHoZF1d4KqO/Pw541+OiVL/AEiA+s56wvoYH6qEnB2EdSKlfzT6bIygXYDAoBCKk7BYk
         hN2YiM9HUSkdj5EB4sJwBbaEPbjWmKRhirE0wq4IGFYfovPeVCd3ctL66FJwbClNXGR9
         N4hd4OHH59NvFrzG8n5FijW2/kg67aWtdEffFek8nKkG6aF5M3/EnYfNb1IGKuAqIykh
         zr5w==
X-Forwarded-Encrypted: i=1; AJvYcCWd8IlZOZ+MCo8iG7ibGd+gKS8UYG1HyeemMYUW/eMNbzckzL8GoHJ7tPA1aKma0XDlUoYerLZLRnxl2cZXBVpbWxP5rB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFsqPNzHKB9cjtA8GTmsyekxK02lfb2U2jEV3A1mVUn2tyXxzr
	SjcShGAV1zy942UD7knyztFJQOBw1XMKjn/pa1jawIgHPTtZwHVWV3Z4Se8Y4Q==
X-Gm-Gg: ASbGncs8NRN51EETb0wuQ+HoTDEwHVlUs7qx1tHlJQLGVFPS9n9QwY39FJAcX8fXXpe
	QnmOuJHuwgLIwTbuSEFJvS6t17qqExX6TGitId/cBr7KjLp8V59+3M49cmIKQEUIg/5Jl0gMSeQ
	H2pPI17eqkBl0gGPxpXrZkYj4Qg90cn0cLZx5ResMAKzulo7yzT2SmIj+0F4RakfdT+jjoBv/a6
	fR6q+cVfyfSuNSfq87//qJ4K3nPqatqrJstEztjKIeQ9W3V+HxW42vT5v/tW3WElcPTXmjim76O
	QHzJBTHFNg==
X-Google-Smtp-Source: AGHT+IFRCKLUMoXl5JEDpq7UON4WvuYD4HEh+mS4+XxYPFYQ3wLhzghiNfoK5YkyF+2nF/gkS/9Zlw==
X-Received: by 2002:a05:6a20:12cc:b0:1e1:e2d8:fd1d with SMTP id adf61e73a8af0-1e88d0a2b46mr13827667637.33.1736475020220;
        Thu, 09 Jan 2025 18:10:20 -0800 (PST)
Received: from enlightened2.mtv.corp.google.com ([2620:15c:9d:4:17ed:36c7:e5c0:d447])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a318e056063sm1671649a12.31.2025.01.09.18.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 18:10:19 -0800 (PST)
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
Subject: [PATCH v3 1/2] fs: add loopback/bind mount specific security hook
Date: Thu,  9 Jan 2025 18:10:07 -0800
Message-ID: <20250110021008.2704246-1-enlightened@chromium.org>
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
passes, and only if the MS_BIND flag is detected. The
do_reconfigure_mnt() case (MS_REMOUNT | MS_BIND) is still handled by the
existing security_sb_mount() hook. When the new bind mount hook is
called, the source of the mount has already been successfully converted
to a path struct using the kernel's kern_path API. This allows LSMs to
target bind mount requests at the right stage, and evaluate the
attributes in the right format, based on the type of mount. This bind
mount hook also signals the existence of MS_REC flag via a boolean.

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

Changes since v2:
- Reword the commit to include how do_reconfigure_mnt() is handled and
  mention that MS_REC is also surfaced in the hook

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


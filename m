Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A911847C
	for <linux-security-module@vger.kernel.org>; Tue, 31 Dec 2024 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735609618; cv=none; b=QxeK9DFTW7xGC3flC9CPMitbKcLPEiOJwTm1VZbKRyuhZ31IvYA5fi7+QjU6vXt/Vi9S9wtAPjuY8Z3+P+IIWWkJ6rQvup/7EDfuE91R0ep15zSBKjbmHd2Ox7GVJX/x7enEIe6QMS3/rn3GPs3mcv6XAILZPCiZd54v81VwEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735609618; c=relaxed/simple;
	bh=Bk/U0wy0mXlff0HMCha3vAVWd5OLsQKzHalXGHgwriY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzHfRYiInuK5K15QZrZdR3IutWDqPQJ6Dp7hnhNZWdbzp04I8urHY5OTDhmP3cJxCK9gwkFkCrhfbERV1Ko4b74gIwarmvySabDx2vHDQV0iiLNkdhzuMeRPlMONDMM8R8ecfRsEwl8aLmn5PVfceOVyLZfh2KhIVlYE3iyh5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xp7hJeoU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xp7hJeoU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216401de828so120722505ad.3
        for <linux-security-module@vger.kernel.org>; Mon, 30 Dec 2024 17:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1735609616; x=1736214416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGa9UHOmj9Luni8WoEPYcWzdFDosXs3JozZ+mt5/zwg=;
        b=Xp7hJeoU/Kan3K4Z5PhwiV1j4ReFD6mDz6fu64AmU2CuoGZFTvTsfZmxAZBRojSV8Y
         wE3EBrvI1KjLSy81+chazpTUt5Jiznu/nrWjZSStLtJjIOu2CZ+6EwkpXYNbnqxDWRuF
         5F7xbkrdlra3p4MrQc9aON3esLdy6AYORDMDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735609616; x=1736214416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGa9UHOmj9Luni8WoEPYcWzdFDosXs3JozZ+mt5/zwg=;
        b=AJgF96N+sZmkyEWbIL9u2XEt4UYdRRxvkk/qttcDcqdiCYyS61F2GnGXQEY7lsycQ8
         sDIwtlqIMjtudlUqMBRrC0ymHPl7Wzjf4h8YhldzVUriwBB/4Fsp9uxu6D4atd4ctk35
         WFrOVW/puCZddyypva5os9SgHw5W4zFmM29U11XuOol3QaiyxtK7ajflL8yDHhjbVFSY
         024rp4hmw5bg54uXUcLsVjgNu4Y6QHs+XIy62pExBbBqZFHw38JDbfRo4vV6TZTpHvTj
         fDKbRZ37SGQz4c9tnCl/qF6DUMpkbtQZkI1i+udL/HUAXECESAzonIpoLSne954+vBdG
         swWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLB+H3RISqb8Q5hTdnvSu/p7tagqC29Po3ieM/0sm7nfWqSo9043keH2duf+ntHu0t4eXp8C/bcYX+HntbtEDOH6t7Vd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4bWUomK9YPCJ92QZenp3oIf5/uDtMreS+f03dF/uEX6iMx1f
	9w49EW8HokJqEemV31LibgF6+pziw/qjZtIRheY92ZxXt/QEtKSkWR54BULtukjy5pq/uAZLkws
	q/txz
X-Gm-Gg: ASbGncs/C2cQ5cI3TUQ/APirL4LMQXcWAstJBB9SkiTq/I2vE+10ExaYnw/meGkcFom
	y1wZRgTPk478errsjq6GT0GaT7QiOpe1J+VNIg9g99opdF5Vs4Df+0VX7eupu8d2MI3Sa44Nu51
	/2P09XXcEg0VD0jb50VOp2TcCYHrf1i3zzoUAcQaMz5hwuV9cq9QRZY+axSTTdM4mo6KL5xf+V0
	FvN2NgXZs4jQihE4oPy9/RxOq3UBdSr0C0B8nGqoJlmy+k3AgNdKwR6uzCVjpHDa0AlUAiOYPCe
	6n6UZyl8
X-Google-Smtp-Source: AGHT+IETg4lDpEmoCvNw0iqcF4rE63t03WKlEFVF90XaO5NEWpXDjFEU3AhWYJ82pnliSViWKIfdcg==
X-Received: by 2002:a17:903:182:b0:216:4943:e575 with SMTP id d9443c01a7336-219e6f28547mr382836225ad.57.1735609616425;
        Mon, 30 Dec 2024 17:46:56 -0800 (PST)
Received: from enlightened2.mtv.corp.google.com ([2620:15c:9d:4:115a:46b1:149:edd0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842e4057b77sm15098139a12.83.2024.12.30.17.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 17:46:56 -0800 (PST)
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
Subject: [PATCH 1/2] fs: add loopback/bind mount specific security hook
Date: Mon, 30 Dec 2024 17:46:31 -0800
Message-ID: <20241231014632.589049-1-enlightened@chromium.org>
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
 fs/namespace.c                |  4 ++++
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  1 +
 security/security.c           | 16 ++++++++++++++++
 4 files changed, 22 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 23e81c2a1e3f..c902608c9759 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2765,6 +2765,10 @@ static int do_loopback(struct path *path, const char *old_name,
 	if (err)
 		return err;
 
+	err = security_sb_bindmount(&old_path, path);
+	if (err)
+		goto out;
+
 	err = -EINVAL;
 	if (mnt_ns_loop(old_path.dentry))
 		goto out;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index eb2937599cb0..3d1940239556 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -71,6 +71,7 @@ LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
 LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
 LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path,
 	 const char *type, unsigned long flags, void *data)
+LSM_HOOK(int, 0, sb_bindmount, const struct path *old_path, const struct path *path)
 LSM_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
 LSM_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
 	 const struct path *new_path)
diff --git a/include/linux/security.h b/include/linux/security.h
index cbdba435b798..512ac656500e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -365,6 +365,7 @@ int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
 int security_sb_mount(const char *dev_name, const struct path *path,
 		      const char *type, unsigned long flags, void *data);
+int security_sb_bindmount(const struct path *old_path, const struct path *path);
 int security_sb_umount(struct vfsmount *mnt, int flags);
 int security_sb_pivotroot(const struct path *old_path, const struct path *new_path);
 int security_sb_set_mnt_opts(struct super_block *sb,
diff --git a/security/security.c b/security/security.c
index 09664e09fec9..bd7cb3df16f4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1564,6 +1564,22 @@ int security_sb_mount(const char *dev_name, const struct path *path,
 	return call_int_hook(sb_mount, dev_name, path, type, flags, data);
 }
 
+/**
+ * security_sb_bindmount() - Loopback/bind mount specific permission check
+ * @old_path: source of loopback/bind mount
+ * @path: mount point
+ *
+ * This check is performed in addition to security_sb_mount and only if the
+ * mount type is determined to be loopback/bind mount (flags & MS_BIND).  It
+ * surfaces the mount source as a path struct.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_sb_bindmount(const struct path *old_path, const struct path *path)
+{
+	return call_int_hook(sb_bindmount, old_path, path);
+}
+
 /**
  * security_sb_umount() - Check permission for unmounting a filesystem
  * @mnt: mounted filesystem

base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
-- 
2.47.1.613.gc27f4b7a9f-goog


Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81BA4E1B3
	for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120228; cv=none; b=cM4PJeZuLgV3xyw/MRZoeV51meHo86Q24MfnrORsLzPlEi0DrkxEF8a+UgLwAdR9vxow/hfbusdg2SO46KnPexzg0LGN7MjH5vLIm6+3tSnaddvClw3zOWt1KMxAnkPh45pxaDLgc+9uytDRh5lxHrSMKpneGn+U8oxRw7XQZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120228; c=relaxed/simple;
	bh=SUlqwgDoB+j6mp3daqLN3lDcVKqBzs5Zdx5JbddS8p8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rkr9h6Y5xCDJjzxl/aIeB7litNfdwcz79LhaleS/HmUMp8P8oIXL5LDio4zmgxTK9PR76TUTQXl10yWZ+v1K7OMtljrLF40mbX2rDtiuMd8mQ4rakbgOrNmJrluF253eX2l3MQZJ2TTcfSss3NXrLTjQuuf+UuGCAZija3STUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quz2UjAZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quz2UjAZ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ff1816749so37959247b3.3
        for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 08:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711120226; x=1711725026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sz0NfA7QwlgjZXRVL07X3cjKoeJcVAaE+B0NiSWNqrk=;
        b=quz2UjAZA/PNAlWw/gkt4KKRCuRFaoT9et67P4b8syFevZDR4RZ8z6yxU0IEYg5/wd
         oTjDRaeOtDxe3x7/VGR3xhesnm7lhynRmop8ePHc9uIms106kg5NEMNEAmXVx+Z6bLO1
         b5IzWxSICYdkIh3s32hgc2lAS8wnoPHBl2hQluyvxCGiDwkVRVWEJup9VnEXbAiUcPF0
         3rQYQ6nsv0OFr3ExaSHzFcVzZkTdeRjmc55GOvo/Y8vgMAl5kxJixaBaGlfvJUaWaPuE
         h/CPUuPFRu2JW+lhl1w9bHZO91e0poZ8hFF2eN7lwzsnZ3nmS2CFD5uJFiQJrSx98G3Y
         eXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120226; x=1711725026;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sz0NfA7QwlgjZXRVL07X3cjKoeJcVAaE+B0NiSWNqrk=;
        b=LTRX2ynkJY3hK2eAD3H1q4QTWYNaem9c0vxYZ4k04LOi+eRHQMQczruSKJltiTBNKU
         U5ZEKnHvGESdcMyHw7WWo/nFkO3HBAZibCC+Vp+nJnGnqT5c5163C9bthoLfAhGwLqTR
         aQHzR3BLTEq7CHnSi1ec0hKULP72T47hMHzkZL3cs6mrXWiUH2MANrPJDhT0Q6YLHGHQ
         SaFEiO6RmOCuvdDXTO/dOUq1x71zaPGArqY5JcKtyv2Mz+7Kh+T+Iot1nvriHQy+86Qs
         Hz/eVMPtMQxdqZ0mkdRgQjB5LwnyMt+rzu0xpnepL+W8KdpEgfPv/LCrsr4gHqzCD4v8
         henw==
X-Gm-Message-State: AOJu0YyKEDZX3VMohrVqEB5qeWMh8CYrMt9/euvu4Z6N2VNG6Jr4GRzJ
	+iomtzlW2hDbFnZhIL0x2Zcx+mAr+Hfufy9otNiwnpHpGCaIZiAs68S70Vj0bmqHN7on5LMTqSB
	yOX/90DLIMrGIKXe0wbEFg/NFYSXnjNWW2EE/UXcdenb47mBhr+9kIGIkOVsn2riSuyN/90Spwu
	0hKwdZmH48q7xM5h+mrsO5FU5eYhZRXjUS68tqPwIMrG84tnpINPD8
X-Google-Smtp-Source: AGHT+IEVl0nVf2PkeBJWX1+vgaRwh9j+KpSXxFnpu62kxn7SmBtWi+DHOmt41T2f5FKy8GzvDuEOQ7REKGw=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:230a:b0:dcc:6bf0:2eb6 with SMTP id
 do10-20020a056902230a00b00dcc6bf02eb6mr54487ybb.6.1711120225591; Fri, 22 Mar
 2024 08:10:25 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:09:55 +0000
In-Reply-To: <20240322151002.3653639-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322151002.3653639-3-gnoack@google.com>
Subject: [PATCH v11 2/9] landlock: Add IOCTL access right for character and
 block devices
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Introduces the LANDLOCK_ACCESS_FS_IOCTL_DEV right
and increments the Landlock ABI version to 5.

This access right applies to device-custom IOCTL commands
when they are invoked on block or character device files.

Like the truncate right, this right is associated with a file
descriptor at the time of open(2), and gets respected even when the
file descriptor is used outside of the thread which it was originally
opened in.

Therefore, a newly enabled Landlock policy does not apply to file
descriptors which are already open.

If the LANDLOCK_ACCESS_FS_IOCTL_DEV right is handled, only a small
number of safe IOCTL commands will be permitted on newly opened device
files.  These include FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC, as well
as other IOCTL commands for regular files which are implemented in
fs/ioctl.c.

Noteworthy scenarios which require special attention:

TTY devices are often passed into a process from the parent process,
and so a newly enabled Landlock policy does not retroactively apply to
them automatically.  In the past, TTY devices have often supported
IOCTL commands like TIOCSTI and some TIOCLINUX subcommands, which were
letting callers control the TTY input buffer (and simulate
keypresses).  This should be restricted to CAP_SYS_ADMIN programs on
modern kernels though.

Known limitations:

The LANDLOCK_ACCESS_FS_IOCTL_DEV access right is a coarse-grained
control over IOCTL commands.

Landlock users may use path-based restrictions in combination with
their knowledge about the file system layout to control what IOCTLs
can be done.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 include/uapi/linux/landlock.h                | 35 ++++++++++---
 security/landlock/fs.c                       | 52 ++++++++++++++++++--
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  8 ++-
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   |  5 +-
 6 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 25c8d7677539..193733d833b1 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -128,7 +128,7 @@ struct landlock_net_port_attr {
  * files and directories.  Files or directories opened before the sandboxi=
ng
  * are not subject to these restrictions.
  *
- * A file can only receive these access rights:
+ * The following access rights apply only to files:
  *
  * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
  * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note t=
hat
@@ -138,12 +138,13 @@ struct landlock_net_port_attr {
  * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
  * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate=
(2)`,
  *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` w=
ith
- *   ``O_TRUNC``. Whether an opened file can be truncated with
- *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, in t=
he
- *   same way as read and write permissions are checked during
- *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
- *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available since =
the
- *   third version of the Landlock ABI.
+ *   ``O_TRUNC``.  This access right is available since the third version =
of the
+ *   Landlock ABI.
+ *
+ * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or=
 used
+ * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same wa=
y as
+ * read and write permissions are checked during :manpage:`open(2)` using
+ * %LANDLOCK_ACCESS_FS_READ_FILE and %LANDLOCK_ACCESS_FS_WRITE_FILE.
  *
  * A directory can receive access rights related to files or directories. =
 The
  * following access right is applied to the directory itself, and the
@@ -198,13 +199,30 @@ struct landlock_net_port_attr {
  *   If multiple requirements are not met, the ``EACCES`` error code takes
  *   precedence over ``EXDEV``.
  *
+ * The following access right applies both to files and directories:
+ *
+ * - %LANDLOCK_ACCESS_FS_IOCTL_DEV: Invoke :manpage:`ioctl(2)` commands on=
 an opened
+ *   character or block device.
+ *
+ *   This access right applies to all `ioctl(2)` commands implemented by d=
evice
+ *   drivers.  However, the following common IOCTL commands continue to be
+ *   invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL_DEV right:
+ *
+ *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO``, ``FIOASYNC``, ``FIOQSIZE``,
+ *   ``FIFREEZE``, ``FITHAW``, ``FS_IOC_FIEMAP``, ``FIGETBSZ``, ``FICLONE`=
`,
+ *   ``FICLONERANGE``, ``FIDEDUPERANGE``, ``FS_IOC_GETFLAGS``,
+ *   ``FS_IOC_SETFLAGS``, ``FS_IOC_FSGETXATTR``, ``FS_IOC_FSSETXATTR``
+ *
+ *   This access right is available since the fifth version of the Landloc=
k
+ *   ABI.
+ *
  * .. warning::
  *
  *   It is currently not possible to restrict some file-related actions
  *   accessible through these syscall families: :manpage:`chdir(2)`,
  *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
  *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
- *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
+ *   :manpage:`fcntl(2)`, :manpage:`access(2)`.
  *   Future Landlock evolutions will enable to restrict them.
  */
 /* clang-format off */
@@ -223,6 +241,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
+#define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
 /* clang-format on */
=20
 /**
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c15559432d3d..30b70d38ddcc 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -148,7 +148,8 @@ static struct landlock_object *get_inode_object(struct =
inode *const inode)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 /* clang-format on */
=20
 /*
@@ -1335,8 +1336,10 @@ static int hook_file_alloc_security(struct file *con=
st file)
 static int hook_file_open(struct file *const file)
 {
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
-	access_mask_t open_access_request, full_access_request, allowed_access;
-	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
+	access_mask_t open_access_request, full_access_request, allowed_access,
+		optional_access;
+	const struct inode *inode =3D file_inode(file);
+	const bool is_device =3D S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode)=
;
 	const struct landlock_ruleset *const dom =3D
 		get_fs_domain(landlock_cred(file->f_cred)->domain);
=20
@@ -1354,6 +1357,10 @@ static int hook_file_open(struct file *const file)
 	 * We look up more access than what we immediately need for open(), so
 	 * that we can later authorize operations on opened files.
 	 */
+	optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
+	if (is_device)
+		optional_access |=3D LANDLOCK_ACCESS_FS_IOCTL_DEV;
+
 	full_access_request =3D open_access_request | optional_access;
=20
 	if (is_access_to_paths_allowed(
@@ -1410,6 +1417,43 @@ static int hook_file_truncate(struct file *const fil=
e)
 	return -EACCES;
 }
=20
+static int hook_file_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	const struct inode *inode =3D file_inode(file);
+	const bool is_device =3D S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode)=
;
+	access_mask_t required_access, allowed_access;
+
+	if (!is_device)
+		return 0;
+
+	/*
+	 * We permit IOCTL commands which have a do_vfs_ioctl handler for the
+	 * given file.
+	 */
+	if (vfs_get_ioctl_handler(file, cmd))
+		return 0;
+
+	/*
+	 * It is the access rights at the time of opening the file which
+	 * determine whether IOCTL can be used on the opened file later.
+	 *
+	 * The access right is attached to the opened file in hook_file_open().
+	 */
+	required_access =3D LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	allowed_access =3D landlock_file(file)->allowed_access;
+	if ((allowed_access & required_access) =3D=3D required_access)
+		return 0;
+
+	return -EACCES;
+}
+
+static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
+				  unsigned long arg)
+{
+	return hook_file_ioctl(file, cmd, arg);
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init =3D {
 	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
=20
@@ -1432,6 +1476,8 @@ static struct security_hook_list landlock_hooks[] __r=
o_after_init =3D {
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
 	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
+	LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, hook_file_ioctl_compat),
 };
=20
 __init void landlock_add_fs_hooks(void)
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 93c9c6f91556..20fdb5ff3514 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -18,7 +18,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
=20
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 #define LANDLOCK_SHIFT_ACCESS_FS	0
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 6788e73b6681..9ae3dfa47443 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -149,7 +149,7 @@ static const struct file_operations ruleset_fops =3D {
 	.write =3D fop_dummy_write,
 };
=20
-#define LANDLOCK_ABI_VERSION 4
+#define LANDLOCK_ABI_VERSION 5
=20
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -321,7 +321,11 @@ static int add_rule_path_beneath(struct landlock_rules=
et *const ruleset,
 	if (!path_beneath_attr.allowed_access)
 		return -ENOMSG;
=20
-	/* Checks that allowed_access matches the @ruleset constraints. */
+	/*
+	 * Checks that allowed_access matches the @ruleset constraints and only
+	 * consists of publicly visible access rights (as opposed to synthetic
+	 * ones).
+	 */
 	mask =3D landlock_get_raw_fs_access_mask(ruleset, 0);
 	if ((path_beneath_attr.allowed_access | mask) !=3D mask)
 		return -EINVAL;
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/s=
elftests/landlock/base_test.c
index 646f778dfb1e..d292b419ccba 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -75,7 +75,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr =3D {
 		.handled_access_fs =3D LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(5, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
=20
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 2d6d9b43d958..0bcbbf594fd7 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -527,9 +527,10 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
=20
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
=20
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
--=20
2.44.0.396.g6e790dbe36-goog


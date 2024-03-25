Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA2584D2A
	for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374015; cv=none; b=gpQjE+nhLY1PEwhiI6NskBqne+vTe/FDsb5S59v+SsEG6qNAOlmwp3KE5auANZL6CWJPHQknMb0sVmnNDdqidhKY1PPyrhfHi3IgOh3nycFiF9BRWH0DSRvV4vSIDXn8oi7WHlCveJ3fwtZ/AS829vtVXjHvSGGLnAwUq8lZTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374015; c=relaxed/simple;
	bh=+mMgkr4ynmxH5yzlOBVlYuf85tluuY6aMez/bXTEnJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aX8oyR86FbrhhQ94JfhEzh/T9BxkIHSJsA0LEu1ySqz9hPPsnT4i2R8MgKUacfObanqhIQYP6YpW0KKocDqhxaBJ+PgyIqDuSnHricqdnkj7AapB4MR0gqR1hup7v4zkIG65if/fWgN1FeHT9CSGPEgx3VbxtQk7As3+1A4+TqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubJn7w1l; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubJn7w1l"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a474c52817fso60194566b.2
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 06:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711374011; x=1711978811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+H6CWx3DHP6EwbnkJIv35aXXjnoO2lZdC3Qbh2kDvGg=;
        b=ubJn7w1l1hqhFFEg5OVdoGaQRIfHoFXGmy3SskLBG3T1h3WBS+YoO2dxb7ZIGykJHe
         iF20h+V0GEz68v3+AOLiQiahpLKm+b3CctRSXVJ25yopGvND28HxzFJauQ+W+x9vcqdY
         5Z58NOrAno2ci4os80/udhJ69c+s8XyaCk0FVCE/rs8Myfb59Q8UbmYTEzmp7WkhdNm8
         6Xt9vu9cHDrWiIzTLWqGvL/I6zIH5pSMNeoMupZ51Z1eG72js7baVA8Af3C3++zmwfLt
         Yk5r98V3cPD8EX8y4PNhlhtWNxJEm6r8l8TuVPssXBXPtQfYpr+PEu7MeXoGEYL75Wwf
         mpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374011; x=1711978811;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+H6CWx3DHP6EwbnkJIv35aXXjnoO2lZdC3Qbh2kDvGg=;
        b=aApEEK8NWUvXhpQhFd9t9wxPyF7oJk2jdyhUBzm9496B09uR/m8/tBi4AeVRUoS+Td
         zGurBdSKUfwLVBYyHtn3CdJglN0munRrFFRDTidik5htdwWF6idm+vCt5ZKQWhOjOcYZ
         3OlguEZm5iy8PFAbrAM9t+osRANjLaxCzj1OmTE2ZHtnoZe/kcLLxXk2hC1FssXc5nCL
         ZrLqkkY3K8bU6JIS9uDsJyMrfIwxU0C7IPIvKZeC42xSZl8RH2FqjL4LBXHwkZnEKPy9
         tzO/tmXBaKG3Xw2HQqjF0PLqNZAHJeMWQo7Iv3DH0v7PHH6n7c0st4TIUivEZFeSDjQA
         cE7A==
X-Gm-Message-State: AOJu0Yzg9UvlEh5dB2NcWTb09qHsM2vpNGbagaLJDfhapZWedis/YVG4
	wrfQS1B4mN/KKI26uKgWClNpm6IWOlh+kNB4WVAkFt8bJLVtDtJWF8DL6Bhdppz3azam70sBI+O
	uwbpixB9Gm8WE8yPvGBQQMVyNtc1qAz1zUfxgvZ0GzFldUdrUap3hQvcbwewagaAMp5sD4iT+8a
	xn92HlLsNfnGH2tj5zZ/HuEhfU2tru+SrWaYE/ecYFxlacuOcONHmR
X-Google-Smtp-Source: AGHT+IETYPmBtNv34zGm3XoLgK7eRIQ9/PLSQjTOdompzQQVEXrdGRWG0i0FuSHZFEgnkbtrnepT9sqkRzc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:907:7284:b0:a4a:35bd:db8f with SMTP id
 dt4-20020a170907728400b00a4a35bddb8fmr19444ejc.4.1711374010916; Mon, 25 Mar
 2024 06:40:10 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:39:56 +0000
In-Reply-To: <20240325134004.4074874-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325134004.4074874-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325134004.4074874-2-gnoack@google.com>
Subject: [PATCH v12 1/9] security: Introduce ENOFILEOPS return value for IOCTL hooks
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If security_file_ioctl or security_file_ioctl_compat return
ENOFILEOPS, the IOCTL logic in fs/ioctl.c will permit the given IOCTL
command, but only as long as the IOCTL command is implemented directly
in fs/ioctl.c and does not use the f_ops->unhandled_ioctl or
f_ops->compat_ioctl operations, which are defined by the given file.

The possible return values for security_file_ioctl and
security_file_ioctl_compat are now:

 * 0 - to permit the IOCTL
 * ENOFILEOPS - to permit the IOCTL, but forbid it if it needs to fall
   back to the file implementation.
 * any other error - to forbid the IOCTL and return that error

This is an alternative to the previously discussed approaches [1] and [2],
and implements the proposal from [3].

Cc: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20240309075320.160128-2-gnoack@google.com [=
1]
Link: https://lore.kernel.org/r/20240322151002.3653639-2-gnoack@google.com/=
 [2]
Link: https://lore.kernel.org/r/32b1164e-9d5f-40c0-9a4e-001b2c9b822f@app.fa=
stmail.com/ [3]
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 fs/ioctl.c               | 25 ++++++++++++++++++++-----
 include/linux/security.h |  6 ++++++
 security/security.c      | 10 ++++++++--
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 76cf22ac97d7..8244354ad04d 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -828,7 +828,7 @@ static int do_vfs_ioctl(struct file *filp, unsigned int=
 fd,
=20
 	case FIONREAD:
 		if (!S_ISREG(inode->i_mode))
-			return vfs_ioctl(filp, cmd, arg);
+			return -ENOIOCTLCMD;
=20
 		return put_user(i_size_read(inode) - filp->f_pos,
 				(int __user *)argp);
@@ -858,17 +858,24 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int=
, cmd, unsigned long, arg)
 {
 	struct fd f =3D fdget(fd);
 	int error;
+	bool use_file_ops =3D true;
=20
 	if (!f.file)
 		return -EBADF;
=20
 	error =3D security_file_ioctl(f.file, cmd, arg);
-	if (error)
+	if (error =3D=3D -ENOFILEOPS)
+		use_file_ops =3D false;
+	else if (error)
 		goto out;
=20
 	error =3D do_vfs_ioctl(f.file, fd, cmd, arg);
-	if (error =3D=3D -ENOIOCTLCMD)
-		error =3D vfs_ioctl(f.file, cmd, arg);
+	if (error =3D=3D -ENOIOCTLCMD) {
+		if (use_file_ops)
+			error =3D vfs_ioctl(f.file, cmd, arg);
+		else
+			error =3D -EACCES;
+	}
=20
 out:
 	fdput(f);
@@ -916,12 +923,15 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsig=
ned int, cmd,
 {
 	struct fd f =3D fdget(fd);
 	int error;
+	bool use_file_ops =3D true;
=20
 	if (!f.file)
 		return -EBADF;
=20
 	error =3D security_file_ioctl_compat(f.file, cmd, arg);
-	if (error)
+	if (error =3D=3D -ENOFILEOPS)
+		use_file_ops =3D false;
+	else if (error)
 		goto out;
=20
 	switch (cmd) {
@@ -967,6 +977,11 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsign=
ed int, cmd,
 		if (error !=3D -ENOIOCTLCMD)
 			break;
=20
+		if (!use_file_ops) {
+			error =3D -EACCES;
+			break;
+		}
+
 		if (f.file->f_op->compat_ioctl)
 			error =3D f.file->f_op->compat_ioctl(f.file, cmd, arg);
 		if (error =3D=3D -ENOIOCTLCMD)
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..b769dc888d07 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -248,6 +248,12 @@ static const char * const kernel_load_data_str[] =3D {
 	__kernel_read_file_id(__data_id_stringify)
 };
=20
+/*
+ * Returned by security_file_ioctl and security_file_ioctl_compat to indic=
ate
+ * that the IOCTL request may not be dispatched to the file's f_ops IOCTL =
impl.
+ */
+#define ENOFILEOPS 532
+
 static inline const char *kernel_load_data_id_str(enum kernel_load_data_id=
 id)
 {
 	if ((unsigned)id >=3D LOADING_MAX_ID)
diff --git a/security/security.c b/security/security.c
index 7035ee35a393..000c54a1e541 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2719,7 +2719,10 @@ void security_file_free(struct file *file)
  * value.  When @arg represents a user space pointer, it should never be u=
sed
  * by the security module.
  *
- * Return: Returns 0 if permission is granted.
+ * Return: Returns 0 if permission is granted.  Returns -ENOFILEOPS if
+ *         permission is granted for IOCTL commands that do not get handle=
d by
+ *         f_ops->unlocked_ioctl().  Returns another negative error code i=
s
+ *         permission is denied.
  */
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long=
 arg)
 {
@@ -2736,7 +2739,10 @@ EXPORT_SYMBOL_GPL(security_file_ioctl);
  * Compat version of security_file_ioctl() that correctly handles 32-bit
  * processes running on 64-bit kernels.
  *
- * Return: Returns 0 if permission is granted.
+ * Return: Returns 0 if permission is granted. Returns -ENOFILEOPS if perm=
ission
+ *         is granted for IOCTL commands that do not get handled by
+ *         f_ops->compat_ioctl().  Returns another negative error code is
+ *         permission is denied.
  */
 int security_file_ioctl_compat(struct file *file, unsigned int cmd,
 			       unsigned long arg)
--=20
2.44.0.396.g6e790dbe36-goog


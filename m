Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168125;
	b=V/dM+eM0XhmFqVdbiH2HtGpP34bY3718mnhX+zdEeSQUPoUPUgfoEqVxO1mt4+4uPqYd
	 DVukFArlnaJxJtnXFnBZ4QcWK8lxylM6hS6qZtJQIiegk0etV6Biq41vkV4Y79uiNOHKB
	 8pW5nMWDFdOrtjyxl4OpAWu/8N/MTX+1pMKzYlitdbDdqs21+orWmL+oo8uol0Pk5qGXU
	 p8KFwqRpSJ6DYVN8QMqkAs1p3XEoeI022DTDqwtK7NmQN0koYmL8siKRVvpCmjEtNU9k+
	 nuOiERjpUvEV9U/Int5Th2I0rTT6FXg/dNLeNRqglrH8ZCmwz/hb+NKGDTe0tGdGc8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g7RdVn0LMoEs2dfOGDRDG/kF9Dj5nfh11MC5a3PxnCE=;
	b=BNRzetlBXLzElM6bC4/7Tto2hURbbdLWf/DM+iYV8euAGgKJ3m9ay0GkG05U4JOApmVB
	 hZLqSCwGTbgBAas+EJxIDlwXwOadBFbg/hmpV4CUsexLiUM3aMu45gUG1L+/kK6WbQl0f
	 K5H7dL0x8Cg3tMcAgxOlxypSFN1J7UM4ottcNIW0XLHhrDPGD/Cg0P8xGgmwK4jGweNMm
	 WNZ3UmypecmzNwZx8Baq/kzBUwNJjhG4jzuSA+kZJcFUoPAajRLZEDdFKkZqddAd7LB91
	 F1vfWfVqyxXzHBGiPDNjoNWs7IIi/7Ewg5WPbRkoHCXKNSivtqsCpddRMYAtzBP6Rpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ugbdGhIZ;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C281660A2603
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 09:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C281660A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ugbdGhIZ
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so7947535e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 01:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795168123; x=1795772923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g7RdVn0LMoEs2dfOGDRDG/kF9Dj5nfh11MC5a3PxnCE=;
        b=ugbdGhIZJtUsZ6WmT/mPSVLomwtutW8nQfXgBmaN/lCuuo0bZGq182BQA57yn7pVaC
         Z6R5qYhoRMOxeJhRpOvqVsIpjV08d7+Uan8W2WpX38C9+SXrsN9AgqdLzo/DpaRC2yqO
         VPjdesb9fJ5Nqt6jYpGE+tjW6J88IT9q3w4XMZpxIcvlbxo7TOldCWXXAWZO54Mqu8Im
         xPzuPv2+Up4oCmjtkeGiT71Kcf+V+iKfCIC4nqZHcim7JIVYFjTXEPs39QWlLf/2akQw
         tUFWA67KcNk7jPlSsdJ4aJkkJGv7/rrG92Wk5g+V8sNbdJsd3OawM42PNQYdTIDZG3Kd
         BFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168123; x=1795772923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g7RdVn0LMoEs2dfOGDRDG/kF9Dj5nfh11MC5a3PxnCE=;
        b=VAgWUZspSl0wUPYU1D5aSmfQlbq/qFSxNmLA1UkF/YwzZGEFIv/XYk3YdIFmj2WZpC
         PoLmdv+QEoUTWVpPWapgWfzai6OQG82e8leOwA1XMbWDw56rgOJtPRSj79YbZd06e/tv
         TUdOD+wG/nOoOG483tY5+iHhdio17GP8WWKBfjqw8TQgDhJmXvLClA67VALV+oFc5IQv
         i/xov4VxvsdEEVpdvbIyymSKuFu5LAeoHHjdrT3PK8wcI0rN5VOB0vr00LA67NpvAPyl
         Z7EFYwPFvBtpBS+0RKX1QcghOnD+t/K6prpR5jzRJij/Y1qZmuFaD0sE+B1YV+bkhMeU
         B/Iw==
X-Gm-Message-State: APuU4Z+Gpdso3jz3UtwIsYQnNE+R6vhWnkUIv7zes5pSUEG9gKPiCnne
	xVh2eb3RgaRE8AaFeEnZOafKZmgTdd+/k4VxVlFSoslYGwq0fN8HObRpZvPhWRjb
X-Gm-Gg: AYBFou01s0l72q1UeEhrOOj4jyvE+binYaIrNcFIRQ8cSseof7JXss0dvd72X7HdyKc
	ACRI1xl90SIioNUIixXBh9XN377VFfzk2GoXwIH/ZsS+NFBr+wJfMZy1nHKUf40aof6Khjiyagj
	nim3vex2YrAtac863kv1pSxYxOQyXk/SjEdzEaBDxCMgorm4zGUzTbgksSWuDfu+EohIFsaW1N1
	+ZQq8gz8+CVEbOPF5Rp3sL7yHLFjl28p0WfzdQRrgyWTIDJ3ylQGS6om+4tKbEJa3DsAgNZdyT6
	s8iS3eu4fDj8EVRS/vIj0f02YxzP5P25qkgGPGr7SNMoWd5Eq/k164CZMbWTzcuoGfFYsiEI2DV
	o0489pes/2h3s7SGEQF0DS4FV1vhE4hQhOy/5r7wevoukzlCAzv98svWbXBfLX+XjCoOoqzxDS9
	XqH4qg1cJsodHGlb5uU+LnAvojTjobvBCSdv2GX6wHRgXzn266Jqh170AcxJSi+BbPQw9wmkp4i
	Y6LxL2z0oj8gE4zrDf1092x5zYBE8X11WC50negp0E4uLOlUDM8KsU5g2vKvGTHvtKwcxVUfNzQ
	xPOT6wYzCWS7M27JKxE3I4AllSo/D4FtrJugH3+khIw=
X-Received: by 2002:a05:600c:4e16:b0:4bb:6f77:1e35 with SMTP id 5b1f17b1804b1-4bb88810991mr58830945e9.21.1795168122957;
        Fri, 20 Nov 2026 01:48:42 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f635ffsm45137535e9.4.2026.11.20.01.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:48:42 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	eddyz87@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [RFC PATCH 1/2] security: Add hook for unresolved pathname opens
Date: Fri, 20 Nov 2026 11:48:19 +0200
Message-ID: <20261120094820.11929-2-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120094820.11929-1-tasos.papagiannnis@gmail.com>
References: <20261120094820.11929-1-tasos.papagiannnis@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the copied pathname against the selected base before traversal or
file changes, including O_PATH and O_TMPFILE.

Pass lookup flags so policy can request a referenced retry. Recheck the
base after each restart and cover kernel opens with an explicit root.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 fs/namei.c                    | 15 +++++++++++++--
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 10 ++++++++++
 security/security.c           | 27 +++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 925aeb63bfa1..fde11d36d434 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -749,6 +749,7 @@ struct nameidata {
 	} *stack, internal[EMBEDDED_LEVELS];
 	struct filename	*name;
 	const char *pathname;
+	const struct open_flags *open;
 	struct nameidata *saved;
 	unsigned	root_seq;
 	int		dfd;
@@ -768,6 +769,7 @@ static void __set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 	p->dfd = dfd;
 	p->name = name;
 	p->pathname = likely(name) ? name->name : "";
+	p->open = NULL;
 	p->path.mnt = NULL;
 	p->path.dentry = NULL;
 	p->total_link_count = old ? old->total_link_count : 0;
@@ -2716,7 +2718,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		} else {
 			path_get(&nd->path);
 		}
-		return s;
+		goto out;
 	}
 
 	nd->root.mnt = NULL;
@@ -2726,7 +2728,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		error = nd_jump_root(nd);
 		if (unlikely(error))
 			return ERR_PTR(error);
-		return s;
+		goto out;
 	}
 
 	/* Relative pathname -- get the starting-point it is relative to. */
@@ -2784,6 +2786,14 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			nd->state |= ND_ROOT_GRABBED;
 		}
 	}
+out:
+	if (nd->open) {
+		error = security_file_open_name(nd->name, &nd->path,
+						nd->open->open_flag, nd->open->mode,
+						nd->flags);
+		if (error)
+			return ERR_PTR(error);
+	}
 	return s;
 }
 
@@ -4999,6 +5009,7 @@ static struct file *path_openat(struct nameidata *nd,
 	struct file *file;
 	int error;
 
+	nd->open = op;
 	file = alloc_empty_file(op->open_flag, current_cred());
 	if (IS_ERR(file))
 		return file;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 87d9d06710cb..3537f2b73d8c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -213,6 +213,8 @@ LSM_HOOK(void, LSM_RET_VOID, file_set_fowner, struct file *file)
 LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
 	 struct fown_struct *fown, int sig)
 LSM_HOOK(int, 0, file_receive, struct file *file)
+LSM_HOOK(int, 0, file_open_name, const struct filename *name,
+	 const struct path *base, int flags, umode_t mode, unsigned int lookup_flags)
 LSM_HOOK(int, 0, file_open, struct file *file)
 LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
 LSM_HOOK(int, 0, file_truncate, struct file *file)
diff --git a/include/linux/security.h b/include/linux/security.h
index 40831fab5470..e6c66cf1cd1c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -498,6 +498,9 @@ void security_file_set_fowner(struct file *file);
 int security_file_send_sigiotask(struct task_struct *tsk,
 				 struct fown_struct *fown, int sig);
 int security_file_receive(struct file *file);
+int security_file_open_name(const struct filename *name,
+			    const struct path *base, int flags, umode_t mode,
+			    unsigned int lookup_flags);
 int security_file_open(struct file *file);
 int security_file_post_open(struct file *file, int mask);
 int security_file_truncate(struct file *file);
@@ -1238,6 +1241,13 @@ static inline int security_file_receive(struct file *file)
 	return 0;
 }
 
+static inline int security_file_open_name(const struct filename *name,
+					  const struct path *base, int flags, umode_t mode,
+					  unsigned int lookup_flags)
+{
+	return 0;
+}
+
 static inline int security_file_open(struct file *file)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index f6583d507395..d265f9347791 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2742,6 +2742,33 @@ int security_file_receive(struct file *file)
 	return call_int_hook(file_receive, file);
 }
 
+/**
+ * security_file_open_name() - Authorize a pathname open before lookup
+ * @name: kernel copy of the unresolved pathname, which may be empty
+ * @base: starting path selected by the lookup
+ * @flags: effective open flags
+ * @mode: creation mode, including the file type, before applying the umask
+ * @lookup_flags: current pathname lookup flags, including LOOKUP_RCU
+ *
+ * Check the original pathname before lookup, creation, or opening the file.
+ * @base is the starting path for this attempt, or the file itself for an empty
+ * pathname.  This hook also covers O_PATH and io_uring opens.
+ *
+ * This hook must not sleep.  @name and @base are borrowed for the call.  With
+ * LOOKUP_RCU, @base is RCU-protected; otherwise it holds path references.
+ *
+ * Return: 0 to allow the open or -EACCES or -EPERM to deny it.
+ * During RCU walk, -ECHILD requests a referenced retry. A cached-only
+ * lookup returns -EAGAIN instead.
+ */
+int security_file_open_name(const struct filename *name,
+			    const struct path *base, int flags, umode_t mode,
+			    unsigned int lookup_flags)
+{
+	return call_int_hook(file_open_name, name, base, flags, mode,
+			     lookup_flags);
+}
+
 /**
  * security_file_open() - Save open() time state for late use by the LSM
  * @file:
-- 
2.56.0


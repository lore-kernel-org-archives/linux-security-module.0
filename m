Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D583C1F41
	for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455145; cv=none; b=YxslqFwPMUb/0ppBCepR000l1qAOPSz/iLVBZm+JkMWvcE/MJD0vEql9vfEV3jHQt2lTTb+B76K8022cPXMgDYNI+akUhfb7fymsFQIXxPRBj5IUrtGHqOTNSHdmXCTPSd458aWJ6exPzt1RsftcNDyL4QrzwBI3r+41sM4tGpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455145; c=relaxed/simple;
	bh=UeLmhePSWPFBkTNLrPRrGvFa0QdMl0ECbxnKCarjDNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRyaadirRHoHAZTwbQ5DV4ayDPEsrkYasxIu1nJjB/fHOcm4MxYtWMxTqt9ga4S+PzVLnSv/bzNAkEagKh8s5/UQekCfetEg6HAoD8KdnKTrboORIbSYcuvlbj8rTHFUK863xK0yKzyuJm6LR8n5J2C6shALPC0tfUhJASAPG5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcN0Tc+2; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcN0Tc+2"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8f0e5e36912so2740806d6.2
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 16:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785455142; x=1786059942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6bZ7yPHg5vYfLp4cv5XEz6QymRiym0C5qHzBJxTtuE4=;
        b=fcN0Tc+2K8qu8lyLltORgo0w57ssv+K8cESw8jhOzqU7VeB2DkglRQQO9bhGEikiBN
         5dlf811xyvSpZGX2rzNCJmfvhnJvFUvZAaUUeGeZp5SI5p/LyrxBBXaw+DCgXDNA8Bbe
         ReKDKnUUHd4FF86S1vNfrcClSkrs3EpDczDCIneazYT/b7qC8dn2y/poW4WD0c7tQbHV
         I4f0yc+BmmibTzqVEOIqp4Mgh8qBut1kAbRY6us4R0tUqHsfmXmFtsHZN9fTlBlkKNfd
         2ZFVeLVuZ3clqAM6luCKGGWQ5tEbKalm8UJRL3JW5m4g5oW6wyx/XVkm2j8ftysDIho/
         uq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455142; x=1786059942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6bZ7yPHg5vYfLp4cv5XEz6QymRiym0C5qHzBJxTtuE4=;
        b=N5DUWiRP4u2yiei8iynXy2wUZEGACaVewusH2QE0rbLs0v+2Ljda4b7P9cN/y3drsR
         edWxad5wTZEqKY1QLQnajRe/X3Okco9ywNvOB2GAfoKwK39val89iigcmV1PTixRjb7e
         SMM43wG7xUhSb8emgYPdH9d85x1TKdJ6pK3jvFk+Z1OdHats3dHakv0lrYbZ6WecP/pM
         gkT8Xhh8y81Sa0br0P0NmTHjq+IcLrTPCm7cT9ywEpYKxhBOJv3brHMVAZom+RVS2gnH
         DY6QhVPnALxc93v2Qa531yAGS8LaCK5dSTRhFN2bf0G5QeJk+twwXt01lmcMtoE9HMRM
         HdyA==
X-Forwarded-Encrypted: i=1; AHgh+Rpw6jIR3dGrGpRiXPQErmBxyNA1nf2J2HxiceDc9mwKlxAkZTmdnY/vUI5R/PmFABGkbUodlHbmETTsk9oYUVooWOw+obA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynhM8OCAessj4U6etE5RamImq8nZ2xn+BYLM5O4z3wabX+l+NO
	FVgxV52XzkXpqFCNttwcPpLH7TtGeWkjW4G5GlUBXeJXIfCm8SvLK0irBW6PcE+1
X-Gm-Gg: AR+sD13n9hyNXyiNUzeBnYWp+Dyj62+PMSNQsKr+GnHpi7Jj5UKcR/fkvqQ9WjjMxh8
	Uh86i4MlY0mNpR72eq/okSPl3AE86MoI9IHqIp6dcVkoLVR6FSVpnmfP5PGBvn5hmWOTeap6lzR
	XxvntP59NjZSpQ2mkV8G4P0+68yXkYWyZCpBAPiQSMbEf27WZxK8AVZbqJbTtJf0i886YLTmKJG
	e6Hpo0FrgW9jHgp3SJlRyuyuFlKmTBanrAj+03Dva/G0G3UR/piXbnHE3gpj9Fu8NGueq+ye3hI
	AH7hNUfo2yovYOFJdxau9nq2+H7bRCHNTLoZgRfsBTEOLEGozMtVK1ZhbTTMHKuelwk7d3W5cKq
	Ev8jXIoKXt14wA/2hPfOAbzsWNNqcOQBhWjEfoMv2vA1yeBcAAcmuTVgiXJzeCD2IuY03iV02n1
	rFJ6Q8ltzKPXSFLnVs0f4tkcZfd9bbv+rPVf1izSYVTewUxRvJafOi3pA0GZDpy8PP5SFjZky+l
	oMTkqU5//7mPi6KwUPo7GGcyJZ91Zexvuczq23rbWEEMCmAMnEqXdK4r3k3kExZgnI5X82LLQ==
X-Received: by 2002:a05:6214:3901:b0:8ef:db4:d85f with SMTP id 6a1803df08f44-9083bb5b841mr27021636d6.41.1785455142243;
        Thu, 30 Jul 2026 16:45:42 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908323e8bc0sm28991836d6.26.2026.07.30.16.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:45:41 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Thu, 30 Jul 2026 19:45:32 -0400
Message-ID: <20260730234533.1912709-4-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730234533.1912709-1-dwindsor@gmail.com>
References: <20260730234533.1912709-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
xattrs via the inode_init_security hook using security_lsmxattr_add().
The hook now passes its xattr state as a single struct lsm_xattrs
object, which the kfunc takes directly.

This kfunc is only callable from inode_init_security; the verifier
rejects attempts to call it elsewhere.

A previous attempt [1] required a kmalloc string output protocol for
the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
provide xattrs for inode_init_security hook") [2], the xattr name is no
longer allocated; it is a static constant.

Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
Suggested-by: Song Liu <song@kernel.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index f1863a891db6..7b55073934e0 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -11,7 +11,9 @@
 #include <linux/file.h>
 #include <linux/kernfs.h>
 #include <linux/mm.h>
+#include <linux/security.h>
 #include <linux/xattr.h>
+#include <uapi/linux/lsm.h>
 
 __bpf_kfunc_start_defs();
 
@@ -379,6 +381,44 @@ __bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
 	return d_real_inode(file_dentry(file));
 }
 
+/**
+ * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_security
+ * @xattrs: inode_init_security xattr state from the hook context
+ * @name__str: xattr name (e.g., "bpf.file_label")
+ * @value_p: dynptr containing the xattr value
+ *
+ * Only callable from lsm/inode_init_security programs.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the filesystem does not accept
+ *         xattrs at inode creation, negative error on other failures.
+ */
+__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
+				     const char *name__str,
+				     const struct bpf_dynptr *value_p)
+{
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	const void *value;
+	u32 value_len;
+
+	if (!name__str)
+		return -EINVAL;
+	if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
+		    sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
+		return -EPERM;
+
+	if (!xattrs->xattrs)
+		return -EOPNOTSUPP;
+
+	value_len = __bpf_dynptr_size(value_ptr);
+	value = __bpf_dynptr_data(value_ptr, value_len);
+	if (!value)
+		return -EINVAL;
+
+	return security_lsmxattr_add(xattrs, LSM_ID_BPF,
+				     name__str + sizeof(XATTR_BPF_LSM_SUFFIX) - 1,
+				     value, value_len);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -390,6 +430,7 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_init_inode_xattr)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.53.0


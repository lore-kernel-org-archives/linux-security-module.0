Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0D1F7569
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773264687; cv=none; b=nY+PAGpuFViYnKWJRdXF3zZK77aPRPhfQEPcv84k9CKlQnj+AeCBvfhcIRw5JLZcICOQGQxv+hqXOvmaD5cDTMBjxtf8E4JEt1Kwl3v3Z3SlZGQu9MOxrZqLbqtMzDuDbIuzZaseYPX2dNKxwqO9Q7miPRpTcUQEYhZQGO2cxrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773264687; c=relaxed/simple;
	bh=6R7DImnsXBYJQBnefaWTz+XuDxYsvyJzUXRjb8C9Zz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BKnufDyYapcw2CEabM3WBokT7fSS3ARpHTM9Lq8Jbn47I5Ro9jL92sgqNwVpYsGt0nSg3+9JRzlNR2odC6uAN9bO+XFyvKSywfXR6dw0C3w/KJVCGLC/Z4Sb4CCbU5CXLoyzvHh4JDHXOOrAcsBe9s0Y3ZknLZ4v4UiRBl4B5Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bjVo+zPT; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bjVo+zPT"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-67bad873c3eso224912eaf.3
        for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 14:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773264685; x=1773869485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IX29AT46QQIcV+IR2GwkNddbkT1RbF8B8LfUKka7CdA=;
        b=bjVo+zPTtgTxZPoN2j4ZrV+iBff4bksbpLHcrtPELGuKCmkpxUfSGJmdGdEON+oHtn
         4uLSK7fXRN8ywnaEgvehDJHVGtsNp0pqx3tJ9V4h59fVZSWSIH1xLo2Ft7Lk6GnAw/Nl
         5UxFzudW1xw+DQXGctCzzQXBFW1NVXnPyIBwdVZMrc0Ba2hdnSXAvO1k2koOmNnj6TQu
         UfD9ViEg3qy4slBIGQnPgs29a7tOjaT29Sc9t/wZW0sn4NZGyM6Kh3xJia6A/iOWrg7M
         dyCge7jSksFpQs1qgRjtAcG+bJ+wol7cXMGfvolpBSSjvJKVEVjn4s2g3r6/N0Ut9Xpm
         T3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773264685; x=1773869485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IX29AT46QQIcV+IR2GwkNddbkT1RbF8B8LfUKka7CdA=;
        b=AnzaXwjdpefry3udCvhs/uMM0W200HuQ50XDmL/69Uy6gYKaA3JupkkSytDpzvd4u4
         0N+QFTIx2Gj3OizUMZo7ErRkte4P8TNM6gNeC58+WWHnnmjODrIuxadK8dGQjpikXnda
         7LhKmGD/CVMVe/hbOXoma5/zkkNrORL0L8sZ8e3R4StD7ib3MYrpfG4FcmtXBWOpDxS8
         kA5ZickAoLTuUHFYDJ7TEXnWIzFmyJ4C8YEec9iMpGJP4lTT9CtCY15RC16w8j4UaY9+
         1uZPvRRmWXE8LmekCNExMbkkUJvVVKdESWQu9mHy7RpFAnVExVz5GAVDNvxqepSAzh+4
         IviQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO6psariusHllo0SroMmmj6JuZe2RI1xewHMNy/s1QJT35T/u+c7/EoLZia+AoVRRz3B+8chIcIQobg8+P2i5GJCZBUA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+sWALK6DLAzk0jLU/tc+E4w2zo9xO5WIVyf3BRX/5GauZv/6
	uhl7q9KwHKO3lA1MQbd8dSpoNCSNQmOJVdKwjSzZ3lQRLG6uZM6LlMcXDyjmVK1u2FY=
X-Gm-Gg: ATEYQzz/vwSYb/Db3fbhnu/STp5TAk8Vbw7U3Z+x98lSU/gQHs1VP3XRLX8IJixVmO7
	zII2T3mcc9zL/63qRCYXi574JLb8aRcOYThLlPgD+P2RASvdzrwJAJDSjK/2Ol1ULdC1E9noXdb
	iMYJDR5MVNcEgO3XmU4nAp/N0AFdCiZbXUpz6dvzCbkS2CoQWxgqAjiUSR0QV1bVaWYPLdz1du1
	d3zKwDqDOpQ67Zg79gkLxCU7mTg6/LdQw78MPuUPa4xLnxlxXsqSGuLpxVFJ0zcrt6aZq6vZ81f
	m6OifRX2SmB469PzbHzei0g3+IApFZrkkg1RV+bUA0zKLkyYY7yudfcYLHlZLkhqZCuhx0JnxGr
	5tQNHX+o9AEOBAwoPQ0UwEcuDCso8TZJm/vt5ibW3nv0oNzyCatq2i3JOvarBbf2BA3Du6bf4dn
	0c6TJ4eE8=
X-Received: by 2002:a05:6820:1a06:b0:679:be0c:8b54 with SMTP id 006d021491bc7-67bc88780f7mr2728421eaf.5.1773264684867;
        Wed, 11 Mar 2026 14:31:24 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:947d:4e6::7d:82])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1fb90csm3530413fac.4.2026.03.11.14.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:31:24 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Wed, 11 Mar 2026 16:31:17 -0500
Subject: [PATCH RFC bpf-next 1/4] audit: Implement bpf_audit_log_*()
 wrappers
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
In-Reply-To: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 audit@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kernel-team@cloudflare.com, Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11097; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=6R7DImnsXBYJQBnefaWTz+XuDxYsvyJzUXRjb8C9Zz0=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpsd8nAVEDVeVoA/J51G/He85tYdUpq8FlBqjPK
 SMUHy6glcuJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCabHfJwAKCRCrJbR2A5LT
 bQiREACSw+lxbX7Na2XyaP4JiFdPIVB3jQEUE3BFi2o72reP0VE75EdCWz2P+GZxt9jR6K+SEp1
 yM1a1xuwuNeAsZvHqz1qkKk15vflf0f2f1At7nmGsnYNAmBgK0J0Vx9sXnAAZDVi1fR0FLA1Zgd
 uv0NYhT0tgb/y6V70YfKT5ylbKq0sHh+syok7+Ty/fW69q/a6lxKI4BvqKcV2V2o09ub1mmlWka
 siyS9tkx9CtRm0j9GFJw80z4XxuZGI67/qkFzAwthhL5kEN3zm9mo3hPAj2DnhJu4OmYKCejgen
 elbVQWB3OgdTd2cZtIqiq/uij6FjFjOjeFH7XAWDUMt1dtE5z9vk2rdHG0fIJKBdQi7f6A61Zgq
 j9FS0VVJq/rCxMiX9LPLSr2bsjzY2gbaitUF5BwmY83hV1PXG5NgOHIiIH4Tdy9tz9Uo+ztznIU
 SpxZLB/E/W8UoochkcNWBkgc9S5o8lLCLDbGnWuRF/77Khwu8BlNpn8UHxGdTpCwM/iU9q9gvU1
 K2/gFoeon2B5RLVkdce3dYF2oxyD7Ybdjcl4fu9lXM7uNLYr4ccvGlvQrungOKUDHhPNDQM+fH+
 Ky6bvS1Cj9VVeXSaBS6k3UIh6cEj2GIP/nwxqPFiE5GGWZaXi0Hw4AOCCPff5LAOmL0bTd9KQa7
 c4I7tNtZQ8kOioQ==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

The primary use case is to provide LSM designers a direct API to report
access allow/denies through the audit subsystem similar to how LSM's
traditionally log their accesses.

Left out from this API are functions that are potentially abuseable such as
audit_log_format() where users may fill any field=value pair. Instead, the
API mostly follows what is exposed through security/lsm_audit.c for
consistency with user space audit expectations. Further calls to functions
report once to avoid repeated-call abuse.

Lastly, each audit record corresponds to the loaded BPF program's ID to
track which program reported the log entry. This helps remove
ambiguity in the event multiple programs are registered to the same
security hook.

Exposed functions:

	bpf_audit_log_start()
	bpf_audit_log_end()
	bpf_audit_log_cause()
	bpf_audit_log_cap()
	bpf_audit_log_path()
	bpf_audit_log_file()
	bpf_audit_log_ioctl_op()
	bpf_audit_log_dentry()
	bpf_audit_log_inode()
	bpf_audit_log_task()
	bpf_audit_log_net_sock()
	bpf_audit_log_net_sockaddr()

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 include/linux/lsm_audit.h   |   1 +
 include/uapi/linux/audit.h  |   1 +
 security/lsm_audit_kfuncs.c | 306 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 308 insertions(+)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 382c56a97bba1d0e5efe082553338229d541e267..859f51590de417ac246309eb75a760b8632224be 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -78,6 +78,7 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_NOTIFICATION 16
 #define LSM_AUDIT_DATA_ANONINODE	17
 #define LSM_AUDIT_DATA_NLMSGTYPE	18
+#define LSM_AUDIT_DATA_CAUSE 19 /* unused */
 	union 	{
 		struct path path;
 		struct dentry *dentry;
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 14a1c1fe013acecb12ea6bf81690965421baa7ff..7a22e214fe3e421decfc4109d2e6a3cee996fe51 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -150,6 +150,7 @@
 #define AUDIT_LANDLOCK_DOMAIN	1424	/* Landlock domain status */
 #define AUDIT_MAC_TASK_CONTEXTS	1425	/* Multiple LSM task contexts */
 #define AUDIT_MAC_OBJ_CONTEXTS	1426	/* Multiple LSM objext contexts */
+#define AUDIT_BPF_LSM_ACCESS		1427	/* LSM BPF MAC events */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/security/lsm_audit_kfuncs.c b/security/lsm_audit_kfuncs.c
new file mode 100644
index 0000000000000000000000000000000000000000..0d4fb20be34a61db29aa2c48d2aefc39131e73bf
--- /dev/null
+++ b/security/lsm_audit_kfuncs.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Cloudflare */
+
+#include <linux/audit.h>
+#include <linux/bpf_mem_alloc.h>
+#include <linux/gfp_types.h>
+#include <linux/in6.h>
+#include <linux/lsm_audit.h>
+#include <linux/socket.h>
+#include <linux/types.h>
+
+struct bpf_audit_context {
+	struct audit_buffer *ab;
+	u64 log_once_mask;
+};
+
+static struct bpf_mem_alloc bpf_audit_context_ma;
+
+static inline u64 log_once(struct bpf_audit_context *ac, u64 mask)
+{
+	u64 set = (ac->log_once_mask & mask);
+
+	ac->log_once_mask |= mask;
+	return set;
+}
+
+static inline int __audit_log_lsm_data(struct bpf_audit_context *ac,
+				       struct common_audit_data *ad)
+{
+	if (log_once(ac, BIT_ULL(ad->type)))
+		return -EINVAL;
+
+	audit_log_lsm_data(ac->ab, ad);
+	return 0;
+}
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc
+struct bpf_audit_context *bpf_audit_log_start(struct bpf_prog_aux *aux)
+{
+	char comm[sizeof(current->comm)];
+	struct bpf_audit_context *ac;
+
+	ac = bpf_mem_cache_alloc(&bpf_audit_context_ma);
+	if (!ac)
+		return NULL;
+
+	memset(ac, 0, sizeof(*ac));
+	ac->ab = audit_log_start(audit_context(),
+				 (aux->might_sleep) ? GFP_KERNEL : GFP_ATOMIC,
+				 AUDIT_BPF_LSM_ACCESS);
+	if (!ac->ab) {
+		bpf_mem_cache_free(&bpf_audit_context_ma, ac);
+		return NULL;
+	}
+
+	audit_log_format(ac->ab, "prog-id=%d", aux->id);
+
+	/* Audit may not have a filter configured for syscalls. Include
+	 * potentionally redundant pid & comm information
+	 */
+	audit_log_format(ac->ab, " pid=%d comm=", task_tgid_nr(current));
+	audit_log_untrustedstring(ac->ab, get_task_comm(comm, current));
+
+	return ac;
+}
+
+__bpf_kfunc void bpf_audit_log_end(struct bpf_audit_context *ac)
+{
+	audit_log_end(ac->ab);
+	bpf_mem_cache_free(&bpf_audit_context_ma, ac);
+}
+
+__bpf_kfunc int bpf_audit_log_cause(struct bpf_audit_context *ac,
+				    const char *cause__str)
+{
+	if (log_once(ac, BIT_ULL(LSM_AUDIT_DATA_CAUSE)))
+		return -EINVAL;
+
+	audit_log_format(ac->ab, " cause=");
+	audit_log_untrustedstring(ac->ab, cause__str);
+	return 0;
+}
+
+__bpf_kfunc int bpf_audit_log_cap(struct bpf_audit_context *ac, int cap)
+{
+	struct common_audit_data ad;
+
+	ad.type = LSM_AUDIT_DATA_CAP;
+	ad.u.cap = cap;
+	return __audit_log_lsm_data(ac, &ad);
+}
+
+__bpf_kfunc int bpf_audit_log_path(struct bpf_audit_context *ac,
+				   const struct path *path)
+{
+	struct common_audit_data ad;
+
+	/* DATA_PATH prints similar to DATA_FILE */
+	if (log_once(ac, BIT_ULL(LSM_AUDIT_DATA_FILE)))
+		return -EINVAL;
+
+	ad.type = LSM_AUDIT_DATA_PATH;
+	ad.u.path = *path;
+	return __audit_log_lsm_data(ac, &ad);
+}
+
+__bpf_kfunc int bpf_audit_log_file(struct bpf_audit_context *ac,
+				   struct file *file)
+{
+	struct common_audit_data ad;
+
+	/* DATA_PATH prints similar to DATA_FILE */
+	if (log_once(ac, BIT_ULL(LSM_AUDIT_DATA_PATH)))
+		return -EINVAL;
+
+	ad.type = LSM_AUDIT_DATA_FILE;
+	ad.u.file = file;
+	return __audit_log_lsm_data(ac, &ad);
+}
+
+__bpf_kfunc int bpf_audit_log_ioctl_op(struct bpf_audit_context *ac,
+				       struct file *file, u16 cmd)
+{
+	struct lsm_ioctlop_audit op = { .path = file->f_path, .cmd = cmd };
+	struct common_audit_data ad;
+
+	ad.type = LSM_AUDIT_DATA_IOCTL_OP;
+	ad.u.op = &op;
+	return __audit_log_lsm_data(ac, &ad);
+}
+
+__bpf_kfunc int bpf_audit_log_dentry(struct bpf_audit_context *ac,
+				     struct dentry *dentry)
+{
+	struct common_audit_data ad;
+
+	/* DATA_DENTRY prints similar to DATA_INODE */
+	if (log_once(ac, BIT_ULL(LSM_AUDIT_DATA_INODE)))
+		return -EINVAL;
+
+	ad.type = LSM_AUDIT_DATA_DENTRY;
+	ad.u.dentry = dentry;
+	return __audit_log_lsm_data(ac, &ad);
+}
+
+__bpf_kfunc int bpf_audit_log_inode(struct bpf_audit_context *ac,
+				    struct inode *inode)
+{
+	struct common_audit_data ad;
+
+	/* DATA_DENTRY prints similar to DATA_INODE */
+	if (log_once(ac, BIT_ULL(LSM_AUDIT_DATA_DENTRY)))
+		return -EINVAL;
+
+	ad.type = LSM_AUDIT_DATA_INODE;
+	ad.u.inode = inode;
+	return __audit_log_lsm_data(ac, &ad);
+}
+
+__bpf_kfunc int bpf_audit_log_task(struct bpf_audit_context *ac,
+				   struct task_struct *tsk)
+{
+	struct common_audit_data ad;
+
+	ad.type = LSM_AUDIT_DATA_TASK;
+	ad.u.tsk = tsk;
+	return __audit_log_lsm_data(ac, &ad);
+}
+
+__bpf_kfunc int bpf_audit_log_net_sock(struct bpf_audit_context *ac, int netif,
+				       const struct socket *sock)
+{
+	struct lsm_network_audit net = { .sk = sock->sk, .netif = netif };
+	struct common_audit_data ad;
+
+	ad.type = LSM_AUDIT_DATA_NET;
+	ad.u.net = &net;
+	return __audit_log_lsm_data(ac, &ad);
+}
+
+__bpf_kfunc int
+bpf_audit_log_net_sockaddr(struct bpf_audit_context *ac, int netif,
+			   const struct sockaddr *saddr__nullable,
+			   const struct sockaddr *daddr__nullable, int addrlen)
+{
+	struct lsm_network_audit net;
+	struct common_audit_data ad;
+
+	net.netif = netif;
+
+	if (!saddr__nullable && !daddr__nullable)
+		return -EINVAL;
+
+	if (saddr__nullable && daddr__nullable &&
+	    saddr__nullable->sa_family != daddr__nullable->sa_family)
+		return -EINVAL;
+
+	if (saddr__nullable)
+		net.family = saddr__nullable->sa_family;
+	else
+		net.family = daddr__nullable->sa_family;
+
+	switch (net.family) {
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		if (addrlen < SIN6_LEN_RFC2133)
+			return -EINVAL;
+
+		if (saddr__nullable) {
+			struct sockaddr_in6 *saddr =
+				(struct sockaddr_in6 *)saddr__nullable;
+			net.fam.v6.saddr = saddr->sin6_addr;
+			net.sport = saddr->sin6_port;
+		}
+
+		if (daddr__nullable) {
+			struct sockaddr_in6 *daddr =
+				(struct sockaddr_in6 *)daddr__nullable;
+			net.fam.v6.daddr = daddr->sin6_addr;
+			net.dport = daddr->sin6_port;
+		}
+		break;
+#endif
+	case AF_INET:
+		if (addrlen < sizeof(struct sockaddr_in))
+			return -EINVAL;
+
+		if (saddr__nullable) {
+			struct sockaddr_in *saddr =
+				(struct sockaddr_in *)saddr__nullable;
+			net.fam.v4.saddr = saddr->sin_addr.s_addr;
+			net.sport = saddr->sin_port;
+		}
+
+		if (daddr__nullable) {
+			struct sockaddr_in *daddr =
+				(struct sockaddr_in *)daddr__nullable;
+			net.fam.v4.daddr = daddr->sin_addr.s_addr;
+			net.dport = daddr->sin_port;
+		}
+		break;
+	default:
+		return -EAFNOSUPPORT;
+	}
+
+	ad.type = LSM_AUDIT_DATA_NET;
+	ad.u.net = &net;
+	return __audit_log_lsm_data(ac, &ad);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(lsm_audit_set_ids)
+
+BTF_ID_FLAGS(func, bpf_audit_log_start,
+	     KF_ACQUIRE | KF_DESTRUCTIVE | KF_IMPLICIT_ARGS | KF_RET_NULL);
+
+BTF_ID_FLAGS(func, bpf_audit_log_end, KF_DESTRUCTIVE | KF_RELEASE);
+
+/* The following have a recursion opportunity if a LSM is attached to any of
+ * the following functions, and a bpf_audit_log_*() is called.
+ *  security_current_getlsmprop_subj,
+ *  security_lsmprop_to_secctx, or
+ *  security_release_secctx
+ */
+BTF_ID_FLAGS(func, bpf_audit_log_cause, KF_DESTRUCTIVE);
+BTF_ID_FLAGS(func, bpf_audit_log_cap, KF_DESTRUCTIVE);
+BTF_ID_FLAGS(func, bpf_audit_log_path, KF_DESTRUCTIVE);
+BTF_ID_FLAGS(func, bpf_audit_log_file, KF_DESTRUCTIVE);
+BTF_ID_FLAGS(func, bpf_audit_log_ioctl_op, KF_DESTRUCTIVE);
+BTF_ID_FLAGS(func, bpf_audit_log_dentry, KF_DESTRUCTIVE);
+BTF_ID_FLAGS(func, bpf_audit_log_inode, KF_DESTRUCTIVE);
+BTF_ID_FLAGS(func, bpf_audit_log_task, KF_DESTRUCTIVE);
+BTF_ID_FLAGS(func, bpf_audit_log_net_sock, KF_DESTRUCTIVE);
+BTF_ID_FLAGS(func, bpf_audit_log_net_sockaddr, KF_DESTRUCTIVE);
+
+BTF_KFUNCS_END(lsm_audit_set_ids)
+
+static int bpf_lsm_audit_kfuncs_filter(const struct bpf_prog *prog,
+				       u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&lsm_audit_set_ids, kfunc_id))
+		return 0;
+
+	return prog->type != BPF_PROG_TYPE_LSM ? -EACCES : 0;
+}
+
+static const struct btf_kfunc_id_set bpf_lsm_audit_set = {
+	.owner = THIS_MODULE,
+	.set = &lsm_audit_set_ids,
+	.filter = bpf_lsm_audit_kfuncs_filter,
+};
+
+static int lsm_audit_init_bpf(void)
+{
+	int ret;
+
+	ret = bpf_mem_alloc_init(&bpf_audit_context_ma,
+				 sizeof(struct bpf_audit_context), false);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+						 &bpf_lsm_audit_set);
+}
+
+late_initcall(lsm_audit_init_bpf)

-- 
2.43.0


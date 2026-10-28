Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194430;
	b=CfRjtlUewDUCpyygPY4QycRmCfFyoRiH9GengWp8jnEXJQSRnLfJ1bzmR0VOLPkRjC4H
	 Jvha+xDyk/pGu7SEDGFL+So3oYbJOxztUTAHEoTfl3LA0Fkfa8zpsuih2NGSFAiqHR1I6
	 DvTPfS6mU6nIPCeFOqt9EXDe/E4oLuhr9O65Pi939RBji8DX14UZmxSgTYhARIiq7a30T
	 7qTXN3FTf2ompeD7IoKby6tvd4etVyb8ZLXYuaHMjBV0JBz25zCnL3JOthZHro8tHUDDs
	 OnmeeMKGkX4P2b0nN7xXgq5qEe2wWDDOb2W8Re2VYgbkPa52J3EdybJKAnkvE7jk+Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5Gktc4fxUiUbyi4OC6QEacgpGkR7EGDsMwiLK6P1Grs=;
	b=fXhiqBfDTDVUyPsmf4Xx9sgb0udaPHfID1p/jwtGwwPQAMJZ0bgfU2PuTap4NtlC2lue
	 +G13jG+/3OGyulde/km20fGw27MWkbmRw5W4h4tJPB5Kkx0Mtun7CKINuKJICAoqHxbvX
	 whbVEXT9ubAjuuAMe54VJafnl44wxttzteYs0BfnoEEn3V3UPTExuH6+fd4XdA90oXWLd
	 XzupsvUuEljMxk7Qt6lJXNaLKW7afMGdOMEIBAbkDXmYQ+rVuiM1A6gBOZwTUEUuwDQAg
	 UaAzz/xYjnHFzhiveQsvy4V3RGEUcqU5/KfmwIbqZM2nxbtrh7Go8i0NqxubLCQrteQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=B91Aa6u7;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68D060A260C
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 13:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E68D060A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=B91Aa6u7
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b0a921ee46so8525337b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1793194429; x=1793799229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Gktc4fxUiUbyi4OC6QEacgpGkR7EGDsMwiLK6P1Grs=;
        b=B91Aa6u79uDzBTZQoJ4nI5PWEdog/sk7iPSmqLj0Ds0uOhiy1nZHi4jArsHgdLZ+we
         ML9JIYIXWsC1Yc8PaywyqFJfkjzxt9Rs/PCvH5sN8jYvnDm1uFNpo/H1Fz81yeaKg/iy
         lAONHkIUrZZZDINr68gcvgPSRIsPXOsnOmpaofi10nLSW7CjY9rr6rn8MyZFYf8iCf63
         /GgaGuUmCkE6+g0ivR5kmjIl4MgEtsnkwOyqG7WzO8QWHkAjuJRcbjJERJgFydEF2qCZ
         1kaJ4Pyk3fzy7ZDy45PsDEPoFAkuJtPuAuisDM60jP2EmZaV3dvEWlnxGolvEyzoCHFC
         ng8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194429; x=1793799229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Gktc4fxUiUbyi4OC6QEacgpGkR7EGDsMwiLK6P1Grs=;
        b=tCPny94hmnmNFC39ABbrW2smv3gqBXcAGESKOVm+Z88ZxeA28WRui3FWYSjGv6nxVl
         lpZPNu5F1y8eswJ7bA0vTtKXrkdjrcTi5sW+pei1as5i94JXYFoGvYJKtKpECdLVT4e8
         xWbCLB1O8zqM5SnL50v76FFGftw2QfmpxfdNyVKdr/+508hixv/d/R0aezpduAhg8m26
         dynXn+/LIe3940Tjjfb4D7eby/uDLlwBOsBfe9UPz5ZGizH+Ery/AXzvTgBMs7Sry+1c
         be53GHy6xL0AsohdKQRYYAJZDD+5WegVh7k5pDaCPY+5Fs24JJaZVZSRPcH6qLpzkbd1
         I3UA==
X-Gm-Message-State: AFq9FYINXXwcpgYNR52Z5zyId82UJ5aiiFzMmXnvGhk9n/OeE1X8cor1
	mNhGPWRiGYlHBhvTxTkcBNK7c22Fi0UCL3avh9O0K54Waz/QrymAATqsaTOaToQzEVpQ
X-Gm-Gg: AYBFou2wYMtCxfF4VY5hmrOn+2dTaM12Kz0bEZcz/xYm/A5jXUdTt+kmxjl9deuI/kz
	PvW+Y8EuxG6QOGGqXFM3cFRPoK2pzZ0nNDSZiaQVl5MchwX/26DTlsFCTSHN6RYsCmPQ6d32iyO
	kQd+tfs10oACA5QdPb/boGzYViUeFZFkJEgun812Wb/gXqvN3LYcuDZj6x6cGrqnjJM4+Zeo+mo
	ljYSGijM5TjVsAi5PfzeA0Kt6o13KDZqdL6uSS6a/8XhWTd7+Z+XxHD8VVhUul6viERaD6rdqiJ
	9RicH2Li+oAXM1YT2jlzZphieEtbdjQaqGEmXApUSKl76XiF9eMSgaToZ2ekM8yxCCTK/mwR2SN
	euHOZVnlb6rbAC3s2/seVfQllGRzS1onTcDRcGQ/Anwlz3VYRc6TFrnOL5JpeenxOuuIedOhoyz
	P0hJNmFhlIjCLUyPqKc505HZY/PvGae2qg7ZmAhQzYHzUQvROIQqwuZi+KUzJvFt2az8bicv/ZH
	oiiUF7ZuSf8xr1gWJBDR2AoM/4z11TNnc9/LPb+PZfzCVeGK4qrLUtlErNTlo2t22vo6UWETMTh
	osr9X8TbhkDy8Gx+5w7F9jUYyd/6UzkkYgvhCPwfmukyJygQzYPMBdCjbgdkppc4UVha8AdpB1X
	EoYp1IZSXsqaPq75ulL7E7LYdkgC84P1PLawD7LZvbKFSIuA=
X-Received: by 2002:a05:690c:832:b0:8b0:e238:271c with SMTP id 00721157ae682-8b1b5c885f2mr9630557b3.27.1793194428780;
        Wed, 28 Oct 2026 06:33:48 -0700 (PDT)
Received: from CC-KJQTV599DQ.attlocal.net ([2600:1702:7b5a:ab90:103d:30e1:1f09:a9ae])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a79f38dfesm1694911d50.1.2026.10.28.06.33.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 06:33:48 -0700 (PDT)
From: Ketan Bhardwaj <ketan@armoriq.io>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-kernel@vger.kernel.org,
	"HARIHARA SUDHAN . R" <harisudhan@armoriq.io>,
	Ketan Bhardwaj <ketan@armoriq.io>
Subject: [RFC PATCH v2 2/6] security: kap: add the LSM ID and internal headers
Date: Wed, 28 Oct 2026 09:33:31 -0400
Message-ID: <20261028133335.75899-3-ketan@armoriq.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261028133335.75899-1-ketan@armoriq.io>
References: <20261028133335.75899-1-ketan@armoriq.io>
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

Reserve an LSM ID for KAP and add the declarations its files share.

The ID is the next free value in the target tree. It is provisional
and is for the LSM maintainers to confirm.

Assisted-by: Claude
Co-developed-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
Assisted-by: Codex
Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>
---
 include/linux/kap.h      |  16 ++++
 include/uapi/linux/lsm.h |   1 +
 security/kap/kap.h       | 159 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 include/linux/kap.h
 create mode 100644 security/kap/kap.h

diff --git a/include/linux/kap.h b/include/linux/kap.h
new file mode 100644
index 0000000..8d11d20
--- /dev/null
+++ b/include/linux/kap.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KAP_H
+#define _LINUX_KAP_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_SECURITY_KAP
+int kap_check_namespace_flags(unsigned long flags, const char *operation);
+#else
+static inline int kap_check_namespace_flags(unsigned long flags, const char *operation)
+{
+	return 0;
+}
+#endif
+
+#endif /* _LINUX_KAP_H */
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 938593d..7cb3d64 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -65,6 +65,7 @@ struct lsm_ctx {
 #define LSM_ID_IMA		111
 #define LSM_ID_EVM		112
 #define LSM_ID_IPE		113
+#define LSM_ID_KAP		114
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/kap/kap.h b/security/kap/kap.h
new file mode 100644
index 0000000..14cfe4d
--- /dev/null
+++ b/security/kap/kap.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SECURITY_KAP_H
+#define _SECURITY_KAP_H
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#define KAP_TASK_IGROUP_NAME_LEN 64
+
+struct dentry;
+struct task_struct;
+
+enum kap_hook_kind {
+	KAP_HOOK_EXEC,
+	KAP_HOOK_FILE,
+	KAP_HOOK_SOCKET_CONNECT,
+	KAP_HOOK_CRED,
+	KAP_HOOK_IPC,
+	KAP_HOOK_NAMESPACE,
+	KAP_HOOK_DESCRIPTOR,
+	KAP_HOOK_BPF,
+	KAP_HOOK_PTRACE,
+	KAP_HOOK_PROCFS,
+	KAP_HOOK_EXECMEM,
+	KAP_HOOK_IO_URING,
+	KAP_HOOK_LAST = KAP_HOOK_IO_URING,
+};
+
+struct kap_task_state {
+	bool active;
+	u64 epoch;
+	char igroup_name[KAP_TASK_IGROUP_NAME_LEN];
+};
+
+struct kap_task_state *kap_task_state(struct task_struct *task);
+bool kap_fail_closed_kind(enum kap_hook_kind kind);
+int kap_check_current_target_why(enum kap_hook_kind kind, const char *target,
+				 const char **why);
+int kap_check_current_emit(enum kap_hook_kind kind, const void *object,
+			   const char *deny_reason, const char *allow_reason);
+int kap_check_current_target_emit(enum kap_hook_kind kind, const char *target,
+				  const char *deny_reason, const char *allow_reason);
+void kap_emit_current_event_target(enum kap_hook_kind kind, int decision,
+				   const char *reason, const char *target);
+
+/* Shared between the policy engine (igroup.c) and the control plane (kapfs.c). */
+#define KAP_MAX_NAME_LEN 63
+#define KAP_MAX_ROOT_LEN 64
+#define KAP_MAX_PREDICATE_BYTES 65536
+#define KAP_MAX_EVENTS_BYTES 65536
+/* The install document is the authority plus a few short header lines. */
+#define KAP_MAX_INSTALL_BYTES (KAP_MAX_PREDICATE_BYTES + 1024)
+
+enum kap_file_kind {
+	KAP_FILE_PROCS,
+	KAP_FILE_IGFD,
+	KAP_FILE_LINEAGE_ROOT,
+	KAP_FILE_AUTHORITY_EPOCH,
+	KAP_FILE_AUTHORITY,
+	KAP_FILE_TRANSITION,
+	KAP_FILE_MODE,
+	KAP_FILE_EVENTS,
+	KAP_FILE_EXPIRES_AT,
+	KAP_FILE_INSTALL,
+	KAP_FILE_COUNT,
+	/* Filesystem-wide, not created per igroup, so it sits past the count. */
+	KAP_FILE_DEFAULT = KAP_FILE_COUNT,
+};
+
+struct kap_igroup;
+
+struct kap_file_ctx {
+	enum kap_file_kind kind;
+	struct kap_igroup *igroup;
+};
+
+struct kap_bound_pid {
+	pid_t pid;
+	struct list_head node;
+};
+
+/*
+ * Predicates are compiled once at install, so a decision only walks an array.
+ * Patterns are interned into one pool and referenced by offset, so the whole
+ * thing is a flat allocation and a decision allocates nothing.
+ *
+ * The pool is sized to the authority document itself, so any document that is
+ * accepted can be compiled: a pattern costs strlen + 1 here and at least
+ * strlen + 2 in the document because of its surrounding quotes. Each set's
+ * patterns are laid out contiguously and walked by length, so there is no
+ * per-set entry limit either.
+ */
+struct kap_pattern_set {
+	u32 offset;
+	u32 count;
+};
+
+struct kap_compiled_authority {
+	char pool[KAP_MAX_PREDICATE_BYTES];
+	u32 pool_used;
+	struct kap_pattern_set allow[KAP_HOOK_LAST + 1];
+	struct kap_pattern_set deny[KAP_HOOK_LAST + 1];
+};
+
+struct kap_igroup {
+	char name[KAP_MAX_NAME_LEN + 1];
+	u64 epoch;
+	bool revoked;
+	bool has_sequence;
+	u64 last_sequence;
+	char lineage_root[KAP_MAX_ROOT_LEN + 1];
+	char authority[KAP_MAX_PREDICATE_BYTES];
+	size_t authority_len;
+	/* Expiry in Unix seconds, 0 for none. */
+	u64 expires_at;
+	/* Swapped wholesale on a successful install; NULL until the first one. */
+	struct kap_compiled_authority *compiled;
+	char events[KAP_MAX_EVENTS_BYTES];
+	size_t events_len;
+	struct kap_file_ctx files[KAP_FILE_COUNT];
+	struct list_head pids;
+	struct list_head node;
+	struct dentry *dentry;
+};
+
+struct kap_install_request {
+	char lineage_root[KAP_MAX_ROOT_LEN + 1];
+	u64 epoch;
+	u64 expires_at;
+	u64 sequence;
+	/* Points into the caller's buffer, which outlives this request. */
+	const char *authority;
+	bool have_root;
+	bool have_epoch;
+	bool have_expires_at;
+	bool have_transition;
+	bool have_authority;
+};
+
+extern struct list_head kap_igroups;
+extern spinlock_t kap_lock;
+extern bool kap_lsm_active;
+extern bool kap_ready;
+extern bool kap_default_closed;
+
+struct kap_igroup *kap_find_igroup_locked(const char *name);
+int kap_bind_pid_locked(struct kap_igroup *igroup, pid_t pid,
+			struct kap_bound_pid **entry);
+int kap_parse_transition_sequence(const char *payload, u64 *sequence);
+int kap_install_parse(char *payload, struct kap_install_request *req);
+int kap_authority_prepare(const char *doc, struct kap_compiled_authority **out);
+int kap_install_locked(struct kap_igroup *igroup,
+		       const struct kap_install_request *req,
+		       struct kap_compiled_authority **compiled);
+void kap_trim_newline(char *value);
+int kap_securityfs_init(void);
+
+#endif /* _SECURITY_KAP_H */
-- 
2.51.0


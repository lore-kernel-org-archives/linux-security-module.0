Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923480;
	b=NuZibn1Vcw3naZ+N8ut0BNiYf0qPo+ESGS/85KWsus+5y2n0txQYGMeNdf9H+w5h9iqq
	 8GJBrsKK5zJ2GICvrWhsje/DzeU+oHBEoDLcxWQw8KIvqfoTiAwEaEN3oCJoxyi1g575R
	 iy+nzVVD4xpIFsPUfWV2N/G8iN9en9p5dfvjxTIPcUoushgpcWqQpa6qvcGR0X4TA0y2F
	 KSiJqKxV8juyM+akGbsYcYLDNJg8rd0GCuchlQzuK9T3n0FJhgeLLUmGQzopyYZbe+TRS
	 1NS/T/OZFQp9J+3p00a8b/OhARy4ptSmgUJBczCR8qNOv9/WTRJFR8yqJ5/WOdjdEEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923480;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JANj6/ttEGWoJIxAqnmqmvDr+UKTFLdepsSWLcZQG3c=;
	b=OtD9xHIKfPGFJKCksZfv9+sn3uJ6+XFciyOow4efX06qaL3BjggI/iuEN7/bLdPGy3Mr
	 YKbLsktzN4GMfS3VJTDE0/6fA+xDaRNws5re2+olP00ZaaBzVqfa2AulmaMy7swLRGLum
	 ACtBVTB1xJnY1Pc560cd1namp+ISoFODIkJ0vRsx4zkuy7oRJywIrO9ZyHHRc0Mi61oA5
	 oNivvr7UzdPehWL1NdEnWwXgoocU/6YLaNrBOwIUWQC/w8BBRJ/dFZNx4GWhdkECgAWdw
	 nsk+BM4LH6yJKvX6xFc4MemaEFGm9KacfM6X9LUdQhpNO2mhBBeF6KPNG6+CPYbL8lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Zfh3LSEO;
	arc=none smtp.remote-ip=185.125.188.120
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2238606A323
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 13:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2238606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Zfh3LSEO
Received: from sec-questing-amd64 (lfbn-idf3-1-218-1.w90-22.abo.wanadoo.fr [90.22.217.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 42C3242CDF;
	Tue, 17 Nov 2026 13:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1794923478;
	bh=JANj6/ttEGWoJIxAqnmqmvDr+UKTFLdepsSWLcZQG3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=Zfh3LSEOOiaXYhjME2x5T0fFli70j/6a0V9eIZCzOiAkJW0Itl8zTeekRH79pdRhS
	 HQ4/IWtsgHMHY5z6s7ZcMI43bWNJY4vlFgAH3X2Y1uo2aQhY9BOKwoSbLbofvZSKyL
	 qgdNBcsAa5AflhBbiRV4KYs/g5fd3ggnzsM9jzHfjM9TVVCJsy7NcCt8e4/g3kvmQ1
	 34fTIhNQEaHWQnpkFydwvML4Djzddu4KQdOqjprIs5k+uVAZzOdCRz3z62iu1cuj5M
	 p6hKsnQsdhy7kT0Xg50HFrsZdUDzp4TdhATju7/YULPjfbEjlCeZND18daRzXIn9o3
	 cy915iLKkbjUSO7Vs1+xbrpCmUEohqXaeWLT/2FHOFXExbMhbdtUv1WWrVkJVyyUea
	 oMkvBM8otHeaPQZ+3bFijMakSqQLSn4oE0lpaX6zaQL+CRNrFMYzpe2a+7TOEYnnvx
	 eWvVr5+GP+Lf0uiADaqse4q3gxZk9DnuYUAebEE3uSmUz0fmWKohgNrhQBz00tGeyH
	 sajLPNIv4FClpq8kwQ2RrWOOiACaMdmlbBqqNje1IrYPclcGh0+NqJ50g/RhEutEM7
	 4/ExwzplUV3V+Rp8XnUHgxIg7DkJUyGorLF8QZALvMFcViaN3sDr5hLFGOvKqXF8FQ
	 wLeVBVbM7K0vxxDWx1kRLuIk=
From: =?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH 3/4] apparmor: write the feature set to a file at build time
Date: Tue, 17 Nov 2026 14:50:09 +0100
Message-ID: <20261117135042.78238-4-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261117135042.78238-1-maxime.belair@canonical.com>
References: <20261117135042.78238-1-maxime.belair@canonical.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

apparmor_parser compiles policy for the feature set of the kernel,
which libapparmor reads from /sys/kernel/security/apparmor/features,
and the policy cache is keyed on that set. The cache for a kernel can
therefore only be filled once that kernel runs, and the first boot
into a kernel with a new feature set compiles all of the policy.

Every entry of the features directory comes from a static table of
constants. So write the set to security/apparmor/features when the
kernel is built, in the format that libapparmor flattens the directory
to. Policy can then be compiled when a kernel is installed:

  apparmor_parser --kernel-features=<file> ...

Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 security/apparmor/.gitignore         |   2 +
 security/apparmor/Makefile           |  15 ++++
 security/apparmor/apparmorfs.c       |   1 +
 security/apparmor/gen_features.c     | 100 +++++++++++++++++++++++++++
 security/apparmor/include/features.h |   5 +-
 5 files changed, 121 insertions(+), 2 deletions(-)
 create mode 100644 security/apparmor/gen_features.c

diff --git a/security/apparmor/.gitignore b/security/apparmor/.gitignore
index 921cc7c3e835..ff816ca0f22b 100644
--- a/security/apparmor/.gitignore
+++ b/security/apparmor/.gitignore
@@ -3,3 +3,5 @@ net_names.h
 capability_names.h
 rlim_names.h
 feature_masks.h
+/features
+/gen_features
diff --git a/security/apparmor/Makefile b/security/apparmor/Makefile
index 7d20a09cb116..400655ec78a3 100644
--- a/security/apparmor/Makefile
+++ b/security/apparmor/Makefile
@@ -102,6 +102,21 @@ cmd_make-rlim = echo "static const char *const rlim_names[RLIM_NLIMITS] = {" \
 quiet_cmd_make-masks = GEN     $@
 cmd_make-masks = grep -h '^\#define AA_SFS_' $(filter %.h,$^) > $@
 
+# Write the feature set to a file, with a host program that is built from the
+# feature tables. It needs the kernel configuration, and -idirafter keeps the
+# other kernel headers behind the ones of the host.
+hostprogs := gen_features
+HOSTCFLAGS_gen_features.o := -include $(srctree)/include/linux/kconfig.h \
+			     -idirafter $(objtree)/include
+always-y += features
+
+quiet_cmd_gen_features = GEN     $@
+      cmd_gen_features = $< > $@
+
+$(obj)/features: $(obj)/gen_features FORCE
+	$(call if_changed,gen_features)
+
+$(obj)/gen_features : $(obj)/feature_masks.h
 $(obj)/apparmorfs.o : $(obj)/feature_masks.h
 $(obj)/capability.o : $(obj)/capability_names.h
 $(obj)/net.o : $(obj)/net_names.h
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 4ca449b108df..b897d2840d77 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1255,6 +1255,7 @@ static const struct file_operations aa_sfs_access = {
 	.llseek		= generic_file_llseek,
 };
 
+/* gen_features.c prints the same values at build time, keep them in sync */
 static int aa_sfs_seq_show(struct seq_file *seq, void *v)
 {
 	struct aa_sfs_entry *fs_file = seq->private;
diff --git a/security/apparmor/gen_features.c b/security/apparmor/gen_features.c
new file mode 100644
index 000000000000..978a1b06ab4b
--- /dev/null
+++ b/security/apparmor/gen_features.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AppArmor security module
+ *
+ * This program writes the feature set of the kernel that is being built, the
+ * way libapparmor flattens /sys/kernel/security/apparmor/features on the
+ * running kernel. The policy cache is keyed on it, so the output has to be
+ * the same byte for byte: the entries of a directory in the strcmp() order of
+ * their names, each as
+ *
+ *	<name> {<entries of the directory>}\n
+ *	<name> {<content of the file>}\n
+ *
+ * Copyright 2026 Canonical Ltd.
+ */
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+enum aa_sfs_type {
+	AA_SFS_TYPE_BOOLEAN,
+	AA_SFS_TYPE_STRING,
+	AA_SFS_TYPE_U64,
+	AA_SFS_TYPE_DIR,
+};
+
+/* The members of the kernel's struct aa_sfs_entry that the tables set */
+struct aa_sfs_entry {
+	const char *name;
+	enum aa_sfs_type v_type;
+	union {
+		bool boolean;
+		const char *string;
+		unsigned long u64;
+		struct aa_sfs_entry *files;
+	} v;
+};
+
+#define AA_SFS_FILE_BOOLEAN(_name, _value) \
+	{ .name = (_name), .v_type = AA_SFS_TYPE_BOOLEAN, .v.boolean = (_value) }
+#define AA_SFS_FILE_STRING(_name, _value) \
+	{ .name = (_name), .v_type = AA_SFS_TYPE_STRING, .v.string = (_value) }
+#define AA_SFS_FILE_U64(_name, _value) \
+	{ .name = (_name), .v_type = AA_SFS_TYPE_U64, .v.u64 = (_value) }
+#define AA_SFS_DIR(_name, _value) \
+	{ .name = (_name), .v_type = AA_SFS_TYPE_DIR, .v.files = (_value) }
+
+#include "feature_masks.h"
+#include "include/features.h"
+
+static int cmp_entries(const void *a, const void *b)
+{
+	const struct aa_sfs_entry *x = a, *y = b;
+
+	return strcmp(x->name, y->name);
+}
+
+static void print_dir(struct aa_sfs_entry *dir)
+{
+	struct aa_sfs_entry *entry;
+	size_t count = 0;
+
+	while (dir[count].name)
+		count++;
+
+	qsort(dir, count, sizeof(*dir), cmp_entries);
+
+	for (entry = dir; entry->name; entry++) {
+		/* libapparmor skips these */
+		if (entry->name[0] == '.')
+			continue;
+
+		printf("%s {", entry->name);
+		switch (entry->v_type) {
+		case AA_SFS_TYPE_BOOLEAN:
+			printf("%s\n", entry->v.boolean ? "yes" : "no");
+			break;
+		case AA_SFS_TYPE_STRING:
+			printf("%s\n", entry->v.string);
+			break;
+		case AA_SFS_TYPE_U64:
+			/* "%#08lx" in the kernel, which prints 0x for 0 too */
+			printf("0x%06lx\n", entry->v.u64);
+			break;
+		case AA_SFS_TYPE_DIR:
+			print_dir(entry->v.files);
+			break;
+		}
+		printf("}\n");
+	}
+}
+
+int main(void)
+{
+	print_dir(aa_sfs_entry_features);
+
+	return fflush(stdout) || ferror(stdout);
+}
diff --git a/security/apparmor/include/features.h b/security/apparmor/include/features.h
index dc38f54abec6..aadd8391ae9a 100644
--- a/security/apparmor/include/features.h
+++ b/security/apparmor/include/features.h
@@ -3,8 +3,9 @@
  * AppArmor security module
  *
  * This file contains the tables behind the securityfs features directory,
- * /sys/kernel/security/apparmor/features. It defines them, so it is for
- * apparmorfs.c alone.
+ * /sys/kernel/security/apparmor/features. It defines them, for apparmorfs.c
+ * and for the host program gen_features.c, so it cannot depend on kernel
+ * headers.
  *
  * Copyright (C) 1998-2008 Novell/SUSE
  * Copyright 2009-2026 Canonical Ltd.
-- 
2.51.0


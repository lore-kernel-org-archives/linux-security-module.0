Received: from a3-9.smtp-out.eu-west-1.amazonses.com (a3-9.smtp-out.eu-west-1.amazonses.com [54.240.3.9])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5C419DF6A;
	Wed, 11 Mar 2026 05:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.3.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205747; cv=none; b=pOOlrIc9Db1t5TCS2MCcdw7CMVDpwAQo/Qy+JcmUI+iO8KPGWkYJOaid0alPQqZ9PWBtA1dH0aqfVh8N3rxMv2EThkestubv1LewoYZdL0H9csFGtqi7YAiRrAiciRt3SPNlBg1vQdi95g4IRDCa22A6qiLhn0sZZqZjNZadrg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205747; c=relaxed/simple;
	bh=P7rVdnPdbCXKsFc2cCPCTOaLY3LDb+jTcPGF/C+NoOc=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=OAr2BKm62jqaZvjgsqCw4SS9UNz9XrmMxHKSzDh+Thq2AqK/YIZ8ZoEMr2r+FAJN3r7OzFkhrMplrm09WgoCv/zi6yGRtmSzvC+S6ePzgOoDicvPF5lbwxt5yNesyVmxZ4Mko4G1aQQqAHgzLQ0Lq8GcAo4W4pWgYdG/WcURk2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com; spf=pass smtp.mailfrom=send.matrixforgelabs.com; dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b=lNp7fLi/; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=og3D1APZ; arc=none smtp.client-ip=54.240.3.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b="lNp7fLi/";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="og3D1APZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=matrixforgelabs.com; t=1773205744;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=P7rVdnPdbCXKsFc2cCPCTOaLY3LDb+jTcPGF/C+NoOc=;
	b=lNp7fLi/XkATEnWyJnoan5MR5WpwEtbciyAYr9yXwHxvhXsGTMzzmO2SM5ItNxb5
	HwDM8h16sOceQII0/ogZq0xNGKVV43rQmlN3sD9WfG95m4tTF2gd0RnsBtrSSyFHFRs
	0nsFXwo1xhAWqM/zx6GUwNCMwYCuwye6jW9Uo2H0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1773205744;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=P7rVdnPdbCXKsFc2cCPCTOaLY3LDb+jTcPGF/C+NoOc=;
	b=og3D1APZtaz7OPNQyQc+WLUje0KVnGqqv8eDbP+T/pJBA7FglXKfj2rRjVJuXszE
	2G07dXWa91Mmm1RFGgd/LauqCYvl+D/YWKMf0Bj7Xaa5bF0v5hRSbxKQrF8aAaCFaoJ
	Zvp+0EU+kY0dqccrZ1sZCreVSaKYap65rLcZKT2o=
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311050854.657422-1-jamie@matrixforgelabs.com>
References: <20260311050854.657422-1-jamie@matrixforgelabs.com>
From: Jamie Lindsey <jamie@matrixforgelabs.com>
To: rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	jmorris@namei.org, serge@hallyn.com, jamie@matrixforgelabs.com
Subject: [PATCH v2 2/5] rust: helpers: add C shims for LSM hook
 initialisation
Message-ID: <0102019cdb4c6a42-a28bbebb-3664-4792-966f-4036c94ac19c-000000@eu-west-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2026 05:09:04 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.eu-west-1.dUvNRtpqGVRXeo8wh60CXsl7GQehaaQ6nnrtD0cVQa3Ql6wtvHFwU/L0ElxknTtyiIJqbukn1OjAm5wWeKC4/L/mSl4kXjXWbCD+H4nPl2leK4flNX+koNzOtq4VJ309U1FPreISQBpCbnqANIVuwUyneL8ocSNAtI9Qxd/4vCM=:1.eu-west-1.xc5b6Z4+0WlftYwtQHAHsTtsfYdZQImSOXWypZD9BdY=:AmazonSES
X-SES-Outgoing: 2026.03.11-54.240.3.9

struct security_hook_list carries __randomize_layout, making its fields
inaccessible to Rust code (bindgen sees the natural field order, which
may differ when CONFIG_RANDSTRUCT is active).  Add thin C wrapper
functions that call LSM_HOOK_INIT() =E2=80=94 the existing C macro that =
handles
the randomised layout correctly =E2=80=94 so that Rust can populate=
 hook slots
without touching struct fields directly.

Three hook shims are provided (file_open, task_alloc, task_free) plus a
wrapper for security_add_hooks() which is __init and must carry that
annotation to ensure correct placement in the init text section.

Hook signatures verified against union security_list_options generated
from lsm_hook_defs.h: all three match exactly, including u64 for
task_alloc's clone_flags parameter (not unsigned long).

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Jamie Lindsey =
<jamie@matrixforgelabs.com>
---
 rust/helpers/helpers.c |  1 +
 rust/helpers/lsm.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 rust/helpers/lsm.c

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index a3c42e51f00a..c496917be073 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -35,6 +35,7 @@
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
+#include "lsm.c"
 #include "maple_tree.c"
 #include "mm.c"
 #include "mutex.c"
diff --git a/rust/helpers/lsm.c b/rust/helpers/lsm.c
new file mode 100644
index 000000000000..fb475428fd0d
--- /dev/null
+++ b/rust/helpers/lsm.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/lsm_hooks.h>
+
+/*
+ * Hook list initializers.
+ *
+ * struct security_hook_list carries __randomize_layout, so its fields =
must
+ * never be set by Rust code directly (bindgen sees only the =
"natural" field
+ * order, which may differ when CONFIG_RANDSTRUCT is =
enabled).  These helpers
+ * wrap LSM_HOOK_INIT(), the C macro the kernel =
already uses for this purpose,
+ * so that Rust can safely obtain an =
initialised security_hook_list without
+ * ever touching the struct's =
fields directly.
+ */
+
+__rust_helper void
+rust_helper_lsm_hook_init_file=
_open(struct security_hook_list *hl,
+				    int (*fn)(struct file *))
+{
+	*hl =3D (struct security_hook_list)LSM_HOOK_INIT(file_open, fn);
+}
+
+__rust_helper void
+rust_helper_lsm_hook_init_task_alloc(struct =
security_hook_list *hl,
+				     int (*fn)(struct task_struct *, u64))
+{
+	*hl =3D (struct security_hook_list)LSM_HOOK_INIT(task_alloc, fn);
+}
+
+__rust_helper void
+rust_helper_lsm_hook_init_task_free(struct =
security_hook_list *hl,
+				    void (*fn)(struct task_struct *))
+{
+	*hl =3D (struct security_hook_list)LSM_HOOK_INIT(task_free, fn);
+}
+
+/*
+ * security_add_hooks() is __init =E2=80=94 it installs callbacks into the=
 static-call
+ * table and must only be called during kernel initialisation=
.  This wrapper
+ * keeps the __init annotation so the linker places it =
alongside the rest of
+ * the init text, and Rust callers invoke it only =
from their own __init path
+ * (the lsm_info.init callback).
+ */
+void __init
+rust_helper_security_add_hooks(struct security_hook_list =
*hooks, int count,
+			       const struct lsm_id *lsmid)
+{
+	security_add_hooks(hooks, count, lsmid);
+}
--=20
2.53.0


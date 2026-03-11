Received: from a3-9.smtp-out.eu-west-1.amazonses.com (a3-9.smtp-out.eu-west-1.amazonses.com [54.240.3.9])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6459282F24;
	Wed, 11 Mar 2026 04:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.3.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773204972; cv=none; b=rgUgMlnfon0exZhJt8I6Wf7E9BKacj+/O9L14eY/W/j2SsnqVDbE5ExTtcNDFc/oswWykLRRSpvvtKHJbUMvBc2WnRyYASbObYffoBXntlO81caNBsMmfy6LtxZlR4D2O7GitmLa9uuLXHd3m7whQFE0rn3J51mk5CSaowkt0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773204972; c=relaxed/simple;
	bh=uJV2zz/ducVoPkYFB1yle8WiBdW8UanZOO7frgI+WDU=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=aCXdFNMgpLZ8Zq4UR2+s8Nnpm0Mjogkx44OpIgPg6YTzNXTqxhGZyua4AxGw6E3imFzUP8OCumSePbC5XPWJIMNKnwBttjav3G3yGHNxACMDET4rWO9pCZKT/mC6Zc+crbq6++dujxmKtBJNXZ7FLjV5W+Emv0q1JBpwWzDlEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com; spf=pass smtp.mailfrom=send.matrixforgelabs.com; dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b=D5D93veQ; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=EjzwuL3J; arc=none smtp.client-ip=54.240.3.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b="D5D93veQ";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="EjzwuL3J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=matrixforgelabs.com; t=1773204969;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=uJV2zz/ducVoPkYFB1yle8WiBdW8UanZOO7frgI+WDU=;
	b=D5D93veQzhi55U96tMOVxACBDcl016KFc0TzCYELjBRDiJUZKdnk3ybOqWsoVGE+
	dZ9qmzbMPe0B1TuGS5p5MEfTIQE2YG+9dm61KsfN6dJGYIDMaNbdx3XPKl/HocDJabC
	A3iFK+s7L9XMQcShxtHLI4RcVVr/XGrSZPZolako=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1773204969;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=uJV2zz/ducVoPkYFB1yle8WiBdW8UanZOO7frgI+WDU=;
	b=EjzwuL3JUVD/4VspM3nQ8b9pc2UuHg3YerhP3i1P3w6Xj5QG6/pGf/SLn6iFKeAO
	mp5tCOvT56rSdoNEuvMoP1cni8FLtIntUUfY7nlo78r+Ayv+NPU+2eBFBi52RhbSqwX
	48steTD/KU+1v4j7HA6VPlj4AlgO+sUlYFBrOF8s=
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311045601.649904-1-jamie@matrixforgelabs.com>
References: <20260311045601.649904-1-jamie@matrixforgelabs.com>
From: Jamie Lindsey <jamie@matrixforgelabs.com>
To: rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	jmorris@namei.org, serge@hallyn.com, jamie@matrixforgelabs.com
Subject: [PATCH 2/5] rust: helpers: add C shims for LSM hook initialisation
Message-ID: <0102019cdb409740-bfddbbc2-a142-4e0c-99e7-5fa80ba23858-000000@eu-west-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2026 04:56:09 +0000
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


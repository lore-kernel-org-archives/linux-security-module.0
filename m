Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82443C1411
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982676; cv=none; b=n6O0ij3sBQEchahOSZfusTA17n+60JOiJxpeJp1qK9nDeo7HIVelgHh0r0mgfYVG9BtYeaoZxTlqyODeYjQChHRmYxfBybDHzYsTG/FmiegopdIDfSZbbUlgoTiozc5zCyvPsdtxlbKz900cNzCpE2O9E3xESaHzolLEhKeVo20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982676; c=relaxed/simple;
	bh=5JeaYKVSzKXAX/sgZsANqhlDhCRYedCYJj80Zm93r/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EI6X+A4T9WMe+s1WXmrEzs7z0fbUR9j6CELTnG37wYKlrSDbo6AWvw8cYdCnIG/2kONHg+GfjPkWyxWplpEAK7wXNkvKiOtmQCqYiUDDh5eOYvFM1ZAoPIArdJKOZD6JO6DqKx13bzdFnKV/bSGJyzTlIOXNZ1XgDNPUJY0kt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIId4AkZ; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIId4AkZ"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcaso14469687b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 12:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982672; x=1789587472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F6UQVnWZ6sTXYVTmbh7VH9y6ww3yNiInSoSyLyLDAvU=;
        b=OIId4AkZstPKXJVDjd4u2DZy7RqEwTgJ3fDQGoGniYfF7jN70SB1tifbY/sLGHP/Gy
         FZyah/11agw+U3lH9fhANZC/0CyA7EMOk0UL/dGZxGWUB9MNBBhsiocrhjeOzCJ/qZHW
         oWc4sKx7mgtcfWLtTg43oqSLeZu2Pclz+BTruKttyXwFGc0XTW4KHCjz4OsOsph7jIVv
         JVLqdOZNu5RpPrntaLMdo9lCTCOSQbdDS+IR3fJB5ZDCUO1z5wny3RzDEkuB93DR93KO
         +jrVX7GDkgqLNsOPzpFKloqILgCLEeU9/hAngMM9h/pYDPkCYCI79A1F4Zg3W/j8RlKu
         nl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982672; x=1789587472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F6UQVnWZ6sTXYVTmbh7VH9y6ww3yNiInSoSyLyLDAvU=;
        b=s35vhwad6g18pF7JOaQaeW8SGd3pV6mbNICYVJcsMDKaTnsH8SO2t/6dnRKvSZUo6C
         qkbF2wukPA6lWyyO9wNjNsBA/PFb66MmZz8IT1O7qci2ZmUgWei0qkKfzQHwBCY/hVCt
         NNqp7v5tVDf/HZYlRSXVX9mNsoPeipIlnc8DCY6kDpG6Bpc8xWwxDDVt/9nLtHtupJOn
         xPS5l5evs/loUyZUrgMi5ZKfVX9LlPbE2GYkQkEA8Qw/cfyJwQ8VV29mMCBcsUBc9gRE
         WpuY7vXLPJYGK5q656DwcHFuevOhMjdbU6u8/cI94D6fOc6zOVI6QOqKW5rg/GDILSdb
         OGHA==
X-Forwarded-Encrypted: i=1; AKwUvBytJq0aAKd8E1IZxvk3wikjSC/xoz9LnM1vUr0Z+z8CUZoK1JnZJLkHhdyxWsEzS1m9eCYh3NpBSYm5lyP9gmusx1p4Sd8=@vger.kernel.org
X-Gm-Message-State: AFuF++lKBrNAdIPxthd2ABWPCBWLOCmAi1nlZq6Ptp+4UhKB4uxytgaW
	pSEf/QK6v4COFrrDLYDgThBwRh1xB5GdfZXWu7nWdC7dS6xUW3JjcpiU
X-Gm-Gg: AYBFou3HCIAbQ2NjSkEUT8/94nomIDWLeGTG7nRkenWlDx/9AN2tvgoP+h/XhNAHzBO
	zDRhcWPadqtMlnxNfOF4ZOnDyBKZle4g/4IGfHHwbbToJdcwlz99XWuRdBlsakyGqpcwwhU08pq
	33LcnZAy6ob9wVPxCSabTCH5d7224cuccv6o92iMFWWM/iV+QS4RliMoWJcc0toO2+XxcAHsdFC
	z+WR59lV2po/SPzRBS0QhQCM8Kfr4D46VkeiMIBLVfldXU1d3cjlU9+EEARJrHh6NfIfXYGFYdk
	oc/n/MGf/vQ31HW+bw9DDX1LlOjvQ6wiYCd/jpHQrn/HTiVcI6RhPp4Dzkw/tHPBy0NJjrAnqJJ
	+/JUP6hh/tYzCUMD9OVql3dbsfvU9F6NGO+1XunEwb3VP+exZS+yjex+ew8kZlIU6DmB9XkMvOf
	g8oxowyOTDNLYGUO1YMJ3oAcXG4MB/tz9GawgkT3S/bLPcQbv4d9buvYsXFqZg14t2CxXF5Zw/a
	8atRmc4HBi+pktKBYhWdF1ce0s6gQTk
X-Received: by 2002:a05:690c:c6ce:20b0:816:b469:ccec with SMTP id 00721157ae682-87f245c27e6mr31944217b3.15.1788982672495;
        Wed, 09 Sep 2026 12:37:52 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:37:52 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: casey@schaufler-ca.com,
	gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	jolsa@kernel.org,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release kfunc and policy object destructor
Date: Wed,  9 Sep 2026 15:37:07 -0400
Message-ID: <20260909193719.518517-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909193719.518517-1-utilityemal77@gmail.com>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add security/bpf_lsm_kfuncs.c, the home of the kfuncs exposing LSM
policy objects to BPF programs, with the first of them:

  bpf_lsm_policy_release(object)                KF_RELEASE

The kfuncs are the LSM framework's own BPF interface: there is no
per-LSM kfunc and no intermediate security_*() layer.  Each kfunc
walks the matching hook's implementation list and calls the one
registered by the LSM whose lsmid the policy object carries.  Calling
a kfunc for an LSM that is not active or has no policy object support
fails at runtime rather than hiding the kfunc at verification time,
so BPF program loading is independent of the boot-time LSM
configuration.

A policy object reference is meant to be handed over through a map
kptr field, so also register a destructor for struct
lsm_policy_object: map-held references are dropped on map teardown,
possibly from a context that cannot sleep, which the
policy_object_put() hook contract accounts for.  For the same reason
the kfunc is not KF_SLEEPABLE, and the filter adds no per-kfunc rule:
releasing a reference must be allowed wherever one can be held.  The
filter itself is needed because BPF_PROG_TYPE_LSM and
BPF_PROG_TYPE_SYSCALL, the two registered program types, share their
kfunc lookup buckets with other program types.

Cc: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v2->v3:
        - No change.

 MAINTAINERS               |  1 +
 security/Makefile         |  2 +-
 security/bpf_lsm_kfuncs.c | 98 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 security/bpf_lsm_kfuncs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6215fcb07770..ba816d7ee127 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5081,6 +5081,7 @@ F:	kernel/bpf/bpf_lsm.c
 F:	kernel/bpf/bpf_lsm_proto.c
 F:	kernel/trace/bpf_trace.c
 F:	security/bpf/
+F:	security/bpf_lsm_kfuncs.c
 
 BPF [SELFTESTS] (Test Runners & Infrastructure)
 M:	Andrii Nakryiko <andrii@kernel.org>
diff --git a/security/Makefile b/security/Makefile
index 4601230ba442..a9364ea9828b 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
 obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
-obj-$(CONFIG_BPF_LSM)			+= bpf/
+obj-$(CONFIG_BPF_LSM)			+= bpf/ bpf_lsm_kfuncs.o
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
 obj-$(CONFIG_SECURITY_IPE)		+= ipe/
 
diff --git a/security/bpf_lsm_kfuncs.c b/security/bpf_lsm_kfuncs.c
new file mode 100644
index 000000000000..e1190215d477
--- /dev/null
+++ b/security/bpf_lsm_kfuncs.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* BPF kfuncs exposing LSM policy objects. */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/cfi.h>
+#include <linux/init.h>
+#include <linux/lsm_hooks.h>
+#include <linux/security.h>
+
+#include "lsm.h"
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_lsm_policy_release - Release a policy object reference
+ * @object: policy object to release
+ *
+ * Release an acquired reference on a policy object.
+ */
+__bpf_kfunc void bpf_lsm_policy_release(struct lsm_policy_object *object)
+{
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, policy_object_put) {
+		if (scall->hl->lsmid->id != object->lsmid)
+			continue;
+		scall->hl->hook.policy_object_put(object);
+		return;
+	}
+	/* A held reference implies the owning LSM implements the hook. */
+	WARN_ON_ONCE(1);
+}
+
+/* Destructor for referenced lsm_policy_object kptrs. */
+__bpf_kfunc void bpf_lsm_policy_release_dtor(void *object)
+{
+	bpf_lsm_policy_release(object);
+}
+CFI_NOSEAL(bpf_lsm_policy_release_dtor);
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_lsm_policy_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_lsm_policy_release, KF_RELEASE)
+BTF_KFUNCS_END(bpf_lsm_policy_kfunc_ids)
+
+BTF_ID_LIST(bpf_lsm_policy_dtor_ids)
+BTF_ID(struct, lsm_policy_object)
+BTF_ID(func, bpf_lsm_policy_release_dtor)
+
+/*
+ * BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL share their kfunc
+ * lookup buckets with other program types, so restricting the policy
+ * kfuncs requires a filter.
+ */
+static int bpf_lsm_policy_kfunc_filter(const struct bpf_prog *prog,
+				       u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_lsm_policy_kfunc_ids, kfunc_id))
+		return 0;
+
+	switch (prog->type) {
+	case BPF_PROG_TYPE_SYSCALL:
+	case BPF_PROG_TYPE_LSM:
+		return 0;
+	default:
+		return -EACCES;
+	}
+}
+
+static const struct btf_kfunc_id_set bpf_lsm_policy_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_lsm_policy_kfunc_ids,
+	.filter = bpf_lsm_policy_kfunc_filter,
+};
+
+static int __init bpf_lsm_policy_kfunc_init(void)
+{
+	const struct btf_id_dtor_kfunc bpf_lsm_policy_dtors[] = {
+		{
+			.btf_id = bpf_lsm_policy_dtor_ids[0],
+			.kfunc_btf_id = bpf_lsm_policy_dtor_ids[1],
+		},
+	};
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+					&bpf_lsm_policy_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					       &bpf_lsm_policy_kfunc_set);
+	return ret ?: register_btf_id_dtor_kfuncs(bpf_lsm_policy_dtors,
+						  ARRAY_SIZE(bpf_lsm_policy_dtors),
+						  THIS_MODULE);
+}
+late_initcall(bpf_lsm_policy_kfunc_init);
-- 
2.55.0


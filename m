Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEF5221E4
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910121; cv=none; b=KkUAYTpoV9ydxKH8FaeDTyjm9JBzGlfS61xl8p6pQE/8x5A3OAoTAX6S3FpDpnTec7OvENqPhz9n0b9StF/8fDx9Cg0BDy8w+rJHgP7i1qwHYuhMheGJTdSnYDT19+WWwYqY1Trcc9mKsh9187eEgbWh46EW6+enlo8ub53NkyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910121; c=relaxed/simple;
	bh=twaqqsy4JScubQuzgnErtrn8QhXdbphsw1UXkZ9/kZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fqr7myATIR6Hgy8Mr0hv7WBkawS0c0vkfxpMYc/pJg3okLwckGj5b+8af5vnmeA6TK9V9RJhNkgPLOtAORlfOA9qD7755wgbuUE8PP2OzE4n3EtCip505HOUbruSp4UJwFXxlwwI+OlLiTCPuP4jIUpqLkceDzt7vL8Wr61Sj3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCb+uY+y; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCb+uY+y"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-677bf06de21so2422480d50.3
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910118; x=1792514918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0sxD+uq/JHtdGPSVPV9/lbl9Bu23cNBYDzbADlnpt2I=;
        b=rCb+uY+ywn0zSi2kR95yR5yM6UU2HGF8iHYnTUTTcSztxJNmcHj3VJq/nFDhiWMcuK
         Qnlp3h9lVa8uFQh27oVOXjptMgoF5HQoYPRNQuSezZAlNq2TbdJ9/vfEoGvIDEXewwWw
         7vVIkyQ+c/8YUoMEKk2sQYf6wcN300Tb272J5PHshqlYbXObqj68UJw7aCxs+YujgXdi
         nlg67UC1U2J/8bRiKV18EjatD55RaZ1BSTMBvlgceETkJFPmP43vb/0KcLYEgYJ9YINd
         OA7Gb/7Eglh3ov7bfXGfy11M2EMrBvTrPYfJTMXRKAV9OL05YaYb7GC+G9Ta5o/Kd+ph
         3LdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910118; x=1792514918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0sxD+uq/JHtdGPSVPV9/lbl9Bu23cNBYDzbADlnpt2I=;
        b=sddZcbB7TmwHpqyrQute2Wu73WPd4O6EHhw+++wfNPzWtrkzcqLIXwCxNTlW1DcXuh
         3CKhqgCHDiizlWfhzNr8fF3FvFYXiI8XA5LsEPLC+pNG/34kexxGkqysUpM+sgEYRsf2
         uzWTTFqQUTlh8RwDetXoUj7SXNdUimB3j7fw/RfzQ3bBD0XMx91Z5S1Cc2br/K9rYJ1i
         rZ3XDGq1QKG8ibj0DB3rMUwapovDnSoy24lg8xfIP/oF1B5DgzXdEZEDbsKilzo1aWqc
         AmcAk4u9JQy29aLlXdNcgmjzExnZqpH8goFrjSpyG6jD+VEV50C3d62nXCyu7XmRqa0I
         SRpg==
X-Forwarded-Encrypted: i=1; AKwUvBw7wcBN94WwjTaHdoZMoRSE9DGutc+6pJu7j83LMTbX4wBYwiXdhGG82mYeuUc58EJANxKTDkxDnNDo0rNX/BJOqa4RMcs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKq8j7Td7hlYKkyzP5D+RhxzprjUeHFZH4/CPnjGmstRwCngbIM
	v2Q7eKmWUJjvNNY2R7mZf+zmIZoum1xY0CUrQBD5bsPBAZXSyhS/yx3g
X-Gm-Gg: AYBFou1PbSzvCYRje6GCq7HQIKOqE3AAvfsy+77EGYsr0kFZO2/KPfQFHDmtUACmiKP
	DWV/gC5a4NTk7UgZaEswBhPpB+eBUuQ02Ccf6kAgBNC6P3zQ7CtmNcJLC/WoClGpsEn7qNRzthj
	Nlk2nZaJaWJcgEGf1eSrSbfWvJtBJJOi+AbVevYXdhNWhqC5ZrsGHUsWcVR/R5DgUat/JYPVrEI
	6YY9F1RoYMVyvxu9Prc7GxCi+/YI0znPpcV7QclWjjhcNSB7TmQL383VXNJw8lKXDM3kjoEuCS5
	SGX9dKRd91ATVjKf6S1aZI7N0cmFlQ/gOV6oBLwz1QzA17kVgnalCaOMWecGeJGCX/tDAZUt/RP
	hcNt1p+nJUiBOGIJ2rO8DnkkXKD0PUo14oeq2LolXwIg+OhHF6NZLscPcPPas2yseoDPzmk+VE1
	X90h/jT9BYcEe8MBXPf3loafOpNBEXgbKYUzRwNcafQNGwCLzku+kYK3/AEtZaM6T7LnnTwRtb
X-Received: by 2002:a53:ac8f:0:b0:677:deb1:2af5 with SMTP id 956f58d0204a3-6793600b308mr3381591d50.25.1791910118205;
        Tue, 13 Oct 2026 09:48:38 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a89294sm81136d50.15.2026.10.13.09.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:48:37 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v1 06/11] selftests/bpf: exercise the path ancestor iterator
Date: Tue, 13 Oct 2026 12:47:55 -0400
Message-ID: <20261013164800.2906577-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013164800.2906577-1-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Walk the ancestry of a mkdir's parent directory from a sleepable LSM
program and check that the iteration reaches the root: the temporary
directory, its parent and / are visited, no position comes back
flagged, and the flags read back after the loop show it ended at the
root rather than on a failed allocation.

Hold the first position across the rest of the walk and resolve its
pathname only once the loop is done and the iterator destroyed: the
acquired reference, not the walk's, is then all that keeps the
position alive.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../selftests/bpf/prog_tests/path_ancestors.c | 57 ++++++++++++++
 .../selftests/bpf/progs/path_ancestors.c      | 74 +++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_ancestors.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_ancestors.c

diff --git a/tools/testing/selftests/bpf/prog_tests/path_ancestors.c b/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
new file mode 100644
index 000000000000..d1bd26bce10b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Justin Suess */
+
+#include <sys/stat.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "path_ancestors.skel.h"
+
+void test_path_ancestors(void)
+{
+	char base[] = "/tmp/path_ancestors_XXXXXX";
+	struct path_ancestors *skel = NULL;
+	char suba[280], subb[280];
+
+	if (!ASSERT_OK_PTR(mkdtemp(base), "mkdtemp"))
+		return;
+	snprintf(suba, sizeof(suba), "%s/a", base);
+	snprintf(subb, sizeof(subb), "%s/a/b", base);
+	if (!ASSERT_OK(mkdir(suba, 0755), "mkdir_a"))
+		goto out_rm;
+
+	skel = path_ancestors__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto out_rm;
+	skel->bss->monitored_pid = getpid();
+	if (!ASSERT_OK(path_ancestors__attach(skel), "attach"))
+		goto out;
+
+	/* mkdir b: the hook sees dir == suba, whose ancestry is walked. */
+	if (!ASSERT_OK(mkdir(subb, 0755), "mkdir_b"))
+		goto out;
+
+	/* suba, base, /tmp, / at least. */
+	ASSERT_GE(skel->bss->ref_count, 4, "ref_count");
+	ASSERT_EQ(skel->bss->ref_flags, 0, "ref_flags");
+	/*
+	 * The referenced loop ended at the root, not on an allocation
+	 * failure.
+	 */
+	ASSERT_EQ(skel->bss->end_flags, 0, "end_flags");
+
+	/* The acquired second position, used after its step was taken. */
+	ASSERT_STREQ(skel->bss->second_path, base, "second_path");
+	ASSERT_EQ(skel->bss->second_len, strlen(base) + 1, "second_len");
+
+	/* The first position, used only after the walk itself was gone. */
+	ASSERT_STREQ(skel->bss->first_path, suba, "first_path");
+	ASSERT_EQ(skel->bss->first_len, strlen(suba) + 1, "first_len");
+
+out:
+	path_ancestors__destroy(skel);
+out_rm:
+	rmdir(subb);
+	rmdir(suba);
+	rmdir(base);
+}
diff --git a/tools/testing/selftests/bpf/progs/path_ancestors.c b/tools/testing/selftests/bpf/progs/path_ancestors.c
new file mode 100644
index 000000000000..6287f5099a18
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/path_ancestors.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Justin Suess */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_pid;
+
+int ref_count;		/* positions seen by the pure referenced walk */
+int ref_flags;		/* pos flags seen by the referenced walk */
+int end_flags;		/* flags after a referenced loop ended: 0 unless NOMEM */
+int second_len;		/* d_path length of the walk's second position */
+int first_len;		/* d_path length of the first position, after the walk */
+char second_path[256];
+char first_path[256];
+
+static bool monitored(void)
+{
+	return (bpf_get_current_pid_tgid() >> 32) == monitored_pid;
+}
+
+SEC("lsm.s/path_mkdir")
+int BPF_PROG(walk_modes, const struct path *dir, struct dentry *dentry,
+	     umode_t mode)
+{
+	struct bpf_iter_path_ancestors it;
+	struct path *pos, *first = NULL;
+
+	/*
+	 * Keep first's init opaque: gcc-bpf otherwise folds it into a
+	 * preceding loop's exit value, which the verifier cannot track.
+	 */
+	barrier_var(first);
+
+	if (!monitored())
+		return 0;
+
+	/*
+	 * Referenced walk: every position comes acquired, so it stays valid
+	 * past the step that yielded it - the first one is held across the
+	 * rest of the walk and used only once the walk is gone.
+	 */
+	bpf_iter_path_ancestors_new(&it, (struct path *)dir, 0);
+	while ((pos = bpf_iter_path_ancestors_next(&it))) {
+		ref_count++;
+		ref_flags |= bpf_path_ancestors_pos_flags(&it);
+		if (!first) {
+			first = pos;
+			continue;
+		}
+		if (ref_count == 2)
+			second_len = bpf_path_d_path(pos, second_path,
+						     sizeof(second_path));
+		bpf_path_put(pos);
+	}
+	/* NULL from an allocation failure, not the root, surfaces here. */
+	end_flags |= bpf_path_ancestors_pos_flags(&it);
+	bpf_iter_path_ancestors_destroy(&it);
+	/*
+	 * The walk's own references moved on and the iterator is destroyed:
+	 * the acquired reference is all that keeps the first position alive.
+	 */
+	if (first) {
+		first_len = bpf_path_d_path(first, first_path,
+					    sizeof(first_path));
+		bpf_path_put(first);
+	}
+	return 0;
+}
-- 
2.55.0


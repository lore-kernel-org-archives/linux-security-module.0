Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67675261B9E
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246053; cv=none; b=XhYT4FyFJyHoMPuTu2fUnM/zlpES1QX52Xi5+dSPZUleCC6hoF7kzY9EfL7A4BuwFUnzeSCpuSnv+1Iy2oQHCHlC2q0eWcZljR+dnyuWEfJ2HUGHFhwSNGM3B/0WWmQfz6KN1nvEYxuvN144EszxEkifMVnGkId9kMPrz4Y7yqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246053; c=relaxed/simple;
	bh=g+n1czrcMHPLMQpcpTgeEza8tWqqWT5DIADJOEgauhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qV6NfekpaqINQEcBuyvmo3e5+0OeafKJssgAwuSkPfGHBQHJP99oNdSKYreNckBx10LlOujH+Sx48hxuofHmUOLOFt9WCpLlzIjkCZsn5Nrja+dJUrNfaTwlyVFgmfu8FGlm3I6VhD6DkvAotVZ7KsWFeQ2zhBgbaFy1zJJwk58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4T56T7N; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4T56T7N"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ac8a2ac52bso3549377b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 05 Oct 2026 17:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246049; x=1791850849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WcPAYnp6FRhiKAh9ydZFYz6XVPrSxVL1Ud94wpG3oX4=;
        b=D4T56T7N+JYXwvkTfK1CmI685PRoJSJ11hOKflHGb7K/jjIHUtjAf1KshSV2zZdSgL
         ZkApGaPqnAPmBLhe1bN6Xv+XhSYFBudrfMk9U5EL+zjjGSU8prqfwIAV+NpgJlxEKveJ
         sl5YzrYCQly66AVuMBIbR7QN26da1ZRFymZQgAfiYOCnDNp3IhVgCqYWCMoBDQnszqSf
         OgjZNJhoFmhr3iktHrgZDACoS09hVHcA8jbdSByG5UfmDCfjTfFwyjwUyAkbQ4R6d7Vn
         4ebGNTSsTZnFht9mUXggxNIg/DBSquYm7crMsDSv4GnbGMKLSQZdAYTgmvK0gjJ707ZA
         fG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246049; x=1791850849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WcPAYnp6FRhiKAh9ydZFYz6XVPrSxVL1Ud94wpG3oX4=;
        b=1cLoyLCWkcRG3LIyG5P3/TDFmmgJKERKAKFzTaf7EDItKwOmamjc6YuHfAwWk2Dlr7
         UxNxbwbekFwB1oiI4RT5PlqoV3TX8gZ699sVvl/45kfQ9YU3atE91j2kD2DGiH72Dy0N
         GV/eKaaxQGZEpPY43EkTOuTjDPWADYVXPFD8QAd5zsZjndA42I5C8nVKFdLukaHMkrVx
         nenVYKt4Oakpr9ofaMJClDral89La3Ir0jyZfApJuR8X/E2qkIr5e1bvWtRQ3cGyQMbL
         vGPRK4HOu8iKwuCWvMZxgO3ywrwSZWR/73rZUNBKDxRPhYDQF+gHndyx7W++R1dSpjKF
         9kog==
X-Forwarded-Encrypted: i=1; AKwUvBxoFUlDYrGvEdf4urvwb8VYREByzc/mbtumeccmE/1DcYXXHs1WrnC6SGDiq22sMQarqPaGTszpvKqKmVYuDlVSxqWtagQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLr8aSwD5OyH5PmkDA2d8SmIySjwwWi1SWoGPklBt3Tr3Z2xWrn
	PT7oQDXQNHUDV9fBky9/nCyFn8rRDYfd5mRGF+oat1+h7FziCQKCFL2w
X-Gm-Gg: AYBFou3zn7zxy97A2WqaavGH0/c4wyq3eBcS5iWj+z4rbQlsodU1Pa66syyA68exV6G
	s79kMDKtUPTfZ7eHk693711fhhpSMr1MAVt0xWgyh1bloqffHF4kX9KRLZrxg+Py7VR/8jCn0kN
	Wbr2mGR1y4ZxB650HWgrk6RHqZQpoFiNR4cRhz6jY/OSj9JveZpuusSkH/9gVng7kg1pUkMvwnN
	4UIbxDGxVdTzfQEv1ZPPzCklC4hCe1FUjtCWRc3FstzGqNrk4iKTzzLdk9J09P53Gz2wI31ca3f
	r90FERJjUr/YHiI4AaXt11f/ByuQUNrm/JbzPlAXZw+ernRZL/usR+HOEYeVCxHLOn1uURllzky
	o4OpwDOEnrBQEg7OmN2A7I4O+dSotHBuXgAclk77UlySR1n/9TuDCQLXIkdXA3W8FZBrVIcmZaT
	KwJWBgeJrd/Ceb87eKQqAuV4/XXDMiiSvw2EabpqtokEjE0Nr6+KajTbQnDriT7VYgA2DmSlw4x
	NM=
X-Received: by 2002:a05:690c:e64b:b0:8ae:ae7a:2763 with SMTP id 00721157ae682-8af7204ed31mr3635217b3.13.1791246049148;
        Mon, 05 Oct 2026 17:20:49 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:20:48 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 07/12] selftests/bpf: exercise the path ancestor iterator
Date: Mon,  5 Oct 2026 20:20:14 -0400
Message-ID: <20261006002020.2890858-8-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006002020.2890858-1-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Walk the ancestry of a mkdir's parent directory from a sleepable LSM
program and check that the iteration reaches the root: the temporary
directory, its parent and / are visited, and no position comes back
flagged.

Resolve the second position's pathname from the acquired position after
the step that yielded it has been taken, so that the acquired reference
is what the sleepable kfunc runs on rather than the walk's.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../selftests/bpf/prog_tests/path_ancestors.c | 48 ++++++++++++++++++
 .../selftests/bpf/progs/path_ancestors.c      | 49 +++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_ancestors.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_ancestors.c

diff --git a/tools/testing/selftests/bpf/prog_tests/path_ancestors.c b/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
new file mode 100644
index 000000000000..2de79673a13b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
@@ -0,0 +1,48 @@
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
+	ASSERT_GE(skel->bss->ref_count, 3, "ref_count");
+	ASSERT_EQ(skel->bss->ref_flags, 0, "ref_flags");
+
+	/* The acquired second position, used after its step was taken. */
+	ASSERT_STREQ(skel->bss->second_path, base, "second_path");
+	ASSERT_EQ(skel->bss->second_len, strlen(base) + 1, "second_len");
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
index 000000000000..af6b777e8bec
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/path_ancestors.c
@@ -0,0 +1,49 @@
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
+int second_len;		/* d_path length of the walk's second position */
+char second_path[256];
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
+	struct path *pos;
+
+	if (!monitored())
+		return 0;
+
+	/*
+	 * Referenced walk: every position comes acquired, so it stays valid
+	 * for sleepable work and past the step that yielded it.
+	 */
+	bpf_iter_path_ancestors_new(&it, (struct path *)dir, 0);
+	while ((pos = bpf_iter_path_ancestors_next(&it))) {
+		ref_count++;
+		ref_flags |= bpf_path_ancestors_pos_flags(&it);
+		if (ref_count == 2)
+			second_len = bpf_path_d_path(pos, second_path,
+						     sizeof(second_path));
+		bpf_path_put(pos);
+	}
+	bpf_iter_path_ancestors_destroy(&it);
+	return 0;
+}
-- 
2.55.0


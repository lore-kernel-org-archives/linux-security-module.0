Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA002874E1
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246067; cv=none; b=B5QqU3K8MG/eFbWwy1IAr1Lfw31cBGQHiMX8Eg70G7Oy2Qc5vZqRu9ilwTnkMB0U9HWFkBh4lbPSGYN9ac0uCyArHlS/GJvkbUJiw3a0OZsygpxQCEPkfEv3vRFUFZy7nZqeIBrgdtG1+TvHSUKcKqDoiO8I+aDK/IGXOOr86+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246067; c=relaxed/simple;
	bh=5IHNNJEtUlKJEhnNbWbSN0wlvDwMgHAFZwu9RzbhX8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nw5M6MG613q0S3/BUeGBgWWSkZ4Lcpv4OQriubVvGcTe3u6XDyLBf/cqaCO18xpdrot11pKZuQti8BO49kqf7BDdgnuS9KMN2oSiQ5G/rgfKr7m4yUh23K+aqdmtrz2yazj8I/lGPN7Me/P4IpTUxaBttTN80XgQS0dMx4ePGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CazxQBap; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CazxQBap"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab445ac183so24828957b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 05 Oct 2026 17:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246065; x=1791850865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qiSLpzAIAwj1Vd6pAZ21vWt+EaPkWyZTSVtuKYzMJIY=;
        b=CazxQBapYMbnxI0bZOOMrJjGk/DrIcMJO2xPzsoWiJFQ1AU0ryLxBSlOFM7LlG0wR+
         5qAGIY/eWn6ZVhBoDPzsazTI+pmBwmL84x+Ur5zTkf6VXoVGRYeGwceqnSZEjFfJPoxS
         ZaFocE4uah4VO57CiCbYyB2KnK3x+bIEVAtljrsLR6Yn2kZu7yK9QsSv0/QuoExoVux1
         Eh+1WFwq/upcjSoAEfeEQMqd6Vgn3BLzrQNgl9Hdgyv0TF4ScX3Ixat9xUdr3GoJ48hr
         HToesqaX9Xz4dxROS1UwiPrcKw2lNki4axw8P+pnVzCTYX3U0DDRUnkp2MLYWI70qHfJ
         fvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246065; x=1791850865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qiSLpzAIAwj1Vd6pAZ21vWt+EaPkWyZTSVtuKYzMJIY=;
        b=NA6/D7yZLH5WVqW4ws9Nygoi3SrMKxAnQTb+QBl6lDsdKq9BsuZtkmW03T91ew+Phs
         xnpLFX6KIjyfOGbVaTCcfmQjsPHJCQ0Clo+a3lKWVziPq51WotymVjnmDjZIxxmHbgqn
         ZsvBx+bfbUjbkUxC0+QdpF8sTji/bilGH+QCYGW7pShhKOI/fEaLyDpCp6Adt8ne4GHH
         1qZwIotG9IyjhlsbAE5RgUcYb1xOh4wi7zUA/UmqVyzdxVwlWmYvvtMPcSNzAU2Y1MBL
         WrjZycvXFMFy6I8Gh5tUgVuQI+8oKOUajJUpbW20OTqQQDDHhyyS76VCTYw4J95+EQ/I
         OZvA==
X-Forwarded-Encrypted: i=1; AKwUvBxlJpS+SY7jldEJGTMY2lHH8bvJetO4VugN/Yi0PFzUCwhJKRN92Z663dd7RLDljLi30wb7lYzN5htRKLOlQeF/huyf9DU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgeyb5VqwL97BjX3bfw8nCdCvP+x6rJ4CWSBwIbIIW9xsAPbaJ
	coQOT2dTZz033o2SJb3gGmZ27e1nE0hLNo3KPdCqHVoqjRlvuJBDcDe0
X-Gm-Gg: AYBFou1ut1EiIZyMWTmbYNTCpyg3KliZGrPUkhbnvIlmMg3GQHJr9xMoqWTbhqQMRq2
	7REcZFa4g9N/lOTbRBJFmfM22nrodEnSYLUQKbiXXHbNfJjybaVH22mSG0cIaLC7wyDiee3u82H
	OFUlpZqRVGCyG0Yv5t+7GedgZV0FOdVLjKlLeU9rue6rsu884zy2MEqYA9bbfOLbKdo0CGIZ2rC
	ql1nbphSCzY58vt+bOzpE5hsn6OK86SDSGfNWDIhJq/4d05chap1b4k4poT5FjEba4GpYGyEaxx
	ghyCByxTmnGLQX3x8a25fcGqkmexhoNLKW2shy9Uwm6SAtI3peXPSVQRTTzvlz2mA1+0Y+JSFGR
	VTuE94NY6ADiJ249Edi3gVSSxofJumOQwIR8JQq9bcoW0A8POkfTo9sLkqnIf0odYaev9WcLhxk
	qQT1XD1yHz5cNwt/g8aWA+qs86y1l74RYBrUAPN5Ba/+i+XRnjE0tDmgTfg8ykuEjEds2iVUyLk
	w==
X-Received: by 2002:a05:690c:dd6:b0:886:70a9:3ad2 with SMTP id 00721157ae682-8ae392b68e5mr56802557b3.15.1791246064581;
        Mon, 05 Oct 2026 17:21:04 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:21:03 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 12/12] selftests/bpf: exercise the lockless path ancestor iterator
Date: Mon,  5 Oct 2026 20:20:19 -0400
Message-ID: <20261006002020.2890858-13-utilityemal77@gmail.com>
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

Walk the same ancestry four ways and require the position counts to
agree: lockless from a non-sleepable program, where the RCU critical
section is implicit; lockless under an explicit bpf_rcu_read_lock();
referenced; and the hybrid that walks lockless to the second position,
hands it over to a referenced iteration, and resumes there - the
escalated position therefore being walked twice, once per mode.

The sleepable work the escalation exists for (d_path, an xattr read
through the position's dentry) runs on the resumed iteration's first
position, after bpf_rcu_read_unlock(), which is the only place a
sleepable kfunc can run at all.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../selftests/bpf/prog_tests/path_ancestors.c | 33 ++++++-
 .../selftests/bpf/progs/path_ancestors.c      | 89 ++++++++++++++++++-
 2 files changed, 118 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/path_ancestors.c b/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
index 2de79673a13b..ce1ded844c3a 100644
--- a/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
+++ b/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 Justin Suess */
 
 #include <sys/stat.h>
+#include <sys/xattr.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <test_progs.h>
@@ -12,6 +13,8 @@ void test_path_ancestors(void)
 	char base[] = "/tmp/path_ancestors_XXXXXX";
 	struct path_ancestors *skel = NULL;
 	char suba[280], subb[280];
+	bool xattr_works;
+	int err;
 
 	if (!ASSERT_OK_PTR(mkdtemp(base), "mkdtemp"))
 		return;
@@ -20,6 +23,12 @@ void test_path_ancestors(void)
 	if (!ASSERT_OK(mkdir(suba, 0755), "mkdir_a"))
 		goto out_rm;
 
+	/* Read back by the program at the escalated position (== base). */
+	err = setxattr(base, "user.walk", "hello", 6, 0);
+	xattr_works = !err;
+	if (err && errno != EOPNOTSUPP && !ASSERT_OK(err, "setxattr"))
+		goto out_rm;
+
 	skel = path_ancestors__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "open_and_load"))
 		goto out_rm;
@@ -31,14 +40,34 @@ void test_path_ancestors(void)
 	if (!ASSERT_OK(mkdir(subb, 0755), "mkdir_b"))
 		goto out;
 
-	/* suba, base, /tmp, / at least. */
-	ASSERT_GE(skel->bss->ref_count, 3, "ref_count");
+	ASSERT_EQ(skel->bss->test_err, 0, "test_err");
+	ASSERT_EQ(skel->bss->escalate_err, 0, "escalate_err");
+	/* suba, base, /tmp, / at least; equality across modes is the point. */
+	ASSERT_GE(skel->bss->rcu_count, 3, "rcu_count");
+	ASSERT_EQ(skel->bss->ref_count, skel->bss->rcu_count, "ref_vs_rcu");
+	ASSERT_EQ(skel->bss->rcu_ns_count, skel->bss->rcu_count,
+		  "nonsleepable_vs_rcu");
+	/*
+	 * The escalated position is walked twice: once lockless, then again
+	 * as the resumed referenced iteration's first position.
+	 */
+	ASSERT_EQ(skel->bss->hybrid_count, skel->bss->rcu_count + 1,
+		  "hybrid_vs_rcu");
+	ASSERT_EQ(skel->bss->retry_flags, 0, "no_retry");
 	ASSERT_EQ(skel->bss->ref_flags, 0, "ref_flags");
 
 	/* The acquired second position, used after its step was taken. */
 	ASSERT_STREQ(skel->bss->second_path, base, "second_path");
 	ASSERT_EQ(skel->bss->second_len, strlen(base) + 1, "second_len");
 
+	/* The escalated position is the walk's second one: base. */
+	ASSERT_STREQ(skel->bss->escalated_path, base, "escalated_path");
+	ASSERT_EQ(skel->bss->escalated_len, strlen(base) + 1, "escalated_len");
+	if (xattr_works) {
+		ASSERT_EQ(skel->bss->xattr_ret, 6, "xattr_len");
+		ASSERT_STREQ(skel->bss->xattr_value, "hello", "xattr_value");
+	}
+
 out:
 	path_ancestors__destroy(skel);
 out_rm:
diff --git a/tools/testing/selftests/bpf/progs/path_ancestors.c b/tools/testing/selftests/bpf/progs/path_ancestors.c
index af6b777e8bec..50ce0ce163dd 100644
--- a/tools/testing/selftests/bpf/progs/path_ancestors.c
+++ b/tools/testing/selftests/bpf/progs/path_ancestors.c
@@ -11,29 +11,74 @@ char _license[] SEC("license") = "GPL";
 
 __u32 monitored_pid;
 
+int rcu_count;		/* positions seen by the pure lockless walk */
+int rcu_ns_count;	/* ditto, from the non-sleepable program */
 int ref_count;		/* positions seen by the pure referenced walk */
+int hybrid_count;	/* positions seen by the lockless+escalate walk */
+int retry_flags;	/* BPF_PATH_ANCESTORS_RETRY observations */
 int ref_flags;		/* pos flags seen by the referenced walk */
 int second_len;		/* d_path length of the walk's second position */
+int xattr_ret;		/* xattr read at the escalated position */
+int escalated_len;	/* d_path length of the escalated position */
+int escalate_err;	/* bpf_path_ancestors_legitimize() result */
+int test_err;
 char second_path[256];
+char escalated_path[256];
+char xattr_value[16];
 
 static bool monitored(void)
 {
 	return (bpf_get_current_pid_tgid() >> 32) == monitored_pid;
 }
 
+/*
+ * Lockless walk from a non-sleepable program: the RCU critical section is
+ * implicit, no bpf_rcu_read_lock() needed.
+ */
+SEC("lsm/path_mkdir")
+int BPF_PROG(rcu_nonsleepable, const struct path *dir, struct dentry *dentry,
+	     umode_t mode)
+{
+	struct bpf_iter_path_ancestors_rcu rit;
+
+	if (!monitored())
+		return 0;
+
+	bpf_iter_path_ancestors_rcu_new(&rit, (struct path *)dir, 0);
+	while (bpf_iter_path_ancestors_rcu_next(&rit))
+		rcu_ns_count++;
+	retry_flags |= bpf_path_ancestors_rcu_pos_flags(&rit);
+	bpf_iter_path_ancestors_rcu_destroy(&rit);
+	return 0;
+}
+
 SEC("lsm.s/path_mkdir")
 int BPF_PROG(walk_modes, const struct path *dir, struct dentry *dentry,
 	     umode_t mode)
 {
+	struct bpf_iter_path_ancestors_rcu rit;
 	struct bpf_iter_path_ancestors it;
+	struct bpf_dynptr value_ptr;
 	struct path *pos;
 
 	if (!monitored())
 		return 0;
 
 	/*
-	 * Referenced walk: every position comes acquired, so it stays valid
-	 * for sleepable work and past the step that yielded it.
+	 * Mode 1: pure lockless, under an explicit RCU critical section.
+	 * Positions are borrowed, so nothing is released here.
+	 */
+	bpf_rcu_read_lock();
+	bpf_iter_path_ancestors_rcu_new(&rit, (struct path *)dir, 0);
+	while (bpf_iter_path_ancestors_rcu_next(&rit))
+		rcu_count++;
+	retry_flags |= bpf_path_ancestors_rcu_pos_flags(&rit);
+	bpf_iter_path_ancestors_rcu_destroy(&rit);
+	bpf_rcu_read_unlock();
+
+	/*
+	 * Mode 2: pure referenced.  Every position comes acquired, so it
+	 * stays valid for sleepable work and past the step that yielded it.
 	 */
 	bpf_iter_path_ancestors_new(&it, (struct path *)dir, 0);
 	while ((pos = bpf_iter_path_ancestors_next(&it))) {
@@ -45,5 +90,45 @@ int BPF_PROG(walk_modes, const struct path *dir, struct dentry *dentry,
 		bpf_path_put(pos);
 	}
 	bpf_iter_path_ancestors_destroy(&it);
+
+	/*
+	 * Mode 3: hybrid.  Walk lockless to the second position, then hand
+	 * that position over to a referenced iteration which resumes there.
+	 */
+	bpf_rcu_read_lock();
+	bpf_iter_path_ancestors_rcu_new(&rit, (struct path *)dir, 0);
+	while (bpf_iter_path_ancestors_rcu_next(&rit)) {
+		hybrid_count++;
+		if (hybrid_count == 2)
+			break;
+	}
+	escalate_err = bpf_path_ancestors_legitimize(&it, &rit);
+	retry_flags |= bpf_path_ancestors_rcu_pos_flags(&rit);
+	bpf_iter_path_ancestors_rcu_destroy(&rit);
+	bpf_rcu_read_unlock();
+
+	if (escalate_err)
+		test_err = 1;
+
+	/*
+	 * Out of the RCU critical section.  The resumed iteration's first
+	 * position is the escalated one, kept alive by the reference the
+	 * iteration hands out, so sleepable work can run on it.
+	 */
+	while ((pos = bpf_iter_path_ancestors_next(&it))) {
+		hybrid_count++;
+		if (hybrid_count == 3) {
+			escalated_len = bpf_path_d_path(pos, escalated_path,
+							sizeof(escalated_path));
+			bpf_dynptr_from_mem(xattr_value, sizeof(xattr_value),
+					    0, &value_ptr);
+			/* A trusted path's dentry is trusted, never NULL. */
+			xattr_ret = bpf_get_dentry_xattr(pos->dentry,
+							 "user.walk",
+							 &value_ptr);
+		}
+		bpf_path_put(pos);
+	}
+	bpf_iter_path_ancestors_destroy(&it);
 	return 0;
 }
-- 
2.55.0


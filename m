Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA4525A84
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910139; cv=none; b=kttGW2Mg2T7AhZQVr7PFalylsy8QmwEG+NAWcpT/EqxdWIxktQeGHmIKYUD6JvyySwxBqfKv4iT4Jl6RKH1sfanvmnI1uGny1MCDDEXaiLWyWHSWdxAki9ChigROJYKZoajERNPT/Af3XDL6rOMvumRhT2uXBhmfXTAtYsdjC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910139; c=relaxed/simple;
	bh=2EeR6V404iYnKihW+yPfj1QHhrtQAjxp9odbCAczzB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsfWv9MoNHiL4cpEvkwhy06WvhLZuAcYVuFYyvCKJaAv3XvXAvrcM2KvZ6BIWc5ksGXW8p4/KSpvOLim5LfxdcsWYpHcla3rhi8CX/0M8mj5H2WRuPhmU5SRGRYO64/bfcNc5vLSreRMOngKXumro8E4PIPBW/v+a00j3k70X20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Piko7b2b; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Piko7b2b"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67921b515a6so2449017d50.1
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910137; x=1792514937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rD0Lguh2Ejza0ZWBhDV7c2VWmxR4PIMA31ZIarRTpfI=;
        b=Piko7b2bwyQHTWxNN/Azmz79aMbZJPfumZSY5EAfyJTXODG3TVYVS5R0EPE2Y8PQlP
         4uMPSG2KE9+zhJB6HNjHHZzuGxqMw6meK9rgN/9Yj1tuQ6GkNbZoMoFCGZXXyX7P9LKb
         ZbQVpTXnJd9Yj7wdKOkhEsqAzaKBtQ2Ym35c98YXKgsVHorHY8rxsWh60vzZ/JQg2mZZ
         ChR5g/YWnp+kltqhL5qnCRnhtnqM+f82mny7TSfx+/ri+d8tCzdHvN8T+DB9CgeLXUTW
         +eX4LTlARldmahAa3Qs3rQv0m9am6lg2/4+V6WA6/6fywgG8Wc3X4+8qCJLnxKh+4Huk
         wJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910137; x=1792514937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rD0Lguh2Ejza0ZWBhDV7c2VWmxR4PIMA31ZIarRTpfI=;
        b=r5hYcypKcUOiB0GzDj3xSZsKbD6BMNxBmU2hxS6Cm/+XGHguFqiHmCuKSTwWj6M9ce
         Mahw5V+j0c+MnydRQOcZPpUQok/U/MO/gwlOvuJt0MwL/9T1HQ5GZ50WU6xvVk3saSLS
         6y9dx8jUwHTaPZlRGPABkTMKYcHis36Tvspx5JNUWoZIrhLqLLvOCuDMuYgm8U04mv1x
         xihLK9cY7h+mG8JEXBt9w0uXyWTuWAfww+RkJRxCLU96Q2osvs59XOKzI8Fv7C6Sj3rj
         IasXPOWRDvN4xcuT1/Hv4NBIxKSszvXwLEEvLMDtTQr2xIy0fapzMGsiis+xJLDzj42x
         2rgg==
X-Forwarded-Encrypted: i=1; AKwUvBwYgzXNb/XB7wsMrOwJtpWQ1/TzgucwZtNoyKWSvqEChH5tXJ3cIydOOqPBpZPZDz7He9B9mPMSCv7EMvq90/cgYZbroQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIm03MtXPQyoNeTl0GRuCNxAdE3+KooLNMUrxkneYchuP8qfk2r
	1w2uUGAIaf3hPqOYf5r6o3myv8wSiFzScHb/x+ae/7U4ni1lv+IBQrDr
X-Gm-Gg: AYBFou15UK3htZNUJmlg3GFEWAdsf0jaiYMl4Pzdt+0Mrmwk15OMOpKZvGDTTLwGXmL
	pFyJW7fTWAV+WkZGlU6P3+uHIFn7zw1Zd8zM4dUw/ygr+0o1+K+yLS4RkWLD7toFYuqGRjy8F4Q
	YiDRSMU26Erfm3FdyxUROhuIC5Qj8dh61MgckE/wSRfXJ3+IYgVW0M+j96LqygzdhgW9/Ly7k/H
	bgMyD9Qa3PH9Kr5PmTfWBwk4AQNR8BsmrQcu9JvO357/PBPJfz/M1GHtt878bivdy5N58W8ymun
	IRZYc2y3CUndJZ+DcoA5h/ELQKPnOPVaZG0R14B9hU2xYMM8VJ3rKYIJRXkTOtbfVZfEbmjGoC/
	uqCGCSapE+lzwbWcIs2MCRT+LML5JNCE+cXvfaFB/C5VBOMS5VhyhLf8WaqC0kqRDENiqu2FFRG
	q9bs0JMsWRRaVRGPaDv/Eakr8GHwz6cjhMO9yg9Sjst6y/BI6//5GDqxJ0F+dv5RGOQ4UPvO8B
X-Received: by 2002:a53:ac90:0:b0:672:9f72:7c09 with SMTP id 956f58d0204a3-679362bce0amr3837238d50.107.1791910136642;
        Tue, 13 Oct 2026 09:48:56 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a89294sm81136d50.15.2026.10.13.09.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:48:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 11/11] selftests/bpf: exercise the lockless path ancestor iterator
Date: Tue, 13 Oct 2026 12:48:00 -0400
Message-ID: <20261013164800.2906577-12-utilityemal77@gmail.com>
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

Walk the same ancestry four ways and require the position counts to
agree: lockless from a non-sleepable program, where the RCU critical
section is implicit; lockless under an explicit bpf_rcu_read_lock();
referenced; and the hybrid that walks lockless to the second position,
hands it over to a referenced iteration, and resumes there - the
escalated position therefore being walked twice, once per mode.

The sleepable work the escalation exists for (d_path on the escalated
position) runs on the resumed iteration's first position, after
bpf_rcu_read_unlock(), which is the only place a sleepable kfunc can
run at all.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../selftests/bpf/prog_tests/path_ancestors.c | 45 +++++++++--
 .../selftests/bpf/progs/path_ancestors.c      | 78 ++++++++++++++++++-
 2 files changed, 112 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/path_ancestors.c b/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
index d1bd26bce10b..c324090588dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
+++ b/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
@@ -12,30 +12,56 @@ void test_path_ancestors(void)
 	char base[] = "/tmp/path_ancestors_XXXXXX";
 	struct path_ancestors *skel = NULL;
 	char suba[280], subb[280];
+	int attempt;
 
 	if (!ASSERT_OK_PTR(mkdtemp(base), "mkdtemp"))
 		return;
 	snprintf(suba, sizeof(suba), "%s/a", base);
-	snprintf(subb, sizeof(subb), "%s/a/b", base);
 	if (!ASSERT_OK(mkdir(suba, 0755), "mkdir_a"))
 		goto out_rm;
 
 	skel = path_ancestors__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "open_and_load"))
 		goto out_rm;
-	skel->bss->monitored_pid = getpid();
 	if (!ASSERT_OK(path_ancestors__attach(skel), "attach"))
 		goto out;
 
-	/* mkdir b: the hook sees dir == suba, whose ancestry is walked. */
-	if (!ASSERT_OK(mkdir(subb, 0755), "mkdir_b"))
+	/*
+	 * A mount anywhere in the system during the walk legitimately ends
+	 * the lockless iterations with RETRY and no conclusion: retrigger
+	 * until a quiet window.  mkdir b: the hook sees dir == suba, whose
+	 * ancestry is walked.
+	 */
+	for (attempt = 0; attempt < 5; attempt++) {
+		memset(skel->bss, 0, sizeof(*skel->bss));
+		skel->bss->monitored_pid = getpid();
+
+		snprintf(subb, sizeof(subb), "%s/a/b%d", base, attempt);
+		if (!ASSERT_OK(mkdir(subb, 0755), "mkdir_b"))
+			goto out;
+		rmdir(subb);
+		if (!skel->bss->retry_flags && !skel->bss->escalate_err)
+			break;
+	}
+	if (!ASSERT_LT(attempt, 5, "retried_out"))
 		goto out;
 
-	/* suba, base, /tmp, / at least. */
-	ASSERT_GE(skel->bss->ref_count, 4, "ref_count");
+	ASSERT_EQ(skel->bss->escalate_err, 0, "escalate_err");
+	/* suba, base, /tmp, / at least; equality across modes is the point. */
+	ASSERT_GE(skel->bss->rcu_count, 4, "rcu_count");
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
 	/*
-	 * The referenced loop ended at the root, not on an allocation
+	 * The referenced loops ended at the root, not on an allocation
 	 * failure.
 	 */
 	ASSERT_EQ(skel->bss->end_flags, 0, "end_flags");
@@ -48,10 +74,13 @@ void test_path_ancestors(void)
 	ASSERT_STREQ(skel->bss->first_path, suba, "first_path");
 	ASSERT_EQ(skel->bss->first_len, strlen(suba) + 1, "first_len");
 
+	/* The escalated position is the walk's second one: base. */
+	ASSERT_STREQ(skel->bss->escalated_path, base, "escalated_path");
+	ASSERT_EQ(skel->bss->escalated_len, strlen(base) + 1, "escalated_len");
+
 out:
 	path_ancestors__destroy(skel);
 out_rm:
-	rmdir(subb);
 	rmdir(suba);
 	rmdir(base);
 }
diff --git a/tools/testing/selftests/bpf/progs/path_ancestors.c b/tools/testing/selftests/bpf/progs/path_ancestors.c
index 6287f5099a18..3ebf86b23199 100644
--- a/tools/testing/selftests/bpf/progs/path_ancestors.c
+++ b/tools/testing/selftests/bpf/progs/path_ancestors.c
@@ -11,23 +11,52 @@ char _license[] SEC("license") = "GPL";
 
 __u32 monitored_pid;
 
+int rcu_count;		/* positions seen by the pure lockless walk */
+int rcu_ns_count;	/* ditto, from the non-sleepable program */
 int ref_count;		/* positions seen by the pure referenced walk */
+int hybrid_count;	/* positions seen by the lockless+escalate walk */
+int retry_flags;	/* pos flags at the end of the lockless walks: 0 unless RETRY */
 int ref_flags;		/* pos flags seen by the referenced walk */
 int end_flags;		/* flags after a referenced loop ended: 0 unless NOMEM */
 int second_len;		/* d_path length of the walk's second position */
 int first_len;		/* d_path length of the first position, after the walk */
+int escalated_len;	/* d_path length of the escalated position */
+int escalate_err;	/* bpf_path_ancestors_legitimize() result */
 char second_path[256];
 char first_path[256];
+char escalated_path[256];
 
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
 	struct path *pos, *first = NULL;
 
@@ -41,9 +70,21 @@ int BPF_PROG(walk_modes, const struct path *dir, struct dentry *dentry,
 		return 0;
 
 	/*
-	 * Referenced walk: every position comes acquired, so it stays valid
-	 * past the step that yielded it - the first one is held across the
-	 * rest of the walk and used only once the walk is gone.
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
+	 * stays valid past the step that yielded it - the first one is held
+	 * across the rest of the walk and used only once the walk is gone.
 	 */
 	bpf_iter_path_ancestors_new(&it, (struct path *)dir, 0);
 	while ((pos = bpf_iter_path_ancestors_next(&it))) {
@@ -70,5 +111,36 @@ int BPF_PROG(walk_modes, const struct path *dir, struct dentry *dentry,
 					    sizeof(first_path));
 		bpf_path_put(first);
 	}
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
+	/*
+	 * Out of the RCU critical section.  The resumed iteration's first
+	 * position is the escalated one, kept alive by the reference the
+	 * iteration hands out, so sleepable work can run on it.
+	 */
+	while ((pos = bpf_iter_path_ancestors_next(&it))) {
+		hybrid_count++;
+		if (hybrid_count == 3)
+			escalated_len = bpf_path_d_path(pos, escalated_path,
+							sizeof(escalated_path));
+		bpf_path_put(pos);
+	}
+	end_flags |= bpf_path_ancestors_pos_flags(&it);
+	bpf_iter_path_ancestors_destroy(&it);
 	return 0;
 }
-- 
2.55.0


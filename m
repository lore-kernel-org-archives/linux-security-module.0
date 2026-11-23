Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452847;
	b=MO+LQzZs56qXQraBqsnbyu7JA6gns+gJ78bopLxkYRYa2xLUSZ0nY+Ifju9zdCnrtNbo
	 s1yyaAXtaGtGdurSzsTSPowTprGcfVquEoNw44ZddWNbXznPUmjs+ncAFu9KoqSCcqBQo
	 NAVyFWmG90Ttf5rScHa6txQFGHzRX6IBQFoAveh3PfSr7n7X5yhS7w2ENCIjP2g7/G8NX
	 fQ3DEkSlFr4xD+L5k2JbKsRJ7tCTS7O485vBRgHEnJ4l31B3wXJFFSc22YHktjVXTNEMR
	 Z6S6u2eaaAAc0QG2+VxRRBXryPxH2MXbLFN5lWt2v+l7aJCRkczi3iTzoa3NVSobF7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7UR94Er5BqhFrRYk1QbhHUlLQc2SlLi1Cmg4CSQYG1U=;
	b=MO67gZaejLJ888MRD9btJt/rJBKP+Z4ZyoHQHl9IxQced8jJcH+PZER9jlPFZDewyZTW
	 aORFcSSLrF7eyMFdRA4ALkxHOWxfa8HDmTQLsuwshVVcIEVyaQrp9bpu0RWRUdNtYiPNQ
	 FGp6t8GihY++sLCjbQnnldDvcD9O9PHCerl1j9acvmb3A22Wz1rdLx/rpJOMzyADt5EYb
	 lV4blEhcH+BlHds0OqNErnL/cc73PLIOV243BIz6TT5BHrjT1VMu+VnyqSQXOAysxC9/M
	 8LosprwHURMtUTyew1SfvbNGcHyhca/TbFKtzcgwrd7ldjZtDmjn45RA9/uh3UP2yog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxzOSLtG;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEEC606A31F
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 16:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DEEC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxzOSLtG
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3b4be95e0afso182554a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 08:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452846; x=1796057646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7UR94Er5BqhFrRYk1QbhHUlLQc2SlLi1Cmg4CSQYG1U=;
        b=sxzOSLtGJQ+BuRHajhKDGpJSMRmx8ZiqROL8NCU/7vmoobzr3tFNkiO/Le+/wFPCN4
         L7vqiTnL7HEUwtaRINp2urMi4hUR+a0b4CMwUba7xTwapJI7n2sonB9JJ3183agZwxMi
         ZgyG6yJDQ9HtJjs8W0+8FfqI5mbxMGDr0wqgp5i7jPiSN1fCZKQbTpd6gGhbMImT0u1d
         7jaPuRDk2mcY71gWdI+RmvSB0Dznrp/G6rcbucrN1FQMgGOa8v0Pqa+ym2MoF71WQLXm
         OXq6f747kU3pBef3r06/Z2+bWAzWx4HT1Nw9FTgxrGRENaG7cz5neMhpbKUDV79qzZps
         DQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452846; x=1796057646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7UR94Er5BqhFrRYk1QbhHUlLQc2SlLi1Cmg4CSQYG1U=;
        b=puAk55DeN1NjDRun5UrIDuX7BXtnlhVIMwhhYOg/PtMW3zXgOvzkS3A89q9LSAUt46
         189o8J+Oaxkm4tX9+7h0/WvPvtuiPxt+baNgH2XueSdQh1JhmqIYrRk2jjvs2yXlw7We
         wBuBnp4mM1SWSttPcpMvLm0VeFCDSIp76bd/GU2LgJIQLIE5R7evrkzIwXAsfo4R9S1B
         YqialJ0Hc9thaRZfNMWJIAIqQNvMFXE06zfrHTrJWnB0Z3uoNMlFDAvBSKTHulikX1s9
         HpiW4c3P5XU2J+be6mlLo43rYj/LaQTm1KNN7CKkkcdeWr1WADcNnwYFf8eRfZTtzbIx
         Mg+Q==
X-Gm-Message-State: APuU4Z8SI6CqyvfcFtWwVdpH6Ae+XewoQgv8XDakM+qzl92/B5/rXFmL
	/KE5q7fZMDDyFsNTRYjJv++xT+zx+PZr2tw0kwyRflb5w5FvT/DiC9Jejhp6XAqm
X-Gm-Gg: AZFdTZdBu/yrjj2OYEktNSykLkoSGkbldBiK6vAikz57JdKXw0cui9oke0htLXvP45p
	SWd3hESYlACKxehaS2jbcwDvS8jcIiSNs2Ghp0yLgGjp2tGzBAh1Tif9G6hBlCYbuWXJRyY2xEt
	qLFO/ZJKs9juVyLNJVi0IkwdM11SdhFC8ZPKazramYtVQQMNqBKi6jDpjcSHIVCbC7MWzkgthtR
	aatpcA4V7qhj9P2dR06PYh2V2oRDPszDgE9QhZnHzDygW95sYQuIzNIqZ43ZmAn/iaVxpX5oq16
	/1RxeHoSTMC6NFmGDNyXDmH/yU356D65WaRCRw0n7v9y4I7Wig4VGC2WD7/0WJpjMLI9bTpqL3L
	GP32CCK71M0SDldY/tQbmhh4SzaYeL/a0tsUo51a+Lm/XefnDloiD0KNqufyG2ZTeb552l4iqhm
	bs54sXoQMqHu8FpdjdWr/EDWmNn1i5D6b4krdqNP2tbAJfVBGNycdIH7mnTZpuwuJ5TKmI2W09j
	hPXesMpzraCXKQZDoBp7sEne8ZDMEp+QOy3n1mTkaCjtKd0q/vgmI2OfFqS5Ue9qy7/86K6vUTk
	QkUDzNL3hDpexk4x905vAQhAgyo9deRkjF8uo5cRs56vBJMvr66kof9axA+R0KafmJrml+di07Q
	Zqw==
X-Received: by 2002:a17:90b:4ac5:b0:3ad:b7d1:8631 with SMTP id 98e67ed59e1d1-3b41c8d95cfmr11438729a91.17.1795452845785;
        Mon, 23 Nov 2026 08:54:05 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b457a58d04sm6880922a91.0.2026.11.23.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:54:05 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: kees@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	john.johansen@canonical.com
Cc: linux-security-module@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] yama: fix use-after-free read of a dead PR_SET_PTRACER tracer
Date: Tue, 24 Nov 2026 00:53:57 +0800
Message-ID: <20261123165357.4092273-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A PR_SET_PTRACER relation stores a bare pointer to the tracer's
task_struct.  When the tracer dies, its task_struct is freed via
call_rcu(), and the relation is only marked invalid from
security_task_free(), i.e. from the same RCU callback that frees the
task.  A reader that enters rcu_read_lock() after the callback was
queued is not protected against it: ptracer_exception_found() can read
relation->invalid while it is still false and then dereference the
already freed tracer in task_is_descendant().

This is a slab-use-after-free read during ptrace access checks, e.g.
via process_vm_readv(), on mainline v7.4-rc4 (KASAN build):

BUG: KASAN: slab-use-after-free in task_is_descendant+0x1a3/0x1b0
Read of size 4 at addr ffff88810a46c598 by task poc/167
CPU: 6 UID: 1000 PID: 167 Comm: poc
Call Trace:
 <TASK>
 kasan_report+0xce/0x100
 task_is_descendant+0x1a3/0x1b0
 yama_ptrace_access_check+0x2ea/0x410
 security_ptrace_access_check+0x34/0x50
 ptrace_may_access+0x26/0x40
 mm_access+0x139/0x200
 process_vm_rw_core.constprop.0+0x1ab/0x7c0
 process_vm_rw+0x188/0x230
 __x64_sys_process_vm_readv+0xdd/0x1b0
 do_syscall_64+0xea/0x4f0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Keep the tracer's struct pid alive for the lifetime of the relation and
resolve it with pid_task() under RCU at access-check time.  Pinning the
task_struct itself would not work: the relation is only invalidated from
yama_task_free(), which runs when the tracer's task_struct is finally
released, so a task reference would keep the relation, and therefore the
task, alive forever.

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Fixes: 93b69d437eff ("Yama: add RCU to drop read locking")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 security/yama/yama_lsm.c | 42 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index cef3776cf3b2d..fd394c24e4357 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -29,7 +29,16 @@ static int ptrace_scope = YAMA_SCOPE_RELATIONAL;
 
 /* describe a ptrace relationship for potential exception */
 struct ptrace_relation {
+	/*
+	 * The tracer task cannot be pinned here: the relation is only
+	 * invalidated from yama_task_free(), which runs when the tracer's
+	 * task_struct is finally released.  Holding a task reference would
+	 * stop that from ever happening.  Keep the tracer's struct pid
+	 * alive instead, which is enough to look the task up safely under
+	 * RCU, and use the plain pointer for identity comparisons only.
+	 */
 	struct task_struct *tracer;
+	struct pid *tracer_pid;
 	struct task_struct *tracee;
 	bool invalid;
 	struct list_head node;
@@ -39,6 +48,19 @@ struct ptrace_relation {
 static LIST_HEAD(ptracer_relations);
 static DEFINE_SPINLOCK(ptracer_relations_lock);
 
+/*
+ * Free a relation after an RCU grace period, dropping the reference
+ * the relation holds on the tracer's pid.
+ */
+static void yama_relation_free(struct rcu_head *rcu)
+{
+	struct ptrace_relation *relation =
+		container_of(rcu, struct ptrace_relation, rcu);
+
+	put_pid(relation->tracer_pid);
+	kfree(relation);
+}
+
 static void yama_relation_cleanup(struct work_struct *work);
 static DECLARE_WORK(yama_relation_work, yama_relation_cleanup);
 
@@ -121,7 +143,7 @@ static void yama_relation_cleanup(struct work_struct *work)
 	list_for_each_entry_rcu(relation, &ptracer_relations, node) {
 		if (relation->invalid) {
 			list_del_rcu(&relation->node);
-			kfree_rcu(relation, rcu);
+			call_rcu(&relation->rcu, yama_relation_free);
 		}
 	}
 	rcu_read_unlock();
@@ -149,6 +171,7 @@ static int yama_ptracer_add(struct task_struct *tracer,
 
 	added->tracee = tracee;
 	added->tracer = tracer;
+	added->tracer_pid = tracer ? get_task_pid(tracer, PIDTYPE_PID) : NULL;
 	added->invalid = false;
 
 	spin_lock(&ptracer_relations_lock);
@@ -158,7 +181,7 @@ static int yama_ptracer_add(struct task_struct *tracer,
 			continue;
 		if (relation->tracee == tracee) {
 			list_replace_rcu(&relation->node, &added->node);
-			kfree_rcu(relation, rcu);
+			call_rcu(&relation->rcu, yama_relation_free);
 			goto out;
 		}
 	}
@@ -323,11 +346,22 @@ static int ptracer_exception_found(struct task_struct *tracer,
 	list_for_each_entry_rcu(relation, &ptracer_relations, node) {
 		if (relation->invalid)
 			continue;
-		if (relation->tracee == tracee) {
-			parent = relation->tracer;
+		if (relation->tracee != tracee)
+			continue;
+
+		if (!relation->tracer) {
+			/* PR_SET_PTRACER_ANY: any tracer is allowed. */
+			parent = NULL;
+			found = true;
+			break;
+		}
+
+		parent = pid_task(relation->tracer_pid, PIDTYPE_PID);
+		if (parent) {
 			found = true;
 			break;
 		}
+		/* The tracer is gone; this relation grants no exception. */
 	}
 
 	if (found && (parent == NULL || task_is_descendant(parent, tracer)))
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802290;
	b=NYsU7mB8Lb9jK1gURxuy2Yo090DbtFlIWpIuuDY6CREcdu+TcY2nfFILpyC+MIZOAj3f
	 GB6yIQrnVau7zq4HwLJurVUTZWp5WtXXGoDnNwJhSOCW1WZ1b/tTsCBlXEDwevubnY0Fc
	 S0A848ECXLJSJ1S6+y+mnK7zEIB1l14HYru9k6RPjppHcCQOmznUmi2XpgAi2/V66Nhg4
	 spNSMZRHslFcC9Jp+fYZ3myJF5NwssTtCKoQBtgkL3d+x5Jm6XO74ODAtxb7pwlw6X16x
	 deK0P7+/tQE1xkk27MCz60SZOJx9tEt/fspHOebODvSFj3OuZ9j6R5aV8bXPWSpQhkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=49oPa45zrh2c1m1GL3JZQ3LJ8IgKAaLTpn11OJ5t0GQ=;
	b=ryf1lofH43lS+E86i9shV4x3p120L0pWxFFLSGpXERE6Me2msFQnUZHBe1eoSFTLrs3q
	 CENkD3dDDQ2+r6Yl2e/Q1h/jd4tDDm8B0SpTMR6H1jUbs4Me6dw3mbs4CTZv1sGwu5uP+
	 inzXEafslRTTxnafnZa4TsugpxdMpccTOEuG+bdq77hCSkEoGlyEtTB9memTP6FPfg/bT
	 Ns+zSTbwwgC1nyQZv+HB7VtVzk9cW7IxjzYPgEWLjVWM5vPNvzUStwQT+ELEjG8r08d9u
	 q3Eo4Y4JTjrmEAS9RD7ZipocLXGv173q8ZSTPuWjInBvehFHwgLz1oEmZs/NcsqjNRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=eImnh9c5;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B797606A337
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B797606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=eImnh9c5
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7cc013095d4so174964137.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 06:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802289; x=1794407089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=49oPa45zrh2c1m1GL3JZQ3LJ8IgKAaLTpn11OJ5t0GQ=;
        b=eImnh9c59XVrGWdrtf3pvi3k1BD+yXh1ZM/l2oiUm/0atnDUtExsgRKGGWZvZ1E+dJ
         An91u8qzbU2Bq90RBsVykntNa6QkYcff1hrkEN2VPEZlcSVzJxqQObmbHNlJktEt8yIu
         JoUlvewYYyNEZitAyXiLScsjJTqS6iqa2Yjqc7HjYqQjOV0y5+RPICxrcbHLIGnbV1oe
         tuMrf/LmL4+WXgbIyGWiNLdmxq+QEoMde0SzlwubTZey/IbSid69F4DNKH14pC5L1FF/
         aZrd8ElfywePmHHAvDZ1tzQbjHzOa2CdmsYDdX+fhx0CzGSY11E3wYHgU5tMS0IkLIiE
         0XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802289; x=1794407089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=49oPa45zrh2c1m1GL3JZQ3LJ8IgKAaLTpn11OJ5t0GQ=;
        b=1VPpOfoLReQtpWP0Fw90VUB65Zl4xm/Zii06w1VJku2sI45pmMKPA0kVbyN7g01cB7
         0pUlJiP/wwY2C/GuT+a0KaLx8teHJEfVNb8w2GxlbCZzptif9GTNCpxZcKu2mrqz/e7Z
         msgsoN4QBZIr28AcTUYS3FmQooOPuv7zMAHn0AAnWVFVM/RDbvk6d6hi1zD6GvSopwvt
         jkjMYgH46HtjAjYfKVSDvLmZACKT/FMDbs6pjS2bg3rMeDTMrLP9pysI8P8erLxOekXW
         pTSPL3PyIqRioJNEGimVAOuhxrNHgIIQU4njsmPExt3id4BL8LYgkRjE4OKoiaONO0u7
         qaAA==
X-Forwarded-Encrypted: i=1; AKwUvBzAbf8TD9T6jJnZgOdQ6Ci4p3bZsr3hRveXWMU82sqa2VCJYRRRR4t3yULfoO014Hgbm50FjOXeOQy57pxB0WDL4mR5eLY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xqSKPrsiCJYpmwwaGwyrWibvEx/wPxbMmbY3UP+3zK/IjOX8q
	FeUK0JIUc3J3cp8vzd82C7ExN9mIDfwoIvIMnvZwoZgNfkKSvzVV/T+6ElQ5JhH7Ig8=
X-Gm-Gg: AYBFou1GF/AJBZB/AwdTWN3ZLkjOOes+5EzFg7p8Oos4AvMNaHAVrUs7RPpi0rB3xQA
	g5Z0xxGaClMA1nV0Xq2CCdV7EmrssAmyp5bpoUNPEqj4LI1oAUeissDOnCrLvtSpoIuAVzB/1mW
	vxkU07HeY2Znlbk68n0t/kxJcYciMNL4eUcxqtRz2nk85nYd0D/Mp5rs07k5Af3EROlPrdqwZCY
	CNfqXxSg/PNddX8JPaBYOLPS/pZzf4+L01UjsCzSHbfS2uZSDxEOmhSnavs2Yb+KExX+Awtkn4p
	G1mx5qXjCjgRHmRWbPn8/ep2XjRR+kOGP2b0SxomO9PrcrdYoJakyHEDnTsV49Fi1MbEFdlDlFJ
	khfRBlCRooSkFT8FRqZQ8/9Ep4NWIQQmRUmGDCcQi0sfTmKH+IjeUDn0cJwyCaP1TIaSVNWrHI0
	tscKUW11/PZwSlVh6QBc6wiw+uZNY3e6o0/pcn9cIZLKSFFjXLMGU/G7XO6c1tbAJmNXV+yQPYP
	HWvRXy1CTj4hD2VVV/6+H/xYho5iJW2L1G284/vELREYJ1GKsuRWjzrqmrqQ1r5TRV5Tiq9Kryt
	EdXPJgH30bmnAKrQTKKz+qFk/ZU2gQGVIg2D725Sj0dvtQ==
X-Received: by 2002:a05:6102:548b:b0:7c3:6466:3155 with SMTP id ada2fe7eead31-7d072d2ca10mr5409983137.33.1793802288828;
        Wed, 04 Nov 2026 06:24:48 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2829d28d0sm243565137.2.2026.11.04.06.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:24:46 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:29 +0000
Subject: [PATCH v2 02/13] cred: add KUnit tests for the id rules
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-cred-ids-v2-2-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=10174;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=PbbC82f2/K/HPbh7V3nbpnG7Z51PQgNDlIQfWE/UMLw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM9PgXsYeAdU1KKlNbIkGtebw+alIpoaAxc2AEKOuGKUYbcSgZ9jFBuaBmoMvz6zlks4Mg2Rp5R
 I06fiDBfw/AY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Hold each of the new functions against the expression it is about to
replace, word for word as it stands where it is used, for every
combination of a few ids, 0 among them: 729 combinations of three uids
each for subject and object, and 4096 of the twelve ids that
cred_ids_allow_control() can look at.

That the conversions which follow change nothing then does not have to be
taken on trust.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 MAINTAINERS         |   1 +
 kernel/Makefile     |   1 +
 kernel/cred_kunit.c | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug   |  13 ++++
 4 files changed, 233 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..0bc2c39eb417 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7126,6 +7126,7 @@ S:	Supported
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
 F:	include/linux/cred.h
 F:	kernel/cred.c
+F:	kernel/cred_kunit.c
 F:	rust/kernel/cred.rs
 F:	Documentation/security/credentials.rst
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 4ff92e24680c..da712b4399ff 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -140,6 +140,7 @@ obj-$(CONFIG_RSEQ) += rseq.o
 obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
 
 obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
+obj-$(CONFIG_CRED_KUNIT_TEST) += cred_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 obj-$(CONFIG_USER_NS_MAP_KUNIT_TEST) += tests/user_ns_map_kunit.o
 
diff --git a/kernel/cred_kunit.c b/kernel/cred_kunit.c
new file mode 100644
index 000000000000..b3a54e8c565f
--- /dev/null
+++ b/kernel/cred_kunit.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the rules by which the ids of one credential allow it to act
+ * on another, see "One task acting on another" in kernel/cred.c.
+ *
+ * Each rule is held against the expression it replaced, word for word, as it
+ * stood where it was used, for every combination of a few ids.
+ */
+#include <kunit/test.h>
+#include <linux/cred.h>
+#include <linux/uidgid.h>
+
+/* Root, since two of the rules know it, and two others. */
+static const uid_t ids[] = { 0, 1000, 1001 };
+#define NR_IDS	ARRAY_SIZE(ids)
+
+static void set_uids(struct cred *cred, unsigned int *n)
+{
+	cred->uid = KUIDT_INIT(ids[*n % NR_IDS]);
+	*n /= NR_IDS;
+	cred->euid = KUIDT_INIT(ids[*n % NR_IDS]);
+	*n /= NR_IDS;
+	cred->suid = KUIDT_INIT(ids[*n % NR_IDS]);
+	*n /= NR_IDS;
+}
+
+/* NR_IDS to the power of six: three uids each for the subject and the object. */
+#define NR_UID_COMBINATIONS	(NR_IDS * NR_IDS * NR_IDS * NR_IDS * NR_IDS * NR_IDS)
+
+static void uid_combination(unsigned int n, struct cred *cred, struct cred *tcred)
+{
+	memset(cred, 0, sizeof(*cred));
+	memset(tcred, 0, sizeof(*tcred));
+	set_uids(cred, &n);
+	set_uids(tcred, &n);
+}
+
+/* kill_ok_by_cred() and kill_as_cred_perm() */
+static bool old_signal(const struct cred *cred, const struct cred *tcred)
+{
+	return uid_eq(cred->euid, tcred->suid) ||
+	       uid_eq(cred->euid, tcred->uid) ||
+	       uid_eq(cred->uid, tcred->suid) ||
+	       uid_eq(cred->uid, tcred->uid);
+}
+
+/* sigio_perm(), which had the uid and the euid of the owner in @fown */
+static bool old_sigio(const struct cred *fown, const struct cred *cred)
+{
+	return (uid_eq(fown->euid, GLOBAL_ROOT_UID) ||
+		uid_eq(fown->euid, cred->suid) || uid_eq(fown->euid, cred->uid) ||
+		uid_eq(fown->uid,  cred->suid) || uid_eq(fown->uid,  cred->uid));
+}
+
+/* check_same_owner(), twice */
+static bool old_sched(const struct cred *cred, const struct cred *pcred)
+{
+	return (uid_eq(cred->euid, pcred->euid) ||
+		uid_eq(cred->euid, pcred->uid));
+}
+
+/* set_one_prio_perm() */
+static bool old_nice(const struct cred *cred, const struct cred *pcred)
+{
+	if (uid_eq(pcred->uid,  cred->euid) ||
+	    uid_eq(pcred->euid, cred->euid))
+		return true;
+	return false;
+}
+
+/* set_task_ioprio() */
+static bool old_ioprio(const struct cred *cred, const struct cred *tcred)
+{
+	if (!uid_eq(tcred->uid, cred->euid) &&
+	    !uid_eq(tcred->uid, cred->uid))
+		return false;
+	return true;
+}
+
+/* __cgroup1_procs_write() and rdtgroup_task_write_permission() */
+static bool old_move(const struct cred *cred, const struct cred *tcred)
+{
+	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
+	    !uid_eq(cred->euid, tcred->uid) &&
+	    !uid_eq(cred->euid, tcred->suid))
+		return false;
+	return true;
+}
+
+static void cred_ids_uid_rules(struct kunit *test)
+{
+	struct cred *cred, *tcred;
+	unsigned int n;
+
+	cred = kunit_kzalloc(test, sizeof(*cred), GFP_KERNEL);
+	tcred = kunit_kzalloc(test, sizeof(*tcred), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cred);
+	KUNIT_ASSERT_NOT_NULL(test, tcred);
+
+	for (n = 0; n < NR_UID_COMBINATIONS; n++) {
+		uid_combination(n, cred, tcred);
+
+		KUNIT_EXPECT_EQ_MSG(test, cred_ids_allow_signal(cred, tcred),
+				    old_signal(cred, tcred), "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test, cred_ids_allow_sigio(cred, tcred),
+				    old_sigio(cred, tcred), "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test, cred_ids_allow_sched(cred, tcred),
+				    old_sched(cred, tcred), "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test, cred_ids_allow_sched(cred, tcred),
+				    old_nice(cred, tcred), "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test, cred_ids_allow_ioprio(cred, tcred),
+				    old_ioprio(cred, tcred), "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test, cred_ids_allow_move(cred, tcred),
+				    old_move(cred, tcred), "combination %u", n);
+	}
+}
+
+/* __ptrace_may_access(), with the ids it picked by its mode */
+static bool old_ptrace(kuid_t caller_uid, kgid_t caller_gid,
+		       const struct cred *tcred)
+{
+	if (uid_eq(caller_uid, tcred->euid) &&
+	    uid_eq(caller_uid, tcred->suid) &&
+	    uid_eq(caller_uid, tcred->uid)  &&
+	    gid_eq(caller_gid, tcred->egid) &&
+	    gid_eq(caller_gid, tcred->sgid) &&
+	    gid_eq(caller_gid, tcred->gid))
+		return true;
+	return false;
+}
+
+/* check_prlimit_permission() */
+static bool old_prlimit(const struct cred *cred, const struct cred *tcred)
+{
+	return (uid_eq(cred->uid, tcred->euid) &&
+		uid_eq(cred->uid, tcred->suid) &&
+		uid_eq(cred->uid, tcred->uid)  &&
+		gid_eq(cred->gid, tcred->egid) &&
+		gid_eq(cred->gid, tcred->sgid) &&
+		gid_eq(cred->gid, tcred->gid));
+}
+
+/* keyctl_session_to_parent() */
+static bool old_session_to_parent(const struct cred *mycred,
+				  const struct cred *pcred)
+{
+	if (!uid_eq(pcred->uid,	 mycred->euid) ||
+	    !uid_eq(pcred->euid, mycred->euid) ||
+	    !uid_eq(pcred->suid, mycred->euid) ||
+	    !gid_eq(pcred->gid,	 mycred->egid) ||
+	    !gid_eq(pcred->egid, mycred->egid) ||
+	    !gid_eq(pcred->sgid, mycred->egid))
+		return false;
+	return true;
+}
+
+/*
+ * Two values for each of twelve ids: uid, euid, fsuid and their gids for the
+ * subject, uid, euid, suid and their gids for the object.
+ */
+#define NR_CONTROL_COMBINATIONS	(1U << 12)
+
+static void cred_ids_control_rule(struct kunit *test)
+{
+	struct cred *cred, *tcred;
+	unsigned int n;
+
+	cred = kunit_kzalloc(test, sizeof(*cred), GFP_KERNEL);
+	tcred = kunit_kzalloc(test, sizeof(*tcred), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cred);
+	KUNIT_ASSERT_NOT_NULL(test, tcred);
+
+	for (n = 0; n < NR_CONTROL_COMBINATIONS; n++) {
+		cred->uid    = KUIDT_INIT(1000 + !!(n & BIT(0)));
+		cred->euid   = KUIDT_INIT(1000 + !!(n & BIT(1)));
+		cred->fsuid  = KUIDT_INIT(1000 + !!(n & BIT(2)));
+		cred->gid    = KGIDT_INIT(1000 + !!(n & BIT(3)));
+		cred->egid   = KGIDT_INIT(1000 + !!(n & BIT(4)));
+		cred->fsgid  = KGIDT_INIT(1000 + !!(n & BIT(5)));
+		tcred->uid   = KUIDT_INIT(1000 + !!(n & BIT(6)));
+		tcred->euid  = KUIDT_INIT(1000 + !!(n & BIT(7)));
+		tcred->suid  = KUIDT_INIT(1000 + !!(n & BIT(8)));
+		tcred->gid   = KGIDT_INIT(1000 + !!(n & BIT(9)));
+		tcred->egid  = KGIDT_INIT(1000 + !!(n & BIT(10)));
+		tcred->sgid  = KGIDT_INIT(1000 + !!(n & BIT(11)));
+
+		KUNIT_EXPECT_EQ_MSG(test,
+				    cred_ids_allow_control(cred, CRED_IDS_FS, tcred),
+				    old_ptrace(cred->fsuid, cred->fsgid, tcred),
+				    "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    cred_ids_allow_control(cred, CRED_IDS_REAL, tcred),
+				    old_ptrace(cred->uid, cred->gid, tcred),
+				    "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    cred_ids_allow_control(cred, CRED_IDS_REAL, tcred),
+				    old_prlimit(cred, tcred), "combination %u", n);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    cred_ids_allow_control(cred, CRED_IDS_EFFECTIVE, tcred),
+				    old_session_to_parent(cred, tcred),
+				    "combination %u", n);
+	}
+}
+
+static struct kunit_case cred_ids_cases[] = {
+	KUNIT_CASE(cred_ids_uid_rules),
+	KUNIT_CASE(cred_ids_control_rule),
+	{}
+};
+
+static struct kunit_suite cred_ids_suite = {
+	.name = "cred_ids",
+	.test_cases = cred_ids_cases,
+};
+kunit_test_suite(cred_ids_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the id rules of credentials");
+MODULE_LICENSE("GPL");
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec13a..c548e660dc5c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2806,6 +2806,19 @@ config HASH_KUNIT_TEST
 	  This is intended to help people writing architecture-specific
 	  optimized versions. If unsure, say N.
 
+config CRED_KUNIT_TEST
+	bool "KUnit test for the id rules of credentials" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the unit test for the rules by which the ids of one
+	  credential allow it to act on another, cred_ids_allow_signal() and
+	  friends. Each rule is held against the expression it replaced.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config RESOURCE_KUNIT_TEST
 	tristate "KUnit test for resource API" if !KUNIT_ALL_TESTS
 	depends on KUNIT

-- 
2.55.0


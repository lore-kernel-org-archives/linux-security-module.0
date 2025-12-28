Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F48B63B9
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766885363; cv=none; b=WxPwJ8rcv3LW+EDAaTT+P4BvnDP8c6F88i2WaxZiOu1INBq5un4Xfp3MQ/E8wPQ6Xj8KHdNJUmbfdaGzGFCFqDpbVSLSmO6/rX7DVd66b/huRVwQyrsQCdEfdVStwR/61EYSwCPFclLgnsMEm0W4nOTJ7xlGGMfhvpFT3D5cINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766885363; c=relaxed/simple;
	bh=yaMu2GQ8lMJHRzKDGqbc10RXZ9MenM8mRXD81zhvduY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Su5prFhJpsu9LbFZmI6DnRuvsQsi7cTxp9zv10ozPmMRvD4UzZpxWRgBNMy1b62btNZ6s4oIhj5IeyhhL+maIx5VdOXPcORiBTTJmziYvDe3Ar5kdvgeZq4CbBRxuGjhCq5Cvp6NvMpQ1n8e91dk/8Ne2/QWqB7Y9Fi2YRi3O2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Lw0mc3y8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bHo550lT; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Lw0mc3y8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bHo550lT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9AD8EEC010D;
	Sat, 27 Dec 2025 20:29:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 27 Dec 2025 20:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766885360;
	 x=1766971760; bh=Ds7jGxLk8KVI+3aYYiaNgO65OvpcvIrPNeM+3RXrMIU=; b=
	Lw0mc3y857egbJSKywmwKzyRgNtWF8naBpkjfXj+Kx1IgXtv3Mo3JeJVwW6Y2gsF
	1tPJJ7yBE8S2t+Ocee24+JdyIg5Re7mBczDIruuZ0Mteelgb8U2Z3laxrV/0sFbD
	S/zN2MO8GuRettbnvJmDGiZxg6pLncMJgpkAbj+qLLix++l118lB5JiBxWWC4Okv
	teWMSqEBEVmTdJGfto+YG+DVoO3yIUNPwv96XAhjrtOjcGQkKsjt9hsWoVY+xIgi
	2ANJk3fDzAm9kXajx0EQi2SYl+UpIKqmF3VtLIyTgKM4GCZNb0zEwnJvCRzDcnRK
	GQOdwl2YRgzFvX2SjXtYfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766885360; x=
	1766971760; bh=Ds7jGxLk8KVI+3aYYiaNgO65OvpcvIrPNeM+3RXrMIU=; b=b
	Ho550lTUnPShKubw840NfFqowyCAMRuL3AEX7pJUP/+H8ER8drGKwceb5Eu6rtLF
	GMVIJlYzM5T4SJpom/XOO5mvD/mnhLXqu1V/+UvameYH/wgu+sDgH2wVxxYuJjUA
	xt4LcdRXM2+e/KD+X5eqdVCfOrpQaaWNNX5kfMaOFRyVqhkD/7vi4D6XpG1le3DW
	9pQWOpxJshmhNtobMDzDVhXzpeVwvdBmKX73YK7nRqztFgozCxz6cYBT2HdNxQeM
	1qpv6oRkvvB2iHY55YLt0r2LPUjbXV548aFP+W8McpBQuKC5sCfl0cg0YtUI2T8W
	qX0oM3HDEDb4f0/AAr3yw==
X-ME-Sender: <xms:8IdQadvFN2geYD61Q--joVCJtlWrhoZNAeLo4lBRZybAMW2VRtvUOw>
    <xme:8IdQadXmkuZ6S2IyowFkUCTq2KRSg1xuWEiyx-3scU7yMLxvueKfu-3pQK1gh9nM6
    fI-SaYp32ZVgAv2debmAw-dfL741VJ9s6B170rlzLVAXZegO0MM4e8>
X-ME-Received: <xmr:8IdQaZE5Xk2VSnO5KcNPzeCm5_C8MBfiMd4XufUBdrBK_cPeaK58iQmO9NnRtZ3bUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejvdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeiie
    eggeehtdffieffhfekueffhefhveeugfdvkeejkeehvdettdfgvdeghfdujeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdroh
    hrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehfrghhihhmihhtrghhvghrrgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8IdQaf3yI-7Lpj9QE-jyfls3sGmgcrVvRqQVVsN5DM5l31jjLe4qfQ>
    <xmx:8IdQabOA700h-DaK1_qtFJ6BwlTx1jtPyHg_m9m2_6VV3p-ICO_Tzg>
    <xmx:8IdQae73mj889eC0wrXpJm3nEeKpxfUIMo7oq0wVzH5Eded1env0kA>
    <xmx:8IdQaV2sXJn2tsV0BiasadsW3RJIWhR-A31LW1SqsTXaLk140tmL5w>
    <xmx:8IdQaaRY5Ddi16ZOv9Lg_E8AImkMayJ7MuDwXnoVewLPvtGXsD6bfH2A>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 20:29:19 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH 4/5] selftests/landlock: Use scoped_base_variants.h for ptrace_test
Date: Sun, 28 Dec 2025 01:27:34 +0000
Message-ID: <48148f0134f95f819a25277486a875a6fd88ecf9.1766885035.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766885035.git.m@maowtm.org>
References: <cover.1766885035.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ptrace_test.c currently contains a duplicated version of the
scoped_domains fixture variants.  This patch removes that and make it use
the shared scoped_base_variants.h instead, like in
scoped_abstract_unix_test and scoped_signal_test.

This required renaming the hierarchy fixture to scoped_domains, but the
test is otherwise the same.

Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 .../testing/selftests/landlock/ptrace_test.c  | 154 +-----------------
 .../selftests/landlock/scoped_base_variants.h |   9 +-
 2 files changed, 12 insertions(+), 151 deletions(-)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 4e356334ecb7..4f64c90583cd 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -86,16 +86,9 @@ static int get_yama_ptrace_scope(void)
 }
 
 /* clang-format off */
-FIXTURE(hierarchy) {};
+FIXTURE(scoped_domains) {};
 /* clang-format on */
 
-FIXTURE_VARIANT(hierarchy)
-{
-	const bool domain_both;
-	const bool domain_parent;
-	const bool domain_child;
-};
-
 /*
  * Test multiple tracing combinations between a parent process P1 and a child
  * process P2.
@@ -104,155 +97,18 @@ FIXTURE_VARIANT(hierarchy)
  * restriction is enforced in addition to any Landlock check, which means that
  * all P2 requests to trace P1 would be denied.
  */
+#include "scoped_base_variants.h"
 
-/*
- *        No domain
- *
- *   P1-.               P1 -> P2 : allow
- *       \              P2 -> P1 : allow
- *        'P2
- */
-/* clang-format off */
-FIXTURE_VARIANT_ADD(hierarchy, allow_without_domain) {
-	/* clang-format on */
-	.domain_both = false,
-	.domain_parent = false,
-	.domain_child = false,
-};
-
-/*
- *        Child domain
- *
- *   P1--.              P1 -> P2 : allow
- *        \             P2 -> P1 : deny
- *        .'-----.
- *        |  P2  |
- *        '------'
- */
-/* clang-format off */
-FIXTURE_VARIANT_ADD(hierarchy, allow_with_one_domain) {
-	/* clang-format on */
-	.domain_both = false,
-	.domain_parent = false,
-	.domain_child = true,
-};
-
-/*
- *        Parent domain
- * .------.
- * |  P1  --.           P1 -> P2 : deny
- * '------'  \          P2 -> P1 : allow
- *            '
- *            P2
- */
-/* clang-format off */
-FIXTURE_VARIANT_ADD(hierarchy, deny_with_parent_domain) {
-	/* clang-format on */
-	.domain_both = false,
-	.domain_parent = true,
-	.domain_child = false,
-};
-
-/*
- *        Parent + child domain (siblings)
- * .------.
- * |  P1  ---.          P1 -> P2 : deny
- * '------'   \         P2 -> P1 : deny
- *         .---'--.
- *         |  P2  |
- *         '------'
- */
-/* clang-format off */
-FIXTURE_VARIANT_ADD(hierarchy, deny_with_sibling_domain) {
-	/* clang-format on */
-	.domain_both = false,
-	.domain_parent = true,
-	.domain_child = true,
-};
-
-/*
- *         Same domain (inherited)
- * .-------------.
- * | P1----.     |      P1 -> P2 : allow
- * |        \    |      P2 -> P1 : allow
- * |         '   |
- * |         P2  |
- * '-------------'
- */
-/* clang-format off */
-FIXTURE_VARIANT_ADD(hierarchy, allow_sibling_domain) {
-	/* clang-format on */
-	.domain_both = true,
-	.domain_parent = false,
-	.domain_child = false,
-};
-
-/*
- *         Inherited + child domain
- * .-----------------.
- * |  P1----.        |  P1 -> P2 : allow
- * |         \       |  P2 -> P1 : deny
- * |        .-'----. |
- * |        |  P2  | |
- * |        '------' |
- * '-----------------'
- */
-/* clang-format off */
-FIXTURE_VARIANT_ADD(hierarchy, allow_with_nested_domain) {
-	/* clang-format on */
-	.domain_both = true,
-	.domain_parent = false,
-	.domain_child = true,
-};
-
-/*
- *         Inherited + parent domain
- * .-----------------.
- * |.------.         |  P1 -> P2 : deny
- * ||  P1  ----.     |  P2 -> P1 : allow
- * |'------'    \    |
- * |             '   |
- * |             P2  |
- * '-----------------'
- */
-/* clang-format off */
-FIXTURE_VARIANT_ADD(hierarchy, deny_with_nested_and_parent_domain) {
-	/* clang-format on */
-	.domain_both = true,
-	.domain_parent = true,
-	.domain_child = false,
-};
-
-/*
- *         Inherited + parent and child domain (siblings)
- * .-----------------.
- * | .------.        |  P1 -> P2 : deny
- * | |  P1  .        |  P2 -> P1 : deny
- * | '------'\       |
- * |          \      |
- * |        .--'---. |
- * |        |  P2  | |
- * |        '------' |
- * '-----------------'
- */
-/* clang-format off */
-FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_domain) {
-	/* clang-format on */
-	.domain_both = true,
-	.domain_parent = true,
-	.domain_child = true,
-};
-
-FIXTURE_SETUP(hierarchy)
+FIXTURE_SETUP(scoped_domains)
 {
 }
 
-FIXTURE_TEARDOWN(hierarchy)
+FIXTURE_TEARDOWN(scoped_domains)
 {
 }
 
 /* Test PTRACE_TRACEME and PTRACE_ATTACH for parent and child. */
-TEST_F(hierarchy, trace)
+TEST_F(scoped_domains, trace)
 {
 	pid_t child, parent;
 	int status, err_proc_read;
diff --git a/tools/testing/selftests/landlock/scoped_base_variants.h b/tools/testing/selftests/landlock/scoped_base_variants.h
index d3b1fa8a584e..7116728ebc68 100644
--- a/tools/testing/selftests/landlock/scoped_base_variants.h
+++ b/tools/testing/selftests/landlock/scoped_base_variants.h
@@ -1,8 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Landlock scoped_domains variants
+ * Landlock scoped_domains test variant definition.
  *
- * See the hierarchy variants from ptrace_test.c
+ * This file defines a fixture variant "scoped_domains" that has all
+ * permutations of parent/child process being in separate or shared
+ * Landlock domain, or not being in a Landlock domain at all.
+ *
+ * Scoped access tests can include this file to avoid repeating these
+ * combinations.
  *
  * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2019-2020 ANSSI
-- 
2.52.0


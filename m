Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A61EE7AB;
	Sun,  2 Mar 2025 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931642; cv=none; b=sYK2Cm/AbMV6D5dm7naDkdBBnuEW8wARnLQZQKTsGr3Y1G4zLaA0xi5DNlAPaRNy0IETpPlBFRFqJRHrmMrc9JjoM9pBnAKGEsTtwZF5FvGv/Ug0/DWwdeQ4Bf10xGRovTRBtKcG+f6fvdl5RoN140u+JwqZGgvz1T8ZFwera2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931642; c=relaxed/simple;
	bh=q4kLq85gsyUAnl8du8+7CG1shloC+EIB+wENgTVQN6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCZWdIolro01pbhEx5QML0pFISLw12mqvGmv1L7abV4sQ4Oo+EeB7xHTaRFGjtH0RGgKp3JLv52CsA7wEoLxu7bZ1qqCzkhI2gfeWMEvko+LQvnrd5b2P8Ms/QZQgQfdltdvKs4+D4PF5/SKIuMbBbnjiPCSTyZQtIRSSH6jM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=I8Us6+ww; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="I8Us6+ww"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931638;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DocaNsuHjM+N41rLqaAWsZ7H9Gb/g9wp09AAVVo026g=;
	b=I8Us6+wwEBsSw3c/3WEDogDmTjcrUN78W4pRQk/r8mUCE4HL31uoClsJaAivN/3V/6XqD8
	BADNH6reL9sZ1mS76cvitfZJDq3G1BGl+enF4gm2K8k32JUnxEyAUcqOxUGsmrOA1D17BU
	j2QbCRtr+f0eRBa9AGgDd63jkxRchptmeA4Al/MXKqCbWsQar+koAeeJtx/zXrtfUPIdyM
	vWfOfR2T8mkQ84ROq/wPTQdQbX6HOzsQBKMTC3V4XgBydnCuO05Lg5hslRvQBmxn56F5OE
	jZ7z+rIuMwFKWRm4XYAEEFsV7U6Vfxk9y/J4DSWMND/c+kbkc34Hf3CVBRSG4w==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr
Subject: [PATCH v2 01/11] coccinelle: Add script to reorder capable() calls
Date: Sun,  2 Mar 2025 17:06:48 +0100
Message-ID: <20250302160657.127253-11-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 MAINTAINERS                                |  1 +
 scripts/coccinelle/api/capable_order.cocci | 98 ++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 scripts/coccinelle/api/capable_order.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..b1d1c801765b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5196,6 +5196,7 @@ F:	include/linux/capability.h
 F:	include/trace/events/capability.h
 F:	include/uapi/linux/capability.h
 F:	kernel/capability.c
+F:	scripts/coccinelle/api/capable_order.cocci
 F:	security/commoncap.c
 
 CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
diff --git a/scripts/coccinelle/api/capable_order.cocci b/scripts/coccinelle/api/capable_order.cocci
new file mode 100644
index 000000000000..4150d91b0f33
--- /dev/null
+++ b/scripts/coccinelle/api/capable_order.cocci
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Checks for capable() calls of the left side of a binary expression.
+/// Reordering might avoid needless checks, LSM log messages, and more
+/// restrictive LSM security policies (e.g. SELinux).
+/// Can report false positives if the righthand side contains a nested
+/// capability check or has side effects.
+///
+// Confidence: Moderate
+// Copyright: (C) 2024 Christian Göttsche.
+// Options: --no-includes --include-headers
+// Keywords: capable, ns_capable, sockopt_ns_capable
+//
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  Pattern to ignore
+//----------------------------------------------------------
+
+@ignore@
+identifier F1 = { capable, ns_capable, sockopt_ns_capable };
+identifier F2 = { capable, ns_capable, sockopt_ns_capable };
+binary operator op,op1,op2;
+expression E;
+position p;
+@@
+
+(
+F1@p(...) op F2(...)
+|
+E op1 F1@p(...) op2 F2(...)
+)
+
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+@ depends on patch@
+identifier F = { capable, ns_capable, sockopt_ns_capable };
+binary operator op,op1,op2;
+expression E,E1,E2;
+expression list EL;
+position p != ignore.p;
+@@
+
+(
+-  F@p(EL) op E
++  E op F(EL)
+|
+-  E1 op1 F@p(EL) op2 E2
++  E1 op1 E2 op2 F(EL)
+)
+
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+@r1 depends on !patch exists@
+identifier F = { capable, ns_capable, sockopt_ns_capable };
+binary operator op,op1,op2;
+expression E, E1, E2;
+position p != ignore.p;
+@@
+
+(
+*  F@p(...) op E
+|
+*  E1 op1 F@p(...) op2 E2
+)
+
+
+//----------------------------------------------------------
+//  For org mode
+//----------------------------------------------------------
+
+@script:python depends on org@
+p << r1.p;
+@@
+
+cocci.print_main("WARNING opportunity for capable reordering",p)
+
+
+//----------------------------------------------------------
+//  For report mode
+//----------------------------------------------------------
+
+@script:python depends on report@
+p << r1.p;
+@@
+
+msg = "WARNING opportunity for capable reordering"
+coccilib.report.print_report(p[0], msg)
-- 
2.47.2


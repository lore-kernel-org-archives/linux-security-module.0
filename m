Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9DF1AB501;
	Mon, 25 Nov 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531242; cv=none; b=UXkNvetqqVNon92V5oOEegDzy/h2OPTvoBceg8rYs8HQezown9JqWK2/8l95dRCuwrpLwMXDJmjxgImeDVxnkSMtXLEC3OjyhAstfRVnT9Yn2dSFtMLovv1zt6Vfao2nr8hk3VMxYvroKoF6Yr8t0G6mFcCHqv5oy3DsNORceqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531242; c=relaxed/simple;
	bh=PSaQOMGKr/Ve7TwzTNQdr5+VuDZ1b8z2M3mr2p+Da48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdF0w3KwqYHlUYh6ZcK5yD2Tiq/YZh6rh07JW338ABTxn8qJ4KhhDySzsQWTAgRaCPIft5BzuxzC/aPsd2Ggjlq1EVw3VDDObqiy1FToh2PBlDqzRLsvACnrfFtmiY1EFQxTDztX/QVEevmpy9NNl9/ofVPLcqQM2h+SeEMFHbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=jSKVqFEx; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="jSKVqFEx"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531238;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5x0yPCIryoiXTXe24z13INkplAFzoVmn1x49aPuCCtY=;
	b=jSKVqFExQSaxinJXOrSxNiS3t8Eipge1vhRHBNJjhjCz4n+7KScfgPxBuo3b46kSVLhJ2j
	0UXhFTBuKx0joSbRghed5bds0gNwtkpqrBXIrEoXXXFKSX8qE9F0glBVwfeSpHJWMuHfz2
	nVV0HJum8Ip7bUeU4cuswj8g9PjYLTmNs5vzPTZx7cQt/KD5M6+XKYaJ51YvSi/48XcQ/0
	7c37i7/iZ5dQQDciVeEFDG76UYubJI3Gk7iK28SGmDxf2ZG2FeVzk1vdHvZ91lOAfTaaut
	JWZBvLX+qbBYQn1/zRqcUXDbxu5PwSHYCEUrJraSUnNW55PMAPFq39B1zB9tFw==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr
Subject: [PATCH 01/11] coccinelle: Add script to reorder capable() calls
Date: Mon, 25 Nov 2024 11:40:04 +0100
Message-ID: <20241125104011.36552-11-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
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
---
 MAINTAINERS                                |  1 +
 scripts/coccinelle/api/capable_order.cocci | 98 ++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 scripts/coccinelle/api/capable_order.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index e7f017097701..ab5ea47b61e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5106,6 +5106,7 @@ S:	Supported
 F:	include/linux/capability.h
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
2.45.2


Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3841D33B6EA
	for <linux-security-module@vger.kernel.org>; Wed,  3 Dec 2025 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790651; cv=none; b=fKo0xL7oVg0UO+6+zc5EKYxjAYfiJ7OkG6gTeKw+UIssQWj8xorhHDuI3sG36opfuCgyEHYQjsOZH9XyE3h3HZWF9jBCLBZT4eWQvSMeObRcqYPLWgjIxqKVSGyWVDCFh5ljneM3n2xiVSM1yWbCr2NnPmoqPVdkhxVWpASECVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790651; c=relaxed/simple;
	bh=E0jMcZCjFn2zwvZ/eQSrlu0VGN4vqoFjyaKNHFUcXu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vunc8+T0YYhx4F67qfszgQdX82ETHdn4d1BS0hzX3aOcBsYtQBvffcNLNiAmddquQfmwmKjy3QF5CR9UQZTSR+rIRtVImEEMfcagNKNdgN+uJ7aIJXqdjne7g08vgBjOMge1dA+yunjLy8eanKdb3pKARfXGUGsdPr+vnvuKUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Roxm4L+l; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Roxm4L+l"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42e2b90ad22so92338f8f.2
        for <linux-security-module@vger.kernel.org>; Wed, 03 Dec 2025 11:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764790645; x=1765395445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=raWn2Mn07AjodiXa3v0vYem9nsGju6qXPmJteoPWPUc=;
        b=Roxm4L+lWsbecQaf57P1WCWb/JklgbA9nYrQNlNZPvT2yWAU+4qQx+Nhd/Dhrl8Rb8
         YzX4mHcNq7M1X/TB9XLkZ4OHwhqIHIABXd7rX/aR82mXAs2khEx5j2dETmrQdB5fd++j
         uVn6g5t2s5QU5Hhp48SM5tablfqM7bvfYQHBB32vefUebzBvSMKVIrTn6I5JumPHCJM/
         qXZoYThlkJgqFjzbTDTMj02ruyyGCuLj9WOs7WSctpmvqaikf+O/iwjVAS80HJd3J7Tl
         EPyeI7viu9xOz5e0cLXofNN0foDwElCNEHeMd6TMglaGT4klqxuKg/Yl0HqN1YGjjkW9
         tMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764790645; x=1765395445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raWn2Mn07AjodiXa3v0vYem9nsGju6qXPmJteoPWPUc=;
        b=qzs7x71sQc/BhYL3xNrAsnXTdzipCh7ifEm5bUuUu1GryKdVD/tyIs0pCyIcyflPH+
         Y9bO0oxdFLOPAI3qmD50UnoZ6U0giIyTY2c6kckivYDcJoWPAhgp0FehJdbxbjgw1OCU
         zX+lVMrdSnkQqCN/rL2h0HPbMHd0MF5OxMiwYA8pbgUUiLpHP2yyindbyak0HOxs5FzN
         YJ6DQ579dxxUFOQ7LX7c5vA2ZPP0765To/T2k2w5byBliIrzck0zdCk2wGkSrGWTEuQv
         hSgsa4G+nsvxZ643Hhvuv0D4UDB5Nk7aiTHLkqvSlzZTVK5r0JFQtzYEhP9J2XFo4HtA
         VRfw==
X-Forwarded-Encrypted: i=1; AJvYcCXgZSIk2Fg0j0P+jLLUU40id4PrTRRg36D+7QmdN+t9rmIJ1x14G/XDBioSkG2+pXrNDDrIqRdBaH55mEDMcrS40viWHNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvFmNoZOasO9Sae1+Xdev3LDN/HTNc9p12HQOjatx172JW+R4F
	ujPt83UQrPQqQvOZmXDsd2U42+C90oRZ3dx1FJcGVc6E4ht4a2qS/sUeaqY/vftG+Kg/Qg==
X-Gm-Gg: ASbGnctyy5sV8HivbN46duChtmspoQNyhhrP+PW1WfIrAkYKnZreuLIp0gvDML0eJDd
	HLUagoUpi4ObUFoyJXYIbXUDozuIDNOh5JWzgeoHnte8Io3MBN01y6XkZ5clj+7mMXJo+rLeWcM
	cALe79/R1HrRwrmEKashSvz+r7sFBDSLCrO0oXTZe9qertbiH2GSNgPFT7Wu/GWScEaDJFEjbom
	InTZxuILSYUK2IRO/JwJXgkSt0+iRJJYreheNd7EApWhWRh5M/aAwfhotteUBHoC1dpnF+a7q9j
	we5SYA50retn5OVmoQF6B+ZOTVIZvA9sv9iSpjujGMMVyJE/sy5ifxamFaEMJh6EjVo5Xl5W7fD
	wZj7CndhmCA0WBk+Mmzzzt/6ST3lIjYlAj6FsYL5hLoMpJgfgXmKEadX93p7oyR3xddslrxRfuB
	NCzp1MOb0nvc+BLsY4yevyqGPF
X-Google-Smtp-Source: AGHT+IHz5ldqxl2N9EpMExjf8C1snbhBsHrs3zCB7S7EkoA7iTO+pYJvPw1dlCLvUiNM7CKHNvO5iQ==
X-Received: by 2002:a05:6000:2003:b0:42b:3062:c647 with SMTP id ffacd0b85a97d-42f7317d539mr3515125f8f.21.1764790644799;
        Wed, 03 Dec 2025 11:37:24 -0800 (PST)
Received: from Arch-Spectre.dur.ac.uk ([129.234.0.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c30b8sm41232412f8f.7.2025.12.03.11.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:37:24 -0800 (PST)
From: Yicong Hui <yiconghui@gmail.com>
To: wufan@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: Yicong Hui <yiconghui@gmail.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipe: remove headers that are included but not used
Date: Wed,  3 Dec 2025 19:37:17 +0000
Message-ID: <20251203193718.504344-1-yiconghui@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove headers that are included but not used in audit.c, audit.c,
policy.c within the IPE module

Change have been tested through kunit, kernel compiles and passes kunit
tests

Signed-off-by: Yicong Hui <yiconghui@gmail.com>
---
 security/ipe/audit.c     | 1 -
 security/ipe/policy.c    | 1 -
 security/ipe/policy_fs.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index de5fed62592e..5064f2257e32 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -8,7 +8,6 @@
 #include <linux/types.h>
 #include <crypto/sha2.h>
 
-#include "ipe.h"
 #include "eval.h"
 #include "hooks.h"
 #include "policy.h"
diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index 1c58c29886e8..fe7e8c571ab3 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -6,7 +6,6 @@
 #include <linux/errno.h>
 #include <linux/verification.h>
 
-#include "ipe.h"
 #include "eval.h"
 #include "fs.h"
 #include "policy.h"
diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
index 9d92d8a14b13..90c37949378c 100644
--- a/security/ipe/policy_fs.c
+++ b/security/ipe/policy_fs.c
@@ -8,7 +8,6 @@
 #include <linux/dcache.h>
 #include <linux/security.h>
 
-#include "ipe.h"
 #include "policy.h"
 #include "eval.h"
 #include "fs.h"
-- 
2.52.0


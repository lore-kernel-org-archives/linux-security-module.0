Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F276B2BEC2A;
	Wed,  5 Nov 2025 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385190; cv=none; b=CvgoXrufqPaWoOZQKU29KYt+r99e9tBewyInDyI3Mf8Mrih1o84qRFgF87AhctrzHZ0AJPT2hwRykVswFsq6XK26skIC+3A+Wj6MGb6FXXMftqBjKyxJkINJliUmKkcLvelfHZ4CoWapWE1+76FshZTee+Ete7CFRgg1rgXxkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385190; c=relaxed/simple;
	bh=jgJngAPzarV2IyDyBB0a88c9F2vTRvwxzjkkCJOgrII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3l8aaNpt0NfpbGqdjlA5VCqAmilRCg3TjV+tASMqxgYBw9diO/TiaWnpZeWjRq8tIG54W4/L1FTxm0dL1KpPAudTEHOlAvhgc1+y99vjeV5DptYf+Y4y7UpruW1IIh5ZZzBoszXpd8xdoBPCBUp12/eWK7fzOqZsePJXTLUu/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LfeN/s0F; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LfeN/s0F"
Received: from ubuntu.. (unknown [131.107.174.57])
	by linux.microsoft.com (Postfix) with ESMTPSA id 087F2211E327;
	Wed,  5 Nov 2025 15:26:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 087F2211E327
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762385188;
	bh=daYkxbQPaFOfN++2FPGE+dRTIo8sLbr3VwlwzQQEYOo=;
	h=From:To:Cc:Subject:Date:From;
	b=LfeN/s0FlctiRlMbEfD29TPHGLlmCkeaxoxf/TcrYrHnwKt4joIzmQxTkVEAmBZnA
	 +512LZHp4t0UVYDFQQLrFpTPRMNsoHTUkWfeYcUc+c1xfeV1xTD6BGBEoDcA0WmxuA
	 Y2jzliUbWDZjuVXnKgWcue+ao37F18O9l0HrCaSg=
From: Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
To: wufan@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net
Cc: jmorris@namei.org,
	serge@hallyn.com,
	corbet@lwn.net,
	yanzhuhuang@linux.microsoft.com,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] ipe: add script enforcement mechanism with AT_EXECVE_CHECK
Date: Wed,  5 Nov 2025 23:26:13 +0000
Message-ID: <20251105232615.720861-1-yanzhuhuang@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indirect file execution through interpreters (e.g. python script.py, sh
script.sh) should have integrity policy enforced by IPE based on the
rules. Currently, IPE can only enforce policy on the interpreter binary
itself, but has no visibility into the scripts that the interpreter
executes.

Overview
--------

This patch series introduces script enforcement for IPE, allowing integrity
evaluation of indirectly executed scripts through the AT_EXECVE_CHECK flag.

Patch 1 adds the core implementation with ipe_bprm_creds_for_exec() hook
that integrates with the AT_EXECVE_CHECK mechanism.

Patch 2 updates admin guide documentation to explain the script enforcement
mechanism.

The IPE test suite has been updated to include script enforcement tests:
https://github.com/microsoft/ipe/pull/6

Changes since v2:
- update AT_EXECVE_CHECK reference

Changes since v1:
- update the interpreters reference

Yanzhu Huang (2):
  ipe: Add AT_EXECVE_CHECK support for script enforcement
  ipe: Update documentation for script enforcement

 Documentation/admin-guide/LSM/ipe.rst | 17 ++++++++++++++---
 security/ipe/audit.c                  |  1 +
 security/ipe/hooks.c                  | 27 +++++++++++++++++++++++++++
 security/ipe/hooks.h                  |  3 +++
 security/ipe/ipe.c                    |  1 +
 5 files changed, 46 insertions(+), 3 deletions(-)

--
2.43.0


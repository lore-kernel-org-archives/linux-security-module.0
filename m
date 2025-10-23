Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295D1990D9;
	Thu, 23 Oct 2025 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262648; cv=none; b=bQ3qZ7ZBEiXuyBB6Tb0joGROOPFwhsaf/YIToDqlbtXMcHMK3RZUPII6wp6/C8ge290UCsF0Yib8/C6ap+tFvhSiJROuqou5gI33oE3WiVUDH+a4qsD+7pD6u5iQOeiofnfXloct0cASQDBcxBCTS45EZT4Pp46XtcDaMeyg7dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262648; c=relaxed/simple;
	bh=FiKnydBNVEXs4/Q1KtGxapXOwwNN9ankrE65xIY6GdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxkS7dQXCIvUdddmOEt+kGR3LL0P6TvWOBlfGzCm6nEiyGrD9/7VdVQUE5SgItVWSoDHM8PogOIH2YW7D31ZiFTjd0hNHugmLQlvBbvE7Iiv5IsJuQaRL6Cwm22JMWViEmxFJQ1CaYJ22/6S+aZakXXljJ8g09Xqm9YsOpI63f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jDjEGhri; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jDjEGhri"
Received: from ubuntu.. (unknown [131.107.174.57])
	by linux.microsoft.com (Postfix) with ESMTPSA id 54FA6211B7B6;
	Thu, 23 Oct 2025 16:37:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54FA6211B7B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761262640;
	bh=kmIPzPU8gaQ4mvr0usCufx5jzxoD2NeT+T3nxJwApgo=;
	h=From:To:Cc:Subject:Date:From;
	b=jDjEGhriCBjg+S1h0mokCEEMUMH1r6KtM1Vw5VUxqYiTNWWkn/oEW1hHMJvRQEGnW
	 PUBXTL+q6ihLZcenwi9koPYkujIquJzB8wdEeNwnSUGhOMqpQmY89GTM3O44dQ+9P+
	 c9Hd8eOktL7ACskiR4sgwptWRcbE4yAzNILIyQE8=
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
Subject: [PATCH 0/2] ipe: add script enforcement mechanism with AT_EXECVE_CHECK
Date: Thu, 23 Oct 2025 23:36:54 +0000
Message-ID: <20251023233656.661344-1-yanzhuhuang@linux.microsoft.com>
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

Yanzhu Huang (2):
  ipe: Add AT_EXECVE_CHECK support for script enforcement
  ipe: Update documentation for script enforcement

 Documentation/admin-guide/LSM/ipe.rst | 15 ++++++++++++++-
 security/ipe/audit.c                  |  1 +
 security/ipe/hooks.c                  | 27 +++++++++++++++++++++++++++
 security/ipe/hooks.h                  |  3 +++
 security/ipe/ipe.c                    |  1 +
 5 files changed, 46 insertions(+), 1 deletion(-)

--
2.43.0


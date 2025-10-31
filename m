Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEBD339B5A;
	Fri, 31 Oct 2025 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905858; cv=none; b=sVSWP3o7A+GLPM6hH4pKYmOXd42o8qJdfmH46tXf4ufF/f75wit7qtnmYE8XJZBtffRBmF0xD1XKQF63MnBhHiXemRfo60V2tcv2oAFyEaB4xWTCTzXboIoqzpsKh6inybp5lyELG5ElfWYauJKxVv42SE3PuRUz7RkEbOCdJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905858; c=relaxed/simple;
	bh=a5p8ACO4QiOwrrFK+Bus/GpC10B9MNKMUx8x155MRhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocE9bIMKReZWCC9H5dHNV+fJbH1yQNLNk9tWTj+z7dJmEMp9JYE1uU87WRjS7tcaxEIQUZ7jA9gZWTrWCYiDsqO0BPQVRc+YW5eNIeylZIYRA6wnkTd3OkkVZivMuh4Vf3FZgXA2ZANDjk86qUQ2fg3+OObBW/6n6N6A3UMacJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cW2MnDJx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cW2MnDJx"
Received: from ubuntu.. (unknown [131.107.174.57])
	by linux.microsoft.com (Postfix) with ESMTPSA id 62856211D8DB;
	Fri, 31 Oct 2025 03:17:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 62856211D8DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761905856;
	bh=KSc9kzqkXrK0RQncMPSCHb0oE2nqu4S9E5C7wYM6fro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cW2MnDJxzeiKTJ3lvR0ucV2pySR26urerSGWu1GgwkuEHXDTadTSkBkVlcN10qO17
	 CZsWGSUzjSroCGvP7dA+GQUysjEAS9YF0KBlqg7wuzwtG21u7OlJgbUmUQYvJYufSg
	 wC8ZcmQ2+7nfim2BMV6kZB+4DETTvymuxFbtJQLo=
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
Subject: [PATCH v2 0/2] ipe: add script enforcement mechanism with AT_EXECVE_CHECK
Date: Fri, 31 Oct 2025 10:16:58 +0000
Message-ID: <20251031101700.694964-1-yanzhuhuang@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023233656.661344-1-yanzhuhuang@linux.microsoft.com>
References: <20251023233656.661344-1-yanzhuhuang@linux.microsoft.com>
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

 Documentation/admin-guide/LSM/ipe.rst | 17 ++++++++++++++---
 security/ipe/audit.c                  |  1 +
 security/ipe/hooks.c                  | 27 +++++++++++++++++++++++++++
 security/ipe/hooks.h                  |  3 +++
 security/ipe/ipe.c                    |  1 +
 5 files changed, 46 insertions(+), 3 deletions(-)

--
2.43.0


Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2CE1F91C7;
	Tue, 29 Apr 2025 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745961792; cv=none; b=oWgiWR37W6XPY0R75Q2CHuKOohhZYUzxooBsdAOPRWv16Fuj5BR172XvOGhkPnBSBKW4UW3lp8pLN0sJgOxmJJPlweNZ/Gp6mxu8REiEDmQbhU4z2eTgvphV3i9V7XC4se0jH710C4iTNcqD5NoCrukl7eXIUA0VcHZVr9AC40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745961792; c=relaxed/simple;
	bh=aRKeSFEkOZ/gwOGfX1YDImDT7eYZ37+4f0OSNTpep7w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=b6IKyUqoA2pnL3PoACjzeJ06HNKUZF03MdNjDyqFfGsPkeZDuMxrym9s51lqiBgN64mDUetNBNp9XYbRGi4x8+LUeCXI8H2uzeZhS3QUF4ltGUbrCKwE/CScv+taPvvpugpEzVjWWl7X7QAKVWPDKOOWUEV2PQY00XqnpzcwRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Wd3goS46; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Wd3goS46"
Received: by linux.microsoft.com (Postfix, from userid 1212)
	id CA0E9204E7C6; Tue, 29 Apr 2025 14:23:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA0E9204E7C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745961790;
	bh=dDcbjfipiCfWLfsuRDJrhkmw4he45mZlyPHUDlgww38=;
	h=From:To:Cc:Subject:Date:From;
	b=Wd3goS46tEUEJvfvChYSl8fYd46iS3vucz1RvI63cROBLJOwyFFYEPdiE68sFt8Lv
	 NcuseVsQgjNIQ8m59/JY7xLW9qtexZaTovv3KtqzpJoa1AX25drJCJSPZ9oB9Ft6GJ
	 3f+GMa0PLs0R2WJn9hTJU0ot/HRVic9+dqkjYU74=
From: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
To: wufan@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	mic@digikod.net
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jasjivsingh_microsoft <jasjivsingh@linux.microsoft.com>
Subject: [RFC PATCH v1 0/1] ipe: added script enforcement with BPRM check
Date: Tue, 29 Apr 2025 14:22:49 -0700
Message-Id: <1745961770-7188-1-git-send-email-jasjivsingh@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

From: jasjivsingh_microsoft <jasjivsingh@linux.microsoft.com>

Currently, IPE only enforces the policy operations for direct
file execution (e.g. ./script.sh). However, indirect file execution
(e.g. sh script.sh) needs to be enforced by IPE based on the rules.

Overview
--------

This patch introduces the `ipe_bprm_creds_for_exec` LSM hook. This hook
specifically targets the `AT_EXECVE_CHECK` scenario [1], allowing IPE to
evaluate the `EXECUTE` operation policy for the script file during the
check phase itself.

[1] https://lore.kernel.org/linux-security-module/20241212174223.389435-1-mic@digikod.net/

Example
--------

ipe_op=EXECUTE ipe_hook=BPRM_CHECK enforcing=1 pid=18571 comm="inc" 
path="/tmp/script/hello.inc" dev="tmpfs" ino=24 rule="DEFAULT action=DENY"

the log message when the IPE policy denies the indirect script execution 
via the 'inc' test interpreter.

The IPE test suite has been updated to include script enforcement tests:
https://github.com/microsoft/ipe/tree/test-suite

jasjivsingh_microsoft (1):
  ipe: add script enforcement with BPRM check

 security/ipe/hooks.c | 23 +++++++++++++++++++++++
 security/ipe/hooks.h |  2 ++
 security/ipe/ipe.c   |  1 +
 3 files changed, 26 insertions(+)

-- 
2.34.1


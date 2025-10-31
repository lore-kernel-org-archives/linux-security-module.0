Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBFF33F372;
	Fri, 31 Oct 2025 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905861; cv=none; b=Bdx+oLmWqDAhqmjL5FaUy86PQlQ2Pn9sfgJorgGc+oWNBxU29oZZtEm6MJTgOj0K5lf8qiVRbqIe7flID08XzHyCR6iTuTPVF3yaI6EGofs2FV/1HafQ9nbAdh2imjqz1pZgpL2mq6WRZF6PcH/nydAfV5uLXVXgpVCQiITmDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905861; c=relaxed/simple;
	bh=npRj2RXUFZlU2cO9NMobnA7pSPSkczGeScDnUdo66G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0j9phse1yqrjrTYeSYXWPFARjQl2AbuQELen/CBOjWu4toXf01vWMxq/o3rLgIeHkwEcaDBevb/LzUfgRqrK+X3Yi+eO4p00rBAbt/EKxQxlTs2prnz7wy4KCB+k0wZZ+hhJA9W9m8TB6Q4Qh44h9/0Br9nyVaVn8UavbTAOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AUV6GpP4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AUV6GpP4"
Received: from ubuntu.. (unknown [131.107.174.57])
	by linux.microsoft.com (Postfix) with ESMTPSA id 546FF211D8DC;
	Fri, 31 Oct 2025 03:17:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 546FF211D8DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761905859;
	bh=A2i5xH5KTXr40A99Hzhc/aUW5RD8StWwacVH2CbWm1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUV6GpP4wi+BZ6pCkO3IkX3Ete+4C82XNWOfvHit5bYS7zbXLGrMcldAffwtgvJ3U
	 P16e5xmBPMs/Bwqhyys5JYXi96VqZYJiXiZFOFrpMBZ6wX9R2/g3ouFbsC7anpzpN9
	 2UlSgivPwknyM4k1ShJXrKQVYXaK8WJeivuWjXo8=
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
Subject: [PATCH v2 2/2] ipe: Update documentation for script enforcement
Date: Fri, 31 Oct 2025 10:17:00 +0000
Message-ID: <20251031101700.694964-3-yanzhuhuang@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031101700.694964-1-yanzhuhuang@linux.microsoft.com>
References: <20251023233656.661344-1-yanzhuhuang@linux.microsoft.com>
 <20251031101700.694964-1-yanzhuhuang@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds explanation of script enforcement mechanism in admin
guide documentation. Describes how IPE supports integrity enforcement
for indirectly executed scripts through the AT_EXECVE_CHECK flag, and
how this differs from kernel enforcement for compiled executables.

Signed-off-by: Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
---
 Documentation/admin-guide/LSM/ipe.rst | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index dc7088451f9d..3f205d7dd533 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -95,7 +95,20 @@ languages when these scripts are invoked by passing these program files
 to the interpreter. This is because the way interpreters execute these
 files; the scripts themselves are not evaluated as executable code
 through one of IPE's hooks, but they are merely text files that are read
-(as opposed to compiled executables) [#interpreters]_.
+(as opposed to compiled executables). However, with the introduction of the
+``AT_EXECVE_CHECK`` flag (see `AT_EXECVE_CHECK <https://docs.kernel.org/userspace-api/check_exec.html#at-execve-check>`__),
+interpreters can use it to signal the kernel that a script file will be executed,
+and request the kernel to perform LSM security checks on it.
+
+IPE's EXECUTE operation enforcement differs between compiled executables and
+interpreted scripts: For compiled executables, enforcement is triggered
+automatically by the kernel during ``execve()``, ``execveat()``, ``mmap()``
+and ``mprotect()`` syscalls when loading executable content. For interpreted
+scripts, enforcement requires explicit interpreter integration using
+``execveat()`` with ``AT_EXECVE_CHECK`` flag. Unlike exec syscalls that IPE
+intercepts during the execution process, this mechanism needs the interpreter
+to take the initiative, and existing interpreters won't be automatically
+supported unless the signal call is added.
 
 Threat Model
 ------------
@@ -806,8 +819,6 @@ A:
 
 .. [#digest_cache_lsm] https://lore.kernel.org/lkml/20240415142436.2545003-1-roberto.sassu@huaweicloud.com/
 
-.. [#interpreters] There is `some interest in solving this issue <https://lore.kernel.org/lkml/20220321161557.495388-1-mic@digikod.net/>`_.
-
 .. [#devdoc] Please see :doc:`the design docs </security/ipe>` for more on
              this topic.
 
-- 
2.43.0


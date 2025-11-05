Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8822F6168;
	Wed,  5 Nov 2025 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385196; cv=none; b=urFC16uiQaPi5VLRjONOAVNS58wMPON/WjXHvFe2Zyd1lDPtA9FuGL+WLySmr6Yd9Sat4QDIELeLX5Ct9UYUvAdD6JqQLYvAxll9saMylaYsZxuJ/Rdvgn11wRlMbGBmYBEN/mS30QfhpaRBhByoFD9BHyuVgluYHAM7hawBhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385196; c=relaxed/simple;
	bh=XUj1itDk6Fs0j99eYL38hRxsBNXp/8pzC7yr7UeJNt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOjuP7EnLs1dOZEQ8qmHd8qV1z8FtIYApHPwcU6kzWH8585+TA48Ix+bdZFm6gxeMZOOPlALOQSEGPG5deY0bqMAkirTthnmUTML2ytulW8mx1kIBr8qnXs5MBGvc8mwiR6LbESOyVKTi0W9K9cWDWPIUOWdW1S1QuJ1/6sd78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cO0u/46g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cO0u/46g"
Received: from ubuntu.. (unknown [131.107.174.57])
	by linux.microsoft.com (Postfix) with ESMTPSA id 511A4211FEAA;
	Wed,  5 Nov 2025 15:26:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 511A4211FEAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762385194;
	bh=y4yWSZvpXNw96xLFnutJZ9rJo+5mrC89tk8wZFQYBRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cO0u/46gO55dJ8/vvpzeezdWQATL1HPM3hhvs5t5cw9mQnUfDkdHhBGU+hztGI5bP
	 GsmHlRtWlsXu0+4FrIN4ByBt6Wme0Bz7hAhniqpn9r6MgaB3tgeFwNBlSywJTujkPt
	 d+yoINO9RhKfzsNyKkJbgPGY7Qr71pkQGmABloi0=
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
Subject: [PATCH v3 2/2] ipe: Update documentation for script enforcement
Date: Wed,  5 Nov 2025 23:26:15 +0000
Message-ID: <20251105232615.720861-3-yanzhuhuang@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105232615.720861-1-yanzhuhuang@linux.microsoft.com>
References: <20251105232615.720861-1-yanzhuhuang@linux.microsoft.com>
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
index dc7088451f9d..a756d8158531 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -95,7 +95,20 @@ languages when these scripts are invoked by passing these program files
 to the interpreter. This is because the way interpreters execute these
 files; the scripts themselves are not evaluated as executable code
 through one of IPE's hooks, but they are merely text files that are read
-(as opposed to compiled executables) [#interpreters]_.
+(as opposed to compiled executables). However, with the introduction of the
+``AT_EXECVE_CHECK`` flag (:doc:`AT_EXECVE_CHECK </userspace-api/check_exec>`),
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


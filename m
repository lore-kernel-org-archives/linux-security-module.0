Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460CD2E2EEF;
	Thu, 23 Oct 2025 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262652; cv=none; b=AYcBxqxMAnHMLgkXd54MjvowgLf8FicVSzMvi6HWvv/NCKn7hEChwYMwhj0qqfZDwJwbv4O2Q7gbCfkWObyio5gWTisKNj6K85lT7UfSfHVzh7IHZE5jzFlRytKDteG2NZI8KT14KlrN5AIkqPRMHmNmVyi63+RlwdfAG7eGjVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262652; c=relaxed/simple;
	bh=a1v3XVDKituKBqX+bCDwry/NI1wSt71v34IZGGFjQAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBpc0ZHHRUa1N572seEqPJQmaL8vmxEjd3cpcD5FPBvUNd+V5ANJaD9Na1Wbkbp5j2AJkDG8jTjREp7gh5dKopkMDoXIt/viRESv2FFNbAQYm1LYjgfnMqahEiPDkYQ2oipTx3x1AZoW0Bf1GRKy7ADEdBfj45wcY3ZrnZgVS1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=opTK39qS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="opTK39qS"
Received: from ubuntu.. (unknown [131.107.174.57])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4965C2118281;
	Thu, 23 Oct 2025 16:37:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4965C2118281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761262645;
	bh=jiBFxJoA8Rn+KVfkh/OKuoz5sR+/TGQDS2103YeNRRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opTK39qSQwW6CwOLOwiaaDYo4XGlRK6IChFea5eFW2Dt35Yv0SCz45Y3nSht4mpqG
	 MI3TpqnKCN6O/8EfZXyougWr7F2xyBZcWLAJ/YfLdeP2bvvQvXn7JY315roxJ8Srig
	 /EwFlZJljt3Um+VOjXtgPus+K9qjo5qpLGcofQ+0=
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
Subject: [PATCH 2/2] ipe: Update documentation for script enforcement
Date: Thu, 23 Oct 2025 23:36:56 +0000
Message-ID: <20251023233656.661344-3-yanzhuhuang@linux.microsoft.com>
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

This patch adds explanation of script enforcement mechanism in admin
guide documentation. Describes how IPE supports integrity enforcement
for indirectly executed scripts through the AT_EXECVE_CHECK flag, and
how this differs from kernel enforcement for compiled executables.

Signed-off-by: Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
---
 Documentation/admin-guide/LSM/ipe.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index dc7088451f9d..1063256559a8 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -95,7 +95,20 @@ languages when these scripts are invoked by passing these program files
 to the interpreter. This is because the way interpreters execute these
 files; the scripts themselves are not evaluated as executable code
 through one of IPE's hooks, but they are merely text files that are read
-(as opposed to compiled executables) [#interpreters]_.
+(as opposed to compiled executables) [#interpreters]_. However, with the
+introduction of the ``AT_EXECVE_CHECK`` flag, interpreters can use it to
+signal the kernel that a script file will be executed, and request the
+kernel to perform LSM security checks on it.
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
-- 
2.43.0


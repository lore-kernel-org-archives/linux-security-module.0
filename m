Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2662396588
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469664; cv=none; b=J+yDNvRpuVMhJtdbJ5NavBEQj1CG+wXXzR5PzT8NnkR1amswfuwlATTjtQxTLzOQ59Ay/VgWjsJp+J01ezJPjPvCS3FEpjJH/wado7UcHuOnmpCc/FI+Y9qszGgg9gkJZ+/fSKSsfa2ReayV5JItqfF2vUIiblOK0kR3AOeq7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469664; c=relaxed/simple;
	bh=WaB0/OBi7Xz0AZ1aEUaODytn+pEkREAfIuXYAwlsKy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+0f2EI1HMBEbw3reGPUNNOFD5tzC/BeAeLiTlE5wQKa7WHc9jA81u0IYZqTNBp3f7s1XycS3c2n45276hkHH5VQsVq2imiHSnwB2LQrNF+VDyERXEoYjXvESPi9Nm0H6RnBWro4qBXF/L65LUWdfo0FbNjYBfPX/d5G9pQygYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCsHPTL+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCsHPTL+"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-487048857f6so2697895f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469661; x=1792074461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ny/9gEnpxHKxqOxqx4ATI59L/h/kxApeZ/xGlP7B7Q4=;
        b=XCsHPTL++YTqy3qn7s7xabwe7/EIKkajN4MyzCc33FRltDSuYv/SURwL/s7gAJxSHA
         SuC17+fpEN/Zr7SO0N62A54mM9gHjYP9lyPFSGXE5gqiLC2FqsFXooJdqZ48+YAZcaTB
         TcfofNTiQFcIZ+DzbmGndHnEq6BC1Eexv0Frv8u2vrhnzekr/c3th1u5yciRXIpZqTzs
         /o9R0tRsko4otOFgmKvriOj7/witSZLjYESyNmZc/7wM/dVcgRPyD+gxpT5GPPP82YRE
         wBge/SdYMtB7Z+04i0DY4Fw5RgnusNLdzE5mMM9sbmFjbkPDPqTq2C+qyTel67TOisDK
         lsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469661; x=1792074461;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ny/9gEnpxHKxqOxqx4ATI59L/h/kxApeZ/xGlP7B7Q4=;
        b=YVcSKmIDLvheeupcU31/QxPY6nXXKkOlfI7lJxx+5ECk8MwIipvXxvTgwR1u9qX9Sm
         lfNs9L0fPvSTkJWlNev+fxoDE+e39ujOOXS4rBM0HhClBDyTH/sPyI2rxe7CXW+UowpD
         K9veSGFMYEu9JMInEWXSSTNPnCdj0rQOHct9+sWK4mQm7E6qcKOwz5RVTiTB8X2a3n5M
         /R2yOxEx98sj1QHhjgolwKW+ruvKKqG0fPRykAnUhrqsRmYuZrwX8R3U+1fVtETQ9ZIX
         3gep33AnvLfV9+CmmKCBNkJELm1v5BXAR5Ygb6qPFSMMo7Mz0pKhlCpEuguqCkXn4CwG
         LmvA==
X-Forwarded-Encrypted: i=1; AKwUvBz3+xOS5srUQYzZNzCVoazj0D/9ORMD/gnOoz9Ck1P0DhLhbfRNLaCzHCHKJOw//A7lnPQgzZJMFkIlubbMKhdOanb8hbA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVxUWLv43r60wckreXFy25fXJ6Rmj4JI/Jofm2a3HRNCpQytqn
	VQPXZuegRrJYgPwLRuJyN5bSlqUQ53QPtQJQXMPFpXQ7FOEIE+v/RGQ2
X-Gm-Gg: AYBFou3h8bUjCmZFXNAmWhvU34QEoUILsyQUYXcudWmlILWkVjyTx7EGMLP7okI+7H5
	OFAVuL5dyMEhClPG/MTFKtQ//wnltholeaKxwAobKEJbyLQ4aNbFf0JxzidehP3P0IDUvBdTurr
	NI2P9FqhIBQ/Os3PyRt2fwqAjA8mrRryuuU9ogY4dHrQlkbvJhzSrGZZAdJRSc4Pff1uUeiCIp3
	I1LBjX6NR6Swey2SBigbElNceIyVOmsWDApGV/nk4JIST85BdLAgoXP+FX5edJuSiqnYYDDS3vb
	UpYpd/Z34WJ6Zq4IHgLXYIy+mjQylxp98dFu7Gh3uJ3Ij6aARviF/rhqgpYptWoxO1iXz6yE8B8
	dIOX3VLLo5kyT/wI/Rvd65P3ujwUPPnDQWlEZLdLx1bvDvjjtwBnink8lEEiFgjIKxAt1qqzOWZ
	awKbIdpYn/Mfxyi5uXLw62E0PONbICedSCahTXgqFkAX+QAsYJRKe9QJKDay6Ngc4tTk1V5f+l4
	Ngo9CrQ1hXLXnIyky6RiiA=
X-Received: by 2002:adf:e19d:0:b0:488:79a2:3232 with SMTP id ffacd0b85a97d-48c7278c0e3mr12010002f8f.31.1791469660708;
        Thu, 08 Oct 2026 07:27:40 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1e9c2sm10964964f8f.30.2026.10.08.07.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:40 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 22/27] selftests/landlock: Fix messages and comments in helper programs
Date: Thu,  8 Oct 2026 16:25:51 +0200
Message-ID: <20261008142604.39107-24-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008142604.39107-2-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* sandbox-and-launch: Describe the actual argument order.
* sandbox-and-launch, wait-pipe, wait-pipe-sandbox: Report failed
  read(2) calls as read failures, not write failures.
* wait-pipe-sandbox: Terminate error messages with a newline, and fix
  comments naming "." instead of the opened "/".

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 .../selftests/landlock/sandbox-and-launch.c      |  6 +++---
 .../selftests/landlock/wait-pipe-sandbox.c       | 16 ++++++++--------
 tools/testing/selftests/landlock/wait-pipe.c     |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/landlock/sandbox-and-launch.c b/tools/testing/selftests/landlock/sandbox-and-launch.c
index 3e32e1a51ac5..8b33ddadc63e 100644
--- a/tools/testing/selftests/landlock/sandbox-and-launch.c
+++ b/tools/testing/selftests/landlock/sandbox-and-launch.c
@@ -25,8 +25,8 @@ int main(int argc, char *argv[])
 	char buf;
 
 	/*
-	 * The first argument must be the file descriptor number of a pipe.
-	 * The second argument must be the program to execute.
+	 * The first argument must be the program to execute.  The second and
+	 * third arguments must be the file descriptor numbers of two pipes.
 	 */
 	if (argc != 4) {
 		fprintf(stderr, "Wrong number of arguments (not three)\n");
@@ -67,7 +67,7 @@ int main(int argc, char *argv[])
 
 	/* Waits for the parent to try to umount. */
 	if (read(pipe_parent, &buf, 1) != 1) {
-		perror("Failed to write to the third argument");
+		perror("Failed to read from the third argument");
 		return 1;
 	}
 
diff --git a/tools/testing/selftests/landlock/wait-pipe-sandbox.c b/tools/testing/selftests/landlock/wait-pipe-sandbox.c
index 87dbc9164430..dbc0c2747e9f 100644
--- a/tools/testing/selftests/landlock/wait-pipe-sandbox.c
+++ b/tools/testing/selftests/landlock/wait-pipe-sandbox.c
@@ -31,7 +31,7 @@ static int sync_with(int pipe_child, int pipe_parent)
 
 	/* Waits for the parent do its test. */
 	if (read(pipe_parent, &buf, 1) != 1) {
-		perror("Failed to write to the second argument");
+		perror("Failed to read from the second argument");
 		return 1;
 	}
 
@@ -65,7 +65,7 @@ int main(int argc, char *argv[])
 
 	/* Tries to send a signal, denied by layer1. */
 	if (!kill(getppid(), 0)) {
-		fprintf(stderr, "Successfully sent a signal to the parent");
+		fprintf(stderr, "Successfully sent a signal to the parent\n");
 		return 1;
 	}
 
@@ -88,13 +88,13 @@ int main(int argc, char *argv[])
 
 	/* Tries to send a signal, denied by layer1. */
 	if (!kill(getppid(), 0)) {
-		fprintf(stderr, "Successfully sent a signal to the parent");
+		fprintf(stderr, "Successfully sent a signal to the parent\n");
 		return 1;
 	}
 
-	/* Tries to open ., denied by layer2. */
+	/* Tries to open /, denied by layer2. */
 	if (open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC) >= 0) {
-		fprintf(stderr, "Successfully opened /");
+		fprintf(stderr, "Successfully opened /\n");
 		return 1;
 	}
 
@@ -115,15 +115,15 @@ int main(int argc, char *argv[])
 	}
 	close(ruleset_fd);
 
-	/* Tries to open ., denied by layer2. */
+	/* Tries to open /, denied by layer2. */
 	if (open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC) >= 0) {
-		fprintf(stderr, "Successfully opened /");
+		fprintf(stderr, "Successfully opened /\n");
 		return 1;
 	}
 
 	/* Tries to send a signal, denied by layer3. */
 	if (!kill(getppid(), 0)) {
-		fprintf(stderr, "Successfully sent a signal to the parent");
+		fprintf(stderr, "Successfully sent a signal to the parent\n");
 		return 1;
 	}
 
diff --git a/tools/testing/selftests/landlock/wait-pipe.c b/tools/testing/selftests/landlock/wait-pipe.c
index 0dbcd260a0fa..3cfa4dce5f35 100644
--- a/tools/testing/selftests/landlock/wait-pipe.c
+++ b/tools/testing/selftests/landlock/wait-pipe.c
@@ -34,7 +34,7 @@ int main(int argc, char *argv[])
 
 	/* Waits for the parent do its test. */
 	if (read(pipe_parent, &buf, 1) != 1) {
-		perror("Failed to write to the second argument");
+		perror("Failed to read from the second argument");
 		return 1;
 	}
 
-- 
2.56.0


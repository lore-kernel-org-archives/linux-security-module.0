Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826586;
	b=tEkw8yB2uEnyAUmTeTPGZh3P6RMdMVeImql4qEKBWyIpyMDKhg7TaKhZnPUvu6FiHaH6
	 jxYmJ24FagAXXDj4/eqXzxQduIn7Y2nBG5NJVR6rTAgiHpkWur3BNGzDbobkcDgqr0wXm
	 o1wpfAhYggDpyCeR1NXbGz90bEdIwwAKp/BYzZacDLm2AInCewhltHCKhlUesDuyM/Vjf
	 2QeCfVMqrdmVhbGJAso2v2ed0uwXHBzJpyiKnvN/vfHgzcAFs0HFXA6iwgAJFj2clfk39
	 NBYKKsG5sIRZpt1gC4Q46qro3AcDc+QsDQ5qO/UTgMhap96kXINRixMyIP46EdsjeCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=iDRVFy6I1yy3Vo/9vdN843HKbuRZWWjAxcnOm4/lGYs=;
	b=J1FGAhk3SQ011XOP/vtnbRBOdin1tTCn9LMa8toCSugwM+hvs8QnjMilDbi/yjsVm7g1
	 kak6gBFsU7LIDxSYnG00KzyMFso70ZkT4MSiV7NV/TmkSi+8l1BPMhTyA/abyomAm4Edx
	 3Gii31s2rMga/QozWBRO8EG7YzlbeCoGvnQdLtWBS5kBTWusUJrB4HPVv3YWxFnGoBMZL
	 Eb/RODicWQbxSfN8fds7vha0XlerHIDlo/cwtkMT2UPy+KWz0mXED6SN2ei0tu3quNLk8
	 7Gn7ghBuJQbZr5NIMlmIA7zRu5s+u+RoGkodpruEmuZWwum8NetAlK9ztzXZncrgpnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YN0v5xCT;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0C607B9DA
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47B0C607B9DA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YN0v5xCT
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso9305305e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826584; x=1794431384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iDRVFy6I1yy3Vo/9vdN843HKbuRZWWjAxcnOm4/lGYs=;
        b=YN0v5xCTD9eqYjRDrox9B7A61G1+SFMIUYQay/ymlVUEBzD+kVNRzZ7FlEgvOJVqyW
         Xy82e6XV0cd+AV6K5WT238vjhOrRtDiq6vPygR4889jEbICVmf1w1bDKHwPfTLME7Quj
         BwhZqF0rAVrNbnHOFyAL9cOwIXM40H6qOtSOWsB5yjPWJYQIZeomuTgT130NUsQuwbu2
         Pbqs8VQqOKBQEd/H4ynbiTvnPlphdVumQpxeCPSLMskleBloYrVLj48dpS9euGOu4d6R
         GDgF81LTbZo2O+Y+nKqU1HWH3B/V38lsGwkJy4NxGq3Z3VSbu7u3sc2JVPsHahRzoFZS
         G/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826584; x=1794431384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDRVFy6I1yy3Vo/9vdN843HKbuRZWWjAxcnOm4/lGYs=;
        b=nowNSFj7u2fhpbieMBRoWYxqGS5btXhkq+mwLQIohZxkggkwPFpruwvUjJQoIzIynP
         LxuVwe3lDY4o8HVTkzV7leimkzRQENyna/ln+StD4Sa/uYuIlvitWnjCC0LtGyFcQ0HQ
         WsQwlP8r+8M0MeEx4CjCKgDrWgVJ/At2Pa3uM/xWEGhyRwEZsm274owooraA59Q/OWUa
         3Sy+sGpuj+foVDpaV9HBPXmNopYbq+M0iOWOSl1jII7Yahh7OEF+RE5bWMBqKVZCo/iU
         08GzEEBPHzMVEQh7NXlynCBfbzeikEUiuDZqP7UP2Y1MtN+MGrG5kBtFZeb9D9X1vnsP
         +stg==
X-Gm-Message-State: APuU4Z+ymApMvGfFSrHI2Lr7ZQcei98ja7v9VwELtrSPOW/6mSJatX9c
	rQeqPBpuUUkbIhgrPA8eEH+ud2Aj2v54VOpHE1b8dVyFKtI85/Mw+fA/
X-Gm-Gg: AYBFou2jRe3p+jDHxPSL6S5HxHjhAULOk4s+Zt3vOC6CIxd6ppwHxXaYoyllnH9GPOj
	1cFWhz0UeuNmoY1JJEmRpllIX/FvBaPGeLFMOFlBL1OOI2lM8YY56zchA1eOZqCJzpJgHeUkKsx
	mReYEcuKXZkAHekH1A917SFYGjiSAU7iYO3MiPgJwVZwnaD5w0WTYu+sx1+JGNzKpYXjeFImYyn
	jls4ZJV1Z8KuNUA7LYNc9d7cvZP/3HBfiZ4QYWE/K4rIiCP+Jz0LfRpk5ftYYQdIBBC8nT36C/t
	fksjUjfmAdD2BV53rwoKOOghqRzhmBlJY9F48t5ZnCDqGcGQ6VehLsWnAEMH8PuGqD7/Ez5yamU
	c2YBghjnKO1CQLVLJDJuP9X6sG3e/Cpkh17qAidoyhIVW2qWd8109ufYVma3POxJn0k9u4UfN7q
	KI9+U1f/6ynDfngxTXnGZjAXiAa/OqyS6jRPSPGLQmyi7f5QuXp+4eoBHFTpyvNWDGXZ5AS6Uv8
	lmH5dXs9c/xHoXQQaPjYsMXU4uTJa+nFRSSYe+tzXKbTiVBOP2q8SBpHvNKYrD+b5O86FF1uNpK
	T9NZjJ+q1wfsFUVPF2ADoEWBjmVWG6Rh1oGbYMaxTM4hMCia+74ivrLlPhSjNZ2bNDUnhCfD6kA
	=
X-Received: by 2002:a05:600c:4e50:b0:4a1:7d9b:d4ae with SMTP id 5b1f17b1804b1-4ac16fa3523mr400681945e9.5.1793826583655;
        Wed, 04 Nov 2026 13:09:43 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4532916f2sm84724225e9.5.2026.11.04.13.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:43 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:09:08 +0100
Subject: [PATCH v2 22/27] selftests/landlock: Fix messages and comments in
 helper programs
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261104-selftests-refactor-v2-22-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

* sandbox-and-launch: Describe the actual argument order.
* sandbox-and-launch, wait-pipe, wait-pipe-sandbox: Report failed
  read(2) calls as read failures, not write failures.
* wait-pipe-sandbox: Terminate error messages with a newline, and fix
  comments naming "." instead of the opened "/".

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/sandbox-and-launch.c |  6 +++---
 tools/testing/selftests/landlock/wait-pipe-sandbox.c  | 16 ++++++++--------
 tools/testing/selftests/landlock/wait-pipe.c          |  2 +-
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


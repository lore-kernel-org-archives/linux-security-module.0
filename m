Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6787320F
	for <linux-security-module@vger.kernel.org>; Tue, 11 Feb 2025 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739280374; cv=none; b=k91N/tcER/C5GviOSCQS8/MeVKtLCYciDMBI9d4EngUa0S98kuQMs8VAlwoxXq40Bc2sQ8kaqPB2uMmow7uJVDzhFIn+VWcoL0t/HaUvjw75shTP5q3NZfQwQLR6fN6pOAGGqMZMHTGn6a4TheFAJiGIGV8UZBVZT5q9TeZRkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739280374; c=relaxed/simple;
	bh=foLtz4YAIIZIFxsL+bD71O1Y2wSQEYbhjmhB/7tGWUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B1y2tFzHTFVkSYP+XIPjjrc6V0InFreyiRBIWr9yWJk1xXnbgiN1rtKgj+zQaDjWnRkqc3m9u2B2XTNAhfMNcp+QrVAGjiYE6xluiEET45mx0smYeW+IXfPaFbAmpwgxsYDzNAXxlu1xGZdZ4VvYL9DLDgt3Ho8mOI/rwijJErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0/mPYFNx; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0/mPYFNx"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YshzD21WVzpvH;
	Tue, 11 Feb 2025 14:26:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1739280360;
	bh=oEI1dLX3z3WnJRwXX4fVmgXzFsVcJphDLTIJHUJ5OaE=;
	h=From:To:Cc:Subject:Date:From;
	b=0/mPYFNx54hTAEE2qfyb6AIN2Yv/hJLqox9Y4CTypfHJpJlYTZLwS2QdivihjFr9b
	 T1c9jKE1H5gT0FZWNxQd38Gzsl5JaqIexJ8aRt60CErdlukY7gYDxJ43BK5m4v+ZAA
	 7ti0ZrOEoLZ2fGNSweznagWQZKo46EPXdMfhelx0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YshzC5mr4zCjj;
	Tue, 11 Feb 2025 14:25:59 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Florent Revest <revest@chromium.org>
Subject: [PATCH v1] selftests/landlock: Enable the new CONFIG_AF_UNIX_OOB
Date: Tue, 11 Feb 2025 14:25:28 +0100
Message-ID: <20250211132531.1625566-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Since commit 5155cbcdbf03 ("af_unix: Add a prompt to
CONFIG_AF_UNIX_OOB"), the Landlock selftests's configuration is not
enough to build a minimal kernel.  Because scoped_signal_test checks
with the MSG_OOB flag, we need to enable CONFIG_AF_UNIX_OOB for tests:

 #  RUN           fown.no_sandbox.sigurg_socket ...
 # scoped_signal_test.c:420:sigurg_socket:Expected 1 (1) == send(client_socket, ".", 1, MSG_OOB) (-1)
 # sigurg_socket: Test terminated by assertion
 #          FAIL  fown.no_sandbox.sigurg_socket
 ...

Cc: Florent Revest <revest@chromium.org>
Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
index 29af19c4e9f9..361f94f8cb0d 100644
--- a/tools/testing/selftests/landlock/config
+++ b/tools/testing/selftests/landlock/config
@@ -1,3 +1,4 @@
+CONFIG_AF_UNIX_OOB=y
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_INET=y
-- 
2.48.1


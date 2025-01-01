Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082503A1CD
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jan 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735733008; cv=none; b=aTcMk4rsYFuHXr4GdTfwWGRoHs5gloLdDxgUiB3DVQwaI0Ba+x5/myOKFm3djQAva94A33BraocSEaFzrhaET/EipY/N9w7gWdU0kNZDWbmxaSW08DJhDK8ojum4s4HbRDjlwhQhn8bVGlKHNReNAe1Pnna+DI1OLeasiSaQIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735733008; c=relaxed/simple;
	bh=wCyWj6sWJmB7gV1BEKe2Zgpyy+BSnR+fb9kcNu+uRbs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZKmSldhEm/qKVZR6Yx7Zb3OTfLVM6yw1VLjUbaoZtoNs9Vf6GR8ZtPnpzbfi18gRPoKVnZ+y04775xhhqExbZ5e/ktcVW1JpbSTceUpd+4YhPj9kR/vbOUSimHeY1X6zE2L36NTR5He56tjBadCfEUY57fo2D5DHJl7L+DZxO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 501C3IPm006949
	for <linux-security-module@vger.kernel.org>; Wed, 1 Jan 2025 21:03:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 501C3Ic2006945
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-security-module@vger.kernel.org>; Wed, 1 Jan 2025 21:03:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5a987f1d-fcf6-4b2e-9efc-6dd08cc2543a@I-love.SAKURA.ne.jp>
Date: Wed, 1 Jan 2025 21:03:18 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-security-module <linux-security-module@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] tomoyo: automatically use patterns for several situations in
 learning mode
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp
X-Virus-Status: clean

The "file_pattern" keyword was used for automatically recording patternized
pathnames when using the learning mode. This keyword was removed in TOMOYO
2.4 because it is impossible to predefine all possible pathname patterns.

However, since the numeric part of proc:/$PID/ , pipe:[$INO] and
socket:[$INO] has no meaning except $PID == 1, automatically replacing
the numeric part with \$ pattern helps reducing frequency of restarting
the learning mode due to hitting the quota.

Since replacing one digit with \$ pattern requires enlarging string buffer,
and several programs access only $PID == 1, replace only two or more digits
with \$ pattern.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/common.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 972664962e8f..dd7eb60da2e9 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2024,6 +2024,32 @@ static void tomoyo_add_entry(struct tomoyo_domain_info *domain, char *header)
 	if (!buffer)
 		return;
 	snprintf(buffer, len - 1, "%s", cp);
+	if (*cp == 'f') {
+		/* Automatically replace 2 or more digits with \$ pattern. */
+		char *cp2;
+
+		/* e.g. file read proc:/$PID/stat */
+		cp = strstr(buffer, " proc:/");
+		if (cp && simple_strtoul(cp + 7, &cp2, 10) >= 10 && *cp2 == '/') {
+			*(cp + 7) = '\\';
+			*(cp + 8) = '$';
+			memmove(cp + 9, cp2, strlen(cp2) + 1);
+		}
+		/* e.g. file ioctl pipe:[$INO] $CMD */
+		cp = strstr(buffer, " pipe:[");
+		if (cp && simple_strtoul(cp + 7, &cp2, 10) >= 10 && *cp2 == ']') {
+			*(cp + 7) = '\\';
+			*(cp + 8) = '$';
+			memmove(cp + 9, cp2, strlen(cp2) + 1);
+		}
+		/* e.g. file ioctl socket:[$INO] $CMD */
+		cp = strstr(buffer, " socket:[");
+		if (cp && simple_strtoul(cp + 9, &cp2, 10) >= 10 && *cp2 == ']') {
+			*(cp + 9) = '\\';
+			*(cp + 10) = '$';
+			memmove(cp + 11, cp2, strlen(cp2) + 1);
+		}
+	}
 	if (realpath)
 		tomoyo_addprintf(buffer, len, " exec.%s", realpath);
 	if (argv0)
-- 
2.43.5


Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4DC145324
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738333899; cv=none; b=REW7fh90dqX7Z8xfJPGWrc7tKVu4zzxZJVUH8DYcXsEoukLHfRsjWUfaI84HBGeD6D+yrv/iAmyIBy6NSzVxoR1L04nrGfBDB6LB5CFPhJTR1F8WtdnGcX5P4G0cvzs9s9NVYaQo7CH09pTw7v2308VcoRPWLil1ffm10pzZUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738333899; c=relaxed/simple;
	bh=df/RxGzAGe6486vCYSrG/pan1I9r0mP8TUkb3beRtoo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=r1WyUwfNiPfeTgpeB2y9B6u6e8L0vU0KqNEpCVEzOGyvWRjE4tiTUqRdpjVfn9D86+b/Obn6WiPLEsglKKxxenZpyERp2lWZmoAik8KGprTpDGhrt9Ea7dYHLclEQ6Kd1kd/rjDmY2lhSQ0PuEoJJqFaPpM3aY7nEvDXGmEgRMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 50VEVSqI094593
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 23:31:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 50VEVS5K094589
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 23:31:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <837690e4-4158-4667-b70a-5a2a2992d11b@I-love.SAKURA.ne.jp>
Date: Fri, 31 Jan 2025 23:31:28 +0900
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
Subject: [PATCH] tomoyo: use better patterns for procfs in learning mode
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp
X-Virus-Status: clean

Commit 08ae2487b202 ("tomoyo: automatically use patterns for several
situations in learning mode") replaced only $PID part of procfs pathname
with \$ pattern. But it turned out that we need to also replace $TID part
and $FD part to make this functionality useful for e.g. /bin/lsof .

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/common.c | 145 ++++++++++++++++++++++++++++++---------
 1 file changed, 112 insertions(+), 33 deletions(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index d9fa69632147..0f78898bce09 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -1980,6 +1980,114 @@ static int tomoyo_truncate(char *str)
 	return strlen(start) + 1;
 }
 
+/**
+ * tomoyo_numscan - sscanf() which stores the length of a decimal integer value.
+ *
+ * @str:   String to scan.
+ * @head:  Leading string that must start with.
+ * @width: Pointer to "int" for storing length of a decimal integer value after @head.
+ * @tail:  Optional character that must match after a decimal integer value.
+ *
+ * Returns whether @str starts with @head and a decimal value follows @head.
+ */
+static bool tomoyo_numscan(const char *str, const char *head, int *width, const char tail)
+{
+	const char *cp;
+	const int n = strlen(head);
+
+	if (!strncmp(str, head, n)) {
+		cp = str + n;
+		while (*cp && *cp >= '0' && *cp <= '9')
+			cp++;
+		if (*cp == tail || !tail) {
+			*width = cp - (str + n);
+			return *width != 0;
+		}
+	}
+	*width = 0;
+	return 0;
+}
+
+/**
+ * tomoyo_patternize_path - Make patterns for file path. Used by learning mode.
+ *
+ * @buffer: Destination buffer.
+ * @len:    Size of @buffer.
+ * @entry:  Original line.
+ *
+ * Returns nothing.
+ */
+static void tomoyo_patternize_path(char *buffer, const int len, char *entry)
+{
+	int width;
+	char *cp = entry;
+
+	/* Nothing to do if this line is not for "file" related entry. */
+	if (strncmp(entry, "file ", 5))
+		goto flush;
+	/*
+	 * Nothing to do if there is no colon in this line, for this rewriting
+	 * applies to only filesystems where numeric values in the path are volatile.
+	 */
+	cp = strchr(entry + 5, ':');
+	if (!cp) {
+		cp = entry;
+		goto flush;
+	}
+	/* Flush e.g. "file ioctl" part. */
+	while (*cp != ' ')
+		cp--;
+	*cp++ = '\0';
+	tomoyo_addprintf(buffer, len, "%s ", entry);
+	/* e.g. file ioctl pipe:[$INO] $CMD */
+	if (tomoyo_numscan(cp, "pipe:[", &width, ']')) {
+		cp += width + 7;
+		tomoyo_addprintf(buffer, len, "pipe:[\\$]");
+		goto flush;
+	}
+	/* e.g. file ioctl socket:[$INO] $CMD */
+	if (tomoyo_numscan(cp, "socket:[", &width, ']')) {
+		cp += width + 9;
+		tomoyo_addprintf(buffer, len, "socket:[\\$]");
+		goto flush;
+	}
+	if (!strncmp(cp, "proc:/self", 10)) {
+		/* e.g. file read proc:/self/task/$TID/fdinfo/$FD */
+		cp += 10;
+		tomoyo_addprintf(buffer, len, "proc:/self");
+	} else if (tomoyo_numscan(cp, "proc:/", &width, 0)) {
+		/* e.g. file read proc:/$PID/task/$TID/fdinfo/$FD */
+		/*
+		 * Don't patternize $PID part if $PID == 1, for several
+		 * programs access only files in /proc/1/ directory.
+		 */
+		cp += width + 6;
+		if (width == 1 && *(cp - 1) == '1')
+			tomoyo_addprintf(buffer, len, "proc:/1");
+		else
+			tomoyo_addprintf(buffer, len, "proc:/\\$");
+	} else {
+		goto flush;
+	}
+	/* Patternize $TID part if "/task/" follows. */
+	if (tomoyo_numscan(cp, "/task/", &width, 0)) {
+		cp += width + 6;
+		tomoyo_addprintf(buffer, len, "/task/\\$");
+	}
+	/* Patternize $FD part if "/fd/" or "/fdinfo/" follows. */
+	if (tomoyo_numscan(cp, "/fd/", &width, 0)) {
+		cp += width + 4;
+		tomoyo_addprintf(buffer, len, "/fd/\\$");
+	} else if (tomoyo_numscan(cp, "/fdinfo/", &width, 0)) {
+		cp += width + 8;
+		tomoyo_addprintf(buffer, len, "/fdinfo/\\$");
+	}
+flush:
+	/* Flush remaining part if any. */
+	if (*cp)
+		tomoyo_addprintf(buffer, len, "%s", cp);
+}
+
 /**
  * tomoyo_add_entry - Add an ACL to current thread's domain. Used by learning mode.
  *
@@ -2003,7 +2111,8 @@ static void tomoyo_add_entry(struct tomoyo_domain_info *domain, char *header)
 	if (!cp)
 		return;
 	*cp++ = '\0';
-	len = strlen(cp) + 1;
+	/* Reserve some space for potentially using patterns. */
+	len = strlen(cp) + 16;
 	/* strstr() will return NULL if ordering is wrong. */
 	if (*cp == 'f') {
 		argv0 = strstr(header, " argv[]={ \"");
@@ -2020,40 +2129,10 @@ static void tomoyo_add_entry(struct tomoyo_domain_info *domain, char *header)
 		if (symlink)
 			len += tomoyo_truncate(symlink + 1) + 1;
 	}
-	buffer = kmalloc(len, GFP_NOFS);
+	buffer = kmalloc(len, GFP_NOFS | __GFP_ZERO);
 	if (!buffer)
 		return;
-	snprintf(buffer, len - 1, "%s", cp);
-	if (*cp == 'f' && strchr(buffer, ':')) {
-		/* Automatically replace 2 or more digits with \$ pattern. */
-		char *cp2;
-
-		/* e.g. file read proc:/$PID/stat */
-		cp = strstr(buffer, " proc:/");
-		if (cp && simple_strtoul(cp + 7, &cp2, 10) >= 10 && *cp2 == '/') {
-			*(cp + 7) = '\\';
-			*(cp + 8) = '$';
-			memmove(cp + 9, cp2, strlen(cp2) + 1);
-			goto ok;
-		}
-		/* e.g. file ioctl pipe:[$INO] $CMD */
-		cp = strstr(buffer, " pipe:[");
-		if (cp && simple_strtoul(cp + 7, &cp2, 10) >= 10 && *cp2 == ']') {
-			*(cp + 7) = '\\';
-			*(cp + 8) = '$';
-			memmove(cp + 9, cp2, strlen(cp2) + 1);
-			goto ok;
-		}
-		/* e.g. file ioctl socket:[$INO] $CMD */
-		cp = strstr(buffer, " socket:[");
-		if (cp && simple_strtoul(cp + 9, &cp2, 10) >= 10 && *cp2 == ']') {
-			*(cp + 9) = '\\';
-			*(cp + 10) = '$';
-			memmove(cp + 11, cp2, strlen(cp2) + 1);
-			goto ok;
-		}
-	}
-ok:
+	tomoyo_patternize_path(buffer, len, cp);
 	if (realpath)
 		tomoyo_addprintf(buffer, len, " exec.%s", realpath);
 	if (argv0)
-- 
2.43.5


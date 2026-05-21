Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835D383334
	for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379631; cv=none; b=n+4E6VZlHWhfbWAlKx9Ek6hSKB1Ts7fz6RfE/+C0HULtyxdApBzx7p58RZu5zkSGpdljgzDSXbEMupHOVLd/BgVlI5o38cvFk2ln/UbofStmE0JWvzlsXUy4sOgU08CufJ0u8KMEHfA1tau11aualPx8KlLjop5PowydK/T5FQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379631; c=relaxed/simple;
	bh=Zw5z54erCSTGg/mG8h8Y1+6Fvw8RXBf25VfL/v6jBIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbRmt4xyk/T17CXv2h9x0KknFi+tAP5KJN6Hbd8nOOul1MJqxEkQ1+WGsKFGl17pwMdbjqH3WQaiEPdRqsTJUTiHceBw0hTVZP9MmeLpyr6W27BJDOuwuXjR9IBrp4fR4xxmEQ9xPL0G5OF8ytOK5V5iYQfMsTfkNNO97sMuEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh8lW5Gr; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh8lW5Gr"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7c0dea734b8so59963937b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779379629; x=1779984429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7j1R7ydUbojI9HTehxoq4C+M0tevraBNI7P2+NL1MOI=;
        b=Fh8lW5Gr6Ue032gluu+ZVND/cqOoxHB88sDaZWmXqzwFX2lwAydp26CSZPtZY2xHyZ
         kMGpz1/JFOJjdcWVMLQsqHz+EZZHuaPCIz9ipeiGYBY5EuUh6paNZ1ERQGL9T8RNDyLF
         1uK9VxkC3I27mOfQjAJTNxm6XTS06p6xIPqOCkQx/4JO7wDHxVLeD6ny7OsFk7aOXyor
         Z6/efaP1q7V9VzVW6itp8ATa2xYLkmbCGqRb9hMrRwJRQTwGdS/zfDzWmME0IMNqrF4W
         0Alc45Weo4a64Wc3BuXsQmKNySdScLJomcSUc40UZSsVCykFbbMrgyz3wLlca2QHPPyO
         UIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779379629; x=1779984429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7j1R7ydUbojI9HTehxoq4C+M0tevraBNI7P2+NL1MOI=;
        b=cdHdgWCQj2bOwJ4tFHMoa47rRI9lGO1Dj4JnwtmCIFyl8DURz3BiyptBjdVfGNOk8X
         kC4CRkfIEwTSt/Iqvadc7ZKg1YbMDyF1sI2SzxLlVj05KefoHPT7OaUZEzeKemjM7K7M
         U9em5CGdlUFGam8Sw/8OEA5fCEtMjT46ijvx9jq7qO49Go+OyMPB6z/K73ecrwXeD8PP
         5PdGgbxqk301FaddMl1GANDe0YjkqEDqDsvY2pPOBsNE/NJ8rKT7ed3GEzpmWN/eJNek
         Nr6ZoVPR5HnVxgZccvbMbVLKr57Lgj6MKrvgmBQgGh3Gnciwh3TolPooi8/3ZQbzu2gt
         3YvA==
X-Forwarded-Encrypted: i=1; AFNElJ+SBnyvt69vcpwT6jw6/ocFSKqcWkWnLWBVIUgegn2EvqO6FRvnU7tipfK0PL20Z/KczIGFcr6SK4eG5glZYZz1Eh6YrKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1XSXPUjx3HhtASZfOPZ1rHXYuWAi8YsOYOTQkfFbzU0POeAhG
	zKKd2u0c+GKCJRyVNrXwQssJFpu9xG6uBjuh3P52u6PnDsRy+oot6Wo1
X-Gm-Gg: Acq92OHsoag92YMiFJ3q5BsCaDt16UHo39P4VvJWt648WoU0VEpFoy79WATeV3UbvMa
	qrkR5DZvw5lx0FJNvWG8rVrSi4VdlMW4tEINNNa9i0hS6lI5azHiTloD+MJo480FY26Ce5s0K6G
	6qEBi6Lw3ipJ/o/aW65JR/I2Wt7+J2sVbkaTWunoZB2cACNecr3esF/J+Cu8Mkz6CikVB2sf7iV
	bwvBw5hFUlP9xw78kUVOrpH/6OfMK/+n0YO1TGMHrBp8AgWzKz7rx42Uz4uU6e050jd3rXE9hPo
	HRwe6Mq0nOa+fQIEkq+vCFOxlTTGdiktp4p+zgjAd4tx2fHmEMZGnyd1kGDnqJ9H+rvMbW7i2jJ
	1XfjQdfM7BXLBMv/wt+9HS5Oz2QUGeuqoi8JnAeZEnSe83CvHYP33lBxU3S4qRYZdE20390jYZ0
	N3CAB3bsv6ItJGN6E8DCXsMn2x6NbVLN2R0WIyv2+oRnXftSWLCA5/IXiyLxk9Lt1vPSZ0Bmzd1
	DMzP0cDSQ==
X-Received: by 2002:a05:690c:6202:b0:79a:6249:a046 with SMTP id 00721157ae682-7d209cd3355mr34423037b3.9.1779379628872;
        Thu, 21 May 2026 09:07:08 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:c2cf:2e92:9a48:97a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d2c7abad87sm4657587b3.2.2026.05.21.09.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:07:08 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 5/6] samples/landlock: Support LANDLOCK_SCOPE_SYSV_MSG_QUEUE in sandboxer
Date: Thu, 21 May 2026 12:06:39 -0400
Message-ID: <20260521160640.1716746-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521160640.1716746-1-utilityemal77@gmail.com>
References: <20260521160640.1716746-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sandboxer support for the new LANDLOCK_SCOPE_SYSV_MSG_QUEUE access
right.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 samples/landlock/sandboxer.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 66e56ae275c6..689628b87f5f 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -235,10 +235,12 @@ static bool check_ruleset_scope(const char *const env_var,
 	bool error = false;
 	bool abstract_scoping = false;
 	bool signal_scoping = false;
+	bool sysv_msg_queue_scoping = false;
 
 	/* Scoping is not supported by Landlock ABI */
 	if (!(ruleset_attr->scoped &
-	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL)))
+	      (LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL |
+	       LANDLOCK_SCOPE_SYSV_MSG_QUEUE)))
 		goto out_unset;
 
 	env_type_scope = getenv(env_var);
@@ -255,6 +257,9 @@ static bool check_ruleset_scope(const char *const env_var,
 		} else if (strcmp("s", ipc_scoping_name) == 0 &&
 			   !signal_scoping) {
 			signal_scoping = true;
+		} else if (strcmp("m", ipc_scoping_name) == 0 &&
+			   !sysv_msg_queue_scoping) {
+			sysv_msg_queue_scoping = true;
 		} else {
 			fprintf(stderr, "Unknown or duplicate scope \"%s\"\n",
 				ipc_scoping_name);
@@ -271,6 +276,8 @@ static bool check_ruleset_scope(const char *const env_var,
 		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
 	if (!signal_scoping)
 		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_SIGNAL;
+	if (!sysv_msg_queue_scoping)
+		ruleset_attr->scoped &= ~LANDLOCK_SCOPE_SYSV_MSG_QUEUE;
 
 	unsetenv(env_var);
 	return error;
@@ -301,7 +308,7 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 9
+#define LANDLOCK_ABI_LAST 10
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -327,6 +334,7 @@ static const char help[] =
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
+	"  - \"m\" to restrict associating with message queues\n"
 	"\n"
 	"A sandboxer should not log denied access requests to avoid spamming logs, "
 	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
@@ -336,7 +344,7 @@ static const char help[] =
 	ENV_FS_RW_NAME "=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
 	ENV_TCP_BIND_NAME "=\"9418\" "
 	ENV_TCP_CONNECT_NAME "=\"80:443\" "
-	ENV_SCOPED_NAME "=\"a:s\" "
+	ENV_SCOPED_NAME "=\"a:s:m\" "
 	"%1$s bash -i\n"
 	"\n"
 	"This sandboxer can use Landlock features up to ABI version "
@@ -358,7 +366,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
-			  LANDLOCK_SCOPE_SIGNAL,
+			  LANDLOCK_SCOPE_SIGNAL | LANDLOCK_SCOPE_SYSV_MSG_QUEUE,
 	};
 	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
 	int set_restrict_flags = 0;
@@ -444,6 +452,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
 		ruleset_attr.handled_access_fs &=
 			~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
+		__attribute__((fallthrough));
+	case 9:
+		/* Removes LANDLOCK_SCOPE_SYSV_MSG_QUEUE for ABI < 10 */
+		ruleset_attr.scoped &= ~LANDLOCK_SCOPE_SYSV_MSG_QUEUE;
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
-- 
2.53.0


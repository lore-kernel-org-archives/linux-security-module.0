Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A035CB9F
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630163; cv=none; b=Pd1Y3SjFwF/eBNXpaSkRbwaFeU/3inAgJRY3eK/lMDCsThJAQRpa9Lyplj4sGOUsNgmSDDf+IvA05DzV+p+mZnNIQYOPsDKcPkf0FhBf8A0WcGxY9IQPha9hUXN+K8FzRQlRk0EkJf05NNh+zCx46+E5M55RcqT0bv7WG2YoG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630163; c=relaxed/simple;
	bh=2vUGALO9uZKAjCpKbcNBhVMLzh1JWfApkokXuuQ89yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8S85BbMV6mozHJD1tuYSgmCHvJ4IvnuX/4MscT+1kdLt4XjBjyqvpLuM0YfgqdmeKOL9h0ishjAtgBRNHSmBMJBPO54Z8aZCKEOPMwZY8eCnELcOjL+xJa0DFOINZhnewhVeDBaKHkf68P26tQrsuyC6VeRNxEezEXAuuJfSnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVNKCGTl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVNKCGTl"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so22523215e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 09:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630160; x=1775234960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USBSZwtwkVhJyz8WY2h6vy9d6CAM7AC4OGGdtIthKzE=;
        b=dVNKCGTlRfoLWGZ5p9LWoDroml9hlL9C8V2L1Jmtv0O3lrexowX0ZOGyYUAmsUqo27
         jwVXNZxMvfQu0hHQA3l/MKBQA4DjUDUCOMogI7eJiAVbZ6vxwp1LDg3mFxQkBWsOqOxI
         v8HnsIErBIUjrafhzSo3vKPy74LjUO/fwBoVTbek4FCaDUP6R6qi45em2bntsWRpVWC6
         tGLPc89jPBveteCvjL8sgaA8xiY+v4d0ZTRk8NVQ7+yg8JPCsUM5bytUpMOWbiV1Lssb
         D5xwgCkrpBddXm1ui/hPWJ2+Kljhs5yocC6G4Ks3ut5lyEEDCzItnGwxsTuziBujO7rD
         kiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630160; x=1775234960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USBSZwtwkVhJyz8WY2h6vy9d6CAM7AC4OGGdtIthKzE=;
        b=fHIa+B9LceWtT+D47huKnVIBo4QdhpPwD/PT8AXhMWydVNXva5n+Ub2X3EvG0lS5n5
         8CHIFpJ+UVz8m/o0BXn4ovj9EpsUep0E/cyFpfMB+b7BttePnPIuKN46BNm2yjpc2BH5
         sLgnflTojvFzZDAwaxP+C8H7i0RmOw7TtdMcHFxfU8k7ytooY54qRGAhY3+U2scCsoSm
         4LpLWJQCawysZ3m2pOohSuGrGLqkug5N+LjCmmEfssgfm9f3289I4roNKKN6bzCHvuCD
         uU2OG6IULEulDVHx2o00CMHTVBwZ1vr1LvQgbG7TnqsiPu2TlxQC8bJyOA92zIb11KMU
         qoUA==
X-Forwarded-Encrypted: i=1; AJvYcCU/aErow+1KPUT3XcHkONaHtYQfek+GFeZXWU2PIHe0ahUQ7AcBMUC/wphkd5Rlp776YNrVLdEfHUb5C77h62swDhv13hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwZCm2xhVRyUpGPxM9Zl2wyZiB8hF0D65/HzIwmrtMhCYvQey
	WxtesHe27ZPaGwOgrhwEmR9owoZwK7PcTj8NQO2gZBAemxT9tXcMgKED
X-Gm-Gg: ATEYQzyMWI3IjM4/B5bWZa6WopXciqw+KKj8gCQJX7whMan0ZAuHFUG4pg+0ZmdUm2O
	ucLerxtRgrDfwVyMsOA3CtVVXqRqzq09rI75dluD/ty9Q+8LT5uP1wiWrqI1oU6KXXDK/O4NYq+
	GT3jXaFjVmo3wkDcy6/LsOsdfpcrdfTwR1JdFVlkUvYk6AmEKAzRInXCxvsE8oNg4NLyW0VylBE
	EGQrZpESGXk0VO0By1Uw2aTe4rGoXz6/p+wL08dZzVagBFRco3nw4TPORa5FEukL3KQOuPtwCuH
	Gr+dg6xFF53EBy0Xt9PmEUUBayNBesAUoONUv+NsL+i8IFvAbzu/YNGbNytN5/yNjJxZ3TtNWSQ
	ItaSByuRZ+9qIvkE/5klSQmT3JPzEUe6WQAKVNuqpcr2rKw1I27olnKOBuw9JsVqv4mdhk+2g5d
	ndCnC7WqoV2+reELSHmIKJvxoo7Zg/JauMw/amY0QPKqI6M7mG
X-Received: by 2002:a05:600c:c10b:b0:485:3f1c:d8a1 with SMTP id 5b1f17b1804b1-48727d84152mr38429905e9.9.1774630160152;
        Fri, 27 Mar 2026 09:49:20 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487278c71f4sm35256275e9.0.2026.03.27.09.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:49:19 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>,
	"Georgia Garcia" <georgia.garcia@canonical.com>
Subject: [PATCH v8 06/12] samples/landlock: Add support for named UNIX domain socket restrictions
Date: Fri, 27 Mar 2026 17:48:31 +0100
Message-ID: <20260327164838.38231-7-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327164838.38231-1-gnoack3000@gmail.com>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The access right for UNIX domain socket lookups is grouped with the
read-write rights in the sample tool.  Rationale: In the general case,
any operations are possible through a UNIX domain socket, including
data-mutating operations.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 9f21088c0855..66e56ae275c6 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -111,7 +111,8 @@ static int parse_path(char *env_path, const char ***const path_list)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
 
 /* clang-format on */
 
@@ -295,11 +296,12 @@ static bool check_ruleset_scope(const char *const env_var,
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 8
+#define LANDLOCK_ABI_LAST 9
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -438,6 +440,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			~LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
 		__attribute__((fallthrough));
 	case 7:
+	case 8:
+		/* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
+		ruleset_attr.handled_access_fs &=
+			~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
-- 
2.53.0


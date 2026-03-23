Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE373C062C
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285098; cv=none; b=WSJnuz0vMc+/3U83Qdsg+u9E+YUSjFD1NHgs8TVmmbIG3dfaTGrpcVFUrEaFDcecDsNVSTJCKWAbgMkJGoK9wpV6pVZAuXw82okJDJYMsC6jqOzi03OnFBKXHdUSjQlxga1E4Al8NoRmWAQgGXkIPyerVLxsYCg+S0lwtyf05ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285098; c=relaxed/simple;
	bh=2vUGALO9uZKAjCpKbcNBhVMLzh1JWfApkokXuuQ89yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQHYtxU1Vy7TzN1ltkQ8wA9cxXqasmjO3FSjdEideXeRv/TSQfKXgnEOP0vrl53gO9RVWlCAw4xolLYUiMJVSM8Wkb1fzzG1YQ3TOE9IooLpuUuY//shVKidDa82z1AAuzKTPAIF8KlkiDz0whbrw5rZ7AlwxPQLbywpglo6toc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UN1LGhR0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN1LGhR0"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486b9675d36so36253215e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774285095; x=1774889895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USBSZwtwkVhJyz8WY2h6vy9d6CAM7AC4OGGdtIthKzE=;
        b=UN1LGhR0PSQnYAU1cnWKH/kTI+Dwr7fL5e+N0zcoBlm1WKAEmpZ9l4mCompFf5P7Lr
         8SL0j59rx8s56b6OWF8gH2gn9BzILciebcAPFtbWkufHWQ+bTf1teO5OJkDvPTwJJaau
         QE/NMQuPUPvNjtGtZ3bnOsi2+peoTEH9rzsLVmxK3BgneYE7Tmj7pFuWkYlEIk1WgsD/
         k4meX8Av4v39muinNpPbRGtiGOznOanFklpK/Jldn4QaYQS3dDuMYTGzkSFzSFnro09x
         vNP4q8sP17qx8DA68U2ywBo7fkc9A+BQtsBZRIdL6BVvDqxE655ucjrEH9qOE1epOd5z
         fmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285095; x=1774889895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USBSZwtwkVhJyz8WY2h6vy9d6CAM7AC4OGGdtIthKzE=;
        b=nfDY0tN5aK0gdPUQBjlhezGiOpOpys3efaPulcxvE3NhpQF1y52+x+3m/TGxCmVR/L
         Jw+PWgkDbbtbSdPuglpIudCsZ68EHK8QKb/uOAsr/zrgbZGln+jdCSS8VgrUpy6Ut5TT
         5dIJp9a1h03MJaOfgCXJTLdIkRrRcD/lHYC1d6+69wYGE2KpDBqlnwVBXQlgA6xqxMu4
         jzgMatRltWcsfx92fikeXiWThf1bpqLX90XXra34qjOYSfLLS4dSUU7Nvj0YF8XM+Hce
         nWQmJpeilFQo3v9/WJbceStTtwWmGlEAmPHrbydtyRJcSR+ABZWOw7GbA9P0i/AK3ira
         4axw==
X-Forwarded-Encrypted: i=1; AJvYcCX2zXtcnPDsglLz9KFPE/ErnD9JR5WBRNxLek5YxIoQYtQelVuGPy5fX6QCGw1JAYGElmRX51VnFZtgM60lpGC3BzTc0g0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/BUNxF3DUefWOSPtlTraAxop2I2OJuvWip+mUSmsbsJIJZh9U
	U+yI1HPhNWD+OHuPsfqJVlXmqfj/cNUFGR0C2uAeqU9nod2Ocd9Qsf43
X-Gm-Gg: ATEYQzwA3xQUSjYExjzYkawlUlL+iCazgGuXLIu95coliQx7vW4cNvNWGdOHKNT1Zpg
	duY62fT3v9gdpCeIOKgnzy81iR7jkUvOTMZlZs29hrLxhmCLtruGmh716UT8x4vh1x4tfR+qyEx
	0Mg8Az9e2NTZWvz90UHASBKicnsIZpDUzi+0x11ERr6UpYEyqmn95gSJDzzRDBKuseA6rcRWl8q
	Lu2G9+hpOM2v0sqsjZ0VA5GXnILb4iZcpolhN8imlZ+mKhnnpY9vXkaWHjc0KyxB/J2Y4F8xrmu
	Cfq+dj3mPxUEPVb04eJ/lO4jRL/d3H4N4lhNC1XnOimdDHUIr6I4qog/n8OWPOdog3GbU/FD00g
	i42cZP5Qvk8j5WBbVulPk3HwyURYbCzEasiGtiFAUrc05immU7KPyDxnlhRhGGkV5fTtV2sEFkP
	nzA9PrajEIft912roMIl0fvicnM17Y7IHia8rgw1N0PUjx9sp0
X-Received: by 2002:a05:600c:524e:b0:485:3dfc:57a with SMTP id 5b1f17b1804b1-486ff020bc4mr173156015e9.32.1774285094679;
        Mon, 23 Mar 2026 09:58:14 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe6d923fsm474475985e9.1.2026.03.23.09.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:58:14 -0700 (PDT)
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
	"Kuniyuki Iwashima" <kuniyu@google.com>
Subject: [PATCH v7 04/11] samples/landlock: Add support for named UNIX domain socket restrictions
Date: Mon, 23 Mar 2026 17:56:46 +0100
Message-ID: <20260323165654.193957-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165654.193957-1-gnoack3000@gmail.com>
References: <20260323165654.193957-1-gnoack3000@gmail.com>
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


Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13942DA77F
	for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771152759; cv=none; b=Af7Tsxi2llGQ2dpBmUkKcW+9Dt5vc704i8kYWBvzEZ7C+3yYriZ2UzGa5fxyy5VgD1yHxU64l2EePf3l8QvSv0myQ0+P4ZtAMCgRa8QfYESxIIBh4NZOEdJKoBuJqgiX2vwdUpqe8tanJxBHmt8bwza2K6ZV2x4isgbrK/3FG9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771152759; c=relaxed/simple;
	bh=QOm9F4rAdHIw0Y1+r1xirK/H3bmY8d8frKBBirnCKq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hW/4SKjZUULAH1Hcn13DmXYP7jHb6Rvo9XFFkVBwpPsGyP3gP5mfFw4nCiBwrRnuZV0uZV1P8nL8wME64VX4okjIkf6EVUacG52GipBzmvWMe0qKwoM7DgbGrFjjeYY93gqeDEvwcOm1d1PDv1BMn6YL/HScsVBpgvr0T8hgIrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSLMRB+4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSLMRB+4"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43626796202so2073607f8f.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 02:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771152756; x=1771757556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKIbbH25AkZ/XRQpPyQa4nvfKuzS5hDxsm5xC75qvbs=;
        b=DSLMRB+4wRwA8mWnI2vYSlEcrZhE4c25c5T9w4EgQM7mY+3ZiS+de8E/6ZE+19DVan
         RV0mTRYEKeAE15DRSUHTQs7zH4Ara0VUOlads37PvowgLyIufHxfhHi6cDWyTShEJFmy
         pZecAPPKl0qKnE74k5bNM4MLFbDnNd7ecPa0rN0IDOhW0e/xpS1sMjqPdcdh2Rq0QApx
         FTVbY3YA0urlVjnVsgUX25dSbaaCWFNeO1/GyUdAzx43hyqvzrb958L6aarUMGWuDCKS
         P7+a2sAmTKUfSJJKr1L6F54v1x2irLMcIx+FLRw+5gIYEqfdmcV30JNCFOlpwxjZlP+L
         owqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771152756; x=1771757556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZKIbbH25AkZ/XRQpPyQa4nvfKuzS5hDxsm5xC75qvbs=;
        b=xDsuwVkzW02Qv9rq9uhWTxA0LvNA4FqpMoDBpWTDxdpOqx3BJAo3BRMHSaBNCIEI9J
         tk+FqkERmGjo/Mx4oJo1klBbk+/pX0cpkqO922ElA5PxWeD6lN2pJc6JKNYYEL02hGhz
         NeaJ4mxuhjjuZ1mfUz6B8Z3oDf2zPkp5YGEiYQIvdg0fpS2XyW+6EPCTrxgqmpdcGiSA
         rEPxfkNmAnv05Z0a0BwO2gMhMq/ArBNJJZsBcvsFQNCukfJRtrWganOmp1+8FWkfdlko
         4cja9OudTW9BW/fbC9+3tx9tlfNHoGnL/LfU2svl2n6SFMqjlycbgbhrF0ok7i72i7KL
         4y1g==
X-Forwarded-Encrypted: i=1; AJvYcCUjcnIPMELl3UjkwjtU+WdcHpbDl1HU8x2R2lMCzo7+SZRq6B8EAE4WvDfW5F2U8TJTE8WU6gREJ97AVy5U+E66Npu0m/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YydqvoZyoTVqXXKzdKLbEsfxidErOAWVCvEP8rcLxNy0YmrMMFI
	cgVs9V7JQdetxaToJaHZ2P/5nafha8hZb7KroTx/hwerikAoapRyNs6gZ3zPLnq1
X-Gm-Gg: AZuq6aI6RS1Ndi+YXI6cic3ojnUxc+syq0/1/3lgGzFIKn5fPBLAlyQ2HsmmJfxpGiw
	GFL+oCuOSXxCLaOSiLeqaaN8A15Yqjp394MJkSg9kw4odsBGhGqr9ohomJfF+ZALvyT9/ENqK8G
	xAzUMQ2OK+hW/8U8wIlwhYwkiFpK73uWm9alNTv+ZCtHRZecIV910KPTuBo2KKkcUHSqp7qn3FN
	orqTP6G7zcWOFagYi8KVMc+vo06SbbhRwcePkAQrOAOUDVaQuK1z41N1Orqnw5PlIj8MBiHc5cJ
	4X+tOWSWY76RaLkeELiBnkmqR/Hp0SoXXnqxbxwG7Sfvw4oMN9qS+fNOtEMj01l26wUSWeJGgu7
	+0fiq29mEWs8J8CoyNtd5FV4ZXyjtodJ4wf3jWcGnsmJmT0Nw2/LpotZ9yuCEupwQSmzRJ2Aaih
	hH1/yrqdWM+BFuhTr9vBkp5R+BwlRpGMRpRh4MW61RhBnA47AC
X-Received: by 2002:a05:6000:420e:b0:436:8058:449 with SMTP id ffacd0b85a97d-4379792bf56mr15204800f8f.45.1771152756218;
        Sun, 15 Feb 2026 02:52:36 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5b4cdsm20628012f8f.8.2026.02.15.02.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:52:36 -0800 (PST)
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
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v5 3/9] samples/landlock: Add support for named UNIX domain socket restrictions
Date: Sun, 15 Feb 2026 11:51:51 +0100
Message-ID: <20260215105158.28132-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260215105158.28132-1-gnoack3000@gmail.com>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
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
 samples/landlock/sandboxer.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e7af02f98208..0bbbc5c9ead6 100644
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
 
-#define LANDLOCK_ABI_LAST 7
+#define LANDLOCK_ABI_LAST 9
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -444,6 +446,13 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			"provided by ABI version %d (instead of %d).\n",
 			LANDLOCK_ABI_LAST, abi);
 		__attribute__((fallthrough));
+	case 7:
+		__attribute__((fallthrough));
+	case 8:
+		/* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
+		ruleset_attr.handled_access_fs &=
+			~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
+		__attribute__((fallthrough));
 	case LANDLOCK_ABI_LAST:
 		break;
 	default:
-- 
2.52.0


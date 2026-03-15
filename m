Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF57371872
	for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773613379; cv=none; b=NonsUvuTmuAkgzwlo7dl8Oeh1n5nyrE/nGHidBH53pguhVOKGHcwJE0Yp8fqQN1ahn7SXlLrEOteqm21j32xuVl3XZ19glxCdgOU41T2PCYePGOt57cmp+rB9EMk3KtvAopaqKtLbKYjSqBFztQ0xWlIM3ZdFEx0n66oKRgVPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773613379; c=relaxed/simple;
	bh=2vUGALO9uZKAjCpKbcNBhVMLzh1JWfApkokXuuQ89yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWrd8IGcDpni3FD6Sgx+Bpk5n/6DMVit0A37nkH+qaBjOChPtdDgTQq3kguHWvEmM/gtOEAGKWpx34kNn9Afi5kuBBydE2PnB4J4ivIGuJ6e4kCS3VbwilS75Dg2yml9IgLiUFUDIo7xj40FpeXnG5EiryEnY8BxzZsG/M+jkxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AedOoHDB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AedOoHDB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso31888795e9.2
        for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 15:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773613377; x=1774218177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USBSZwtwkVhJyz8WY2h6vy9d6CAM7AC4OGGdtIthKzE=;
        b=AedOoHDBbrkPVfBXz9nykuMD6CFF6nIXkwydhIOx2+J25lzATO8WMEDwCYBMpTuPqY
         6o2+kuUkA06PWuPjlQXQBzzT9CtjRQbpPGN9m0gC07jOPp2aAvep86GPJIAv4di+v5NV
         u+wtrHbiEYe0HsxeJVyd4edJbO6CxOZGM6bn3pt8QJbUiEgyyakf7LZ+uno0EpZ6BaF5
         VRQ8lcQ5qPX0X9Cghg3xuzvP7B2xxPgtmHxLW9ZFOq16q9NUY4BzzSaERP8v+0ZDCZa9
         Hbj0LrtRsf+P3S9JdasiDAuqt5w3ng9qSNGeD2SfphqUNToIrket00+Xo2xo33U+VPAD
         dxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773613377; x=1774218177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USBSZwtwkVhJyz8WY2h6vy9d6CAM7AC4OGGdtIthKzE=;
        b=G8JA60HUXiTwjQKD0/XkdIw1Y0gMstsdCPpTXl1JcW/F2pTlfYUUWIJMiELAFFAe4k
         l1zvoBiJZoGw+kxMg3Z99BBUiRf33dsfh/TCW+rGQcfnQx0k2J+jYk2LKCFCBgGrM+cK
         VcnUFwB+cHSgxYcJL4K2z3thGlMvrZrc/6GpELQkN4xZXa157eqmxjipppqwbHXjprzD
         UtOZxlOV1Y8n4CaJ3FiDgUaF/Zlv/JRQ6clFH9hhyPS6iGcCMTJkkqGIxAKHoxVc74/e
         0YQGCuKwFc5iaPrU7TVAaHJE/FeFsTvM6tgiE0taCOSTIS1RSf5MsNTypBmfIJY8wXng
         degw==
X-Forwarded-Encrypted: i=1; AJvYcCVzckHXt3cRMv0PdlCeKfuwNMGJN70mzfm/UOGwOMcd/eKVpyMcW5vkejix7YmQPduB7i6VdJl31igIWe7pAXvja+m6ypw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvDS5xRrAOoAK+RbrVLKYe6DHYN1nyXV9C1ov9iGANBZS3ZKVD
	byjnYJbbcl0+19LnISXGAVv81tXnAZuQLos2iMh3Bn0hgLooFaRwCCgK
X-Gm-Gg: ATEYQzwtT83MugDNsSmnK2OWob84/zNkGq2ni/37vnNY5ly/o5dkAI55edJm1HjkE+K
	GpP0zWIGYH99J5Bbq0IySBTAvp05Z6ePchJCcNMM6qSbbC/2TuTqbj7fOjP/MpduUrwOgoTd+yG
	5u12aWbfh6dt03sI20KmEmHdWLB9h1+E0rfYO3IzgcFCK2U9M6+eacbhbh1HBwpUTdNh7vFUhWT
	/BA/ScNRA+HW53qBIPXUSpAacovrkc8cfYpeuboN6Hm5GJiPaeT6vDXdoCWZYJzy45gNafj1b65
	V9VVu45a5bYlEnkhgcmdEGRXdKgZNYj55R3RqzfYXHCoFGlLJc6h/UxhQIEeBsMaLlpkxnJGVab
	xN1Vj/yM2M0s4T1LAd83vQWaP1Rz7DVqH2ryraz+96NnNdGAdpm2s6Yj6zjikGxEITQlki+Kp1K
	oJNy+x7gf7+nMV5zJp8dBueUwYC7eacyyAjplLc0DpenyzvRSFCOxjMPNDdrs=
X-Received: by 2002:a05:600c:a15:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48556714af0mr186283485e9.16.1773613376871;
        Sun, 15 Mar 2026 15:22:56 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48569672c60sm53517645e9.0.2026.03.15.15.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 15:22:56 -0700 (PDT)
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
Subject: [PATCH v6 4/9] samples/landlock: Add support for named UNIX domain socket restrictions
Date: Sun, 15 Mar 2026 23:21:45 +0100
Message-ID: <20260315222150.121952-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315222150.121952-1-gnoack3000@gmail.com>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
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


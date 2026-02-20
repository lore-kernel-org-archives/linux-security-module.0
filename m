Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D82DBF40
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603609; cv=none; b=rnoyYs4UpeFKZIyBKN0ZyC8oNlwbCK6rwJaKTMw6I3obFwkyq6V2yUNAp8gEJdxKJ/+TMdV7RCGlJl4P5MZhae/xsBFs6cFs8BCx966YGQ6FC/a4HGC3d3wK5FbMT5YCkfu4kXmoBL7cA6jPBBdU3q40cwulZu70E4i4sCjns+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603609; c=relaxed/simple;
	bh=a6rEnq1MuYcal/xHR3dZtf+YmAr/SJySPqwXd4dW0vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rn0f4qFWKDV/XGhjfPDHOfnNFt3A9obopluxo8h80COh1IgZVbFzONTGTMujkqT5qTLLHpoFaNAlgLZax9DXzfTggSKWBr3uVRS59OVFmNHGxheOVWSG5RT7jPOsiag6X+20R40CwNIaNyTgO2HRbbKlFt3Q0rplhQ/xJx4gpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxM5seGY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxM5seGY"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4837907f535so20367275e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 08:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771603607; x=1772208407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCMV3g2wOQtGI2Ld6+x2hWsF5KmBmhBPlHJ6o0KwaWY=;
        b=dxM5seGYHhnhXn/YULcFwwp/JGVCLXR2NDu0BNyBVxoZ3ZjQcfMEkAsUqB4l56KBeI
         UQwmay6EEAJQ8tASeswAO39GUDvhycAHKbKoijNtjx8drPc0IoptEKI6vggKPoqVwJhO
         BzQL3nLFElf30JozaZK2ot1SX7GZGhJfih7ffIWyASex4/9ez+bjHDeRtPsg5zoD15Yh
         gWbh6laoxo2R7nUyAOPd1sdLX+EuSbmHuxrNxsLWii5cLScfhKF7+UqbKetKZeH+aBal
         2WhyrKsg2jhZRYIKR0Pu2PhBWGMuL2JEE9IQ+1WadD4nooml9WqBvVgpcBlQonSxC6se
         vhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771603607; x=1772208407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCMV3g2wOQtGI2Ld6+x2hWsF5KmBmhBPlHJ6o0KwaWY=;
        b=VfFfOQUE72VGhgMhTEYfgPPZTAfu4zSdHVcLUVyCEoZziBm0chGv1++LwVBntMWP9f
         jNRoRXbRZg7+bgxTQ/USRRkE/6705vGORd2TZRR9IVaOtAo9rLBRfFkB9GWjFj0/lSfP
         4TxML2OL5t0u5yzudBEmFyblkedQL/YkTkg11phPVEb7zL7a658ninZgVBdK0zocqOCC
         Mi0PE/i5SLsG3WTtJeAB+1yOW1z5yy+F8NAdQd29C4iT7gf175YTYFjMOSkOTIZZ5t42
         vPi64lnhRLPZN2bLj0mEcPQMKqgeIPA5yzUjCl2z3SzZ2wJ51TJFMLEzJwId07bIJaAa
         ol1g==
X-Gm-Message-State: AOJu0Yyqatz3enygN79cCN1UDN4rNOhAzRE/xnq83sGkocV5KucdJQp1
	PKYNFrerlfZYulavt9a7Oeo/ZyYIYgLkjZx6B2has3fcvR9oCRzkeXX6
X-Gm-Gg: AZuq6aI+llunZV7v+8N3WGWgeDMPFVT++J7mC22Rk0JUmsdGaHLJtzjT74bRl0J2I4F
	tHxhVtHcA38JP+1l3q98WgsXZeZalVmniVi+1ti2wb7z1HIW8LJRsb/S2OhfqMAH/dhBhlJmTIr
	Ri+ShcM/NIN94PiZIxK6ImiZq/Hk4U3eoDscQXMA4TYnuFcsUV37PKJ/Y2/jZWWQ0rdfW6XERQN
	I3xpw99OBmtpbbUunLxDUcT9li3IeDpLhop8USBVSZpzTnemQjMWz+kC4n/RtGjV9tlQGiL2ZSL
	u67FPNQ0PznYQoHThuwi7ldvHDK7zCVURLn/lUr4ka2AcZkfRiaiI5/V0UHnIkrY/Xm4CaW697l
	oit5Rv4SCJJS2JCVx9se5Ws/j5ihsIhGfxVZ+gWhPdKEUqd25DNen4iH5m+VAUr4neZdJlP8zHn
	eRwkaDjnsAdGE/9YkU95+EyX8M/n89Qm2rBV4DRlHltl2stf/3
X-Received: by 2002:a05:600c:608f:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-483a95bd7e8mr690915e9.5.1771603606204;
        Fri, 20 Feb 2026 08:06:46 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b3d88sm81984575e9.3.2026.02.20.08.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 08:06:45 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH] samples/landlock: Bump ABI version to 8
Date: Fri, 20 Feb 2026 17:06:27 +0100
Message-ID: <20260220160627.53913-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The sample tool should print a warning if it is not running on a
kernel that provides the newest Landlock ABI version.

Link: https://lore.kernel.org/all/20260218.ufao5Vaefa2u@digikod.net/
Suggested-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e7af02f98208..9f21088c0855 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -299,7 +299,7 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 7
+#define LANDLOCK_ABI_LAST 8
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -436,7 +436,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON for ABI < 7 */
 		supported_restrict_flags &=
 			~LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
-
+		__attribute__((fallthrough));
+	case 7:
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
-- 
2.52.0


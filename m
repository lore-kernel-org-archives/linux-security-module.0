Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14480195811;
	Mon, 27 Jan 2025 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738011262; cv=none; b=N1/EvulvzjjBwauITyl+driD4jguXhy2tf6/AotZt1CqPXO7ZSTC5u8w34qrR4x+6+vsCzJukjBvmvjIpy8c5+u5wNqdnHO+2DmJUWku0jz3deTls1G0wbvriy1Usp6VGhpbcAT5Y8AF5glulPrB7qJjH7ePomZt0Kggj9nzDi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738011262; c=relaxed/simple;
	bh=jnwhaxRBRPGdiewyRV2eSnlAt0+ysDqIGLXM+YkIn+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mDY6g7nM7loIVnMAglj80I5cmxhUEdHdhUc0gZyk7HRKQlUnWV8dKG8NfnFdy/jJCoONfpaD6vfkWFgEjmz3zYkTnWs8PZIiN6t+aRoQkY/FeGukzF2ecPJgi54IdX3AVX9HuVA3TDW+gfYxR4YIvJA49DkNnNybuZMnjJ4SUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P78fZfpE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P78fZfpE"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso824100366b.2;
        Mon, 27 Jan 2025 12:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738011259; x=1738616059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5S+oczGlbkqFclKhQnfKDCJ4c9QxcLjwIDgTTGQqSEI=;
        b=P78fZfpEqO7JxBUPDcH4/0YAeH5LO8/5mLHmdvB1OT0M0hL4i0mXomX80jFkS78xgR
         59WaGiqifmr3Iqn8Y5cBYJgkjDR1NKTTFbMSfWTXFFku+tGOK+wnkL9IPATxaa5jvQcD
         3CkJ0+JKU3/kppsMK9/6OijJKxlgXfs50Xau2YDEzGXjdOVaqH68QzT3cAQlNscE06IV
         oK1t6QGszqST1jixHU4AyQEoIxVkLU62ybuIIUiHmzLoMEI2cwFby14CSSMQKa0fTv2d
         aJHsJIq1quQ6hjjVlY5D6lY/fLePzg473okseNzFOkc+8sKmRwDj8rnOtOXQCk1P58zL
         sCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738011259; x=1738616059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5S+oczGlbkqFclKhQnfKDCJ4c9QxcLjwIDgTTGQqSEI=;
        b=gOJUKOExIDBw3b4ITfFd+4ewXJmIo1e035BP7FjI6SPvi/R1nOGyHAnhTc9siWZNXA
         zBJ/pLGn73+ZCcg1qApsSdj7OI6jYjbP+eqpLiV6dQl2Br9c0tULRN9HaSjd947f0rix
         ZTFvVXTrhPXXZJrf7Hh02IzKdDUD8wzGg4sQ1l0b8zFSrlg/Ac7bqLw87DQ98QWGELiZ
         TRmcaZYQnhO+49AsTbkOYCXCTVBiE4z9GmNE8ustCoLGWnaP1xK+g3Zcql5ws4u3GRb/
         HnoM89l3Mb5bG1MZabQd/9dG48kcV+UdcWepwuPlZpxrB5BziHXx8hhT0lB/iSaiejwv
         BxNg==
X-Forwarded-Encrypted: i=1; AJvYcCVLD/2S5k23wScIoAnfF+hGvkf9S/bT94tPuqQ86DbeoMQtKF6qYy1Z7561XNByb2Z6KSh5EAhHqZZT6W3lswj01ze8Bh8I@vger.kernel.org, AJvYcCW38hEOPNhev8Fkhke3Wz+ufp3sq4m7/I/1RrI0uge9diSrzGHFoiwdym2itGXlQ6GR0rV1f27He2L1WYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHK3jEbx+jvqVIE0I8S/LXZHnD23g2ZQ/wvCDpvJdcTURDecqA
	eCpYP/+VxhCHaBXr7abeIUyHdK9pTL6K7qJY5CHoQ1gCApUp5+SB
X-Gm-Gg: ASbGncs1tfHkxPt/oEMHeqiZVyXjvzwux6ffnlSoGKd9wBNGB/us9VonrW+kQ6oSbnu
	zYRxE1e/Q6Ctlbiyvi6hirbjA528X9Enib33HeRdHpRADr1LTCR33BcEYjkZlNZFZNyJJYiyRo3
	EZXvQfyuNIK4iBknqSRpckd+d4zA6N4PFRraXEnysBGxvkXd4Z6+xXSWAZHwe4/BXjhSKUa3+Q+
	siSH3Vb9klBtT+zg7Alh+p30mU4u6jWHDse78wqx+av7NqF9POvO+oz/bmZgz2M5YCUqIrDA/n5
	z+ziffn1DJNscFol1dMdEF2icQtbo9A=
X-Google-Smtp-Source: AGHT+IGSybohYJwJF4LlLHrCwkHM4EjS8F85YxhhPGJdtoaLijjuxVEoGxvQZHZbt+LA/sSLfVSMqA==
X-Received: by 2002:a17:907:7e82:b0:ab6:6017:6442 with SMTP id a640c23a62f3a-ab6601764c8mr1998793066b.35.1738011259040;
        Mon, 27 Jan 2025 12:54:19 -0800 (PST)
Received: from f.. (cst-prg-86-17.cust.vodafone.cz. [46.135.86.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e12090sm638908266b.29.2025.01.27.12.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 12:54:18 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: john.johansen@canonical.com
Cc: paul@paul-moore.com,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] apparmor: use the condition in AA_BUG_FMT even with debug disabled
Date: Mon, 27 Jan 2025 21:54:04 +0100
Message-ID: <20250127205404.3116679-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This follows the established practice and fixes a build failure for me:
security/apparmor/file.c: In function ‘__file_sock_perm’:
security/apparmor/file.c:544:24: error: unused variable ‘sock’ [-Werror=unused-variable]
  544 |         struct socket *sock = (struct socket *) file->private_data;
      |                        ^~~~

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

Plausibly the sock var wants to be eliminated altogether, but I just
want this to build.

 security/apparmor/include/lib.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
index 256f4577c653..d947998262b2 100644
--- a/security/apparmor/include/lib.h
+++ b/security/apparmor/include/lib.h
@@ -60,7 +60,11 @@ do {									\
 #define AA_BUG_FMT(X, fmt, args...)					\
 	WARN((X), "AppArmor WARN %s: (" #X "): " fmt, __func__, ##args)
 #else
-#define AA_BUG_FMT(X, fmt, args...) no_printk(fmt, ##args)
+#define AA_BUG_FMT(X, fmt, args...)					\
+	do {								\
+		BUILD_BUG_ON_INVALID(X);				\
+		no_printk(fmt, ##args);					\
+	} while (0)
 #endif
 
 int aa_parse_debug_params(const char *str);
-- 
2.43.0


Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F17345752
	for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768055688; cv=none; b=aDNyfghPFzFmFLVUFgHtgydbSNkKiJNwF5tb61K0zoA4dVEOmArr9qD5KDI2g6b+yv3UgaQJ3FUFBJQKYmGcNtBjWrGhw9GFGULn9NEfR9lE8Td8cBgPWUp+NSV1EXeE4ydg/Xx49Rl6nq/m+lMuTUTj76iDVM2ufjrwiKYaZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768055688; c=relaxed/simple;
	bh=k+MQo9gtGaUGvCS+RH70m2PfWkAGtbxQ+3azuUmhqy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3E1bGWQvacT5vv1bL9Cw1aP/Gz0mrYES3Uh9w2pgtSDVymdEhS9BPJUZUcuq1iLTQiFEHdfejzFT3R0oJq1SWXFnSWGhL4hpggDr5o8EJU1F8qOffK5VbVcPZ60AGW4gSVywRnm8evzfvXVL+loNz+QZXyIheYbb8E/DiOLRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWo6Ytu3; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWo6Ytu3"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b802d5e9f06so744322066b.1
        for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 06:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768055686; x=1768660486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWJQZ6bH/XEUVNSkTlMNIIzhpCpGhyzuCULQDhIkcLw=;
        b=MWo6Ytu3K1aO5InrjYtKJHo9OpjFI/FYmiM8bLqenmzvY3OUjgh2oSqWbUP1Qad0u2
         MLejbU0vHQIOma61Stt8gB2jd0wz6BeZ4VPFPKOfE2et4Wlj3cVuDChEFX1W9OBsMUYa
         X4FXGpVS6zOnHhFPmbPWVMIXsUoLPD0B36Ry0Lg+8SFCvA6K4m78v3As+BJsLLdbTvEI
         x+k7py6ynbsA7dX4aJrdz1pomverRqysK4lFt4xddHV8L4hmbSi9ubuMLNSgBb4pRdOV
         I1VK0cDaAG70j9SMViUkDyM4MzT82Cc34V6u8da4B2uFjbj1hionER/5+ABnPZ9YfqB+
         Rf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768055686; x=1768660486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YWJQZ6bH/XEUVNSkTlMNIIzhpCpGhyzuCULQDhIkcLw=;
        b=lQc2nUzc7Mh27n5zdyxvr7K6K09L3YFFMbpWgNwszbhsm1YLcBCRpVrDxt/uDm+jAI
         85zSY+wOQ7xV00Ihq0yaSjOXp8HRsw7IJiYjZFpM6NwQjFojGx6G6EheaDxANu6WkFxq
         7g62t9SpsphWLYjt8MSk5P7K1MPZBMoibs2ZSW/n2RrVgEtemOiaidpuHRuM2JtJ5N3T
         fXALalHfWnwBNeq8kLGy4pCYRLvqtBa0CQ6mgw8ouTXEywwi98L+yd72s99z11nFoMbs
         /0/MeU9blZCiRRHwu3kWvonVfg1GeaDtFTRo7l15KTTgYWQmnDZIKxXfXS7uv4vZOyRr
         Iw+w==
X-Forwarded-Encrypted: i=1; AJvYcCVFnKko84z7IazdqxBXXZmNHY0TaUihwHbsdZ8kP3M/aYFNFnDqTskeZtKTZ+HiKCt6ud1YNZoKuSoBUamaTZCSCkoh/nM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0LWzMIsANhYMSLuAi1LORqEdF2zNwSs7ywa/sJ/I5RL7Vw5O2
	UsO58MrsbHw68KqWtkqnxt/bWiS5QAyqCC/tilrsvmv1QnKRAIxhka0y
X-Gm-Gg: AY/fxX4s3YSCO0ZUzajrS8Jb6z1g+5iydh4fytsSgBSjY5X1LL2ftvCO6EJjox9+AeF
	TvQq+GkUtDwo2oq1r1lKBY4vzSK+qqdAQ/9kKm+/1hcR3YcIeTTNiK53LJpcDpHsGaKzA/4Dbqi
	smFnR5fKR9eA8gMaPw71JmVyNioB+s4qRQwY1jhOHwgZjqF109vanNldMo2z7akt5EkNe4qZNCP
	c2H70uIJgGS7SNoX2DhmZhMyRQ81oixiEvSPXexW44HvMR3EsRPQWQzZ0Jfb3OOTuuoIgXSSmIp
	2XZo5UwUjCiJXEUSe99oauW/7yiMh03+7Sg11l/H8tiscWXcdjoRXLG7ULJXzVHCbX95N5jFYlg
	2PMzxorbj9bHqXlLuf0Aq1bgi/uqWnctXK3T7GVbEQawLDY3XjOORbhkQ7a8xMVOOEvZaftwKUC
	i/OIOgGOtPQd/4l9PDXVt6THHvdZTDxBXubqC3
X-Google-Smtp-Source: AGHT+IEIn08Ktle0tZAKf0qm4M43/IT4IekCJUCzSwr9O026khz3GF6AWsg9uObsC9HLiKEL9xM0Qg==
X-Received: by 2002:a17:906:fe0a:b0:b73:667e:bb29 with SMTP id a640c23a62f3a-b84450332c0mr1250475866b.8.1768055685466;
        Sat, 10 Jan 2026 06:34:45 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cff3fsm1382147266b.33.2026.01.10.06.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:34:45 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
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
Subject: [PATCH v2 3/5] samples/landlock: Add support for named UNIX domain socket restrictions
Date: Sat, 10 Jan 2026 15:33:00 +0100
Message-ID: <20260110143300.71048-7-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110143300.71048-2-gnoack3000@gmail.com>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The access rights for UNIX domain socket lookups are grouped with the
read-write rights in the sample tool.  Rationale: In the general case,
any operations are possible through a UNIX domain socket, including
data-mutating operations.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e7af02f98208..f7e73ba8910c 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -295,11 +295,14 @@ static bool check_ruleset_scope(const char *const env_var,
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET)
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 7
+#define LANDLOCK_ABI_LAST 8
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -444,6 +447,17 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			"provided by ABI version %d (instead of %d).\n",
 			LANDLOCK_ABI_LAST, abi);
 		__attribute__((fallthrough));
+	case 7:
+		/*
+		 * Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM,
+		 * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM and
+		 * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET for ABI < 8
+		 */
+		ruleset_attr.handled_access_fs &=
+			~(LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM |
+			  LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM |
+			  LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET);
+		__attribute__((fallthrough));
 	case LANDLOCK_ABI_LAST:
 		break;
 	default:
-- 
2.52.0


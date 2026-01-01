Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE48D1DA0E1
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767274881; cv=none; b=Bsi3/iOBBlV4vT9rRg2L/x0behtLBIAVvnr69zzo9C5gaxl7yDPtLyYbLVYU0xJwN6o6hx3bNoI6hcGcbBPAmnpTbGG2jI0io0x3AlSp8MnISzYn6fduI9yoNpv/yFvfnirtaEyV5bi9PXsdzvB/miFiFjGcckOWTAlrhCdrNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767274881; c=relaxed/simple;
	bh=kBnsTKBcoQX7rR327LF6KFuyma/K4gLC0YssWx9j4Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6tJRMcGP8o4xyX3R3yVKykZjV2Ss7RCo6V8Igj1upl+XFAWuNMNW5O+hG0nBsd0KwO0i+mDo+UymFMzJ5ivaG5qQftS874AOCMj+gredtspm3H9aZGsxW1rfsBVQymNpOJcUXt4vEB6mGRX7AnKIoyuPTvefG5x1QYIVcdu/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxeMY5LA; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxeMY5LA"
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso2057644866b.2
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jan 2026 05:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767274878; x=1767879678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkq6Iz5zamhxmkTWblPAHDAlaF05J/Fmp+v+yTuwMjw=;
        b=AxeMY5LATcUXui/D3FjOgSQAq5zpn0YYyY7hhKimyB/bSC4FUSSfJNkyNC7RO8rBuE
         SFYJmFsEmyKNSR6FIiNwzJeABROhWLXGsgVrkb7UK2n/OPoi+gJPSRpsfYXoaggWPRTJ
         LfWgOQRI+XnTkDL7Dd+jcMFPQmdPd1jjyv7YxFNiONYlR8BbZtz5n5uG7jBiivunkvRl
         WOvv7c54jgJF8aBJDHYr2WahZmT8aSXHKOR4nM1iqHFyzgt84L97oQb2yum8DpGw36Hm
         BxeJ94kofO+WZNq4/nIrjN81SVlJ7SWOZgM+mwGP3+83dVN+S16AW1TCo4PNVKmf1THR
         V+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767274878; x=1767879678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mkq6Iz5zamhxmkTWblPAHDAlaF05J/Fmp+v+yTuwMjw=;
        b=hNFHDltarINF0dWtOTNwDw9gHZAxuoDA2H4YR40M+ALJm5qZSaGQDPp3Eq5T0D1wPx
         c/XpoIrX8R/CnJ8FUKMFQjmYFgbDrKFB7wvZxQCS5vrODrEmmgTHL7VPe5SaLZlLa3XD
         xMhao3+z8KsnKX53NU7Xvwh9K/CsnNMWKsaLcTtj1d2I3aZU27eNQ1c4lI/3NG3i2hXf
         FG+qlJUNlBdqiuqHCzUjDRDrEMig3EAoMV+AnWWksTC5du4Of53Kd6p8QChHFtJwG9Ml
         FeSNI9lUCQinpr4r/cUO/UevMd7457EuQklX5qmwTRFYMdvGtnP5zzCZ0FTGhYuKxci4
         P5yw==
X-Gm-Message-State: AOJu0Yxj/C7I5BLjSCXxYY/SPzzyi8+II9RRkAL/Uwkrxpk2g+D7d3LL
	K2zv4HH+ja4wvmCqJoxdMciMfMnzHS4Sjq/tGhq/QPAA+R9fyzSrIj506+vTYH6p
X-Gm-Gg: AY/fxX6DkeM+ccoIgdmb9X8F15HzrwtUmcSBhTIh+QggtukdAWgmqq9N5DYjI7wVbrs
	EK2PRQG9tYrHlGCqjE+x9gppvlyUrk8HKfJnbFGHadtZ8mxUVaA4NrQ9dg+itgFPxIxtvBLDPS7
	vxpra4sM59EQut9P1UX6vvtHLzR547+YSfxjpuzlkQ1jF9Mi7sEJK+wgjSRV3RZLep5zopWY6Vl
	USGMRemLCxW5cmduTe1QBVfY/QBG1tWk1/exNITIUXmleET5MyJ2lsnISZDIh8+YQekWzJsN3Ej
	Ln9gyFYUZhoRcyGu/CpzrSrR+rBir3Fi6yXQ294aEjcRlHqyetZXNQF2l/9ofqY+YDLXFu9mZAR
	7QEA2eiue6Y3rITT3hEL3Hctd/0udHBnb7PrLhd+yzJB47YYie8VfDRrnFTbZA4CeoCoxjQE9ow
	LIwRWNyBpaC+RwyhpIZTGZvVESU5grX6ibmOGS
X-Google-Smtp-Source: AGHT+IGrTgxM34TKK95LGrF6btQwz+NtaS/79RByYHTVGu2Uki+5quHdY0/p+N00Io0IfIwlefeHfQ==
X-Received: by 2002:a17:907:7e82:b0:b79:ff94:50ff with SMTP id a640c23a62f3a-b8037178545mr4123634166b.34.1767274878151;
        Thu, 01 Jan 2026 05:41:18 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494dd3sm40995903a12.21.2026.01.01.05.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 05:41:17 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [RFC PATCH 5/5] landlock: Document LANDLOCK_ACCESS_FS_UNIX_CONNECT
Date: Thu,  1 Jan 2026 14:41:02 +0100
Message-ID: <20260101134102.25938-6-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260101134102.25938-1-gnoack3000@gmail.com>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 1d0c2c15c22e3..6efb5c51253b0 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -77,7 +77,8 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_MAKE_SYM |
             LANDLOCK_ACCESS_FS_REFER |
             LANDLOCK_ACCESS_FS_TRUNCATE |
-            LANDLOCK_ACCESS_FS_IOCTL_DEV,
+            LANDLOCK_ACCESS_FS_IOCTL_DEV |
+            LANDLOCK_ACCESS_FS_UNIX_CONNECT,
         .handled_access_net =
             LANDLOCK_ACCESS_NET_BIND_TCP |
             LANDLOCK_ACCESS_NET_CONNECT_TCP,
@@ -127,6 +128,10 @@ version, and only use the available subset of access rights:
         /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
         ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
                                  LANDLOCK_SCOPE_SIGNAL);
+        __attribute__((fallthrough));
+    case 7:
+        /* Removes LANDLOCK_ACCESS_FS_UNIX_CONNECT for ABI < 8 */
+        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_UNIX_CONNECT;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -604,6 +609,13 @@ Landlock audit events with the ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``,
 sys_landlock_restrict_self().  See Documentation/admin-guide/LSM/landlock.rst
 for more details on audit.
 
+Pathname UNIX sockets (ABI < 8)
+-------------------------------
+
+Starting with the Landlock ABI version 8, it is possible to restrict
+connections to a pathname :manpage:`unix(7)` socket using the new
+``LANDLOCK_ACCESS_FS_UNIX_CONNECT`` right.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.52.0


Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76C3C4571
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285112; cv=none; b=O3r+YjIpPxuz9lelILjhtlFuqRh6ZXQURgMu6iFidPn+3tEy3fpqwMIO2JJIMMSMRax6tFiaDWg6IsHpWThurX7eThJKJZ9lBe7gogd8JfgAeatAHMe2xCUqj2nrrnlG4GhS9sKrEBpskI6EeU3IYVj5znd4W50bX8kF/okZnbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285112; c=relaxed/simple;
	bh=opw9caHfWbBZMewr9t9CjGESwa5zyg4Lv/nCU5nn8Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cV1Tt78xzHDwKrxmTPMDq4e1eTmcyPUObmpKqsmXRhC7IpZKCIzjQQLZCZA34VSlzAHySD66i4OA5BQ51nHMuzmI2c4BKTKqfqoNAJAH6KW6WUhn09Z+yv4jHGcMaELCHnhtKzQOi4DtZ1A2+j0qTzBmtyN4ss8047W1DEIq/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXzwoNla; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXzwoNla"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so37420345e9.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774285110; x=1774889910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG503LK+N1uxl3LfYfBRebWpzPPsbYWGZEMX2o/lkhA=;
        b=kXzwoNlaHlXiEGtvbFdB/Tq9pS6exIUmmtO0svV+kDZbPRLVJ+I8kU9LrLE+gaFcQN
         c9Yue6jRMS1NWUrRm6gRlMwwB4ruj1SVMjJdEVupgpTLPMzWL6EsHz6SGDA0Pr1Zz+on
         yKig+eks2xf+AWcUFFHurs9B/0SJ6rIHm2ThRMVr6GJlo+9Z2iEDqT6ukqLwfcZO+PWF
         g39otrkM5X+Z7t+jNiGyPQR/SNarH6MrPkT+7FiIN4LQlUo8aKJoZe+jfZXNgqI43/CN
         QZ2DcNOG5KMLrUQLj/6HHrS9ZISadnXWjFzUhYm8Nhn0AB7ZyPaNkvCzCjo+OYWFiBX5
         ibTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285110; x=1774889910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sG503LK+N1uxl3LfYfBRebWpzPPsbYWGZEMX2o/lkhA=;
        b=NZR6TaV18b1TVcEp4gucSpZxoh/QytbCO3SXf87OdxvPJzZKbOI58U+IR/LzInFFd/
         YLpwFQiv6MKPFWX/J59dgpp4aaRGfuDHsuryErIXbkI5BJzr7DO2D5P1H+3izFGFsX1o
         c0y4/FdJ4ec9ZuWFuy/I11KsYolTEyRS/B7xwAoBp2dKB1EsHlL0kXUTvjQSjgpSDD4r
         lHlAXQZDakZe80ZI3zXn5KNu11uiJRvLBdi1ErlSzAdFgHvuG4XyLgnXUvtRJJYdK1sc
         SCygO5TpMgP1I8u6mHWCRrwP2xjHq9C+vFVOlDXohvSqnmDrxR8PPPKovwyjgisDvfdm
         6n+A==
X-Forwarded-Encrypted: i=1; AJvYcCUd5Lp8KRPlza2ycr4EZ1vvPwhV6wzaaYrOEHW/BORjw3GDja2ilx260lym+mc8EYfFLY64SUhw66EhyjMxW+iImapE/qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPaT2yzrNWzGTCMmTZhhnXzRF4Y27M4RP8M8bSNMgpD/g5t3DF
	StL5IzZNj8GuluZxQydYvdg1pu9VH6f3E+yVlUB8Zo6T/MkLT9IntXps
X-Gm-Gg: ATEYQzzjplGl4+EoYbd07cUVyD8mhurdwNA/2lT5hequkU4QI8Vh+FRiCBYSnqXyhr6
	kFYrMKOQGubfZDzFGNBHS6mtT+etOt+dZcBGrv8va7q0qhTHzi+4Cia/aQ/4VIRPr7fTLdd6Oi2
	lX57u8FYT8CBl6V7w44LdybClAVr2sBxKjLovOg/oFUCnGZyn1a0aPo3rZZlNhNEYtIl+gGLSAi
	iIbqiZ4pgPblNjCNTx7qUvaVE3EKfNeAjqxMiaHxsDwlfGG0b5HEumn6SG3/CSNHSDOKRI+It9V
	u+1u+fPA2ThBPzORVIfM9kuXA3DMXxJ3U0xxvJj+sTG3tXIKiNUVCbObaYfzr7vqS8/XoTnas5j
	mdh4SoL7jZGGt6kcN9yvo/wf1d142/mEW3rIWGWFKYnYW74RIfZ7SGr+/0GDfd7wlbbRHhu/QuU
	ghiJ+eGBC79XMjayVUs5gupmA3cqBJnpCjfawfeMIaMFG1HZOy4t6hOkzV/Os=
X-Received: by 2002:a05:600c:6096:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-4870f1fc5e2mr4242265e9.8.1774285109582;
        Mon, 23 Mar 2026 09:58:29 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe8c2987sm116263995e9.3.2026.03.23.09.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:58:29 -0700 (PDT)
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
Subject: [PATCH v7 11/11] landlock: Document FS access right for pathname UNIX sockets
Date: Mon, 23 Mar 2026 17:56:53 +0100
Message-ID: <20260323165654.193957-12-gnoack3000@gmail.com>
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

Add LANDLOCK_ACCESS_FS_RESOLVE_UNIX to the example code, and explain
it in the section about previous limitations.  The bulk of the
interesting flag documentation lives in the kernel header and is
included in the Sphinx rendering.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 13134bccdd39..318d0d8a16da 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -77,7 +77,8 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_MAKE_SYM |
             LANDLOCK_ACCESS_FS_REFER |
             LANDLOCK_ACCESS_FS_TRUNCATE |
-            LANDLOCK_ACCESS_FS_IOCTL_DEV,
+            LANDLOCK_ACCESS_FS_IOCTL_DEV |
+            LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
         .handled_access_net =
             LANDLOCK_ACCESS_NET_BIND_TCP |
             LANDLOCK_ACCESS_NET_CONNECT_TCP,
@@ -127,6 +128,10 @@ version, and only use the available subset of access rights:
         /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
         ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
                                  LANDLOCK_SCOPE_SIGNAL);
+        __attribute__((fallthrough));
+    case 6 ... 8:
+        /* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
+        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -685,6 +690,13 @@ enforce Landlock rulesets across all threads of the calling process
 using the ``LANDLOCK_RESTRICT_SELF_TSYNC`` flag passed to
 sys_landlock_restrict_self().
 
+Pathname UNIX sockets (ABI < 9)
+-------------------------------
+
+Starting with the Landlock ABI version 9, it is possible to restrict
+connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
+the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.53.0


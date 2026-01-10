Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672092D3739
	for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768055694; cv=none; b=hXEvVXWrYfp+zrDq2DOxNthysg/tTodiwigu2cpFlcs+E88C7Jen8a667/qNH1BOYsfNau6wnRgUSjqAqm34+P/BqfZl7OZeVoh/KFcUih4BwnMzs6RoAjxz/C6Vev6d87vA34B0/DJr3WYtVTidofGv3kVShhNg916Bey0QP+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768055694; c=relaxed/simple;
	bh=6KqY88IAsjbbme5u5WDaHgNfiCjBmLyrqRnzpLdSntM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oicIn8mX8BpAXCOurtwG7BUrM9cj7VaDQPl1BrkyxGZDvoJ9MRuoKyU5sTGBOtSNC7OCZxPNB8mUOpCmgWXW2D2udN33WbIlqBjRmCjd7MaL7kGOxTwS/qDNUVJvuDel4eFlz06ZzkaGqkQUoTK2ZNimdIT2SSutYAtMIIBSEuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is05b8O1; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is05b8O1"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b7277324204so795747966b.0
        for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 06:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768055692; x=1768660492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qUNGmjxXR9IGqq+Kp/y2SpTwq5enP23MLPAGxRfjb0=;
        b=Is05b8O1mDmo0H1Pv355Jw/opNh4vBtXl3jikAdjP7zSyzxSJxGOepPwHw5dmSLmM5
         yMe/DdHv4Z4ysS4mR/YmTasYScOKje4N9wbOY18Wqwnf1V8AnlV+9s1wpsKLW9Gg5B8j
         5QqJ/+tCWJixP+hg5tbMFGp4SV+kwQyFoyHsV9C8gqbwyAkKEfGHAy7qGalgHTZJ3Wc2
         vRJswIzKwgnJc58VVIWSirdfNQXq9XjKNeW8A2NZ+HV2m2rewEV1lUTdFKCiTMildOJ7
         oQPYm6RHX42DiNQNx1KaqvYby1VdUqeoLjJyNJKXKDDwZMAlNVYPw8cZNOKBKZro2F24
         YNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768055692; x=1768660492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3qUNGmjxXR9IGqq+Kp/y2SpTwq5enP23MLPAGxRfjb0=;
        b=oNg6yjTRs+XQ5EIyi0fLMzV2Vw2HYomvpyleNm3zoYguYDPdrz9MPzdmvN+/uxMkP6
         6moz33KpS18shUbeFmFiL4x6FmDY/2ZOxd3C/hXBMkJ0ueiIfhSvT+FLIRMMKEFngS85
         1rgcbdWqF7Xiz/9EuYOXqYeYl/BAF1UtaM0GWU2B4h8u080Kq9lnbbx7jfPIi2r0EWkH
         wx0yJUKplqoeyKP7AR07ffgkIST40pkB+hq6esmC+Zb/CP3yqqO1qSQB/jCmXpeQxReU
         DKTh9zC2/7vXAxTC0UT3ts4MzxYUUXWr/C6CXGxYfYuHjR8LRpaB9ZIa+83Uw5DOsb0d
         PnOw==
X-Forwarded-Encrypted: i=1; AJvYcCU9mW8M5xHSWRl8ShUwC/8ACIpLEVqW2z2+KNm/O9NRgMgY5YzeULXsdyXvssxczFjqg09xFEfXRhh48Q8oMQL4JWpA8r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH85MRbSCZAU73JBRp/gapQkKJTwJNKszj75w3MLjXefdi0z/r
	PDOFcs00PofRx3sSECC6opqRUHiSfCKpixTvffdwTw7vrreeQdxyXjy1
X-Gm-Gg: AY/fxX5RLOvxpHVQLBVk51dJxHujkFWqO8eUj/22MtvdMStmqCvEispwYVNSpTSFy7W
	9yTgjKjzkkF1hdiv1XyZITQF6IVirnwvhDNzJDqbqeG9PG2dpZ0WDSJgtPSQR60dytO2fHWEbPk
	a/qMZjFkZdrD9wQ0MnkoLh6y+/oXCsab1WwF/k5XPRJL8QRta8NJeUkrQiD/NWBH7si6mWEFzWp
	Vtlovm/1eA/Uu+81uDmkV2dxpUZ9UxH0leh3uuzbi9/RhUWJ456ivQrVXFi9xII/DMB0Y6ko2iO
	U/hs6VcfcXWFK7WvWjaAOYL9X/k/OW46wZdrtL3gT7HfVyaSbHPhDxzPjBueOCJ6eUNjtM5Bnvt
	AlNUvvwOspHWOpXX6sWPdf/7mfXRZs1sd1E9rHAaCe7Yj8nF4DnSacLiiZGWYmMDTY6QVTnBsis
	l1jvpM/PFPC2JDovwEa6aUpJLMk0mMHC9b6RMb
X-Google-Smtp-Source: AGHT+IGsubmMaCuYw8JtTLoHYst1H1jrk5sDj4ZyjqsHCbFAOcOzSFD00tscTCj4pgZUm1Y4vBKpng==
X-Received: by 2002:a17:906:4fd0:b0:b80:f2e:6e1 with SMTP id a640c23a62f3a-b84453e334dmr1314681966b.43.1768055691484;
        Sat, 10 Jan 2026 06:34:51 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfe60sm1408019066b.45.2026.01.10.06.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:34:51 -0800 (PST)
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
Subject: [PATCH v2 5/5] landlock: Document FS access rights for pathname UNIX sockets
Date: Sat, 10 Jan 2026 15:33:02 +0100
Message-ID: <20260110143300.71048-9-gnoack3000@gmail.com>
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

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 25 +++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 1d0c2c15c22e..29afde4f7e75 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -77,7 +77,10 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_MAKE_SYM |
             LANDLOCK_ACCESS_FS_REFER |
             LANDLOCK_ACCESS_FS_TRUNCATE |
-            LANDLOCK_ACCESS_FS_IOCTL_DEV,
+            LANDLOCK_ACCESS_FS_IOCTL_DEV |
+            LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM |
+            LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM |
+            LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET,
         .handled_access_net =
             LANDLOCK_ACCESS_NET_BIND_TCP |
             LANDLOCK_ACCESS_NET_CONNECT_TCP,
@@ -127,6 +130,17 @@ version, and only use the available subset of access rights:
         /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
         ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
                                  LANDLOCK_SCOPE_SIGNAL);
+        __attribute__((fallthrough));
+    case 7:
+        /*
+         * Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM,
+         * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM and
+         * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET for ABI < 8
+         */
+	 ruleset_attr.handled_access_fs &=
+	 	~(LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM |
+		  LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM |
+		  LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET);
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -604,6 +618,15 @@ Landlock audit events with the ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``,
 sys_landlock_restrict_self().  See Documentation/admin-guide/LSM/landlock.rst
 for more details on audit.
 
+Pathname UNIX sockets (ABI < 8)
+-------------------------------
+
+Starting with the Landlock ABI version 8, it is possible to restrict
+connections to pathname :manpage:`unix(7)` sockets using the new
+``LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM``,
+``LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM`` and
+``LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET`` rights.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.52.0


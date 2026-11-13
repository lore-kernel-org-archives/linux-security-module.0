Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601444;
	b=UXF9Kkmu/5rF66Swt58FCb3YYQFcZ9IHG6hQx2MA36AH//iOTc+8gMXEdbAhy6x5Wro0
	 xuB7niLNVARhfmy6oMnGkC11gSfEotf5leAi5Vz4mxaezBKLShOjDK4SxMdN+Pn/ZBVem
	 Ax71h5hOjbLHzZj1pFZWuHvkBHnDSb7w8dB3tdpa7eJtkxhir8yeoC1ohaoyuJ83nPoYN
	 Z/QXTWVZlW/oScG2KT+XMz2WbaCZx3uruk98WzehxXxiz6qbKN2YNAzbvL3JhqaYQ6Ovt
	 AX2r7DA44J1KqIlNNsPV8m9Gy8dpbmbj4jgWjMoLJ0TwV1lyZ6C9YXNLkD1QNUKGxSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=11pzDrSvy8pN7juNxI1TqFg/ZMo6mlfjRdUwJqxTnJU=;
	b=BMJE8TYRrovkWBH29QZTtJSoJ3YZhrkZHYqTqbDKmI1InwjH8Qi6d1oYjXdecAySiN1Q
	 l1rmVxvN4Y9jIyTDxVSqUTG6IWcWcYfrHhnf1k/GBCsH/n78Kx3HDAa8VqlNI8mQelJYB
	 HoymLQmuP4G5fSJqw+t7dIgF3laig19dUKiSiCRozOyaLrw3nf1o6A+VQbBKVHkIWfkTC
	 YN959qYhwky0cNWTI2Hpzr2g+V+YXnJWrr/hk/Ny4M7HlwItmTg71ukiJz74zlSR00HWW
	 BbC6SWdyM440e1ggVISWIaf8nVPJ0cgYkWTHp86X9qXI0HdSPH660L+jzT1ZJAqwL5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TIVvuyfg;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160460A261C
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9160460A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TIVvuyfg
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so14164975e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 12:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601443; x=1795206243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=11pzDrSvy8pN7juNxI1TqFg/ZMo6mlfjRdUwJqxTnJU=;
        b=TIVvuyfgpZi5DMjjNMj9tV9pARWEk5hqVnUHOIGVemowXnFkJWwKHP+DEYDXvfoKlU
         sYyD/6PlQqRUZl5p057WVQqTjOt+VXV7kq7fL7ELEg7+WL0pTZZzz5qBotepgw7Bv4t8
         XcIRcrZfTrWmFGHxafUne9CgGLVKBOFsR3WsHvXQ49WAqAYpAe3Dnwj6oHY/tWBZaCBs
         3ZCsN1sAX5RKmnXuU646pSqjXiwb0WpcmPiduXV1PaoJARIwXRIQ3jcD8N6T15eFAAV8
         0Qu18ldKn8aYwBEzMuVRgnmxKwG9/8C94njOEgQCuClLnqqAxElQF2FkfByaaI5JVCHf
         yCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601443; x=1795206243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=11pzDrSvy8pN7juNxI1TqFg/ZMo6mlfjRdUwJqxTnJU=;
        b=Ze7uNyWoJIFluUq4ha8Lg2T9OnePfWBQWtrDv6juVlqww++8rPRBVdpGWxIXbM05lx
         7EiKwZrP/QaSazUWVLclSS6hMagn7RqX/XcQ73pWWKfmt1p1ssXNOLVKIP2Ko9QnI0fR
         R48qD9nK4pKDRBtPbMtwCB9OX93X8QQtL+8xKHi9lpO1hN4ndu95AGZnl58nVfns+/CX
         IfaIzKcvYoLvJUjY7u/xtjtBH+3eKpacrRFUk/csZvMNuFJL2XhZoyGXp5eODD0d3KyN
         Pnm8F/7x8RNsLU6K9y2zKjK/PexiFuuh0p6ZwDLhiH60gwfbt9MzXPeXUOHrmLeyyy9s
         sN2Q==
X-Forwarded-Encrypted: i=1; AL+hErF0eyoX6sc83Iue7S0DuM3r8nSFQ0s8Zr+Vs4f6+kLwzepRS+Xf2B9Uajd44jZufrGWLmI/uM9jja8fnL5ZfjnzZSMpxbY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3IVx5ZpulF3dLAV0hEYEAUBe3+Sg7KaZ4idN1GtefFqXT8vE9
	hZ43dlMtrnycqG+yIvFl+Iiea0wb8UQTWapshYCL6/eaMMZrDHdD6XpW
X-Gm-Gg: AYBFou0lpBC91/h6hSR9KRoOtFTAViYIpEnxW/2J0B6Yg+7232fvE4eXIRS8eWpjqWc
	2ze78L4fr9nETUSKbuuYUvDZOCUG8+Y1xt+vhTI+7QJjVyFP4a1IWCrvWHXg7P3GQCU9/OUPWTO
	0wGs9WyoY3dRLFNqXQy668QUkjNZPf0idlMFTZu7pcgNlF4ePCCzq1T8uqVWo0bq91pu+Z0bq7W
	hIzT+CvlCy+EboflZPiKQLdBHkFf03k4wL3bV9BKDTLroHLVaLbIwmnsTtCd9TWcGQdHIJ2UvQV
	71EPQhuXOeLc06sXlbRHzHuQ4j4JvXCa4PGqbnK+xM0zC9VQvThPB09FsxAoMotk8UQW4u3hBJM
	HA+J2BUWoj20HQmF3zXPl3H2NfF4wgA6/B/jWVBxmBKtLL39IZT9ouInPOtmyB0CEoQqb8orDhr
	GJUDuBRL96Az71+9HEA0nZqWt3CcB1VZfiuy8SL9xR7mEwVs+tkCRFLkHhPqaFadYDw/jWzN6hJ
	ZeBGAExyGjLgN6R2A1qhQT3UR7UIarUqSlNE02H/u93jzvyuu0T6pRxWRjYy9uW3er+lFowu5c8
	MWm51Yo24luwkzmpsYk6qIafel7Xy17/ZfjiXMp6WSYmopliBjr8oQ==
X-Received: by 2002:a05:600c:1d06:b0:4a2:190f:cf6a with SMTP id 5b1f17b1804b1-4bb55ab3403mr73006955e9.35.1794601442864;
        Fri, 13 Nov 2026 12:24:02 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae5299sm95755415e9.11.2026.11.13.12.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:24:02 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Fri, 13 Nov 2026 21:23:27 +0100
Subject: [PATCH v3 5/5] landlock: Clarify implicit handling of
 LANDLOCK_ACCESS_FS_REFER
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-b4-landlock-refer-nonfs-layer-v3-5-02d7e42bcdfd@gmail.com>
References: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
In-Reply-To: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
 Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

The LANDLOCK_ACCESS_FS_REFER right is handled implicitly in a ruleset,
but only if any other filesystem access right is declared as handled
in the given ruleset.

The old documentation was still a remnant from the times when
filesystem access rights were the only access rights that existed in
Landlock, but it became misleading when we introduced additional types
of access rights.

Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h              | 17 +++++++++--------
 security/landlock/access.h                 | 13 +++++++------
 tools/testing/selftests/landlock/fs_test.c |  7 ++++---
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 24510e5d8479..7e38b9d1bf12 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -22,10 +22,10 @@
  * enacted.  Vice versa, access rights that are not specifically listed here are
  * not going to be denied by this ruleset when it is enacted.
  *
- * For historical reasons, the %LANDLOCK_ACCESS_FS_REFER right is always denied
- * by default, even when its bit is not set in @handled_access_fs.  In order to
- * add new rules with this access right, the bit must still be set explicitly
- * (cf. `Filesystem flags`_).
+ * For historical reasons, as soon as any filesystem access right is handled in
+ * @handled_access_fs, the %LANDLOCK_ACCESS_FS_REFER right is always denied as
+ * well.  In order to add new rules with this access right, the bit must still
+ * be set explicitly (cf. `Filesystem flags`_).
  *
  * The explicit listing of *handled access rights* is required for backwards
  * compatibility reasons.  In most use cases, processes that use Landlock will
@@ -462,10 +462,11 @@ struct landlock_capability_attr {
  *   This access right is available since the second version of the Landlock
  *   ABI.
  *
- *   This is the only access right which is denied by default by any ruleset,
- *   even if the right is not specified as handled at ruleset creation time.
- *   The only way to make a ruleset grant this right is to explicitly allow it
- *   for a specific directory by adding a matching rule to the ruleset.
+ *   This is the only access right which is denied by default by any ruleset
+ *   that handles filesystem access rights, even if the right is not specified
+ *   as handled at ruleset creation time.  The only way to make a ruleset grant
+ *   this right is to explicitly allow it for a specific directory by adding a
+ *   matching rule to the ruleset.
  *
  *   In particular, when using the first Landlock ABI version, Landlock will
  *   always deny attempts to reparent files between different directories.
diff --git a/security/landlock/access.h b/security/landlock/access.h
index f9eaa2f53686..789ccfd9f669 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -18,10 +18,11 @@
 #include "limits.h"
 
 /*
- * All access rights that are denied by default whether they are handled or not
- * by a ruleset/layer.  This must be ORed with the .handled field of all
- * domain->layers[] entries when we need to get the absolute handled access
- * masks, see landlock_upgrade_handled_layer_config().
+ * All filesystem access rights that are denied by default as soon as any other
+ * filesystem access right is handled, even if the access right is not
+ * explicitly declared to be handled itself.  This must be ORed with the
+ * .handled field of all domain->layers[] entries when we need to get the
+ * absolute handled access masks, see landlock_upgrade_handled_layer_config().
  */
 /* clang-format off */
 #define _LANDLOCK_ACCESS_FS_INITIALLY_DENIED ( \
@@ -178,8 +179,8 @@ static inline struct layer_config
 landlock_upgrade_handled_layer_config(struct layer_config layer_config)
 {
 	/*
-	 * All access rights that are denied by default whether they are
-	 * explicitly handled or not.
+	 * All filesystem access rights that are denied by default
+	 * as soon as any other filesystem access right is handled.
 	 */
 	if (layer_config.handled.fs)
 		layer_config.handled.fs |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 6d9baab0fae8..48c1f896dc9a 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3034,8 +3034,8 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename1)
 
 	/*
 	 * Moving the file2_s1d3 file below dir_s2d3 is denied because the
-	 * second layer does not handle REFER, which is always denied by
-	 * default.
+	 * second layer does not handle REFER, which is always denied as soon as
+	 * any other filesystem access right is handled.
 	 */
 	ASSERT_EQ(-1, rename(file2_s1d3, file1_s2d3));
 	ASSERT_EQ(EXDEV, errno);
@@ -3073,7 +3073,8 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename2)
 	ASSERT_EQ(EXDEV, errno);
 	/*
 	 * Modifying the layout is now denied because the second layer does not
-	 * handle REFER, which is always denied by default.
+	 * handle REFER, which is always denied as soon as any other filesystem
+	 * access right is handled.
 	 */
 	ASSERT_EQ(-1, rename(file2_s1d2, file1_s2d3));
 	ASSERT_EQ(EXDEV, errno);

-- 
2.56.1


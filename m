Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE71824AD
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612901; cv=none; b=thiAEo8LWpLm6bi/U17YPC+ZXqJ1f9tkLsNfY4ynP0yxerYzwl3cr/kNEemAShK2El5Z9dm/z1RZcgoxeBCZLeUNBX1urLgv2OIi6LBYIv9aBhwhn4drrpzgW75IjGHSlwL6mQABLYA5HqT9QmvssErb+kpUf2kkNoGpOVSJWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612901; c=relaxed/simple;
	bh=r7/8jemukcKyHG+VD3CvLwk14kjGeWIwzHrA6TlbF/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uDuAZ47NbdR0C6q3Xq2ESUGGh2GAl7m0iPyWpaPjx+SOL0+7PvWqc9SwjohCoG1/trDkq8R+9MXuQfPkmN5ISdG68aCn2GvloIhx1kQuGZkTkpsbZJzUMacP04zU60KorYnx8WZYiYb0Mw/g6xRQwfKu0Rog0vYVF8v7y28cP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xa6BGzzQ; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xa6BGzzQ"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a77e59a53c4so366144366b.1
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720612898; x=1721217698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QAr79NZwYGjlusygzufg919HeX6gSvgCVs+wVSuUSJc=;
        b=Xa6BGzzQqLo9sl3/7cdU1Mwnts7yrjJKuojdT/NP/e7nWKgX3yoNBc7kOmWrvt9RMn
         u1Sjjk37vAf3ajUxNKmfYaZ8QIabXjv58IWv+VMUTlPQ7kfiUbrEERtT9rrU3zl8IJRa
         urhDb8TtSkRBurZIyhoS5DP26xj1FiuIeI9Pk/cGod4Hesf7urLcS3c1qddakNOcYiOm
         Coe16OA35Sg1Fdky94XpgjLhbx2/owdUvvIxk+a2DXjx/7P7p/2DVG/mk0jC5fNg4I94
         i5yLGgXblXce6UmUxbVi3nQJezH3hnJ+fpbTDe/KgmCR7DHIhBKIuUj8JcTiVrkMmnZm
         NpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720612898; x=1721217698;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAr79NZwYGjlusygzufg919HeX6gSvgCVs+wVSuUSJc=;
        b=ov4fp0FTSxi88UJW6szocZG7omFgop6FeCqGOCN7/Ji05YkgwITOAnnhlOSli11A1B
         9nEYPWHdLMwH9tGu9XaQepmJIxEw3+U1DkAFwc2AWx43yNr+srX7u03NoBaHG53OtOdS
         zpA2I/jARgFBtqpU4vkL5XbmPLVdLmEFAg5SQ8byMKkVFZPWAPo5L/c54DJUFh9QIlec
         Z3Oe4PGKkRBcXZ8FVW+9u2QmfiaLKgIRfPvFE2o8t7UDtycSpAMVyAbX56l0FZHf7kn2
         nw2HLjohzCcRB9nCpQUOn9o7gO08TStwneNSF3XrTPPcFhkQDwYinzdePbmW3Ktvmm06
         7T2w==
X-Gm-Message-State: AOJu0YyAbXKNvLB2Gt4zY4hQe3AYZCmv82qZblZsajxznkZcXhAyLREQ
	3SKQBatj0HeFyma93uU3WpvLMko6+r5ap+Y+DYWCiasvXPxn5Q/T+wlFlwN/dZsodGDskm8LsBS
	tSmZn3FhaJZqSsveztAII0zxvt7A5T9fR8/Z9K8R7StQh1UgDoglYZTE7hdYdQUX0n87QHGXX+B
	DwQr4X3wRZ8HUQwxMqv3zRh4AFG0HJ/bcTTDXCR/6arBUbPHV3+k2Y
X-Google-Smtp-Source: AGHT+IF4++o7QyXGPKU33Lw0o/Nw4SzozF77UsqxgBuKV+CkMyoRE0/faYYldrOB2eBJvujq9DbL93Y/bSQ=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:907:6886:b0:a77:eb49:793c with SMTP id
 a640c23a62f3a-a780b883538mr365166b.12.1720612898127; Wed, 10 Jul 2024
 05:01:38 -0700 (PDT)
Date: Wed, 10 Jul 2024 12:01:34 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710120134.1926158-1-gnoack@google.com>
Subject: [PATCH] landlock: Clarify documentation for struct landlock_ruleset_attr
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Matt Bobrowski <repnop@google.com>, "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, 
	Alejandro Colomar <alx@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The explanation for @handled_access_fs and @handled_access_net has
significant overlap and is better explained together.  I tried to clarify
the wording and break up longer sentences as well.  I am putting emphasis
on the word "handled" to make it clearer that "handled" is a term with
special meaning in the context of Landlock.

I'd like to transfer this wording into the man pages as well.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
Cc: Alejandro Colomar <alx@kernel.org>
Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: linux-security-module@vger.kernel.org
---
 include/uapi/linux/landlock.h | 42 ++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 68625e728f43..6f1b05c6995b 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -12,30 +12,32 @@
 #include <linux/types.h>
=20
 /**
- * struct landlock_ruleset_attr - Ruleset definition
+ * struct landlock_ruleset_attr - Ruleset definition.
  *
- * Argument of sys_landlock_create_ruleset().  This structure can grow in
- * future versions.
+ * @handled_access_fs: Bitmask of handled filesystem actions (cf. `Filesys=
tem flags`_)
+ * @handled_access_net: Bitmask of handled network actions (cf. `Network f=
lags`_)
+ *
+ * Argument of sys_landlock_create_ruleset().
+ *
+ * This struct defines a set of *handled access rights*, a set of actions =
on
+ * different object types, which should be denied by default when the rule=
set is
+ * enacted.  Vice versa, access rights that are not specifically listed he=
re are
+ * going to be allowed when the ruleset is enacted.
+ *
+ * One exception is the %LANDLOCK_ACCESS_FS_REFER access right, which is a=
lways
+ * implicitly *handled*, even when its bit is not set in @handled_access_f=
s.
+ * However, in order to add new rules with this access right, the bit must=
 still
+ * be set explicitly.
+ *
+ * The explicit listing of *handled access rights* is required for backwar=
ds
+ * compatibility reasons.  In most use cases, processes that use Landlock =
will
+ * *handle* a wide range or all access rights that they know about at buil=
d
+ * time.
+ *
+ * This structure can grow in future Landlock versions.
  */
 struct landlock_ruleset_attr {
-	/**
-	 * @handled_access_fs: Bitmask of actions (cf. `Filesystem flags`_)
-	 * that is handled by this ruleset and should then be forbidden if no
-	 * rule explicitly allow them: it is a deny-by-default list that should
-	 * contain as much Landlock access rights as possible. Indeed, all
-	 * Landlock filesystem access rights that are not part of
-	 * handled_access_fs are allowed.  This is needed for backward
-	 * compatibility reasons.  One exception is the
-	 * %LANDLOCK_ACCESS_FS_REFER access right, which is always implicitly
-	 * handled, but must still be explicitly handled to add new rules with
-	 * this access right.
-	 */
 	__u64 handled_access_fs;
-	/**
-	 * @handled_access_net: Bitmask of actions (cf. `Network flags`_)
-	 * that is handled by this ruleset and should then be forbidden if no
-	 * rule explicitly allow them.
-	 */
 	__u64 handled_access_net;
 };
=20
--=20
2.45.2.803.g4e1b14247a-goog


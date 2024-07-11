Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B916B74F
	for <linux-security-module@vger.kernel.org>; Thu, 11 Jul 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716954; cv=none; b=h7WhC3R0y8izkIt6lZWlRWp33l2v2xgVLsWCJrabjLmSkNcLXwgZtCSVt+w7jn4aX6n8Kr+i8P3RtUemJqD7yJ0MJsat8WXRN3fw5OGRT2V15IgGs4uDjPMcVhQdzaS5GaFsuTaLl7Qnn8niPY8ZmCdLNqLDcXPKWjKjyuQJRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716954; c=relaxed/simple;
	bh=C9CaTVNOPzct39t+RjnfqGPNyoWy0BOzoOizLyQ1fIM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sIFTS1FXwSVaKkRWp0ahh1FEpw0/xuGd5QaTuUtH+Q6OwG9J8dup5505UE6dF53Ucyej3bg9lMzNaTN/lGj91xTRnl4dg+w17ZGzWaLNKCTw/ypDQMNMuZHTqA8SW/fnrAjOOFulgnTtGpC/kI68DTxBK1FtisTOoAQ6j8mYtZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syatRwrP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syatRwrP"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03623b24ddso2020859276.1
        for <linux-security-module@vger.kernel.org>; Thu, 11 Jul 2024 09:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720716952; x=1721321752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SvIVngPkpQF2aOTZHJCVjaJqnfJSy+eWc6U15OjE3Yk=;
        b=syatRwrPJhkuzhPy1FtsQ7/QV3BX1x7/LL5gFHmji3ProOf6VnYY+J9ANJ1moxYHlp
         JHsoi9v1egTQrfDVtlXxbFrdImY2zzEuddGxncQo+2D7aZTRHvsuotj9A9dVdjC4Co5H
         fJB21xZscRihefWVdp6xbgO1/ciTKmJrQM3x49nWM/WXogK3VjrCHi7c8SICUJaOmc0N
         6xl4mpw/tOjo9fLWCwPDnJI4afI47YNExh3HFVjzVH43fwRN0WVXStxtYTqoNlYHk4bn
         7tk/5RmnfKPRWkClwIRslbspy1YbVfZhjIldB8LlBSv5MgOww/o37cXpckVY4ZLt4B65
         Utxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716952; x=1721321752;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvIVngPkpQF2aOTZHJCVjaJqnfJSy+eWc6U15OjE3Yk=;
        b=Qyk8Mgp/Vr1U4RbvJw6KUhRaaFCiSoDfWUeWdDc9sb3blO2vAXKUl4kxdu7+QQT8W0
         7nh098/p8QHy14cKVZMdkI/CiwMBrhQaeQB5NReS/zsQ2PurWGYIoUOLnISN6nQ2QIOa
         Rk+E9YpdwiF2rFXLk65O4X5pH8FrOmYxfWM6doOdZLewu6KpZWwBhfWx3l3sc88jbAqa
         Q9uqgSWa4V7zkBWjnKUsH1ho+iSd/nAIoQtRMSMlzFCxHqunMcaKWAPkvmY9H4nSaqAB
         MLPG6NqUSrzcBR0IoD/LO1cPlI4aZs+c6I8L4a+9XsMnTJqJ4zExNsEK9d/nbxAIuyhb
         2DqQ==
X-Gm-Message-State: AOJu0Yzq+7zOiy87lkfmaI9/rLPjsB5TP6kQDK0xbKfrM2UZwZyGOgKT
	FS5jU7W6zf/zkFyWTvlpEXzoyTaoz2+CxtCZTIMotXSEKBD/iJ6wCyOr6yJwseKXmqmlq6ZM3s3
	HosuDJGDv3WJB+msQWB6Kf8p6KGCOE37ZduNG+fhBX4tD+DA5aGCYsELpwtZHx8L0jZ9JsCMj76
	SxjwyQpDySc3k/UgYBUYvj0XWC1VCuW7SPDVHxrNg9sFf7hUpxv6e0
X-Google-Smtp-Source: AGHT+IGdquWT8JIBi6oFVlr8y1ln5ftncZzRQisotGkZdXCBZNQp4aOLlOaeBUrjgV7iHrgBUpZTdCD/+Jw=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:1002:b0:e02:b51f:ceac with SMTP id
 3f1490d57ef6-e041b1415d3mr379527276.9.1720716952150; Thu, 11 Jul 2024
 09:55:52 -0700 (PDT)
Date: Thu, 11 Jul 2024 16:54:57 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711165456.2148590-2-gnoack@google.com>
Subject: [PATCH v2] landlock: Clarify documentation for struct landlock_ruleset_attr
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Matt Bobrowski <repnop@google.com>, "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, 
	Alejandro Colomar <alx@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The explanation for @handled_access_fs and @handled_access_net has
significant overlap and is better explained together.

* Explain the commonalities in structure-level documentation.
* Clarify some wording and break up longer sentences.
* Put emphasis on the word "handled" to make it clearer that "handled" is a=
 term
  with special meaning in the context of Landlock.

I'd like to transfer this wording into the man pages as well.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
Cc: Alejandro Colomar <alx@kernel.org>
Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: linux-security-module@vger.kernel.org
---
 include/uapi/linux/landlock.h | 39 +++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 68625e728f43..e76186da3260 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -12,29 +12,36 @@
 #include <linux/types.h>
=20
 /**
- * struct landlock_ruleset_attr - Ruleset definition
+ * struct landlock_ruleset_attr - Ruleset definition.
  *
- * Argument of sys_landlock_create_ruleset().  This structure can grow in
- * future versions.
+ * Argument of sys_landlock_create_ruleset().
+ *
+ * This structure defines a set of *handled access rights*, a set of actio=
ns on
+ * different object types, which should be denied by default when the rule=
set is
+ * enacted.  Vice versa, access rights that are not specifically listed he=
re are
+ * not going to be denied by this ruleset when it is enacted.
+ *
+ * For historical reasons, the %LANDLOCK_ACCESS_FS_REFER right is always d=
enied
+ * by default, even when its bit is not set in @handled_access_fs.  In ord=
er to
+ * add new rules with this access right, the bit must still be set explici=
tly
+ * (cf. `Filesystem flags`_).
+ *
+ * The explicit listing of *handled access rights* is required for backwar=
ds
+ * compatibility reasons.  In most use cases, processes that use Landlock =
will
+ * *handle* a wide range or all access rights that they know about at buil=
d time
+ * (and that they have tested with a kernel that supported them all).
+ *
+ * This structure can grow in future Landlock versions.
  */
 struct landlock_ruleset_attr {
 	/**
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
+	 * @handled_access_fs: Bitmask of handled filesystem actions
+	 * (cf. `Filesystem flags`_).
 	 */
 	__u64 handled_access_fs;
 	/**
-	 * @handled_access_net: Bitmask of actions (cf. `Network flags`_)
-	 * that is handled by this ruleset and should then be forbidden if no
-	 * rule explicitly allow them.
+	 * @handled_access_net: Bitmask of handled network actions (cf. `Network
+	 * flags`_).
 	 */
 	__u64 handled_access_net;
 };
--=20
2.45.2.993.g49e7a77208-goog


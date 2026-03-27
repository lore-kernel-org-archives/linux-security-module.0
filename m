Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868235F5E4
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630178; cv=none; b=MxoJuMeiF7crG8viy81EHmauhXEBa3ufqHyrBRmKScxdWTwrwGfodLtzyJJSpUITPqZt2+BTsyymR2pBiQfJSIZKAd5j/90b2jA+OpO14Nm6X7YGGTHJzv0/4FRCIPcc9gySAxvtBWHgj8r38J1D4cyjK71hB3ngRXUau4Q3wyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630178; c=relaxed/simple;
	bh=PYle4XZerr/+Oss0dUv8lbQM51oRuco3L9FQd4Ilm7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ro7E2WVshS95QUDnrOl7RfAX+GJ1kIf4rsexeLusjh6u67qQxsSrw9ghxCbIhTtgrwEbgFte38fnDXW5PpOHKSxi3m/ht3TAfkWfg4MkhlN12aMMxq3vuVOsot94wG6v7yE7nQKIieizfbb8lb1aj03szPlkEiftjtIU2P5oTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfShs0nw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfShs0nw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so22525285e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 09:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630175; x=1775234975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTlD5YQnitvwUc7v/rc9nhcnkGaN7PvIsoF2XflMgp8=;
        b=TfShs0nwUiiQ6VbENzP56IAwr0wX4PeFVgFJCYqsmzQGxJjLYvl7s8BfFhQK51sJUN
         b84oSg+9JcQ/9g/vC3t+vWWNqAqJFzpN/QJHYnutjzCyd+h90r7XOenSL01Wp9CsWXNs
         cNOr3m0Fq6wwu4jUB02FgW97wZepUCgqBPsOIZLyhrSEkWd9ZRzbiEh5RczVDCcaUiPk
         82ncbxgOoqD6L3m9YkepmwQ0R8CxQXLG91i++CLmwpSBpAGMNkfd+SoEpWgYBphp1kG/
         eI6LxOnXJ1wfkRggsUWaqv7Ie76KXP2C+LV9ZiVKLL/aV6cXPLuIvxCgZV0bjQIUOnc7
         ZLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630175; x=1775234975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTlD5YQnitvwUc7v/rc9nhcnkGaN7PvIsoF2XflMgp8=;
        b=npIkWOR73YnPzFuUdfzkLp7FqNB3D1om09Yn3z3cjRggtQSri2LhcnGzQrcXtKldni
         jvNbM5SsSKfyj6VguSPtaPDA3mfHVS+mnzeRDNmuobRf4mMZz6IOy3H+OKt0UFGeLQWy
         U2jbSb5Vs5q+2moDr+pkkV3jj/6O29L15jOOQrPL4is8yoBBDvf/XnBZHBMEAxvDYTm/
         jLpH6orA/2w//Wpy9QV+ZVrkZG/Cj/UDtZN4ccdLNb/E2OUqQScxn0JcKD80+bHSgXHo
         MMiWXrTiegBstakmdquGwx07DSz1gOFsrsEZTzSjXaO+v8NRCoU9SBI+Zn+WWKtu0n+X
         gFXg==
X-Forwarded-Encrypted: i=1; AJvYcCUW8FxLWvdgVK5+Yh46JD4KoJJ8/XEuKkJpcduF1tktqpB3LcM0/f7kkQJUc9xhuvG2FjcGrWLTVNAU0FjdH8G/H6E0ggY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf7GJ5l6Z1xVC/MfCs5Y/bV9ihkXJQ0DNXobryeA5O8c+YGaMO
	J6Cj40N7o9csMzG8pHhNAICXc1E+US46GJuYgyOl3dJChbRE5ofLjRlH
X-Gm-Gg: ATEYQzxbLRUIXyAB015FvbgXM5Hlx3K0zOisqQguhB5hOliw/BzNwa026ivL55eCFnH
	ii0hH8wZ7IB12Rfuh/Yq7LiQXCDYHpTh7ZmfLegbS5G41k2ZTOFP5u8K5n8TOxt0skqUbrlqvz0
	FD/GN6xe0szoE2/+iVyZZKiDLdKFpKrHrQNItNpMRe+dcYaRYQZQXBKqACZjJSu/FUTeiqxYKAe
	TqsHSrgZJcHP92VCuBhIWVS1rk7Z3gsVllmAqeT4gUxBkrLtqPXyQQ6xTBYINBI32Vw4AcKV+sk
	Gej2U6wEzGHYFvKanrZn6zskovDutU6JK4xq86hOmfD9EQIMePY+BO41TszBqDfCfg2cgh27ULv
	DITMpIZ/iW+OtzzhTIaRZgM4Sx6W9sv1oPzxxgVuybKJxzqwMo4OrV/qGZne3kANpkAwNOW1lBz
	YaYOxbVWVH7+lSU/jDc9WniFnM4fNpp6nwSwrYwtCSeybftDPF
X-Received: by 2002:a05:600c:6287:b0:485:3b5b:eb8 with SMTP id 5b1f17b1804b1-48727ef6617mr52872665e9.26.1774630175064;
        Fri, 27 Mar 2026 09:49:35 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c65989sm163696655e9.2.2026.03.27.09.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:49:34 -0700 (PDT)
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
	"Kuniyuki Iwashima" <kuniyu@google.com>,
	"Georgia Garcia" <georgia.garcia@canonical.com>
Subject: [PATCH v8 12/12] landlock: Document FS access right for pathname UNIX sockets
Date: Fri, 27 Mar 2026 17:48:37 +0100
Message-ID: <20260327164838.38231-13-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327164838.38231-1-gnoack3000@gmail.com>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
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
index 1490f879f621..6624af085a6a 100644
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


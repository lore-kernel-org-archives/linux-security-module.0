Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717712EC54C
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854937; cv=none; b=j/qLQ7N02IdM3oyXkW3c6GJjD5V4rL1waosaWSH3+qP9qPwQ5u+4Lga92PVsPtm7n3IgJ46lJRQikM4+QZZeMPTZjuGA6gELtLJXIbihVaDqQYBYEpd+7ZyRS6mHOGAvIHqA2QUU1amW36JDghozdpAoqM678XxzTc3x/fobBTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854937; c=relaxed/simple;
	bh=tQyZV1YRh3AVUUAZjke75WfrnVtR90TXUl0ZZNlay58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qv6f2xANfFFz2KHb5oLqORq5CJSR5aTtpjkDYfYbVoTv2P4NjhAZqtxUgU0PsVyAepRh3EgBD16ih0D0GkyY+CFByEQmm2XCEf+i5ZCuJBQpn+kFI3T4tK7+VEz2km4bWbSo1j7rzkFpCrI40fSbUHRjSj02MM4pBIhqYVrQbeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An3ROfXP; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An3ROfXP"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso9337313a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 12:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768854935; x=1769459735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iim+oTRQqSd6URqhLRv98ByCnLmwvLfF9tjNthwo+jo=;
        b=An3ROfXPNf5pheULNqBsR6dFTo2midfSJD0oFbS52qBYtNWl+L1v0jxnzPF0Jzc2wD
         HZ3Q7Dwe8Op/UlnBfv1KjnwEq64jUMMYlVVtdjl/yPPFofzIzYxQWwFXZqqSLjzTmhvF
         uyBaortj9szzziwQ/Lg8f2L6pPhTUSgZzmgxypNmyix+NGezywXbFQf014HWJOyX2S4I
         v69Kt5jwKy3zkOiuhfV1WhW9qxkVRv7f/zqHQDj2i/BoK/YqRhqsZ3UL5MKbzyA4+5H+
         qSp0Q0vPpSA9D7MWk42E4Xpsg4cpoAc72UTVwOIc8Ewm4LLzuotmFU1yHpecWd0DNItJ
         bxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854935; x=1769459735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iim+oTRQqSd6URqhLRv98ByCnLmwvLfF9tjNthwo+jo=;
        b=DxNJiHYygPC3umlRDG7AmyCQ5Iv6zEbuLmA7kCLzqNbrLWECOhdd0EAIr32YzNjjdM
         z2td8lOCCKVunllVm6T+aTAdcdVRTgYm/zWukY/I3EVrIUxz9pRqE6GkiTxb9RTx2flR
         eC6cxSVNpqzj5hQn6jLD2PnUexL4RcG6KWLUoRBt8d63rkGyWYfsQF9WfSzQOCtrzJ+Y
         5U156M7Dh/Qhj4xb1gEcqYbRMic5XE8sYz44ZTeBai+xEKq9Pr14BcYEGadSBBraGZwQ
         Rqv8PhzLdMvoLGi2Uw9Py3qOk9x1N+HUkQm9g5gXPQQPpjqWXEOBPMj6UucwSGCyePCC
         P3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXnnzHvuQJ+G5JQosTQF+30wY3RVIHnYqNZjcREX4od1F54N+GtJ/UF3v5QbPzqzZKlB6qVg8niWQEGDm3AEaVR0z5azg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7uzKVMwZuRcQeSzN/elF0G+9jTP6Lh8wAxiaURnU7Ivt91lgE
	IP2pVBNTmAzQpyhSq5G9L+1R8+msSk9UYILcvtZIi4nrFhCxGI9jD3OktsPFm/JJx+E=
X-Gm-Gg: AZuq6aKHcxgQF5NDobjPl2wx5oADMlg5LJpakuNv29ZmPAarFaaIgp2uVCehACrxyXe
	UIb55GRCR3lExOMUY7HcyEQy/0+2RZD1usl3fCBwBtlYCjmIhjpm04yXM0pD0IPzFVdtOfv5CeN
	NMuTOJiVV8coC1OCZ2K7pzKRIlV0ftt8dDkO46WvnjZgO0PHO+2nDLlQSY46qSWZrpb+fyTjl4n
	cX995plnJy5SYO+wgrd3699gv7GHpHeNyYNS1kFEy293wMYXWiM6tjBw3tcTRNghzSd8K4H8/Xm
	C+Mc3/uMr4kZBWx5PQerYqizSDvxkqu64eZC128kYQ7oWWErwcqr8uBf2WRwjPkSqdGjT+yky7K
	Z615bYWAVJ2BhPBDDd3rEImznDYsiVx5EMvO4J7R/iLUGripDi3jvmvfGKnxDKFJQMPO62yRRl7
	EJstbM7RQFkco68QWHudxgG/XCujCib7MU9fyJ
X-Received: by 2002:a17:906:2099:b0:b87:b0ba:5d2d with SMTP id a640c23a62f3a-b87b0ba6e99mr543133466b.57.1768854934662;
        Mon, 19 Jan 2026 12:35:34 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795169d30sm1220084166b.25.2026.01.19.12.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:35:34 -0800 (PST)
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
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v3 5/5] landlock: Document FS access right for pathname UNIX sockets
Date: Mon, 19 Jan 2026 21:34:58 +0100
Message-ID: <20260119203457.97676-8-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119203457.97676-2-gnoack3000@gmail.com>
References: <20260119203457.97676-2-gnoack3000@gmail.com>
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
index 1d0c2c15c22e..980ee5dc482d 100644
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
+    case 7:
+        /* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 8 */
+	 ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -604,6 +609,13 @@ Landlock audit events with the ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``,
 sys_landlock_restrict_self().  See Documentation/admin-guide/LSM/landlock.rst
 for more details on audit.
 
+Pathname UNIX sockets (ABI < 8)
+-------------------------------
+
+Starting with the Landlock ABI version 8, it is possible to restrict
+connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
+the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.52.0


Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F0211A0C
	for <linux-security-module@vger.kernel.org>; Tue, 18 Mar 2025 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314511; cv=none; b=j6XNW34yZ7k+Kb8jXd+EAfCpKxYAAur5eIa9cmVMK+Hp7KQXUtm/WediVKv+X5pwHaVfIiydvB2AYAJ0Q6GTSilPZ1Tj9e9vY/RA5YaxP1dgReNAdRokXZWc0/fCyck/SHQgsJHO1vD0T3B+2fICm6RVtS2JHPQ5mII+9RKgjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314511; c=relaxed/simple;
	bh=JIXfcRnOc2NsgTREu0brY0eFsywSqCuOtFh/aDiOzuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ny5bmrM5xCugkgRlZem9Qdfd4wdUWskYNKHpQd4kOzfWlV2Ja4nqzTiQzUI4qSuoL06kZyYc+FpMI3iC04QJ+E6tSD0oIbgNHgHf/KFT0ETRh0sWS2jgau44TwYJU4CgUwxktxfUYTrNqZ2Yp4ovJZOHFVOYNNAJ1uu3bhb8NIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vg9QND59; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vg9QND59"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZHH4540cGzFpr;
	Tue, 18 Mar 2025 17:15:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742314501;
	bh=TAanqdbmi/XehtIUQzZvwwXbsMighDnqKc1rhhGRDAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vg9QND59PMWzfBPWgQ7qHUm2QRgBm38IISEoW272yiB4ftP2voTwZC6yP1S/ZY+Pm
	 G+yqZJq9MMNZFXw800mqKfRbg60xjaj0kuUWfpWgd+m+GV2iUaHRh79QG/bdbVRz57
	 6k27WtDvY5L++56zwaiSP9szNgm/ZCKU3VQEaHUc=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZHH446ZD2zHwt;
	Tue, 18 Mar 2025 17:15:00 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 8/8] landlock: Document errata
Date: Tue, 18 Mar 2025 17:14:43 +0100
Message-ID: <20250318161443.279194-9-mic@digikod.net>
In-Reply-To: <20250318161443.279194-1-mic@digikod.net>
References: <20250318161443.279194-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Explain errata use case and include documentation from each errata file.

This is a dedicated commit to avoid backporting issues.

Cc: Günther Noack <gnoack@google.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250318161443.279194-9-mic@digikod.net
---

Changes since v1:
- New patch.
---
 Documentation/userspace-api/landlock.rst | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index ad587f53fe41..80b090729975 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: January 2025
+:Date: March 2025
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -663,6 +663,28 @@ To be able to explicitly allow TCP operations (e.g., adding a network rule with
 ``EAFNOSUPPORT`` error, which can safely be ignored because this kind of TCP
 operation is already not possible.
 
+Errata
+======
+
+These errata identify visible fixes (e.g., loosen restrictions) that should be
+applied to any kernel according to their supported Landlock ABI.  Because user
+space updates and kernel updates might not be applied at the same time, user
+space may need to check if specific features are fixed and can now be leveraged
+with the running kernel.  To get these errata, use the
+``LANDLOCK_CREATE_RULESET_ERRATA`` flag with sys_landlock_create_ruleset().
+
+ABI v4
+------
+
+.. kernel-doc:: security/landlock/errata/abi-4.h
+    :identifiers: erratum_1
+
+ABI v6
+------
+
+.. kernel-doc:: security/landlock/errata/abi-6.h
+    :identifiers: erratum_2
+
 Questions and answers
 =====================
 
-- 
2.48.1


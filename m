Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ECD346FB3
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022359; cv=none; b=Pdo/kaF93EJWA/NX+QxKslCNfGaNEtGODf2K4Nf3NjZFjN5+Mcogij5YuCnCkQvT2G9KqktsmcgcAH/4sORLErzVm0QKHbdUpbQ2iwtemipfi9twE9T/eJSU5V7DGwqu9wkvYo1DywD+ASKn7GEgumCUnPs95mr6FKFX2Bl0MiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022359; c=relaxed/simple;
	bh=vD2Lqmpd8WID0ao4NCkZ+pRjlzaYIr18UixJHy0+WT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kL1tMfW2ZcBIOUBoNvflvk55Z08fa2YXxxAv3yC770tcD6v4s5QJ5DH/n2gZUxoFasiudSGMhOft7xitRVmm/kVXgzCu3AnYjESXi642aCva/HTGAWiMMpK2bT1VCfw313E2rsMdL6Mc2VgDyOag2MGwupViUpuHB5OeF+Gb0xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE1rYDTJ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE1rYDTJ"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7986e0553bdso35191797b3.2
        for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022358; x=1776627158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqKl5sNylpq5crdJu3jFiO/PkjPfc0zWN4ejZQ/7vEA=;
        b=HE1rYDTJ8YJoJFN2eUEaJ9dPfGNFBP+yiKKMj3fU+U5Xld8bjqtv4tskE9YkawUIYt
         1vrCA2LOsjjvbGUEVtCwFul/9ghnMsjGmq3qYm8ddK2l19r7Z6f9hK4rZxsmNvFipvKn
         FFUg4ed8XAS+JAgUwBqkCm8COHC2GBpZ6BZy3XktnKnVuFA9NsKKiaihIogfGiaUSyC1
         Qf0IkQr5l/TvJ5fAz1qyNxp+cqLsp0cFdgiGRD+UOy5R5FJQlmH8Km+1aylqqBmn9VHi
         yfNf4vS0Y95oaIUgHnijdygZsy+pSEJYnzRp3wQ4uRsrXLLIBrEnxKnDAfIF2XoHIrA7
         x/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022358; x=1776627158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UqKl5sNylpq5crdJu3jFiO/PkjPfc0zWN4ejZQ/7vEA=;
        b=VGvfv0KpHA2+HbXEuilSJ+rP/Q0Rp0Fa4a6uvKYElzmJgyTAkmwML0/S7RoVUNchIg
         Cv5nW3hiCH1aQnG4zN5Iap+al72TtMalbGiwPWBDQuspeo+gU/yOpARky9w86J6qdQiP
         FXbeRcJXleA7f+dSh11QYdkJ000JapHl9BojSjMwuXcLs8xHwoKfdRY100fVQkOGRXQo
         TiqhEYLv9++DDd0bDpNf2dSq8z6rj3I0JG3gRUyYAniZ6gF2Xc7vt/ZTYm36HPxuZ/ov
         qBBntmwLiGmp8VmeucetzgWtvPw9bL+f0nzBHw4uEpPm5R70eTypfev006xRPkgOWWQY
         5GxQ==
X-Forwarded-Encrypted: i=1; AFNElJ85PghDQVcppkC7/XnC1Z/4MB+hB24dDd64YIjgitEBkgpnqafgNhbEb3keaMVBkKlbfKZsksoh8+XSpmRj83OlbakgnkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM0101fQrgtWCDHsuZYlVAZUQHby8YiX04M8E0BKqZAq/PcH9q
	QvgzSRFNYiqzMmiSejZXZ06zjiw/C8VIrdeKiyFobTlpG17XxtmjVDst
X-Gm-Gg: AeBDieufJmcNgrkmy1PvAu3zdYURLVQp03ACapeSoBpEr17VhLOtJgptqKaFX0UkkVI
	p2Dl1JguqCQF6IMcz2gz5h4AHG4mcMQ30cE0fsWI+IK38TzttbKN+Q7K7Ew3XpE5xsb7m4X1FB7
	+ayGzu1+Fd18ZIgmgyMneBetjp7Ja9Ga34rHUdWiFvWjVnghPb7+wr67u1zJCjC95dwi7JYvTep
	g2g8YFI6B1H7T+oZYAtCXsngyL+OvKTc3XRBf+PIZmS/kLLUjFQudvgP7VN0HUqzyoafnUVuk4H
	u70N6OXQwSbBAfz6KquBPqZEwWI2a0hWkWY01YqJt8kHRrHKr1XBmh4M7gTBpJev4O50+LxCnVj
	OnfXgQAHnrm3W+dOUoXnpLA4VNCRRROJ6OXOi+fZDv+JYubQfAOo5Su3q1W9or0DptkHT7t6HwF
	a1Df7sq51voBRnSmBCy8F6sXl4J1gw4HuNKxjEoClRhCJTeTFfy20G+SvVB2BEWrVsm15NuC9P
X-Received: by 2002:a05:690c:6604:b0:7a4:a215:9238 with SMTP id 00721157ae682-7af6fbf7a47mr125020977b3.19.1776022357693;
        Sun, 12 Apr 2026 12:32:37 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:1192:20dc:2cb3:dcdc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3c8decbfsm42395807b3.8.2026.04.12.12.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:32:37 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 07/10] landlock: Add documentation for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sun, 12 Apr 2026 15:31:58 -0400
Message-ID: <20260412193214.87072-8-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412193214.87072-1-utilityemal77@gmail.com>
References: <20260412193214.87072-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds documentation of the flag to the userspace api, describing
the functionality of the flag and parent directory protections.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v6..v7 changes:
    
      * Bump the documented ABI for LANDLOCK_ADD_RULE_NO_INHERIT to 10.
    
    v5..v6 changes:
    
      * None
    
    v1..v5 changes:
    
      * Initial addition

 Documentation/userspace-api/landlock.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index fd8b78c31f2f..f49e30a1599a 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -716,6 +716,23 @@ Starting with the Landlock ABI version 9, it is possible to restrict
 connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
 the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
 
+Filesystem inheritance suppression (ABI < 10)
+---------------------------------------------
+
+Starting with the Landlock ABI version 10, it is possible to prevent a directory
+or file from inheriting it's parent's access grants by using the
+``LANDLOCK_ADD_RULE_NO_INHERIT`` flag passed to sys_landlock_add_rule().  This
+can be useful for policies where a parent directory needs broader access than its
+children.
+
+To mitigate sandbox-restart attacks, the inode itself, and ancestors of inodes
+tagged with ``LANDLOCK_ADD_RULE_NO_INHERIT`` cannot be removed, renamed,
+reparented, or linked into/from other directories.
+
+These parent directory protections propagate up to the root. Further inheritance
+for grants originating beneath a ``LANDLOCK_ADD_RULE_NO_INHERIT`` tagged inode
+are not affected unless also tagged with this flag.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.53.0


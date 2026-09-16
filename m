Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2433B19CA
	for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572238; cv=none; b=lASyncwtjKVG2vjCgfdfo9vugwzqJjgvN6djNA28Dr4EMeZeH14e3dA2KpYgu/LJSfgXGECLNHtsmwcAXudvy1jMP7VzpjDXB3LwdOyKNC+1I+HTC347C2OFnNGu6pyWlXZFxJFrbJ8pCLVe3pHsLL9AtzFep8mWRBRgJY1VwcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572238; c=relaxed/simple;
	bh=oLl8fjZTbq37IaphHO2AVCVFYPM2f1JU6S+DNccp2cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kgq0Y7LvelHh6QumM2S3GleB7ZhE4AUOgEAzlmjaFbSuvEZgF/jR+FYxAL72fqyyg7wRNp3VA8Yrl8PhmUpE0ZSbdE31DtAo2kKnfM7FLEEagJouvThhJWLu/Fj9wl8SM7p2qM2AkvNMCLZv2Tfx/E0vRX6GRj606wF4UdKqzp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=KNJZ23k1; arc=none smtp.client-ip=74.125.224.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="KNJZ23k1"
Received: by mail-yx2-f3.google.com with SMTP id 956f58d0204a3-6712e34848bso107667d50.1
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1789572229; x=1790177029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V5K768g5siM5TtZg6LJ3Bszma4LWRnch5JHQsrTQEf4=;
        b=KNJZ23k1LRkHTx8J9GFae2iES89F5nhd8hgUjJ/wiiI/st6OrcQuwXOoUocw4wVIdS
         1Nb5g7ylWYPQCvGoODGGh7Jt/I745z1J04hrye5zQb/Pf3QlBOQ7tIPA6K9Yeyf25CpQ
         WhKUEgb5Vdh/uPtK6seHGdl4pTvwI3vV+TNn4/MVpz16eEy6exYprgVhNfxmxOa4iBo0
         eNZD7tLwU7aUfJF361YKOmWuRWtVF7qXOsCozb8eBrMBaH8PU2dCxf9aTyXUFZdvPW7u
         E40+a6kIzQbr9bz1ya68zTQPeMrnOt71zZ2xMziHXqqFtnE4aGYS0ZWkvKr69peMojHi
         WGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572229; x=1790177029;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V5K768g5siM5TtZg6LJ3Bszma4LWRnch5JHQsrTQEf4=;
        b=T+M8I1SaaOKSTGclkWlonIwHJxLO9ImVRShwMnJ5gqOK4dElX2Th65in9j3lCPIbOO
         cYw3+n4THrfjXPnyLYgrYpnRSzCFoVArjrdg3zQ9aj0b8lGbj4ADUXR0cQfm0AboHFqh
         cM/lqjuMvNBF0Mecaay5MlWh5Sri/UKK37tKHwUT3Fk/fbhucm87WR7lqoJfDB7yPG0e
         sHw5Muu8RjI3bswJGlQwOGyvqCNpZNa1ya16YSUGFdPM0Na1D36prXpdqot4pgqqEEFR
         rjAVbq679BR0lG7LFbq5zBhEmbbUc/lT9oL2deoCNGKGD9im+PklOWUDoyV8+L/sR4Aj
         ZOlg==
X-Forwarded-Encrypted: i=1; AKwUvBw2m6zhaeBu2GovBugKG7tPDa8jFki7uKo187ng2ukCREqpTxRzAG1fsUYGz1STrCYSRaH1CiYdk27cftCU+F6bo0UWEao=@vger.kernel.org
X-Gm-Message-State: AFuF++nU5MvJHIVg17MccXmwIGZcAl0q3yzVLOBSeM8LSR6N25utqwPE
	qM1NgsUsE+wsyJ4Rk8bfd9mYGvI/Ps655cF9iS08qRsS9WN7xiQKSRkO43mhYKMUVcVr
X-Gm-Gg: AYBFou0d0n6EPE6tauFqpofNEcy4om0NlzkIpNovm0Bfi1f3yCDpVSzwqLusEb9gYCH
	kymJ4LVV13cSmluYpT90zzjCJypNfTvsDkur+6ZGN4ELIAYLUupS+odfGflX/3Qhamc/c3/Arc5
	iUfbc6mGD/EgFrpb2L8JwyeYnJJwFiOvnm/ESxg//jtm3Jw2kZVYxMtn8l+Rr+RATePRNtEN0aH
	IkM14CS3okfed38qPrnkcD8WdW40o8Gry0FEJqqZzwPhVeqT3fkW5dP+hrsBGT4ZP7XiEXXkv3X
	jfiSieKemXFkSzTsIX0KturkvGvSYTe/jFCeBtC+00+PtOx4r5LxJMbpCBNPVnYXGOYp7aPt/7o
	W5YwPvCFWMz4Pcbl2F2z3mZ+utWBTqnzIhxmzhov1THEGOD0XCW+WO0DWh3b4Gvmu9e/h18u38d
	eegGeV25btO2VkBD4mstDOloSArEaSYB5WoiyjAM42YMS3FIOL9pzJiEnZIG++S+31XPFma1Rjy
	gVEMX8rCszcg7XWsYOXQ6+csWi/PXamq1+/LCk=
X-Received: by 2002:a05:690c:4b81:b0:870:48aa:472e with SMTP id 00721157ae682-8921c5494a9mr14065377b3.0.1789572228991;
        Wed, 16 Sep 2026 08:23:48 -0700 (PDT)
Received: from kelso (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8943ddc0220sm67927b3.18.2026.09.16.08.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:23:48 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: landlock: clarify TTY signal scoping
Date: Wed, 16 Sep 2026 11:23:36 -0400
Message-ID: <20260916152336.1589383-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The LANDLOCK_SCOPE_SIGNAL documentation does not describe how TTY-driven
signals interact with signal scoping.  Holding a PTY master file descriptor
is a separate capability: its holder can cause the TTY layer to signal
processes running under that terminal, even across a Landlock domain
boundary.

Add a concise clarification to the userspace API guide and the UAPI header.
This records the capability boundary identified during review of the
TIOCSIG discussion without enumerating individual TTY signal paths.

The documentation text and changelog were drafted with assistance from
Codex (gpt-5.6-sol).

The userspace API documentation builds successfully with the kernel-pinned
Sphinx dependencies.  The patch introduces no new warnings; the existing
missing-graphviz and undefined-label warnings are unchanged.

Link: https://lore.kernel.org/r/aqqJAZfG9FC7PgMW@google.com
Suggested-by: Günther Noack <gnoack@google.com>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
---
 Documentation/userspace-api/landlock.rst | 3 +++
 include/uapi/linux/landlock.h            | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 84cb7bf6b3ed..33a514ebc615 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -430,6 +430,9 @@ The operations which can be scoped are:
     This limits the sending of signals to target processes which run within the
     same or a nested Landlock domain.
 
+    Holding a PTY master FD still grants the capability to issue signals through
+    that PTY to the processes running under that terminal.
+
 ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
     This limits the set of abstract :manpage:`unix(7)` sockets to which we can
     :manpage:`connect(2)` to socket addresses which were created by a process in
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index cceda3b3b961..6485af37dd25 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -501,6 +501,8 @@ struct landlock_net_port_attr {
  *   related Landlock domain (e.g., a parent domain or a non-sandboxed process).
  * - %LANDLOCK_SCOPE_SIGNAL: Restrict a sandboxed process from sending a signal
  *   to another process outside the domain.
+ *   Holding a PTY master FD still grants the capability to issue signals
+ *   through that PTY to the processes running under that terminal.
  */
 /* clang-format off */
 #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
-- 
2.55.0


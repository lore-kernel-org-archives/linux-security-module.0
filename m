Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB43C65FD
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181389; cv=none; b=MGlLfY3HkPajiiJmmVZfiPUwlUP2OcW2WT1jLTlb1+rvnKeThfqSbvWnoXmHZ9ESXrSDSxSFk4YX7CMxCUiQOdx+i1iIeh7PUhysqVHL/zkuZEBpfaRNca5GAqJy5dRG45wKdpoa7ofqTauY2FksxAQs9L2v1IkYyqDZQQReDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181389; c=relaxed/simple;
	bh=HyMlUX/W9HvvI5kZhh4XgDfUUhUda5AirsyOm9dGlUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3nBy/CHcFXEgtnU2weT94FQzMJWKaUnLAvDuEHgOd97rfAMi4hEfW9Q1xFWglitDSHgLm2vN5VGz6OmcTkqZ7ub354o90KWEtgXnR5ixWtaI39FK/pwUKMgQFiraMeYM/fvmy5g0FYOxv598ydIOlkGNTZEjnBHB7hJfDwzPhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=QhKCS5ty; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="QhKCS5ty"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-859023466e0so1083397b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 09:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1790181379; x=1790786179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K8ztzFzESiCouCMaYiUr65tJ28qhpNA5LSgzOI3RJSU=;
        b=QhKCS5tyYcQwxn+dfVzq7sGjioWxu2ybxkIxfXdUJioJuhAMZeBkge8rawr/9F1xVM
         7MAZxqAeIh6t3tie7645xAt1j92seJBopW5YOwg/5lJO4678Rq8RFdNc2e0vZZWDS+do
         zYX/AR7TkonFvYJJ8vqbmbSOjWgIkL7JU+obB7deYyCg5dDaamUeQaCFsrRmIG/RTIdK
         ZabJksbPlhdJ+HNZ8llKwuzIWl8O6g22HgBZEaO5CQze4ET7W3XxKzdjmp/neb0Zd1R3
         nKae+V5+1/wgR29z9OgCeCYvsm4gSh2edqqR4a7hkS0r5x6WcID6rCu6Jz4743shyUzO
         r1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181379; x=1790786179;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K8ztzFzESiCouCMaYiUr65tJ28qhpNA5LSgzOI3RJSU=;
        b=flPCbjNNEtoohtVHXQDUsED0UNiezY5fJ/WYRG1Th5df7PdfNhYI0RUPWe0vPV0CTl
         UtMbNyiF9a8VdKeRLERmswshMAD0VW/R+jznmVLI+sQQQH3KmNcrLoDGtF210wCsqXSS
         YZ6j284SiUcVK2bJNXIuoMOZj28FA/WFyJ7rvHC3+w0BaRIrnonFyk2jOssGxEsmK24Q
         zLtpJSxOBT0a+kn0A0SmsnBRK5GEvOjZR/2eWjRJ5dQcgeGow3B7HXCnc94q6y1ltg16
         mk2/2rbw5Xm77gYfxWBespMen/JkwFqblCH+r/VVdKzZ8j/cIx50YSK6U90nrHdLjYgG
         AiHw==
X-Forwarded-Encrypted: i=1; AKwUvBzVXBxBnU4vtDGJf+MAGGubjr+xn/zMXRJifc7R6iXZH+SwRAuYjg5YDN0OmHfzzvTUT4rp9MJqykNJI+OwLZDH+p+c4Ko=@vger.kernel.org
X-Gm-Message-State: AFuF++kM4YeuNla5p20iFamzBE7vV3wK33ecknPYsem2SIO3nukzE1kl
	Dg96J4bKHobA9G2y9q1fHlGm2M5fslgsAiRqam5v/thlVLv4RzMkf6UU0bSfkrOYZS+e
X-Gm-Gg: AYBFou0iV9ZqWRWJVc2mDUkns7Jwe7CzqBs/Mrl+Qz3gxLmrThZeMSdSbREiL8y167x
	GFS+4WDz3DsLfILgGTeQh5gSFhWQuoOGBXzYKEx4tgQ55UiJoGQ8bDnvK/tNII2zRcYcNQ6MNBE
	jYbDVmS0o1k3XEK4SaZZfaRfL1VuWI1k9B27oaTp/5FmgVgPARkmdfUwbTHpf6jWsDZcUOxYV64
	Ki1AqI82ES8DYN1wjWrnIwR3WOjtK7VE/fTLO8Tw55HTU0QR1nTx+EJK5mMOjyTd+S+TQeyb8Zm
	2FJIr5MQUE8OG/OwLgt4RIIaP7wtT12z1G1/IuFk1oECLrC37RbFg4XVrUBiiQvxb0UnrSaYb/3
	rnJCLUtQNwrWDI+GE9pa+eCxf0PQNYaM4mrg5Q0OK9ACTfo8Y2DuvDMOptb6z8PnMSYj1AthqST
	n3SYq3wCDO4URwCnuS2qAhAICECkX2UzXGOXVpLgBowRnkJZq/wGvK4WLiT32hb8u4OS+D6/1pz
	H9WLyu9xa7z5zdN3PlyAV/hihbn6sP99SpE2+U=
X-Received: by 2002:a05:690c:6b13:b0:862:bb29:a715 with SMTP id 00721157ae682-8a45bb793d0mr35516137b3.3.1790181379194;
        Wed, 23 Sep 2026 09:36:19 -0700 (PDT)
Received: from kelso (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a4658c9778sm12709257b3.8.2026.09.23.09.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:36:18 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] docs: landlock: clarify TTY signal scoping
Date: Wed, 23 Sep 2026 12:33:20 -0400
Message-ID: <20260923163321.79770-2-clusk@northecho.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923163321.79770-1-clusk@northecho.dev>
References: <20260923163321.79770-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

LANDLOCK_SCOPE_SIGNAL limits signals sent to arbitrary processes outside
a domain.  A PTY master differs because its holder controls attached
processes through input and signal injection.

Clarify this boundary in the userspace guide and narrow the UAPI
description to arbitrary target processes.

Built the userspace-api docs; no new warnings.

Link: https://lore.kernel.org/r/20260916152336.1589383-1-clusk@northecho.dev
Suggested-by: Günther Noack <gnoack@google.com>
Suggested-by: Mickaël Salaün <mic@digikod.net>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
---
 Documentation/userspace-api/landlock.rst | 6 ++++++
 include/uapi/linux/landlock.h            | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 84cb7bf6b3ed..4d9fb1f1588c 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -430,6 +430,12 @@ The operations which can be scoped are:
     This limits the sending of signals to target processes which run within the
     same or a nested Landlock domain.
 
+    Holding a PTY master FD grants control over the processes running under that
+    terminal, including the ability to inject input and signals.  A process able
+    to write to the master should therefore be considered as privileged as those
+    processes, and this capability is not restricted by
+    ``LANDLOCK_SCOPE_SIGNAL``.
+
 ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
     This limits the set of abstract :manpage:`unix(7)` sockets to which we can
     :manpage:`connect(2)` to socket addresses which were created by a process in
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index cceda3b3b961..ad7b1ebd62ed 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -500,7 +500,7 @@ struct landlock_net_port_attr {
  *   connecting to an abstract UNIX socket created by a process outside the
  *   related Landlock domain (e.g., a parent domain or a non-sandboxed process).
  * - %LANDLOCK_SCOPE_SIGNAL: Restrict a sandboxed process from sending a signal
- *   to another process outside the domain.
+ *   to an arbitrary process outside the domain.
  */
 /* clang-format off */
 #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
-- 
2.55.0


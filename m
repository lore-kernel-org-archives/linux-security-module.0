Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72E2D47E9
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766173164; cv=none; b=Sfpazf1Tj8qHfe4eAWRW7NJ+RxiZo1uqsggDt9dmwmx5Rsn9kFayckMJ7vAzSDHalKznNirr0wVajRPdFlxA0IAGa1KcdzVq+0g0f+39gvcAqlGDyVlZPlepLzXJTf8McFCkLZhvEfSFioYrR7EBNZTGuVfc4eURMAeDdKGLYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766173164; c=relaxed/simple;
	bh=UEi9U00taEC9YL4CD1jtQaUdHRibvbEqXIi2tAckEac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKqKI0HA/U4qSJ7RBzt7jUoL6e3IJfP+3ph9v9Mca6CrzcfLF4M11zI6j0ybSqFNZQh0dAt95cFMXii+3X2fEmBI1pExRpJezke42Ur1ejRujsSfJ3oVFogqq2wP7NbeZNvT6oK4lMNzxqP134jZHWV6cdK2dyHhrRaAZbO7hGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ew218sma; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ew218sma"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dXyXH4LlNzm1Q;
	Fri, 19 Dec 2025 20:39:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766173151;
	bh=ymM7wVasf1mvkhQjzTvf18r98jdMZgnPSL51sjRGqe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ew218smakTEVX6a13MoiEJMhtcA3qJgYK6IzF0d55QR8xjRYoMkKqA+moxmcWE3oK
	 PkpeiUYwDTGBiiFLR4Bg8IjEYBflt6We1UvVqX5ZBEkw9U8I0CgFTxTqS2Rk0Cu6Bg
	 J6gVvwpBId6BJ45XCJbsm1ES5sa8cC+8TQiwmgLs=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dXyXH0HqlzLbl;
	Fri, 19 Dec 2025 20:39:11 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: 
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v1 2/5] landlock: Improve erratum documentation
Date: Fri, 19 Dec 2025 20:38:48 +0100
Message-ID: <20251219193855.825889-2-mic@digikod.net>
In-Reply-To: <20251219193855.825889-1-mic@digikod.net>
References: <20251219193855.825889-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Improve description about scoped signal handling.

Reported-by: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/errata/abi-6.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/errata/abi-6.h b/security/landlock/errata/abi-6.h
index df7bc0e1fdf4..5113a829f87e 100644
--- a/security/landlock/errata/abi-6.h
+++ b/security/landlock/errata/abi-6.h
@@ -9,7 +9,7 @@
  * This fix addresses an issue where signal scoping was overly restrictive,
  * preventing sandboxed threads from signaling other threads within the same
  * process if they belonged to different domains.  Because threads are not
- * security boundaries, user space might assume that any thread within the same
+ * security boundaries, user space might assume that all threads within the same
  * process can send signals between themselves (see :manpage:`nptl(7)` and
  * :manpage:`libpsx(3)`).  Consistent with :manpage:`ptrace(2)` behavior, direct
  * interaction between threads of the same process should always be allowed.
-- 
2.52.0


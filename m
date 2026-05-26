Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D5368964
	for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809750; cv=none; b=JLVHiNwvKZXtA7kS9hPddA6y1mpQoZpaZOPSl93iXy7HoVyrUyIrEwshJPz+6+C7eabaI8d/dfPUZPQYE694jUC1foqB2mz8PLyxStP4eoNdxX500WlpD6yiHGEQoHnRMaPxAYCIzPhQjoU/Wy+H9BxmbkAmUSykWYrCsCcRnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809750; c=relaxed/simple;
	bh=NuDqJGTOYHhRsQ9gakG/33fRFBaIncRipDI9L+xU6VE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbPsdelXsjDdwEFvbNIwgnx0UL28EieB/SY6hLvK3uTBeH1AbDys1nXyWcoxQjQaTrbnG3I1YVW6fPFteemDRsyXBEArmia4Xlw6J32vOBl36v5ihOJZIvTQ4LQZIAcFNyutjD2FgQTAwSptwZfJaUWKc87hL3HWi41uJZWkQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=SOJJ2ORc; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="SOJJ2ORc"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-631a7868228so7187478137.0
        for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1779809745; x=1780414545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1SF4aD6INk6fdsWXArAkTfVU/esaaz0J7oWltfvu4dQ=;
        b=SOJJ2ORcb9OOHitX/1JItAE9BuPbUuuVjLMOymAj6JgIl7YyqTg3wMwzrPGl9WEser
         Gguo3vflPI3YT3hsbkOQXygX4wXQm9tEfvw/jJoQUkfLfdqg3N/Ygvr6d2qief0yGYMO
         RfeqBWhIIiMzQEUgf39qTq//CE9Da8Kgbt/WSWjFm8J2VjfesEM+jHGv2qd/xnlza32E
         Lv5IQZrhQ5XsICrjCqx6XUs+lxzIsose900KyXVcUKZItS42jX9auS83TkqkkVDOvQ3J
         y1i7cTbvt7xE3XxlPNyxkcDO91XtMpfsToqFaPWvYkgN3IxbREe1cYDxAx9CKKA/k7ri
         HqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809745; x=1780414545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SF4aD6INk6fdsWXArAkTfVU/esaaz0J7oWltfvu4dQ=;
        b=SfznVQ5FkXB4yDAt6nWKC5xU2aC5E4ErdgxEMqWz+Gx7JG4f7ByBb91rxwDYw71+4K
         0puwgdpzzQc8Mdy8vylFbB/nRDb7+Tf+U8OWTnTqkhYrIwasr020+D0fvMxSSgn4xKic
         l+N4zCJzjikBXtHH4PNHBMxaSHHXbip0pAiI1i0D9z55IPD76erCUg86TOe7lT8BWAZo
         XzDJeQIo2/prFtmkFakT2B/RgJi8CVGglzgOE48tEKnm77Bd37G5kRRjGQWAi0G2U/im
         /i7Z4uMqDzjMXBaYYvzjBwcdvqmLUvV7clNQpupg6Fxo79I39FHUr/wq6mSfvyu3IXcQ
         efOQ==
X-Gm-Message-State: AOJu0Yy4/vocZp7ps12v1EP1HlLOYBKut7H+eoaS5UmGZXfLkCvJci2V
	ExKGykvdYBhIZwPZ521ScCX56p6W31OlMGYAt4gL3S+d7CWffSdFGFFCUiM5xA9YbdB5O0ZcCfo
	dn8Zx
X-Gm-Gg: Acq92OEqSG9eilf82JueXyazfOhsJFFA2rjyUkbAdVJhpA+EYoB4eP2q16X9Qzn0CDJ
	CfAtY2uAF4k2Wn4N+LbPvq9p2A6S0PgaawUGf9J476whC1CeTqbR7H/oZFzgOK9czVl6GA0aGGJ
	4d7srGOeykbgkpUBqdlSKyVeJiqsRfDk1bVZwfxfRG4qisKKharXYKNdLyqjpfnY8YwZxBFNmD7
	0EWfXushf7ciZwlIjyijvvV8XgBKLlP7waXIXnGknTB8CTp5/aZ3pmXPRXCX2aYKUfbRWyvGLBY
	PuoO5V7/B3Dt6LLG5oWp+coRBbGz2ltu4O90ptMXixx8bv3oqBVeS0MMhE9guP2A7X9qe2shngO
	s+vatLXThBGwf3I+JlXtVvQfWtAbCrCgITuf7xLQWKLub6yubAZreWggbrs0zQqXOpDwePy9l0U
	Q66yCNrTlY18wB+MUP8Zu8x+su35MsZoYStUebfRZ0SmWhGoeiRsM8XKqMA84q7z1O8GPbFIVh4
	l/u9NE9ig==
X-Received: by 2002:a05:6102:e12:b0:62a:1bba:64ee with SMTP id ada2fe7eead31-67c7cee41d9mr9889846137.6.1779809745234;
        Tue, 26 May 2026 08:35:45 -0700 (PDT)
Received: from warpstation.incus (107.191.145.34.bc.googleusercontent.com. [34.145.191.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dd02c1sm145053886d6.6.2026.05.26.08.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:35:44 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: kees@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH RESEND 0/1] yama: clean-up ptrace relations upon activating YAMA_SCOPE_NO_ATTACH
Date: Tue, 26 May 2026 11:35:41 -0400
Message-ID: <20260526153542.105483-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once yama's ptrace_scope gets set to it's max value (currently
YAMA_SCOPE_NO_ATTACH), all ptrace actions will forever be denied.
However, processes may still add ptrace relations, and the memory
to store these relations is still allocated, even though it is never
used again.

This patch cleans up all memory related to ptracer_relations upon
YAMA_SCOPE_NO_ATTACH, and additionally disallows further modification
of ptracer_relations from processes.

Ethan Ferguson (1):
  yama: clean-up ptrace relations upon activating YAMA_SCOPE_NO_ATTACH

 security/yama/yama_lsm.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

base-commit: cf2f06f7152d
-- 
2.43.0


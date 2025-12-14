Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6AA24113D
	for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765731968; cv=none; b=Wb3ZauvDeJv2Gl52j4FSG8GyDAszm9RvFaJ6wgBqfCdVDfVI39eD0i/P3b+BbrXjjFLQE5n/9NyLYk5grivGjqgfe+PDO80Fmfegn852d9Eoims5QcZ0acDXspwKDv+bdz7eIRQr6+R5wvWtTEB9xmLNzHt7lH15i+1mQS6r9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765731968; c=relaxed/simple;
	bh=a8jlAnlBcpoh23Ct+hrdRQ6LMFGXAQPWGJOorw8+ebQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kmm0tOZU5bXnEEdfgzbiXu5p5v41ETdM8/rFYqGjmfRTyrGgob3QcnUQazNjkji4fFtETjpoks9wRTJpAPU1ZZYfTu39seK6I36EylQXPsFQch0QgUcrJxP3dkfCnDMZYO4GAgGNBLYlrR9jC8OPbO0QrN/xRd50UhghbvQPBU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3eyDMPK; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3eyDMPK"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78e2fe1f568so23349687b3.2
        for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 09:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765731963; x=1766336763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96JmxRz7g3wRzIawC7epGmPER41ZJv6TULuRiFCbA3A=;
        b=f3eyDMPKQLy0OAAdQHFd/SKNj2r6pYPxwJvYQY+Ywfs1GZvUEI26ibwRPvVozi1jl3
         4LRFP+Kr2R+Wwgop4J4lY6RJjjtELIgwJPU+2SWDikB4YdZe2Vk75r7E/dRF4PvsKMWJ
         ATM8QB8RxBvvtDlAKTw+9nms6cpaVz2gF2RFhFNYviPAeTslCCgHNOLE/rZdbq9goSXl
         2dVm9pqh9BL0oi32RqqCvLakAcX5x7/gVg1AKjtTnap4VvnNxpvYfYcNYC5L4TyWSdpl
         T2DV7aXs4xbDEtQ6qFzyfoMmMOpGESYWDd75Tyirh61HknR1r8FV+/LG86XKkxHl8BAy
         SY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765731963; x=1766336763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96JmxRz7g3wRzIawC7epGmPER41ZJv6TULuRiFCbA3A=;
        b=MXGJt6v97X0XGjM6ykF+2fTdS2xVccIadX8Pz3X9cRPvITp0nfDD/wV92LSt9mlP05
         Qr9dA8qNv9sdPIXlDeJeEdF8sSa3q+n1tU6u8+IBy56JK5RliuMfjO/GrMdj03pmgL/q
         1quhjqe8gZO5n0WSf59DdIbqidZdW4Witc06vD3B6F67+jk8WEoVqH9DJhGYHk/2m2NW
         tEhtJoSqmxkCiHzLJ/IGuVi1Q4WQ8OFjzU4dW/9drKDHshy1WkQyqu6S0R2aTRxy1bCY
         qiRHqhTVl/TW1QefepNzR7gqpuFtbKzUCiuO00mbm+ACLJswqqw3BvD9BNQZXSiDdJWB
         PE4g==
X-Forwarded-Encrypted: i=1; AJvYcCUI27oHF8ThbvhGZuHxqMbM3uGUG1PkdeV+gXPejR2atE13I/wOmUkD1ugJ4Vzb3dvjmaS5J6b2bVXcZ/v9/SXbvKEhH/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6QJ17g5WIvsy37x1utcFweQ5+BdC6rY7S48W988GxgIlsBJTD
	sQfd0mPo4QbbTpU5v48+/IkNEl0we6DhS4JXhBw8LMDuanADGvVjzLKT
X-Gm-Gg: AY/fxX4/W/ZxhCV52XUod86Pae0VW+Hred2/y75qZbnpEexsX7dVly8TmprtS4Qj7um
	paTgdr95EXVp23ZWjWEXkNu3b0WIRpZAWGwC9zEdTGI+UWs3w+oO5sBQSuFnbZfKnf1lhUUgJuZ
	RiEmtOpY/7+PN9yQ8mZoDPQyNodc1h1faNjaZz8QMXY9b3f1zlrzee7cjgJzdLfCwnbyLB5Z/CQ
	TldB+UPUpwHI0bBNeWlJm19FohpH2Utz9UuPmxBouXdjcm5lJtEL3MONJxPA13RxSPf0RN4C2gv
	OuLKE9luGHxIuVKmJrrWShXRS033wKlIhu8PHU7U52mzitnZYm8JAvEfd6tab/cfnyhLV2wJvpU
	uRUOa1wcTDB87BsWsyXuSzE46zQyK+9xqzYOV7Msr27ZcugdIBp5TInM9kNJM7LtlNCmzFOXhzQ
	3jLabp86HqECVKJhtIsMrkTNRJwJ/VwAMfEdtaeRaRYfBIL2IhJ57Uem+xOoWE
X-Google-Smtp-Source: AGHT+IFgUW8SnAQzJAZ/oyXQ9rJfwnPFIkhjTJofk49kzBMN2WIyCwYgYQ7tXF/Aw58my0Mk+QfwRg==
X-Received: by 2002:a05:690c:b0e:b0:78d:676a:c006 with SMTP id 00721157ae682-78e66e53952mr61687897b3.42.1765731963173;
        Sun, 14 Dec 2025 09:06:03 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e749e7683sm19401117b3.32.2025.12.14.09.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 09:06:02 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 6/6] landlock: Add documentation for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sun, 14 Dec 2025 12:05:46 -0500
Message-ID: <20251214170548.408142-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214170548.408142-1-utilityemal77@gmail.com>
References: <20251214170548.408142-1-utilityemal77@gmail.com>
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

v1..v5 changes:

  * Initial addition

 Documentation/userspace-api/landlock.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 1d0c2c15c22e..3671cd90fbe2 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -604,6 +604,23 @@ Landlock audit events with the ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``,
 sys_landlock_restrict_self().  See Documentation/admin-guide/LSM/landlock.rst
 for more details on audit.
 
+Filesystem inheritance suppression (ABI < 8)
+-----------------
+
+Starting with the Landlock ABI version 8, it is possible to prevent a directory
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
2.51.0


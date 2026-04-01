Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7D361DDA
	for <linux-security-module@vger.kernel.org>; Wed,  1 Apr 2026 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056169; cv=none; b=L86epaDqY5u9cX/UkdUnyYsYWEyJ4X+0DaEuTZt6qnYhMcNZJUxrh96h58cIS7ady5S03RTTc8MRCguOM5K6WdoLTxkgcR3zm4Ue/sfZe85tRwIbeCUG8/Agg0wJ699ThfGKjM+56UgcvGG6fFHTB121fZDekL2WgX4Nvs0MFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056169; c=relaxed/simple;
	bh=TYImxQ0raZlYxa+hVemvw4NjrHU/MZubi0CaurCmRgQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kA3QUnl4KlRtIo+GVPqLeH5CjTJ7o89eHeqheIUjuJ8ReLEIU4v+kcEVY7oM+SBN8tbdekHIr5eVXcbWD95Mkk17oeCkhKRN52cv/fqQe/+dra6axIqcNRH/BkWZ7yHh1lAmfIsBrysGkI8Ay0QR023fJzYPLRyf7PTHy3t3T3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQt2NQz8; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQt2NQz8"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4887e4b338bso10641655e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 01 Apr 2026 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775056166; x=1775660966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/C1aMgqD9yw77MbkVR8omjc4JaXGn+12NJ8kWTEyuk=;
        b=MQt2NQz8dBQbMuhLBJ/Zgg+0DjFjF8iMKLzca9b2ySKreMwQ+O+6H8e7z1v8tMbmsy
         taHQCTBb1givjvXAgYNyuY4p3pPlW/b/ps1FnLeDijORrNF5yOQX+uRL9VapQFLEQBxu
         DtcewiekACTq7w3Ctoo6QXYdrM2+r7z1ase3IPiIDq5VxerQ71i7sskrS1WLPv33Hc8u
         Wnp+1zvibkQPpHr350fZb1sB/zHsI/MnhvIjUoC5th45iyuqrN3IaDaFKZF3/zYExyvq
         Aw5yZzipLgc6hArx1Cjw+4PCK0gOINiEeJY8L5FF4NWUp0zA7KgqOjQgnb+uFMZlwSfE
         pIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775056166; x=1775660966;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/C1aMgqD9yw77MbkVR8omjc4JaXGn+12NJ8kWTEyuk=;
        b=DaablXbuVGU6rLM2WMe6GWJo240RLOGg/LiwoDkukUOj6HVEiwqJwMeJ+tgaWQfTWl
         7wDkuHrtOupeZEPVu4p/b8dQcf0VDd+HDjCEtjAyBwE+t/iEfpl4reK80dQ3MbMnV9wd
         BQgZB1mZk1KZ+58GYEqfY1o3VIRccJU5k0AsR0pgFeYXuZt5D7Juw1O7I4yET04EJNFC
         sy5uFaPOk1g+Ai3NmMQpUpXsH1NSXeTuEDix4zJcWcCOFww/HtcB5kmhJTgHoEBvJBpe
         OWL9LT3sI0lv7oAB97EdTkv55YO+GT6liMwYKuDfFHekKyJ23bIm+yNoYcT+SHyMDjeP
         EUUw==
X-Gm-Message-State: AOJu0Yy2CHxPLIEYBKymS8/Ps/arJVlpKAhrQGDKCfZZjkvlFlojxyVl
	F01XApri3sckQpMF4g4OnHwBM0WczBoxq0jNKVHx7328cwsFD6tHu4aBmh5GLluWgYMxFGqkciu
	jLX/yDQ==
X-Received: from wmbjt8.prod.google.com ([2002:a05:600c:5688:b0:485:314d:637a])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e85:b0:487:12c:e7ea
 with SMTP id 5b1f17b1804b1-4888358935amr58995365e9.5.1775056165849; Wed, 01
 Apr 2026 08:09:25 -0700 (PDT)
Date: Wed,  1 Apr 2026 17:09:10 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260401150911.1038072-1-gnoack@google.com>
Subject: [PATCH] landlock: Document fallocate(2) as another truncation corner case
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reinforce the already stated policy that LANDLOCK_ACCESS_FS_TRUNCATE should
always go hand in hand with LANDLOCK_ACCESS_FS_WRITE_FILE, as their
meanings and enforcement overlap in counterintuitive ways.

On many common file systems, fallocate(2) offers a way to shorten files as
long as the file is opened for writing, side-stepping the
LANDLOCK_ACCESS_FS_TRUNCATE right.

Assisted-by: Gemini-CLI:gemini-3.1
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index 7f86d7a37dc2..d5691ec136cc 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -378,8 +378,8 @@ Truncating files
=20
 The operations covered by ``LANDLOCK_ACCESS_FS_WRITE_FILE`` and
 ``LANDLOCK_ACCESS_FS_TRUNCATE`` both change the contents of a file and som=
etimes
-overlap in non-intuitive ways.  It is recommended to always specify both o=
f
-these together.
+overlap in non-intuitive ways.  It is strongly recommended to always speci=
fy
+both of these together (either granting both, or granting none).
=20
 A particularly surprising example is :manpage:`creat(2)`.  The name sugges=
ts
 that this system call requires the rights to create and write files.  Howe=
ver,
@@ -391,6 +391,10 @@ It should also be noted that truncating files does not=
 require the
 system call, this can also be done through :manpage:`open(2)` with the fla=
gs
 ``O_RDONLY | O_TRUNC``.
=20
+At the same time, on some filesystems, :manpage:`fallocate(2)` offers a wa=
y to
+shorten file contents with ``FALLOC_FL_COLLAPSE_RANGE`` when the file is o=
pened
+for writing, sidestepping the ``LANDLOCK_ACCESS_FS_TRUNCATE`` right.
+
 The truncate right is associated with the opened file (see below).
=20
 Rights associated with file descriptors
--=20
2.53.0.1185.g05d4b7b318-goog


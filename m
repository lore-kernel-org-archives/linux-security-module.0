Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430433AA4EB
	for <linux-security-module@vger.kernel.org>; Tue, 28 Jul 2026 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228316; cv=none; b=YLETGim6EVlTsFOywu9nGS5Uzqz7JgTP3iPMH3B/krDUXRZfkECmB+c32W6dXh/Jepkei45lkA2iNr3vh5BnB4vuQ2rbv+SCRemOtuHd7w5ubBwf9OonvCi+xeSb8yMejOjoXOgPMitpvZbHAGEcqlpzkmhQ+8meUDioAsnvAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228316; c=relaxed/simple;
	bh=XL7M3CFbRaWzta3d5k/hiLSQfRlVsavebS+3dtJQ8c4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gtdEKWG6asWbZXBxgCTzT0dBXWfj/o7oazDUzPxAWBo6XrGlXSZmbP0E2d6boBhKcpqlzK/ZDpJA99wRq+IPwPL6dqm1hxBWMVIdHc/ZFdX/5ZUs9dHPJ3o5h2aRS9HwjufqqrW1Tl7LGp/P+sYaK65jY8O+VOwehluCzB166sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tTEbz2tq; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTEbz2tq"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493a7fa8481so4167285e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jul 2026 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785228313; x=1785833113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N+ia8UvU2/BvObPDqCGNu1HPWvH+/6chFDg4z2RifV8=;
        b=tTEbz2tqNsk3L88VU9+DQm6tBnd/MTl4qWAAPCyin2axTxCKMjduGBykVk14y6gd3g
         kIjTjQdIUqSAOGBKbBpUQoI/1KxfTnE3X0JPhcHsEMfBjUBvqvRA2zf39AbAiyU4f2SE
         is7DnTEU0HfTbbS1DH4FYG6XJofhbLSCt87zJMbwTg47T0hsmeRZ78n64lPFA7u1aGBp
         Ng5rwmgnLXtfRVWUQ6bW3OKccr/OU4VnaxiqACCsmFYc7hNQgUSYYpt3IXDez+DMnrQA
         mQXp84SRBhvtdQuG4+6demy0ieuMCw8uizsQ/tsCdFlJoR7FXcEclDG6zIxy9V8NhdRg
         4p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785228313; x=1785833113;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N+ia8UvU2/BvObPDqCGNu1HPWvH+/6chFDg4z2RifV8=;
        b=FLfa/wzJkotjZqjAkSONDs1MUWnzvOCWJ4vLULKGcUJmY6WGTpFgGHkEh1cMI8h5a3
         iXR+5oubtHTyosr0yvlOWd5mSedwNSGwaetPzeASfMRzriI88/9ZJerO7FkwhqJTl1wu
         s0TguRFFq4ycXjv7aUhSnp/NzrgYVTFhC6XUA53H/xpU6uJQbreV3Yfha1beaWcFojzR
         RP8IGj1leb/6uVQKjP9IpfGtbzZiu79h5YEUKIE2SMkkBUINd99xjde/+1U4MeKIB9Q8
         9d75H2dYgg8a324s9IZlqd0zGi6mWaphZcb/0BFMs5o5D7whRJyT9vK296ohL8nrhgyl
         wbxQ==
X-Gm-Message-State: AOJu0YyPz+9nd5FaEd3tRZc0f5XqhViRSy1hdPm8y/zYQsPJ0W8xEmlu
	PMommynLh4kwkG9N09D4p2FxtIECWLRUkWFYOpoM9YYPiZraLFh1DaIprBWk8IHGPznKLMqXIhG
	xDrtVnw==
X-Received: from wmot19.prod.google.com ([2002:a05:600c:4513:b0:493:fb57:3896])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:474c:b0:495:3c6f:7c18
 with SMTP id 5b1f17b1804b1-496c641e095mr14838215e9.3.1785228313218; Tue, 28
 Jul 2026 01:45:13 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:45:09 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728084509.218288-1-gnoack@google.com>
Subject: [PATCH] landlock: Document io_uring credentials management
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

io_uring can override credentials (including the Landlock domain) and
interfere with Landlock domains in ways that may come as a surprise to
users.  To reduce the incoming questions about that subject, document it
explicitly as a common surprise.

I am intentionally vague about io_uring's credential management, as this is
better documented by io_uring than in the Landlock documentation.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index 5a63d4476c1c..dab04f8e4962 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -675,6 +675,19 @@ fine-grained in the future.  Until then, users are adv=
ised to establish the
 guarantees that they need through the file hierarchy, by only allowing the
 ``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right on files where it is really require=
d.
=20
+io_uring
+--------
+
+Operations issued over an ``io_uring`` can be executed with overridden
+credentials (including the Landlock domain), which are either captured at =
the
+time of request submission, at the time of ``io_uring`` creation, or at th=
e time
+of registering a personality with the ``io_uring``.
+
+Depending on its configuration, an ``io_uring`` may therefore use a Landlo=
ck
+domain that differs from the one used by the current thread.  When using
+``io_uring``, it is recommended to double check its credential management =
so
+that the credentials with the appropriate Landlock domains are used.
+
 Previous limitations
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.55.0.229.g6434b31f56-goog


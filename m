Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B475034CFAF
	for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153977; cv=none; b=FhaxTGXh/FlLwZSgyeFiInslXm4opV1HNy4/F6A9aaY996pqpHJLqBJ0JV3U45RKwN8gcccID+YGkLgW6c0P39YTTDtj6SdoM8H2yk6/lllL1vw/tZyIHTFLnVg1KT8uvQHlqLvDfQnu68eljGyTZLAhuK5bQYPEEGoYoKKD3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153977; c=relaxed/simple;
	bh=UpUo31jx0wt7UrXw5XM8wlGO3R5v+c1VTy5L2yGwIgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g36riFY6H95T0Sjql33SGwsN0WxO1I3dR4lo/K8/w4KgZCVHRq3CuVVm/uzZAtO4n4fdLuLYnAQW8ruSgtv+9wzLqn2Yp+3IRZNjyujRStdMNJ9Nzd4tk9e+Z3t+tt/TB0XkspCHLpZEhSUTRpxWZrBgHCnKBpMbNS1MvW6LQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrLS931s; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrLS931s"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so9622117a12.1
        for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 09:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768153974; x=1768758774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aIHPZRBDqC9W7S9M0xIVK8D6F7YIEVVLxLCmiUkgEak=;
        b=VrLS931sqY5oSC4j3CTeDecZrDR7fizelEd/tM7Pn2Gw2GQ0Z/XVMOIfbIw0T5fqxp
         aKmUpng+ri2BwpHglplbQStJ3RbE3LbvVxmgiIjPECCovZRE4P2v+86U9M23N+kuwZGL
         sFF4WajyLo0JmEkgsQlqiCPbH04jtPq6uaICEW1UlC6G9AkrZsf8xLVnJowg60m+JryI
         WhYjkjHAwtx3n4YMU4f7BPz2QUQLaCoApRM8SwgJxkdIcOytbZ9I4fOo2vPCgKZOf7GF
         BINp99j2p25Uqw/O01cgg1fQcAk05QoyBdwjA+K+gUy8jP9efrUMkPvvPLF1rUw9KKXM
         AeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768153974; x=1768758774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIHPZRBDqC9W7S9M0xIVK8D6F7YIEVVLxLCmiUkgEak=;
        b=StUpkpFr8Fb9CUewu4eiylXh5prfqGwkXb5ykiTDWtOUwmMc4OHDI+iAj+MIa0ulyb
         N4dd8xyT9Dk+HYZbLvc2pZYI9RG+l26T+tFxeUiJkbYuVft0BqbJf756bVXipZMcf80/
         1090g+ucbmyht2VBU9xKqWs0mMGJarHTJMYBJy09DRY1xFlmNXF7dXRsWycLL0m2Nd+Z
         28o/J7iTD0in+ieD6kJrdJjX3KyXyCN3NacxJe1K7CRHjL67gqIosEyGgQvNQjSWgFTz
         3ofKHsuTRXBqyTvUmtqPYZQgTPt9H5rQPKp9ANnb1OopVsxeQkC1m+hs41eEm1yzQaoV
         aorg==
X-Gm-Message-State: AOJu0Yy6GUPxkb+nMSp2whuZspFGLBqSUcWeHuQ0x5QpfOHs8ivhv78k
	sJ/P1aBHiQLNveOq+gAbgLJLHQHc+SNVdjYpCj+otg+6+S+YKbJXjwD2
X-Gm-Gg: AY/fxX6kzBRGx7GjKv17ZodaHOcJeKkx7Fn21qrYbsl6e/K9QP2RhTKCyqvRJS86jRs
	78cDaqv6NRiOmIaypnvh28fIBWGMizW7gr8yWLra6RsHJH1uqnEBQA76qGD3d5f6xIaJ38sVd04
	uGnsCfMMvXPGlE+aLTvFxL9UjIw20jsob7vhW7YaSlXfZg5WaLN6YNbhHFFD20IGQXdSfI6rBXZ
	baUh9cjWlNON/olMbrDhce2Me8Z54srusn8z2IdJ0dw0B89sb/w0I+PYXry+jH61j6tFnhWBQ25
	r4/Lmsan17Xixn8l5lw3mYzQt0449yCVfms1ZPVcEuIcsjP74VDFa5HSJGS3OQfjchsBXgNhHNQ
	wYWTIphMFaq7RV//oCt6ue9WuRivQDfRdgwzwk5TczLKZJvZWbpun50eCvR9wugFLgaqpWE9ljN
	q7cFhs/RiaK3QgckdvHlfck9sKloJGynpLPhcn
X-Google-Smtp-Source: AGHT+IEuSDlaLH+JR6FOa/KLob9WWZi9RQF0j6ldywVjUB/LsI8ue17nUDPQPn2HsHNvxGogMSF9nw==
X-Received: by 2002:a17:907:3d0b:b0:b83:1349:3a7 with SMTP id a640c23a62f3a-b8444c4d0e0mr1512320166b.10.1768153973698;
        Sun, 11 Jan 2026 09:52:53 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870e33259esm223710266b.8.2026.01.11.09.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 09:52:53 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCne?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH] landlock: Clarify documentation for the IOCTL access right
Date: Sun, 11 Jan 2026 18:52:04 +0100
Message-ID: <20260111175203.6545-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the description of the LANDLOCK_ACCESS_FS_IOCTL_DEV access right
together with the file access rights.

This group of access rights applies to files (in this case device
files), and they can be added to file or directory inodes using
landlock_add_rule(2).  The check for that works the same for all file
access rights, including LANDLOCK_ACCESS_FS_IOCTL_DEV.

Invoking ioctl(2) on directory FDs can not currently be restricted
with Landlock.  Having it grouped separately in the documentation is a
remnant from earlier revisions of the LANDLOCK_ACCESS_FS_IOCTL_DEV
patch set.

Link: https://lore.kernel.org/all/20260108.Thaex5ruach2@digikod.net/
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h | 37 ++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index eac65da687c1..fbd18cf60a88 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -216,6 +216,23 @@ struct landlock_net_port_attr {
  *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
  *   ``O_TRUNC``.  This access right is available since the third version of the
  *   Landlock ABI.
+ * - %LANDLOCK_ACCESS_FS_IOCTL_DEV: Invoke :manpage:`ioctl(2)` commands on an opened
+ *   character or block device.
+ *
+ *   This access right applies to all `ioctl(2)` commands implemented by device
+ *   drivers.  However, the following common IOCTL commands continue to be
+ *   invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL_DEV right:
+ *
+ *   * IOCTL commands targeting file descriptors (``FIOCLEX``, ``FIONCLEX``),
+ *   * IOCTL commands targeting file descriptions (``FIONBIO``, ``FIOASYNC``),
+ *   * IOCTL commands targeting file systems (``FIFREEZE``, ``FITHAW``,
+ *     ``FIGETBSZ``, ``FS_IOC_GETFSUUID``, ``FS_IOC_GETFSSYSFSPATH``)
+ *   * Some IOCTL commands which do not make sense when used with devices, but
+ *     whose implementations are safe and return the right error codes
+ *     (``FS_IOC_FIEMAP``, ``FICLONE``, ``FICLONERANGE``, ``FIDEDUPERANGE``)
+ *
+ *   This access right is available since the fifth version of the Landlock
+ *   ABI.
  *
  * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
  * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
@@ -275,26 +292,6 @@ struct landlock_net_port_attr {
  *   If multiple requirements are not met, the ``EACCES`` error code takes
  *   precedence over ``EXDEV``.
  *
- * The following access right applies both to files and directories:
- *
- * - %LANDLOCK_ACCESS_FS_IOCTL_DEV: Invoke :manpage:`ioctl(2)` commands on an opened
- *   character or block device.
- *
- *   This access right applies to all `ioctl(2)` commands implemented by device
- *   drivers.  However, the following common IOCTL commands continue to be
- *   invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL_DEV right:
- *
- *   * IOCTL commands targeting file descriptors (``FIOCLEX``, ``FIONCLEX``),
- *   * IOCTL commands targeting file descriptions (``FIONBIO``, ``FIOASYNC``),
- *   * IOCTL commands targeting file systems (``FIFREEZE``, ``FITHAW``,
- *     ``FIGETBSZ``, ``FS_IOC_GETFSUUID``, ``FS_IOC_GETFSSYSFSPATH``)
- *   * Some IOCTL commands which do not make sense when used with devices, but
- *     whose implementations are safe and return the right error codes
- *     (``FS_IOC_FIEMAP``, ``FICLONE``, ``FICLONERANGE``, ``FIDEDUPERANGE``)
- *
- *   This access right is available since the fifth version of the Landlock
- *   ABI.
- *
  * .. warning::
  *
  *   It is currently not possible to restrict some file-related actions
-- 
2.52.0


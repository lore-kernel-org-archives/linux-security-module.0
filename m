Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A1363C46
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019546; cv=none; b=d5ZOr4ohf1vjd/fkHBtTNEZruIMBHifUcUj9yDyDbJOkh1xnjrvArPECDgxem2sRvgbhAc+cwFIRcpi6zqF5V0f39zitvG1731ufHtdhxJENcPaCBYpEBEWw1KYj80jVMJznl/NHyQnYzfbjbYdkT4Ul0RKtMM3K1MbkBKJQW+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019546; c=relaxed/simple;
	bh=7Tcy8Vd2YFqPv1kuhiGHki5kQkFlk7YAgNHoIyhBMxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQ+g7xPytmgHJYyTFnLRvZNfGkBRmwMdDzVMTolNwpuLUBkem5Q1OLew637jGaxHZ92NRQGnhU+Q+bVrzmFZ+dsG4La3WqKqeX9IA8NWWZRPwQ8h819Xx7zxK4/HOY+O6JWVE8SdCGx4oThtzLnN0qwabdKJ5g8gCqOeJDZLmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IO8vjeVS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO8vjeVS"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7dbe0943b21so26509837b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 18:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019543; x=1780624343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzvSYVigel/B+h2nExs5/MzF6RaaZLzOGje0ZHns2RU=;
        b=IO8vjeVS8Iw154s8kd5C6TiAnPl6r2y6oFXfG8hL66mxg4ADOQPXO0ntj8dc2RtPen
         DZ2NYAtvrGDkOdoQHiU/4xuwIVQwMOfjyGu8NMZ/PKys2ghk/BmCzm3lhZC5douv0P58
         sWdAd05p7o7F5iHzTfmhXnmb6cmrHLqkrPTo/y3pcc21RSvKEJfwhEUYocdFWftP/r79
         nBNhnZexjY+TB5SPgK0K4cYYDM3zsA+1qHb0K61DxIJNVUKfWI5OIIdtLHKSwU5ihEGm
         x6EFEv1X25JgvyQHZ48JN4iMJ6SHpF9U0w2aXN96XlYgE3DeqCN0QsvJuWWSSS9zmmKi
         EyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019543; x=1780624343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzvSYVigel/B+h2nExs5/MzF6RaaZLzOGje0ZHns2RU=;
        b=e6AR6hpIknWuzCYts9v6Bv6RbU+oz4br1qn8LM+Ju9iwaRLmLJ/iZPsWbGX9ac3SKj
         h2qeX1f9GRCqbGEkvJuTY4cKQ4XUHAcaFhp3MxK6abFe5YNlUOaCjWUGE/6TCmG7+L76
         yVnygPCH2DX9Kgkh+ART4sLRfaUZCNSriu5vrUOOT38ZWv/gQgC1rgHFznpfl5nTsIOs
         jBP6PR/Pw2ttJL6rEGGjMaFZ+pWEI7StyfQzJabNmhprGy1QH5gOcUABwY8010g+B8tF
         aLukp9t4rdbnJMR7emwLYuEA4+Y2q5Gbuf9wOWJs7HKInxBjAerU4EA8MEG5MBV15l+z
         Jsdg==
X-Forwarded-Encrypted: i=1; AFNElJ96zbGs6yhD+qPXlP7DUL7HQhNGXcyhv/LQDqwMgO0LIFB9gpTiXMyU/XzDKYxoZADr9aVbF9uNB4BKVpQQGNiD+7gZn+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YykhtXAGkBM6GmdUq4n/AMCC9P0Ia57/GgLne6CaHmSr8lLgVwX
	7CNU45b1RKUeF9qUOkVTdLnZg6pzPlCwIdEjMYo+/1EZl/p3mBHYluhpQAJu9g==
X-Gm-Gg: Acq92OGyE5X2DqTPqQeeqSq8/aoDh6Ij+h0VjfqUAqqieyi1E9PZpD7GZpWhMCPAkS5
	M1HqrMvspLH1Foa2eROLYiLRN+VfbY4zkIAE3u7gm6jwWJaYIYbzq0dHGkqXPqgCMR0tiHY0gAC
	FthM2b+JDEMRQMOyGFTx293uGKkcTizigYe08GOX1hYBgNhL2wcVYYBSL44DSVqPkIBWPzVVY5N
	RpmWaNtlj1OxifZQowFd3rTOQj6/CTA3kFumffeYuiP9Q+PxKvJYl8tTQDi/T8D0MbFzsXzPxlk
	lkdx2G/XJS9PKZKeqDJVrgitf5ulIb8s2/YZJ2LN/d6izoGJJNdAIbpUYqzi7jS3gBZOGtWdfsd
	MoYh8oKFUnswc4ndec6Xnn+jooSvoamUendG+5fXCP8xMZRU4qGR38wiNbTd/jNh01VR6o3woFO
	qgAvpyuLAtlt/Q85k/EJOW4iFMOc+0dZVBviURs897Q4PYjx9DHSTfvhXMw3BhdpkVzlzfrTGtj
	Vv0dzxVCAY=
X-Received: by 2002:a05:690c:c24a:b0:7b2:9347:7ba7 with SMTP id 00721157ae682-7de334bfec0mr7343957b3.22.1780019543380;
        Thu, 28 May 2026 18:52:23 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:7a41:d368:8442:1cb2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6d1f3943sm1284717b3.26.2026.05.28.18.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:52:23 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>
Subject: [PATCH v8 01/10] landlock: Add landlock_walk_path_up() helper
Date: Thu, 28 May 2026 21:52:00 -0400
Message-ID: <20260529015210.500291-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529015210.500291-1-utilityemal77@gmail.com>
References: <20260529015210.500291-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for centralizing path-walk logic, add
landlock_walk_path_up(), which moves @path one step toward the VFS
root.  Its return value indicates whether the new position is an
internal mount point, the real root, or neither (i.e. the caller
should continue walking).

No functional change intended.

Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v7..v8 changes:
    
      * Reworded commit message; no code changes.

 security/landlock/fs.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 3b71f569a8f9..8e75583c3ca7 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -320,6 +320,38 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
 /* clang-format on */
 
+/**
+ * enum landlock_walk_result - Result codes for landlock_walk_path_up()
+ * @LANDLOCK_WALK_CONTINUE: Path is now neither the real root nor an internal mount point.
+ * @LANDLOCK_WALK_STOP_REAL_ROOT: Path has reached the real VFS root.
+ * @LANDLOCK_WALK_INTERNAL: Path has reached an internal mount point.
+ */
+enum landlock_walk_result {
+	LANDLOCK_WALK_CONTINUE,
+	LANDLOCK_WALK_STOP_REAL_ROOT,
+	LANDLOCK_WALK_INTERNAL,
+};
+
+static enum landlock_walk_result landlock_walk_path_up(struct path *const path)
+{
+	struct dentry *old;
+
+	while (path->dentry == path->mnt->mnt_root) {
+		if (!follow_up(path))
+			return LANDLOCK_WALK_STOP_REAL_ROOT;
+	}
+	old = path->dentry;
+	if (unlikely(IS_ROOT(old))) {
+		if (likely(path->mnt->mnt_flags & MNT_INTERNAL))
+			return LANDLOCK_WALK_INTERNAL;
+		path->dentry = dget(path->mnt->mnt_root);
+	} else {
+		path->dentry = dget_parent(old);
+	}
+	dput(old);
+	return LANDLOCK_WALK_CONTINUE;
+}
+
 /*
  * @path: Should have been checked by get_path_from_fd().
  */
-- 
2.53.0


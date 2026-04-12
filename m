Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBDF1A9FA4
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022349; cv=none; b=i35H+C6FjihDjUU8ZYetGsH8kp6jmtbEE9L5kWyPgk7VuJh6mOBSXynwNxeJjP8OUATBpccr2YRN1+psUi2owL3KagPWpB8Q+Q+TLEv7jCzzWXtgUHEA9mS2uImDUj89joSpKo6rqZW9uCCFGt+QTbD7uY6mW2FmFwLdM9evsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022349; c=relaxed/simple;
	bh=JS6G56bMWvGjwMv739ywKlFR5k2Qnz1zhqigtorvC0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4bYo3ZuSMyuFuhD3w56Myv3CfLry3bqhAvMKNU63zfUla2Uv0Mdv+kvmEYb+fVO4wDoZTxHeLrddU/5FmmIaDWXkkvEdCfizYTR6ZgdHJrquSZ0vebzQUomN80q0ddnHNnvnU6B71pqQDngJO8ccR44sZIYbw/0rA2jyizDCH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy63Bwys; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy63Bwys"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79ea87af213so51352487b3.0
        for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022347; x=1776627147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzIATH4n3qNV3YhovqfwVOYHzvOWmMPkfYqiUReDNC0=;
        b=Iy63Bwys+B+0NJouMSslmb8IyvOB1K7IQoKegegZPIvqz1v7VxzW9X8vZIsqSQD3rP
         SGEyguKYtEwp8Rv50lZ1PHTC04X9X3UY2BmH3Akg7JnHajPsUBknJttsKKRRiEmoBw6l
         Yh7jQ8XgOeiMyqBISC1QYqTA96rIMwtRZ64Nzo1yoLcbfK/B/C04hW0u2tx8q4Q/ZUaa
         o7M5pYOD0+uCScGFHakXgqEo757wqKHDv9W0b0cmGus/WGA0EqGvsGofUlvRjJF4mb8M
         jdF/Pwwo1SxBRTL1fgkaowtVYglB4rL3MXayLNGQ0dxpq8aoYlDu1uq9m6pWNgJJKuqU
         tHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022347; x=1776627147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bzIATH4n3qNV3YhovqfwVOYHzvOWmMPkfYqiUReDNC0=;
        b=ijQ758kOH7SWmWi6phNpVOm1PC+ugGFeU0tFkiz48Mmeu4l8gjqYKBzCMR9FftjSRn
         PVWwNgJalNHAzlEAVXq5Sy6R2O/Qgv1Y5VmBenTHQuDIic17Hpak3evZLPDXSdGYIVOg
         VBDFmSK/SqQr/oLdxZsJnHCvMeOYmSy3BLkUAXKOVUKazxu6BSSAAVBPZZ4Hr8HmdDsZ
         oUGmWmxX/ot20BuEu1A3ozI5uhyCCcBBYcHpGO2IH5LYYwV+VLct3Q8qFdKLTuW5PFFa
         zoZEkSnNJ4VdRURNIF1g13rIPfpOA+UUfP2Tjoh2zCsgBSfmehfzlxEvgxg0pboMHb11
         HhgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qklvLbFLMYOZD5kA6x2Eap2rC/co1DQcRZo0PUbA4fyL8H3WEAMoZeEIg2wAoOQDu8Ij2lG/YgARueNtZSCeDTXyMdx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7o0AYvYskMo2JeX9q/lFHS1pLlg/GBXEooeG5BumlhcIL3LTj
	hPrX5zDFtomnQdBQLehDnkCwltVD3HoxAVM/Fqk+ofiqzdYyfDVwCLo0
X-Gm-Gg: AeBDiev2AET52In1LbYctyEhotCw0CHMV+0aN0OZu2IXVUg4gex9m3QGwNS8ngyEb/I
	jdzsQEngKZr+BkYspSk+QPZrGL0rVBNVgD881LICtUcSvU+pTc4grqaF5kQZBgXoZ4+1ecRo3nC
	EMXyuQF52pkW3ej+2uReg0NTkkHKLXb5ZQHhWoPFwVjTu7XfUniWKswluh3ZRW8L/qnrR16+PdJ
	Q7MU5SV6HBw+JtZKM1KzAxindhJQY/bytpKQ9B6fsHiVVxPOY2a//Zn+Xozx6kqA6/1XnzWiggi
	YIXU97xiaokITOK6CnA6Ssp/eQpg2EotKynpnsWBsLPphMPrcqv6gDr36g/9kpQelPzxiu0o0zt
	AL9ajsWfTx5wRPSaAFgM5ZYcRv/YJeZ8/oldSOQ58EoKs6KQmWyvqKt/fZHWCYvnqZhKwt97s4/
	84Vy/ynzwDILf2xAcwsaA1mxqoevHT9pP67S3wUZ0+Jm+h4ayNsGW1VdBt5lxqGapMXuiraHvtW
	aGBJVB/OxA=
X-Received: by 2002:a05:690c:c4f1:b0:7b2:7dc9:35e9 with SMTP id 00721157ae682-7b27dd88907mr19774287b3.8.1776022346963;
        Sun, 12 Apr 2026 12:32:26 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:1192:20dc:2cb3:dcdc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3c8decbfsm42395807b3.8.2026.04.12.12.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:32:26 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 01/10] landlock: Add path walk helper
Date: Sun, 12 Apr 2026 15:31:52 -0400
Message-ID: <20260412193214.87072-2-utilityemal77@gmail.com>
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

Add path walk helper landlock_walk_path_up. This helper takes a pointer
to a struct path and walks the path upward towards the VFS root, and
returns an enum corresponding whether the current position in the walk
is an internal mountpoint, the real root, or neither.

Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v6..v7 changes:
    
      * New patch split out from the v6 core NO_INHERIT implementation.
      * Added enum comments.

 security/landlock/fs.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index bd7554d0b65a..644637a8c0b5 100644
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


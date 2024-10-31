Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9F33F7;
	Thu, 31 Oct 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390342; cv=none; b=pQMWHIk1hlEy5v8v96Rnq3CX4LXjPpDjmFgj9/EI7M81Khd0udpahj7isc/XAx3ohdlr/PwruAdiPIkiF4pH7eqfR8Sfb756GZ2ctvU5oYJsgtBfFORvW8dY37p2ui78AM1PmSQ0nHLffhbvrVch5Di+NzDO7xlgx5HswDYpUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390342; c=relaxed/simple;
	bh=KVqtJ6+31/7LG0jubAcYGxBoG3ai1OLyPduzkmuaIoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iQ2xA0SW9aqe9nFhpRbuQPcFMP5dWfG8rRELN4C7rl9TUR4LQ+3qAcCX8594cS24EZnb0UUNEK1bmGeuMIT3yu1tKu/E5fdpXc69CowO31wj3W7i83EknLFYWfsYofoW/3dXYbz5+/K8U1KLu3F0RmD8NHFGyM4u0iHBumvvskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS3Batvj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS3Batvj"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so9203175e9.2;
        Thu, 31 Oct 2024 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730390338; x=1730995138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UgwNFtv7v+HTHeQa2LyIvaRpePXDUo69gSnUNfeHmCM=;
        b=TS3Batvjdkr9QSGLcJr7NqN+nM686G/mwVgH6vRn0gcpm9G97ooPxsYbxOI3MDePNC
         K1ANC0glmYeXGb97F0HFme7HHnyHprNSDd38hDZQV8HoqjuXXHn86mbwTsaCPQoMXT8r
         1jPIC/yltCK5kt1eCOdRQFJnkkyud6S0JQRZhS0ekgJZFFuqXXN7cPUWsv4sgHaFO7ns
         VbZGnWqT4Hs9f1XjJqE1ZxRGb1fi1NHcl5zBAoVqy95h7nNA+HpupsRqVUvvtyZIjQR/
         8ji6z0C8TZV0gGE+LAOk4wHs7E+ha3nEYYUcQCE5o7zbpzW9zm70Fw/c4IobOLtQN5Qc
         AI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730390338; x=1730995138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgwNFtv7v+HTHeQa2LyIvaRpePXDUo69gSnUNfeHmCM=;
        b=S7JJbBqjvAVQ+RyALq1NR9hxAtllIQtZwDZh5xFq9nln84qUewHwpuSZ2XmNfCg4jt
         En73yLpI84ehxKf2bGY0IFIrMSNIqm/hEvAO8hkGLeehrVM1e5+KpVR/pDBxOKisGFX3
         u93WkqwXFboSjwyUdz1pOMo/zJ/KM+iucM+T6Ok32F+XwBkYJSHQtR5mLSwrEDmMoODh
         VZ1I2vp4C33g52I3+AWgpRNR1Ix4uEyOVIExTq5S+c5+JxcKHlCwD2394O38nUgtl8Yk
         9XRB9HEd2mST31rLmBIyn7Q1jwIMHscrqsCqaebElIZbwNIjLdyK8sgJD4zVE9i/eh38
         Poeg==
X-Forwarded-Encrypted: i=1; AJvYcCUCHpuDY5sXzyh2t3XZmzrwAFy/4Tao5eImVSTuJIOdS38xmrkYkDJyXREQAdBMIwU0R8wBQY6vFgX2gZ6uShOnEG/NTeqZ@vger.kernel.org, AJvYcCVpSBN6NdwZtKR54f+6TNSHT+/xDdTQZ+hQroSkcJYmxV2nSfKWsHMi6DX7zxDxZMvS9lOYqAR9fopJ59c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwniNFOusgaiCEbwecj2lVKnwjDRHFA/ljEfWSI6So6IRCv7wSn
	HNFjEMMS8CfGTT1AsOnJUuODW2sx2VDG68KUmoYU7cbv+DsaxBOP
X-Google-Smtp-Source: AGHT+IGaxUg+BMAR7WuTyNDh1F0SjP7q7ZPR3WHVrYWH4Tl6rULWauDzozYmmm+H4JDnLkKSEFz18w==
X-Received: by 2002:adf:ea43:0:b0:37d:633a:b361 with SMTP id ffacd0b85a97d-38061206c0cmr15050819f8f.51.1730390338315;
        Thu, 31 Oct 2024 08:58:58 -0700 (PDT)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c08sm2532758f8f.17.2024.10.31.08.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:58:57 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Fan Wu <wufan@kernel.org>,
	Deven Bowers <deven.desai@linux.microsoft.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] scripts: ipe: polgen: remove redundant close and error exit path
Date: Thu, 31 Oct 2024 15:58:57 +0000
Message-Id: <20241031155857.3262806-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently if an fopen fails the error exit path is via code that
checks if fp is not null and closes the file, however, fp is null
so this check and close is redundant. Since the only use of the
err exit label is on the fopen check, remove it and replace the
code with a simple return of errno. Also remove variable rc since
it's no longer required.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 scripts/ipe/polgen/polgen.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/scripts/ipe/polgen/polgen.c b/scripts/ipe/polgen/polgen.c
index c6283b3ff006..01134cf895d0 100644
--- a/scripts/ipe/polgen/polgen.c
+++ b/scripts/ipe/polgen/polgen.c
@@ -61,15 +61,12 @@ static int policy_to_buffer(const char *pathname, char **buffer, size_t *size)
 
 static int write_boot_policy(const char *pathname, const char *buf, size_t size)
 {
-	int rc = 0;
 	FILE *fd;
 	size_t i;
 
 	fd = fopen(pathname, "w");
-	if (!fd) {
-		rc = errno;
-		goto err;
-	}
+	if (!fd)
+		return errno;
 
 	fprintf(fd, "/* This file is automatically generated.");
 	fprintf(fd, " Do not edit. */\n");
@@ -113,11 +110,6 @@ static int write_boot_policy(const char *pathname, const char *buf, size_t size)
 	fclose(fd);
 
 	return 0;
-
-err:
-	if (fd)
-		fclose(fd);
-	return rc;
 }
 
 int main(int argc, const char *const argv[])
-- 
2.39.5


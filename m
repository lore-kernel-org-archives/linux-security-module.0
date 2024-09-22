Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE7A23
	for <linux-security-module@vger.kernel.org>; Sun, 22 Sep 2024 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727013384; cv=none; b=N5DclIMxhFg/1heC0X5RHL4MvsOkKriMaB4DPqPEHQXWoZ2cts7BjhxSXRPMQFFFff+F9h5hLWojOKDayhl37XRX6+JP32GiiTs5nZW64IJpQCFIVng2kvlYcQtBtRUj79dQ0X5QvQeQISDDft9D6qXKeGk8Gs/B9+tTiDIeyeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727013384; c=relaxed/simple;
	bh=4SR7uj42fjD8PLsH4542xBRmf4KdFaI4WWmQRIunbf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fq/iAXIjfhrEQ/A5JwETU1XLy8V6I4vDQ8UcJ44S6wdhxl484J0bOPpp47R/37Qlu60PGcQLRFmT0JeAi+zSneN0PEG8ioFhiH45vCWnae7nW5BL189JpURS2ZO1cmqzILXfs0/KnSxwGwsduSX2qJyf4FlU9IHqV8uk0LtsEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY0LP66p; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY0LP66p"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-378e5d4a80eso2579042f8f.0
        for <linux-security-module@vger.kernel.org>; Sun, 22 Sep 2024 06:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727013381; x=1727618181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+z+A2ZURHd+AAEqbkBB569HDm5iBM1lTDVd1GI/OC/Q=;
        b=NY0LP66pVSDXnfV0gXMOCpmixxVHBcpe1o621ga+yrQ3ygzhm1u/ue/qVMLoEyb015
         QErfzHqBk8i2/bB16SN/KPKrZhNoSA1DiYy8yYoTW7hoo6CC0LyAsLQruh22Epo4t+x4
         80FL+y79JOKKFpGxiBxUv7Hg/5/QUHB8xYMRNRjQdjSlEBrRj4HB1Rq5KSYYXC5111Fj
         VTzuXqYMERYd3nYoaUI/KeNfUIeYidjgZBKqG5uLPl+RJWUSt5FX0q2hfJ6DsRjfG9/M
         bEWLZjEWQpHc2sY98wroOLInvtGCeUaqwmP0D4tdFURMDvfxy/VSVHHwHlRHkxTfigSV
         OBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727013381; x=1727618181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+z+A2ZURHd+AAEqbkBB569HDm5iBM1lTDVd1GI/OC/Q=;
        b=J9yLu3MVPVK2YHuWhHcxZl9B+R1H3AMqxYCVReaPR2xJ8R5l5ZOG0HdGk3C6f4CEZI
         ykjrLN1rVRyhcwM123tJ5q4Vhuo0HE5I9CecE+pDpoaRhSwoB9+58ondlnvpWHQYEXDh
         SBSIsDdbMEqJS1/MMHFzGKtZ9uMHBdxFFvMpdG94IoG6y2sn6nDSqpwn0icrT8sMH+ku
         mmhUR58/mYx0Bm7Ost92aQE/M3dfN3n8WGRUWKR+orWNqecrfrXKPfTjMQdbiZTpUvH6
         /cXfYiQdNwO27cZbUgM6p0itOUDvTCuw4MN7UDRV0GFeG3SNdKmccQUh0cvN7McxRi+G
         w+Iw==
X-Gm-Message-State: AOJu0YzECh+GyBoQ2fGcmK7JPP8le4seETdAAbqt0U7Jpv1o9qv5M7xZ
	md8nSK8H4ONeWI+UcXWfzlUGBeyaMzYVTUzXxduRIcbZdGcymdGglZbZfjnKJM4=
X-Google-Smtp-Source: AGHT+IFoK9uy+COKRB5eX91/3Ow0Mb7o4JzNId7V6cX8FrT2ucHDBnceHpj7uusZJka5wQsYBKr/8Q==
X-Received: by 2002:a05:6000:1b8a:b0:371:a8a3:f9a1 with SMTP id ffacd0b85a97d-37a42252ce9mr4335299f8f.11.1727013381128;
        Sun, 22 Sep 2024 06:56:21 -0700 (PDT)
Received: from localhost (ip-185-104-138-53.ptr.icomera.net. [185.104.138.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm22038763f8f.30.2024.09.22.06.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 06:56:20 -0700 (PDT)
From: luca.boccassi@gmail.com
To: linux-security-module@vger.kernel.org
Cc: wufan@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 1/2] ipe: return -ESTALE instead of -EINVAL on update when new  policy has a lower version
Date: Sun, 22 Sep 2024 15:56:13 +0200
Message-Id: <20240922135614.197694-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <bluca@debian.org>

When loading policies in userspace we want a recognizable error when an
update attempts to use an old policy, as that is an error that needs
to be treated differently from an invalid policy. Use -ESTALE as it is
clear enough for an update mechanism.

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
Found while adding policy loading to systemd, like we do for IMA/SELinux
https://github.com/systemd/systemd/pull/34418

 security/ipe/policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index 67a051620889..5de64441dfe7 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -116,7 +116,7 @@ int ipe_update_policy(struct inode *root, const char *text, size_t textlen,
 	}
 
 	if (ver_to_u64(old) > ver_to_u64(new)) {
-		rc = -EINVAL;
+		rc = -ESTALE;
 		goto err;
 	}
 
-- 
2.39.5


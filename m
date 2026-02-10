Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518AF264617
	for <linux-security-module@vger.kernel.org>; Tue, 10 Feb 2026 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744130; cv=none; b=CyP7VWzbtKOSbYAAVyfmLQKaHq5LTfp8k3aQLziDiA2AanxcADgp1TP8cjsHinLAVz3xtkgsX0fy3We12bdez+6UUWo5ZEAC/VVt5v1sDJ1ZovnN6IBlsruQrexMVYzkyH+GmwDg9yMwLcUlxqKLBZI1zCJzLPp/gNC1Fkp5PXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744130; c=relaxed/simple;
	bh=gWT4iOROf15CZJ5Sk6yDjnw+ATYS+WUDC3ZRm1W2sjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUVCBZ/Q/IzElWUZnFRZRu0spL79GShAADmM8OvfBtvXFWXmPSibUcNoEkz+RFC68SHp4kSAJ3FC578vrBVLrUE420yhYbzn+/LVOfRtHSI8feUVMESJkdzOIRvQrTb1IZwMLZLhfBXj40Pks/VsosmieQexMyirU7CTwzyDcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4DukseK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4DukseK"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee07570deso40126175e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Feb 2026 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770744128; x=1771348928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SmyYHYkCf6isXqHI8LRLyQfyBIoea8jRfojSGa+OYoI=;
        b=G4DukseKKQ6QqWqv8roY1RbtfXE7We4sVMR4l1nnQqrFchfj5U+v/Kg1ThvLdhZkVT
         zRpR0L5N78iBNl5+S9asKc0I4ixvU9jvjHw/CVOBZWT+2jdssLYMdSdF8JISoruKcC9H
         G507c+78sn6HXvxYl78pH6o5YWe6beS/PzxKMO8o0P5MoGcg3+wCCOA39q69AF8RPedG
         4QOUHmgpYWrLifnCjCAVG1qwUwykUjgIhJtQwnWlf3UtihmyK1gyjNBSSqgeaZQNTcY1
         rURk1bvQhcf3XV1RpTXAwgONhotsL6vHwkCvDjwzial08L3LGn5n/yn8E/e2TVndUa3j
         ja+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770744128; x=1771348928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmyYHYkCf6isXqHI8LRLyQfyBIoea8jRfojSGa+OYoI=;
        b=Rq7eCjUWsqAZ+UjWi+dW7D2ArcYP9PLSQXUPle7RBdETXaYn8dGSJebg4YNCokis8b
         4+kt+5d7GGPENzjNY66h15SQLpxOYfbe1FdPw/KS/F7YzUxyqVU1/MqznqvlaGDf7hgS
         oDUCStLGR5OnqfTGCTJwzHB+0ymC9ZmE4T/ELIpYE5f/xRX9NMjMKOrdyAjL/5eKZTSk
         rG5GU07+LMQnneGsjSjITs2SA9x2BKgWOZSyDum3ifElckKqaV7RweUBgjpz/9uBmxRa
         wMqwq5iS89QhG43JBN5iV1BE0slQRUPywzKXbmRFPAmANlFkkysPrIQJ1/uJaGytDI+5
         /KJg==
X-Forwarded-Encrypted: i=1; AJvYcCVXU14D3pvMaz1K2ZMFILGWMAf8JdoDEZQT7Q4w7Dt1XkaXJSTM3hS1vmi6L+0vUgpDqJQmmg4YhPllooC/vvDk7f7vCeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLl1laxDvlfLQZUt2rOwX0IHeeNH9dtxfb156opRGl/LtvO6cg
	v3HmbowYx8Z6DcLNjhwTgsYY1fiHra7FQheQJMzmPYRHNC8Gxz+RH/tO
X-Gm-Gg: AZuq6aJGLA0VE6zTB2oasxF4LjvYn/uLjrkDDP8My4VsSbfOEKgT/8IRiRKs+M28kxo
	fUvGDlBSZvjzMxeez0a/kr2gsis6X83nzEDNsbHSq8gUwzxuX9wLdRlTzH/vpWwljjSznPc56GH
	XbXQYWsomvHdlhWC11bcwSyS4AE9FyZGRZlU7Gn/hpPpY3aDcn47yU7P5obTk83LRW/f4T7lOKL
	j5U9wqsdqGDOcgoncGAjnM8NqPM4eZu9bA1maTu371sZHBxXpyIBek8VfuJYn+sTQlXAwImGW8q
	sDgs7NKBB+ccpDj6QAxcFA42Q8A3lvbWh6IZObWhwjA4hBEAn8RUElA3Omz8tfw3G3c+bIgPs/f
	qCz8kk+2Mw+Q6kfKbvOxEMu9I7JiuaF9555ITj8h/0UR/mNZHNI4JGkNrLCugNdVHmhYsma8M9G
	KSwFk2AuKlWGl2khiYOi45EYITb24F+YTigBh+zYo2XIlaJxx/oR142ERpPfpcNg==
X-Received: by 2002:a05:600c:8116:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-4832021c74cmr239650605e9.26.1770744127455;
        Tue, 10 Feb 2026 09:22:07 -0800 (PST)
Received: from geekom-a8 (net-93-66-82-32.cust.vodafonedsl.it. [93.66.82.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d480530sm118237175e9.0.2026.02.10.09.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 09:22:07 -0800 (PST)
From: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
To: john.johansen@canonical.com
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Subject: [apparmor][PATCH] apparmor: fix incorrect success return value in unpack_tag_headers()
Date: Tue, 10 Feb 2026 18:21:24 +0100
Message-ID: <20260210172159.535137-1-mpellizzer.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unpack_tag_headers() returns `true` (1) on success instead of 0.
Since it's caller unpack_tags() checks the return value with
`if (error)`, a non-zero success value is incorrectly treated as
a failure, causing tag header unpacking to always even if the data
is well-formed.

Change the success return in unpack_tag_headers() from `true` to 0.

Fixes: 3d28e2397af7 ("apparmor: add support loading per permission tagging")
Signed-off-by: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
---
 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index dc908e1f5a88..221208788025 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -825,7 +825,7 @@ static int unpack_tag_headers(struct aa_ext *e, struct aa_tags_struct *tags)
 	tags->hdrs.size = size;
 	tags->hdrs.table = hdrs;
 	AA_DEBUG(DEBUG_UNPACK, "headers %ld size %d", (long) hdrs, size);
-	return true;
+	return 0;
 
 fail:
 	kfree_sensitive(hdrs);
-- 
2.51.0


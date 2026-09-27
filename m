Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D671D5AD4
	for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 05:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790485974; cv=none; b=lPQFJWkyJrW97L3e0eBrbNWthy1bGGbIuQXg/qF3TEHk/RMYEomjmGfeY4PpqlO3TPcmEWGlSdKYstiZJzPXou5/YjOyjtn1IVht8L0uLLmdrw5qGC0KEjdt8lEFytLJr53uOqN0KFBW5tnH6EDl/zLXXl3ZTHvbiNJSV0ZLbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790485974; c=relaxed/simple;
	bh=whXlk0+in+lcejoQ9Fn7+DUyvKc/f6eSB0w39yUDlcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mNXBeayvcDFbXj/SfViNHbh/vIyMFEef3/gbecJVf/3VNJZS/WCPqBWux2Pz//lktu+Vta8ljR71Y+lFU/U1o2DtZEnCXRGUqJ7HJXA2L7f5s/nhPlch8UYn9/XKgvv+gTpXUvDQFBrBE/OBjl6sZvVzU1u0Vgrd9p4XF/6P63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmBGaHSN; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmBGaHSN"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34346932d93so551948eec.3
        for <linux-security-module@vger.kernel.org>; Sat, 26 Sep 2026 22:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790485973; x=1791090773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n8xWzQ3Nt5TXjgmtMPJDxkLRF89bNISk2+LW4IfX7bM=;
        b=ZmBGaHSNQlRz+BFqEsqj14Vec9LBPUuQOIlOWc9FTdX/RywbgUesBRKugUF7hu57SI
         /rJ2gBvn8/CWp4kNNChGmCnpr0MIRsG5zKMT68crZ8239E4FlgEj2/G9PjhGIVUYnLQK
         eqZf0EDtYZ9IWWXWVnBGynVVRxJriF/1E89CrR1ubSVk3h+24iR2trcIU295ygxSBcbd
         JhzvlAKarZGG6XAfciKthXbw1hP0VUt25AWZ9JaYFFtEriazLKDYzO7YonOEdOppvvGv
         x099LEn5VByxHAw50MO6LNv3tOjhAQVNQgss9eqP50L3A4xUFE/7dOFFUcXo7JE08D4I
         Q+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790485973; x=1791090773;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n8xWzQ3Nt5TXjgmtMPJDxkLRF89bNISk2+LW4IfX7bM=;
        b=GoblqgOTwOhmtRCAFewI4CjLyClJz3nKU0GnZkCBy0XhaOAGr/+HnNrcYWHOBLQxxv
         X2KcsYMVyWeMYHzdXHk/KQsMSX1v7xQJw50B/Gm3/ycP8OYLlfrq2ou01wEma9tYaUf2
         hw1nJ0UX5o3J8YsDwx6KfoFyPEto/Rkv8GM1d8/1VM6ig9EsAqgiJ0siCY7mxhH7Egjx
         PHQmAy7m7CPbdkIan+CQnuqrvFIyTI/8Ty2e41HZyKgFuoXFr0C/N4QW11s4cHU8Nbyc
         ZmPn1x4XcIUiYBiuJgQwYYkJr/YQyO0tesZxyE176755++mOF+a25asQWmwvs0OhmlU6
         zm6A==
X-Forwarded-Encrypted: i=1; AKwUvByfB4vKQsK333Wvi2qUSXAvt3ldd9mEg8lhsfhV0a8VpUA/Ot88kIBwd85SZG4GYA0Y5LoJoZpXIvFznSLNDzvQBuI2x7Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nrt64j4NwJ4qMw6WtW2cNAPPjYav3+lx6UupdpbVbIDEHUBwvc
	WLORWzSdzQZNMosMmHIo7gDsjWjZN35XwiN/aRFk64RXhAfmfKm6stSX
X-Gm-Gg: AYBFou0d9KQyXuD2cKkVgMLoK8IYh28oEzBRNuSDrGnPFa6DrgMCcZGpc220vZ7yz1n
	Tuz9wRBJbacKUqa9MooXVdDoOFlExeSKvCkgZFEiGREOkpG4jFWjNgQL+AJClzvN0Ex19FKPzJd
	Cx/Sn/RCqKyR0r2pZIA3Fs7aVBG2dlFi+3oL3xqrEeq2ECkSxFtRgKu+1GxWQkdCgEHzxEp8PmG
	qQbaDrf77+DkaPN+KBsejtWEjbmnBP0W+ZHRP7jVAUejG/ebQMKqmKP/s8UEN3HkHfa6UOcg5w2
	6kvkAlhtoWiQS4VI5+w6q8WlhOhZ/gTP1sG4XfVb0b3roznKoq/S1nSvpeVLErImUcBv4J/VAOV
	Dfg5fT5wajVJWAA74OTAD/wiYvQbBV2C1M0PGrtBpneLIC8IUbnzUyACp5ztqG8kDCvRJ8ud93S
	ZXLDeM2dpr9XFyvwfDYQwxgSpSAW81J3Pt/8gUzZEBO3vFAJFFgivj9BaMuBw5E5RWpU+0QWZhM
	Q+DvI86DOUJcfmJsA2zaMR80h0MWB8/CIxnSx+felTT66jpGBFWXIphXac3x8OhTQkkYo+FBHLe
	X8mKPs/ypFUqamA+QfKML2A+uPeT2CDCLSPrHT+WhftqUJtGn7PODGfv5IQ=
X-Received: by 2002:a05:7300:5613:b0:341:7dd8:1a6a with SMTP id 5a478bee46e88-3427304a34amr5603965eec.36.1790485972480;
        Sat, 26 Sep 2026 22:12:52 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414504fae2sm19519389eec.20.2026.09.26.22.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 22:12:52 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] MAINTAINERS: name the mic/linux next branch
Date: Sun, 27 Sep 2026 13:12:49 +0800
Message-ID: <20260927051249.2751431-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The T: entry for LANDLOCK SECURITY MODULE names mic/linux without a
branch.  The repository's HEAD points to branch master, which mainline
already contains.  linux-next merges the next branch of this repository
(Next/Trees).  Name that branch in the entry.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
This is part of a cleanup of all T: entries whose repository HEAD is
not where development happens: one patch per repository, sent in small
batches.  The plan is at [1], and why it goes out in batches at [2].

[1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergens@gmail.com/
[2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goergens@gmail.com/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 140eafcbbd78..a91b79563304 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14708,7 +14708,7 @@ R:	Günther Noack <gnoack@google.com>
 L:	linux-security-module@vger.kernel.org
 S:	Supported
 W:	https://landlock.io
-T:	git https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git next
 F:	Documentation/admin-guide/LSM/landlock.rst
 F:	Documentation/security/landlock.rst
 F:	Documentation/trace/events-landlock.rst

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.55.0


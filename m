Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0A72D7398
	for <linux-security-module@vger.kernel.org>; Sat, 26 Sep 2026 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790401948; cv=none; b=ZoXHzozR692pQxXORuq0WEDwNQ6AF2na6SzvylCVKnukpu97+TmVBtfgVi+KC4w1ADagzuENXRtFmcbkv0/9i867McI9Pv0HIhR3C2Pg5eVIa+Kr3asYtyq/+ON8fm6nPoXTlWhqgaCqo2ybMTx+Nk36A80LKeooOtWBEaHC66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790401948; c=relaxed/simple;
	bh=N7CZKrLWfUHHeImC6VymCYZP1eJmuFrtkrq7oDcWLx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9Zs6lOpQT6vc3g1Qu4DS7ao6AmJypM7IW6LS2Pp2+4ksbKJP7mDJBu1rZJHcxOCOFuQJNXq41BL61KFW1b/zyCBGvXG3VXqeRhTzY5IVycgzd2ylOn3AuwNxnHdDj41cKCgJHCIKjnnu/usI3JaxChsLcCvjIynZgpL3JR5Ug8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCPhCIWq; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCPhCIWq"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca069c8so7183935ad.3
        for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 22:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790401947; x=1791006747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/QvJN+bX36r4/LFLkgmm6ibfqhhY8yGzHXOxH+BomuE=;
        b=UCPhCIWqOFuFzlxoCTJobXm0Y9tCK5ZgpTrAJ9WLFva6ivwkL5KPkuYnUNkTbMhJQ/
         c+v9qNeVLYFxo0IfdwQLgW9KLYgWD2ZkxWGiIrs5ah+DV4e7KOSIjUKVwIsKeXJwWwtc
         KxRbx0Yf6MM34GiJwdGyOgyoJNdrnK56W6g05aWDQ2sW1oQsS3p6SUoFwnhUbt35ixvb
         +auF3+cZDe4dZ6cf4ucwCvzPuqHB4I9k8ejYzN3c8HI80N6jyhZjvECjdtG00oDApH0m
         HR3zw6z6YRr3lbVkIYMynfNNd3XFCg86h0qGO5p9LAwY9LkAbdLVvhiZSjiZ74MRGNwQ
         mTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790401947; x=1791006747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/QvJN+bX36r4/LFLkgmm6ibfqhhY8yGzHXOxH+BomuE=;
        b=S/UBxNNzdf8PYWRLMp9CtBNxq2H5m9s7QZ1onwmLZQ2g1KYnraWHb/g/tzg6DoZ5uf
         scY0Vi+Y+14qOv0l1K4gQndv/mD+MxUfUBt8sRpXcGgP5DsiVS0IwhTU8FrnK0JKGWrC
         p+e5g1NV1JvfrA7pqTBPD4PMR/6vdxk0zWvIDREK0Btxnl+/9nMSuPiKiVXUiKzb2yUs
         PwBp97UqCZVuMpRNH5Zru0JvNRvgWVmH8MvkBm44OkqkcoRnHMvamxsINbs2navbY9e3
         wQpNOdQCHBfneVHvp2EBMQzp8JTxfupSrM+q2bJvZ6SeLq1R1GwsVLo85omZ14S98qDR
         fyNw==
X-Gm-Message-State: AFuF++ld8/SfCs16hMD260IbF9Vcx+tTqzf1n58iuy1XbKFvZLfEwq8T
	p1oN1yAm+NxZll2E3p/E0j15U3zxDWkUHeVO7SHuEP8Y7o5PqRoVuHJMebnLClJY9+e0OdW7
X-Gm-Gg: AYBFou0zrc2ngYLYEPhNpMJy8Dm2xMoM3684j8PTjGbkW4YBOhuvRNbpTuGdlN7P9QX
	JunuY36y+O4urkuJUs5nClAUfQctC+ZAor2dcdpyBUiJwPD8tDYOxL6I1ZuYn8XjKBd1Nn1Jj/h
	FUdGQYtcW2Bn62BB8Jbi7cFyESIYUU0uGH31WRGniWwCZE/piKaZRW+7wY8jxQAfZctX1oqtYWf
	10/pxYE/hpi9pKft0iqDdd3DOYmVV6m8BklV7snYUGqc3sGPy3yAy4hhqWBCe1EwS4tvC675JuQ
	xyhpl96G7v4PdFWzN0dkJfFVPyKxWvrlEu5OIOa2+GhCNalNUdD6Dy8XuW2nSzLLoto0pJbvvq8
	SglsbNhD6bMqateRsLKqWdSg5zDYoiJlDxXjd+QibnPP5Me9oYLChcddkbeOvhX3W7aPC8RxVfY
	GjChxxRRqYiLKzqMvYzE1kFXKNQItcqWarb8mM37knMyt2IJFCcdEsw7ydGy/NuuG45njv/xOk5
	97SEqa0CySzF//uvMBMrHyMbU7AXn1b+EMIC9OTBXili4An3VU7lWhZ8Pk6p5GavlrNL6jef6g1
	N2QqpCt9t6Cf8quuR1OjQp/4XeTsoZOI8ZArvoDYqs7v+kojlAyDrv8oKgR8iu3TkP4+Lg==
X-Received: by 2002:a17:90b:4a89:b0:39e:6c69:34da with SMTP id 98e67ed59e1d1-3a098fc84eamr6336506a91.62.1790401946810;
        Fri, 25 Sep 2026 22:52:26 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e151be04sm1662000a91.9.2026.09.25.22.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 22:52:26 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Fan Wu <wufan@kernel.org>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH] MAINTAINERS: name the wufan/ipe next branch
Date: Sat, 26 Sep 2026 13:52:23 +0800
Message-ID: <20260926055223.3678216-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T: entry for INTEGRITY POLICY ENFORCEMENT (IPE) names wufan/ipe
without a branch.  The repository's HEAD points to branch master, which
mainline already contains.  linux-next merges the next branch of this
repository (Next/Trees).  Name that branch in the entry.

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
index 140eafcbbd78..fc42b68e0718 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12960,7 +12960,7 @@ INTEGRITY POLICY ENFORCEMENT (IPE)
 M:	Fan Wu <wufan@kernel.org>
 L:	linux-security-module@vger.kernel.org
 S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git next
 F:	Documentation/admin-guide/LSM/ipe.rst
 F:	Documentation/security/ipe.rst
 F:	scripts/ipe/

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.55.0


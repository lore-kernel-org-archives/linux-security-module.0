Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F8442B11
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909436; cv=none; b=mUOmQsncvNMFJ25M+FZWiQX4xLIPGocvLRqLZbhnuvcBSc3XP+Q9t3PfMFdl9bFIsoYfTweg0Yn6o0qo5wHTGZIrURWa4JlNRZFi4eKDc2ypB0T6jGREsjEzSjHw4+3T6E7dE1aUXgRqFagxVLo8wobNPnzZOGU59EyYnq24W9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909436; c=relaxed/simple;
	bh=nWG0PfFa1CSrj0WyElTCxGuxFcX2iyBKD+urYs9kcro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YDwFn1GCew1WRKD5hxq8bBUxNKtnvXXkWGJWfWLHpN3tg3eU7tzuRN7Tt4AR43ykMX2GKIsFzGrj89HU34A/ie8DaLplDGbsGTOFwB0VCN6+IhtcuODvKINWwy7U8Jn9oCg9FhY6poLVZoH1ortNWdmygOsPLHUaaKhHJKACKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JJzbz24W; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJzbz24W"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso6435925e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 09:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784909430; x=1785514230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ao48qHv0z4axAmJTdaCTz++3+jlKkXGzU6bx5YED0D4=;
        b=JJzbz24Wjt6tGDjjnl25qXnLEk2SqSgzSM6cBl/XNVGhxtQiLcA5SPAccWsJ560Jqs
         8nFLJernP9GKXAx5MQ0x3E00UIGYCGBxnyt38rBxAekEsJdEr/w9PzIwP6qQj1wpB0q0
         vzaa1LL7Q5OoOTXP9U2kLJYxSEhXqmKD7MctGah7Dhl6Q/XrkEsrC3WohSq6VlIxu+pI
         /7AvoaRjjqoH71bCOWaFI4NG4vPoWBidC5mrAK37+6mKDrCtHmV5NiO5Ut6erPTZCNlM
         56vsL0uUqi79in3u1PqgMh95TiqjLsEBrSNhkFJ56P6MZwv5dGTLbCuSPwbMULy8IiKP
         Fc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909430; x=1785514230;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ao48qHv0z4axAmJTdaCTz++3+jlKkXGzU6bx5YED0D4=;
        b=lLub0jhhMYu3KpORE1eEkzWDVE2qHKH2Fq46tRnItO7FB8XvAq7YoDiCXznPoRtLKy
         d2iATAfxkxJGUZvLGGYQdm7Or+Wt06FNkPGImKepeNABMDDwEr1rH5jHe0M5icvcE276
         7tthX3n7PTr79cqG3mGS3E+fFX8AP5eHvc1lQvHtQt8/klrRVlafHpUAUQRlBv2EBdP4
         6iVlHPZ/YfxMjaZBwzlG8j/2YOkwi+qflZSNcIVq78aCZdrKH7lIxPLpsvjEiBk1ziWh
         t1PvhmveOwdtc0htGC0EK/HP9b+/rJOxilETNleBQ+8xVuSoeYOpuMdBaPfmJt9N6gdL
         5b9w==
X-Gm-Message-State: AOJu0YwlV2RsTWGuvgzoyifHOcFIsGwRHxaoQjqzzHB1uI5jEDVRl/TM
	hV53gKUcLFtN687cwC32kzSnhPI1X+yZFeN78ahgJGLiomkckNgG+ATyRfrblB8q5m+9Nkx2r4U
	H/KyGRw==
X-Received: from wrzd9.prod.google.com ([2002:a5d:6dc9:0:b0:47f:5277:39a9])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c4ab:b0:493:cd3f:d051
 with SMTP id 5b1f17b1804b1-495f573bbf1mr21413815e9.25.1784909429476; Fri, 24
 Jul 2026 09:10:29 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:10:04 +0200
In-Reply-To: <20260724161004.2360749-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724161004.2360749-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724161004.2360749-6-gnoack@google.com>
Subject: [PATCH v4 5/5] landlock: Link the erratum documentation for whiteout objects
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The documentation embeds the canonical erratum documentation from the
header file, which is already a self-contained description of the issue.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index 5a63d4476c1c..df996ccaee34 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -556,6 +556,9 @@ in the running kernel.
 .. kernel-doc:: security/landlock/errata/abi-1.h
     :doc: erratum_3
=20
+.. kernel-doc:: security/landlock/errata/abi-1.h
+    :doc: erratum_4
+
 How to check for errata
 ~~~~~~~~~~~~~~~~~~~~~~~
=20
--=20
2.55.0.229.g6434b31f56-goog


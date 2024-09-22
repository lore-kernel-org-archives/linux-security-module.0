Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19523C9
	for <linux-security-module@vger.kernel.org>; Sun, 22 Sep 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727013392; cv=none; b=NNv6jZhL3cyo5ClDcHvLztwrQFOJsWmlQUHfbnqt7OLQsu88W2DQHBjOR6hJfe8FsmjfCd2b7ucr0a66kVFDWSGgo1rb9/weIZZDi1arArr7voLV9bGoBeGLLASST6oPNWZhAuB/mifXFriXAm0ziOMBgdcotTQWx/ig9qHA8f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727013392; c=relaxed/simple;
	bh=2yyhQgJ9Do0MpdzkXrFktowH5w32l2jYf+d9fAQXOuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ULKdCGUdlseA9GtQte29nD5Q2Pzmg7WU4vUI4cEqZ3RDZG957lirg0wn3jTJW0vMnF3NfcTk1tDtSlxLMOgGuamv4u4jHitlTbaYawrAYgyjrQj9LMzWiGlnI7ffHsjVbiJjU+u7jDgR3OgAtxmN8Jk94re5YAOnKn5/x9+VZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOFnMs6X; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOFnMs6X"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37747c1d928so1709334f8f.1
        for <linux-security-module@vger.kernel.org>; Sun, 22 Sep 2024 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727013389; x=1727618189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46N1Njx21K5ZBQE0i8oAQsibS2S0L3D2/6mfQnrVzFc=;
        b=mOFnMs6XRNGkRFLwcp+0ojM8RdKPyW5awU8eIegXvU2A3l5PuNtZsTrKO/rDXNolM6
         rN6juhqwqXzBTr9/VQZ4kZscKN4RfKlvgkYROpEkP1tRwPTPJ3g/6QEsZ2iz3CLblecS
         X0LeHzNDC3Yke9OnsCZs1UORaRC34SFW05HxISJFGMwBFHSZej1YNLThcAExS3LhsNia
         qCiV28md1Tkc9WZLJSNtTvvyYWQ6VMrvcie2Xl8AStCfjDlM9veGUufG4U3T3qmKkdiI
         Jsezffe4SHrpX0MporM5FOfffuGwJNyXforupQXtE8Ao1NZnVcKzjIfqyGNGsYqDi4dv
         fdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727013389; x=1727618189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46N1Njx21K5ZBQE0i8oAQsibS2S0L3D2/6mfQnrVzFc=;
        b=FYMZT4FLRdsuLXsbe9DNdpY1TfKf1yDc6l8OgQRaV/jIrUUsKLs0JHBVOEQzMzXyFV
         q1n+0VTlvI1B5PMk1Isg+3XwX9zO6lT+AjHEKEVr2vkEqbQNHrgMxCad+JKV7ZeHaeTo
         kUI6XIN3jzwlrMdel6PbaSAWa1o+sbiSamQ04s30gT2Jd+BZ7lNGz3HlIT4BpVRIvbiU
         zEHuxUQp1voCUX3X1ZY6hR/yHOIxs2/H2rhg12DpJhgHcK9DWQJLBc/eGnrfNaOgMJWH
         u/ec6SVScSzMaPR7zmIkAFmLJvHKZErjJTW4Ie093zac0j5su2y7GXxX2hTR8CWb5+xD
         63UA==
X-Gm-Message-State: AOJu0YzX0P43wFcZKHGFTu0ylzcqgjuY7OLxhF7GCLtd7RHc3rBMkcN2
	P4YDIDiiJlEjxhMEXzoUGsVAugkgANKZitPL0pQ8jKfzajeDBZDq0yreOfk2NrM=
X-Google-Smtp-Source: AGHT+IHi0mFW/uZHyTUbgrLZZ6GO6RvwmgmR75ufMiVGMTTcDl3eYqoadeqHeJgOvepLnO2T9t2o2w==
X-Received: by 2002:a5d:6646:0:b0:378:89d8:8242 with SMTP id ffacd0b85a97d-37a422bf176mr5038187f8f.26.1727013388467;
        Sun, 22 Sep 2024 06:56:28 -0700 (PDT)
Received: from localhost (ip-185-104-138-53.ptr.icomera.net. [185.104.138.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f649dsm22150221f8f.53.2024.09.22.06.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 06:56:27 -0700 (PDT)
From: luca.boccassi@gmail.com
To: linux-security-module@vger.kernel.org
Cc: wufan@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 2/2] ipe: also reject policy updates with the same version
Date: Sun, 22 Sep 2024 15:56:14 +0200
Message-Id: <20240922135614.197694-2-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240922135614.197694-1-luca.boccassi@gmail.com>
References: <20240922135614.197694-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <bluca@debian.org>

Currently IPE accepts an update that has the same version as the policy
being updated, but it doesn't make it a no-op nor it checks that the
old and new policyes are the same. So it is possible to change the
content of a policy, without changing its version. This is very
confusing from userspace when managing policies.
Instead change the update logic to reject updates that have the same
version with ESTALE, as that is much clearer and intuitive behaviour.

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
 security/ipe/policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index 5de64441dfe7..01da3a377e7f 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -115,7 +115,7 @@ int ipe_update_policy(struct inode *root, const char *text, size_t textlen,
 		goto err;
 	}
 
-	if (ver_to_u64(old) > ver_to_u64(new)) {
+	if (ver_to_u64(old) >= ver_to_u64(new)) {
 		rc = -ESTALE;
 		goto err;
 	}
-- 
2.39.5


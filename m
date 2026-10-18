Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D09A3DDDBE
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344749; cv=none; b=Tv/DyOQm5ZIAmhipU3ipNmUgsnfJ/TivqztuWPo6dq2btibLK1Q/F5rwifqGcHfVQlrYw8xkygscvSlGo9jmu5nDDOCL9zKHDAhm6LT239J+dmxvqLb9s5e5fX1TQjtsjvTfZBYvvmQgaK+GD4VaMt4PykVQKqPcEhW4OvqRGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344749; c=relaxed/simple;
	bh=DDf+hsKD+njkHbTRX0z2pNAboCvX+xbQD7r7N1v3wsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9WrV+V+G3i9ulHCKp1CIU6WDoIb11DbRwEcs/CiIfAsn9s/wmZuZY+znslbE+0hDyU2PY0dT3NN5//cwgt4izF206wbUltAku4JfMFwxnnQdaYOU21jq1+niy7/K4CP6VSsMR9vI/gU/9A0EqyzXve1NV8hFUjKfxwOVFlwkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=RooJSzQX; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="RooJSzQX"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91b9e758c50so23564126d6.1
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344745; x=1792949545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MIT6/NixQImXlRC4TWm710R6s6U78F1MT6/A/k5CzXU=;
        b=RooJSzQXWMziB5UeuxNcSxvgB8AqkuqS97YMT+3gC6tKR2/lnnrKC0MJG43cg6EY83
         jNHIibj/ps+0AcFluE7cwWiuMNfF+YBH9agj/xdeP8scinSjHLsdklcOlyUbJcklfEi3
         w4Of7Fpy8ktKVLbdg6VPNfvqqJda4ryqxe0EvHkrTOsV8a4i9exZEalCOUbeEBiVHA48
         sdRAe1kedyx7j/jqmWeQ1Y9JhvCyOCwzVNAQGbG6h//oD93SDtENl110osc8Xlcny759
         cW0zlM/0WJH8039f52jvy6+LgWdfnIRcZ/QPaSg8CPld6/ZIG1H+aQE2gOxZsCHgKDwB
         hCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344745; x=1792949545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MIT6/NixQImXlRC4TWm710R6s6U78F1MT6/A/k5CzXU=;
        b=R13bmyGVM2Q0m9DS9Gjc4SfzrUHc1+PnLugM0tBUMPrEv/0CHQE8zzE5EvOrUvzJAG
         U92ix/c2YNvwfY82P7ti7zR9WmYeNVHMNWj46aXzmwRYhWVHf5+xMGTrgpSOaiKMRO7Z
         pJDggTkzMylqwSK0CxzlbObTtOULqzTQWdAMX0OyPR2TEh749DRFOSu40aRh7G7IXjcR
         kgvT3HxGs4ZhsL574z/sEMpbfzSheqRPPy8PYQyz+EbRlivtc3fmTiRF2xer907HxvEo
         3NBH+PhLwWRspTi5IDVVGX0Mq7aqQd7xn78PbOX3sN0bigT6LU2j0Cacm6KPg718ec73
         3P0g==
X-Forwarded-Encrypted: i=1; AKwUvBxgFSuarwN6+MDDOOG8WCA/t+C2y3U7hGJYKZ34zXhDibs4uaZZiB/gDH2G7JRvUQcF9ZmevTtfQcztDliHo1ncgP0de/I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYcXUIloICfIiWe/v+UBcuGrFR97gPvlHek7iRvsiO34fXtVTa
	ZILT9AsSy9S0VDMRm7CIqAaNF1q1JWmrZf+NKuhqWyUozuvFNI6J96tnF6blIbjw0xUAyDAXoIN
	J2p/7
X-Gm-Gg: AYBFou2diNCM8sffXztE+Dqf8CAHc6TGSwF11Y5JTewRwoOk38rpROrvnsZWlh7//s4
	c8O3/fUidalDPOpgNXIsZpYl0UzCOn6lGQHki3BxVtGLsWc/EdgdWxewKls3rwbmS7KYKTL5ctV
	Tjb/rxzZA+ExQFNuncJJiP9pJ1/1ZExijDmXHoI8rfnxRFoAM32o2skn+YoQvw0p+sk5jJzXWtn
	674xs72jF+I88qvrWm/Rv21i37YvHvsMnpNDYHiYivgnUkQfrqRNFDVF75+Y9ahJ2UQYB013puF
	6/YKZyTHQzNsyCeLJhvs0bDjYCapMDkyOrV27N1lwvEve0VyUMaseOr/ce3yJzU4eDz4mg7wjac
	RtQHwitY02EVnZpTAd7UIg7xcyeA4lZxw3EPXTHNMm6jbWcRTBW9cG1zKIDIyUV/5ysIqKZOWu1
	sWYYNMxdvqWdGUoDTMO+Hu0CVpn9B0dbYnrdLLiCNdDxNmNXA6xYqukUVBQxB7jgRh5B9MOE8Hk
	eckG+0jFNY68W4=
X-Received: by 2002:a05:6214:4488:b0:91b:8c61:6e9c with SMTP id 6a1803df08f44-91bc91a0620mr137773836d6.4.1792344745282;
        Sun, 18 Oct 2026 10:32:25 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbb5c985sm76919046d6.38.2026.10.18.10.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:24 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:55 +0000
Subject: [PATCH 13/13] keys: use cred_ids_allow_control()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-13-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344715; l=1062;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=DDf+hsKD+njkHbTRX0z2pNAboCvX+xbQD7r7N1v3wsw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEbulJ9N31iyUAPdo+ORU8Pby+Nj2eZrjvPJsp5DUHSYsGpNrWt4MQGwNMuGQwHcBTuz3Sbrk0h
 D9nQdRqBYFQs=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

KEYCTL_SESSION_TO_PARENT wants the effective uid and gid of the caller to
be all three of the uids and gids of its parent. Use the library.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/keys/keyctl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d14ace88e529..c69448ddb743 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1691,12 +1691,7 @@ long keyctl_session_to_parent(void)
 
 	/* the parent must have the same effective ownership and mustn't be
 	 * SUID/SGID */
-	if (!uid_eq(pcred->uid,	 mycred->euid) ||
-	    !uid_eq(pcred->euid, mycred->euid) ||
-	    !uid_eq(pcred->suid, mycred->euid) ||
-	    !gid_eq(pcred->gid,	 mycred->egid) ||
-	    !gid_eq(pcred->egid, mycred->egid) ||
-	    !gid_eq(pcred->sgid, mycred->egid))
+	if (!cred_ids_allow_control(mycred, CRED_IDS_EFFECTIVE, pcred))
 		goto unlock;
 
 	/* the keyrings must have the same UID */

-- 
2.55.0


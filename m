Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E247A867
	for <linux-security-module@vger.kernel.org>; Fri,  4 Sep 2026 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520158; cv=none; b=BClFVn+2uogAWnlGu7fLv8nnqPdRGCpbd+DjeXruMpkkfwHdfRAYlBed5rGlraroIutXv0C6M47tr5gtMn7P+Z3Njz3ar7BxHEZyGCUvWaWmqoqTurF2BbEYG1B+gBOIvV72zHXgdUYONq/2pY97taPErXnykNaWfFmzpss9aJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520158; c=relaxed/simple;
	bh=YaGljnvWoQzIcgOagfuWcy7uipn7G4q/7MezpQpALh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WM2xJVff3IgOTDz4zgqn2Z45XXcmYts7+6mA92gVSIQhk8k2H4/c5fiinItJnaA4bfi5UegF5TK0t/3Nyf6H+EIUBDz1RQLfBbmhnIwglCs8DQYGNHMo4AaVizEH97KEDMfC300QpqTll5srb/2/IlynG+4eTA6DLe7zm16PtiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcbtlRDy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcbtlRDy"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4858c1c4b4eso262964f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 04 Sep 2026 04:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520154; x=1789124954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7gzrdcRbZFNkipzgWidgs+ChixBs5c4oi8w4Ru76NQ=;
        b=FcbtlRDyNfZpE9lJGApjudRRXyrPEQhedXkV3j77Kodp2mdyfge1KZV5G2iLu7C8Yo
         NEgIYMlUolfPH0gpdtRHRh45HG2BcUV2BgItNo3GTD3ipV/R5cxhtNDoaKOANahy2kSB
         uft+4KSVQ3V+3zlDXgPINn33o9cKV5SfE12eCWL87D7I0pcqJB9lFVFewSQkU2XtSMzB
         YAM/mWkkPCYFvtVh1w5BBXTxkJoBlB5MvbF4lj0e7upovVFgTWXdISeLn2u4uPFYHKiq
         rXMxRoFH1gg0KQpHUZphCKmOmJVlslTV9iWRBz8UxI9cA4vKScxAHnUsNc+yrXCxdkUw
         i00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520154; x=1789124954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a7gzrdcRbZFNkipzgWidgs+ChixBs5c4oi8w4Ru76NQ=;
        b=QA2zgQ6AKf37tXUyNXMQw8AkOL/4Hln70FA4zSNW87oaZMNKu669g5lKWN7Yf/IMTo
         rZKzRIbJQzEeMIkxiemb7Luw6p41gzSwXCAN7ubJ82+KntM/py9dj3MwakgPYWri8eKa
         t+wFN+2ZnqRqPUXR9FOB/QxxfSidCM00b9aizVKVXKN/A3VY94peNBsKwTnKqWs/Dgdy
         UFAPUGoCRVNe0D/37kLINVJ2bV5ONxrXsZlxpW51KUGeOzPyqxkdeVqPsn5QV9nkCKaa
         GH9PGlShz0B2wcYzuf/CY84LxcIcSfR4gyEcGIb/LO9QAZqmxqzeLF7A8qsgbooKuzDF
         h6lQ==
X-Forwarded-Encrypted: i=1; AKwUvBzC8hm0vs6z/ISwyGy5xfSMKpd8elU1tvZZ5LJxxkRH/kMKjIveO/cybt3S2ZLYWUWdYg5EQF/G2mt6o0pnSsWDTwm7q2o=@vger.kernel.org
X-Gm-Message-State: AFuF++lsRpaT0081a/Up7NEjgWlMWkq4DIhaxRdgYLXM6tGqrJmj3zaq
	3sAeS0t8amVPLlxR84gU+ZyoDE7lfTSW8/2EngUhDFp2U5n9inLGC/2a
X-Gm-Gg: AYBFou3cUBd/dPcw8P/mxxWMOlZ56EdMzvOZ5hCzHTPb3do4lKDCHUbw9L1Hd16NBdF
	De/1ZBd2oBMYIilAW5BrUXEnVNLrk1PMpcuQ5MRnNwE5ACeH0aa1RaMRF+4xs9aqvTVKJsLiJZ1
	XS5t3Ym8Fu+YrJtPv5im8z9lzviYU9RqiLQuzP/8RafEFaRQzM8ImVnTu1M1phwHkxle0jixeqY
	qkKcFGkffWeABcz3n9Qzh7lf7jgjr9ReD5GeLSFpiOEdYjEuSaQvgvbY4mJt5FP0b5LOTgGKctE
	cHPjjHQRhv3fDqYxdqJotA3eg9SERehbb46A9Od953QJsmbTI4rcfRyTlsU65mebOAh0ddjfEWM
	jx9/HPTS+pRAnXCxqX+SKzxQo3DnJ4a23/3QvZGn4bkilyYXpYk28BoLBtBvePJBMuhztipkwtj
	BZdyDWqpd52M+OcW5Y8Vc68Wr8W7oVibMxxgoQoWELpXppA0FLmbMqrl5yja1wkPrn9f4YXkoSZ
	xYamJBTIqzltbqQ00nO6SMbLmNL145DTPXdayUEYmL5umEyCYpB
X-Received: by 2002:a5d:5c82:0:b0:485:8a46:b3b5 with SMTP id ffacd0b85a97d-4858a46b479mr3503706f8f.29.1788520154340;
        Fri, 04 Sep 2026 04:09:14 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm5426934f8f.21.2026.09.04.04.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:09:13 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: eric.snowberg@oracle.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v2] ima: allow users to specify the pcr index with IMA_MEASURE_PCR_IDX
Date: Fri,  4 Sep 2026 12:09:11 +0100
Message-ID: <20260904110911.4087260-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMA_MEASURE_PCR_IDX option is currently not visible in the kconfig
frontend, so it always uses its default, 10. This means that the
'range 8 14' is dead code, and users are unable to specify the pcr index
value.

In a previous discussion, Mimi explained that users should be able to use
this config option to specify the pcr index. [1]

Let's add a prompt for users to specify the pcr index, when EXPERT is
enabled.

This dead range was found by kconfirm, a static analysis tool for Kconfig.

Link: https://lore.kernel.org/all/1feff118-4afa-4b9c-86f1-271a7a88208f@gmail.com/T/#mc4efa2491b4937eb7c9e532c29ffba516a70e662 [1]
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
Changes since v1:
- updated help text to recommend using the default of 10

v1:
https://lore.kernel.org/all/20260824162215.1572367-1-julianbraha@gmail.com/
---
 security/integrity/ima/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index b3a9f86809b0..72654cf797cd 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -46,12 +46,16 @@ config IMA_KEXEC
 
 config IMA_MEASURE_PCR_IDX
 	int
+	prompt "PCR Index for Aggregate" if EXPERT
 	range 8 14
 	default 10
 	help
 	  IMA_MEASURE_PCR_IDX determines the TPM PCR register index
 	  that IMA uses to maintain the integrity aggregate of the
-	  measurement list.  If unsure, use the default 10.
+	  measurement list. Most attestation tooling expects PCR 10.
+
+	  The default is almost always what you want. Only change this
+	  if you know what you are doing.
 
 config IMA_LSM_RULES
 	bool
-- 
2.55.0


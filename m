Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A358370D6E
	for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2026 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993434; cv=none; b=MnlBDcgCg7ns80WebsB6u3x6WNGRR+C9U2cL7+UmP8Ep3gPY6EM+HVhmcCeqxC3MTeupyIRqrm+p9Q3G2bUnnMqcZjjiD5QnVfsKxypwjSaloV2RdtJgobgj1+WAw59SS3/wfSF2hIFnM+I6mpyKrfW4KqFHhoLn/iIz+/CHSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993434; c=relaxed/simple;
	bh=PVs+gHTDyYChhu+7rRJSjmFR790Mb8zOYoVJnPhHsQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Et87kxBOfFo8PCfLz6x0VSyEP1DhE2DPZwP0k65qNupT5vLpu2SpZKuBoTn4l8P7qirZHLli7gUs3/D8PJ+Volg7BxwmE4FEz4GP2XiqKmdbX0T2Y6xpZ4adCtduA83fJZ0xy/b7xkZSandCPCnLHOemZMI40lggQqXlU76ssA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlaO0CRb; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlaO0CRb"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca7c1176317so2724529a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jul 2026 18:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783993430; x=1784598230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLYnguE796013GUUX5AfLaBgg2bMMPqf3FcC8kN1cc0=;
        b=WlaO0CRb7KrIB/XrVnc1Dmc0UqbtDoG3BelkYEOx55pq640zozcmjQ06wciqCDuD4m
         EihGqQf486ZkXBPIYQJ/DuULtVXIn2Zao9IGlt3kS3QxxFNnEGnwsItetocmCK3j95nR
         p5AwSGvhWl/ZxboXSIuqklKmI9g9wDv0qMGK13JB6duvjpXpczqV2l8DJZFsd3rjJc7+
         L1vM3A5oZNP9rt+pAOO4So5UKxj/qXeJJjq+jizVIY+HoZzFHZTEVTNh5UmvxjS7/mxT
         sm8bktBnG21uIkqvCQPABtijbfmPWMyGbzSm6RBZTfxX+28xbvNHBRrouRZIWwCLX2Do
         R2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783993430; x=1784598230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yLYnguE796013GUUX5AfLaBgg2bMMPqf3FcC8kN1cc0=;
        b=YJnnG+mrq97KM0kk+TFIHOmaI8JL2lYaUwOOAxuGFxTCxtHQw/QoG3OYAdjUDMK59H
         l9KkIURcT5609WUxj84/gMX1eE/4YHmWqzz7PRosoYRHIVN2bV0SEw2YKjS+TUatxx5K
         a7WZoDERT0c5XgYrpiQp+8m+Q+FMSjKZ9Dk+J/rCVGPxgfXIXrIbmdDurWvuSfDYXROH
         kvBhdkPp6Joq0rflmdIHz7lLQn4nU5dKAFkatkNoRLepPjkda0wX90PHUm8Eq9FxbxrP
         qqicz+gw17azjvz1ZXhNHL4sIzvj4lCkUnvDBEe70mw58MP3fCqM0SPV/9wnETHi9ImW
         US5g==
X-Forwarded-Encrypted: i=1; AHgh+RrK+B2CafjTCpqhnF7eVby2WZGTAQrP5zEOrrVm22KSWWhjq1VrQSHN72yney28+f5IO9MQqTuVGA+Po//J1fidozqzMyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ajdXCXgPorlYre5SJjePM78wtW1cTFcU+UdsRr7uGramg9qg
	heE1SM2xYC1ueQiPyRKhLZoV5KTu1ixnncwE0X+hAnGH3ZliOtYkZjaH
X-Gm-Gg: AfdE7cksjoEjp/lYdTLnvJQS7xNeoeTS/Uf8aNzfHhQ5T2wItp+LhmFvy9BFcbyM8jy
	XlwT5vm1uPEE2HaLR8AbcjELO+0TQ6jZx7Fl3sAjrRNbOgVCpNSDUtB/kq67RKE2Qs3QObz2R79
	kY7pGIr63JF4JDmYRKyR3+8nXeOm1gFTHHzWlLWBWPg19+UPQj7XC87jFQXCdvVgrnKQkS+aLN2
	zR5hKWizIxeOQfTNneqi0C+HqUI7D6SwhFCGyY/9ASZTKgT1TcEC3Qcwvys1U/mUod4zaMFIjTE
	mgeb02RLS1UL6QEaWT5mUvEXdROuJO7LDb+1TBg7ddmwETANPmVD88SjXN/RWeWlv1Tg82mjCZt
	f0eckMXEg/2f1Bjl2P2/m9aoCTfYVBj6xKaImafuU+xD/qpTT3k2/RIl7vREOYIq6LziAsqbiiR
	67MJVG2IuLOg==
X-Received: by 2002:a05:6a21:9d48:b0:3c1:85d:fa2f with SMTP id adf61e73a8af0-3c1108c2d4fmr11352039637.36.1783993429962;
        Mon, 13 Jul 2026 18:43:49 -0700 (PDT)
Received: from sleipnir ([2804:d45:3612:3b00:32a3:79f0:cdff:a04a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm59675775c88.1.2026.07.13.18.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 18:43:49 -0700 (PDT)
From: Lincoln Wallace <locnnil0@gmail.com>
To: paul@paul-moore.com,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	penguin-kernel@I-love.SAKURA.ne.jp,
	rdunlap@infradead.org,
	Lincoln Wallace <locnnil0@gmail.com>
Subject: [PATCH 2/2] doc: LSM: fix module ordering description for /sys/kernel/security/lsm
Date: Mon, 13 Jul 2026 22:38:32 -0300
Message-ID: <20260714013832.977443-3-locnnil0@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714013832.977443-1-locnnil0@gmail.com>
References: <20260714013832.977443-1-locnnil0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LSM usage document states that the capability module will always
be first in /sys/kernel/security/lsm, followed by any "minor" modules
and then the one "major" module.

This does not match the current LSM infrastructure:

 - When CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is enabled, lockdown is
   initialized as an early LSM, before all other modules including
   capability, and appears first in the list.

 - The integrity modules (e.g. IMA and EVM) register with
   LSM_ORDER_LAST and are always placed at the end of the list,
   regardless of the position of the major module.

 - The relative order of the remaining modules is not fixed by the
   framework; it follows CONFIG_LSM or the "lsm=" kernel command
   line parameter.

Rewrite the paragraph to describe the actual ordering: lockdown
first when early lockdown is enabled, capability otherwise,
integrity modules at the end, and the remaining modules in the
configured order.

Signed-off-by: Lincoln Wallace <locnnil0@gmail.com>
---
 Documentation/admin-guide/LSM/index.rst | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index c24310c709dc..9518495edfbc 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -27,9 +27,15 @@ man-pages project.
 A list of the active security modules can be found by reading
 ``/sys/kernel/security/lsm``. This is a comma separated list, and
 will always include the capability module. The list reflects the
-order in which checks are made. The capability module will always
-be first, followed by any "minor" modules (e.g. Yama) and then
-the one "major" module (e.g. SELinux) if there is one configured.
+order in which checks are made. The capability module will be
+first, unless CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is enabled, in
+which case the lockdown module will precede it. The integrity
+modules (e.g. IMA and EVM), if enabled in the kernel
+configuration, are always placed at the end of the list. Any
+other "minor" modules (e.g. Yama) and the one "major" module
+(e.g. SELinux), if there is one configured, appear in between,
+in the order given by CONFIG_LSM or the ``"lsm=..."`` kernel
+command line parameter.
 
 Process attributes associated with "major" security modules should
 be accessed and maintained using the special files in ``/proc/.../attr``.
-- 
2.53.0


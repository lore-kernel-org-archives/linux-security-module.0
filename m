Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298A20298C
	for <linux-security-module@vger.kernel.org>; Fri, 14 Nov 2025 03:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763090618; cv=none; b=n9WbibyRmMOdieVulMPHXCuLaPeakmJreqQX1E1KakVaOtI5AMsoX03vRX08Hj1HyzSu+d8qzFypD0xpH121iOqF5atOIq2BnPq2Jcrk47VvJlWk+lf12U5z16QSM0RuvYZjXAtsS/Y1IIxqWVKinS0NHncqKf/LlEuw+JtxfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763090618; c=relaxed/simple;
	bh=DzHro0xNr70EYxpIcz3rGjha7A8PYxBga61WygXmHSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OR0h3XmX54kQwobsLyelrtIfUfnJEdEL6XTU4JPj+OwdrIwdXz4ePLQq1olmcH/n01mdwxc6hMhaZESfquBPTMC2Ol5RFmNuZ3yTCY5k9GxF3ZiiTebfBxyRpD5CdesecWAIlXJQk0Mge9u2V+GNm4ktUrPvFKQrY1lOsIbu7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYry5gYt; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYry5gYt"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b26b12be9eso167858685a.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Nov 2025 19:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763090615; x=1763695415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dkrt4Bp2pLFUlX3oLFLTvUW3L5WSrct2SUsa+csZg28=;
        b=NYry5gYtYglUujRkAhrUWrMWnnP/7eiZ0O4ls8t2YiRpGP8OZ7N+ahwOBTqAex1V4n
         SSteFCmQTz+mf2e1KS338PQaxQHEcZjvHhLjd0wxZ2FX4rnoCl0Svoutb6NszbCcyDxG
         HwckL2+fz9iKBQmP989+H1kkLYhoyVxnbPG6Yqp1Or27Wp82F/bmEIuKDyLeequIs+5E
         okdKp0A+ugqVTI3Lgc8U8JxuYUVwHyAV7U2sqtid8MIGNL+CgHbUP00Y3OK+GkN4h3Jt
         8rFaYYyJ5L1nhPSJfa1bBv4Ewa8kNjMZoIDSEFIUfdQhW2XjUn92HPwQDMksByhkmXGl
         /LfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763090615; x=1763695415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dkrt4Bp2pLFUlX3oLFLTvUW3L5WSrct2SUsa+csZg28=;
        b=RP/stqlFfGFQ2EdgLvjptjPj2xI234kTCoRM6WLWIYJkFtEgHY/DJuzUT5jNFxh2lj
         etIu+2nDekGMyxxFGyGXnGHGRhDvFNn8LkmFMRwn9k0C5xw/PT7+BiraUwbUL4MDBSqy
         XZvLTJuEJQgfzLqjYGayEQ3cR/XPoOfBfDklaz+RONmGS/OI/o+MzDhNYZmirkNF22Uo
         3IJ/zaX4HPZC/ZEpKOvYjSWKrN+B4xNMJVoC3Wzh7aMOQt6frlDNvWiSEXozM0R+V3Xn
         9y6asHn6ko8vIX9VYVVWuqdC6Mt/PL4H2Nq3hfp499dt/q+DDuCVJp2lJm6JIdH/35MC
         255g==
X-Gm-Message-State: AOJu0YwNcXTG2Avmy9CwHg2ukuUiCN0MWFYXi/QtOK0yGtV6goPUxucV
	JIiffq8YqW5Z/wtva3zt95S0I3akzQMP/CtlHPzcOtr2n6gNa1QcpTQSVO96wMJg
X-Gm-Gg: ASbGncuW37fpFcT9VpjZ5KA5VWLP2mjNbJpv8xGqtzujj23NFd7Wx6x4oQXpCFGwrW5
	sYqAuqlE3w8Es8OPz1VRPR5AzWunGDuwEaUGfCXWpHS9TM/6Opz0XTJtZEZeEymuZLFVAZCwune
	ksC/h7C7dmMa5vqiHyVbgwx4DWkevsej8PJWJrtJY3n70nN/0+AAjA0D5a8ESsniW+YD8irpLGR
	0j2jpaf6Ri2h93r+iuhU+7atvVqej852ldqOB9EbCDykGynWrYwOfkZakekr4xwLI3fewUvGjjt
	dzwlVl9DIJXOnxa2mb8AQ1bemtOUcl8vA9GWwQRHl+5sBB3rwlolmNRRGM53ZUmHC0HMhqpA9K9
	CxTyI+tydqoZ7ovYzeRlGHXoGzl+ZmFDIUez/BujeY9WnaQd0vr6pAgfa5gb6W07gf+J8GtRlC/
	/4IyHvAN8T+jqlMh/L2wgl/kwsVqQkC8L22K1tzj76Kw==
X-Google-Smtp-Source: AGHT+IEhzW74eEXDN9g1FsomVeWPM45zEIV9qmeDeJunqbQlSnHfTFM8xcIvOUkjO5PR0oosEcfAIg==
X-Received: by 2002:a05:620a:f0c:b0:8b2:6eba:c460 with SMTP id af79cd13be357-8b2c3168f46mr224652985a.28.1763090615594;
        Thu, 13 Nov 2025 19:23:35 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.78.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af062fd9sm256134785a.51.2025.11.13.19.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 19:23:35 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?B?R8O8bnRoZXI=?= Noack <gnoack@google.com>,
 Paul Moore <paul@paul-moore.com>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
 linux-kernel@vger.kernel.org
Subject: [PATCH] landlock: Document fexecve sadly reopening files
Date: Thu, 13 Nov 2025 22:23:32 -0500
Message-ID: <2240250.GUtdWV9SEq@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Relying on "Files or directories opened before the sandboxing are not
subject to these restrictions," I tried to modify `setpriv` to allow
`--landlock-access fs:execute busybox --help`. Sadly, support for this
use case is absent in fs/exec.c.

Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
---
 include/uapi/linux/landlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f030adc462ee..a69e9fef703c 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -206,7 +206,7 @@ struct landlock_net_port_attr {
  *
  * The following access rights apply only to files:
  *
- * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
+ * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file. Note fexecve(2) reopens it.
  * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.  When
  *   opening files for writing, you will often additionally need the
  *   %LANDLOCK_ACCESS_FS_TRUNCATE right.  In many cases, these system calls
-- 
2.51.0




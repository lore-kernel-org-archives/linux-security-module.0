Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601435;
	b=NbhIqZKuxRoHLZ1DWS6tvgvJFHGcPhlm55PwsLQZiGQspFiGRouDqwD4atFWrCaq0qac
	 8K2kKyQoGAo6OFaepoviRGs38Gqur9ssFG0S3LaoLkI7Da0jUpSk8RNjK7ruaMCu1kpkW
	 hblFx7eFG6KOT0C1CAIbbuhC9r2oqWvBU4Jn27fMDnEFKicH9R3nSypeasEV98Moxynlp
	 3XvBAFnLMEyjrmj4pAgDMlsVXhITsC3AmyR3XCSoYX1aOugeH3xBkvbEwwPj0PeqfwNZH
	 9eHwrNq1AjlfmZX6vT8ATQKtU0lLbJp6J/3Wg5uxxJmSkoaSufS2SkLCR1ikjxeCRDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=WuFDW0jud57WyRGGTHzMPW/pELUpVMizwN/dVZUKa3Q=;
	b=3f8Z+WQDk+9HwO2ObOTTriLxe26wrA8x+g3hq/LOgZ1TZLdllHfrZFDOea75qVqk6gjc
	 ZuwkWgf/1cp3H0Tu6PwGCZinjd2B+fH3dTVr/XFK2iyyCbH9DFhvBEZ4AaMLbenNtF63J
	 BDO876miijGtLb6P7ELsg0b9LociTLmsjjkzzLv+MIIs7ju/2pHsPNV5eDlPszdAb01LZ
	 kmfUdirUzXTIe9VXC6TAgd9V5ebz/YD57cexL3XXCJxDb2cLHGjtXArm/FV+VDwIPQPLT
	 lWIKQJWv5rlvFNlfMOFXsbo8K0Tk0D7tmoOeywT6bAly2JHe2VMAkILTnNWhfthGGow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QeWUU7M7;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BE606A330
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 768BE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QeWUU7M7
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4919a880834so686224f8f.0
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 12:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601434; x=1795206234; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WuFDW0jud57WyRGGTHzMPW/pELUpVMizwN/dVZUKa3Q=;
        b=QeWUU7M71JvO9Vv0lgiL+sU9jHCWhDolHx2g91UpgVev+mt8J4dmuN++myRVgvbENK
         +B2+HC8+dRgWdqJtOhNmF6VAYSjNbu6SyVe6+GsXUglCPVfC1A4W+ChILaFOuBAfNLjb
         hbLA7ntgOYy8F1lfIjEqBYPY7SIdDuWRJOL2E99tnvK/7iDdPlcmdldQ3vJNDiCb797f
         IJnCIJ/SAW2NxYD/jBFaMJt6i5JpdOfSWEbA86Poes6vptmZr0s3D9s7tAMyqaNvkbqR
         4OtAkk5IcY1rqrgZMdeKtVmJNBxXrngqL+nR746nNxEnYERbco9Qqm16NBNTjfik+XZD
         CtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601434; x=1795206234;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WuFDW0jud57WyRGGTHzMPW/pELUpVMizwN/dVZUKa3Q=;
        b=ow5hGpFaiZH3sRznGO6JlRED4i1z/J3V2IOQ6jHMjiHmaX/TdQ3FJseqgwfH8H+6/g
         AuYyusF9q67ESDdvo9ajg3LjIK9TmFvwnVC+7oyIUl6M6dbYLqO8Cui600pl6L8ngl/6
         uz3JGDNDLFESFg3cRCVAr4+BM+ukao/hMIhAvVH7qVxnOFsPG8oapNgCtVypKz0q7Ivg
         glEngTbYCvObnLg7JAs4BuvsbezAxcUnJEnXbz2vfQg05CF6WFscN7Knu0cDsUPFQi1z
         m3l/qbAI2OEaJBAPKBh1eh0OTl6AwwjfWrs2HtTRYEG6Pb15yKIAcxlLDeIAbsm8qIi7
         wV/w==
X-Forwarded-Encrypted: i=1; AL+hErFbFS/wUlH9DxbQYS9vVNuoxkx1X/7hJ2b3qigJXYCZmtnMBXzTa6yaC8wEbuUMmjQ/EFkwnjRQ+OD/zcyz0EuqOphrvNQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jsJK8XpMHnj7xW7cyhDMo49sAT3sEou5VWWYhQdRYgakmJ+KM
	nNZMaJpEUiZ+2WfrhkZbSQQjRhbEm799piphWgzhQw12fA5DCopjxvSP
X-Gm-Gg: AYBFou1TauU14h/fr4GWk5NENP1L7dc07KGL6IQMrXOVTnlSQYfXy0MAIIoe/4tuifo
	n+AVId04wpP3hQ2ApkAz4M6tcG7hG3DPrU801JWFBjdTWB42DdQUE7m+UlPwf3/5C9OCr6253mH
	tsr8tdYjpU/pdf1Z+XQLmch/TokSNTdBoE+MkFJ6plDF6RHkbS8mklX2Czpp1McALYnP2OQLwa5
	fR+bHN54pk9OUMmq9pBgMDMWPCdVx7zhnegSBvU7t4QyQpwNd4SIeKG9uxnm1nrmbsfdhkv+t/O
	Wqs+D06tGoeZzH2PGseE11CCT4tSnXVDXQjNKtmMR2dkyB2FG1WXMf4WiKO5yWqjkNVq8PIA/4j
	/L6iTVLh93lYOMhsVOcKwcN/V7Va1/9I4vPYS8vNTR2Opt1n0NnBJ5xsdBGT/gBJhlfwfDrPBVc
	/7+uWrYwqSFF4czowk4jl4yhkzMS0x29z1ahMsDNSI3YG0iQ4VpKLd9EeSARQlp4TEr83cSKxA2
	XzmN2fYdDuFWkRukVniGidF3l98Ru0AjwZs73JPWYKZjndx2ct2FABzpzx6C+IIQDaWO6MO4jHa
	sMnYACrGyAnXPNgdpjwLTivHpEGRbzobSB3ZetDove+YbB8FIyXnuA==
X-Received: by 2002:a05:600c:1d08:b0:4a6:b49f:9ae5 with SMTP id 5b1f17b1804b1-4bb55a898abmr71653285e9.34.1794601433578;
        Fri, 13 Nov 2026 12:23:53 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb566220edsm118582515e9.0.2026.11.13.12.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:23:53 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v3 0/5] landlock: Fix REFER in layered domains
Date: Fri, 13 Nov 2026 21:23:22 +0100
Message-Id: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOQQ7CIBBFr9KwdswMRVNdeQ/jAihtsRUM1MbG9
 O6CXejO3fzJmzf/xaIJ1kR2LF4smMlG610K5aZgupOuNWDrlBlHvifCCpSAQbp68LqHYBoTwHn
 XxLSc09zUslJaGVRCsOS4J8Q+P/7zZc3xoa5Gj1maic7G0Yf5U2CizK2/sERCLoi2xA/VDgha5
 6XuS0Q8tTdph632N5alE/+e/a84cUDgSuCu0aRKKX9ty7K8AdIWSz0TAQAA
X-Change-ID: 20261108-b4-landlock-refer-nonfs-layer-fda8bcbe0b44
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
 Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

This patchset fixes a bug in Landlock layering,
reported by Dwi Siswanto in [1] and [2].  (Thanks!)

The bug
=======

When Landlock initializes layer masks for path walk based checks, it
unconditionally adds the LANDLOCK_ACCESS_FS_REFER access right to the
handled access rights.

This leads to a wrong layer composition, in cases where the following
layers are stacked:

1. A FS layer restricting REFER, but also allowing REFER in a rule
   (e.g., handle REFER, but allow REFER on /)
2. A non-FS layer (e.g., networking-only layer)

When these rulesets are enforced **individually**, there are REFER
operations that are allowed in both rulesets -- the ones that 1
allows.

When these rulesets are enforced **on top of each other**, the non-FS
layer starts enforcing REFER implicitly as well, and all REFER
operations are denied.

This patchset
=============

This patchset fixes the issue in five commits:

1) The fix, which should be backportable to older kernels
   and which is CC'd to stable@.
2) KUnit test.
3) Regression selftests.
4) A more elegant fix for newer kernels,
   which is intentionally *not* CC'd to stable@,
   because it would break on older kernels.

   In newer kernels, we already add the "REFER" access right to the
   handled access rights when we merge the ruleset into the new
   domain, so there is no additional calculation to do for it.
5) A documentation update to clarify the situations where the *_REFER
   right is implicit.

Both the selftest and the KUnit test are built to fail before commit
1, work after commit 1 and continue working after commit 4.

Please let me know what you think!

–Günther

[1] https://github.com/landlock-lsm/go-landlock/issues/66
[2] https://github.com/landlock-lsm/linux/issues/67

---
Changes in v3:
- Add erratum 5 describing the issue
- Add KUnit test
- Selftests: Test the scenarios where layers are enforced in the other order
- access.h, fs_test.c: Update some remaining misdocumentation of the REFER right
- Link to v2: https://patch.msgid.link/20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com

Changes in v2:
- Rebase on master and resolve conflicts
- Fixed documentation as pointed out by Dwi Siswanto in
  https://lore.kernel.org/all/20261101125114.19009-1-me@dw1.io/
- Link to v1: https://patch.msgid.link/20261030102411.12985-1-gnoack3000@gmail.com

---
Günther Noack (5):
      landlock: Fix layer composition of LANDLOCK_ACCESS_FS_REFER
      landlock: Add KUnit test for landlock_get_fs_access_mask()
      selftests/landlock: Test that layering does not break refer
      landlock: Simplify landlock_get_fs_access_mask()
      landlock: Clarify implicit handling of LANDLOCK_ACCESS_FS_REFER

 include/uapi/linux/landlock.h              | 17 +++++----
 security/landlock/access.h                 | 13 ++++---
 security/landlock/domain.c                 | 44 +++++++++++++++++++++
 security/landlock/domain.h                 |  9 +++--
 security/landlock/errata/abi-4.h           | 21 ++++++++++
 tools/testing/selftests/landlock/fs_test.c | 61 ++++++++++++++++++++++++++++--
 6 files changed, 145 insertions(+), 20 deletions(-)
---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261108-b4-landlock-refer-nonfs-layer-fda8bcbe0b44

Best regards,
--  
Günther Noack <gnoack3000@gmail.com>


Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689D83164B4
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190920; cv=none; b=b75uUL3LZL7MsZXmJnfK30vkOo2bU+HXlh+Q1wBCD35dJ6qqjoHASnpw8eCef6Af62z5DX7exnoTj1nAhsxPdfh/h3URVFJZisQELm34+JbQtoz4Lsbtr6cZItjFTn9O++6gjtgYgEs9n3loUr0gHyGuf0sUdQSUC+tPThhPCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190920; c=relaxed/simple;
	bh=vUmD8Dr1QA/q8Q5d8zJXZvPMSpBgJu62nHTvdE3NCM0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nwjx8bjuzqFIvO32nox+ebJefuq0z/dIYKhH1i1VQS5h65ZisAfkQOPepwKOLbtweGr24XN+zJ5EwTUc+nRNcVhJKlDzH9W3Ur1LVG5YCObUSRWzFGyZ0+fNCgRIyfYuIXsX1lzJLpY3qTKieGNhIQS2I2482iyj2kimhFSNITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e0MFMXAm; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e0MFMXAm"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81e69a2db34so44571357b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 15:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1785190918; x=1785795718; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E4ZkrWpY1eycEFbvVr+P7kycKCmRHCPZeyFaSQqYnPg=;
        b=e0MFMXAmakQwTkJKxPSK+a3SOl53vSmhBT3KY82FiS5wI4fo+hxPClvcD+W4VYQi6+
         zs6AraFiTXa4aarPoPdGYZ17vJJJH1wiaElf1v+ZhLD1i+NFJE9n/5vo629HTInEA8mg
         DCPbOIpCSAXJ+bK0ofVcqmWwYTwPzjJEnhF6JXlzABf3xsH4CgOAhEnMwQbMnkHgo+7K
         bvifz6RuZF5SDRFWdg9EJrr5NzZiF4B03wips5OKKJ5dfnQHPDiP/HnJb9Q2EZ6Mj0np
         C6KrVhtditBrI4AN6A54Iv4EBsiPgH6DOGlzVpCIqFHYTqeFUMP4Jkx+aZO3swavzXls
         om8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785190918; x=1785795718;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E4ZkrWpY1eycEFbvVr+P7kycKCmRHCPZeyFaSQqYnPg=;
        b=sWWcH5Llxnxky1hML4qCjSQ6grchRmNqlchKAfJJPqXT99vd6eVH4ZwpQDVnRyixmi
         oHZkvjxv9yT1lbnOumiyxFxzIUd4P0Pn7woxAaiwZnB2QrLzzP7WJdTrInTge9pGcsJZ
         b3Fk+VOqjfBAyKClVPo0AZg2p/UsfN5AzQwRY2+KSu5GvSX0qoLZ7xqY+iqFmY10vMtB
         DCRXFzvIH5txqaOTi67SZ68ejsdyOWxO2vaM6nx8k6Q1cXSdqlKDFdrgAx5YsW0a39Ra
         bVXw0phF8XirsxvtdGDD89gQLaEn7KlRWgDDlbrDp1wWH8B4k+OfapSw5XYWUGUqa4tY
         UsSg==
X-Forwarded-Encrypted: i=1; AHgh+RohSYnx+Rp2nmzn4iFxRpVv/z5Wm3A4fEUGHOw4w+d0tvndy5V3HAe6/+RcWeOmjXDefzdhzow5QTPOMsDpzndlgf1kg24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5Vo+ym8HllFnINh4Zgv2iMnU5YIOxc/COpGMwtL/fr17phXF
	HtlfMCmofZZ0znKVMo0LrlaPwulHOJg7aPelNW4rJ97aMV6BceOHAzVeC7glCcW4huE=
X-Gm-Gg: AR+sD13eWHX41sSN/DKqaq9GIDjp8luBvarDdytExkQm4EDJYzyWpDsrSAtHXglhXoe
	jOmB1jqf5+m4ArKJcn7FiNK4CwdGU5gjloXHBJqXgkdWtGoQsgpg3zvOi0kp4bsm4sIGpVBAOWp
	RTpKdTlnx8NQu7HA3u5Yg17fauOcrn1iltJb8gEL7GgEWJKf974XIrLbjJK2tdzxXmrXyRaWza1
	Qoiih3sKaBaJkQTxY6rWRPcNK44S533XCvWqJYSziBD74nDJcC/EwPwcvHQKoHIwrpyeAPXqXBz
	PsRZvueBlkcxbbItG61ecVkmXVXDuO+FEdaaGj2BCt+qgL1aOGngLHrq5d747QRnxJbxJ2Z4baI
	oIMJ3U/jSWenAqdmfPhO+i6XLEgQzoAjxQlnISzo8SU0+ACTQ0OV1W+UIfWk7FA==
X-Received: by 2002:a05:690c:3344:b0:81e:bb95:653 with SMTP id 00721157ae682-81f69e36e7dmr37138577b3.42.1785190918299;
        Mon, 27 Jul 2026 15:21:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:3af::5e:7e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65774b02sm38756017b3.5.2026.07.27.15.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 15:21:57 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v2 0/3] integrity: Return error codes in audit messages
Date: Mon, 27 Jul 2026 17:21:46 -0500
Message-Id: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPrZZ2oC/32NTQrCMBBGr1Jm7Ugn1viz8h7SRUimJlCbMqlBK
 bm7sQdw+R5871shsQROcG1WEM4hhThVULsGrDfTgzG4yqBapdsTaRSeoyzoTfLIIlHwqNqD0wN
 r7hjqbhYewntr3vvKPqQlyme7yPSz/2qZkNBYuqgzESnubnaMLzeMRnhv4xP6UsoXcWmTE7cAA
 AA=
X-Change-ID: 20260716-report-hash-error-5203d6fe6e4e
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=vUmD8Dr1QA/q8Q5d8zJXZvPMSpBgJu62nHTvdE3NCM0=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqZ9oEz8vmACgchaAlUZ8X0byfE2zbrZJR3FcBV
 cmw25ubkDKJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCamfaBAAKCRCrJbR2A5LT
 bc80D/4vyPjPTHlGSnetDvPZMblFGs4VQ98hXY1QHPQN70lnFNFoHiz9LG5EUU58Hk/edL3HOBP
 YOUt5kLwVRtAJookHprCyPuoxwHbKSBZGistCNmjMAWnQnHWA7HAyS6qlqvVfVOofX4USrRqveV
 FoLc9CAEndg79m3j5ki6EEk35j4vWCP6OEMbKs9agB690P1gmsTv3NqGzOuVQ2ugS1rfWZ7iyoW
 XcB0Fe9UHdPCuv3pHPJkgc+uL0KXDfEVHwVSBHL6WS/tDoJ/+Rt2mvMWaFHuZviqBD1rES8ecjS
 n4R9EaIzdM06r58FPnJfeXkmLrxsvmqxBkN2GdM3qcFO2kG4R11ZJxdnRyrTwlUAnbOSwQ60unI
 gjr0Ktk5wlghEwdkpehjHaS+qpOcW/tzEg7ClHcSR+8R+uNyryglI9AEYtQiZ4Obl+pHLgzfYon
 FPPYXekeAAKc2EUPEge8fNukz0vxxRnMLjXTGAR+enybw90xIkHO0ZuAf/2GAYulcVgMipPxPNZ
 9DCL/Nc+f/QhGNqlY4eBOgNgXzR9vYHkxCMeOQg3F49M0b2mMCZOP6El4KCdvZDM4TeUjFxNnIj
 y0CGsZ5wJOfPM11PgpgyDmxNoSGrhmmHprTVZKeEjgFujaBlceXO07KDmsjMdfhL5hGNDINz347
 2o9qxnPaJ1DMnyA==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

Commit 2f845882ecd2 ("integrity: Add errno field in audit message")
introduced an audit log function that can take an error code. It is
wrapped by integrity_audit_msg() that implicitly sets the error code
argument to zero. The problem is that there are uses of integrity_audit_msg()
such as ima_collect_measurement() that hide the failure cause for
the message.

This series aims to convert integrity_audit_msg() call sites to
integrity_audit_message(), and then expose error codes based on the
following criteria:

    1. The log depends on a result from earlier callee, and/or
    2. The caller function itself returns with that result

ima_release_policy() is the only caller I thought made sense to keep as
is. The message doesn't correlate with a return code, nor does it
depend on a result from an earlier callee in the function.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
This is probably a bit more than what was asked from v1, but as I was
making changes and looking at other call sites, I didn't think it made
sense to keep integrity_audit_msg() around anymore.

Changes in v2:
- Changes from v1 are now reflected in patch 3.
- Replace all instances of integrity_audit_msg().
- Convert to patch series.
- Link to v1: https://lore.kernel.org/r/20260716-report-hash-error-v1-1-ac19281112e4@cloudflare.com

---
Frederick Lawler (3):
      integrity: Replace all uses of integrity_audit_msg() with integrity_audit_message()
      integrity: Remove integrity_audit_msg()
      integrity: Report error code in integrity_audit_message() call sites

 security/integrity/evm/evm_main.c         | 38 ++++++++++++++++++-------------
 security/integrity/ima/ima_api.c          | 20 ++++++++--------
 security/integrity/ima/ima_appraise.c     | 12 +++++-----
 security/integrity/ima/ima_fs.c           | 11 +++++----
 security/integrity/ima/ima_init.c         |  4 ++--
 security/integrity/ima/ima_main.c         | 16 +++++++------
 security/integrity/ima/ima_policy.c       | 25 ++++++++++----------
 security/integrity/ima/ima_queue.c        |  4 ++--
 security/integrity/ima/ima_template_lib.c |  6 ++---
 security/integrity/integrity.h            | 11 ---------
 security/integrity/integrity_audit.c      |  8 -------
 11 files changed, 73 insertions(+), 82 deletions(-)
---
base-commit: 1da739feb31b4fecae465ebf87ba44a97e44101b
change-id: 20260716-report-hash-error-5203d6fe6e4e

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>


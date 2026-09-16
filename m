Received: from mail-oi2-f6.google.com (mail-oi2-f6.google.com [74.125.231.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D994968FA
	for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594613; cv=none; b=sTp73aH2ajGkbaeEP3QWqXuubFk9rCEwgpqRrWGkdaGxqzjEVTb5/HsACttKxQRUKYYnf4hPVvCNV+9wLT8eU8Q9ZB25MsYlc3GFgOf9y8Kv423cHA2xL5zTatelLxCEAhElVqZ02+X8tElrPy4+nO12iR0CMOeYZfMsus0h6CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594613; c=relaxed/simple;
	bh=IyuajYzPnmD3io9Y6axVM5mE4O2sgF3cAAOwkQSlc8s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WIMPtvGu6WMm268+7z/r+WQiHfrM6q3YJMzjk+zM8T5RsU1bUvsjcrjoo8K+m1pIG03hKKTl8cRS0nylasQRkx9WpgvaunV9m3K7ZONVGB9SdvOhZJ4/SXlaSjcZG+75uCuswjK3et4FqqVLi58eLpeiMwtBCypPbP5iiNApDIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cpDtbHpE; arc=none smtp.client-ip=74.125.231.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cpDtbHpE"
Received: by mail-oi2-f6.google.com with SMTP id 46e09a7af769-8069d92e182so57133a34.0
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789594606; x=1790199406; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NLbXNfixPvdVNUANDYuEZ718E2/Tpe1XaOhwQtbxwPU=;
        b=cpDtbHpEJwR7gpRgwVHreVgTdmJBBhBI+wBIZ6sGTepgmt38lQc+imlFToKILs8xMW
         cyzXl3z7d5ZUgOngTV7fL07Opfw+J3bEl6LcHEiqE59ctzpKSXmibU/lf5dYyayy9Dym
         HWMngn528aNQL6Z0dJO//8zyyhH0TtKKJEviVnQr0V00AxTs/HYM+pnfhGc9nIaROExP
         76yxHUaH+G43VuFLJTy8+zvxVYDu/sPKRqweltvwfkW8DK5JsOqgqNPrEEosdd/6Omua
         ZJApwaa2eIYC+c5i/+p7PlO6OwL01InJ2qu/N+1KW0/QTAYTFiednKlRGpAzJxZwzOVZ
         Bu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594606; x=1790199406;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NLbXNfixPvdVNUANDYuEZ718E2/Tpe1XaOhwQtbxwPU=;
        b=1IS+px+gGg83fN4OP2r8JFKlxdRlGP06W5e2zWlW2xKJdf9UWDxKWEI9J7QGEDNd39
         N0lGezKEewaqagDQlwmpEz+5k5ThZIgRJZrUj2uaYrDOM6sQldBxD1/qSwsuDsvs4drm
         TfK8bCOHuaLJ3AcX+2RnlL7b/FPT0kBfHyw44gIz1mi2c9LxSXuak4LLo6r2dYqzYsGp
         eNlYZ9LTnEr2m+P0llMd5uWEHnTby1cLCeCwT3Bcuhb283kiteF5b4i3IVJnWSegz99b
         Yjb1tfgPAC2LYeZfa+qR2CYWplYRfZFAzAvIdImjNC5cAnBRpNWisiIZpl6CCk6CURZ5
         XeFA==
X-Forwarded-Encrypted: i=1; AKwUvBzX63ZjnF2NtvrbHLSyItrkuwaN/QAsL+VdRabTnADjh+NhMzv60UigAivqIYp2Z4uikxUtz0rViRX1s9jFQ7uvkO6/m1I=@vger.kernel.org
X-Gm-Message-State: AFuF++ka4T3s+kQFPDVMW/f6cXjVMjdohWpYvZUnF6EdPltWhkV2AMxW
	V+E2rzQwvJxQEclbROegEUvxxNBpnNeLYAdl9erq+7c9vyF/0V/95knEdlnGkZdM+qIuzU13Lk3
	iGSdaiVVUC9Ku
X-Gm-Gg: AYBFou0EpfvSc6WDS8vZ+wRmYmGiszokpwHg2sJbG3kaCy5Ephe5usZsBPbhh6hDq4M
	vsmyQZeZBWgnhax4wkbv06rQmkqioLCCaGgEV1mSRXcQJmV6bhh0oYWhpJDCVTmrowoAi2FrsS9
	WLNUCS/SnFnnybvR0+1IbPZuSNgTcg3E4nPFXec9m7hpRLhLpGuOOSENkKqOcxIBYMEGi4g5ePc
	Oy05ZhcPcHB1CaySwueRzqhDKtv62qbw8FNbES4IfzKrh4vRMwQmUdjv18MPI2M8ZIlHOhKPg9M
	gOKTgg+Ngn7naLKLPJdBGtMbFMfU7w0L9gVAa0fu/bwbL8n3zs0sxYZQrVsExAB7e8V0gI2dSr5
	M8ZSeYuqK+DRCaqFAOzydjHzGV8oaL7A1mvI49Ql19d0G5vjlXkb6QBxxUQvNvb2WeOs22WCmV3
	FtiddWyZNiyFCBrG/2gM2XM3GGzGLHHivxI8eGuFwWB95N6gYuZS4ny+N7Apw1E+GHFGLm
X-Received: by 2002:a05:6870:5ba3:b0:457:4470:96e2 with SMTP id 586e51a60fabf-48475e836bemr4313868fac.12.1789594605928;
        Wed, 16 Sep 2026 14:36:45 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:31f5::4fa:4b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4842a23e310sm3387557fac.12.2026.09.16.14.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:36:45 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v3 0/2] integrity: Return error codes in audit messages
Date: Wed, 16 Sep 2026 16:36:36 -0500
Message-Id: <20260916-report-hash-error-v3-0-73e5d95e9efe@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOQLq2oC/33NTQrCMBCG4auUrB3JTPqjrryHuCjpxARqUya1K
 KV3t+1KUFy+H8wzk0osgZM6ZZMSHkMKsVvC7DJlfd3dGEKztCJNpa6wBOE+ygC+Th5YJAoUpE1
 TOi45Z7Xc9cIuPDfzcl3ahzREeW0vRlzXf9qIgFBbPNIBEYnzs23jo3FtLby38a5WcqQPhqpfD
 IEGo9kcc1dQ7uwXM8/zG9kvSCH+AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2513; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=IyuajYzPnmD3io9Y6axVM5mE4O2sgF3cAAOwkQSlc8s=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqqwvq9XE9AKDW+jkDoMPrQsp+EEVhR+0vyyfSE
 YsH584XbHKJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaqsL6gAKCRCrJbR2A5LT
 bfd/D/9DyM794xZCuCYiEp8E5G2ZlX/+MtkM8PpZR9/dOjmllI/84wOLM7fbud6MxqB0sFqJ1qc
 iQfPLsd+8PaifD4msMqMG0phYciWNwaJsRzCafsPv1++FbcNW8UxkY8ToRHztgTlPxbCkmaBC0Z
 6pqBl04uIPonxe5C72WGGTLRkz+aXEO7I38ySL9ez+ZyP5Fs7pGKUzIwYZEj+SqbtexLQpcfjXI
 91damz+0ON/kswGm1HNvnpy480xhISbK13hxvZoumQfkOwcrp1DfZreUjRjEZ6Cp0LFxLnhr135
 LrRyY5+UnySsfVyfoWnhZku2sVnzASQLAeDxBW8Yn4w98JI+PNRucWA4J2OGb0Z95uvLtJet/S/
 +3RklEagyndq4uDeftKt+SZYAgr2Uo2MCM9mvlTNlAntjjxeESypLO/94JlVGYMDl6Lvu+e/oyP
 crNS9NjS7SMdGFyAMm+L7ud1licAoctohOUa146AKksNJznngrSF6eoYBAQE8x6N1YS3kLUJ3bJ
 Dro/dhx9K0dyuY32ihvbcOmZ17pxs3CAiHttYSPNzCxLDzV0oIx04ug6CFUkeS2o7+AfMQZDLG2
 x5Qwm+bHSuH1GkhMQXsM6YOQImjxWAr5PEfIaDfmoD5BUe0IlMaMbNm7QUwEeNo3eZFowa7PMvu
 F7VT2pXl6cmquMg==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

Commit 2f845882ecd2 ("integrity: Add errno field in audit message")
introduced an audit log function that can take an error code. It is
wrapped by integrity_audit_msg() that implicitly sets the error code
argument to zero. The problem is that there are uses of integrity_audit_msg()
such as ima_collect_measurement() that hide the failure cause for
the message.

This series aims to clarify error reasons for failures, and then expose
error codes based on the following criteria:

    1. The log depends on a result from earlier callee, and/or
    2. The caller function itself returns with that result

ima_release_policy() is the only caller I thought made sense to keep as
is. The message doesn't correlate with a return code, nor does it
depend on a result from an earlier callee in the function.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
Changes in v3:
- Condense series to two commits.
- Reduce review churn by adding error code to integrity_audit_msg().
- ima_write_policy() to report -EINVAL instead of result.
- Link to v2: https://lore.kernel.org/r/20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com

Changes in v2:
- Changes from v1 are now reflected in patch 3.
- Replace all instances of integrity_audit_msg().
- Convert to patch series.
- Link to v1: https://lore.kernel.org/r/20260716-report-hash-error-v1-1-ac19281112e4@cloudflare.com

---
Frederick Lawler (2):
      integrity: Report error code in integrity_audit_msg() call sites
      integrity: Replace integrity_audit_message() with integrity_audit_msg()

 security/integrity/evm/evm_main.c         |  9 +++++----
 security/integrity/ima/ima_api.c          |  8 ++++----
 security/integrity/ima/ima_appraise.c     |  6 +++---
 security/integrity/ima/ima_fs.c           |  4 ++--
 security/integrity/ima/ima_init.c         |  2 +-
 security/integrity/ima/ima_main.c         | 13 +++++++------
 security/integrity/ima/ima_policy.c       | 11 ++++++-----
 security/integrity/ima/ima_queue.c        |  2 +-
 security/integrity/ima/ima_queue_keys.c   |  8 ++++----
 security/integrity/ima/ima_template_lib.c |  2 +-
 security/integrity/integrity.h            | 18 +++---------------
 security/integrity/integrity_audit.c      | 12 ++----------
 12 files changed, 39 insertions(+), 56 deletions(-)
---
base-commit: 6903878d4654bdef4e08e38cdf1ae306ce7de5f9
change-id: 20260716-report-hash-error-5203d6fe6e4e

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>


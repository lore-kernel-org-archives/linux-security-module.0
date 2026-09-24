Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22E4490C13
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282118; cv=none; b=trWUcCEJ3DWxuI9uSrMQRA566A8JssofvscxmwTsNxgs/aBDkT8tWubNW8xg2reTbxy+6+Dgssad0zppnPoj2u67tkn8wOnUqUaZIBqY0QutEzEhYhZ1wX+kGHEuR7/d6aWgTtWxb7u6mN8j3/dmwLbUudOXUxUUZmAOeowjt/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282118; c=relaxed/simple;
	bh=8g4cY0GEAIASt26IdZp/Z/yDTTQdKOaRlsmSarqsPM0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ajCVxFRb7lnp8qQzZmC9EktJR+gwbz1e3n2xkyo5m0NKG8d6xdJ+wnmC+81xEHAZPBZ3a/e0M30nWbBM5cu2KJgVN4UShPC8oGhMQDHca7oiMsMU9dp1wT9CxqZ31uRzs/5TDpmFOGJnzmmQ6BF2v67MiGnNbfS1lTee7hpGLxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NIIEza2M; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NIIEza2M"
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6b1b8f5a1d5so120861eaf.1
        for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 13:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790282111; x=1790886911; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jtPtVAhGj5L/ftRMmfjzkjCBRemFey9PZR0QsKZACbA=;
        b=NIIEza2MbDFB4Qcb7Aok1ZkvJJQomnQci6TvawJ2pIsF+QtFl0LBTWaY+I2qutAT5V
         7GJVUO6hf+g2e9A8dxlHaSGPoaGKHzsO7PJn74HUtTGNmhNFs/pM7R8T59Go785nPoo4
         ku3xPMueRXb7BXmBBogDsl87knxVtv++s5yR3kFR434v+HVVeGfIjoCWmF9FyUq8igwc
         qyTY92TnCh6wMU7hqBZfp6BA6mwlGoHPoSVzZIcLFjbqWUCT+6Se18oBGxnkhhNxF/oT
         wPJv4POPQPmW/qNA1HtsovoWTFticsrDbxbLAqtEIRLQSxDjKg6aN5b+HFQe4HmwU6oa
         xBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790282111; x=1790886911;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jtPtVAhGj5L/ftRMmfjzkjCBRemFey9PZR0QsKZACbA=;
        b=lSv0NZqTkyhup/9F9qFoTv+07vCtqSFCf3Na3wTDCJHFt2cKQI1FNvBFZZfhx5a76F
         SCP9ee7fHyTIwHoBb/MQlZkFa9FCNv7KMh4sfC4pUzCSglgjHTFH4R4XmreC1OS+bVvK
         7rDGiNtX8IHF5a9Vqf81XUbnNFBYmCYwY45hWqlOi9GIBZFae2FnWPocFKmXBBKx631e
         K77i+pgciRKdw/fRqUwTb32dlvzRGAehbQPbGk+AUwHo+vyL1w8wrrEFiZ9GEWY67MI3
         9nZl2v5bWs7MJDUFe+s2s/PJsTatfGl8dhKqKAzHCOn3b6/9P4Vs+UELzEqBhkr8+R/D
         qzBA==
X-Forwarded-Encrypted: i=1; AKwUvBxAURd6g3FcrD60XyYP24jVOMmcviEo+q1Ed3bAPapNazVJ3hZjKfiBbcWB6cvTdp4ZPpbLucSHBxuzASO1AvypKMGjMb8=@vger.kernel.org
X-Gm-Message-State: AFuF++lkR08btY9/m/tEiWAxXXtYK1o92FAoXyTLOPC2ZSDDD3XBXPbv
	Xl+5smqbtv46bRjqTipeS3drEybkTsC6IioGhgYjsBJj2u/75RGL5iWKEWK0hGtcJFE=
X-Gm-Gg: AYBFou190NhKsgzRQb5imtLxOYMm0wLo20xCutxJZLUUphlVLQYEBdakb46NqMueVRO
	tzg3YnoBIPs8YkrQ0oo2E3ma6fF2DIcq3ulyuO8t0/wZ4m9ybmCNG94LZW6gPbNugxRtttBKjhI
	njbwSqdYpCEcncXsQEM/qpT+hSTfklDxLLM2gRujVtm/zrYBjezlqlFesCwFtgU5S4Exu6+asXz
	mmTxQBL+T1T3POao4NMhPYVJj9BqVCT+bCJj3G54dyFIIBhoilygeWdtlymysdUQDfvQLnPFzEx
	ejY8GIgeSeG/54VRP6a0RRw0x/mv1gXsDxqb+wFKIyKuKtzlzmzM/kOBiHzZTk6nf4m7yZAL1QU
	gKBGkRgV9oAW3uKueCA3fu1iHw97Y9Gc5aAXcauV+ycxXCglhaJfgMQYZv+eUqJdLZjnvYBNsMD
	nb4txFwXim15WMtBxdgdFN1/WLpbY1ZWEVZ9YGdnAe+rSGPg1iCzz20kql
X-Received: by 2002:a4a:ee17:0:b0:6c1:c628:b0bf with SMTP id 006d021491bc7-6d43e22b55amr3510704eaf.13.1790282110894;
        Thu, 24 Sep 2026 13:35:10 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:1cd2::2df:f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49335011458sm254515fac.4.2026.09.24.13.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:35:09 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v4 0/2] integrity: Return error codes in audit messages
Date: Thu, 24 Sep 2026 15:34:57 -0500
Message-Id: <20260924-report-hash-error-v4-0-196ca6350619@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHGJtWoC/33OwW7CMAzG8VdBOc9T4qTtwmnvgXao0i80EpDKY
 RUT6rsTuDCJiuPfkn/2VRVIQlHbzVUJ5lRSPtVwHxsVxv60B6WhtmLNre5MS4Ipy5nGvowEkSz
 UsLZDG9HCQdW9SRDT5WHufmqPqZyz/D1OzOY+fafNhgz1wXj+MsYw3Hc45N8hHnrBZ8hHdSdn/
 sdwt8YwabIa1rvYsIthlbFPxq9/YyvTWTSDb+AR8cIsy3IDxssk7EUBAAA=
X-Change-ID: 20260716-report-hash-error-5203d6fe6e4e
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 Enrico Bravi <enrico.bravi@polito.it>, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2917; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=8g4cY0GEAIASt26IdZp/Z/yDTTQdKOaRlsmSarqsPM0=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqtYl7E0fQR4bfIoYoTSoTazCh+HWvNVUVV7Hiu
 F6o+KPD1nqJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCarWJewAKCRCrJbR2A5LT
 beupD/9934eZj90NBW1yC/eCPrwdE6pXH87jV5eJ0oB8HRzR6BvUBdtxH+7I8/gZ0RZ8eMFdcDy
 gg2xQt0C+lz8Jsq1zrSjVgmQAQf7tOfDuZjVlgPgUnrvDTAMC2M3XOTXVtUrAspEb0i4bVGim6H
 sx1eK3cSfaEbLeHTyd9kbiIJj2VGgb9dgyY5SFZx9PXgWW9Lda54elf2NLia8Ean2l8Y+DRdh4C
 bb05Do+pXKLEwlepv3JuQAYFpOMYuUGRxDjuIG/1wb60BqQDT0QUlEEIMD2p6Mv1iSrTCUd6RJK
 h6xZ7IXdtrMBQAjP78RMcE98CBh6ZfwHIdGM5K53Ho5cUySPgSv6/zQe1Q/BBKqkmZ8jbSVafqO
 ELNMmP5/MJ/lOhBURfq/4YUDw5eu0OehrIh/wKEDuG8unnTKQq1dMti9Yy24KcNTAxCOL7IvYg3
 8UrdvjVknh1aJUZTu/JzmpgDNboSJEKLnbiaPcZ2m9F9FL2/Gf0cXuOMadUUF16abD6kl0Jq5d+
 QYSvhMed7CmTz8hUQP8sthqsT+qotRPUD8+YR8wIQOCmc2CVBUFFlWIyefgbRk1cx13NUxLG0m8
 5zxAQ8c/sKGgNaOP5iOI37qKmo+sP2eI+fjM1Gf3sIrfOrLRu/MS2T08OUs2zQ5zWqQmTspjVnr
 BedLz5KMXAQdlwg==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

Commit 2f845882ecd2 ("integrity: Add errno field in audit message")
introduced an audit log function that can take an error code. It is
wrapped by integrity_audit_msg() that implicitly sets the error code
argument to zero. The problem is that there are uses of integrity_audit_msg()
such as ima_collect_measurement() that hide the failure cause for
the message.

This series aims to clarify error reasons for failures, by exposing
error codes to the audit message.

We do this by first by extending integrity_audit_msg() to take a
errno parameter and pass that through integrity_audit_message(). Update
call sites, and finally replace integrity_audit_message()
with integrity_audit_msg() and remove integrity_audit_message().

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
Changes in v4:
- Various patch/cover letter message changes.
- Fixes uses of return code for ima_appraise_measurement() to
  conditionally use rc as error code if rc < 0.
- Conditionally return -EINVAL for ima_release_policy() suggested by
  Enrico.
- Use -EACESS for ima_write_policy() since that would be the actual
  failure for the function. Suggested by Enrico.
- Link to v3: https://lore.kernel.org/r/20260916-report-hash-error-v3-0-73e5d95e9efe@cloudflare.com

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
 security/integrity/ima/ima_fs.c           |  7 ++++---
 security/integrity/ima/ima_init.c         |  2 +-
 security/integrity/ima/ima_main.c         | 13 +++++++------
 security/integrity/ima/ima_policy.c       | 11 ++++++-----
 security/integrity/ima/ima_queue.c        |  2 +-
 security/integrity/ima/ima_queue_keys.c   |  8 ++++----
 security/integrity/ima/ima_template_lib.c |  2 +-
 security/integrity/integrity.h            | 18 +++---------------
 security/integrity/integrity_audit.c      | 12 ++----------
 12 files changed, 41 insertions(+), 57 deletions(-)
---
base-commit: 6903878d4654bdef4e08e38cdf1ae306ce7de5f9
change-id: 20260716-report-hash-error-5203d6fe6e4e

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>


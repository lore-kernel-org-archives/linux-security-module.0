Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6D36DA1A
	for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081729; cv=none; b=pw9U7qX6dhofRMot//Cjf7p7ZdjAul14LE2e12CXr7sJsIHOCzltKFsBqiGzySfODtefFIcm527lT40hAUrFPtLzHvRW6GOds2FoIS0nvXWjEhYILanXdKOzMsrs+c4obXaFO7r1c6AO3ZwQYL/4jB2RqtlLTx+WnB+/wshFbGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081729; c=relaxed/simple;
	bh=Z1zkBNoqlTE7TFv8YEBzTzxz0vDSaujpRw+vu4hgGrI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eRsYwcfXUOPPXGNDuD6ZrD8Ky8ii/Z8eB2RRzXjGz+Gw1RPjx8PTXHQSGL/D1lDK0TkJa+FagXWLwVIQCy2+D+fCidnJhFsplJarTC4D+S69E6UwAimDGMRLlelyf65tHZgt/QJQ3vqNiW6cx9YwATd2MV25d86bBagtPIMEv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WACtdxCv; arc=none smtp.client-ip=74.125.224.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WACtdxCv"
Received: by mail-yx2-f3.google.com with SMTP id 956f58d0204a3-66c70c510b1so239859d50.0
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787081727; x=1787686527; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R5kxolr59Cxqsf3CsaETXDSp9QVWCGFYLmNRwAwnZ74=;
        b=WACtdxCvnctavIHavv3O3Mx0gLizOCABakxvxlrKZZg8+u0ju7cNdLFeqsXQH84FSw
         5h+okGnqADtpuq2YbFHojUg6bq4C4BaS+vBraHaEmGjPWiHPGiepauRtMoTPlqvioZi+
         9kCgu43eZ8sBfv/FV9E/r2R4nal5SQ0Uktgs/mMeTR0Zb+0voVU5XKZWikbxGmFYP6e5
         aNy2rAEkPs1hnQpAAIYqO7icB97u0NOJpBEKXaX9d0QD6taMTpJbZlPU0lH0qWhF2TDT
         qVA777IJn5uVt6kpzXSqK0ypOyUvUcqe2BVm3UbdKXbMmoGEqvwkJYW8N/aRu7zR5x0R
         BcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787081727; x=1787686527;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R5kxolr59Cxqsf3CsaETXDSp9QVWCGFYLmNRwAwnZ74=;
        b=XBCPd5ZLoUL9hFjjXGT4Y0T+bsr4yQL8JeWz8jutG8p8IqoMUj1gGHXSqnSvgh0csl
         3a/gyKnUNJ8WlbHIox4ups3uT+476dZuiGZR1qqgFLIlrLJQgRPEaD16QOmW34nwfQ2l
         8Ln3gEwmXkrw4VC5+xv7dlDgkhoo7QAWY6yI90+LWh2qaOt5ApTLKEKA8xl5xdsbLm+G
         hgZ6atwY/G9UI+hMCYiD5d6WVfpCQ6Dgqi5A+iSUaMnSzuO3caFG813btYjOyuGyjSWT
         y40Icw2zrQg6E4kcdHPzOoHgLtAASVoBCOr9qFN+Je5PJJyF+yW4+VeDUigD3i+eiMZw
         XSoA==
X-Forwarded-Encrypted: i=1; AHgh+RqDTfpe1VSGao56wzOPkQzPtQSBXdEekiuUTQeoiTQ7rXlzdKNoG54AXkAjpSxWllZRn77zXP6OLSNFPZzhAcl4j6xcjWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFjzn0erSjVl4Xwhms9R1F/bVh9S21ROAgtbS0JZZobb0pGDja
	BnRKNcLVi5mAD4TeeX+oVPcuBM58Kl98C6rh6E5CvI+sVODqIBPEIzvVb4EqxlzifCk=
X-Gm-Gg: AR+sD12eXhFZ+wWDHLQ858V+GcCCPf/XSwlNp8OGmTwH0w+zisZlnQREQXVFztUJwa0
	V3zg6sijs9XpLEWiymyq3fxvpqQqA1INqYQwwgDUhd8Yed9+nBgrcd61bqXIMi9epq1oRWLGrFs
	GtF3Ne1xDiDmjYsPpA4dfErk65dQDhDwWKSgb7H32oiRYdioS4O1DS+qZBPOX+MoNiGTV35m6OQ
	Fs+Prjgqrx/sTjs1WFd8BiC7Qta8NkKxDqqn+sQMOVmSKQldCV6pkFVh5pGHvyUi6YF5247tpNN
	oZpVIylcCD1P+BZ4l9r/HjzMnLfYeJp6X/ZlFYylBc1QMkoQvIOQlftYii+vmhJWggbKiMDyAIE
	AsqjA2Ni4v4CQkl4Mk27nAwNf8naXzh3x/pFBm3SATmIvoIPdRfWHVlWqgkyExpRYeUbxmvIF43
	Ui4LW2P1/qH+oyyRvrNzRZ/3SqQ3xQGjWq8bHU7kV3169vqE8cxQ==
X-Received: by 2002:a53:ca4b:0:b0:668:15aa:4f79 with SMTP id 956f58d0204a3-66cca5767bdmr67485d50.2.1787081727116;
        Tue, 18 Aug 2026 12:35:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:3af::5e:52])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cb47809c6sm2795622d50.11.2026.08.18.12.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:35:26 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH 0/2] ima: don't measure/appraise files on configfs
Date: Tue, 18 Aug 2026 14:35:14 -0500
Message-Id: <20260818-configfs-v1-0-a2329043cf86@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPKzhGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0ML3eT8vLTM9LRi3UQjE4tkE0ODJAMLYyWg8oKi1LTMCrBR0bG1tQB
 KyJxHWgAAAA==
X-Change-ID: 20260818-configfs-a248c410b083
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>, 
 syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=Z1zkBNoqlTE7TFv8YEBzTzxz0vDSaujpRw+vu4hgGrI=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqhLP85sosKlBEoFU29UJl56lOKC/kkVBhV+r+9
 2q37yvmgnKJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaoSz/AAKCRCrJbR2A5LT
 bf55D/9zJDWzwTw0F8cSI2kW060svadBjhv31RuDFg0P2mYMzaWe1U7HCKOKEl4LHoVQ5+59vWB
 myjNmV9wrN0/lTnpp+vXv9FyMdiUZrYk7SR3UhHK3TKvDWyPwCs2AQ8eXQoJHfrfB72KtG1Wmwg
 kFb/3VYPiJ91mA6GST2sXPjvLpd1mvT6Ae2Cgc4gfXHZPT2CXBWIRMThY32+JRBR+o33rNIDhFS
 DMYnq0NTreBW4N7JmVGLyyMztvucHwq69d8cw0SQalS806tw32kvmLj7B01L9u/7Hs60fo6TTnY
 h7CyYFkFV2o9Am9ZyhZRHuLPMTNc+BFLM5l/aEbEzQIaKpCUeOxUHjBrQ7af+WX+tkxZWuez/xK
 BdgpIDm1Jgjx/xMMUae+T4n1+ATDfvYtfWOsvZ8P0jMJFiQsX4E/OMYMSwEB8JC50sqiMAMWTeT
 470kLx6gh13qbkh9VCA3NBiFazh9D9TR5PtgoCqwRHZHvAW5iRPL7qdlOqQd2eNiDg/HrPUT2jG
 bftQrzmWv4+4bKDvr4QVXik4VqvZwgpvZJR4x5M+bS1ljznbNBc5SnTuN7/T5SykMylVKByPeFo
 wyinR5QhYps3p1Bnfhn1T2ChRPCYtOQSr8m6nphx7RPAC1H9+AQmlVVtUwsGBvhrOnfl24tReUv
 2RJtjTyomFLfGtA==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

When IMA appraises/measures a file configfs, it has an opportunity to
hold onto the ima_iint_mutex while another file from a different file
system is attempting to appraise/measure. This may cause a cyclical
lock dependency.

Add configfs to the default don't measure/appraise lists, similarly to
other pseudo file systems.

Link: https://lore.kernel.org/all/6a77c7cd.b50370da.49fe0.0031.GAE@google.com/#t

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
Frederick Lawler (2):
      configfs: move CONFIGFS_MAGIC definition to magic.h
      ima: don't measure/appraise files on configfs

 fs/configfs/mount.c                 | 4 +---
 include/uapi/linux/magic.h          | 1 +
 security/integrity/ima/ima_policy.c | 7 ++++++-
 3 files changed, 8 insertions(+), 4 deletions(-)
---
base-commit: f1e10b10874051e4d99911dae0dd7b75a9f8ae66
change-id: 20260818-configfs-a248c410b083

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>


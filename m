Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF11C3B19A
	for <linux-security-module@vger.kernel.org>; Tue, 25 Mar 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926601; cv=none; b=ASN2rG6vCHgeq4QEc33C9c2ItMmaCtHbbq+hiGP0htmgPsG5h38YlT9iwIAEXq4/aPGifrXGU/ImGLfmUdD7RQEHGcxsdVHNx67pAtDB5uJIyWJARQXds8V1cr5olGL1QC7g6kGP910uSZpyxXbLhcAYicjYSOpptuRq8dCMK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926601; c=relaxed/simple;
	bh=esYfgx0cdDMN5ZaBBHor/lPAhpyh+4gBj/W9cpIjRxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfrhA7w4V6yPCy6xD1FVZlenwyvFjPpR5DIy0706OQt05/p5bvUZB70r84HN7z97cwiXg+RNG/W4vfVNOSRzL+dEmlBQ63RTT77y88zha5Y7O4vcRdrx0sRh6NhgXYqncvICGNJ+RCZQuFZS0QJGpiwLAMWUs++lA+kq5Peys7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fALCapmz; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fALCapmz"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c5568355ffso478364085a.0
        for <linux-security-module@vger.kernel.org>; Tue, 25 Mar 2025 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1742926599; x=1743531399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4H7GcC3ni0ITvlHddoWo0ZRS35tRQvYIbusVzXzsR1U=;
        b=fALCapmzznwEEJPwHjCSBi6rFAg6WmPA6D2FgQLnUIF/h4j9QNo4ntBceIKRtqgV+b
         CabNtxs1kOrg0/iiiwUcpxHzktem5mFYjDs30jYiAc1iRVXB4GqG4MZXwa4QNKBAb2r9
         7jvTpsPzQOQy7v1KH4EgDl9kmXY8W9Ctl6NKBl/khZIPt+gEGuItFuM0RWu26D+k9QeZ
         IirFmfMvH3ifN8DKe5vq/t/0AfO7HG6kFauoxi4BDL/+IPnK5XAZNGmFdWqp6xZZcaVo
         u1oG0NNzorDzUHWODbVqIoDAJ072YLqymLYnnhyBsg2YltMkwUW6+2Z75xER5wXwZkK9
         5jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742926599; x=1743531399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4H7GcC3ni0ITvlHddoWo0ZRS35tRQvYIbusVzXzsR1U=;
        b=oQk15DnVZfhM5Egg9s81WKQ31bobRWlCU69db3RZZatJpj3a3+82nyNKP1vgChuy4w
         UnBIeKZB96QoydheTZ/XUnhTYXxhHVqaqoH2mgioGL6nfaSTJ3TAGom8phkBeW1Wcb+0
         1op5M6hGedmerxsAvIG0cmKGYYJallHvwOyQVYD0bNR3VMpb9AK7FdpieMsNDwLFqtQ5
         FbNGo4TAeIed/6aHaR6UxjBemCl6/3zMqf0gtGx3kYa+zl8Y0W35I2hdnB5KpJciXGsr
         sEzX01oTQEF+XzYjpgDjTACdtKHms4SRTzZUVs3lEqOQmngiIybjKvK0ieWj4Z4uIofG
         5uZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1E3Os+0xa+/EgKUjtpty1Emft4ftlf17z5TvreJ3m2cC0EvBb1OmHvsu58wRC/Fjc6UG5C0scAH6WXwdzUPz0wLy7Ej8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvN4EznWqpaQvnoWpyjkucTjh0Wr1Lq+xiztUF785e6AQnRQJo
	3x5HOJEnJTrlCJyVgNi6qt5kWf5MLAw0Bd0Il85sMDsV00pV5fAo4qmkulMJyZlUBcqK9NKY7QN
	r65I=
X-Gm-Gg: ASbGncsx22Ra4Cw5t3XfwJGAhXAyWttLzQZk1ORXPZcikCPZ5fXTOCtatJya1pgRubu
	1uhjBHbF2L+lE2SYva6EMf7S8NexbTikzEGlmW5hH8fOBbG+bIie7RthQf+rpmsYKeN0jG4uOr1
	z9R1049AE1SplRL/9BFQ7P0n1FgdG/YVm/pCesd52uEC1HYo/1loDSR7+ptPuO1rUNadG/iH0fh
	0PKhVB8fR4Rqs7wX/AA/qNMGRwHnNYJkiWo4nvDQNSNW7nNsZ03QOGQE+yW0PAIIYpatzwOKDUs
	MVz33d3Bi9Xc1T+zWEUF0RGDvEcXphQx8shBlGk=
X-Google-Smtp-Source: AGHT+IHKUmFTlJlS488fjeGCyxmy728lgg3HbhLTJYyWpR7aP0o43Y/7GdzMIdEqqfoalzFAPGEA/w==
X-Received: by 2002:a05:6602:7218:b0:85b:5564:2d51 with SMTP id ca18e2360f4ac-85e2cc52346mr1871960339f.11.1742926587923;
        Tue, 25 Mar 2025 11:16:27 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:8152:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bc273a1sm224670139f.18.2025.03.25.11.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:16:26 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-ima-devel@lists.sourceforge.net,
	linux-integrity@vger.kernel.org,
	linux-ima-user@lists.sourceforge.net,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudfalre.com,
	Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH] ima: process_measurement() needlessly takes inode_lock() on MAY_READ
Date: Tue, 25 Mar 2025 13:15:03 -0500
Message-ID: <20250325181616.79540-2-fred@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On IMA policy update, if a measure rule exists in the policy,
IMA_MEASURE is set for ima_policy_flags which makes the violation_check
variable always true. Coupled with a no-action on MAY_READ for a
FILE_CHECK call, we're always taking the inode_lock().

This becomes a performance problem for extremely heavy read-only workloads.
Therefore, prevent this only in the case there's no action to be taken.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
Changes since v1:
- Add MAY_WRITE && action check to violation_check to avoid MAY_READ
  only situations
---
 security/integrity/ima/ima_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9b87556b03a7..11a91d9dae48 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -237,7 +237,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				&allowed_algos);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
-			   (ima_policy_flag & IMA_MEASURE));
+			   (ima_policy_flag & IMA_MEASURE) &&
+			   ((action & IMA_MEASURE) || (mask & MAY_WRITE)));
 	if (!action && !violation_check)
 		return 0;
 
-- 
2.43.0


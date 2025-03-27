Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C48481741
	for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743091769; cv=none; b=sKHvbuhbGxwGkgQG9sBNRW1UJ+h+klX1ZCImD11edLvCu1dme8NaB34F0275AMRD7pn5AiU5kBAYrvLi7XF9TEZ3yEoU5heATAOQm0tDwA+Ygm15XgjarQInSI6/kP6E0zkT3drhMlzQSE/Sf2/a4RzlDp1EZVn9bEhxH7BK2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743091769; c=relaxed/simple;
	bh=Iv1t8vhll1NnfJAVcvohsPup3KoMa8DNYAHImENq+hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAjwqB4129z0vaE8cJbr+H3EzzNiPG6hgOvBgceTHYyDdaPQGDMS4d5EzTMSL/V2fn18QaX2wox1JF2OYKEepP/TC0DdoSMJXM6wFBBCIfUaM6DXqGS7sowZ/NvYYBRFCTwfsShpJ3afHNCu/0InQvEhKtI5kyYKF5q/fU4ioBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T1QWWaMg; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T1QWWaMg"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85e1b1f08a5so33102339f.2
        for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1743091767; x=1743696567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lc9tpoqy6nWDYPuOoCnxwnYnaP2wtDpP4dKKDjWcgOM=;
        b=T1QWWaMg861Yv9Jw3i3+lACFSA3Qz3b5nG8s0Ze5Fmc5zuzynrs/1ZIMVErAfvuE8R
         Y6ShHmLkiSJ8VitH1BSIWLgNI/f7ZBqTrjHC78/owDZ9iTAsWlh/3CMNKkDC77xdxR4S
         Ls11a8f3CuTCVJh2usKWn4hV2b62nuKKxhu6C6aMAOgYGe+vL5P+bHxn6FqX2O1eEvuN
         40I44yXX26RCHcjNmpY6S9TgxOYWLM2dOX+b3cLqdqrgCNQq3kiesf87YyvJo0O44a6/
         deXJz0G1W2l5Q0URaedxSgNyrT/tcVY4DmONC6aWvjaLgLCUDNaoXvHPanV8k+GgrEYv
         X3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743091767; x=1743696567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lc9tpoqy6nWDYPuOoCnxwnYnaP2wtDpP4dKKDjWcgOM=;
        b=ThmM0RlGqTFuUAlJrmsj/JNsnilwWJo0egT0/lWo02K4AE9eE24CsvsLMSIkgM9vQj
         EA8y+E3LaerCMyjJkpR05J6SA0vvgbOmQP3JzPEh3tW28elpBkvSlCBuGzcANWnl3uPg
         rnPKH0LVS1zL3nUnKiejfJf2iemxmZGT9F4a3dHGKpAGP9QsBs7PjcubdsJqrGyENofH
         o2TrH6Dm+6XL6PcmJhjOHUonR3Obj+LdV/B5hRHPCfP4dyJdSUSXYwcQwFFA5iFd9P7T
         q6deuywADZ0ZtWDoYA3bTFbqTcQs7iyN2A4oacAWKoMF/3LwL533HSZZtFSzVAcUnVES
         UH4g==
X-Forwarded-Encrypted: i=1; AJvYcCV0bprdJg32GAE0ZRC9Ic8FlLF2v4nX0uOcqdlPAKVrI2/lLSayswVxs+3c0xxq+87177Xb074nAWtONDRhT2DPas+/17Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEKlkfPOk1d4p/CR6C+Pb8tG0sZziTCO9PmLKzntQFRzFjdKQW
	+D+jmhp5xP8jDZOGMNUxIFDo/2e8PmkpX/isUcCgTfIQuEZlNrfs1Rj88HEpEpA=
X-Gm-Gg: ASbGncsIxQ2nqrppltb1nIoA3FQwxJTX7LxdA1KLxLyZvnu6STNMq+zr9DYlbqL8DAM
	RJtZltiXDgXtg5RhwLiKRMnvTqt87IvmUWUw+r8H3OTa2eqgBAufJra4U2rpJxoWXWtLMmXwgLS
	5cIidR91nZKjcsm/FhlhSrIQdrsXkcqDwM+1ppjEWYSmwBx19+HztNcPLU07T6VFX1DTohLLl0y
	Ssr5EJ4eyIeXKTAO4zJcMf7fO7H1nucSaiI/JQ08Md1SYbe4N4fDuLoWRurPQ//EXyRqfNW7bIY
	as1ovIrI7PxccyefGj23VMPBx88NF5IlHO5WhiE=
X-Google-Smtp-Source: AGHT+IFIyIjqN7KRfbbaU5gWpkJAPN98hiWDLVUjmx28XhdIkaVpn/ZdT5fnt+0q+a+MgIWRytnq6A==
X-Received: by 2002:a05:6602:3798:b0:85d:f74b:f8a8 with SMTP id ca18e2360f4ac-85e820551afmr551444139f.2.1743091766522;
        Thu, 27 Mar 2025 09:09:26 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:8152:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e8ff7f50asm1804639f.9.2025.03.27.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 09:09:25 -0700 (PDT)
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
Subject: [PATCH v3] ima: process_measurement() needlessly takes inode_lock() on MAY_READ
Date: Thu, 27 Mar 2025 11:09:11 -0500
Message-ID: <20250327160916.279090-1-fred@cloudflare.com>
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
Changes since v2:
- s/mask & MAY_WRITE/file->f_mode & FMODE_WRITE/

Changes since v1:
- Add MAY_WRITE && action check to violation_check to avoid MAY_READ
  only situations
---
 security/integrity/ima/ima_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9b87556b03a7..bc453f5a7531 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -237,7 +237,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				&allowed_algos);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
-			   (ima_policy_flag & IMA_MEASURE));
+			   (ima_policy_flag & IMA_MEASURE) &&
+			   ((action & IMA_MEASURE) ||
+			    (file->f_mode & FMODE_WRITE)));
 	if (!action && !violation_check)
 		return 0;
 
-- 
2.43.0


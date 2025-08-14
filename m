Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BCB27BF89
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755208801; cv=none; b=e3FwqqhL9w7QoUHQF7XR5rhDk+ZoteQja7DAC0L8muljrHZC/bQxW6FtJl6QHNykeZ47bXhpiigl0bylWqQV2y6xZ9/LWFyCqfV9ug0CuWERR1wcTb8m+dHgPqYtdPGSaNqXXuTU/+t09eCQWXm22ehfB3MydYi28W9WOWJYsH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755208801; c=relaxed/simple;
	bh=gCxuPFdwajuBLyN5+NCXl38z3U6lEaYYcZPsFhWFPSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPy4U/asBZteK7wBFBBXlSgzEEr4hk3R+Xpg8nWEgMCW0eBD1ySQdI8gPyIn2/hd8aZBw5c+Wn6r05VFldBz3qU5tsNryBStvBn0UN3YiXXXu50DWHe6wKKQKICinR1X/Y17+cib8yQMRRSjNZ8KnahG2t9v1xxoWSZ4G5LxwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ekg/e1eZ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ekg/e1eZ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e87036b8aeso175924885a.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755208797; x=1755813597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JDOT8g2/hpEQdfjh58uqpdtWtw5vHa82i2koXzTdb8=;
        b=ekg/e1eZ0UbdkqGZ34JLfbCJSdmaC4CF3AgB+MoKu4Vm7lDrs15Z5J78AeEjwmauF3
         ++xFZDYQBwIAx9Na2b+ROSvzd7qbl8mwLELHvV+ljHSKqib5viiwWvP8aLm5Bb3WKM7O
         y0oF2LXo0xwSRxOW94qtp6AmntvfqRMNcx3DMoJo2y8IgEpwTRFBQf9zuWJvJAJ+XDld
         ylzMT11con08JFG1hX0Jy90mkQilc4PjiI8FvoxQjQoFiq75qU7EPMJMAV2d8hYNgE3d
         WPNT+Oh+iK56GXf2AZLDih61FPZa+4D+6KuVD0bTACI7lGi1j3V35GiiqbsWEaJY+Udx
         vXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755208797; x=1755813597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JDOT8g2/hpEQdfjh58uqpdtWtw5vHa82i2koXzTdb8=;
        b=B9/SJjC6bG70gpdZmgtevvCznhueJL6+Z5yKv8XdwaSoY2hz76A5EFKWhomtLweDu4
         lr1yMbnJOFwRYKnByZRCl3m528faZU1ZbYlonh0FDWHZYrFYkGsRG6kDkxRh1d3Tn3Tq
         2sEmaSXESrulzVsJ9rZNP/aLaFsseb6DmDJ1ZKiN9qWGy5hdExnuhSJv3KGhkt0JFCBS
         9OSDMNMKPx1ruubK/Pv6DRvhBp07F6ovMjWeLh+gZkmfpaCy3kQe3KxmDBnj3IEL0zVQ
         D7QUXqbIWmvApGupRDWfzrJLC45xMgFf0fQkIrnDCG9BtyjDhmLCy4yghVd83ChpADe5
         J83A==
X-Gm-Message-State: AOJu0Yyy4PMYSa8vqauQ9/9RPVhhm8MtIT3n1zVJ3YFjvCsTcGLN1uCe
	4iFD2xBmJhjOrYJOeAvl2n6v4mrte7XsjiDC5zVif/j8VEIe5NdcMmzL9PzF4zOtqURj9EqZ+Xq
	8BRo=
X-Gm-Gg: ASbGncsD/HrgJ5ev3vlNf42zVs+1hqMod/q9oJbVAG44HJpz+GynjS/2McPOrvUx9St
	m7hgkRl2rSY6y2lkIP8MZUXUAxyS4rLYssE2BfMDPoDa3ioYeKj7gctEuVRiAbg4qI9pQ10XRpc
	CSaeDHJajq1fpRZLgoL2cAe+xGugBFH3kygJmU0ua4Fh1bQ1x2VIGcFk2e4n8ka8CRdQDTRVybQ
	1sQ/Dc65zbDUzj4LFSvMrV6R+xSGpZeq82bFZZC65QvRoIIL39rwdcO3F4ahjlMET2w9j+kjTNv
	gskMlloda1QPvuwPA5/3IPRcY+l88O2JMXeQ4VsRwYp2502an22UKYoRAXwgCIIqxosTpRSa4vA
	mWzFUzgfq4CWvvTP33O9ajoUn0zbpjCm9fPwl/6alT22jiFlegh4G4Q7jKTFQ9YwsztQ=
X-Google-Smtp-Source: AGHT+IHGHty2BamajrPCFb5u4xJcYr8WSwUJmHniFDqGtkXy9aZWC7uCqeshVqBMuxpVh7sUM7gM8w==
X-Received: by 2002:a05:620a:25ce:b0:7e8:26c7:4f9c with SMTP id af79cd13be357-7e87bcbd365mr98007585a.6.1755208797485;
        Thu, 14 Aug 2025 14:59:57 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b4bd651sm35792185a.39.2025.08.14.14.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 14:59:56 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Cc: Benno Lossin <lossin@kernel.org>
Subject: [PATCH] MAINTAINERS: add the associated Rust helper to the LSM section
Date: Thu, 14 Aug 2025 17:59:53 -0400
Message-ID: <20250814215952.238316-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=506; i=paul@paul-moore.com; h=from:subject; bh=gCxuPFdwajuBLyN5+NCXl38z3U6lEaYYcZPsFhWFPSI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonlxYV4RT0lffveOWjtx7EXnxDrEmNhu5G/Hok 8+g/C6QQrWJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5cWAAKCRDqIPLalzeJ c+H7EACW7s2lGhP4Xyji570s9SWXwHShalH31cRlXLpJR1NsjkHn6DLlWrAQZUqV/WOVg3yiYLj BT24sR54FkqaC6U5esIS3mzv3S68FpzbhAj3VYZRsmJK1wGOZAi3A91g+BUFd/htUuShqM55qHb oLqLmMsh8Yj1q7YyE3qRLmRvTRYyJS1C5XK5ca5JUAt1zCfm2MnSlhbbM4dFnRbEg3Hc6JUlvck mODrYlPBPbFSOxgq15er1XRCBkZOYOzVDPu6H/vevk/GJ3c6/eF5TbAwOb4dYaX9lLquJuWoKQc mHmsvvTuno2Dt08mbfRoNN0zXwVX47G8+Oxvuv1xs0NqFm7FJbfumM5S0oLx2qaXsUtBIAgiEle wevaUqul92c0+Dnuh5mfWd3l3IrjjAHAN2oxSdxRnRzWGNak9BmkaNt8KeP0lImzJehVtTPGrbe 8rSyjGyvbWa1NdZaokyiUR9Ckio9Kh5707nCQ12AAK/nZDq5GxqJ2RVaOUZ4RYPlU+Rrm6bL93U zY7yR2c2FJxR+2DGAtkbTAIJ1lSCjBNtK/gKejQ1SHOLEHrmNtNG6OsjWBNDZo35Fn4H2xzor4A p5mOB3yYnUC0vZIWHQFKKVZYHl/uSWlw+rR7IF1YtI9BdGOGqJ8PSMwy8FiqdmQKrUSWEcaXfjS NlW4d8xY09clv2w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..d61f7246e5bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22790,6 +22790,7 @@ F:	include/linux/security.h
 F:	include/uapi/linux/lsm.h
 F:	security/
 F:	tools/testing/selftests/lsm/
+F:	rust/kernel/security.rs
 X:	security/selinux/
 K:	\bsecurity_[a-z_0-9]\+\b
 
-- 
2.50.1


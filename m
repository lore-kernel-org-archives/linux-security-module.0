Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A42248A8
	for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616672; cv=none; b=ID1eNWYV5j4s5koqrIdnEOk4LFC7j8EFmLGsA0uMppf7Qn+dbftKSz5Q+j4mBCVXVs0Vgbsf9sr+swujh6DAgMPVZuT1Rmu0hHM7qpv8xCWgY4+NZb0dq6aqKpvGcdMKXPMr/0MSx7DcSsI5XC0o5LyDtp/SkBEJT9gLopXK2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616672; c=relaxed/simple;
	bh=X/I4V5U5eDHByaXXdO7FtCf2PdP6uXLwFT6sacY+Ky8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edg1SOO7TQ8+p+7gko8lQSue8BHN0RY7Iz/M/aqThoTXmsahWAMEb0xCFJelCH85Seh5WhZAOi+TkZydElJEC7aKV+YYzSZqpfViSldfewZMJxyoLDFWfUePXVaQfHnfSEQd1AHIWIosEh1i9Ylr4Om5QjDMy/HtrwhXS8T++XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQZYx7W4; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQZYx7W4"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8efefec89so35444266d6.3
        for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741616670; x=1742221470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DGyhZ0wVbFwVAAwOC5dQb/mRbEjhspOaf3n4DoeBeKQ=;
        b=OQZYx7W4P5Qqi6ZhE+bTjuJgK+reS513Zs2/b3xU5nakan/l7YMM08QR6L4BLciqjm
         gIWVc5HxMDnqs6nmDQD7GbAan3epR//6SZ9QeXru4QZbAb2//hwkWDeYX8yBExvPPL7O
         qA4a9xSDYgO70xmiogeW+7HITAw6xh7MHmap7MhYJs5G4Iqm0GdLb9fvthM0Ayz/d+cw
         wwg0wNEZ1aJEDRoUio+D8lS8NLXoQ9QT+oj3uJcSFHJiWsOGDMqp+Ch3DYEdx3QXCCx/
         /i6RV5cA02XmQTaFQ8NxQVJuc0fB4Vd7BwcTc3E1dfzHxTdCSEuq3dTOqO+1rxarp1gu
         1CAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616670; x=1742221470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGyhZ0wVbFwVAAwOC5dQb/mRbEjhspOaf3n4DoeBeKQ=;
        b=J/8SVPmzHH2qRQp22Fyx3tBL3Fv8bc0mHXvMzRBh0xfZ1bqSfl5ixD9uU8K8gA7xR8
         ErY/u2ktnwmP9Eo+YTt2MRvYNp7BVjAVQhaL2fO+rcPqhSfVLr1d1L8260FcDK6f3xEG
         kzBQsWN81oSuxYZJXazuhC+/fTRtQPnKQ5rFx61hQiaWbjz5uFVisWzam+0UBU2fJDoF
         h3et265G84rX5E5PUiMlPtr5NXfZOSeD+ulbayOZW7wfkisXCrKsyqpNSRAHjRDEolgr
         0M0LCBGW2sgs+E1gvzj/6F1gmOtRPOZZKZnAtbP/XNyRgZ4E4LpxUiNgg/x8V52IBGGy
         tAeA==
X-Gm-Message-State: AOJu0YzLB4S3zbKecHd4zq4TQEGZzxHKt16AGcKrRU9O00kh1i3+Wsgv
	u+fgqCaxgLkSrkB/SzOBPBAavJcztevcjmh4YZ2F2Ov+6RJwHAYtM4vmVA==
X-Gm-Gg: ASbGnctbgSp3e8UV34gCN4KGxrXAimxnUx3qzEUucwBwLYAb2r14AmoxnoCRYNaMq/h
	Ww/Shc5+cxMqfvG+9CyYVt7sJ0XHnkH4iAre5BMSbpVvbmPpEsiUJaVXbOkRF6Huc6WhQbLiTGb
	wOVQhc+KQX74VKR9MkmkHiKgfJQVZu4yn9fQlAXCHaUI1DPnKKvHLgJO38Lu7/tA1wH28YFtFUl
	pOQB3052xTVsvZB4CwNAsYAq+XfBBbYgL12DXBXW8S1IZOho3sE/HD6AVvhivUFu2aOQhl1sjCB
	MTQPzHIBCJEqvjAhjgofna9iSbYYMihmBXJfPeplIqgc4WD0tJ7B/riyjxmiJcsk7QmEkMGCyeC
	sWJLRfmkxvq3oBx+aFT89G4Mm4YMbx6qdOYYKCfSpqtL6Q8bTIRhGOb8ErA==
X-Google-Smtp-Source: AGHT+IGNBBJ26zheCjc0KXmDIgxNsTzUCS9HSXJ//+7GdNJs8f8Q5+KDCFMZNLQsqKh4UZTjXEYUdQ==
X-Received: by 2002:a05:6214:1c48:b0:6e8:c713:31fa with SMTP id 6a1803df08f44-6e9005d45f0mr187936396d6.9.1741616669707;
        Mon, 10 Mar 2025 07:24:29 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f717211dsm57880026d6.107.2025.03.10.07.24.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2025 07:24:29 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	serge@hallyn.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] lsm_audit: remove old email address
Date: Mon, 10 Mar 2025 10:24:10 -0400
Message-ID: <20250310142410.1667-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove my old, no longer functioning, email address from comments.
Could alternatively replace with my current email but seems
redundant with MAINTAINERS and prone to being out of date.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 include/linux/lsm_audit.h | 2 +-
 security/lsm_audit.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index e13d2f947b51..7283bc4cf413 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -5,7 +5,7 @@
  *
  * Author : Etienne BASSET  <etienne.basset@ensta.org>
  *
- * All credits to : Stephen Smalley, <sds@tycho.nsa.gov>
+ * All credits to : Stephen Smalley
  * All BUGS to : Etienne BASSET  <etienne.basset@ensta.org>
  */
 #ifndef _LSM_COMMON_LOGGING_
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 52db886dbba8..d45651eaefa4 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -3,7 +3,7 @@
  * common LSM auditing functions
  *
  * Based on code written for SELinux by :
- *			Stephen Smalley, <sds@tycho.nsa.gov>
+ *			Stephen Smalley
  * 			James Morris <jmorris@redhat.com>
  * Author : Etienne Basset, <etienne.basset@ensta.org>
  */
-- 
2.47.1


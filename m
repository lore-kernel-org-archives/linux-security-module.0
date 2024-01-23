Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15C41742
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jan 2024 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046912; cv=none; b=MYr10DTHesgVRZGS+0etlcpPe42nAI6J3t4QlgAH80GitOCLA/OZ/aqYoXF5Y3crVGmzPy4BF/V7siAEb6pd6ZLzS4QcwLZ4gAupeI7i1cfF7uTbMngm69WwL/RvBVHb5nqpYdDTBvq/FGoEodL+LKo8F741GA+c5UllsptXCO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046912; c=relaxed/simple;
	bh=C7CYzH+xBSmnm8JMUI0gWqSLf8ydb7G+sBRYyUFAD78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9xjEs/w8VDrzztN8/QI7iKsxiqHT/1C3wVVnM4qt9OrLAa+BV2ct+NRBOks1Taj17yDudEjU/UtGtWnaYfKHBZ84Ck2cvqll50rDJWqhzGSlAJp5+/Xwc8XdOmKl7UIADEda2aOx0whYuYJAXVaBNx9JasnYc17pM+wqSVNiJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eWR5/Ay1; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eWR5/Ay1"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4b87d79a7d8so855475e0c.3
        for <linux-security-module@vger.kernel.org>; Tue, 23 Jan 2024 13:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706046908; x=1706651708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b+TXC7Cl8RW7R6tVYRCFEo3eVAAYyrP4TFYZ+SMkqWQ=;
        b=eWR5/Ay14RJdtVv6QdpEOg7cxHHS3y/P4aDE89cJLdwp77p5F20D5pxXPmAfsX+Ip0
         4AdS0rsbrpSOkhQsdLlqUHyXA1TdUGMUfVP/YzhZVAJRWDZhwZ76eyZFsd2AuIrAnoeW
         JSAyzmdaD3zZzMYNKGYqSjjZjaivI7xu09AophSonK0o6kdn4JAUmiYfWZ7y7pBTyI90
         2e68JYS3SuRCvD7qUpGKFs/WmsHMQTOocHhqLOnlJFEu1e3XpZ6tHomSNMj8Hec2+Lwt
         hkJmJHWIp/hwttxz1GWhrMpVE0pzmHEDEVzK5UokZiBu9MW8Eh30zUjd8C5F0RvjA7oC
         GLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046908; x=1706651708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+TXC7Cl8RW7R6tVYRCFEo3eVAAYyrP4TFYZ+SMkqWQ=;
        b=Ray8z3gsVeCDTCbxBxSk3mvRoEd3t1K5uXCyDl9toskZgxUP/y6W7Snrrz5M3wsCs9
         GnQNTSCFP5v2QyKiVyuYFL+HevSiaC7Ie4ggfw491+dzhYHGjzjiqrO26Guh0jJVunVa
         EYFDwVpbryY3JdY58fmKGYs26ZJb7uUBhGQVwvfpvga/eoF8Qfwou20ciMprDl20q6on
         /j3VxSI/98MjQ5fDChcqzHHTstDrrcCUL1/xNu16HlTY4UqqaXk6xAzs52yiHEoQyoaT
         BTbyTiT1hEbIzCY22TqdNs5oEmTAJb7n6lIRx6q7l8t4nQMBFD1huI/Jo97EyfScqqDI
         KofQ==
X-Gm-Message-State: AOJu0YwcwAdrcPItNPHDzXV5a75decQuEHvWGrSn7A1IO1HxGgiy0ZrA
	mjkv26m2lSDN6XQ3tVvLe5iNGKwTirFYM/7BiLNtaIT4lL7YvAnsTNhJnrJqLw==
X-Google-Smtp-Source: AGHT+IHENJcaOYD/BjnI4SGPEEQJpeJSGQ80ajTMAxZDFVY5z1j4z/4pPo4EsxQlBeCXpjC5Ohq6Iw==
X-Received: by 2002:a05:6122:46a9:b0:4bd:5cd7:ed61 with SMTP id di41-20020a05612246a900b004bd5cd7ed61mr290859vkb.13.1706046908257;
        Tue, 23 Jan 2024 13:55:08 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id sq9-20020a05620a4ac900b0078322b61e88sm3446592qkn.78.2024.01.23.13.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:55:08 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: io-uring@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	audit@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: enable audit and restrict cred override for IORING_OP_FIXED_FD_INSTALL
Date: Tue, 23 Jan 2024 16:55:02 -0500
Message-ID: <20240123215501.289566-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489; i=paul@paul-moore.com; h=from:subject; bh=C7CYzH+xBSmnm8JMUI0gWqSLf8ydb7G+sBRYyUFAD78=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlsDW1WF6BaX5WOEzusgRno3YFlZoCzyanmrpVE hajSmWN3XyJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZbA1tQAKCRDqIPLalzeJ c70tD/9E+YEUzwQqLqdfNoOjtAonOXUS+ug1BCbir99Tq7hcZRiFnMtCUE+eQWUU9ZhJ0Mr4FER ii2b3PHs2yfF6BEJ2LOmItz4Z19z2xZBKetiaid/YwTZt5BRbe/Toz9rN8mzhWBIdJv96PidL0Y BdBCXjps8TS0Ya8AFJO4wXs2AfbjqQezBSS+t1HLn+lNj3QRdT6lEDIESzOb30tm9fcHWmRj/ak EhvNUqSMZ1Txlx9jValm+9/lAdyucwfBFw1+DmDi9Ubx7v8rmHXGG0yy2R6Ehnf+aZkQDVh8IcD 0rIhLjpk0pVquJMo7Ae77aPyFoAv1w8zi8To9vOq5bOaKpHwxQoKU5RYVavjZs7PMN0DvIoZNmd 1yhfFvp1YlKrx/w07a4yV4Yde708KjBOE1NUuCBXjspglvKfxzJGy8RRLhD03EcPGv6gJgQ9A86 4xjHeI5U/t70BKwnqC9kRl13BWSMdwJPFAzfcUJLBp2sInpbpxZ16kQG7Op7snyCprNHAcqME5c JDtQb3JrZr32wnfIQ5iPfAAKFtLl+JsQ5D4EW9iZx2Y4yalWBHY1lwrpDR+KAQo1tfxvcP6DNfD i5/dmVPvqcupwHLdxwZYqu84iXO50IX5PVPpD7QNlThfI1vhnv/Sh3ls0qk8brKqgZX0pQlQ8oa 8GFfeccE+6c1lSA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

We need to correct some aspects of the IORING_OP_FIXED_FD_INSTALL
command to take into account the security implications of making an
io_uring-private file descriptor generally accessible to a userspace
task.

The first change in this patch is to enable auditing of the FD_INSTALL
operation as installing a file descriptor into a task's file descriptor
table is a security relevant operation and something that admins/users
may want to audit.

The second change is to disable the io_uring credential override
functionality, also known as io_uring "personalities", in the
FD_INSTALL command.  The credential override in FD_INSTALL is
particularly problematic as it affects the credentials used in the
security_file_receive() LSM hook.  If a task were to request a
credential override via REQ_F_CREDS on a FD_INSTALL operation, the LSM
would incorrectly check to see if the overridden credentials of the
io_uring were able to "receive" the file as opposed to the task's
credentials.  After discussions upstream, it's difficult to imagine a
use case where we would want to allow a credential override on a
FD_INSTALL operation so we are simply going to block REQ_F_CREDS on
IORING_OP_FIXED_FD_INSTALL operations.

Fixes: dc18b89ab113 ("io_uring/openclose: add support for IORING_OP_FIXED_FD_INSTALL")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 io_uring/opdef.c     | 1 -
 io_uring/openclose.c | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 6705634e5f52..b1ee3a9c3807 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -471,7 +471,6 @@ const struct io_issue_def io_issue_defs[] = {
 	},
 	[IORING_OP_FIXED_FD_INSTALL] = {
 		.needs_file		= 1,
-		.audit_skip		= 1,
 		.prep			= io_install_fixed_fd_prep,
 		.issue			= io_install_fixed_fd,
 	},
diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index 0fe0dd305546..e3357dfa14ca 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -277,6 +277,10 @@ int io_install_fixed_fd_prep(struct io_kiocb *req, const struct io_uring_sqe *sq
 	if (flags & ~IORING_FIXED_FD_NO_CLOEXEC)
 		return -EINVAL;
 
+	/* ensure the task's creds are used when installing/receiving fds */
+	if (req->flags & REQ_F_CREDS)
+		return -EPERM;
+
 	/* default to O_CLOEXEC, disable if IORING_FIXED_FD_NO_CLOEXEC is set */
 	ifi = io_kiocb_to_cmd(req, struct io_fixed_install);
 	ifi->o_flags = O_CLOEXEC;
-- 
2.43.0


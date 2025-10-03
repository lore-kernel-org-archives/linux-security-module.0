Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D91F4C8E
	for <linux-security-module@vger.kernel.org>; Fri,  3 Oct 2025 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518704; cv=none; b=f/j/50emnhfDmTaicM8y4S49rOHMXNY/8RAXzcNf0qCVj3+/d/IKg0NXBh2ZT1K1sXGidBrMqkyyE4BxrrWOnvgcoc1vbhZL935Xfv6DvumjNavt1d1PraYkGtkfC1Ni2sQKN9LrRSR9H+ffymFi8MQ8mVFSeTci8xqlxUz/G98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518704; c=relaxed/simple;
	bh=qNhI4fozkv8fv/lAwki7sY08xD4XO8qRaqdADN66AB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQpJodwwdEbTI5Jt2OjvTjeYqvwq0XWVe1sNzOSQXhNbTQ+PSFtLO2I7OXfCEEI+zGYQK2UwUrd0MehPbNzs8PUsS3LJn6pw1Gfw5SmazSJ9AkQWuzLpG6lWojLUIf+58dpzrAFFOHqs8AYmcizAiv2ljd9Hxt3SXtZ1ltBX7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXBoJdwy; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXBoJdwy"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e06163d9e9so25796921cf.3
        for <linux-security-module@vger.kernel.org>; Fri, 03 Oct 2025 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759518698; x=1760123498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ReEFQvzA0ptpzhP/wKLfBOmz+qA+6kGtcka0Y6onfCY=;
        b=OXBoJdwyDlWMdK1a961ECoFByUwiUT/KLBKxv0ZtjHNl79yVg3pD52MVgzYGrFxHDW
         Z6JM79wCZOVBQiJzeyW51aEd0/TYrZrL9knu0Zd/JJ0DQsyh8ERYoA8BQMqEC3BLG6X3
         OA0LQbfq8VZTJz+xHi0Hxeq5049qSesodGqe0MafVHnvLe92A/Jldt+t01REwOib16Iw
         gsk21g6aBUUfDYoHvxmvuoIqNbjb+JntzIxnSqY5noxz5V4wAJxrdoD4BmsHo7QOU0SH
         cNamGwofGdUAwLx+GIQsSSbi1d+/CLRVTWpOlMeiDZ7kpBnfyuz3nzMs/xrKAkhYLSsc
         hheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759518698; x=1760123498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReEFQvzA0ptpzhP/wKLfBOmz+qA+6kGtcka0Y6onfCY=;
        b=HCLAs98IWO8ZiETpYgBxIC/kgbWD+wMe0ccIgprv+db9B7rquu16+BWnX0GPvMB9E5
         ztPJEAoRmlsvaEtdt71AorWNjM7Rjs6x/EFSUNZV+KdM6FuAueYW+Y6Dwnhft4x7SI8s
         IK2IHEn/arn/tJ4+0uPU6VW4WluspnkokhynbzYOcG8hkV8Al4sPgZOjPVf3qWL21dfQ
         2QrgIWhY3cp/PrDj2insWhSSx8Vsm67v2VllUrrYGnft/Z8pT10RTgcJuMyt1quIo/YN
         oNHAx7lF6qt8cSgMyJNo01cMIswahsqBqzw58D0hCXvuSh78mlhUlxT6fmcdNnuawcRi
         KymA==
X-Gm-Message-State: AOJu0YwOKYGNEI6DlrKkDz0nmCDwOO6lM07ZpoTcmIi87d6UpDV5FU1j
	OJ3tNdtOE0N+HxtGeq0Z3EaNQSnsNyqymtSGOhWSu/2IwIj8gnPe3dnR
X-Gm-Gg: ASbGncsnjdKjZzFTe4Rk6D98hFp2BUr+pyf+4/HtTM4ONneMRaVsz7elwTq4B55s7uN
	upWY8hLPqHn3/Cn21E8klWHUzUksyCoybDMN9Pg9IEZ5bmuAJ+7/3kgXH/LQEXktP0YfaA6mFhK
	f+Uhxd+2PnIwM3j0GmrP9FyFOmF6GloZDNAlcD6xVLHxuWJfO9sL9b8pqbxoJWeEejEF0QNCG8y
	wwd0lX4AYm84qPfeEmnX9HikZs7SYMM4UlSImzNG0vfiww/05WsuYNpM6l29zuoYDLEIdfbyXvF
	vkQ5UXyTcPAfZdmdIXfoc0TEkZdK6/R9Ygq+qpSzE4Yz4GnUYzy9SRz96wzjk9mn50N7n0tsLES
	YXoHOAXieG3s7DyLjXhD9gNOAZKhSkZxPvpy/lAOVegiTQA7ssN1GsrNtMETie8QqYHFmL0V2gw
	Nut+UmZRRxJM0UoOKjEDl6P03qkJzqF5sk2mCe6VuSkD79q3ZA1a0mr3D7jQXVGluvnuNyN4ZJ8
	1o=
X-Google-Smtp-Source: AGHT+IEpaRGWG0AE0nbyt0iFzIe6GNXbyGNAl6pbmFlWyLhGrIG6sAvUMUV/AAhdpb0nTbdnc1CI9g==
X-Received: by 2002:a05:622a:4d0e:b0:4dc:cb40:7078 with SMTP id d75a77b69052e-4e576a3c704mr59562151cf.19.1759518697529;
        Fri, 03 Oct 2025 12:11:37 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55c9e79f1sm44631881cf.28.2025.10.03.12.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:11:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	john.johansen@canonical.com,
	casey@schaufler-ca.com,
	serge@hallyn.com,
	corbet@lwn.net,
	jmorris@namei.org,
	linux-doc@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] lsm,uapi: introduce LSM_ATTR_UNSHARE
Date: Fri,  3 Oct 2025 15:10:00 -0400
Message-ID: <20251003190959.3288-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This defines a new LSM_ATTR_UNSHARE attribute for the
lsm_set_self_attr(2) and lsm_get_self_attr(2) system calls. When
passed to lsm_set_self_attr(2), the LSM-specific namespace for the
specified LSM id is immediately unshared in a similar manner to the
unshare(2) system call for other Linux namespaces. When passed to
lsm_get_self_attr(2), ctx->ctx_len is set to 1 and ctx->ctx[0] is set
to a boolean (0 or 1) that indicates whether the LSM-specific
namespace for the specified LSM id has been unshared and not yet fully
initialized (e.g. no policy yet loaded).

Link: https://lore.kernel.org/selinux/CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 Documentation/userspace-api/lsm.rst | 11 +++++++++++
 include/uapi/linux/lsm.h            |  1 +
 2 files changed, 12 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index a76da373841b..1134629863cf 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -48,6 +48,17 @@ creating socket objects.
 The proc filesystem provides this value in ``/proc/self/attr/sockcreate``.
 This is supported by the SELinux security module.
 
+``LSM_ATTR_UNSHARE`` is used to unshare the LSM-specific namespace for
+the process.
+When passed to ``lsm_set_self_attr(2)``, the LSM-specific namespace
+for the specified LSM id is immediately unshared in a similar manner
+to the ``unshare(2)`` system call for other Linux namespaces. When
+passed to ``lsm_get_self_attr(2)``, ``ctx->ctx_len`` is set to ``1``
+and ``ctx->ctx[0]`` is set to a boolean (``0`` or ``1``) that
+indicates whether the LSM-specific namespace for the specified LSM id
+has been unshared and not yet fully initialized (e.g. no policy yet
+loaded).
+
 Kernel interface
 ================
 
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 938593dfd5da..fb1b4a8aa639 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -83,6 +83,7 @@ struct lsm_ctx {
 #define LSM_ATTR_KEYCREATE	103
 #define LSM_ATTR_PREV		104
 #define LSM_ATTR_SOCKCREATE	105
+#define LSM_ATTR_UNSHARE	106
 
 /*
  * LSM_FLAG_XXX definitions identify special handling instructions
-- 
2.51.0


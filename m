Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF515217E
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339688; cv=none; b=AMbGDTlcA3D90QTYyZ3GBJewCYQSwEDl8uhjsCZ0Fzmkp03pR+JKGIMNWNiHe3QetbJuqfdhC5x418bSjPP2ty4Nbz9fNzGkiutuKn3qC5CocXcqalNc9+keh0svoPlBeUVgV2RWP1g26MhXHsmdrxv/MXkaxYl6SFfrgSq2gA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339688; c=relaxed/simple;
	bh=OEhYNA0WyI1Z7Y6E5Hjxx2MkV8hSFQqTqJGkXxhYWrY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CyeoT70Gcg3DrIYXKyHile5aQHwqc9njjlSJTQvw/gPlVPC3HszoZnoutkhkRqti4xbctkGMIGtwK8PFmMkOXqiVoSdyYk1fVIBuvf/pOpXC+bFgt+vdFbFeLVmUPFxTI0LePLkkz6RBfpDVkcXEdfM5EopPISswclBIWNrt2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=edyrHwkB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edyrHwkB"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61beaa137acso225164047b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339686; x=1716944486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CKnAn2dTa+C7mVsFNdLeReq6XnLpu/yCbmMKU/FzkI=;
        b=edyrHwkBHqAYWheBe+Iq31ot6NwiX1fDlDLGdPwVD0uBkdpP07JBvgMMP2FOq4VfgL
         gowXAJqhi42a7Qa4pyJgCWQWamkCrzgtIe2Aw/eH80EahTws53OzmagbjKRHcEuUMwkJ
         4KDajT9pHoDiQROE8BhUxivruXDs96MWX7qJvQlRoYr3DgSxIus/6/+AvpvhjeqFcyKD
         PKueWp/uaiZhfre9i7iV5wnBI/6CZWwM6BwN6JSWY9XOqqfphV8MxHRpQaktPuM9eKSM
         G3SPxQ+dvgY1vajl/+EX7FU6/OcVzKzVKQczV1AK3idQyS9Lnmmv3x1RlAYoc9h/HGoy
         oiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339686; x=1716944486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CKnAn2dTa+C7mVsFNdLeReq6XnLpu/yCbmMKU/FzkI=;
        b=rvlYoPjZwnxY4Jf9p5KuNcZHUGQGlDyLtQKDkcVE6vhF9iXAiZrtTs90SYCjKZG93W
         5ASru+9/BoVleH3AkufnBIHxit7EsetYoHBuM9uujeji3Om5My15pwH48uFcUuwO3V/K
         ZKeUOnZvR8YQ5+BoYhSr3rD9IaTiM4YhVKo9rbsPJD4/KyTiHoThgKRIqb6Li78459NY
         dVhDvXzwewwkFliS/slntsZDxJHMv4TLijtcKlFCer9aRuyWo0OKFbEGvYDKtqYDCTZL
         xfB4XJ2RubsWjw0YUwszz/nTZigt4/+5LGFbWJGeiWH6Wnq3nFMms0nneCnd7p5bKe8b
         r8Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWU+2CU+5JAfENXOeksU5tjFYGcsuxtNgzbK6NUTLWczzGkYJyI2AHbgSbyVRYarJab/NrsM9pxSpYvDitJxdh06X01khJEm6gFtLJNvlR1OSBuWABk
X-Gm-Message-State: AOJu0YwMmY5/D7syXFgotFEKe0ntdCBGSk5JCWnMEJmVbU3FFIrYl2cl
	u7C6df2MaGyWupTBoFdf98zwadgMCudFk/+plA71Uir92AucNiLiRFbqgOd330zZg+wjljNatrj
	mQQ==
X-Google-Smtp-Source: AGHT+IEl0cJvO4b6yqb1eRVPUMmZua49b0zW20Ko2luMd4dbYyTTwbryVnAUNZaV8WFB2p44rBWO2LcSGkY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a81:918f:0:b0:61b:e524:f91a with SMTP id
 00721157ae682-627e48c78damr1602947b3.10.1716339686071; Tue, 21 May 2024
 18:01:26 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:25 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-40-edliaw@google.com>
Subject: [PATCH v5 39/68] selftests/openat2: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/openat2/helpers.c            | 2 --
 tools/testing/selftests/openat2/helpers.h            | 1 -
 tools/testing/selftests/openat2/openat2_test.c       | 2 --
 tools/testing/selftests/openat2/rename_attack_test.c | 2 --
 tools/testing/selftests/openat2/resolve_test.c       | 2 --
 5 files changed, 9 deletions(-)

diff --git a/tools/testing/selftests/openat2/helpers.c b/tools/testing/selftests/openat2/helpers.c
index 5074681ffdc9..3658722c889c 100644
--- a/tools/testing/selftests/openat2/helpers.c
+++ b/tools/testing/selftests/openat2/helpers.c
@@ -3,8 +3,6 @@
  * Author: Aleksa Sarai <cyphar@cyphar.com>
  * Copyright (C) 2018-2019 SUSE LLC.
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
index 7056340b9339..ecd20a3d47ee 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -7,7 +7,6 @@
 #ifndef __RESOLVEAT_H__
 #define __RESOLVEAT_H__
 
-#define _GNU_SOURCE
 #include <stdint.h>
 #include <stdbool.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 9024754530b2..51f1a7d16cc9 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -3,8 +3,6 @@
  * Author: Aleksa Sarai <cyphar@cyphar.com>
  * Copyright (C) 2018-2019 SUSE LLC.
  */
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <sched.h>
 #include <sys/stat.h>
diff --git a/tools/testing/selftests/openat2/rename_attack_test.c b/tools/testing/selftests/openat2/rename_attack_test.c
index 0a770728b436..477125eb64e2 100644
--- a/tools/testing/selftests/openat2/rename_attack_test.c
+++ b/tools/testing/selftests/openat2/rename_attack_test.c
@@ -3,8 +3,6 @@
  * Author: Aleksa Sarai <cyphar@cyphar.com>
  * Copyright (C) 2018-2019 SUSE LLC.
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
index bbafad440893..48fa772de13e 100644
--- a/tools/testing/selftests/openat2/resolve_test.c
+++ b/tools/testing/selftests/openat2/resolve_test.c
@@ -3,8 +3,6 @@
  * Author: Aleksa Sarai <cyphar@cyphar.com>
  * Copyright (C) 2018-2019 SUSE LLC.
  */
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <sched.h>
 #include <sys/stat.h>
-- 
2.45.1.288.g0e0cd299f1-goog


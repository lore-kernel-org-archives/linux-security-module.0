Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7412F5AD
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299818; cv=none; b=pUEP36LnzhJr+m0gHOa9WMYutJ4sgpGyPi6r43dND4A/nnykjcnFQMBfOEHBGaIRz9YY3bg21mgibNu+yHTf443gjHvpKaFcTTNhjmmWinzgTbPQJmby/S/80ddV5jpvSCMYq61Hrj2Txz1PPsP1V/YArNijcuIKEWg9B83b5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299818; c=relaxed/simple;
	bh=krFmheiwe+bhOpalC+42tJGQSEuBBbvPVyXoXXo7LPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D1Fqdgic7prPIYXBA0l1OPrKeVliYWWoBAGKFVlnIlRVNqbHOsI1pnXe3MMikYXBF5XUxE2T0nLJWCrnl/7aiFVZ41zd1vrCKonaCAXVWbUuIye+QArVO/x45f/K25ByByLPRR05jdY1gBo6QINp2ZkwfSRjT6n+v3FFV0+Eoyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ECzZeLfH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECzZeLfH"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b4330e5119so1234190a91.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299816; x=1715904616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCYOcoi79dGlWA0zgP2ejSPuqCPcThdX6+6Ym86nj5Q=;
        b=ECzZeLfH6bdfyaVt7HV23vNvjRtthWaR5rDSkD3q1suoOqMzuTM1FueqdSA+Xgp0/s
         rO02TowQpqWRjgyB1N7T/ICLXzlRjN0By/hpqcSf6QuUQzoZevmjwcS5BndovKq0cYxu
         8shDH7iadoXHmsBdaO7JbU4ssdlt4wgLHvnsuMxMNWo/a13hxX1ZxaDYazkfT/Xe13N3
         bAPfHtrGMwrizC43hc5xTtB0POOdbS2Jam2PF+BnAbR2BJNhoMnrL6cWiyBdrf2DhDmK
         5unsR/qJVuHB92PsHHgxfTGpKYmoQwfKNF2qCtrwtv9klvusduBRvkbZw8OZO8ukUOiB
         oVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299816; x=1715904616;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tCYOcoi79dGlWA0zgP2ejSPuqCPcThdX6+6Ym86nj5Q=;
        b=j6YNkiS9kWuWBzdiRhzqFfbm9vNYe7vCtENWusLWYRhAa93uwJ2e9nwwHrwZTu1zOj
         lISWa2dvHr7cT4Z0jZ/CAdzoSU0T8m7muBFXIMcUIy23uvm6E1ohmM83Stra4GIJoc1k
         3jl2iCgPdN3Fj+xbhBR1A0rTfgdp4pG7+xXVT1gx7rDmkPl0WTY+cErYra2PsTYBbYsO
         abb9p6SYUtnvSQodO/l3T1gL5Ay842niWGSutr3yH63LEvoMMMhDub1ZgXyNDoLPF65r
         XIMybNLL9kKV0urb7OOnQ81BOKkL999/Mt0wf8O2XfVZxfF4Q2exr8SPegzL8u9mfjL4
         ezQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHm7cPSeTGn3PUF0YjMpegYvZhqI6+rlNNhmBKqfisCoR2CgRPXcH5mPBYvYpfUs/ZdOcKAUv8wFj6AXckKFTKDnFbfnqfj/SjXBVKSbyGxhQU7NZX
X-Gm-Message-State: AOJu0YzehyKIUNJZie9aw9zZE2guNbEbKUJGX93lI+cOIViv9f2L7kWl
	9fXnGzXEytqmfMzacjx1iLZpx2WsqLokVhHIoFi3m1lNbTF2ypxfC9gD8DvXhAMjWl33JoeXlDK
	1aw==
X-Google-Smtp-Source: AGHT+IF9aZrvH9iVwela8h8gnuxSKtgNwX9HeGP3w0cBXhyQMMnBKIlrQWbDb+A4TrctySesXZTy2+mRcOk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:1850:b0:2b6:208f:a441 with SMTP id
 98e67ed59e1d1-2b6ccd85d53mr3578a91.7.1715299816087; Thu, 09 May 2024 17:10:16
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:43 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-27-edliaw@google.com>
Subject: [PATCH v4 26/66] selftests/lsm: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/lsm/common.c                 | 2 --
 tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 2 --
 tools/testing/selftests/lsm/lsm_list_modules_test.c  | 2 --
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 2 --
 4 files changed, 8 deletions(-)

diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftests=
/lsm/common.c
index 9ad258912646..1b18aac570f1 100644
--- a/tools/testing/selftests/lsm/common.c
+++ b/tools/testing/selftests/lsm/common.c
@@ -4,8 +4,6 @@
  *
  * Copyright =C2=A9 2023 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <fcntl.h>
 #include <string.h>
diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/t=
esting/selftests/lsm/lsm_get_self_attr_test.c
index df215e4aa63f..7465bde3f922 100644
--- a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
@@ -5,8 +5,6 @@
  *
  * Copyright =C2=A9 2022 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <fcntl.h>
 #include <string.h>
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/te=
sting/selftests/lsm/lsm_list_modules_test.c
index 06d24d4679a6..a6b44e25c21f 100644
--- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -5,8 +5,6 @@
  *
  * Copyright =C2=A9 2022 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <string.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/t=
esting/selftests/lsm/lsm_set_self_attr_test.c
index 66dec47e3ca3..110c6a07e74c 100644
--- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
@@ -5,8 +5,6 @@
  *
  * Copyright =C2=A9 2022 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <string.h>
 #include <stdio.h>
--=20
2.45.0.118.g7fe29c98d7-goog


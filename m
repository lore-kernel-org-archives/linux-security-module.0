Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C27136E15
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284908; cv=none; b=NSHU0moa7GeXCgbC19ywsaiAV0EE8h7fN/508L/ct4AVz7J7wUx4kiA/sj+PetcSlh5qmaYkx55ykvqd7jq1PvClvoDnLCnBDuVMEIB2Eh7Xfvnzye2qsGhdgHeLkowBf4AZVJbiQfxo9aJNPpxHQ2ecQjhPF5GMzh0WxmODRjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284908; c=relaxed/simple;
	bh=MaP11PegkI2fiYFPrpE6ug+ZUn5gyTFRDKXD73OrLtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qOiH5OBeP6c7KPf6x7ne8SBpkxywREklhsiCHe7xNxKO19S4aiKPz7mIiIS4cK3arJY2IsSWGpXqMd3+oBT8aowgmyJflFfnZ0pepBZLmRIAmr+ckWuWw8wI8aVqifG7Eul55ktFlQiZpEPIbfsJledisr5eJMtgSypFWf/CE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kMtGw3mW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kMtGw3mW"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ed3b77d45aso12667015ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284905; x=1715889705; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c7i8j1MXR4Q++mSB9x/D+2tDt3WYqeMVgfSlh13oZDs=;
        b=kMtGw3mW/Xn55Yjf4GwcY90bzMRN4xE34LUW2BBtilk+uU4zWdrU9duG4FQ4AiEy61
         SYYbIh+0bt8Yet87liOF3ZAEtgcl2yE/v9JW0OkrMDeUCBORwtnfosxv48vSRXRWpIN4
         D9b6DrJM5t3tsjxy2rBndA5jUdOQbEQ0jhXuoXrx2U59EeTZPq3bRSy2gYDl1M6OAibY
         J7Pmd6xppCTglcqgXT05Bdfv2rpzPPBLfNz5IGPEqbMmqcBFfsVug/UdPE4Nq8GsJdVl
         f+WVT0IPSLyibeVP+HrjXEcSb0ET8Gh10Oz5nkU2YyslJcvbWTRYz97iQFNf9v+XdItZ
         53zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284905; x=1715889705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7i8j1MXR4Q++mSB9x/D+2tDt3WYqeMVgfSlh13oZDs=;
        b=LaTaevyg0CEpxBhj1IcAR26S7rl1eoQOU4XBKXeqxcJ4JxKR/HLFav9//yH3XCtbLY
         pMsYLdVzSDZ4IusmuREes6U1nQk/mEPjQwhw/rBiWT4h0z5Kfv5wQifMZAOGtRCvOd1B
         gGdpu2RTOWbos7fN9oXD5d8fFUS7NVqUmPPSQw6yeippYtWPdNBWdzMsYk3REsg+YWn3
         fJajE0hpmBNMNf0KqM8vG4V+hr4nkk1MDWK4+igX+V2sqaP1pP7jjj3A6BQmMZlBgNU3
         qClQL+iyRf6yN+2M8A8XtaCuQiwdXW9NuX9nbkQYkD3G+PFe2n0OWiulJ/Isk9+/XYsx
         QRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9nD3w9HRFGVzqj1iooc7zmtooRr6nEiItK84p0f3MSsqz5Op741bVfWtgHV8FTqYyQL+qSaPkM8Kc0hH2xAoFj/tJxQtLFGOk3dsJlc0sHtcNJ0zS
X-Gm-Message-State: AOJu0YzMTTsNUkuY/X8FD8Dd/az6igGiiXt/NGNq7C6sx0ZSsoMck+OZ
	dbcDOc+ZAvYVkE9GzU1EzuDTwDMQ8/xAbukUJa/mfcqprBjciGPRacqyPE9WR7ZofXAJv4dLhtC
	RIQ==
X-Google-Smtp-Source: AGHT+IGcE37oFpFHu0r060mrxur25fNVzNH8gnu7DuNW1Ui+yVAdSFNdy04KrcqG/HBH3zmLWEsGkp/XAfc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:c40d:b0:1eb:4c47:3457 with SMTP id
 d9443c01a7336-1ef43c0ffeemr21035ad.1.1715284904004; Thu, 09 May 2024 13:01:44
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:12 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-21-edliaw@google.com>
Subject: [PATCH v3 20/68] selftests/fpu: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/fpu/test_fpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/fpu/test_fpu.c b/tools/testing/selftests/fpu/test_fpu.c
index 200238522a9d..53a7fef839e7 100644
--- a/tools/testing/selftests/fpu/test_fpu.c
+++ b/tools/testing/selftests/fpu/test_fpu.c
@@ -4,8 +4,6 @@
  * module to perform floating point operations in the kernel. The control
  * register value should be independent between kernel and user mode.
  */
-
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
-- 
2.45.0.118.g7fe29c98d7-goog


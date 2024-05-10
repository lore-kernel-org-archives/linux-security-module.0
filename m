Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3588F13B58D
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299883; cv=none; b=CMo2MIdlskc6Yct/f7QIOOdJ3EYGT5ojyWPjGhrIrAtxeWWAf44trImKq2UEibaRJxK3rbJpeehaWHI7KhJt92u1BoGVmdjzDIOjbEdJSZnnD4hXCIeqtcorUrtAfzAz6mdIgPtORVrNS58cB+tYCYY22F2k4Bw7Qgj+rknHois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299883; c=relaxed/simple;
	bh=IyUlAGHuB4F0ACGEqw9XDD1VWDnG6Gr5lWYbpcHYvy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uS1SRgZXHFWtigrCyTYtflMf+aynK3hdd3B/4lEAynqKF/PPv3af8rbTCOzJsdIVJ+NN4q/sv6TtIR9eKQZMgv4J+yWAs+5OWH51JKS1IknxuIlw46PZ5OACXzKotp0eA+Ewo1P+5yPNruWSD82B6c4IGFeSP8uHNXOqQY10G8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3UAtSei; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3UAtSei"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0c296333so30243257b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299881; x=1715904681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=N3UAtSeiPrlt9OW2F0rY6m+iv9lq7dDYhKPowMfiXC0i4M50l9Dq0C9BY4cBKpwwg7
         4g6Mso3wfhFFxAlqDrz2MZQMJX/BVKKsTSO0W12iZ0mWIZagIVaL1MDW33UdTQmbTbE+
         lwyQuyKgkExHf0eOHbu/v+DVpB7mWUq0XdsaAJICDUe9zrvd7cg7OddH7V1tZtlvSHwD
         HKgaAxuHATqOmhoKn76xQshp45Ob9vFkc06thVQ8OpsulnW+BalfUaJQ8pXpEpDV7geb
         suWaXWhKX4tDdAjpjzOtOqlzSVoqjniLl6CS3BH4zRnuPDy/NZmeoCatx+ZfUc/pCvLo
         spTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299881; x=1715904681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=sHBhnvDiRDn9opwZ00xYaNFlHFN14Edy4Q3XQVV9KNiFkws36rS3Vcjba+dYBuG7lK
         CKFXBKaC1dIcSPY9p6oJJsmMFIOymg8YzkDWU51+cbdn99CNVSD1wVLHqgpmhnkAS0JV
         h2taV37WWe2+jEU+kVuo+b4LX33sDbzBRqHFm3ho3oyuxZr5b/ak01HVKrYEn5sH5iVd
         ST21cGZMBE1mtz+vq3twv1FH5p3HwZ+x4QwSg8L3g+edJ/95/YvFrQCOzqmtkJt47Hnh
         gNyIAP1nYs6/l4/FdNvVfCWPtMi4uoshkQ7Y4DcKaXjHeeWiyv6nQ/rDwqyK7VBpFppw
         ufUg==
X-Forwarded-Encrypted: i=1; AJvYcCVNHaQpXhVqfmGzivNXXPOIqllOf1MCYLrTggDqDH+bPoRukuhtvRPnlioEGU6iHYNPA0I3drYNYI9v4IrRWltaHdDKbrKyTg/6dHMEkSaeE7KM1lwy
X-Gm-Message-State: AOJu0YzdlhgQgfMELgvjbpX07Vd+2ftYuSvSsOsiCWL871riWg6eGl+2
	qldwzXKDJdnwXC5mBXbDJHxqjjIJiWt6KQWEKilmmpLzhbd56xK84Dg2XhtzaOB4AP7KUjI47eM
	fXw==
X-Google-Smtp-Source: AGHT+IE/x9wCS8dXfiCveNKLMUww3zuulXyRB+TBegOeq8yRgm7kXDMXOCAjHlMh4xirNEVxhfl/HnwXW8Y=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1004:b0:dbe:d0a9:2be3 with SMTP id
 3f1490d57ef6-dee4e558e2dmr363352276.3.1715299881350; Thu, 09 May 2024
 17:11:21 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:03 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-47-edliaw@google.com>
Subject: [PATCH v4 46/66] selftests/proc: Drop duplicate -D_GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index cd95369254c0..25c34cc9238e 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
-- 
2.45.0.118.g7fe29c98d7-goog


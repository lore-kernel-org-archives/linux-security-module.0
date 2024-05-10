Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB70137750
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299854; cv=none; b=pWAaIi1QkfbWkc+osUH2q39WQ8iyFdauqIHzBGn6P6Mm05vKGC+Pjptloc1bzEuUWZ0rq39xyhGBlZjvpahkNJ7Xbl3KMKm9nAlycXvO3sav+Z3NddxJYnV3HTcNUTrDMSVpm6oxSL/k6eJs36e7biG0G4SMh6DTSkhewM+VrCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299854; c=relaxed/simple;
	bh=pZPIQU6t8knFtwCfwdh1/vCnaaKrP5Vz2eAf1hn6QUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FZgnj4MTxeE6k4pDNmK8VDvv/pkmbPpxDOX6It3tAV6hKS6xr7sX6W+cMQHLiSUERCmf/H3YFOgDj6B85bAAH5GYUyLwf/N4QSXfCndxf00nb22c8SZ3SHLgu9EXW+XjPJEyt39x/bcWpF5ALrVKVeiTO8YZmXWOkk6VoA3S3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z8jHT0SZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8jHT0SZ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cf35636346so1171136a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299852; x=1715904652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZj1Bq1Ph7aHtca1pQR7ov3s7eEPL/cFrYRcMYZmLbk=;
        b=Z8jHT0SZFN+ovfqxeslVrjCzTGA2VnuBKwm25fc24l38cXzbJisBSx4NBkha7bjDjB
         C81kVs1WDRtCVyGGO4CjKzkpypXweoiIuNONG/zUiMICOkIgFxtYUPvWkKxc9pbL3YSk
         rciA0vQVp9YzIUepzn9w2NPv2RbUwdSifsbGQq/MDhgHTqnba6cUU1eJPxXknt2Y+k3E
         gvrSApFlVk2se3HxRa1WcLx2CNU8U+2KSmi8ChqNdz6pDP4nIvAiCA+dlVOPNGNM3rou
         aWhrzqrNmn4SBg6CzXlfD0z0DxjscEhY9i46S1IBIovYJnXRR8Mo8L77PwyyTT+bCRMh
         yoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299852; x=1715904652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZj1Bq1Ph7aHtca1pQR7ov3s7eEPL/cFrYRcMYZmLbk=;
        b=TOkt0LPZtIGWWWvX7r6x7x+phviw2on4O8CNa46xjUqIb1WIzxfIs9pBYwQJwpzivv
         UeV4FvtBhEEyT20lUXGkxjqGhGZjUO3iYvw/1JrXK5ddqzLKVnGzBvLYSeq8gc1f9fYw
         0i39n9ohdWZaUWM5TlKZTWeuWU35wBlJdKIauf007cUptf/NqZFznPvRjemOPP/VxUE1
         ae+F9sgZKV1FL4l/6z3+rQ2kSkkTKZcwyEkzeMqosGaYe0YFwmWqnTEPB9WaJe1fBl1d
         YteAbR8PwSzWUpnLUJ2k/HwdJVzzuFUcL3x6QsezTfAi28uxR8tIQGeWYZEnp7cBbGVz
         fwdg==
X-Forwarded-Encrypted: i=1; AJvYcCUkIFRROkCUvig8rTKuOwdPthwrJ0ure2KZBjXiPzcqTpiuL8XCY4zB8emGsmguiTVBPOABh9q2wDxEtXo0LUH9Qd895of9rCbW8iqL0UKi5v2qIb0u
X-Gm-Message-State: AOJu0Yw081oyTaQIXKtt4LJHTSPQ7cQdbALHM8sG2Ct7PYub5GqlvVCv
	9EyYfXY/BNfnWT2//T1Hz6cGQwYmQ0Qk6ZZ04PbDt8xwV7yk+j9yigO3Ih0SIUeJiWbiQ2OMQYE
	zxQ==
X-Google-Smtp-Source: AGHT+IE6gpQE9CIWWmmdDutordyNQu9Ic7NAss89CUXczRtxiQuBxUodgnUyhLai/71SPfiQgvdkopFQ+HA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:3f8e:0:b0:5ce:13a6:3c36 with SMTP id
 41be03b00d2f7-637427aa267mr2381a12.11.1715299852354; Thu, 09 May 2024
 17:10:52 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:54 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-38-edliaw@google.com>
Subject: [PATCH v4 37/66] selftests/nolibc: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Willy Tarreau <w@1wt.eu>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 94bb6e11c16f..a28813f4367f 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #define _LARGEFILE64_SOURCE
 
 /* libc-specific include files
-- 
2.45.0.118.g7fe29c98d7-goog


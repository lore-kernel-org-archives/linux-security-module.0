Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B513FD6E
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284993; cv=none; b=GlRWwJ0PxUOSB+tlruXKXp50ZuizB9wh82lQEs3zAw4EqDY1LknK6EpX9/yyffmdHKWGs6T1k8+VYME22pPT5BOxdzUv0tCKezoVKHzZDcfK4rryUHNqfBR9wXhWXFY2KJFAG8ge205vJsKCeYuXDLW14cI6VmJb8ZlJiku6Lsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284993; c=relaxed/simple;
	bh=IyUlAGHuB4F0ACGEqw9XDD1VWDnG6Gr5lWYbpcHYvy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pFLq+XOwQ78syEmM9p7eMZZuq31K91iJM3N9Dz8S5HGRtBFDjmckziGTsqpf3cqaGlg0y63B5J4Te19/1avcWv8h2S9/nFxr6LlqaIkr042/PN78VgwH15YA0J4z/+sQSyHkLULebfnDhpjyrBRELj9Mx2O3evPzozZLuwEJa/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ybewIHWZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ybewIHWZ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-61b7d7c292aso1165247a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284992; x=1715889792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=ybewIHWZn1KMhnWj5rppt0eEpsAwvBka4dwRdYHdLkslf2u33Y3VreovmEUj4stwiW
         x3rYxwpAhZ/D7s+Ld+zK/ejjnDq21MqDIrRUue4gdPve75UmQ+w1nt5U30Fby+9oeHr2
         RJ9TLuGsGv4q7qeFEyvJG4ifoEMLdhuedipLs7CepjYbRCieq+L03bdt8rHeqaEp/sZL
         FmSKy439+oGntvU89C9/kxIXl+00X04sgjQdojVOYxeOWa7CK4dUpnGp9POuRCQ/h2Ip
         SXFL+jZT6p/icXGrCWNZzgnUxFXXDzdf+8gjgM4QVi9i65T5eUMNqmo4uPC8nW6RdrxT
         pi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284992; x=1715889792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=ShMhCBG8rx/Vc9WxREooNLSlW83laupGkB8NGpq/6p3PPfa5N8phRuz3W8Zeu5Rt5q
         QO2I6Qm6zzLlNspSJYn4CNlKNlfDEJ/dIRR9InsDMfmcbM+ei8NhtmFiMrykDxjuDo3t
         0l6Sd/Ij1Cs2VXeMZAHWwviYoYf8FOuW6iNu3y43ZtJ1zjtwIwHO81OatsrGReQrw691
         I1nwU3BZzAuD0wAVtJf2MrxqLawPWPAPPCjlsx74UkVbwJ8wNw92h3VrXlg9puR/I3sV
         cjRO/Ygh8qKivR06kj9adYZIqvreBiRF/qdHA1bxzXUuTbe5nUiD/GZ/+DXpGbIS/X1Y
         K1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWq+PR8nmZLwy0prB+82Wa4wGFIHFMszi4RG9D6Zr1BhTT2YdVwffECwNqHgyA1G9gG60snZKDzlwtWFm8zHgvuA4VFPcAqui0H4zGzqLbZ187dqIus
X-Gm-Message-State: AOJu0YxyOvxjzLiA0nuoBaALJK3O4voIl8iHVMEgjeLVY0Gzg/pY0NLP
	4K4waxDm96XvJXJpEq7IoxVeo8l9+vpxJiMKqSRwuIz062wWYFqgM+ZLah46awr2PLol+ym/63i
	N/g==
X-Google-Smtp-Source: AGHT+IFCjwU+w1U0yj0TkNwI/1blZtBGHka6u+vlka6eFMoi+Th2FASNm4gAn2xDAZ/v5xVDapqUQKSY1gU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:d30c:b0:2af:d65f:f89e with SMTP id
 98e67ed59e1d1-2b6cb6c0d84mr2722a91.0.1715284991495; Thu, 09 May 2024 13:03:11
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:40 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-49-edliaw@google.com>
Subject: [PATCH v3 48/68] selftests/proc: Drop duplicate -D_GNU_SOURCE
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


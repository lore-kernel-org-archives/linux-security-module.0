Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958115D5D0
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339766; cv=none; b=pDoNMJARd8LliyGk1MKlAwXX2/WPUwxBxd4F4gN9X1lwXNQGxWFPhcpA17q90Vi//VnBkql/9TAPQNxZ+OaXUgy+oUipIs2p0kk5YwCPATNvRVOx2bYH6WzAxAh5ijnvnI60I8xCL0ohChOpbf7iSDoJcrfwjWwNn5B207F4Ypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339766; c=relaxed/simple;
	bh=6W30WIKhE96pwmtcuV2NfxhpFW0veZZZU83PwcF+fM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X1GRx3FIWY5TXNQz5XuFmnISC+DMMt6cj2lEEwvgcKPsYJkYNSA7AC3Je8xpdqALJEoKmq+MbiqNv0p5/ao+1M2SqB1cgQmjqZHmFxmWLplvOgLBBQOqydZ04ooSeyDYr1vBbE0zLt+kDE8/OgqZJwhPZv73fjMg49gJsdDPMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIMg1EtA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIMg1EtA"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f44ff14c17so7314351b3a.3
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339763; x=1716944563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDddXI/rz5Uh/0hxgnIVyZ6+81rNdMnfIsgCLtRcH+A=;
        b=PIMg1EtATWDnwfr31/oDxOZL4KodTbq3ps6C5BR2hXeKBEGJSNlZyIe2/ibUBHWliB
         N0fu43mmrb1weOkXFLzXFH/ovQYis5dnzc505OxAOhfmlKmdov3tbRjnX7dCr5zatrNH
         dy3g8gYqiW/SlazGKNy2TtKZ68s/pK0ZBh3ucTAeYedjvUehxCpyu84WtjCcgfTcno+J
         zm/IHKFiXZqedKEd046owtFolCwdCNz3+u2lW4pkp+Bxm+Co3s/R79oIV9RPluVwLzFe
         OyOqs9NeYYV0XXZc7OZuFy/JPk8WKUVkIHy4dPiHrH4aun02GYwJuxCKyLgx37elfU7B
         hrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339763; x=1716944563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDddXI/rz5Uh/0hxgnIVyZ6+81rNdMnfIsgCLtRcH+A=;
        b=LBxMFrxt7xrAVjabGVVDo4y+/mvlJ2hf8/sYvpbZJYbaeBnqBla31+4QDB1EOt12BR
         ZCVosVJSPu8NsEUxTzE97Hj2D71AgjJ5Dzl/QCsv1AcPjRr5iqeVp1OuZk9oWqztbO8n
         2TIsrsIUfARTLf1kmNv4jU1p8kvHR2FkrE7Ac1ULqm+zSbVJNHV7hfI1CH+LkbtlbW5V
         7ALj/ShqWX/uM7DOGE9bmo85ylc83Ynuf2L2u8m5ztpbuzK0jV3RGylRVv8O+mlCnKLm
         7fBUDNp+3Gm0ZFWGSnXs3X4rbBGJlD6GElNL8glDtLSQbbufQCPfi149ob2YMj0VFNm8
         Gnzw==
X-Forwarded-Encrypted: i=1; AJvYcCWpyLeJOag1sFfl8UMOIBXLdOp+7gvbgQEKRjWM9BXmdzY2nJaWCo4WBxtCGnRcU1f/3YA0Vi8p3p5Qf2QtFfWGo/mvai8t0b0Oe5lo39TVVaUVXQu9
X-Gm-Message-State: AOJu0YwtPVF1YQtdfuvUVo6C2A/NAlHLluYQA6C5MijcekXlYuzZPUfH
	YP7dbdSSix/YGGUkaeDBS5Iht4jT6lpImBGoACoJT0Bb1a6dNrd2EvYtAxtO5i21J8PjV++6mLW
	3aQ==
X-Google-Smtp-Source: AGHT+IH8wpGwaawCict9Ep4Ub644GN8fYtHlm1t7v7pZuightlDMU0GhBoDAJQNtreKGztGUsjMmh0JORdc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3a18:b0:6f4:133:f5a5 with SMTP id
 d2e1a72fcca58-6f6d645c526mr21783b3a.4.1716339763429; Tue, 21 May 2024
 18:02:43 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:53 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-68-edliaw@google.com>
Subject: [PATCH v5 67/68] selftests/x86: Append to CFLAGS in Makefile
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

Instead of overwriting the CFLAGS that is imported from lib.mk, append
to it instead.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0b872c0a42d2..3395a5d114c2 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -35,7 +35,7 @@ BINARIES_64 := $(TARGETS_C_64BIT_ALL:%=%_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
-CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
+CFLAGS += -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
 
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
-- 
2.45.1.288.g0e0cd299f1-goog


Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528A113440D
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284893; cv=none; b=QVTNDQGprqV/TerZKzE59CTCyTEdbMgT/YK4YpmkP4T2dzfcOVJUgf+PXrGgtSLnaSbagZEz/i85ELPXxfP4kbOlplWz1WoeR82q9SEChzkwwK9dlr9aa3jJQMORM3m/ZGvMTq8i08/hvlQFlLhYbxeHf5SAvFucdWKHsc49xKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284893; c=relaxed/simple;
	bh=tTj3M6fIal5DHH8k+Tew/M8u7hiv4dqwU6VGCuE8kiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oDWGF6fmC4RIFodizGL/y96814AJdOUGJoRDmHnxNRnRLCm9MtlS2bGfcm/A/9+yDxcE9nrz7BBg2Yh7Zgv4E7GMyhc9gm9tjlfv86tQGwOj7PT4Obu96GhTB95RuM41csIjO4Jz2E8tE4HiUEfvCHMC/jJmclCEa6EbSAYptuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1grMg40n; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1grMg40n"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec5efb0a33so12234055ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284891; x=1715889691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SARWn1297sTaPTixNcZ2P/NfR3z6dYPtI+wY0CAAJVY=;
        b=1grMg40nSGXiqE+I6S9kiCAhvYqAMfdhjtlFh9ujPrB66YhywAywE20mBO2gQYUIEA
         TBuJwFMk7tmy9o14MxBJK4LaAe4yFTSbr0Us9UavbtfnNtT1XDPXcbfVK2ONsMzFENWE
         rHOnf44B9sy2U1+7oL8rZwQGJlDIFtCAt7bZtS6t+qr2VI4ECSEDiM7MsvgrnsHw6xKt
         wQdVQkyNbu4HfnRsKL0to9G2E1ggVyQos0omOd/GYOZwNLoiL6O9uFbhe3O7ZOFyYcUb
         W3P/Tq92iPKWvDunZFpamvlqcy8u956fK3tlvj1BcFjwxppIA5wnx538kP9i0tRLYbI5
         IWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284891; x=1715889691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SARWn1297sTaPTixNcZ2P/NfR3z6dYPtI+wY0CAAJVY=;
        b=r554QJhvkq74fBwMIr+ZZFwBrcBIoputfPEW925q2xvp5DPtiKWq6L48Yzx9RPXWAw
         aJzUBkpDLiFNd5N6VoSrA5q7YKjft/iACa8JA1iyoBUJ1zMWd359zdnB5dMQ8V+nY6EP
         FeZJUWMwx/MUjBl8oeAs4nTaiFf44wmdlK8bLpcY627uxJEOItx9X5mSc87Dcq7XgLiF
         boSnDgAsEMNKfwwDDBVje9o7qCmqnhZMOiavtMuAQ9RgBzUnKORw8tN9PXgj7lRm4N6Y
         DErAeqBuog/D3ns15+q2tUKa6+1j8GNwyg1nxJoTrU76hNXxhWUABnOVrZnFgh0eAK8M
         aSjw==
X-Forwarded-Encrypted: i=1; AJvYcCXd2Gk4g4/PUGPxZ4qtYzPRxFRvkSHnRxO1OgVAPZSGkW/dvYTyJUbBOm6rwgH9dPH1LhcEnzIh6ysSJma6YDS5fkoPfmYNTx6cnwJ4m9llPDlpnWEO
X-Gm-Message-State: AOJu0YxBXHMjSxy5cTUDRl0sX+Mp8908Qu+nT1ypRmGz/Bjxr0WFqYHv
	B3lgmmd14B9Aajsd8uSp2yJwCO5z90xjIr6snymnWfdFNwXgMYtbAuaAAFPn9JrpnWj2fjIoPAM
	PoQ==
X-Google-Smtp-Source: AGHT+IGdQihvGYGHF6PdjZpZUUK6gc/kNAnaTsu4e7xw8HeMCFzPLsdZMDhNcn3aU3W22mZMcXJG1JBkESE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:110d:b0:1e5:62:7ab5 with SMTP id
 d9443c01a7336-1ef433d9bc7mr28285ad.0.1715284890584; Thu, 09 May 2024 13:01:30
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:07 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-16-edliaw@google.com>
Subject: [PATCH v3 15/68] selftests/exec: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/exec/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 3c79ec9bf780..18d7a1e5a416 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
-CFLAGS += -D_GNU_SOURCE
 
 TEST_PROGS := binfmt_script.py
 TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
-- 
2.45.0.118.g7fe29c98d7-goog


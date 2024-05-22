Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9B157474
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339729; cv=none; b=NN3W//UxMsGAtzlLVJNXgXL2foYPVLlG10dOsBK3Whp7zhdvylrg95hK0SSJREfsmI3dJ8RhXpkXqX3fXMTI6vFJfxRlpNi2sd+INGROgtHUp6fr1/bvqHdI8dti55gUXdHdqkXnOpWFLvKP3tyAuu+T7GODfQqi0mOYNPX6Zdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339729; c=relaxed/simple;
	bh=6jgz4+faO+Nm2X+/8mdPko2LTb0jB/d+3DB95djvy4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PWqUObxi8lfQ1v6pbA8jHxrX8/j6vIrMGxckiXX3+cDr+pBr9pu3YFrJdvngsmDqhSZQ6xbC79l8e1J340wSJVtcpSiYp/aKkt9tMJgFVL8qEYD3vv1ddUEz+Xg3OvPMo9J1oPdryVFk8MDmy7bBN8dnjJ7QXUyzt/JXvRDRZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hlc7uku0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hlc7uku0"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dee5f035dd6so20433347276.0
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339727; x=1716944527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QXP2A1RmgNCuhz3jzkqZFPq/T8JASHp2Av/T3TK/B0A=;
        b=Hlc7uku0gLp7sUvzq/MxQg7wrl0qU7E3ipTr0BPm09OCEYUmPtzSDXMDRL3oJuBFI0
         5gSL7Xis8ZwQK6MoSwWyTL7wiAvsCcOfGhARHWEF1MYZUnpePMFBtDj9ZlRo5aT3L9gZ
         hssqfjokTF7qbr+91ai4BOWCXjomkimBE6SDhA4e8710Yl2MyZfwxVyw9tNHn+BFZvoD
         r3aqwNXklDCvaWLacRbSV3usKU7wldYf9Q79tRgLySr/Lm/cnFz5cdowobDc+SgtScut
         PjN3JB7IIDeLJT3Z4L5Rfo1AdsC7ARpp4pRE2k6bOUo+3dk05wDYpy31udDNDBg8a3fK
         GxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339727; x=1716944527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXP2A1RmgNCuhz3jzkqZFPq/T8JASHp2Av/T3TK/B0A=;
        b=ldc8WH004qZY0p0uicepje4cXaZklaYvpgW+/O5XaQ39yVGnmWT3iY0MQth30ktLwi
         vXG5k881NsJ1G6OKhFTi1tUBSF/0JVrrulT1eKAVw4D5FvoinryMeuqw8N7jONvCjrQa
         I7ygCAtlxY9hrweyHx3hc7UGo4lGxb/5TZRZgVsnqREbcoqx9JIbFbZdCvXfBlqFSnwT
         rELy4F4xqfcr68owIp3YBXqe18XpscT1y4UeGPbqaX/8wbIeyammhWer17vM8rr127Cv
         niEkR3BwXvaVVgCGXQIn+ushhsYaxa0aVGJsD/ZUqU9pa8HDwlsjF8iq5mbv34aDhW2i
         ljww==
X-Forwarded-Encrypted: i=1; AJvYcCXCk+2C/T+PucTrYowe7Uonk0QJGkeji/UTieZHqgqkl68qwhIPxBmPOKv5V9KIu34vJ27QsRcSKskLDaaqfgkxWpgP7qqyTX8umQ7aYwNXjUuYtjok
X-Gm-Message-State: AOJu0YwS/BLGWCVTRMh0i1Ct2wymxvsT9t/3MCypQHBUTCwBkgDGI4kp
	j2pzeqxpIirzRRX30mF8vKyXiB1wrzoZy1eskc38tyv1DPAyiOFhOrhqb9YRf9oIhdQEDnv2dFo
	FKg==
X-Google-Smtp-Source: AGHT+IF8EId4AZCR6U6eMj64+DX2yOmS+/detewdRtohDpLo91NDj/3dT9jN2LeidzPNkDf3gZpsYu11pYM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:6b49:0:b0:de8:ac4a:1bce with SMTP id
 3f1490d57ef6-df4e0e66261mr198614276.13.1716339727027; Tue, 21 May 2024
 18:02:07 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:39 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-54-edliaw@google.com>
Subject: [PATCH v5 53/68] selftests/safesetid: Drop define _GNU_SOURCE
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
 tools/testing/selftests/safesetid/safesetid-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index eb9bf0aee951..89b9d83b76f6 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <pwd.h>
-- 
2.45.1.288.g0e0cd299f1-goog


Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1953E1B
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299790; cv=none; b=nxsFIpaw1sbZzfErbgZ2tGYq2w6PaPPfJNjeqrP1wPFod4q0KgZqnclkI8N+ee5vD0MxdCJNlKjMTU9nEif8qvYmwvsrJKIkMQrMc9qDBds1hJEQJvjbyHp6+ND5PfssHDhimFnYWubXaEEbuYP/bPAf5oRkykfe0rLsYQFkr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299790; c=relaxed/simple;
	bh=fU2P3ohii6eOx7fFDBDMrp0qI5AdjDGRbNifJZQ3D6o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YVvsAHN7kZyYJuL3VCIDuNKaewGU0nN2iPNRD6annnU3NolMtxSJsOMjmEC5SrSBEnkJEPse4I2OfwPtTvQHt7xci9W/SU75Fc0DO5yA5oNcyKsZ1IfKZmnzHYALi21kZheFfS7I8Euvj6CwbyT985cYYaycNHTnikCftlusx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMwzbfWA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMwzbfWA"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61dfa4090c1so21170927b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299788; x=1715904588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uqtc6lb/bjRHtHw2HifamjvJeZYo3Iv/aojOVKqDLuc=;
        b=iMwzbfWADYzCPMDndmgHFn00o1+BKONgdmpKKz/Wkkr0HLzaVF+J1f3LYTBpjPATO+
         0GPhQWJzqA2gUUTcg+Bmrch6B2+wMsCg0mtPwSgddyM+8YVxwytm6PLuWox3nzv5bHYl
         1RMApk+i2xo/cf7eEQ+o/AL47bG/eqQXgxgvlynmEP59kSiVaObm6e3Y8vqpB8mKd00Q
         skYW+49pWncMcJcj2JYo5kTodhI8irLgyi5+7pV2nM7EyJyuUOc//Jf/yhcbUIS9Q6bq
         8oIrnGXkObXCVOw6znLLe+uq+nJg7ys9+I1VpcNjI0iu8k+n1BEK8wvPxu04Hgivfgx+
         bdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299788; x=1715904588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uqtc6lb/bjRHtHw2HifamjvJeZYo3Iv/aojOVKqDLuc=;
        b=bREydqE7V6UQUipWSx543teo/IDCzqqfrS1iAcJXJ/Ik9yT/5v4vIoz5mRZCEUYt/A
         SB0B3I9v00FA8xqL2rkAC7ScVPeGgf0LFGaiExF5UokfRmJEOWiyJuOHWZDhgE+lHjA8
         Jd5UJsDpO516A9njamJ2XcKDGw+Eybmkk+8yyHCb46g7CIjCbxOmJWByihfchiAOtqPw
         hy0JLBfR/JkG3B/gDkAhwKyJG7N3O5jGrSut40QZ7838AX4U4+uMzSc/Cec1K4Nr9ivt
         tDM270BJVLZd87mDhSqw/Psd51HGSYfGShL040zodeQbFSr7mOJVv2mEZfsI3F5Rp8Qe
         qIlA==
X-Forwarded-Encrypted: i=1; AJvYcCUY+lXFGsDREDpED1YvXOMs1rwMjotM1rMDa7X7+//1058qKpxyZ5+T24yf0Gcbd0PUGnCsOevRAxha70rPo3eyBcTHm6a6tGe57O1TMACkclu3q8I7
X-Gm-Message-State: AOJu0YzK7JKpiwZxOXXUEU2PNv0PIo/bwVbl3gmwtrIvj5NrMWwRHSb0
	pfCn7Dab6FwlxRDDq2yoXDjzeTMbwNymDsi21LfgvJr2gJhvhnngkCuRNryc5FCcy3mpzrNn18I
	sCQ==
X-Google-Smtp-Source: AGHT+IGVLgMcKP7k6+jbHoBvicQj4jJfGTq3ct3mJmsySja7BFFB2IfjyDeVqng7lmOeRf+Hm3qC1VhoGlw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6211:b0:618:8bdf:9d56 with SMTP id
 00721157ae682-622afffb2b1mr2640537b3.7.1715299788317; Thu, 09 May 2024
 17:09:48 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:32 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-16-edliaw@google.com>
Subject: [PATCH v4 15/66] selftests/filelock: Drop define _GNU_SOURCE
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
 tools/testing/selftests/filelock/ofdlocks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index a55b79810ab2..301c63ddcceb 100644
--- a/tools/testing/selftests/filelock/ofdlocks.c
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <assert.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


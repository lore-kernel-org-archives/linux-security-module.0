Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9342B152798
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339692; cv=none; b=dN/aoOkhlndV7hrgU6q+I8cq9uDo37pa4cfxhtCwg5XK/dXDu2Zmu+y5/oKB0N5E5VCJwHPVnmT63FHtCWqkJSGdujpgpiNgwL5HjrJjPR8L0U0GpRQTpUSdJWbGf0JZ0bAgjNu3uDwzytT8noB8dW+vHFry735Z8E6m0d1xoao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339692; c=relaxed/simple;
	bh=fc5ZN12L8t4dHv2f+/to/VuuP376ryg7cLyfhK3bSMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jYpARe8vQ4q8UTp8yYAj3wiwJEySS8cgrF5hoiAA0SW17HK6WJg55Fw7tKwjF96bB8QJ6fpNTNrpVjgWLW6/0fw2O4iE/Jil+8tlgTcyFFOby6yQ2tYTsWzjb8OVXQp3+qGAM3uifqgb6lW7rylmat5Z1sXTrMsyZ0CDD9/wORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=saqV4sGy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="saqV4sGy"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-65e8e404479so4915286a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339691; x=1716944491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hKqcMH+cHcivjSlV0iWazZDih52rI3iEBn71iAK9Nco=;
        b=saqV4sGypCV8ublpIPHkIG39GZA4akHNhGTwMOOcDiOZe7VsIlzmtg2mm1ewUNoNuk
         JAmUxeIcEtO93j9bd89eddfUzpgBZ93uylk9lk9zC6kPb65L+egjsNwMMmIrfIPIaH2E
         5XgBVoQwq9+KvLD+ykMHbOXoyq3bAnu/X+eG86AQ5Qf5hv1egS3jDwrTI+CGn+2m7EVn
         5Me8ZBIZJ+HkXLrS2KXkzziPPqwxAJ4z2S5GMrJi/463/urNB5Fy9eEstouzY4EcT6An
         9q0LB05OrReP9MobEelgEnnYjJVcQ7uczcYL0MCVzih9ya38p3Iu6NTYNNlHOFUxVimx
         tmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339691; x=1716944491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKqcMH+cHcivjSlV0iWazZDih52rI3iEBn71iAK9Nco=;
        b=T3mxziNpPPS8yWcUMsDRkvF1mve0IRBVdTapg/p1ZXRbT4podaTLutlO6EQtCLZLMZ
         KQHXi57M07LJ91Jbd1ZiGK4Q/zBF5GM+JVEfi+WksXq+yO/yCkzsJGXLpCWaJlSUuoTv
         RENcKLQQ+hXrbaxcl4TIbnD5rJxJJ/0cvV4rFQUKUwPhk0qzcthSQ5Sf135e3D4m0xUA
         k6BSkEV+4ge63WN3Db/69kNGNkJNVgxWvRIbNYroHHuCZ8LjauW7RFILdEzv0DjydTq1
         j6bSUpeXcKYbze2LFCnWjZHBR4YZfOqO3Fk3cPCWYM/TRxMjzNyMTSrDWnbEzLzW/svr
         rBwg==
X-Forwarded-Encrypted: i=1; AJvYcCXCkNXUtjY9XdKk5Wy1gmljJi+0/r29pZlqCfOhwlIVVSL11B7S/qRvcN0nFp8/bgChswU31MwOqlaWrys12Tu7+ki63S6kfBiz/cZTVaTBmZrG1cp/
X-Gm-Message-State: AOJu0YwMkDtvk+G/AYq8UIq0mNOVLTqz+TkHfJzwkHHKWCiqqQmQ4x4D
	keALHtCYYJq3NG9pYnGzlCu/gLRxeg2CRChQ1hh20TfVdHUz1V7NvmWSCrFK7/87wsaDdwjVOHf
	hgQ==
X-Google-Smtp-Source: AGHT+IHEdlPEV5C7CUmVhgzYSyvdP68FXeZPwJi2pFA4aRhZIMBKvPNDfPXTnCO1F52hvMs38tuZRBZ9qyk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:3715:0:b0:623:2c3c:ab09 with SMTP id
 41be03b00d2f7-67640145dbemr1343a12.0.1716339690894; Tue, 21 May 2024 18:01:30
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:27 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-42-edliaw@google.com>
Subject: [PATCH v5 41/68] selftests/pid_namespace: Drop define _GNU_SOURCE
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
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/pid_namespace/regression_enomem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
index 7d84097ad45c..54dc8f16d92a 100644
--- a/tools/testing/selftests/pid_namespace/regression_enomem.c
+++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
@@ -1,4 +1,3 @@
-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
-- 
2.45.1.288.g0e0cd299f1-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415625;
	b=qV/fIPNoDqjyTFmILWfl5G3vJTV1UjSX5Tw9FrqHVykm57RZnpNL1Sey+4EZ125OVqlq
	 C0l3+a8BFQivKb4nBw9+8tuoMxoO5b6rfqwQmXICvCST8P7kcESLVucojHdzpB5X02GRN
	 KLwOl/DBZ9+0MbPChU2QgGBADVo6M/Dd9aff3bCozRIDj2Z33ZUcoyCd+VLv6lstJ5hKv
	 lYF5m2bULWeZlSrqHgNNIYqMVsUCxpbfrAYdhsQcCEyynUqULzQsvVKggSO5KCuEbz8D7
	 Q4vNrXJ+VTihrEoGI9+BnQX/9hujGx2RFJUq4Qhin+bZY5UJx/XdUEs3EieFEnMen3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eBvXzXjAl0PssB28sXRWoJu57RNJWaLnVNDQ7q1+ZPw=;
	b=wJltrruG0KJjYFbljf+iQCLtc6hg1HJtu5IhIZp/cqsNPwxHxWiJB4RuY1bSghd1uC4v
	 pJlqQ8Mp11Yrx5vrk9UVw4a/v6V+Fz0Nyyc6nfiKN7f5TLNlS+TmxgN1NjdIKoQGRiuZ2
	 d3enO2lcODa6gpAvcwDAIv2aox/tgBpdxFPwHvAxz9AN1LEqXjZJatHrWX7RzfUl6b1mj
	 tLSanXlmeGK1MSe+uDSnLuzYKqdRGa1PlJIShYtPbIa7vfdwXZG+Y5RLnw6Eu/NYP8HjQ
	 iSvZuqKQlOz1rUo1wZo9C6loJGmd2Wk1SzCREq1M1kPC1JAE9eoQ9F/KKqXqebOlZrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fhItvhyN;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFCD606A32D
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 16:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EFCD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fhItvhyN
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ccca948203aso1615779a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 08:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415624; x=1795020424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eBvXzXjAl0PssB28sXRWoJu57RNJWaLnVNDQ7q1+ZPw=;
        b=fhItvhyN97f+TqB77kXmFyDGxHEG5lTG1JgGnFySfPcgKGAUb4uHncpfAGcMzN8fAA
         YxdhptBxE5IrKCsUSE6kSW6aMXCQnl/6RkNI5iNW5TZtmCnUJLa6X2J/FLCWrhYDE6WC
         ZpoJKtGRhq/tKzcl7X8I0393vXkdHSdT6XQOJmbP2X2x5x5kDWCFTjVs4WosVhiguhxd
         q6+6YF0jWrI3gEa3u84YG6gKurpZpV6407KWa3l+1uFGCIVyPhz2d83eLAB2v+2xLOkD
         quxeQEqjXsivsCWH2xWLwYVz+DRYCUSljn76odj40xsS8WQLGYF+BOauh6hpXcqy0G7o
         1Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415624; x=1795020424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eBvXzXjAl0PssB28sXRWoJu57RNJWaLnVNDQ7q1+ZPw=;
        b=ZC2XK/ByPpVXE3LIvs6m6/EdvgAE/RRuHFVCHnmnyR2nW8nKwofAtRmP4G80WbCIia
         +kutdKWwmaYdpf1i7vlSac5uymXz/G4D9ChtJcyob0UQ/QvWE5nJe+KC6oSVzzLqVhbS
         KFg72cZG+D8bAsPNdtjkf8jjTQxieULFy9f0YAEBPcKzCq7JXP1nXWbaIRJMe4Sgh/aT
         6KUd8WDZOjFrrvrsyOp6prsdoji7CBNDkXgSylz4G3315B7jGJtwlHvFKfiYI8K0eo25
         E3Htae4E/6w0gYUVFciOcrl/FSR/IrNOq8iWsrw8yUakZWlBo1asTtNb3Q+xdQ5ZcB/a
         kDdw==
X-Forwarded-Encrypted: i=1; AL+hErE2jIddi8NLBGfLdihEoEC9LO4mCJXsyajzH6aW00vQy8Ce2bCAXbnFz7JY9+/BlOzkRxhrdd3LmyfcibQ9LBgUzj/iRA8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+aHt71z+bEsqk+YHLXQ/AB97PSPtl7B2Gv4S8hHpuEdlZ6Ano
	Iay6ihWAwK1vZyDHBaJt//mteGQN2tMBcIBjeELGz7uSFOEroud3VwLf6kINpA==
X-Gm-Gg: AYBFou3tLUdCCnJYp1U+PwbKK0lwoWaSkLHp79DXHHalZiHlzJotpGF2P1ct5zXt26+
	5LzYQBADpIqkaZCzma/A1zNx2oqhXJ0uj4+Ts6ool5iazpirhfvxqxHc2cJM0n/co3z2dEZ6DpY
	9WGzZFdpY87ujfG6J6mWtMe7Wg1PEFyErt+G3utodXWc7iKD1wi40u+EaDCL4l79SoG3ASog5WK
	0wRiKdC5px9qHDDidqjjTiGqX68ob4oo/j3AgwiKJpSijQJxr5IylZciip9rDSNHyj+jdpNmUdN
	+Cjbh02AMiKGUS+tv8LY26wql96Vahddf0jxEfcRlbQ6KRLmKYALmzIHV+l1bWoRZdV/PWZDttu
	eMUDkFrrDgMhIHDMSXPkxmNOD51IMsoNKdxRSJn1ElW/zStXRFBI9a3Nw+Cg8lPyXGYkQwt3rZb
	OonmihoA5kem/SlLLjLdQnTXJ2wJLnutAjiplK9Zb3EBm3cwusFMEiGt+isEHIgGvOtFVTpsQDu
	95gL5cvKk2rUebeQxXuWQsIFOS7G//wPfAUXTrGxosJvR/j9IYroPOrQud1y61HajBGYLy3olRC
	DRnWenoxsTJqsAhzTb+M/2+Bjrn2zb93QI71AMjzOdjfksk6b8CvtiH/4kQjPiZ7WoYn+AVF
X-Received: by 2002:a05:6300:210f:b0:3eb:3952:d706 with SMTP id adf61e73a8af0-3f3000c0ab5mr3123096637.69.1794415624374;
        Wed, 11 Nov 2026 08:47:04 -0800 (PST)
Received: from localhost (218-35-178-218.cm.dynamic.apol.com.tw. [218.35.178.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab5f1effsm2296684b3a.49.2026.11.11.08.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:47:03 -0800 (PST)
From: Kurt Lin <lylin1023@gmail.com>
To: Serge Hallyn <serge@hallyn.com>,
	Shuah Khan <shuah@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kurt Lin <lylin1023@gmail.com>
Subject: [PATCH] selftests/capabilities: test_execve: drop supplementary groups
Date: Thu, 12 Nov 2026 00:46:45 +0800
Message-ID: <20261111164645.260593-1-lylin1023@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When run as root, test_execve keeps the caller's supplementary groups,
which usually include group 0.

Since commit 337490f0007f ("exec: Correct the permission check for
unsafe exec"), a setgid exec is not an id change if the new egid is
already one of the caller's groups. As group 0 is one of them, the
ambient capabilities survive exec of the sgidroot helper, and two
cases fail:

  # [RUN]	Root, gid != 0, +ia, sgidroot => eip
  # Wrong ambient state (AT_SECURE is set)
  # [RUN]	Non-root +ia, sgidroot => i
  # Wrong effective state (AT_SECURE is set)

Clear the supplementary groups before switching UIDs.

An AI coding assistant (Claude) was used to analyze the failure and to
draft the fix and this changelog. Tested on v7.4-rc2: as root, all 21
cases now pass (2 failed before); the unprivileged user namespace path
is unchanged.

Fixes: 337490f0007f ("exec: Correct the permission check for unsafe exec")
Signed-off-by: Kurt Lin <lylin1023@gmail.com>
---
 tools/testing/selftests/capabilities/test_execve.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 46fc8d46b6e6..9428b787437f 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <grp.h>
 #include <stdarg.h>
 #include <sched.h>
 #include <sys/mount.h>
@@ -90,6 +91,9 @@ static bool create_and_enter_ns(uid_t inner_uid)
 
 	if (outer_uid == 0 && unshare(CLONE_NEWNS) == 0) {
 		ksft_print_msg("[NOTE]\tUsing global UIDs for tests\n");
+		/* Group 0 must not stay a supplementary group (sgidroot tests) */
+		if (setgroups(0, NULL) != 0)
+			ksft_exit_fail_msg("setgroups - %s\n", strerror(errno));
 		if (prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0) != 0)
 			ksft_exit_fail_msg("PR_SET_KEEPCAPS - %s\n",
 						strerror(errno));
-- 
2.56.0


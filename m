Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168121;
	b=JAre/nWVmvzxw6pnfK4SyxPxnoEm+3FA76zJRodHRmdO3oPN0onX1Ny7+LHINKyCba0B
	 NyYWB7QOt/ym10t2m4zR3eiw72zdBXt3PWNGdq15edQC0WamAeufvWKcLyP1r+gyAh0pR
	 w0RQm9/iEpc6GV7ey8bH/BJrXXpMDgjQHsEZyEptBQykadpAUlBrtk18yqXSq+cHvxXES
	 Na6LISaF3V9j1tGArJQanLixS27/PYmVflEjqeFbTQxx8t2b+qwcC99jFyHOW6xwwQQLN
	 YHTJ2OZYIYo3oOwcYxk6hX8XUYhWQ4ZipteYDCXgmSDUZSBv/HR7bxWfGBgyfEDaDZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LrQEkt8HXk1ed1syfHwtkDqVdWgo9sprdy8k9nccOT4=;
	b=t1q/ewWZIGKr9/wLTh117G2+ZJ6mwybrc7aNalHp+RKWOQtWesHqxuMyaahNU/oiDtJv
	 QhJ6zA7PRUUoBSWjuihxA86uTU3pmtCQFrZbLQnIG0mSGMbYqRVallrldXvByWNxKPMUU
	 TfhvYUx+nVuyIGr7D8foFoU6PuBvDQwXRdih8s2jj9VhQQNEOESY4NMmY46alWWHAhPjx
	 g22k3x4i2eXhzqbTtIKogjGqntchtONOP/lF9VWYkg0uFePcBU+bR//05MObw29quoBKe
	 xCdqDoPnbVRBp55mMz6naFQB56hbna6noGOFYKLDORF8rOeq+pfJ9ijsqSnz2bBNpkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QxSXBoWw;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A86606A32A
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 09:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71A86606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QxSXBoWw
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso562556f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 01:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795168120; x=1795772920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LrQEkt8HXk1ed1syfHwtkDqVdWgo9sprdy8k9nccOT4=;
        b=QxSXBoWwFNgSQtDk7FgcCwW7Iu7sNYfShCcuyAaffjRYinW70R31yZM+yPr6wrXjjt
         Bf4ypvCIuYxbTCzsUWJFeRf8AEu0GkpIeBMjk838RaohymTeJ++xhTBHw1EGTGpu9XMz
         KXgyco+DZVAyVTUlpBQv65z13lX7OxIRmbehC1C7HySWbZUnk+JvFvoOo+RW/RhbZuXT
         LJEU4DHn35FBs0y7+1rXo6NntmSmoLsAwh/KcXyBPBt6Rm8I14A6JYeYi/6dOtC8/ig/
         /z56iB3LRlXa9yM8UWdWuNHaZ+ijxWjp2HKs7NWwO7xKLQzFisYDnwLFhf9tfVPaeW4W
         ICMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168120; x=1795772920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrQEkt8HXk1ed1syfHwtkDqVdWgo9sprdy8k9nccOT4=;
        b=PJJFS6K4a68bakMevOblGs1/PUTLLIdJyYCw4kmZP2h68xwN8/OZmT0w7IDXaEc5ys
         dUOCzzUgv4Uv9ICo+k7xYTRbIS6E3wT5JBAcV1RkeiXvw8VsC2IfHtbb1ivUp10lV3Fw
         1nisxzsAtT6q4SBnQBR5IRw3YphOVDITgusibBohwQqB+1vzPGCgMpA55oLMJwcFTpjn
         iTEsO3R3yKZfiPGfv0FSzBsVYEnls4KfmtAnb7urUSU/Zph0x3ZYX8mOcEIU1AuF/lzL
         Um9cDfzpbxpwpPvvVohcFNwfg43aC5655hPApHh+lOEfVNa+Y7QoVfdJoyuW/GU/H82t
         9cag==
X-Gm-Message-State: APuU4Z9dIvzXS1NGpfVstPosDA5MvcXzkdz+B+x25SK/23OODuw6x+V3
	fMbSzcv1aOc373AWAIoH7D39eCWRQOvNQeGPU7pYwdHNVOOFOForgkNL26PAs2gn
X-Gm-Gg: AYBFou03LkgfSV3oD31OBQCPj26SyNXREvyoOJWDgof51uk+MNQQWkoFnHdKEXknzqw
	vm46eB7swYMp8ppG6FPxPeKKRGtwzoxEOclQhAiEZFFhtEA5AeeVL2xfy9ImjzazPtc3ED3v7RN
	njdgr8j6bmnfjqSGdE079gLD50ybjS1mbVHe5t4AB0KGCXHkyFte2rVbbkVW1KtZP5ThGGI05pJ
	/P/vL8r1LpyRfuV0F+rS8elTzubeG+qREnHgPYu+7VB1dW2QOwhjpl9zZl6nSyWtcftBfrLX8bS
	8w/WHmvrNlP/JavF6fymTURp9WxBM/RXdVxuEDBsDQWQFXTrqkW5uxdq04EhlzN9sRh13WZJrAB
	v1VvZKLM24pFB/xXlYKj+3l2P3XRXa9OiKvhJLDxoiolcwoJhjaDTPJkccqkem8TPg1pEF8Ac1i
	n1fHUwuL3dUFTQ8Atm5oETvkJKr32DI6+hc5r/n9QZm6bluFhMGaz6t47WGq/w4JytVB/+/bTp3
	pOZc5PQxJfUEs26FCIJ5PErOhPlHy2TunmeWQHGDbSXe5DezGSo22Tui1duetBH13LKvvjnSnxU
	p9JIQ2TW86IOhn4H65C3HQuwNTjQTPNn/zIKBJyQImQ=
X-Received: by 2002:a05:600c:4e87:b0:4a7:6bc7:f778 with SMTP id 5b1f17b1804b1-4bb88938d38mr55542695e9.30.1795168119561;
        Fri, 20 Nov 2026 01:48:39 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f635ffsm45137535e9.4.2026.11.20.01.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:48:39 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	eddyz87@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [RFC PATCH 0/2] security: Add pre-lookup pathname open check
Date: Fri, 20 Nov 2026 11:48:18 +0200
Message-ID: <20261120094820.11929-1-tasos.papagiannnis@gmail.com>
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

Some security policies need to inspect the original open pathname, for
example to report or block suspected path traversal attempts. A resolved
pathname no longer preserves components such as "..", and requests that
fail lookup may never reach a hook exposing the resolved target.

Today, in Tetragon[1] we capture kernel-copied names through
getname/getname_flags probes and correlates them with open
results. Enforcement additionally probes do_open and passes decisions
through BPF maps to the file_open LSM hook. This requires correlating
state across several internal probes and the enforcement hook.

This series proposes security_file_open_name(), an LSM hook exposing
the kernel-copied pathname, the VFS-selected starting path, effective
open flags, creation mode and lookup flags before pathname traversal.
BPF LSM programs can inspect these arguments and reject requests before
file creation or truncation. Existing checks on the resolved object
continue to apply.

This is submitted as an RFC in order to get feedback on whether the
proposed LSM hook is a reasonable addition.

[1] https://github.com/cilium/tetragon

Anastasios Papagiannis (2):
  security: Add hook for unresolved pathname opens
  selftests/bpf: Test pathname open enforcement

 fs/namei.c                                    |  15 ++-
 include/linux/lsm_hook_defs.h                 |   2 +
 include/linux/security.h                      |  10 ++
 security/security.c                           |  27 +++++
 .../selftests/bpf/prog_tests/file_open_name.c | 103 ++++++++++++++++++
 .../selftests/bpf/progs/file_open_name.c      |  56 ++++++++++
 6 files changed, 211 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_open_name.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_open_name.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0


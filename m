Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119C343882
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464493; cv=none; b=t43Bc9Tfw1Uxi8q7EgiSpKQDusf5MG6SZ0r2+gA1ECyfFYo0RTRvCC43FrbTr+mcdE20CsIhuxnKz8tDyBQKY4RCc1xhayuKkg64J6Vxn8Wa+XAy4RVeaAcb+yPIfaIIsO3XA0W6kSD/h10N/1rP0HxQ7nMsueQlTipkFX7yJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464493; c=relaxed/simple;
	bh=4pXwrm8HEe/yPPybo7ROzJO7tVzYi40tTEffwp8UrdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4XY1/NAMjn5pXWzG21jl3wKVtlh5LQsIw4+Zd2cuAMbzE0pxoEQoM3stgmFVowscfP9h5xdzl+6lhMgfV7jzfbBOWkgDZR1BAd12nrlgkLAsjvpTCytuQXB9Y9Jr0djcDm3COT+Vi5Z6eNlzrHLxoxb/yZk1ixUkjPulBP4NoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZIfLPuQ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZIfLPuQ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-80cebd41372so6851257b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 19:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464491; x=1786069291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vb/WD/mrd6qKrKENAh+IH8pl9uBDuC0uFk5kGRLG0IU=;
        b=UZIfLPuQN37GKP0tcYcLwdjvb1KkeLwthYIMFzpVw3Th3a1QwYNOh5CUZsrC/jGDAh
         OAubSQ0PiqCJN7K40xkqPOpeqyZijJdPAzPw/134h/1hCgos6ZggabJ+2mYyJjleHUey
         IF2o21rMetvTupPtR8g3XnhtbB5q4okQbj4VwX5QHYy1r3aYlNCnQh87SeO2jDPQgfEM
         gxW/Do/bgEI38240xE10wks8YVVvGKHx2TLWzBkFBUPY/RzK9hvWQWmZRLwUR9JFjc/O
         QjXT7nvGBq4+3fnAiei4e81YCIlBfsfKOcNejWBDxoBIYeRWuHYtsx10WOR8PGwhP/gf
         HD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464491; x=1786069291;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vb/WD/mrd6qKrKENAh+IH8pl9uBDuC0uFk5kGRLG0IU=;
        b=GyJMq3d2OBv/FceKsACYn/MYUAitMSzgYTeE2YLmXgjobOCYulb75f7K5NtNDpJ7+r
         GH9X2oPPWYeoplw3B7ZM0kdof51RUNvNTdxYXgtVdpqr55VES/I3de5xdZP+O4izgECN
         i1priUsPT6pf4F18CLsdx8DNRX2szlq2i92bKB80OTlq+saOgq2R4sr2AaXqMCB43/gX
         6Nyeyx8PvxeDHnHgU2c3F25lypk8lQTQHPAphF1DpM24gbRtmJ9RTBBp5FJYxXoKzHrU
         5crL0zS0pVg9IGf100dj7qSXAvDEdd2wkWU6hrWVwzwjRkyo+7lPdAWpv+8QR1+bywEX
         lQiw==
X-Forwarded-Encrypted: i=1; AHgh+RopwjSXGkevmM8L5FIPo5wswF6DglHhMwef9BSMUI0TUJizbbfWtYEYmPakw1V6yX7UEGvBFRo2inAGDYInhYbsqNkO7a0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3drbc4KSZvsmzhbchK+DKwDsurWyubNu23f6ajjB2g7dOgIKi
	mHQdW0TQ8cAwAEdoLddXY9bu83wcih1UNj/VIZqIVxqXwy+m75wSUY10
X-Gm-Gg: AR+sD11zRFp3YSaYJFXES9wR9SvvxH6KVCGSusyeu/oJwbPMQqVQCu6izR9GjLdclTH
	4kmvsEtV5DUzV60Fxk5PnuUqR1s+3VeiVi943ZywC9ASQgqdFg1as0yHaJuDlv+RP/q7gq+W2FK
	UnQhJnoEagjNDv2lvlbgKoBBkxkYlzHXMd3K5MgjFVVVtNC7dDjLCEj/QzgwOjBBCPiksq0cdkp
	BJEPE/VfwU/TKxi3dLLqYFhpguzr5uNf9kUhog48Pe60pn7ns1TjQER0gMh/2dBWgItT1vQpRqA
	6XtNeW8kmEBKh0i83ZCMweaB2kCrVmGihxz4w8IkUDUDGNN6bMyO6WdkEUEH4isRGm/fVEpbsV3
	1KPBzYdcq3X5mUoVaOnBhnSwz7bteqQ+fZ+8ZedMizLzpFVZw9up3H/rItnFQF0O/1EF3kqCPZb
	wxhObKSi3Ubo8VhvvznECRoXlvSmPOqPsUIf0EOAAE3kW7ZsbOApKNYyVCEATUkFKIRB/ck7YP0
	jKOIEQLQieFH97N2piBTw==
X-Received: by 2002:a05:690c:63c6:b0:80c:85c6:898f with SMTP id 00721157ae682-81fcbbaa180mr512937b3.62.1785464490721;
        Thu, 30 Jul 2026 19:21:30 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:30 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 12/13] landlock: Document the BPF kfunc interface
Date: Thu, 30 Jul 2026 22:20:45 -0400
Message-ID: <20260731022047.189137-13-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Describe the new BPF kfuncs for Landlock.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/security/landlock.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index c5186526e76f..01197c7580ec 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -129,6 +129,31 @@ The reasoning is:
   restrictions, because access within the same scope is already
   allowed based on ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``.
 
+BPF kfuncs
+==========
+
+BPF programs can apply a userspace-created Landlock ruleset to an
+execution.  A syscall program (``BPF_PROG_TYPE_SYSCALL``), running in
+the context of the process that set the ruleset up, acquires the
+ruleset from its file descriptor and typically hands it over through
+a map kptr field; a sleepable LSM BPF program attached to the
+``bprm_creds_for_exec`` or ``bprm_creds_from_file`` hooks then
+enforces it on an execution.
+
+This can be used to inspect the runtime context of a pending execution,
+and enforce a Landlock policy through BPF.
+
+The restriction is staged in the Landlock blob of the
+credentials prepared for the execution and committed past the exec
+point of no return, so a failed execution leaves the calling task
+untouched.  The ``landlock_restrict_self(2)`` flags apply, with the
+exception of ``LANDLOCK_RESTRICT_SELF_TSYNC``.
+
+.. kernel-doc:: kernel/bpf/bpf_lsm.c
+    :identifiers: bpf_landlock_get_ruleset_from_fd
+                  bpf_landlock_put_ruleset
+                  bpf_landlock_restrict_binprm
+
 Tests
 =====
 
-- 
2.54.0


Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0354317145
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464507; cv=none; b=QoCd4sImNUd+PoittRlDYkkhQB59OUofZptmZ7UvvL5S5udLmMBfl8xr3VQ/hTgAFNfCOJjKL2YODm5dWQvadcZbfD+3Rd99ngo6gYy/BYVEEQDDVK/t6Whg0jFhU0o1aE9VZNbPqT1mrUY74K63UyCC2CKWqLkDqLCSlK4gfRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464507; c=relaxed/simple;
	bh=6ETYMAWu8ofZx0Y+WACFFKAJ2qtGC9uy+a+hCAKsrP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgOe7RGCLKOrxv3zmwJyDr29WdWtkiHtBYU7jA5e86OG3xfguJxmix0XwQNA1dvpaBNsYmke874LRTDK/HeSn9KMYkF8WjDf2ODMgVffj67iJOnFy114j8K0vMkhllufb5XqHRUy5C1Yszh/T3SDN1OH5wqjrHNdXM/x6jbJAXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpPIjvoX; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpPIjvoX"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66843536f94so454327d50.3
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 19:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464493; x=1786069293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tjpk63ZKju1bkNGm+aJ5Xh/f+GLe8/olsmxsdpk0+FY=;
        b=TpPIjvoX3rcrnHa8jYWkxB89VxV8ldNTsEGGEzHiBCL3IGx+Um4o0QxU2E5aocnB9e
         g3/cNUpaZz1kunK0r37Cc0/hMbm+MWkJWSdH3bLz1MMRo9t24NNinRq9C/N30ot7LqP1
         uxvk6uar55XyahJbiT3+XyKxV9bPAYb2eR0skIRMoeSKxvx9w0Gl8y5RH1UNvNftk5ba
         4tl6HstcbBsOD4iI2oTj7FG4/8Daba7ckCZ++ujaSObXqa8vrWGEKeqXpEaHg8Um4lfd
         BCmSaz1frgkP4xOjyg4HrRT8jK7DoROUdTGQHvrhSRA2HQenaZb+mxN6BFPfdNfLH14l
         dJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464493; x=1786069293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tjpk63ZKju1bkNGm+aJ5Xh/f+GLe8/olsmxsdpk0+FY=;
        b=JOmtzN7lAYCN/dXzw+DXN3wn9tqFG3itlyKGsgS1ClpHXqnZCuFmjpDhAYptQowk8K
         0SxVa5Oh3VnmHvmI2sodXyIv2Hg7mrooDlKfYZcNKVkA3JYSI9THW+uWdqDDDKnaVMPt
         5cgOu0dHEBYphRWfvZST6UR9frWZmd+juhQi83kcnoCv/4vVOkzP6kK62936m0hm/Qoo
         xd0i90g8p8CiwBYqa7AcKw6ocMK61GV8JXE2jbxPy05jEAkUPvlogo7E+dGSZRp3skVE
         xV6HMKlAGzkPBmopWKx/MLcl3x2Tssj6zhPUPCFO4fbYHWobZ1PE+kJHnuDtwbyI35+c
         RnPA==
X-Forwarded-Encrypted: i=1; AHgh+RoUBBo9MMsrEQU7G9UgjTJqxvEDKu3z3ucs0NLqV4jymbwbcazl34s14oLBAZA79QWMPetGG4/nMoiS/iPBquh19eZe8Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBSZXjbOSE5yQ8r6bSX05abWDyi0oy73OnhTFNycw6rf6FJ4Gx
	8hgY278mZWHjwpMHwo65fVfKplEOjyf5g+jtD2JnXi5fNm9dIrTsyaiT
X-Gm-Gg: AR+sD13PMMAqWZYLQuyJwsdKBSxDYTIAWdmWNvPepqMqAVhmf79FMU5ZqJ2EnFM8mJR
	9KHp926RMPkOxv6HIikYBMC32FKi1U9bVkyyVMcnbJbnnw+Tr8Ruw0Gr1Ut+ABjBl0uWsHwRV+m
	PX4OdXCooPCaceJ9c3yZ3o7CGXZDTnmqbYC4wQP8Rr7WsPYcKROTSeZ8DREIqhQYrxvQ6LoNGaF
	ZXA7MknAcDatXn5hUs3zxD6VD7atW/+ViTM0uU1l9w5RzBjA2Eog1yOJoq0zkXfN3YDVcplOeWS
	opIuXa3opPwyGDURY/DHrgNd33ZWblp+R7pxwec7PNrcP3GZ3tEAwg1yD6ltLsbLQD3K+BmRlKl
	MKZlRWzhYSnXn3trgI81SaRUJDHyWuKEHwDch5aQeX7uylnaApji0EiwmlEBCD1Q2tJHGiy664S
	tjrHYASAO8glFwVh2MzBgE8LLKLv8XI//28siO+liX4KbWQU1qC45diC2sszpYni4w/GOyD55HU
	0Jh7U6XLOtCkrkaZuVLGA==
X-Received: by 2002:a05:690c:4c11:b0:80c:85e5:8756 with SMTP id 00721157ae682-81fcbb74b6dmr533417b3.63.1785464492602;
        Thu, 30 Jul 2026 19:21:32 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:32 -0700 (PDT)
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
	Justin Suess <utilityemal77@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH bpf-next 13/13] lsm: Document the LSM policy kptr hooks
Date: Thu, 30 Jul 2026 22:20:46 -0400
Message-ID: <20260731022047.189137-14-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the split of responsibilities in lsm-development.rst: an LSM
exposes policy operations to any kernel-internal caller through
generic LSM hooks. The BPF subsystem owns the strongly typed kfuncs
built on top of them, and the providing LSM only implements ordinary
LSM hooks.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    This attempts to clarify some of the conclusions in what an LSM
    can and can't do from Paul and Casey's feedback and make it hard
    documentation. Let me know if another place is more deserving of it.

 Documentation/security/lsm-development.rst | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/security/lsm-development.rst b/Documentation/security/lsm-development.rst
index 5895e529da7f..fc3af206e795 100644
--- a/Documentation/security/lsm-development.rst
+++ b/Documentation/security/lsm-development.rst
@@ -15,3 +15,30 @@ see ``security/security.c`` and associated structures:
 
 .. kernel-doc:: security/security.c
    :export:
+
+LSM policy kptr hooks and BPF kfuncs
+====================================
+
+The LSM framework implements an interface for individual LSMs to
+expose their configuration through BPF kfuncs and kptrs. An LSM
+may not export any kfunc or other BPF interface directly.
+
+An LSM wishing to expose a BPF kfunc must reuse an existing security
+hook or implement a new sufficiently generic LSM hook for the desired
+interface. The hooks are then called from kfunc definitions in
+``kernel/bpf``. This allows LSM hooks to remain sufficiently generic
+while allowing BPF programs to take advantage of the strong typing
+and runtime checking offered by the BPF verifier.
+
+The LSM providing an operation implements the operation's hook with
+``LSM_HOOK_INIT()`` like any other hook. A BPF program calling an
+LSM kfunc therefore reaches the LSM the same way every other
+kernel caller does: through an LSM hook. The hooks backing kfuncs
+follow the usual rules for new LSM hooks: their contract must be
+LSM agnostic so that other LSMs could provide a meaningful
+implementation of the same operation.
+
+Whether the LSM providing an operation is built in and active is a
+runtime property: the kfuncs are always registered when
+``CONFIG_BPF_LSM`` is enabled. BPF program loading is thus
+independent of the boot-time LSM configuration.
-- 
2.54.0


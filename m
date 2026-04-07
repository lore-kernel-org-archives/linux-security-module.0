Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162137F724
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592158; cv=none; b=Y543K1/rLaxxWdLHzJtS5P/llpLOaIh4OeIjLNYyrV48u8jaVVc/Equ9+uiuvfjyRMSvLyunUo5uKU1gFvDqKCjDvykwaqBqtl66vtOCzMSdj5YlbSo2dxuRRC9n/zQ8ZtX/mulEot7uLANkfxtT9LFQoF44DIPAciMjEeDe0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592158; c=relaxed/simple;
	bh=969N04GJ63B6j3UvBpT8Xq+THHPJF5melGvVjbfv/jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VupIuTyCO99j+o/LZYh6vqDHtE9mKwB8Lro21PH0XIgoqGUDx1dp3BK+KeLqogZiuBjRE6XCJFw4PcMOM3dv2BZjWIqHnbai2ul/zxlvKzt1X54OM9LFtI5qTrmV/Wqe5p5vWBOdbhG/G+PnhbNhAj94Fk/u+QcmPLocG5ZZ9DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spWqyiDj; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spWqyiDj"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64937edbc9eso4949969d50.2
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592155; x=1776196955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kh9HwIL+CvvpNMQ+fa0HjatniWcHatd9mVcMTjGbHyI=;
        b=spWqyiDjKcQ76GvS9Qi99Hn61LwzbS++wKhAPzlridqIFzKfA1ld25/YXV89n4mg22
         xmzPYZf9KjaoFVvry1OHp0MjGXcgHO8L+9LGXczqji417tU5ebWeluzX1ao2Vi0Cmjuq
         4t5WCv/a5mBZyjLy5jNzVvc5MLqUbsFRwWwF03E4g17tGkZpZGtSmxp48dw4dlROoE7y
         qtDwWJjaRnYVM6cKu5rgmCHRAlQfPtgPqpJ7Bku1ML4XOEqRh28YhG8qG2LF2b9UloOv
         esMDjao0zUfe41Dm27hlrCUL/cJhuh0Mk3RXdAzZYEIZneuK8xxcNmrgubNDox51uhfB
         RUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592155; x=1776196955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kh9HwIL+CvvpNMQ+fa0HjatniWcHatd9mVcMTjGbHyI=;
        b=FEEIt+dztGbwpfWUjNGNqpj6P1jymPqzaj/x3Mpz4rMLfPLv28AcHiOdAwYrrCFFG+
         idtS9Ojy0GEa4+W6JhLYS5r95PFe9L47un4j9+AGYJ5q4YDdU+7ho+fEoFUprzD52nOl
         PyCvqqYU0++NpBJSxB5lpdk4IuAN26vQEKfSh6ATQ4NsDO3y1NEho/a7c4gmMRlO9Wd0
         eS7ufzwm/9oMd6Hn4/NF2rz6hnR7AfEJzkPXkbzXOgcicJFjF0HAMa/uCa2kD0b42c/X
         /R855bWDXuLaOTgK1NrBWc8QhzEA5MTiKLgQz4qAzcF0rOPuX4LmNe8MOoGdejSuZyPP
         xNkw==
X-Forwarded-Encrypted: i=1; AJvYcCXfvw/MhUWxihwwrGJQeghg9aC9Sb/IRGWUYaGxzsuym8KQPnytKK8WQ8d107QdFdLeng8TusjzwXiesDBNrfXCmWYYwJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPqXJ64gw5gefPaD9nvZxjPvIKtUNFRkt+V4SXJJJB1rVkzS5n
	a4s8G2+XwD4tk5xCCF6yRhd4xHr91P2SdAKG2RjgATaoumxhKTDRO399
X-Gm-Gg: AeBDiete1mrhfl/EcxYZPuz7y9ms9+FahPM7EYhNlwg03On2E4cbJpFe9h6GGtLocVQ
	URzQ91nE9X5CVpaROFB2exBF3Jr0sjKwVrOPuiSFTA9BfXYTZ+0Xnmr8vuhSFFCBPESlPFsACv8
	M/OR2S6fPE9vZXDGZXwdtU3h11g2te4T2t+zyzggqygm4cFyvKE5iLU91EgfTxvVyoxsW43XfJQ
	AEtiSE2ELO6LPcCPzBgICY/CQUBOMs+ouS3bUveNXD5+O/AqfBTHRSCaoyKjgPtNFHHBDOZGY4r
	1Xa4LWR5ldH7kyAxpWrnu/w9xZ35os3SsAyLfd8Zsw/syugXkCUSJRhuaMEh73flNwlSEZhy56u
	a3011AEeQxp1S1oGZXl3iRYDY4lZzoW3Ixp9BHgST68k//cxL+s6k0M4jZ1i9mqYMw7yfZ6NYcL
	MtdDMODEU7nzKv32un28fawac6dDilIv/y7McTK42Q5gmRxGBd93WjsYdHCx/LJuOABZ5MoccP
X-Received: by 2002:a05:690e:4812:b0:64e:c641:d06b with SMTP id 956f58d0204a3-6504869ce58mr13854064d50.6.1775592155586;
        Tue, 07 Apr 2026 13:02:35 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:35 -0700 (PDT)
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
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 11/20] selftests/bpf: Add Landlock kfunc declarations
Date: Tue,  7 Apr 2026 16:01:33 -0400
Message-ID: <20260407200157.3874806-12-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the Landlock kfuncs to the BPF selftests.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 7dad01439391..00f2b337a232 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -79,6 +79,26 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
 
+struct bpf_landlock_ruleset;
+/*
+ * Description
+ *  Put a Landlock ruleset obtained from a Landlock ruleset map lookup.
+ */
+
+void bpf_landlock_put_ruleset(const struct bpf_landlock_ruleset *ruleset)
+	__ksym __weak;
+/*
+ * Description
+ *  Modifies the credential of the passed binary parameters to enforce the
+ *  provided landlock ruleset on the new credentials. The ruleset should
+ *  have been obtained from a Landlock ruleset map lookup.
+ * Returns
+ *  Error code same as those returned by landlock_restrict_self
+ */
+int bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
+		const struct bpf_landlock_ruleset *ruleset,
+		__u32 flags) __ksym __weak;
+
 struct dentry;
 /* Description
  *  Returns xattr of a dentry
-- 
2.53.0


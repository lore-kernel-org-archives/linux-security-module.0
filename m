Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A63235F5F9
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592155; cv=none; b=IamkBI4CDegX7blSAixloGBNMYbmLYNglDaCjQxStkGu3J8pykRZQl7GJ3HBdR2oj/CfrIXvjSvARZk0UWpiGaoduvIfCLkYbuT5rQr1XZIX38wff/15OjEp8PO6xEBjWpcWwCY57Dfw11uHqKRIGa+i6d6A0uEZ1Lf6h1tHSMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592155; c=relaxed/simple;
	bh=oDGccJGbJlS5oEKY6wi1//U3cO/8pqhENd08XnBAFsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/a9uD0ub5PdPZ3Y/Zx6PxNJsypp5BaDtIWqMZBpjWOxF+PJ8/P1gJOM3eXbeGGcNhGxdZE7yik8K/HJ31juD8kzxRJ5o2VNdPaZiNzqSPYfMYyX34fFbVgbmOGYtq4LyxGNeG7dGCAr0fmGY0Vnx7NA4yEm3xavFogUM04t20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNUmlfUt; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNUmlfUt"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6501725d888so4371289d50.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592153; x=1776196953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVuog/6PNKtU3Y12cDCMa25hSzMRaoPl9mUO+ZR3Rs8=;
        b=fNUmlfUtnxmN4gTTLADjufGaCm4+GOc31J77fV5J2ypNLL1vvBwGxn7NQVPuxqyn0w
         QXGTeIZ5liEpgfBJ4x40sbzgEDAdS01bfjqK3L1CQgNJGVxe7jCwRQdEWmvLaZf1nyWN
         DDz38eCNW+moQFkTs+bqCVAcDcLgOF2lRKcq7IPSl3I5rurEhtAOfOJMNQaFBX6PIdZG
         4d4DRyvFD8Bfpht+QDWXglueWqXXqAFMADy2kUf1r0bZOhSMI+igy8vS5duF3PawNkFf
         elc13+3+/8HFcau46tBbqp2j7Qg0ktw94r//Uwdc3POP1TExokx99OYfpwzboNP2N0qJ
         kgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592153; x=1776196953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVuog/6PNKtU3Y12cDCMa25hSzMRaoPl9mUO+ZR3Rs8=;
        b=I560CbebjD8VkMhsTTvrAU9ZV4GHoayJxYCqIicVCZOlXYC9wN46e87PNMqTsPO5k0
         cDjXi68sD0VXkOsHY2KL0xmepcXBvQXr8s9VEw5EzbJ4ulS2YYyYwViu4NnJHT8XTW7x
         VQJCDpIS9DbxaOWZbkRZMJ2C5ZpcM6fRCl72KvORd3sdURrn8iiGL8Qk8pFvhIpMaDgO
         VcfU0QZf9gHe3uqVbBu0wy3KxGugZrtuLws1SDXTg+pqclWYSjaRN78Y5pZPgGfyL2ed
         jBHp9rvsmz6JhLfll4509HPIyru2ps2eZPIm449JYbuBCAS1GnI3IKCtDLBFODU1vTA6
         SC1w==
X-Forwarded-Encrypted: i=1; AJvYcCWtA79Blru+gHHAU2Rl3slFAcz6NhyjJnGsRNKljazj53I7qGKvZFaatKPdhmC+aVTHrrogcEjTwihcb87Od+9IK0sFHP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5eU94hj9K1R3YN0S81hOOCk/vCx3UTb/4jmyJv0A3LcJv8TKL
	UJrQEjPgzEHMatrehCXCWBnKe2tzezHfoACMw3QpGEOQ4FMgywTit2kn
X-Gm-Gg: AeBDieu1X6MU7kC+AmzOrVA3iu3RB4BgosfiuD+048VFfRT9i+sbe2b2Yr6m9iL6xn8
	izg7QSJO8hTil5SS+8a7WzPP9u1SUIsmCYfaLnjD4hEs2oP57j91OR0rRIi/hpbYD/3ot1JDRzb
	1QHt3roSLIx4o7PCOdivWJ1EpJ7aJU4K77Ouq3OprHNpGIjf6PSPxGoU/bz7UFh4T+3c06UgR1X
	EbV2yyv2xbSYp9yZxhOMBm/sNXR3a2/mGZMDhGF3+lyhEPn310dJdw78iOz9iYMVvAPdJuDL5Xj
	lrK3COKvRi/OU+78AMtBkHlHK1aDZ+t1qb6MEhXzzXznlACBx9wii8R/R1dsUvF0IgHz8kL0xIK
	OzXeRxWd4/RoVU5nfGVJL/LXyuHx/Ak3Bc/3R76AqMLGuVkRdpn4w6uzfo6mC7KL8K+QWqDlxse
	FPMjioCyrOAlgKnduR7kPiA67uYk28eVoYiNQi105u0n14k5/6lohfq2kDCNudVonpoC3aD2Z9
X-Received: by 2002:a05:690e:140b:b0:650:1aa5:8568 with SMTP id 956f58d0204a3-6504887abe9mr16658180d50.55.1775592153359;
        Tue, 07 Apr 2026 13:02:33 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:33 -0700 (PDT)
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
Subject: [RFC PATCH 10/20] bpf: verifier: Add Landlock ruleset map support
Date: Tue,  7 Apr 2026 16:01:32 -0400
Message-ID: <20260407200157.3874806-11-utilityemal77@gmail.com>
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

Add support for the BPF_MAP_TYPE_LANDLOCK_RULESET in the verifier. Mark
the map as storing a trusted pointer to a BTF object.

Specify the map as being usable from sleepable contexts.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/verifier.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f108c01ff6d0..52ba58536387 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -493,7 +493,8 @@ static bool is_acquire_function(enum bpf_func_id func_id,
 
 	if (func_id == BPF_FUNC_map_lookup_elem &&
 	    (map_type == BPF_MAP_TYPE_SOCKMAP ||
-	     map_type == BPF_MAP_TYPE_SOCKHASH))
+	     map_type == BPF_MAP_TYPE_SOCKHASH ||
+	     map_type == BPF_MAP_TYPE_LANDLOCK_RULESET))
 		return true;
 
 	return false;
@@ -2269,6 +2270,10 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 		} else if (map->map_type == BPF_MAP_TYPE_SOCKMAP ||
 			   map->map_type == BPF_MAP_TYPE_SOCKHASH) {
 			reg->type = PTR_TO_SOCKET;
+		} else if (map->map_type == BPF_MAP_TYPE_LANDLOCK_RULESET) {
+			reg->type = PTR_TO_BTF_ID | PTR_TRUSTED;
+			reg->btf = btf_vmlinux;
+			reg->btf_id = *bpf_landlock_ruleset_btf_ids;
 		} else {
 			reg->type = PTR_TO_MAP_VALUE;
 		}
@@ -10238,6 +10243,13 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    !may_update_sockmap(env, func_id))
 			goto error;
 		break;
+	case BPF_MAP_TYPE_LANDLOCK_RULESET:
+		if (resolve_prog_type(env->prog) != BPF_PROG_TYPE_LSM)
+			goto error;
+		if (func_id != BPF_FUNC_map_lookup_elem &&
+		    func_id != BPF_FUNC_map_delete_elem)
+			goto error;
+		break;
 	case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
 		if (func_id != BPF_FUNC_sk_select_reuseport)
 			goto error;
@@ -21662,6 +21674,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_ARENA:
 		case BPF_MAP_TYPE_INSN_ARRAY:
 		case BPF_MAP_TYPE_PROG_ARRAY:
+		case BPF_MAP_TYPE_LANDLOCK_RULESET:
 			break;
 		default:
 			verbose(env,
-- 
2.53.0


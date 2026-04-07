Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ACE37CD5D
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592150; cv=none; b=VCXgMlhzLGN6Dgdny82RGXiEekHtPmBkw6ZBUu12ScwcWrMfzJYMhQ/jSPKtPCAhtvjUW7LjteiHqS+tccxDD9ri435/Y6rky4rmTqUKdv/tfcqKeBM4DwoZ29m1KUVhoS5H0rYajzuGl0X57jFIz3Fuovkmed3ZLrR6pvoI5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592150; c=relaxed/simple;
	bh=bW9jz2Y0w7pnnRcWTatuVDGC9064zzuyQi3gRAondUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5LZAm36uwUcPWPsQGUB8x8uHQFbbZyzRqQ8d9mq8HM6RSXeVgcWrT344UG/VwJKoyM0M46aEMl6XlbrqE+Cjo7UpkJIYQX2OejGfO4Q9/iGp4aONj4dY/p2JVoTLj7LH2i3PO8F+PP/4ExKMo3I5y5W5gP0KM8LPMoKQ15vkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJGmK7g2; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJGmK7g2"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6507a833e68so1520577d50.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592149; x=1776196949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbO5GYpy+e8XYWD7ulHkPHCIvEhrOf0qMakkPgadiYg=;
        b=PJGmK7g2HrZ1yMOzrIjRn57Z7PCpDvJDbrpQfLJ3A3pXWwmW0APKd3Anf8IPOew3jH
         BmOKUb2BtW0QivxjIAUSfg0Enl2dZRnAdnu0CgRPcbkCmgGdBQI7PQbZTb5jMjYnOXYa
         eLPUsdsRi2SsQSPSs16SRb7ynH8KHYl2FcQxTAjtv/kiyOIbZuMCu3wdrp2jyOx/eVpO
         FBZpbZxrRy5wHvICFDIor7BAhrkidG7mXod9DkpfzsiV4l35l5MSfAhU2DUM9iDN0ccF
         4lpT0QBM8hozl1+VwmJB9GSY0DHjCudNV0W5zFEPJQrD1GLXj9gQd1Z2y20/u1uN0qpw
         6CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592149; x=1776196949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rbO5GYpy+e8XYWD7ulHkPHCIvEhrOf0qMakkPgadiYg=;
        b=Ycuqm/tlhfb62H2XArmyM/htFjEjSlA6Uy8/0eR56AL34TjPkMGk7HCEVsDT6TzBUI
         zY01Eh4BhxesJD8+edR51gEXliaVaZbPh+1J5ivrQXeusQLr5yECG6bil+i6FyCFFcKB
         WYLcQiHBnJvhLx1hPhbScJfPx2hoYKHRASdGN5fZuO7qiG0sUAc30VhgdwqzQNUtZZ05
         DgePpxnWbk5niZvrjQCS334WswXrBXCvelxPLFXXFzofrdFNooonHvTbwud3pWE3yPRK
         fLGRON5aF45u85IUActkdDRob/SwDJ0nuqAQ75RCk7yLXFiBzt+aLlYa220BbOWlLJWk
         DENg==
X-Forwarded-Encrypted: i=1; AJvYcCU7A97qWsIw346alPCqEcEdrnzvS53Kcn1irqJczEMeNQNaQSqpyBppi7k9OoEF5l+B1DebL9GGk5t9v8CktqjwQJnDolQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0JG48g6y8IGx3NIUo+onmEXhcRovJlgHBeyQe6HlSxLLOqx/5
	KWeRz+LwobSjYQqEPXreTeXegzD+k0fzDXUq/58ukA1bZrwcSBHOlGtJ
X-Gm-Gg: AeBDieusajkdBy6u1mgOCMpsCFUSYjtcA/AUpbou6mwWUYXqPwwQCmSDqsN7Yu8+GTe
	VzeTv7VrL12Ay7kYzCdkQiQpI++t8TArGAInO/g/QtdWKxTScwleKtkav1axybYOPLjS39qMlax
	FEt/LpkolXhe9MJrjqrr7Cj7teIJkUMrblqn0eCj0Z4XPLyc/P4q8uziEMM9/L2snfb1G7TDUmn
	E2doTVA5D0DOw3CM/qZzTZB/rNS6vXlCA8uhZFb0tbK7CWWewigXM/IyoNgl6ecFal71DQVWXIX
	NvV9oLzCZq/TmZBW9CVy4Bo3pjEqyiPm6lUx8tYJAU0jwYZBjswlD/GWNq40rhbfOwvM0MsDrUs
	FkXW+4VIH9SDSv8YDTX8UuLzbt+4vMtHb8kZ7ccKiIEulqAtnSeCcFgu287IVIV53CFYexQwuvm
	NmEISC/VfXeeKjg52jK1AUb9dE/mvzV9TvFWmmBP6TCcqqqDWxcstPtjoD84jonMeW4QjmmRYEk
	/VdQGO134g=
X-Received: by 2002:a05:690e:b89:b0:650:5316:171d with SMTP id 956f58d0204a3-65053162228mr13914052d50.40.1775592147694;
        Tue, 07 Apr 2026 13:02:27 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:27 -0700 (PDT)
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
Subject: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
Date: Tue,  7 Apr 2026 16:01:30 -0400
Message-ID: <20260407200157.3874806-9-utilityemal77@gmail.com>
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

Expose the new BPF_MAP_TYPE_LANDLOCK_RULESET via headers, allowing
programs to utilize the map.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/linux/bpf_types.h      | 1 +
 include/uapi/linux/bpf.h       | 1 +
 tools/include/uapi/linux/bpf.h | 1 +
 tools/lib/bpf/libbpf.c         | 1 +
 tools/lib/bpf/libbpf_probes.c  | 6 ++++++
 5 files changed, 10 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index b13de31e163f..0fa3b9031d90 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -134,6 +134,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_INSN_ARRAY, insn_array_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_LANDLOCK_RULESET, landlock_ruleset_map_ops)
 
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8d400b7680a..7e4478afa162 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1046,6 +1046,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
 	BPF_MAP_TYPE_INSN_ARRAY,
+	BPF_MAP_TYPE_LANDLOCK_RULESET,
 	__MAX_BPF_MAP_TYPE
 };
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5e38b4887de6..6dd7d70b198a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1046,6 +1046,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
 	BPF_MAP_TYPE_INSN_ARRAY,
+	BPF_MAP_TYPE_LANDLOCK_RULESET,
 	__MAX_BPF_MAP_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..9ccd5df1ea6c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -192,6 +192,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_CGRP_STORAGE]		= "cgrp_storage",
 	[BPF_MAP_TYPE_ARENA]			= "arena",
 	[BPF_MAP_TYPE_INSN_ARRAY]		= "insn_array",
+	[BPF_MAP_TYPE_LANDLOCK_RULESET]		= "landlock_ruleset",
 };
 
 static const char * const prog_type_name[] = {
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index bccf4bb747e1..1407d54aef67 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -367,6 +367,12 @@ static int probe_map_create(enum bpf_map_type map_type)
 	case BPF_MAP_TYPE_INSN_ARRAY:
 		key_size	= sizeof(__u32);
 		value_size	= sizeof(struct bpf_insn_array_value);
+		max_entries	= 1;
+		break;
+	case BPF_MAP_TYPE_LANDLOCK_RULESET:
+		key_size	= sizeof(__u32);
+		value_size	= sizeof(__u32);
+		max_entries	= 1;
 		break;
 	case BPF_MAP_TYPE_UNSPEC:
 	default:
-- 
2.53.0


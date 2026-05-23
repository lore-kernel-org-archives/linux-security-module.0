Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC89235972
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779552033; cv=none; b=dzNT6YJpligCxq8OfBI840IAoUjn6dNU/vTw6foLK1TnWpKJbtFbPBCG+NXIUFcspYs5CzwVBZsvl7JJWJsVvICrMRlAqPFLoc/rmfbj2ZRq3iucV+h3S+dlf1bM3PYqJIy4I1UDLbtBRACMipfgtCCCdlHPuG4rkJWJJtXYAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779552033; c=relaxed/simple;
	bh=D/x8usnB5ajIhBy2PeUrrXP7yx/0Jn19puJ4vENcs6w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YSC+iwv/PnV1+wzY5Tfe7FL+jBoUTQznsfXR9P5u418d1TClCZ9sjktPR+qR2vBSOqIJK7Iz6oXRdULlQeIGXfUqoJvv4rZld9m9EJGAIW0y0sRg2buI60hzHZdzffRiLmNf+CDHmjhP5UolEhpqAhRtDuujSjJxJQLC+a5WAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XLzVWfyV; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XLzVWfyV"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-90b2fcf90a0so1131936085a.1
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779552031; x=1780156831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FWD7BWDYZBw/gKocdgdJ5q9U2RLUzktkAiTp++3aV34=;
        b=XLzVWfyVUMwSpnKLdHx5faGFeCarIYsQTcZEQiTwN3YdsMw6BvuKa8q6QymdMajT99
         fR78me0olx+bxj6cMuHaluHl1WMAONxSQkG3TMwKnsB+AUVsRy9KZRsUCXyAMVWFH5nm
         rNhn2602+AZzvzn8Z20IuQ4ELayNim91eLDyk3IeH7EVX+H7l8lbus+KRlDgdDd6mVnD
         vQDt5QHiMIy1iksQCWWnVkLpy5qs8Wmy06x4PZC9qPsVtC9kToFeljnfduhq5P+P2jm9
         mIE18kNJn4eJ/dWSr+CRsCV4v6mJf9jWeZMs4BsoMxwgMaOWG49FBg3kzlLFTKeLPBAU
         Tu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779552031; x=1780156831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWD7BWDYZBw/gKocdgdJ5q9U2RLUzktkAiTp++3aV34=;
        b=rq5K5hW/XsLd/CSl6emwcpFTLS7oWU4tplMPmX+oR96z5iLxFo5OK8AU1Gpz+itNJR
         iuueGBwTQ00wXNpQmuMoCsIF2SWutjTUso8SApZd5lfbzawgFqeXJtzsq3O4nBWrV2H5
         BPK7khAa8P2Ieo3FIgMKLZSa9AP+kgnB/qE/5mv5ZdQMFKeFBkP+rBf8W01ZAlg9ErlH
         ToiKi1lyIsVfiTNJyQZZQzKj8GMPim38rbHprv0DkQEN1r/hPLHNvigU9cF16I9DZgjc
         cgw3MuMul+FzoLauyB2lsqScZi/xGtCpc9vgUDK3azLS13ed4p0OdFR0/Na3Lj8wufS2
         sdzA==
X-Forwarded-Encrypted: i=1; AFNElJ82f1gj3CpDwc+kgpeHR47q56pzu/kQHyDmqVJfx4Tv4OFdISt9addM/QlutywIWylKJu5DFfdNuZzIgflthGa0YSzkB1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/S70Wba6ZDeR1pxNVuu5C/tcaCKifO8UxisoNKehn00TaCb3A
	g08d+cnPzetdfgrBlKGRqKQJLtYgjTpb9NT66s256ivOhWp1kVgFOy3W0mltSEKxrutdYdFbZDW
	LR0nN5WGH
X-Gm-Gg: Acq92OECDDZ0Pihe1fNs68qhtGYKaOvPFyO+H2ZcA/NOccAm86N7qgA8Py1zuESRhln
	3gubSniNq1IlZOhiAIGIvBPRQltQbELykIwJRizkgBhsPV/LYYwOmlOY1xkHcFD4p8w1xPgsnrU
	41XEVz+aJ4Xzg35sHLkLzKG7iSIdQaIGV6/Aj0wdXkjFBLvr/Rj+ejkYxJDXq23ZWOpE6XmvE3j
	VxU4rBKMqndb7EvPZew/0lbZn7KNj10XSrx+9sLz8/gL2qNwBKKB2AAow+hfvwACEHcj9XTUIH6
	Ed+ijfx2Xl25ILRFSvDezVGdg6br09FTDbTjENKk8M3eYmM+Zu5DtRU+yfb4HAXPGS3AmJ53jsm
	piJAoNPz/vjob0XQ0wc53+CN2XZRhltZwx9qYnK33eflSMRK9x+play/yvSO2Fy9H5UZ9Ljz16w
	AAbZhxT3w9ODCm42vMaamdCoP8CTOy+/Aow7z1rW/F2c7ZvaPXcxdLjWkanRo=
X-Received: by 2002:a05:620a:4511:b0:911:7100:86b2 with SMTP id af79cd13be357-914a23a292cmr1625172385a.22.1779552030566;
        Sat, 23 May 2026 09:00:30 -0700 (PDT)
Received: from localhost (h7.113.131.40.static.ip.windstream.net. [40.131.113.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb906fb3sm429773885a.19.2026.05.23.09.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 09:00:29 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] lsm,bpf: fix security_bpf_prog_load() error handling
Date: Sat, 23 May 2026 12:00:26 -0400
Message-ID: <20260523160025.16363-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=paul@paul-moore.com; h=from:subject; bh=D/x8usnB5ajIhBy2PeUrrXP7yx/0Jn19puJ4vENcs6w=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqEc8ZgAKD0VJTH0uL4NBeAbLYbYm8H58uih3JN ohWO/MMflCJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCahHPGQAKCRDqIPLalzeJ c6qKD/90S40zZWZS8w7kqtjvvhazaPuufM/d7pvzKsx6KFwVlyRdi9VPTPUVJB9AoSSCa5ondr7 agjLNvwsxWQ6jn2VGv3YQTYtKX6Aj50dJO9ZxKMsA/LnCio8opHg6nuxyHqprZhMrxQeRMyfSEq fWwbG9i1wQDNe8Sc+3xP7TgXyHkX0VnFzwhxSQ5oCJo+opb5nPWMb4ZNwj1EvaHfs3LVTJEUmA/ xP6ORZDh19Ywa30Lbtke1ibwPB9908Vrqzposr6EfqR7chcupPEevYBuRfkfSYKcoPev9JaO6Fd GVAmQ73r2JwjZMd3309QQB6vg2cgu0NWALYqgPGrDZktvkfhPro+dhbNPyKyrSQmudAgtqbBuzT 02GBENtqU4azqYz0FnS+6xc9IqD42qV5MF8p1AhBMnLwf18ZEsTKFhMpYWnv74EvVXzUIBVyUna fnGaaY0yalj3z6evqCfkKfL4TkqqwGx4FyPXQv5jEsPSCTg7gyJ6L/QXJAra3/S/QvCLiKjVxD/ QNEO+ta2iTM5BXuI2IusU3pp5VQ9YVzX84A2jq6n0cqG0NH/svJ2OceESsQQ8xP2q/aadJdNc/o /oZBE9isDkKtAVfgsb8kV/LnUfJAj56/kmzOkL7EfSXyGFMM0G+oias5PkAU2TLiMOdMbUx5yd3 Gpxe1OQuncv9Mmw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

If security_bpf_prog_load() fails there is no need to call into
security_bpf_prog_free() as the LSM will handle the cleanup of any partial
LSM state before returning to the caller with an error.  Thankfully this
isn't an issue with any of the existing code as the LSMs which currently
provide BPF hook callback implementations don't allocate any internal
state, but this is something we want to fix for potential future users.

Cc: bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 kernel/bpf/syscall.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a3c0214ca934..ac07280098e9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3076,7 +3076,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 
 	err = security_bpf_prog_load(prog, attr, token, uattr.is_kernel);
 	if (err)
-		goto free_prog_sec;
+		goto free_prog;
 
 	/* run eBPF verifier */
 	err = bpf_check(&prog, attr, uattr, uattr_size);
@@ -3122,8 +3122,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	__bpf_prog_put_noref(prog, prog->aux->real_func_cnt);
 	return err;
 
-free_prog_sec:
-	security_bpf_prog_free(prog);
 free_prog:
 	free_uid(prog->aux->user);
 	if (prog->aux->attach_btf)
-- 
2.54.0


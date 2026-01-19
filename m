Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F41521420B
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825304; cv=none; b=PH3O/U+vhQmjwbRWwtyqCIfDbvpPKKA48uExtfOWiuP09rnE6CCWh/r9bIWBQsNxkUVXIG4xJPt55fTDkAw3EOCdS9OKaqtgvf//l5EQmOoCVALbuMZqNSCJqfkPSzETGvjZg6b0wI63Mjf1xwBRKaRCXDOg3W/Pxf0WSxEt5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825304; c=relaxed/simple;
	bh=3l3SqMDoP1Pw7PBdwa/zu8XNUdLvd8Xz3mOxLUi8yRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MCqYkBPy8qZ54SgOoDCfm1fMX0pYM1YoRZHvHiSt9mik5LHc4sSAYFLbtxq0hOXauOoaUHJL42qEQogw/qdEBmLAhKXa/f+cjveVERPc9IPI2+WECts1BAl4I6eKUl2QRepZMxwdvD9gGSQ3cgmmsx6r4VfbOGGbcJXF7jjyLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXQpVt+s; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXQpVt+s"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7926b269f03so35488067b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 04:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768825301; x=1769430101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y8g1Nep66Hb2o5ywZmQKK5xS7oJRmgLsmW5flAXw3ZA=;
        b=DXQpVt+snu0g8psT8LWdlUnxL+Z+EFwgePtjU4DI1BtlYWVwpBzFhIBISRPlHHUqoC
         Rh4O8yQsXtYTZSd/scqry2uheVBM8oVCMzXiOHUxVFEvy+vy475E1EX1j/Ozuxrg5EKI
         5jOfiv6iIkfdUuqOILrOjynBODpDvOiVevESaydE3KBe7wimB47dyiQsvjVK0XNDE9Np
         FGqIehT6Y6RmB8pEA6nFdGQzY/vPeNEUwQRxq7MHTmL37MRTpzgCiM+54eOC1/PPVFOu
         7IVEyiQaqbfwFrNcDjNYimij8cxxH3caL0SFwy6mOKjG7e/N9MSe53Y9IGeaXI55pybw
         oR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768825301; x=1769430101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8g1Nep66Hb2o5ywZmQKK5xS7oJRmgLsmW5flAXw3ZA=;
        b=qZUl2JHbjSWCKntUW3GDQApUU2SkiUqfyYJ4XXAtY6USLw2K9IOfdlElcDK8hr/u4F
         s9Z7D3GMJkH3E0hMjAvyMqQG+h6+CFacfSpbekO22dXTBNP44mnx/mHGS0/MW3NcmJCh
         wDIO+Jg14Sui4igS35G2umLb5dRkX44jBCbuNNqbEmmt6Gt7cAmRTlmcOHbb29sZWMjJ
         4Z3kKWp8rCpgPRylOng9eQWZmkq1n4Q/F+VqwLEsrBRY3tLTZlopdblCtpRRlCrQ29eD
         c0f+5pBC66XoyUxQvpf9UuWZGv6XlBUSA9Z0QsW2VZ15vu8T12Ibq1j/H2zC9fcDEKQ1
         B1VA==
X-Gm-Message-State: AOJu0YwlkmhzLZUF0ahXu/Li9Kcn+nea3WJ38nKNm2ehOXGsfVCv1I8y
	WRigE6ldCFIwDIKtHMBp/dhxtUbMkiyv3JQnqXkAOsz4j5sbiHkAifn1
X-Gm-Gg: AZuq6aIScJ1y9OSv5fmwREvKvcWrdN4z9DVQcckmXSo+q0/1h551G4B2F9pkdrApZQI
	Iuvrs8YBUJIOBEQWbhH6rJicXmRrzBlysClq69VgKSjlWqU2u+jFYYYa6cCp2IvbqLUdG6wwBO2
	yNHyvsnnLB+/7Yq5uU7JlZLPfdLUaXozZ+NXZCyiXufPSgMYQwyFoVu8JgZt4TXW7NI7omXq4SW
	GCOdbcqcveMlZQLh5ei5YKEwiVT4kcAMzzdSWyJpMrO06n86XN1OFTlVQbkN25GS1O79GtI/WxP
	SkqCku2ThJb/TJ/YMoOSUg1Urz5PD91dgrXc3sbkCNpsbOL0O/K0sa/VRLfFLnqGwKcmraiKGg4
	lkjL6Z26umn+qAwWI7/HQu95VUyDWTF9yIVl1Uo5VflSsbkZrTNvK69g0LvFCsq2Ec4jUQaVW1m
	Ch1Ay/x6fm/d+zOYi7hMUNu33g0aI=
X-Received: by 2002:a05:690c:e3ec:b0:793:d0b2:ff08 with SMTP id 00721157ae682-793d0b30206mr160688377b3.8.1768825301553;
        Mon, 19 Jan 2026 04:21:41 -0800 (PST)
Received: from msi2.sky.cl ([2600:1700:65a1:210::47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66f326bsm39600677b3.19.2026.01.19.04.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:21:41 -0800 (PST)
From: Zhengmian Hu <huzhengmian@gmail.com>
To: john.johansen@canonical.com,
	john@apparmor.net,
	apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhengmian Hu <huzhengmian@gmail.com>
Subject: [PATCH 0/1] apparmor: avoid per-cpu hold underflow in aa_get_buffer
Date: Mon, 19 Jan 2026 07:21:18 -0500
Message-ID: <20260119122119.3648154-1-huzhengmian@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series fixes a per-cpu hold counter underflow in the AppArmor buffer
cache. Under high-frequency execve workloads with AppArmor enabled, cache->hold
can wrap to UINT_MAX, preventing buffers from returning to the global list and
forcing repeated kmalloc(aa_g_path_max) allocations.

Summary:
On high-frequency execve workloads with AppArmor enabled, the per-CPU buffer
cache can enter a pathological state: aa_get_buffer() decrements hold even
when it is already zero, causing an unsigned underflow. The resulting huge
hold value prevents aa_put_buffer() from refilling the global list, which
starves other CPUs and forces repeated kmalloc(aa_g_path_max) allocations.
Because the AppArmor pool does not shrink, this accumulates into large
kmalloc-8k slab growth over time.

Repro (QEMU TCG, 4 vCPU, 1 GiB RAM, v6.16):
- Unpatched: kmalloc-8k objects grow 12->16 in 120s (run1), 16->20 in 120s (run2)
- Patched: kmalloc-8k stays at 12 for 120s

Notes:
This fix targets the observed underflow mechanism without changing the overall
AppArmor buffer pool design. Happy to provide the reproduction script and logs
on request.

Thanks,
Zhengmian Hu

Zhengmian Hu (1):
  apparmor: avoid per-cpu hold underflow in aa_get_buffer

 security/apparmor/lsm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.52.0

Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577EFBE7
	for <linux-security-module@vger.kernel.org>; Thu,  1 Feb 2024 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784239; cv=none; b=VvqVU5LUfXvpZN5CEr+fX7Ciw/LeqzB3rwM45zi9JoNb7JDXFMvkb4pMQPJKSencMIdIqrYho4/P2vI6fHDZQIWbzKKJArDgfmeknzlH6pmU687x+xwmhmmS4yd/VWae1jO2KLA1iwAHTcUs4dbUxXjMjRnxB84BbOK/v4M9ELM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784239; c=relaxed/simple;
	bh=9vJydgfn4ebhmREjnCt1JSAWwvosN2fee922Ag4aRf0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tr7rGBi8qV+drPKqA9Dk12JFNOnnGm00E5u7dGDCmnSiDL3UOgKlJ38Jx2QLOCTB1Gjj68PuXLOUF49GCUsfQM5fOkTgIXJlU8Iuo+7Eusajh3qe65JRc9SpBj4bF9WK0UtutrnEjkJznc/n5BULpTADd3nQu2DR1gy89ZXpe44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qqSu8mra; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qqSu8mra"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a363961b96aso91750766b.3
        for <linux-security-module@vger.kernel.org>; Thu, 01 Feb 2024 02:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706784236; x=1707389036; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2B+7wJNwOqpjQdydmRfyH7YbnYTArb4cNoMr6jOkh4s=;
        b=qqSu8mravSwL/9FnkWBj++CB1DFK1b8z3rumBDQdguhTTMzc6L+wiIBPXf0PxuubNY
         EpZKEb260BwtFEw2IsDKHt0qyN4o35pn3RZ8B017znRaKyGUkBC125JcCpUI8lnLP93d
         3ew1imSvvmg1oRZtK5LXNwzvfmsM2K2Y0BlnltUwp6v230IK10qmgWqWcm0pZGTtBFp7
         VFbxsiNaGMyyWlYuCrz8B+6ptUkYQ/tLRogUbqJh5snbJ6EmrF10c6WORQOLZh9ca6Nw
         10th+E6kWatXKDXCtpZTFM7jS/iWIjKWfDSAKGDMUinKCLRGq5tKZRZUO/htQv8HpXmC
         YWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706784236; x=1707389036;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2B+7wJNwOqpjQdydmRfyH7YbnYTArb4cNoMr6jOkh4s=;
        b=UK5tiu+s1H9hUB0O8ma+BzJBOslAorL/W8J6leYr7av6sNs4fJaiim3F6DZFQ9IsBI
         NEyU+aBcAz5wDUPRpdB5er4W8R7Xd89ik4jfj6aKa7GdY1sqhyivDV6nyGZdtRa9ZaG9
         w46cq5KZoS0otECJr19St/XTxhvBWAJcRUqzsYBYEx9dS2TTvJrLoI3M/z90Ybr01ia8
         04GnmJJpWnPOCcC5ark5SNfwU136c+HjBeFecONEW2kFbcp+QKZiCiZ6547JIZErDD/z
         fw4F5zw0iZvQPwhiuLkDOX9R93SbY6eLyMasysCkdtH+Re/fZJasU5IZC9cieOG9RjhV
         0FUg==
X-Gm-Message-State: AOJu0Ywhs9mLE0wQ9927klFXEiRat4+mYCrStRl5xNIemx7FRzMfS10i
	giScXQMIRI3qI0bWnrPUu12fsXasWql0py/84JgnH7Y2y8bhvqmH63RvlLrAdA==
X-Google-Smtp-Source: AGHT+IFo3EMpbGupVGDtQbW/y4AXVidbTW6W9uQKD2ILk5KcdH4PtCmdtaN87Mbu7EUsiLI0MXAcLw==
X-Received: by 2002:a17:906:b346:b0:a35:2c1c:52ef with SMTP id cd6-20020a170906b34600b00a352c1c52efmr3763973ejb.15.1706784236096;
        Thu, 01 Feb 2024 02:43:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVS+mYwR1ynA7a+OWsin2g3QW3RJK9DBlPpO5T7u36hhsGLfGvjKW6daUd0aSDuAn3jzNRaqtWwbjt3Uhtn7oBpq7SsE7x4Mq+gBJe1bWB9iSGcBvmvtq7ptIDhtH+ZRTOTOiyy6IQ0PoA6bIJYEM/e6fRBPdA1S4ZO2RXb9jMzpJuIdBuFNQM3nRzRqEmcrLs8NSlT+djXTUcjy5Dj87esFUMs8mNZF648XncBsNa7qa5ysFSLW0T7Ajw/glWvSlKmolHKZVmr9E6jizY7wfQp
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id vx11-20020a170907a78b00b00a36a94e16fesm715595ejc.159.2024.02.01.02.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 02:43:55 -0800 (PST)
Date: Thu, 1 Feb 2024 10:43:52 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: kpsingh@kernel.org, ast@kernel.org, andrii@kernel.org
Cc: revest@chromium.org, jackmanb@chromium.org, yonghong.song@linux.dev,
	gnoack@google.com, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next] bpf: add security_file_mprotect() to
 sleepable_lsm_hooks BTF set
Message-ID: <Zbt16HS-9x8YPZNz@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

security_file_mprotect() is missing from the sleepable_lsm_hooks BTF
set. Add it so that operations performed by a BPF program which may
result in the thread being put to sleep are permitted.

Building a kernel with the DEBUG_ATOMIC_SLEEP confiuration option
enabled and running reasonable workloads stimulating a BPF program
attached to security_file_mprotect() which could end up performing an
operation that could sleep resulted in no splats.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/bpf/bpf_lsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 68240c3c6e7d..da52c955f3ca 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -277,10 +277,13 @@ BTF_ID(func, bpf_lsm_bprm_creds_from_file)
 BTF_ID(func, bpf_lsm_capget)
 BTF_ID(func, bpf_lsm_capset)
 BTF_ID(func, bpf_lsm_cred_prepare)
+
 BTF_ID(func, bpf_lsm_file_ioctl)
 BTF_ID(func, bpf_lsm_file_lock)
 BTF_ID(func, bpf_lsm_file_open)
 BTF_ID(func, bpf_lsm_file_receive)
+BTF_ID(func, bpf_lsm_mmap_file)
+BTF_ID(func, bpf_lsm_file_mprotect)
 
 BTF_ID(func, bpf_lsm_inode_create)
 BTF_ID(func, bpf_lsm_inode_free_security)
@@ -316,7 +319,6 @@ BTF_ID(func, bpf_lsm_path_chown)
 BTF_ID(func, bpf_lsm_key_free)
 #endif /* CONFIG_KEYS */
 
-BTF_ID(func, bpf_lsm_mmap_file)
 BTF_ID(func, bpf_lsm_netlink_send)
 BTF_ID(func, bpf_lsm_path_notify)
 BTF_ID(func, bpf_lsm_release_secctx)
-- 
2.43.0.429.g432eaa2c6b-goog

/M

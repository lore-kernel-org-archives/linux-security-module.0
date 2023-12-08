Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NPY8g95W"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0441732
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 07:32:53 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54dccf89cfdso2603690a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 07:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702049572; x=1702654372; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7e0LAup17g0NCNSVw+obiVHzl5PDTKf4AJltQUn8U4o=;
        b=NPY8g95WN9BlEcRj5JDTMwLBX2abMfE99p+H714Iasd7RV77rw8WZNb3b9TRUmdATX
         AzEUlRxOoH3D2G8jADFTlnpJvyNK3KD1+AYgtifZm2ASFQPUFWooYVacDNmpOgkp3rgK
         bpwt8K2ebcJwk1rZzc0snHPfwCjdyArB1tGsRrl4kk1JtENsO0yO9z3Cu2El1DQAaK2r
         EFd3Rr/Smb1dtAcemJo5p8+FFPNLZSrJXg5rPO0DpQwVh9zRI8f5mDgNxrEQpD0t57YL
         BRLSaLBok1HJ+4p1vaqrzx6fupPb7GAJV0kRrpwEOdh2274IJevMuYfjg55ryzofmW4t
         jqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049572; x=1702654372;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e0LAup17g0NCNSVw+obiVHzl5PDTKf4AJltQUn8U4o=;
        b=eFnzybgWtyd3kcUuvE2WIufKHbImrEZZT7SvvyghdMS92w1LcnsMJ9MhNSW+NA0plg
         Jb/RvjBd3azwANekIJaBjm8UD7crR2HKMUXR6o+wWO5TlsdESVeQNydL5ATScaFkuhoG
         BZTMF6RD228C2esk4wd/+Q1rd92th0pvWIxQpLHhztTwe5mXPzoeyGoHIBzLB+UZCzzE
         lNa3Dll+U3tnO407pbjCDNYhk3hpGvCtRpSxbo5iXdRnUtSKXDy/jHUbQ3nifXU27Cfy
         Xsvnm3WmJ+Rc77XGHLa8M1Lo97r9txNqyTvPamgYfAAjP08DWKEySMchaD27r8eiurnM
         3Wrg==
X-Gm-Message-State: AOJu0YzMddd3QtNckh3nffkqYqqyIL4gKdy3L3gMXKWAYn1dE/pBGQia
	QAaKQhtMXN7XmrfyZ/Qk51InKQ==
X-Google-Smtp-Source: AGHT+IEOJXwDu0ftXR4iOSS0n4hmovnrh3fbopcKujhlKJmV/fxmLyIilVbCbW7y01z4IzCvMLtudQ==
X-Received: by 2002:a17:906:1b17:b0:a1d:20:836d with SMTP id o23-20020a1709061b1700b00a1d0020836dmr67512ejg.149.1702049572244;
        Fri, 08 Dec 2023 07:32:52 -0800 (PST)
Received: from google.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090699d200b00a0c3b122a1esm1127367ejn.63.2023.12.08.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:32:51 -0800 (PST)
Date: Fri, 8 Dec 2023 15:32:48 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: kpsingh@kernel.org, ast@kernel.org, andrii@kernel.org
Cc: revest@chromium.org, jackmanb@chromium.org, yonghong.song@linux.dev,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next] bpf: add small subset of SECURITY_PATH hooks to BPF
 sleepable_lsm_hooks list
Message-ID: <ZXM3IHHXpNY9y82a@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

security_path_* based LSM hooks appear to be generally missing from
the sleepable_lsm_hooks list. Initially add a small subset of them to
the preexisting sleepable_lsm_hooks list so that sleepable BPF helpers
like bpf_d_path() can be used from sleepable BPF LSM based programs.

The security_path_* hooks added in this patch are similar to the
security_inode_* counterparts that already exist in the
sleepable_lsm_hooks list, and are called in roughly similar points and
contexts. Presumably, making them OK to be also annotated as
sleepable.

Building a kernel with DEBUG_ATOMIC_SLEEP options enabled and running
reasonable workloads stimulating activity that would be intercepted by
such security hooks didn't show any splats.

Notably, I haven't added all the security_path_* LSM hooks that are
available as I don't need them at this point in time.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/bpf/bpf_lsm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 7d2f96413a57..63b4dc495125 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -304,6 +304,18 @@ BTF_ID(func, bpf_lsm_kernel_module_request)
 BTF_ID(func, bpf_lsm_kernel_read_file)
 BTF_ID(func, bpf_lsm_kernfs_init_security)
 
+#ifdef CONFIG_SECURITY_PATH
+BTF_ID(func, bpf_lsm_path_unlink)
+BTF_ID(func, bpf_lsm_path_mkdir)
+BTF_ID(func, bpf_lsm_path_rmdir)
+BTF_ID(func, bpf_lsm_path_truncate)
+BTF_ID(func, bpf_lsm_path_symlink)
+BTF_ID(func, bpf_lsm_path_link)
+BTF_ID(func, bpf_lsm_path_rename)
+BTF_ID(func, bpf_lsm_path_chmod)
+BTF_ID(func, bpf_lsm_path_chown)
+#endif /* CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_KEYS
 BTF_ID(func, bpf_lsm_key_free)
 #endif /* CONFIG_KEYS */
-- 
2.43.0.472.g3155946c3a-goog

/M

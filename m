Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287A231B814
	for <linux-security-module@vger.kernel.org>; Mon, 29 Dec 2025 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767028446; cv=none; b=hjtxWsrHcvRaAJch14l+q428f3FM/OnanHkCZPboRrI6auemkOnTKc123RO+Te5zYceGdEvI3tPNnToORSu4NH6xC4xCFx90YVKuAPj8Ez5ov3f3vEACQfPN8w1X2xUUJ7ozDU/7/ZZY9H5j5rGnseHIFBrDBr2bv8SJgkMWXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767028446; c=relaxed/simple;
	bh=rPHsj2oVdQZJmJLJWmWO3toMXK9yiLTRStaMVd6JXbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0odx+uqQNsgsHYNpmhKRHVM3fnzzahNh+zntT7g+NGPKhKhhbGcs4aRQLu493UUlZVLO0J/e2XmkwN+BUBH7jk6yKWrTmUJXEJN/5NOQHfl1IAXlndJhVJ/SIUnZJ1Rf98DsClXlIKyMMKqqgLqyQZ60MaoR3ttOaIXLZ1uW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIqSjaYO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIqSjaYO"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso5154959a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 29 Dec 2025 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767028444; x=1767633244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq0hy4ZDbyOAkYMZ9R2bJ77qMoSVUcBr/BQKEBLGcD4=;
        b=GIqSjaYO1LPsrpNx+MJUWdouSiwqq1TK0fcFqnIsRtvuZ12XgO8SfwBzriE3wgzLPo
         e0ZYaemf16rLUaOC0HTYWCUD93l/g1Yga21wt6aElb8a0HEjxa3B5pdig/nopRdz4BeJ
         pRZszj0yS9okHYU9ToggSWm8ewt+VW9d1ifHEWILEMtatcQCB+tR4VYF3uM52MJ4jgQb
         i571ihJiXIx0VgN7OrSQpdRDe+4sUxTPo1AmT4Ls4ttzRXTBb712R2q/EEzQ5HGDqbpn
         bUsoEPvxsbOczHl+Q9cfKuED+iW8LWMbNnSixSv+viCwXtPdiMEphoUSAjbtZtDYlIQe
         uVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767028444; x=1767633244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nq0hy4ZDbyOAkYMZ9R2bJ77qMoSVUcBr/BQKEBLGcD4=;
        b=ulqPs+Dp8kac5Df1w684g1rGZeKiv6guBe8JUEfMVMsfR/XiHePar9WI4Z7bLh62MH
         vF25mflWSVVoOkm4qLQC2iLq8oeLW+9henW6sIL/Ic4tth5CCY0mGZMxGGuliAlPk3Gz
         WI0PD/OOsyd65lPengtmVRkEkpua9cihnnmseaUCWwgi1CSivXbOZ2OiDYZ2FbFAbNaD
         KVo1zwFgQ+MVZnmqJM+Ibu+VXkKzzvWOhteM0BZmOw9QR25q77qjHuw3Y5I5554QWsda
         OmixLRsFaP9KTHT7r28yedaJ2y312mUGkoQXOqOHtVVph6B3KKwgdFsRRKdhnm/ON83E
         /8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCX38VjVdL52sJV2uxy+1QxxFHJM9r7NrrdRm9XAi5jE2shuL43d/B1pixVObzTJH3t1bmeRQsYsQMbFaP9D9SfeQ2y567o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIn0PA0BcT42sis+JTfw8Jo/XugC+lLpIs+LMX1KXPsQE/MwOD
	k4gKxh8Y89X2e6lFP9QlkZfvKDnlxQaVLpCsG6N+vwAiVEGrETBspDv5
X-Gm-Gg: AY/fxX5SuhUdAFfdCcaE+U4pT6y2FBPvFdv3CZqzXfKSyGmVausxmC0nRpBcLdGz+32
	ibJKs92ZXvfJOWFiGcI5t1VKzsOj46smdGTak9L6S9eNSoOPhWTzdNtGl6xurXlcH2vhGsLyLzj
	+qbC72zpw17nVULcEYieGDHK2XMzMYhI/vuikhgO/Tlf+xsoq+7y2gSkufTqvTlEedTysBUtcVm
	XCoR0m2fnqJhwQoQD4/1nl3dn6Vdm2RhiZNL+WNL4pk8jcqhfH44B2gLFgWxSRC1R8AgvyRhknJ
	9iofP/nJXN+aggvgFYI2D42jwUbjHE4lv++d84K3OTQSqqiq8+qgCjTVPmZoTsieFu2sr6BVKCB
	M53dqNiBaTLz8qu5OYmSjs1y65RvexP13QXYtMTBTbz0Ecz8q3P2K5SrOFjMrVfKpnVnHZFq8sq
	adDz0fwZhEfHuzRH+n7ECBz5QvaystE6Eg/vbfDzIq0pnuvhTXFvrgvrPwYuO26Q==
X-Google-Smtp-Source: AGHT+IG4eXbFG3XgvqZI1V+B2x2P42ZmXTkV7Dp/LoGqVFuSVOvFy0fGaXCjk1bAi09n8KFPykhhkg==
X-Received: by 2002:a17:90b:2e4a:b0:34c:9cec:3898 with SMTP id 98e67ed59e1d1-34e71e29544mr29378809a91.13.1767028444325;
        Mon, 29 Dec 2025 09:14:04 -0800 (PST)
Received: from kailas.hsd1.or.comcast.net ([2601:1c2:982:6040::e14d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e76ae7618sm16105280a91.1.2025.12.29.09.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 09:14:03 -0800 (PST)
From: Ryan Foster <foster.ryan.r@gmail.com>
To: bboscaccy@linux.microsoft.com
Cc: James.Bottomley@hansenpartnership.com,
	akpm@linux-foundation.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	dhowells@redhat.com,
	foster.ryan.r@gmail.com,
	gnoack@google.com,
	jmorris@namei.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux@treblig.org,
	mic@digikod.net,
	paul@paul-moore.com,
	serge@hallyn.com
Subject: Re: [RFC 00/11] Reintroduce Hornet LSM
Date: Mon, 29 Dec 2025 09:12:48 -0800
Message-ID: <20251229171402.1491979-1-foster.ryan.r@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <87v7i4hpi4.fsf@microsoft.com>
References: <87v7i4hpi4.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I am considering how to reconcile the TOCTOU concern with the "don't touch BPF internals" feedback, I think a very small API might help:

Minimal API draft: BPF integrity measurement

Goal: kernel-generated measurement of the final relocated program + declared inputs, so attach/link can be enforced without poking internals.

1) New BPF cmd
- BPF_MEASURE_PROG (or BPF_PROG_MEASURE)
- Input: prog_fd
- Output: opaque measurement blob + metadata

struct bpf_prog_measure_opts {
        __u32 size;
        __u32 flags;
        __u32 sig_len;
        __u64 sig_ptr;
        __u64 prog_id;
        __u64 meas_id;
};

Semantics
- Kernel computes measurement over final relocated insns + inputs explicitly in the integrity contract (e.g., sealed maps).
- Measurement is kernel-owned and stable for a program state.

2) Per-prog integrity state

enum lsm_integrity_verdict {
        LSM_INT_VERDICT_UNSIGNED,
        LSM_INT_VERDICT_PARTIAL,
        LSM_INT_VERDICT_OK,
        LSM_INT_VERDICT_BADSIG,
};

struct bpf_prog_integrity {
        __u64 meas_id;
        enum lsm_integrity_verdict v;
};

- Attach/link allowed only if policy verdict passes.
- Any input mutation invalidates meas_id and resets verdict.

3) Input immutability
- Only sealed/frozen maps can be measured.
- Any write to a measured map invalidates the measurement.

4) LSM integration
- Hornet (or another integrity LSM) consumes the measurement blob, verifies signatures, stores verdict.
- SELinux/IPE/BPF LSMs can gate attach/link based on verdict.

Why this helps
- TOCTOU: verification tied to final relocated program + frozen inputs; mutations invalidate.
- No BPF internals: LSMs use a stable syscall API, not map internals.
- Minimal blast radius: one syscall + small per-prog state.

A thought for future iterations, happy to help refine if this seems useful.

Thanks,
Ryan

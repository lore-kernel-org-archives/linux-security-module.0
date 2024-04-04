Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76229129A90
	for <linux-security-module@vger.kernel.org>; Thu,  4 Apr 2024 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233009; cv=none; b=MVkSKYARFOFdExakp5IcIPEZvZa56UajZAiTeDv/NXX3/oEo1oXQet57MHHhk6r6nSjci9IgHmosGzcbPPEIpoX9DwvUzvqwY8bdYZrCnWfMnVIpPRSvQVf565dX0hOj6pZCL2VJkk3wb0SmhwV8Xc1iyrqDpWU25oYXajRlLFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233009; c=relaxed/simple;
	bh=OrnyRAznfz0HaoBMmuRRvJwgEktTbAkUuzxqcJvq3Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W1LD16cUjpLo6BKQt5LG+OYLmDkyOTc2DgDMzTnElEFcU4cVPYXDDJbJNZvz4iOmzYygeomdOEejXlX+0VVFlJ909o8yP2Shf3eksuOEaCvzrvjnwktv8lwlX1LLXvQSuc29JBggIhP0vTeTJVAG5UnPZh5K5we4Lw3ZSOEtVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMyuzoO7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMyuzoO7"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a47385a4379so383555966b.0
        for <linux-security-module@vger.kernel.org>; Thu, 04 Apr 2024 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712233006; x=1712837806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8AAXdi6UnwgE8mvtF9U8oApK2XyGAr7kUWfIztB0ZU=;
        b=KMyuzoO7prAziTBJb2veunMRsqOMwbjjP9/EXJwbhCMUyU9wRlGxBOZxmoZiSPnXZl
         PvAc1J6zxyUtR1bruNnPw6ur7/AidWKQW7PD+weJ7IE/ItequsJ12YD2qb1ZxzUNCIWN
         hZy2uFViq30uLvuGklJtOsyRVaV6PoWQW+U/jU9ElHS0XeKOWH40pX/MZuYkB8WiBmQg
         lMZo7AFErq0DiVZTrERgkiyGmTXa9a9Yp10ScHQKyJf5J+oeJ0AAbbApyJaRg2S1huaJ
         CAqLwaiOYqm0CtcxCOWzXIeTEQoEwU/hLCs/Gtb1hyseHAcInxul2jTDfK/Dzk4+wSKa
         VIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233006; x=1712837806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8AAXdi6UnwgE8mvtF9U8oApK2XyGAr7kUWfIztB0ZU=;
        b=s9vgevzh4bNnKgwrU5qctUG/ARHfpM6z3DMGeZOYNj2IqZOBoEllkT8p4PYvvoRkS9
         7UoVR88UYaRmzTf08vzD2RNkb5MYOUjbZtCcbLG6zRSl1N5VQhJvlJQCJNn1RW0bOA/s
         8WbU3kZE4Sy3GTI6PltB32pe14eUKKPOEn+zONPJQGXzRgcPGuOIvTn7ufZu1RXiVkjD
         dnZ2XXS4+ZCKAcgNlC8MRVcC5Fn3TAYRyKaOxkPNS5Ms0pdb85OexkeMxkiN1dLmBiIe
         83jhBZcbvW1JqANP2gpELf62+n7NVqc7RCI+YziyoecDNUA+tdKoBg2NVkoDaCEYhdBk
         30lQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1VR7AfAdDB61B1ahvFjZdhpLR7mSksspzI9Hnuthf0A/84/KLwSdXMF+P+8QL0CZTyYU0iugVYIjXHoPUzWxw3S804UXyd6Vzhr+4zEVohwG5n9w1
X-Gm-Message-State: AOJu0YwGzVFt6TXbLsxx0bUsfc0d3JSQbz8EtmtnvM+6tJm9QkvVanPy
	IED2EnSMg3t6Ya6HH+jjmoW8BPUjXQJ86tYKO+TZZVjPDF2boVl8
X-Google-Smtp-Source: AGHT+IHI+m/JUz68f3ZXkP11/1Bukju4pMSINUlPdlcJzyhLnmLRJ29mVu0SsOgQem3HUZoxhIqiuA==
X-Received: by 2002:a17:906:af0c:b0:a4d:fb90:4a4e with SMTP id lx12-20020a170906af0c00b00a4dfb904a4emr5193795ejb.2.1712233005512;
        Thu, 04 Apr 2024 05:16:45 -0700 (PDT)
Received: from ubuntu-focal.zuku.co.ke ([197.237.50.252])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709060f5300b00a4e30ff4cbcsm7948001ejj.194.2024.04.04.05.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:16:45 -0700 (PDT)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Dorine Tipo <dorine.a.tipo@gmail.com>,
	Linux-kernel-mentees-request@lists.linuxfoundation.org,
	fabio.maria.de.francesco@linux.intel.com,
	skhan@linuxfoundation.org,
	outreachy@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: 
Date: Thu,  4 Apr 2024 12:16:21 +0000
Message-Id: <20240404121621.9162-1-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402.MooNaiJoo2cu@digikod.net>
References: <20240402.MooNaiJoo2cu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: [PATCH v3] selftests/landlock: Add tests for io_uring openat access control with Landlock rules

> What is tested exactly?

The test_ioring_op_openat() function is testing the enforcement of
Landlock rules for read-only access.
It's specifically checking whether the Landlock rules correctly allow or
deny read-only access to the specified file when using the openat system
call with io_uring. The test does this by preparing a submission queue
entry for the openat operation with io_uring_prep_openat(), submitting
this operation to the kernel via io_uring, and then checking the result.
If the operation is successful, it means that Landlock allowed the read-only
access as expected. If the operation fails, it means that Landlock correctly
denied the access.

> +static int test_ioring_op_openat(struct __test_metadata *const _metadata, const __u64 access, const char **paths)
> +{
> +     int ruleset_fd;
> +     int ret;
> +     struct io_uring ring;
> +     struct io_uring_sqe *sqe;
> +
> +     /* Test Allowed Access */
> +     const struct rule allowed_rule[] = {
> +             {
> +                     .path = paths[0],
> +                     .access = access,
> +             },
> +             {
> +                     .path = NULL,
> +             },
> +     };
> +
> +     ruleset_fd = create_ruleset(_metadata, allowed_rule[0].access, allowed_rule);
> +
> +     ASSERT_LE(0, ruleset_fd);
> +
> +     ret = io_uring_queue_init(32, &ring, 0);
> +
> +     ASSERT_EQ(0, ret);
> +
> +     /* Test allowed path */
> +     sqe = io_uring_get_sqe(&ring);
> +
> +     /* Prepare SQE  for the openat operation */
> +     io_uring_prep_openat(sqe, AT_FDCWD, paths[0], O_RDONLY, ruleset_fd);

> Can you please explain what this call to io_uring_prep_openat() do?

io_uring_prep_openat() prepares the submission queue entry for the openat
system call. In my tests the call to io_uring_prep_openat() is preparing
an openat operation to open a file at a certain path with read-only access.
This operation is then submitted to the kernel via io_uring, and the test
checks whether the operation is allowed or denied based on the define
Landlock rules.

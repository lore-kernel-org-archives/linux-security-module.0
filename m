Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C026E143
	for <linux-security-module@vger.kernel.org>; Mon, 18 Aug 2025 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546110; cv=none; b=h4UWJWI+7PSizHAbGOmTI17Xxnokhu/WYiYtfGrZD2dP6uIIQLcVUCoUsPG44kcZGLCd/9WqOqKi9YN0m+IAA1R2+o1/mHmia1ki7Npn3NHEThIz3QdUn9tliOdhAXWrAJKvZqbBy2Wlex9SXOi7l8XrLg1l2+yJ7GzoH9ifwm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546110; c=relaxed/simple;
	bh=LjzRktvGHG7Cm7GEADais5G1kvlEza4Mc1EJ+4lQo7k=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Nbxn+3jJ2p5+3Y7FPqgz4lKwmmpssrxtN+0irxlXHbzPwAvv7EGRkeFLBDWrJYzd0c0KPQd/w1CezRzYpjTDWujf7iUuvoG4Z9b966bR7oKyP2vJD80T2TeelubX0w4FsQpLN2YJNbLm8aL5KCMdZnk6kDY+FxqeJL1SoLjWwKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a7qzF0mj; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a7qzF0mj"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e872c3a0d5so447110485a.2
        for <linux-security-module@vger.kernel.org>; Mon, 18 Aug 2025 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755546107; x=1756150907; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0abzfqB4DaFxIDFYMlxU0oD0cFz5eYdyEriw8AoXas=;
        b=a7qzF0mj0/n1yiJUi8EDg0cEg6JAqBCd4q7FxxWJqTqBCzvTNSh6VcCuheD8ZrBrsy
         UcuRS7hRovdxTM8SQXrGvlVHPcaASOb5P6EW21dG3IJ1Emeln5Otb9GV/5tklmA6kqJ/
         XvJkjd4FVjljXDY0EYqyg5KYGTInTk5L/v+6zDIfnkdbiA3FYHseOskSQbnr5WdMQbGi
         BZ944b9Qsc5jSEdJKV+ehTdc70HAo4tShq/RsSoQbdNTK9oODlEQOmDzvHlhBGImWocy
         HVU9TvOkPMLs6rUkn7QtVDmzeIyp0Czw467R7F5iRViRMi7E0EpEsI9aHyOIgI0NLOXp
         1l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755546107; x=1756150907;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H0abzfqB4DaFxIDFYMlxU0oD0cFz5eYdyEriw8AoXas=;
        b=UhrQYvx9jUWhDiCn/Lq5FARLMYeBYubgpc0q7r6Ax5QO2JyJBkCxvQ+krnCQVHKQTE
         nmcVim57mB87j8CdwLbKGcZohppFprRHAlIaSt2J9J+qscZb48fjVgPqMbm5N2pJC4n2
         t41t9S8RSW1X8ScaEv0eOGaLLRL28i1wRphuucs38AEu4YHS/dCAWTVIwUpfkjE2ieu3
         l87/k9Df3fPEXVH62dBV7IxX2fJQnXaquKV9ev7rDKAFOvQ3gfMnQI7PA15amKRNJA3w
         N0GFtJ4s5ATZAr/fB/CquTyeKQ/RXuMbK8l3UFNjVBd89ye5ZMWuXqzIWRZw3nElQ+jd
         cIIA==
X-Forwarded-Encrypted: i=1; AJvYcCVHEP+FrinmIwt32vSK7feSExBvX/504dBeVh8O4DI0DPG/Wey4NF2I5FKN51NzGN+GMIxg++KmP1MqVMQFnLPyz2xxeXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA9qHGXKPFT6dxgz7gYYgJXxeH3VGMpSTlIObkovb7Q3/AsMXD
	7BgcaFj7iq/r0FnjTlQhYt+x2OcIG4wguk8cyx/A8B6Or5viTobzJiqZoWM9iuHWtQ==
X-Gm-Gg: ASbGncunKVoK89gTQvrmYMClNf4hOya7/ftF+Css7DbF1hImaXk35J8F9kwAM3idBd+
	pMyy9oSMP1TRpkCf7xGHNBvtHe04j2f5M4WTE0ZY274QF70oklqMJ2avIPqlQM6Poyh8Q0lekPd
	DoqZcgtweGwx0V6OtGFQUx43qHXgZ9XGXmEZ4xdMnoMZxC1QgAIS6sjwX/dwEa5i9OH2eIIgGhm
	Cw1Rr+iIf4h/tVpX4QEvh/hoxpoeBa6Ie2OZzLrmXS62Z5WjsyQZyt62c/VBUil756nmi0trAke
	MVT6zh9LE1fTD0UG8YpiiPSoWWLk0VCUFNEQf9jxGDlSsyyjNrOnaXbWpMHGpp/8dYL1Mz0meaQ
	ZVz16eJy2UDf5iSjcSZ8FdqHYor22G48NcxvI7tB7EDIEuI2YYjkRUFlhIFmEkODRiITX
X-Google-Smtp-Source: AGHT+IERO82vyP3dtgCXTre/8LBPdqmJRpjLyPSaOmYAEAa6+wulpMpZnaDTrBO368CqbS87r5X4jA==
X-Received: by 2002:a05:620a:4686:b0:7e6:9644:c993 with SMTP id af79cd13be357-7e9f331f874mr16087085a.15.1755546107054;
        Mon, 18 Aug 2025 12:41:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70bb3ddaadasm37878106d6.70.2025.08.18.12.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 12:41:46 -0700 (PDT)
Date: Mon, 18 Aug 2025 15:41:45 -0400
Message-ID: <3741abe96e56cef5bc0af788c1e48c04@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250818_1537/pstg-lib:20250818_1537/pstg-pwork:20250818_1537
From: Paul Moore <paul@paul-moore.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: Re: [PATCH v2] security: min_addr: use umax() to improve code
References: <20250815035604.502874-1-rongqianfeng@vivo.com>
In-Reply-To: <20250815035604.502874-1-rongqianfeng@vivo.com>

On Aug 14, 2025 Qianfeng Rong <rongqianfeng@vivo.com> wrote:
> 
> Use umax() to reduce the code in update_mmap_min_addr() and improve its
> readability.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
> v2: Change max() to umax() and include <linux/minmax.h> explicitly.
> ---
>  security/min_addr.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com

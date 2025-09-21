Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA14B1BC4E
	for <linux-security-module@vger.kernel.org>; Sun, 21 Sep 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758468691; cv=none; b=D9LlnEHTCFCOepLDqg6zQvyi8M/ZlM2LjihKsEX/Av2BXZhWnkzNsF9IhXBVClrgmxXlJCjKcRm+f3NXNos53aVwyodSP7bMnyVS3ApwAKArfVfxDhzggKd2XdG4K7KCjYmj4qFSjEBe56Ag6Uv2XfKpA+G7e5Gh9Oa6CNa17gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758468691; c=relaxed/simple;
	bh=7NCxv/9RiVkI4je3zWn63xsUqo8Q/S8SLXjy/jyDnPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZI+WhMwM6Q0e1vn2pct6e6M2n/yzQes9hJPpcnM5WAo6irNTzPSvPyqyqyWGA0rR0sFQJmexj4WGCdKyO9H5VDKSylNy8fpXqEncfCa3KdB7jV7nWGu7bt4lS30516BAZ2vJ1EyGxmEMcDjlbtbPEOPGMUYAVpau7q8A5aGHbsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amdpVqlV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amdpVqlV"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso32100665e9.0
        for <linux-security-module@vger.kernel.org>; Sun, 21 Sep 2025 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758468688; x=1759073488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NCxv/9RiVkI4je3zWn63xsUqo8Q/S8SLXjy/jyDnPA=;
        b=amdpVqlVMxMWDehDaLSFAPFz03X2Px3BviI+5Xt5BDZNxO3OyraEeq134R+0WJqM1L
         pWFOUN9qlxB76Z1sMM0ShbERAcRS12tAdX0fAahDObsUBi2G20savy87ixeoUntSPCOx
         VriRkzensmK0cQH4s7AMV0eTZBQHkeTRl0B88Z4h+CqbtVGejyOCFS01yzxdfWpyW0pm
         RxT94cKRvpayQKDowW8e3+TUoMgRKz15QCA2LAQjSkK760cv+lmOOo5YuTQty1V9k+jh
         n5spTOVqxi80dOvU2ZIDP+UhOGBEpMXPzjGQhYC+ZB8knpkOnrXv5k6uBQ8Td0vQaOJY
         Gxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758468688; x=1759073488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NCxv/9RiVkI4je3zWn63xsUqo8Q/S8SLXjy/jyDnPA=;
        b=prbtBv+pXwICcG7Rvb+0S2AZSurmzgU9vaU51n98j4rh7E/YNRGtByCFuJkoysejld
         LgQ8U+4RHTToq1T0IgC07AvAv25LmWy7yN53v3Z9+BhHvqPCcetkK/fWRDNAtJD7hi8p
         kNe0mcaAVEB+PGt5Bo9pnumPZ7dYkL+HV6RSKhyYKGkKRsNxcT0D/wj+BICulvvyYy08
         s7tlEwp7n+xKPu8x5c76Le47O9dwvIZRev7gcFiOnWW7zPOih7hfYMGW0HTXzWPXd1YP
         RX7aq998HsyRdKL1YsQbr+HFL87r6pASWux6Pwhy0t5g2zzjWrJgoODBrxC/NPmP5pZA
         vPxw==
X-Forwarded-Encrypted: i=1; AJvYcCWuKRrTP4Ca8QVxxtUcF+rIziIXNWvKDr+Tf+ozlNSDkiX1/stnlCcXyJTXR8GtOHW2pZEvFsuoG4TSlitTJ7pK4D1SPjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQSqwRleuFzAjPpfw1QQIVzsngSdB6RgaDl8AgxRL4tQQ6NT3
	nJFdJWlPv3JeXJFfdHg+BpRBuMQer0phr1IIIR/Y5ZG5RpX6js04eOnbO6pQxMBHevZnpepWUSI
	fx1sNMlmVfvJLCZdLxIMOOa0JSDk2kDY=
X-Gm-Gg: ASbGncuLHJZnn3M/jho7+6wJLPJh9o28rmgxf88C42zixuZ7HCte0h+9xQj95njWPMI
	1AJwvJcdTilnITPUCZGrm2xqA61muESf41C0rLsNR5iTwejWGLP5HAq2TP8TfgpzBmXLxxudt3O
	KHREmQpEn4L8ypZWiRFKDtJ5cep1FrMGrrJFApv6PA/c801jLBBwjDU0d2kuQ9a7TID4Tq9qF0L
	GuBu0dQk3fvaW044YcHx6fUEEOvsFNmJsVV
X-Google-Smtp-Source: AGHT+IFLDfCcS1KEU0zLGmnheBCJTR0xfgWuncwrkWZKOCe0PLEWQcbu/yMyLpB4WNBEi2oUGL+MFWe/fqSt5J8fK0M=
X-Received: by 2002:a05:600c:8b21:b0:45d:d56c:4ab5 with SMTP id
 5b1f17b1804b1-467e63be56fmr99171845e9.5.1758468687821; Sun, 21 Sep 2025
 08:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921133133.82062-1-kpsingh@kernel.org>
In-Reply-To: <20250921133133.82062-1-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Sep 2025 08:31:16 -0700
X-Gm-Features: AS18NWCiKg8ZihT9tribG8q0rpDMrWLrdCn2ggSw-LMPm2iRIOMNJ9fehq0ibXU
Message-ID: <CAADnVQJdue2iX1fq+cBM8xkDHa8N3EXBZ-avFQ3VuasQ153fXg@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] Signed BPF programs
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 6:31=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
>
> # v4 -> v5
>
> * bpftool comments
> * Cleanup noise in calc_tag diff.

The patches 1-7 were already applied.
Please rebase and repost 8-12.
Also use [PATCH bpf-next v6] in the subject,
otherwise CI runs only half of the tests.

pw-bot: cr

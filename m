Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521DB13AC1
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126071; cv=none; b=uyXYCCrscQX1lYIB/1fqN6UYTxVrIioVjp35DWPpoQIlwaotdnfp33Q4nLpJxayVXLcqyhiS1G9IzLst8F2eTnRHag/ELti8C5HSSsH4bPmx4zjHU7wQYqFVZxx3Hg+SA9aKFpHiD/feFONpmqNGA1ba5khhukDup9RufONzzLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126071; c=relaxed/simple;
	bh=rYa8UwAmLiF/ruWm+7Ip+yWVFZ1SaMjS81Bt+resw34=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ci7MLb+06keCMMum8lJ40tes2wUkzu6VvL/5eiuzbwPSQzpEZGs6UUihbWD1YdIhmLnUtC47isk79ldrC6xpMXHroOv0j29t7gulaBCBt3Ph6JYuJvDMS8umRTeEUgO6fSXSc1nUs1zyeCV1gzmByJ6hRnJBBQi/ThP0CsRJ68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ChvdcD5J; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ChvdcD5J"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4750ca77db0so283171cf.3
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 14:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741126069; x=1741730869; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKFucnJ0eu2hFoCdtrns3nmxFOzTMWGPnJoCE8LE9lg=;
        b=ChvdcD5JcW6GT82AZREdI9KJI5wMf9FHldqZCztGGm4XN/xNKrW3hnsfaFifNNI8Nk
         AND4RdlbUJoLC2IoFeTyDYV3SMdMgx9ZD+G25ygZaX09WbFNBFA8tbDaEuuVOPB1T27/
         0ZPBJfOU/kdBWwIIpcQ12Z5zj0bn85U3qGw3iL5Jk+OfXiNv+b6+pAxGN7CioqxCOn/s
         c4keFaTd394WdtGQfq4UEGbvuWQXs94As6WtZk4RGoybM+HV5WynToZX24Sr1mFHRVoM
         WOCe9xHTrzIIhwk5V2TBkZJKptNQ824nv1ih6ccKKb2tzfn79WNS6/bw+06kNKqMUcZQ
         Ru0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741126069; x=1741730869;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BKFucnJ0eu2hFoCdtrns3nmxFOzTMWGPnJoCE8LE9lg=;
        b=fHIClJYbn+YOunR8zqVvB3krDAJmrHRTCT9RtNC9K9bPAFyQTnEREMxySdIpxCHkiX
         OEbBrUbJ8dGGJVGpX14n8m70tfWq4FOYXeg9WJkA4yn/aXkP4VFiDgNEY1g8Xf38Psno
         4b6sbrO1KKnq+P71hntJJkBMgJmDTLGNkDKwI8LmvITCRTERApk9fUg/ZO34k05SxoO3
         orTNFXC098tQdSj/J4dfRsxCnYxWLqXZNcOSoya3W+AF3wKRCPrajgAKTO8AdrMVLHac
         en8C2PTwtiBQURZGOTyHmCJrNu4B4NYcg9CVN02hHsfSp92gY08p01ojtb8HKGOtveCj
         Q61Q==
X-Forwarded-Encrypted: i=1; AJvYcCXslNGcGJTIFvCnFnETGHsbVfmTK64FmHNdJ5IxRCSyQWGjiAyizWqZGd0Me8cwl1gDichVHJGaRk9Q8yG8FxEfQLcg2pI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2JFb5cH+ofNvqCiI2u495zR9z514bqD0aEuO33qsXLw4w5PkF
	yIjt9LOPgi+7IgUUfAajYGdWyMUH35vSU8aCoXN58U+r9xugIlaSUjpqeB6x6A==
X-Gm-Gg: ASbGncun6IWcWTZPsbt9/HDFKuYxfoa/yh1dx8J1TRp/rKyCQevoTMJC/toccNxhzOq
	l4epyrlm8RUBnWKbctpDqYl9BHhgR+S3/xcFTTkX8LiUCwZvzEHxYrq2JF52l67QaB0RED5FHxr
	xAeKIj/G10k6LDfiIlytd9IJtf4ULSRiDRH16tAm7HHJlcn8C/0axfpjovYzwoWx852zxaIkiht
	QxF5CkTJ6C/O4O1LseeM/S5kAve5i9soJg2a2/y0rOsF858+gv59y63YrofcbwbMEaqD6z+ou7Z
	U8cl6umTHSX1gcsTmNBX2vPnRUDCG6aZTIao66amBQ3LUv+I2+WP3pBf4AB8VQmi+W4KF+shxuO
	KlyQvC+Ia/twzFg==
X-Google-Smtp-Source: AGHT+IGUzI53OHoAUblYM2qlVQBUsHxaboxVDz0QodPEH5dELjV4Uu9kfywXUTbmN5tYZHwecjh2Aw==
X-Received: by 2002:a05:622a:cb:b0:471:fc74:100e with SMTP id d75a77b69052e-4750b4682d0mr10512251cf.28.1741126069306;
        Tue, 04 Mar 2025 14:07:49 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47472431036sm79332581cf.80.2025.03.04.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 14:07:48 -0800 (PST)
Date: Tue, 04 Mar 2025 17:07:48 -0500
Message-ID: <f52b83c88d715ac3ae989427bcc20030@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250304_1539/pstg-lib:20250304_1539/pstg-pwork:20250304_1539
From: Paul Moore <paul@paul-moore.com>
To: Alice Ryhl <aliceryhl@google.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v2] cred: rust: mark Credential methods inline
References: <20250304-inline-cred-v2-1-7aa54011bcab@google.com>
In-Reply-To: <20250304-inline-cred-v2-1-7aa54011bcab@google.com>

On Mar  4, 2025 Alice Ryhl <aliceryhl@google.com> wrote:
> 
> When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
> toolchain provided by kernel.org with ARCH=arm64, the following symbols
> are generated:
> 
> $ nm out-linux/vmlinux | grep ' _R'.*Credential | rustfilt
> ffffffc0808fc540 T <kernel::cred::Credential>::get_secid
> ffffffc0808fc588 T <kernel::cred::Credential as kernel::types::AlwaysRefCounted>::dec_ref
> ffffffc0808fc570 T <kernel::cred::Credential as kernel::types::AlwaysRefCounted>::inc_ref
> 
> However, these Rust symbols are trivial wrappers around the functions
> security_cred_getsecid, get_cred, and put_cred respectively. It doesn't
> make sense to go through a trivial wrapper for these functions, so mark
> them inline. Also mark other trivial methods inline to prevent similar
> cases in the future.
> 
> After applying this patch, the above command will produce no output.
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v2:
> - Reword commit message.
> - Link to v1: https://lore.kernel.org/r/20250303-inline-cred-v1-1-b2527beace76@google.com
> ---
>  rust/kernel/cred.rs | 5 +++++
>  1 file changed, 5 insertions(+)

Merged into lsm/dev, thanks everyone!

--
paul-moore.com

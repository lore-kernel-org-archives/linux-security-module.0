Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE432620EF
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120958; cv=none; b=mJ5AJJ+qDG+IGz+xNRAKa3dHDfPrYc2+ZkGbTmBWfYAphyLLsKmHQGKqciC1dFzeajdtyC2MkPBFz9D+koMJ6G3Caclz4EwxgUpPQwkNFlj0/G1Fu9kFa8v3ppFt+RY3qO24kwG/x6yS+jdxFTK88irnt1gXlgpegjj795naf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120958; c=relaxed/simple;
	bh=hY3ox+Cv8L/hy1uWd2H+uDH/wZ7y6rjKqKarmY/cer8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=nUpdiSZj53hAZQwmEr6Fdl/oQ04tv+I2mkS4wE7/4PbLhc/28zwsQtJurKiqH7uHgs8E43OrEhmAKQxJMMhm1Pc6yP3mdmYOWMmjayx9tGMhJyPkArEqHWo9nA7oUWgTPwhDHrsTJ6SofsH5F0qzKzai27327w9pH14Xzc6dEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XGwAZ2uq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XGwAZ2uq"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47210ab1283so89485911cf.1
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 12:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741120956; x=1741725756; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1qRuitdwwYSELTXdkDkMV/eQ1X4sgsaSnPBdxYSrvM=;
        b=XGwAZ2uqxdiAH2xE0p3xo9XIG3BZ8wSwL4Vgycku8YGLHMfJg3Z8BNOk46sxsDRbZ4
         EWC8F81xDdEDHpkpU0iMF1irO7cdwFqR+8pjY6SuCokEw4/NHXyhH+JPJZnSYop7qJJZ
         pWGbgQTX+iiX4l67s0kb956n0RDaMMhTon2LJI3NvQjXcxdCNg9Ygb2TZuoWrKG3w5im
         JK8hJCAGfP7gYWROVGPVInwp+yRyAa+zaBvDBZSFRv1GRNGtHdcnwUyYcMjjBcGuC+HL
         tkUaJRm9SaALtwiRgFgDpyBcX7FE0fOFFwR4oGxe3a2EkfIM4rzF0+Wp5/6iPdMszJEW
         w30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741120956; x=1741725756;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R1qRuitdwwYSELTXdkDkMV/eQ1X4sgsaSnPBdxYSrvM=;
        b=F6EY2sczVcMXdavL1aBJ+57NSZ6axFk/SOjek2l2FcympavARO3XsjSDN25gl/3e0t
         xyukcOo9b9QfcSrLD0kuLgcFKvHhHfySg8xfde9rADH7wpt9BYGBHOaH9n6IsduOSxUK
         zd4LipBxeiDR0XW8c8VrHaoeJCG6QiITcRawIeHI6mCRTqeG8U7ojgG+OmWb1fpPe6FC
         zxdbyxZUcaSAyhKbDYiZWbckJl6J+OfYUdag0c66/sV5kbEEsRu6IBUOm5sKQyhkwYqW
         Q7AlZvZd/AD4guJY0zWKfRYZMzd39p74p8hxTOX7frbtBL0zR/0uTRcNtlt6j9V+zTs3
         qUPA==
X-Forwarded-Encrypted: i=1; AJvYcCX16lHxA4laNnFYVgICj/idQau2uHVZ84oePkFoNPYBH85EkQF2mnwrahibZV+i0VACp/HbttvfEb2akjX1+nvOn8efiaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAe3uhhnCbddaG7YloN/29egvxwGxDcIbBeRWG6U9YMYGaDIk
	PC2+2iywCPPzTm78MHOHonjPk2R3NzVonL2I/1TP9s1SrAnryRVfInRciXOhig==
X-Gm-Gg: ASbGncviZTfAPmSRD1y0pXgZWdIfKRt6CSMv303FgqAGRS+wOEqOYxHhr18wLpK1ZJY
	RHGbk2npWvJhnhx7OEVEtjuETbD/UBQNjG5dE0zZZ48wnNq/CtICO4Qr4+juv12p7Wtw1B9zd4o
	tUfHg82KP/ic/sN3KYsZAuYRYpyPpSUtlGoDSKx/MUpnZMn30kSbzfjVVQToost7zXjgQ9V8uym
	lcrakY1sKqOcG442NOiF3AW9PhIuZHBiriX+MkGYYjsp8AO5qhekBxHcyFSUrnqPYE7diJdng4e
	iogXOApgeFjup3sjuLSDLc4xz1XFG118LLpgHIiUeP7C4JelnNR3R+whT9JZCH3sEL+4SyT7syF
	cICxpWq7sddda4Q==
X-Google-Smtp-Source: AGHT+IGGJzyx/Xq+umUg8sGni4KDBOk9xYnclv58VIy14he0JdzCkkSuM+jn28L4VU0r2ABS6Z+JDw==
X-Received: by 2002:a05:622a:1a0b:b0:474:f38d:58d0 with SMTP id d75a77b69052e-4750b245031mr8398401cf.3.1741120955860;
        Tue, 04 Mar 2025 12:42:35 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-474ff3aa7d8sm12524121cf.30.2025.03.04.12.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:42:35 -0800 (PST)
Date: Tue, 04 Mar 2025 15:42:35 -0500
Message-ID: <00f1cac46dcba6dc8e2e602674b55671@paul-moore.com>
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
To: Alice Ryhl <aliceryhl@google.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v2] lsm: rust: mark SecurityCtx methods inline
References: <20250304-inline-securityctx-v2-1-f110f2c6e7ff@google.com>
In-Reply-To: <20250304-inline-securityctx-v2-1-f110f2c6e7ff@google.com>

On Mar  4, 2025 Alice Ryhl <aliceryhl@google.com> wrote:
> 
> When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
> toolchain provided by kernel.org with ARCH=arm64, the following symbols
> are generated:
> 
> $ nm vmlinux | grep ' _R'.*SecurityCtx | rustfilt
> ffffffc0808fe8a0 T <kernel::security::SecurityCtx>::from_secid
> ffffffc0808fe9a4 T <kernel::security::SecurityCtx as core::ops::drop::Drop>::drop
> 
> However, these Rust symbols are trivial wrappers around the functions
> security_secid_to_secctx and security_release_secctx respectively. It
> doesn't make sense to go through a trivial wrapper for these functions,
> so mark them inline. Also mark other trivial methods inline to prevent
> similar cases in the future.
> 
> After applying this patch, the above command will produce no output.
> 
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> ---
> Changes in v2:
> - Reword commit message.
> - Link to v1: https://lore.kernel.org/r/20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com
> ---
> I will also reword "destroy"/"free" to "release" as suggested by Casey,
> but I'll send a separate patch for that change.
> ---
>  rust/kernel/security.rs | 5 +++++
>  1 file changed, 5 insertions(+)

Merged into lsm/dev, thanks everyone!

--
paul-moore.com

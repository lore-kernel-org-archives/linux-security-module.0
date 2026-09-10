Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B54594809
	for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2026 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066820; cv=none; b=MacThjmu8Z+ulaUEN5E2/vDy+h42jnaxD3ZOJ93JgqqNcxNCQX/CVqy6NqS1ELRIhSVDy9JOM9FTV0nC1pahVDJGzg1Fz5Hh8ivr4hPUCRKDKY19U3EIJ8Dhb/jPjD4Jc+v+Sx2BVvhDbV1HaZwN0YVz+AItELkwILeabT35ZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066820; c=relaxed/simple;
	bh=0vvZwREGhVLOGIz6V7/e3vYEdb98WjrdXPg4bmpdzmM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=eqDYUocOz0uT+sif201qCeuqEs/qGwAtR4BmgGA07K7EOmd/wCB3CxWrvfRQSp11fbY4ypz4ULUgIT3hfxp+GBZz1cW8fqCQobm1mMU5B86OQPAMdJLPRKQPCmBUlChbgHt/hd/cRqktVUNbYxk/F8TBpUkQXRBRTKa08Byxfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KfUXvnD1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KfUXvnD1"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5300bdf61d9so1355951cf.3
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2026 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789066817; x=1789671617; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uy7q6C+WBEDRAlNlGjV9EVm7qH12BqCcTHIyf0ThSEU=;
        b=KfUXvnD16lizCzF9wvGLcS2je7B/yEqIi9sboIHbA1cMJ+emGPxk+sSiCucig8SpXK
         hYv3/m8+oYneYZlQicJmBZfZBqM6aID/qplSJtPJL/Q5U3GHW6Jat3VX4ypsnLkafnxg
         jkelDKYNQTbL2awAL4/xmSnPGgySwJ9KjipDv/S581d4aW0sNobZQVJuOSw6jvrFwAL8
         5o7orzIu8kaSOUEw3aBSuMIfjcrorTOYzxAO8BmXf1XitD4t4xG8M/O8K6PF+fK4AMWj
         Xsu1ZTknwnfunmzbay0cAuhsVOV4vuGJHIH7F7IH+8otWPTFga7D9poq/fsUmz+gcKrl
         USLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066817; x=1789671617;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uy7q6C+WBEDRAlNlGjV9EVm7qH12BqCcTHIyf0ThSEU=;
        b=dC30DsHvXQKMWyg9bktjcQYd8p5aASK5x1fjwtjX47FOW1xXjoF1/BTqx2+h3f7YHw
         177RMjzGApvSAwlKrVhU0UuOrYeTZwkfSmILaShjc6TwdHb7t1elxonIIHkc70meSFJt
         kkQ9EzKIs0yQgydfvH6gQj374ZogXr3suYt3L/s7VMtf/fqyjnYgpmWM+wkahrqDuWX7
         kadPLEtVs/zPuTPdqpyOaiGe4wMs/g7aRWn+LzkgcgMA9v/YvgjGlD0ev/6VGkhsr30t
         WY9WVBovCCpcDK7r38vIoENVXYhuOohPjOTu+SMmm2W/SGi21cuZ6d44XvFqTNdCGUjW
         U3Jg==
X-Forwarded-Encrypted: i=1; AKwUvBx5JgVrRCth8bbsTwIkW5aySSraLPw7DxB/haj77TGqhEufwweIqOi03p6xwK3Kl3iA14+A8GZ7cohZfH0j2ijL7dMkgCk=@vger.kernel.org
X-Gm-Message-State: AFuF++lRakqt6Y4nrT3ydVP/T0Ys5E3VTfrXzGyC0fGHq1XlSW7X+hGG
	zZ/a6wm0Ugml6Uqx8q9pav8a6bHRtrXBkJ1+toc4w9c4bpNcMwfyhI4jaBg/lh0hLw==
X-Gm-Gg: AYBFou16zMLWQHgy6Jne+SVGKxb3grd3Mo3HR1Rq2Mhe1xykxq/v218wUmM/0pOFXws
	fuJVLpk7NKo0QHdL8WBz1NFrC6brWtLwvLZfwXXZHZcdKgtjRcQoEBGr+Gi+EnuN2SSoYhKgNDH
	+odtru+sDPLuO8qSIFgs4/jLFBbRk9OnXw3sM26VWbJtW3VMDZDb9fO1qzNf+ZE9f7nhmP+O73l
	CeEpd3uyKQ7zhI5SqB834JrJTNdqer5UFAUM9wTAPh9kwOIEeAab5TLhRCxf3XTOg7r0v1oMTze
	8+RxM96K19U8qg+k9FrZHSXJffLleO4vVgNp2D0PIq97ps4V2ZGElfhL6gOm9WG9PIU7ummT4HG
	TAFXuynpth9BjJQmzemWlVnMZ1z4uHWfTQme76VajdIXMtbcfnoZF5XiEZ0fl3piXYjrqGjq/qy
	z9lpk9dcRqh6TulHlf3YvwDcGT3rCgL1MetKR7WusC1Bv5VfSp4QSfGswtY5R5qTbTzqzYEXrrq
	zGCJJp/vOsWGPqKqJVDOKEwuQpgs0GmYe6buwqXluovFiLWFZpu2f2GIo58FPj4Vrtso4XDlXIR
	Ag==
X-Received: by 2002:a05:622a:514:b0:530:b2e4:91bc with SMTP id d75a77b69052e-530c878ffdamr12092271cf.53.1789066816931;
        Thu, 10 Sep 2026 12:00:16 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca50cd05sm270221cf.29.2026.09.10.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:00:16 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:00:15 -0400
Message-ID: <f7363063f6457ebe9eed74f878ec579a@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260909_1743/pstg-lib:20260909_1550/pstg-pwork:20260909_1743
From: Paul Moore <paul@paul-moore.com>
To: Nils Lehnen <nils.lehnen@proton.me>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>, Boqun Feng <boqun@kernel.org>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Onur Ozkan <work@onurozkan.dev>, Atharv Dubey <atharvd440@gmail.com>, Ke Sun <sunke@kylinos.cn>, linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Nils Lehnen <nils.lehnen@proton.me>
Subject: Re: [PATCH] rust: security: replace `core::mem::zeroed` with  `pin_init::zeroed`
References: <20260828024335.946-1-nils.lehnen@proton.me>
In-Reply-To: <20260828024335.946-1-nils.lehnen@proton.me>

On Aug 27, 2026 Nils Lehnen <nils.lehnen@proton.me> wrote:
> 
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
> 
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
> 
> Link: https://lore.kernel.org/r/20250814093046.2071971-8-lossin@kernel.org
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Nils Lehnen <nils.lehnen@proton.me>
> Link: https://patch.msgid.link/...
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> ---
> Resend of Benno's patch from the Zeroable series [1]: only patches 1, 2
> and 11 of that series were applied, and the issue [2] asks for the rest
> to be re-sent. Rebased onto rust-next; it applied cleanly, and a
> defconfig build with CONFIG_RUST=y and CONFIG_SECURITY=y passes.
> 
> Two equivalent one-off patches were posted earlier [3][4]; Miguel asked
> in [5] for a resend that keeps Benno's authorship, which this is.
> Cc'ing the LSM list per Paul's request on the original thread.
> 
> [1] https://lore.kernel.org/r/20250814093046.2071971-1-lossin@kernel.org
> [2] https://github.com/Rust-for-Linux/linux/issues/1189
> [3] https://lore.kernel.org/r/20251129135657.36144-1-atharvd440@gmail.com
> [4] https://lore.kernel.org/r/20260120083824.477339-8-sunke@kylinos.cn
> [5] https://lore.kernel.org/r/CANiq72nJqFOR9vhPBfZUNrxU+M1HMV6wN9bN6i8e9rf_oOD2qw@mail.gmail.com
> 
>  rust/kernel/security.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged into lsm/dev, thanks everyone!

--
paul-moore.com

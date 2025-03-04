Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A42620DE
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121089; cv=none; b=KnsQo4kBr5Y1RNwiiG2b2j6wywIRFnOzdkhOI4WlM7rhRiZBxeS0wkNC1vBnzaVeISta6r796KO6Q72cpe7bfY4BwYe7aq5Yc2bFwFr9J2bhv4gIU8nVn9hDOKEzzcqfjQrqTTedUuHvxZewQGXohQvL5CX+K0Cn1We163VY//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121089; c=relaxed/simple;
	bh=idw9ZvilSuHtkU6iOnnuLXF/HG3irgXsN8QUX4wGQ40=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=bp06xoHJajN998pSxsgW1MtbKun3Yq/HlnNZawYDNvCMfdujbFPvi+K26BZMV3684HQA2WJgB2TAeNzlV7squDDkenr3fx6CsuZjOIdVoVk4d64IVsfkDj+rrdAFHHvdYk6JOJ7hMCpzxeeyILVyhrfWQs5aQO3QWkeqs9PuWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F4hb/6xW; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F4hb/6xW"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3c9f7b1a6so18860185a.1
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 12:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741121086; x=1741725886; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnI/HKF2BJ2DE+F3QNufti1w5M0knTrq3arpcVmTfsg=;
        b=F4hb/6xWGLhLDHF3UhZOHuErDzYxnhnVmSq9HN6T4P2QJ785XmOa+E0OVe2XuN96ZQ
         MILoenHIICKuuWHkCMNYV6oeqKBbkq2vp1hFDxTSyRuYH8F493BRqW2nTjnscFuTY60U
         EPFZoiLtyICZB6kLDiD4wUe8KkqWGyNUzODgyAQsv2TNyUkXy1NZSbFF/WMl7/BUVBV4
         9jWECoqm/qwkBWPFxv5DsYMXnctANS7ixZzWCCMoPtY/Ql/v91h5/7LsOZC1dpeg90Lr
         CQD5eOA9axsvz2VLACYozFq+JrgLb4b3+ryO8BVAguCbwBEs7B3fprOvZr4Mxi4K4x42
         Li8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121086; x=1741725886;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wnI/HKF2BJ2DE+F3QNufti1w5M0knTrq3arpcVmTfsg=;
        b=NZ7OaZL9x5rvKaPkGAPfBzwLk5IFXoVMirjxjh0MrEomKuRY18qxtutKHsg/tt0R+E
         /+bk0ooBC9OiR1sVrqberyHZz4XiSMCII+Rxl55lvnL3AL4p1a384CFwWhCGW91isQkh
         GDBpwGX0/nf9wAoa9cG7DLdI/geBtxrv+LSvv25LXxZ8IGPBX62dA/OCZL8KZqaIlJ1x
         JgoUHE56T6iLOYGefz6SlIXliRaBN4M2a7EM55KagId/Ul7GN5xSOR4YSOKq8HZOAVl3
         JuWH4zhOuePq87TZ4baDJ9YOlM7AgPtXJuqH8qKPzphHEsS8yrb2Ojror3D/NbSFDhnI
         2PJw==
X-Forwarded-Encrypted: i=1; AJvYcCWQi63yMW/PGSi7+35SYS3NtnbXyTa8R5tf8WNIU1Fb1Jp5hwZcQzlgN8J50NOjIOts4fq2sAkTxG3nJ78aJ2LNWkOlnRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGczMtWx4tXjY4XirFSosLAqUsdzoTZ8XbDnBGIMHVpEwCfJRT
	YXzeXAg2hFUkyW1JsID8CsqI1GIOVoIPs+2vqHj4J2yaKsaSDFsNTTRBXKVwiQ==
X-Gm-Gg: ASbGncuBHOgyoDsdv5SiXaTmH2lMVXvKUH1re/vS7J5UdlMYhiL61gVGQTBg1d60b+5
	WMNWTGblK/rrjGKMOI8lXA1P3ZUsijq/Axw3Mokyy6pkvysm/vLQd4WSU6jkZRdVxFPZr05fR6i
	Q6eOD6NyBBzi+8mego+S7UlKNSLUfCfPKjtS53z/LQkn3ScinoflRUSfMDj5HloY1axWdrnrJR5
	pGt7Q2IVplfduxCEZ3cshCtabv/7skUJx21gZyx+fMAlErOmOHNB3d2XmpxcczVbL/7MqZ5DN9f
	XVE1IvmjdtIhsZ1KhNRRLTfOMGG/NHXG/LrAAN4heunJ/knzYjUJ5naqroYhwivM3uoyamQFEyv
	O/t/rhal13GP3OA==
X-Google-Smtp-Source: AGHT+IHS4jLQv2ArJ6GHx3UL9v6MsZDGfjsA8pdO/0HW7TnyapGyetgLLGkaTBXzkDVSJZ7Yu3DODA==
X-Received: by 2002:a05:620a:2b94:b0:7c3:c9e5:e4ba with SMTP id af79cd13be357-7c3cc37aacbmr691510185a.29.1741121086214;
        Tue, 04 Mar 2025 12:44:46 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3d8e51df2sm21617285a.94.2025.03.04.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:44:45 -0800 (PST)
Date: Tue, 04 Mar 2025 15:44:45 -0500
Message-ID: <c4d75f7666dac40277a9504fe1754f5c@paul-moore.com>
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
To: Alice Ryhl <aliceryhl@google.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH] lsm: rust: reword "destroy" -> "release" in SecurityCtx
References: <20250304-secctx-reword-release-v1-1-e8e9a7ff85ba@google.com>
In-Reply-To: <20250304-secctx-reword-release-v1-1-e8e9a7ff85ba@google.com>

On Mar  4, 2025 Alice Ryhl <aliceryhl@google.com> wrote:
> 
> What happens inside the individual LSMs for a given LSM hook can vary
> quite a bit, so it is best to use the terminology "release" instead of
> "destroy" or "free".
> 
> Suggested-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> ---
> This patch is based on top of:
> https://lore.kernel.org/all/20250304-inline-securityctx-v2-1-f110f2c6e7ff@google.com/
> ---
>  rust/kernel/security.rs | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Much better, thank you :)  Merged into lsm/dev.

--
paul-moore.com

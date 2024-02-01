Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810695339E
	for <linux-security-module@vger.kernel.org>; Thu,  1 Feb 2024 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794709; cv=none; b=YK7o/s2/dImOkx00gletRYOeDc9k0XJAnj06b8/ptYjW4hCVdQhClY+Gj1FthAKDfxwZhZ3If7nbEr26Ts5BFS5QEogtDEn7KUfN7kjTpVhgUvjtuBS0lRLao0svK5PQZor2Ev6snJpXj8yuR374z+MBCIoOEWHiUpaAAnKKm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794709; c=relaxed/simple;
	bh=L/VYNNbT+koDwNzfK9PrewCUQKhWOtEKnNCEgqRNo84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCfafW5nV9cxvoUcGVQyro/OgqklaoaE0hPRrtGIUBiLCIJj69ImRAWiW3qUxXY9pQ/UCTIM8vIQZoUTiiBKH4pRMzg3HB8RCuqmb5moCj/nqGyEYibQXBzpTqZRHfatRKpbt9/zbzZPQgXCM6JzpU4yppHfbbgZP8yOBoTsbxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E65WA6ze; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E65WA6ze"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51121c08535so1454216e87.3
        for <linux-security-module@vger.kernel.org>; Thu, 01 Feb 2024 05:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706794705; x=1707399505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpmR9bUFsa1Cw3gsrxoeWwbdiUlcKfDiUJAg3xWBHVM=;
        b=E65WA6zeX0qmrCfEw+jFddoDSjcpZQyZhwDNFSE0ZBLXETB0URDRTEamhQoHMVFdAN
         fc+TJKgu4l/GXGtjD1pvzGyW8/wcwaJh5/cfW+CceGRqtZ5WXp9SN5xpD5mjAW4zb5HU
         HYL2uK1VTDvSb65rkMLD//PZcIludGTtdXGtG2OrKGfDWQT/ZCfqbsRQ+pPhraLEnoBn
         hBHsA4Rp8ZdL69a8reaxkPkWxMwDCDMpu8FJOnorfYuE0A5A4bPEiMz+8vB+y9J6VApg
         wWjHfH4iM0xs+wEt25YHCjemjl5GTYzCQBRUeyihd5/f1MpC+5E8Xz0zI9jStv38B2ER
         F/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706794705; x=1707399505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpmR9bUFsa1Cw3gsrxoeWwbdiUlcKfDiUJAg3xWBHVM=;
        b=ba819K8oDISRki0COLMo41QWMKwxMfIIZ/2NUQ6V7B6xKr6wJhNyo/Uv/A63VGw9OA
         fjxedfFP12MZ7kX4+TanO9MDbOyVLAi9jlIm47HvM4xihXrVsTaNfZIMeot/qduqmQuh
         GGLLfKew4eLlyU3D3rPfMHTul1tAYozkfA0ElYQZFThVhdCpAhgTl3nJtXBGJA3gfnGW
         D5FD5zUGygKOWc3g52AImiyK8pgU2u1S+1Uu9AQFq7tz4gEqNhIoopZPAH6QsJya+cJB
         Le8cw4rsX6vbn8riDiZWoUqprUOmLzvtbUNDgNW7Ry0lWHLKOcXafZv6bcPd5rP2qQGP
         Hp1A==
X-Gm-Message-State: AOJu0Yz95b491c/0FlcV28ojBgB+7VK1EczL8IB57tndVyZAXdheKnGO
	Rh/+mV91H1Hh3uOZZMNsKdCVmShh1K+eZ6g9D7cCmp2VDH6FdU2d5DAjd+gg6Q==
X-Google-Smtp-Source: AGHT+IF5Rbk2Z+/s7PSKhlynZf0GFY2DdA7Lu3ihbEyZItWSKHdZ0NzDAsGc2WmZp5FkxaZ+2Zszlg==
X-Received: by 2002:ac2:521a:0:b0:50e:8762:3c0 with SMTP id a26-20020ac2521a000000b0050e876203c0mr1564829lfl.48.1706794705333;
        Thu, 01 Feb 2024 05:38:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWYyCUykOxerO4SmMyPfK0wwuaNlIjiwfsyBq6S7UjY41iq3KH6FiA/682vPFidk5LkH/CT70JppB2IZTxI1xpUzk6V8TeZqqwSS3xZqiCswuSqe2T7gxvt4QjY53p2ENW7QhsKE5KWxDLaCSo4oxhlP1tFiS8Lz/UwrYd2JId5YJ9c5DuF1Ih2fKIWZK4YqPuovM2hUsjvH4zub9qphcZizuMz7SfV1mDf54lzkyOWjO4QOzvydYBy5aqbcCk9zfyeOe5lNWf9MOopC3q3Huft
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a36a8bafdccsm867541ejc.110.2024.02.01.05.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 05:38:24 -0800 (PST)
Date: Thu, 1 Feb 2024 13:38:20 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: kpsingh@kernel.org, ast@kernel.org, andrii@kernel.org
Cc: revest@chromium.org, jackmanb@chromium.org, yonghong.song@linux.dev,
	gnoack@google.com, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: add security_file_mprotect() to
 sleepable_lsm_hooks BTF set
Message-ID: <ZbuezASA0_Ng2VB9@google.com>
References: <Zbt16HS-9x8YPZNz@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbt16HS-9x8YPZNz@google.com>

On Thu, Feb 01, 2024 at 10:43:52AM +0000, Matt Bobrowski wrote:
> security_file_mprotect() is missing from the sleepable_lsm_hooks BTF
> set. Add it so that operations performed by a BPF program which may
> result in the thread being put to sleep are permitted.
> 
> Building a kernel with the DEBUG_ATOMIC_SLEEP confiuration option
> enabled and running reasonable workloads stimulating a BPF program
> attached to security_file_mprotect() which could end up performing an
> operation that could sleep resulted in no splats.

Actually, no, please disregard this patch. It was only a matter of
timing before something had popped up.

This was sent out far too prematurely and I failed to realize that
__bpf_prog_enter_sleepable() calls might_fault() and
security_file_mprotect() is being called from a context whereby a
mmap_lock is already being held. In essence, this also means that it's
not possible to run sleepable BPF programs in contexts where a
mmap_lock is already held as the page fault handler also attempts to
take the mmap_lock, and well all know what happens when you have the
same thread attempting to acquire the same lock whilst already holding
that lock.

> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  kernel/bpf/bpf_lsm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 68240c3c6e7d..da52c955f3ca 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -277,10 +277,13 @@ BTF_ID(func, bpf_lsm_bprm_creds_from_file)
>  BTF_ID(func, bpf_lsm_capget)
>  BTF_ID(func, bpf_lsm_capset)
>  BTF_ID(func, bpf_lsm_cred_prepare)
> +
>  BTF_ID(func, bpf_lsm_file_ioctl)
>  BTF_ID(func, bpf_lsm_file_lock)
>  BTF_ID(func, bpf_lsm_file_open)
>  BTF_ID(func, bpf_lsm_file_receive)
> +BTF_ID(func, bpf_lsm_mmap_file)
> +BTF_ID(func, bpf_lsm_file_mprotect)
>  
>  BTF_ID(func, bpf_lsm_inode_create)
>  BTF_ID(func, bpf_lsm_inode_free_security)
> @@ -316,7 +319,6 @@ BTF_ID(func, bpf_lsm_path_chown)
>  BTF_ID(func, bpf_lsm_key_free)
>  #endif /* CONFIG_KEYS */
>  
> -BTF_ID(func, bpf_lsm_mmap_file)
>  BTF_ID(func, bpf_lsm_netlink_send)
>  BTF_ID(func, bpf_lsm_path_notify)
>  BTF_ID(func, bpf_lsm_release_secctx)
> -- 
> 2.43.0.429.g432eaa2c6b-goog

/M

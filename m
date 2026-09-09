Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1DE3DC4DE
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990526; cv=none; b=jlVR1OpT6JtCsuSIJ+EljnssnJAGQMQ8U7x/d+5gYrd8Lp2DiWITFFsBlVuwvOlgyk+wka+NCQtcQ+iOuzbrYGUc//gyv5sPpTjC6aWA+EMfh4jXFRsqGBOdetEq+dyXW+5DLVoB8Bu/kzDVA9HWWtEznYvufaHo0V5TlEiNk9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990526; c=relaxed/simple;
	bh=SSTwEHCWAc+P5g44mSyZbT9L1Ie47uSnjWAmoKDqiVw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=BrRVKQWksSAmYote5X5iLD1A5pDpf2VwKK1bfh9fBx2qo3KrBrtERvNDd54tTSuPvXJY7dP6g1mkfeNn/UZxJ8ii2ban5+p15S1fOxWlsDZQMAhvGPqOpBMwB3yq4Wrh3FuBMrCTVSJVwmPRmggBhN0gXDS63EAOXRswHQ58nY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bcyArZYq; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bcyArZYq"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-90e8e70fa02so67871686d6.3
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788990517; x=1789595317; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWlaXXsiZZ3hxWAJkSJI84Lovlcl0MiT9GyGYtm/owE=;
        b=bcyArZYqhEec8abeb/GPGfpTZ3GKiWJE631k4CpaFSKMfgxO3nw/KamJHwAYzPuLxS
         w1NYiGJAI8lJ4l4BdPWvJTu+D/2l40le9cFNi2goniJJjZBc6hibiR30Ww2bSBVL9o0E
         O+nOhfgE60RLjaKC0t+JeSmiNo3Mayg6xu0GWdy7mIwsFuQRFcqGl0vEsmcLomAUSP1T
         nE0l7OkYARftuYFLI/iqE1L0suwKjBXdA4/ZOjoI8rNX4tPDHWZAGXuZMshQuSZA5QH6
         xEAPFqCjaMULxsYFaeojsumQZIO6D4ml8SzpMqlmajhrJzaa7+7nGTOUrqEVteBb6MZL
         xsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788990517; x=1789595317;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWlaXXsiZZ3hxWAJkSJI84Lovlcl0MiT9GyGYtm/owE=;
        b=nS6CwtvQc4Lp/o9iKpoQqrjtgWETXlzEdZFMF2rSWGL89Yx5sMLXyseNgfkvnuu3/2
         X5QF8Oop8QlLeuxGljguHTYO79QHEK7vL9Kk5EumD+WKdOS4R6sBPH6hp+W4Re7reOvv
         uku5B7xHgNZfiYGycY4wWanWzdDYb31F2u0pQ+M65/APWOpRX/+R53txhpDTiNsHpbzs
         bI+Rj2rcLxhoNi6cCo8L1y72+Rt1ADQ5OgBWI9EcQvIis3t7nJ1dCTRgAKKoepF03D8z
         RnWvHC3UiFawMiZdEuIQEBFMOMuipWbnEW4W3XRzDaObqD3KAy6XxpdJv/EFegd/URUt
         WNng==
X-Forwarded-Encrypted: i=1; AKwUvBzYBWRjHghUFlrH6JswOm8SbBzipOZAtJjK96/XTIL3tTiDwtFTdezNBtMM9salnQjrPDZbDHOt7T0TMf/1kJeTDduECtQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n24Vd3t9HmY0+u2i+0Q92ocsEHqQKeZA30Chs9gXf4zbB984oS
	83wTYzjwMXrmA4fQKg9BcldUHSlCaqHBgaOoeIaDEvHlh7l/4cKF0oewHaLq9wzV4Q==
X-Gm-Gg: AYBFou1xZKGFnYcRFqIes4pVfl4+AmnQPuFCbH4YghJMn5eMfSECgeW0hC9yseIXMDg
	80vqwoCUmGNwKp+cE3Dw0nnbA6jw5vegS7bzQSutUt6nXj4d37ZjbLbDQIvkyyhU+2nQsRhRjk+
	UUWlIXrHentgsmyUFMbuBdN1yOsxO/FMSeX6JPa07cEWBJ/s1Du0y8i+IXMoe+ahqE0SMJf0HxZ
	A9zWBLNu1NRC6JHWoH8Iaj0dUAD/4W98axWX4AwgUhbKq2cOXWjvnlIBVaRJd5c9m6OjmLXj806
	mIdgD+oC764wJCjOPcOFCtafovMypPdDXVqln9VsF9toQqGmhxOF3jkD9ivEV2EBnJDfY90QyXG
	Kp7aqkDqrJDm1mvhrKQ5njkJ4FWfzY0X8ZQlrqkjQ4U1LKeUiN8WRTqhZlRdII7cG6nURaxVAxq
	/zl8RYICcS7QhSGQoJqHH7hc0MGmDjDybsAxnUml4FQ1Fqo25kqNhLU7bWs+A1EpTOFRFOGpGR+
	CCfeYQhNNv147vbRiWVKEyC27jQC5Nx7LiLB70XjMzQgvecpVSsEKt5T1cR/JNxCgNx35uYiXVO
X-Received: by 2002:a0c:f00e:0:b0:90e:9361:d035 with SMTP id 6a1803df08f44-9103ef8d87fmr444413406d6.21.1788990517405;
        Wed, 09 Sep 2026 14:48:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91203ca1063sm2439906d6.5.2026.09.09.14.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:48:35 -0700 (PDT)
Date: Wed, 09 Sep 2026 17:48:34 -0400
Message-ID: <5b09aa12a73fa955c49a4499dea6866d@paul-moore.com>
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
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: Serge Hallyn <serge@hallyn.com>, Vlastimil Babka <vbabka@kernel.org>, Kees Cook <kees@kernel.org>, linux-security-module@vger.kernel.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: Re: [PATCH v2] cred: prevent slab cache merging for cred_jar
References: <20260611070054.6550-1-med08elkadiri@gmail.com>
In-Reply-To: <20260611070054.6550-1-med08elkadiri@gmail.com>

On Jun 11, 2026 Mohammed EL Kadiri <med08elkadiri@gmail.com> wrote:
> 
> Add SLAB_NO_MERGE to cred_jar to ensure struct cred objects get
> dedicated slab pages, preventing the allocator from merging this
> cache with other similarly-sized caches. This is a hardening measure
> to provide type isolation for credential objects.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> ---
> Changes in v2:
>   - Collected Reviewed-by tag from Kees Cook.
>   - No code changes from v1.
> 
>  kernel/cred.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/dev, thanks!

--
paul-moore.com

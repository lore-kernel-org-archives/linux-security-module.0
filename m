Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004FD470EB5
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164571; cv=none; b=VLC4LJZkUeSdPDOjoOMg177aIdlEoZiZMxq/e1Gilfrm5qh3GVNFvq4UVSBcaNa7OvT/3l4MV60/KdkZ7hCHhka20rFeiTMiWm+lrg7bfH8+TEgmb3OFPeLSNklvVenULQIgKlB4N/XzCrm0qRDuXm3G12k/SdErduyZXREoj/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164571; c=relaxed/simple;
	bh=/R8G2rUpeGdvgZtyaJUbEvh1Zo+WC84WR+inH5thUNk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=TCkic20O6X027D7i4Yk7Ig4AzUgWNtrEZB6CLF/P69JyuhSRCW29oiXBql/6LjeMQXvURi3PL+ms6MCcidnoIstMeIjjJ3q3xMWqgnenJ1p4cUdaXn/wo+9DRY/HOCPmjJCe0Zeoci9aPnrzerQMZl1RfbFo0VkA8NzmIpSPOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U9n2bPzD; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U9n2bPzD"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-530e67fe8a8so1314371cf.0
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 15:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789164569; x=1789769369; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=REcGNRrG3IgyeW+W01iwNpi3SPP7pS0X2/2+s4p9Ep8=;
        b=U9n2bPzDNh3hi3J9W0QQ2UNGVEKLaQ/ZwtFwa55+fQNvrZB85ePcVdljoFKIJD5HiG
         XqSjDGbbbQpWzyNtG+BfW/6ChTV64Gg6+M+aovfGzCHDzSa9Ts7WhnSkMY47ChKaX690
         9XHhmKXw+xGf9wZK+vMlmbOkpBWcCVJBjLidyM36XBVySGz49RHGzjZP+7MKF4mjDlb9
         j2fx8w0oVdojWBYygC7GnGpJ89Kmj1HJyKzahe2QtH5KDaMc6hEr1t0h8EJ2tjKtXgNz
         lP/ZP8jkS1Mw1wVadm1lCe0Nu3bxRrtJGJ6Uwm04S/0lXj52vgmByya1AzxeF0GkMh1S
         uegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164569; x=1789769369;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REcGNRrG3IgyeW+W01iwNpi3SPP7pS0X2/2+s4p9Ep8=;
        b=lQRkT2f0PeuSVQzqWaPNHwPa9stTiDmxNnlu2vVbDDpbSRb68uQJdNxll6Z8gViyat
         m4LzMPM473A+OefKN5dmkD+EMhuzMv+ecC/Zd7rULpBpUMQA8/Sg8AVlkXTwWrt0xfgJ
         njHLC8izK9ynYXT36vTZxAzyicmsdgamQ6KNOllcfqefYnbOLG5m5YuGDpT+b9AG7741
         KLLKnEomncHwCMT23fj+/bokiyzH0uZAz5QXWVVLapLrZ7ekqjAu6/Ln5/Mx6I6Hq4g8
         eFZ/E+BRLdWRvBes5o+M6chVkwrEMHe6+VD7vJb2LLrDeCHGKyD6+rBm7qdbP7Ptywm+
         WcUg==
X-Forwarded-Encrypted: i=1; AKwUvBxRGEG3yvGt1xuSNGeYMWQVbYp2wjlBvWa77HYQSKy9s9ZBRWMiBL9BFCWCdaXVL+bp2ZbBsro+bmtzENAyLH2qA8J5KF4=@vger.kernel.org
X-Gm-Message-State: AFuF++kFI9hf9wJ3YTEma6ekyHpGSakswliJvUyzdnS6ZfOJ/8nsNp5p
	JJNcPYdhu7dU7n+2dyySjTaHdxWe63OWYM+MH/qIS00gpg7XoTQGuRvXKxIBc85T+Q==
X-Gm-Gg: AYBFou3Xlq61zjx9/p11l8wxLcCR/vrbSgXRtbpr96fVVWLmPDVu9kuoaOxRvuuBSBX
	jWPIC0RXqi965fuaxXIuE04YxKk2ekmprNI1I/GP0nrInf6Jil4z9NPaGOywemVKcK/ThAqyjB+
	7TbZqv1fAZoANOjF/PSYIUi1hTxppQhFxA/NyFXMT7YRIr1KG5R2cA4nKjhgRgiJw6eti8dsFdM
	VVxXyAhYc1bMiFHfUMXBy+DvJcu1wXxybFDApg19OxHdKMBE7LDGMdwnEqRL0bJ8fot+SXzhgO2
	iII/as2JiJ4WIPs/3rN71HY1iw32JByjOIl0xDJwRhErgiwAC9bcS62groTfbSyJL7uuozmKpxU
	N0UxE23E3tMD5lt7f5R3ppCP2+DtfnpM8l1opLOzcRrX8TjWh6xDVhbIBMFgM/dlswbneRf+h2m
	Z5N0w4QwlvTgMqwa8gJahWZEt8PDwxBehcSDzfC29sWEL45nLii2Oy8f3YlepNfqSA2IZ6ZoFPg
	jpu7h0Md2VrI8CL1d3WQAGyPRLK+w06P4H3o+ZsY/Y2u5ZvI8AOulAkI4kpmgUkevV6Y69n4yQK
X-Received: by 2002:a05:622a:588a:b0:516:dda7:51e0 with SMTP id d75a77b69052e-530c854284emr105918091cf.17.1789164568783;
        Fri, 11 Sep 2026 15:09:28 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca4b9c54sm29928441cf.20.2026.09.11.15.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:09:27 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:09:26 -0400
Message-ID: <7af3da1c32e9b388771aa7406dd42098@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260911_1254/pstg-lib:20260910_1848/pstg-pwork:20260911_1254
From: Paul Moore <paul@paul-moore.com>
To: Lincoln Wallace <locnnil0@gmail.com>, corbet@lwn.net
Cc: skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp, rdunlap@infradead.org, Lincoln Wallace <locnnil0@gmail.com>
Subject: Re: [PATCH 2/2] doc: LSM: fix module ordering description for  /sys/kernel/security/lsm
References: <20260714013832.977443-3-locnnil0@gmail.com>
In-Reply-To: <20260714013832.977443-3-locnnil0@gmail.com>

On Jul 13, 2026 Lincoln Wallace <locnnil0@gmail.com> wrote:
> 
> The LSM usage document states that the capability module will always
> be first in /sys/kernel/security/lsm, followed by any "minor" modules
> and then the one "major" module.
> 
> This does not match the current LSM infrastructure:
> 
>  - When CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is enabled, lockdown is
>    initialized as an early LSM, before all other modules including
>    capability, and appears first in the list.
> 
>  - The integrity modules (e.g. IMA and EVM) register with
>    LSM_ORDER_LAST and are always placed at the end of the list,
>    regardless of the position of the major module.
> 
>  - The relative order of the remaining modules is not fixed by the
>    framework; it follows CONFIG_LSM or the "lsm=" kernel command
>    line parameter.
> 
> Rewrite the paragraph to describe the actual ordering: lockdown
> first when early lockdown is enabled, capability otherwise,
> integrity modules at the end, and the remaining modules in the
> configured order.
> 
> Signed-off-by: Lincoln Wallace <locnnil0@gmail.com>
> ---
>  Documentation/admin-guide/LSM/index.rst | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Merged into lsm/dev, thanks!

--
paul-moore.com

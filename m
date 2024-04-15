Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AB97F7DD
	for <linux-security-module@vger.kernel.org>; Mon, 15 Apr 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197203; cv=none; b=cJZBXYq5xSziEkBIW/df1mre6p4RaOhjjW7BY2JNymvY/fVN66eGiuwyHIvUYPJiJVX6dNxf7J2dqZrDY0STKETEfbejGSh2IT4+uDihukjjgYsQVl/d73GMdARNow/UgZGdCMLlcw9zFyGAaMyYdlQ5rCCfIFe52VdfLoaJD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197203; c=relaxed/simple;
	bh=TbkoZcrC73ReILBlLCzDk8hBya5REumqV3/XGRD0RBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjUBuLajDNfRct5bt91ipaFyORcZ286du7hreCQnYxWxY63A/SOr85qGZ0ZP37f9+jQWTG9DIQvohY9SZ1BqjIkemiIUuCSzlW3a+3TLaCRI3O0iocDdsQ0jkJpUvA4pwOfxuBw8FEBFPfLco8ip3ok0gVoHP+ASHJsiS8/VpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O8xv1am3; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O8xv1am3"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2829460a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 15 Apr 2024 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713197200; x=1713802000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9YkT2PBxlsTiQpc9k80Xb2w2qGzzlQLFXvx15ENFSo=;
        b=O8xv1am3Lk+DQ59W9cNWa2OG2Fks5PZkZcv6Z6Pfi7Uv5Oy1Av7RnTmnxj3FUYOm5V
         yx4o1he5W90asuV36XyOe0antbXBxeK6gi/EVqhCphP56lqegAsztJrs5wGp912uqAFQ
         L131duRGarDG1vumEdOdHiU0czbOW9+JxRfTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197200; x=1713802000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9YkT2PBxlsTiQpc9k80Xb2w2qGzzlQLFXvx15ENFSo=;
        b=IGFSz45y9vHTcCfoRi/3wMWk3oIaxJDuyK0GbKZOgjptwPkWT/QmndjIpV/YGG0OLS
         utT1D22B4guZevgvz1WG4FDxyv/CIEfjJ18OLaZWvkGoyJjoRe8wvILxNBxPssNhx3rH
         lUlLhPAzNRJ2ZXd7TTZBnhwsTBcZk+RZzbgLynJuZAGPZwfN2R1oaMBGUakzZUmXsHQO
         XO5WE1tQpF7ZYDUlyZdbONPrpEkfXzW8IE7knfCiZdlwVBwbD6SudqZcHAaHgIl43xw/
         vKktnjD094hZXJDcy6KjSkTa/Hpx5Wn1X56C1oYklqqgbJBJinTjOYo6kYNi5tJFsLL7
         Aplw==
X-Forwarded-Encrypted: i=1; AJvYcCXtN7Zrwr3F7/PMlXmbtMYHUL+0/yUrhuXq4yZNtNVMFyvIqRY20xRsYAP2LVMsB3qhNPi8YzOWndUk94N9hUX9HFYZY57pJl3sdzAjypmuEQfq6K1t
X-Gm-Message-State: AOJu0Yyu1ORJIAFh2X3tbuWE5E8I9OJkl+hXlcz0NHPYpchTI8D2ecZn
	vGs/XSe8aatSG8HuHc5OIwumU2hK2vU0wpA7Kf7igFqrzkr1HRbnXRpLII6h+w==
X-Google-Smtp-Source: AGHT+IEOd/x1N/CPtx25Nf+PUqf1rfZqa2mTy1XxaxcS7HXEzP+ucQDv/NhrafY/fDlqqKtbbV3LWA==
X-Received: by 2002:a17:90b:3d3:b0:2a5:ba9d:a06b with SMTP id go19-20020a17090b03d300b002a5ba9da06bmr10113697pjb.5.1713197200332;
        Mon, 15 Apr 2024 09:06:40 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090a49c600b002a46b925e99sm8796108pjm.18.2024.04.15.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:06:39 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:06:39 -0700
From: Kees Cook <keescook@chromium.org>
To: j.granados@samsung.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	io-uring@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/7] security: Remove the now superfluous sentinel
 element from ctl_table array
Message-ID: <202404150906.C37D8D9DA1@keescook>
References: <20240328-jag-sysctl_remset_misc-v1-0-47c1463b3af2@samsung.com>
 <20240328-jag-sysctl_remset_misc-v1-2-47c1463b3af2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-jag-sysctl_remset_misc-v1-2-47c1463b3af2@samsung.com>

On Thu, Mar 28, 2024 at 04:57:49PM +0100, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which will
> reduce the overall build time size of the kernel and run time memory
> bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> Remove the sentinel from all files under security/ that register a
> sysctl table.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>

Acked-by: Kees Cook <keescook@chromium.org> # loadpin & yama

-- 
Kees Cook

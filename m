Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0A12C11EB
	for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622727; cv=none; b=FZJ1vksYIu5yQxbhPfD2UlB3aq//JLu0JjAkCyJa17S0YH5MbX/SKbZo2zZoxFS/T9sk4dJ316y2rO2DgHtT+89zayUDM6AfYAl+EzhaLf16FfxLcEf+dOnMUFXpsRU52bNI5GJ/w1Z3MKSM/N+CI5uKBVEAPbalKEWF5fmYZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622727; c=relaxed/simple;
	bh=xGbplm2EFCq46y+g87DaF0fkvZ7Ju/EyBEx5dbsOSOI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=HSTIViAztexTPXjWMac3g2+7eT9v0XwfslbRZNGtkeEgAsSjwcbDIEDl5WiFEQw1JYzDw2hTmqwZVsePpifxutF2zZWgzmoR9QWIkVyGDhEJPeVUGUykc8R3k8vxTqjrnxFe2SPz5GvCP5gTrcwLKa+3IAEoL6tkNqRvaGgQhWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FXI+Xw/5; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FXI+Xw/5"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b5f3e06ba9so26662031cf.1
        for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 13:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757622724; x=1758227524; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLrHT/muhR3agQeAEW9CYBXnRqbyoXmg5paEsWlwRiY=;
        b=FXI+Xw/5n8OUnImEMlEMfhvMkJtgQZFBe1PfpA9uXVFzFGyXu8G3KLdr21DQPx7Ysr
         YtlmBQAXz69A+60/svklgAMkt8rn8N68BCGf4dRrRrQxhVQ5HdxReg2VRsKj3w3TBAdK
         cFEOrJ1Ta9huElhsJiarm++CbXey+FL4KJoEwlmd5Az5lM/FYlpREcr8JPXkWVYKdHQu
         fOpprsPcsLgl5i6jeY0bAa0OaBRCLz10HpvhcmLDhFD8a39WM1NDN/la0vlm5wIBc4gs
         USxkk1oQaOOTUDRtCPG0J6dJltO1o++hrh4ydN7R0tCbyK86ZiwnTDaLt8WT7taP5LNL
         aqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757622724; x=1758227524;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FLrHT/muhR3agQeAEW9CYBXnRqbyoXmg5paEsWlwRiY=;
        b=E2wHvEQqpIOyOB6AmhwUkTQjdnC9RcfCjVhpeU8dlvp/X2ywsQpeLh9wCAhQ+CLZ2i
         yFA+6i27SV17Ku2jA8Op/LOcwvhGg+9Fhl54ygi1V3uSere3SbJ8pyAF+GdHpx1V38yJ
         mMFvGtTK8c2QJpa3fxhNBQzF6ibYVFAUnhjNG6rSOHAIV2k6kyh5W+aw9MxkcIAcQkpf
         CASwLAsBqckj/7hFkDEL6DxhO1Qc6/CaVVKukeJBr4uoVpuCla3anvRDqPa79OO/vp2C
         9E78BI5Mica00RJjW8C8PrTSyIvt7Q89p+xIk0WLzF6FbG2xv5KGoSiGU256E4SOdHoX
         4ZOw==
X-Forwarded-Encrypted: i=1; AJvYcCWHJ5pnzOhlGfDrjjpXy9cUudKaYAb28m20ndoWBU6FoyBx5XwQQBhKD8qSLD+o+7lN3kXsK9f8HGCHl/gz6Xuj7ICToqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg2o1TbxL4aED0tbwBySjF1K0OzR1zLF0oecyHA1Wox+Gfj5SX
	5vm8UVT5Qnd4EfF1IEO0fYwQtitXp7HqITgma4R5WVDywjI8W1jXD7gk2/UyUVVqOA==
X-Gm-Gg: ASbGncspLwpTLfs0KNizy5pWM+gjODZAfQ7EQ5+uVhMRNiI4Dc6KK6NOxJ+WT2nb6Q4
	PxamoY2dHh8RGlCryQQ2ZvVfpErNYWGb7r7s/JGgjh1lFre9qzNXKIxeo9i4wzWboFj15ySlaY4
	JYv60bQo2WU1ZsdEBP1dxiMGwsZ9yKva6TMl2tvYA9s+NYVR2/yQ2jYIKSHsJlxLJqRjxc+Bw5f
	1F7QbAS14TXbjWbHbJTQJz8pafZi4H1PKkIqAoLTQMvpud7tF1T3bf99AVNJ669X5NwAglxEqFm
	vuBF2Noz8uVYcID9uoGh9OzvmQsE6GwZBmAeWlGKZEq0Up2BjIXEKVmsSUvoh6sCVq3Nsn7WBaY
	IkRVeKrcmpgx0wH/eleCGj85T9tMYz91hCs77z+tlqwFwsmjnd74Y8RHenObzJzCXadly
X-Google-Smtp-Source: AGHT+IF0l790Z4iNrZheC5yTY8eXGvQyCJA7kmfoAW0vakFuuO0FDwtJ8sg5goWQVYq5/gSOIOCgcA==
X-Received: by 2002:a05:622a:255:b0:4b3:7ec:d22d with SMTP id d75a77b69052e-4b6347e7880mr53485961cf.20.1757622724416;
        Thu, 11 Sep 2025 13:32:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820cd703f54sm154962685a.37.2025.09.11.13.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 13:32:03 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:32:03 -0400
Message-ID: <684fd2b1e3d47c3e14b74b904f233c57@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250910_1926/pstg-lib:20250910_1926/pstg-pwork:20250910_1926
From: Paul Moore <paul@paul-moore.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: CONFIG_LSM: LSM can depend on SECURITY
References: <20250824222800.92263-1-rdunlap@infradead.org>
In-Reply-To: <20250824222800.92263-1-rdunlap@infradead.org>

On Aug 24, 2025 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> When CONFIG_SECURITY is not set, CONFIG_LSM (builtin_lsm_order) does
> not need to be visible and settable since builtin_lsm_order is defined in
> security.o, which is only built when CONFIG_SECURITY=y.
> 
> So make CONFIG_LSM depend on CONFIG_SECURITY.
> 
> Fixes: 13e735c0e953 ("LSM: Introduce CONFIG_LSM")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Kees Cook <kees@kernel.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> 
>  security/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

Merged into lsm/dev, thanks!

--
paul-moore.com

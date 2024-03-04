Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A9612FB
	for <linux-security-module@vger.kernel.org>; Mon,  4 Mar 2024 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574966; cv=none; b=ulSaiCiPVGLcrT6UQ7HfAnpSZpBb9o18ayDZNi5SfSw6fhld/fLvr5IfbeUkxCKF8D82dj5YiQQUbwAkhQoUjARL9aR870oV334+/MHsluBb1PGjpVHiRfuPufVoI6EkGyTHDL5MuiGxJdh+K7QzOF+i6LLpLRJga3i59esZGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574966; c=relaxed/simple;
	bh=sjlJjVa6TG/fX5vFVh6AwpeyDBSvVtN6my3+HRQrKNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFOM0WEYvpub/rByERBoqn1Yxx/Z2Di/vU6oUBAExNDtnms9uvVZsEOEJHNW5x+GC7bvciOXGB1pmS1Cvw8UW0XrEd/lMg1ypntFHiAx2yEcSsEi0tTZ4Zp6NItu4WCarcAgz5wIugTOuq1pts4o/p3v9zvLQ/wEDIfphmbSYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JaZSX2nW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JaZSX2nW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dd10ae77d8so9113725ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 04 Mar 2024 09:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709574964; x=1710179764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v2VvyqeNIcG/snWQL5vBwyojit65ijRwWamSan0U1MA=;
        b=JaZSX2nWU6XL1jLsvNiWT7HooTxxdp4LNSLgG+aRhKYZMw0tCPKQNaKsbI0amVaE9a
         4pzgs27tB3ZdAGv4mgzTBYf5Q0+/elxcqWEHHyAhHfBJH7GXjynRJvabpWaAH0NFRct9
         yKLnlgaZvNKwbiCZ3VMUEQS4Jq2nlEBM3VwbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574964; x=1710179764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2VvyqeNIcG/snWQL5vBwyojit65ijRwWamSan0U1MA=;
        b=EMcMPj24WnbKsl0S0JybOQhW5kxm2AMc7nv1PbzGoW9B4GMB8shrxeCNSicZApSgON
         xAaESXutGDEjrH15Y7TFCiLJfBkapzlSVZAHAMo8aGP4a8nBAeb0UeDWokyyGTayed3C
         JXlsnoEJqmWlL7u9XVcAPWERd471eIIu96QRDQ3EDezyl+8Zo1HaA6F7kqwZvCIosThH
         HjNyNalgA+12jq+Oo8jIgVAqiEJDmZZdRtXV2eZ4+5c1hADSqDvwOurLevAgol002T4g
         tWV982oiPjeLmbX0qsxheUvWNnTriMPhuaVwUNI4zBx2uZluVaMK5a8eMhbB0Uenv2w+
         uVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXz9XXV/ITbQMN7FSR9LizEemnmBBYSrjhlnrL+yl8FUfuNlatKdn1ThYlnU2IfhOwP8LHVK1RBO0D1NhZjInikeRimyZ5bCVbxOciWra4aaZDDoKU
X-Gm-Message-State: AOJu0YxjBN5v4cEY9CstVzuJEzzucbknhwD9rJ95I+Fyt6tIwzRSWwGy
	RqNY51WnbDk6uw3XglzwEH5K9U8MG75oNF1rm6DNsbgz3DDzGtV2xkNC8CbleA==
X-Google-Smtp-Source: AGHT+IHDdo++0qU0prq5GO315bAFoyYz0xOujqSX7tL10ghla7++THNQj2iSnziTmJMEzirgbCrDIw==
X-Received: by 2002:a17:902:ccc2:b0:1dd:159:e2e7 with SMTP id z2-20020a170902ccc200b001dd0159e2e7mr6628681ple.39.1709574964374;
        Mon, 04 Mar 2024 09:56:04 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b001d9a91af8a4sm8792261plg.28.2024.03.04.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:56:03 -0800 (PST)
Date: Mon, 4 Mar 2024 09:56:03 -0800
From: Kees Cook <keescook@chromium.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	kernel@collabora.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <202403040951.C63C3DF5@keescook>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <39e47-65e5d100-1-5e37bd0@176022561>
 <20240304-legten-pelzmantel-1dca3659a892@brauner>
 <3a1eb-65e5dc00-15-364077c0@216340496>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a1eb-65e5dc00-15-364077c0@216340496>

On Mon, Mar 04, 2024 at 02:35:29PM +0000, Adrian Ratiu wrote:
> Yes, easy to block and also respect page permissions (can't write
> read-only memory) as well as require ptrace access anyway by checking
> PTRACE_MODE_ATTACH_REALCREDS.

right, I don't think process_vm_writev() ignores page permissions? i.e. I
don't see where it is using FOLL_FORCE, which is one of the central
problems with /proc/$pid/mem. (Which reminds me, this is worth mentioning
more explicitly in the commit log for v3.)

-- 
Kees Cook

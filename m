Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360C3548E0
	for <linux-security-module@vger.kernel.org>; Tue,  5 Mar 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633549; cv=none; b=UahSABCmIT5hrjsFyxxFwItu0c2OjmdUOLMGjLs+7xj+vmOf+79ZyQoEZEjrQopJp39XgXXYSYUUH+7bc/5gYczjrTYY7agik2ceG2DlBNns1I/FU8KJpKHRk/qxVrAMlF2zxXYvNRZQS3BXRWMF2ojfFOXO4mSM92JAQFh7fBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633549; c=relaxed/simple;
	bh=qX84Qr8Rjx3k1Qrrec1tOKVgxK5Rdtm5/Yv88GrB3xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0XVn1ECQ1M6tNqj9+rUZHZw4mA2dejL8kb0ykoryXx20JT3IexklV7/s+wfr6tJ9UYiRusU0LUY5GPmoYPhub6gEGOjKK/hysK+qywO3C4ldDzT8DIAp0In+eCOXbJ+nCurFT7BsYyT3F5F1tmMGyfMEUn4jZi0TVoFp5wITOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gT9lMjiE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gT9lMjiE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dccb2edc6dso45464035ad.3
        for <linux-security-module@vger.kernel.org>; Tue, 05 Mar 2024 02:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633547; x=1710238347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90GoPmdoNB7qy/Rz4aKAQpu8I3w30a6c5BBckmqB0YE=;
        b=gT9lMjiETrAheaS14Ym8qIZ1UybbiLc8FoP+cq4pXprpgq/K3ae6Hyavcrr8ezOnEf
         EwlHVc5SET4LNV4m+8tMcvR3Zo/b4atkP34fMI3c2vMsw4bzu4er7OssbexTHiQy/VDR
         vW9HcMeHMi4+K2iC4Vwe57ZpMV6TfQjgCtOeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633547; x=1710238347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90GoPmdoNB7qy/Rz4aKAQpu8I3w30a6c5BBckmqB0YE=;
        b=uNFa+z08YZIa9uxCW60twPpqYzasB9mHs9gK1W/cMYgdJ+pelF6cIfb6ik+XHUoVZn
         Rk/C/kb9QTqytmsn8StzCYZvUZLzelfuQlwcxiHg9cvXKeSYV7T194vN//J4QSSVrLul
         9HqpRqLskZziEq+xPQw+OExspKA/RJZ+x+STvhMkAPQOM3qt/29u+A2Rv7NbtAH5eB3X
         gLTbOEbwVE7ndpGMDYOEJgRUt8g1IQQrpdR0wSiOp21ze+8Gv7hguOy3IY5FeWgNxPQ6
         eQ6qirwHC7uxFcJjgDOZ7TAiWJGfxcUIJCn5gz/3RoBZ/GCWgTjbUcjm6Fh2XiIx5lDo
         1/XA==
X-Forwarded-Encrypted: i=1; AJvYcCUF45ITbKd7jYQikUW9IhfI7nVXl8j97KgRrSrZa78gyF8gGyxmiuEgWX1TlvOG2/kM2gjqik3zQpSzX1A5+TqW4wbfR9hgBCnVxU6W98Uxr/3ASbAW
X-Gm-Message-State: AOJu0YydrC4yEr2KQlTq+HE1yJK87hryexZU8SvyYTR81XlSn69JKL5n
	uXuwM3MW6V2kT/Ju0EpWVWzEmlbAmuOrtsfFW776ne/3vOyzTuMX1VsECPK6CA==
X-Google-Smtp-Source: AGHT+IHivF51UPX1N5OEzkfKJUGVPso4IRPc5xLAaCXRGUd0otijzh2wsjGTeXcfAY79j5YppLpA7g==
X-Received: by 2002:a17:902:8a83:b0:1d7:2e86:fb2a with SMTP id p3-20020a1709028a8300b001d72e86fb2amr1109359plo.65.1709633547547;
        Tue, 05 Mar 2024 02:12:27 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mm12-20020a1709030a0c00b001dc96d1a662sm10134092plb.197.2024.03.05.02.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:12:26 -0800 (PST)
Date: Tue, 5 Mar 2024 02:12:26 -0800
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-fsdevel@vger.kernel.org, kernel@collabora.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <202403050211.86A44769@keescook>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <202403040943.9545EBE5@keescook>
 <20240305-attentat-robust-b0da8137b7df@brauner>
 <202403050134.784D787337@keescook>
 <20240305-kontakt-ticken-77fc8f02be1d@brauner>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-kontakt-ticken-77fc8f02be1d@brauner>

On Tue, Mar 05, 2024 at 10:58:25AM +0100, Christian Brauner wrote:
> Since the write handler for /proc/<pid>/mem does raise FOLL_FORCE
> unconditionally it likely would implicitly. But I'm not familiar enough
> with FOLL_FORCE to say for sure.

I should phrase the question better. :) Is the supervisor writing into
read-only regions of the child process?

-- 
Kees Cook

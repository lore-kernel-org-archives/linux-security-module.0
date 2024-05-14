Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CDD182C85
	for <linux-security-module@vger.kernel.org>; Tue, 14 May 2024 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727138; cv=none; b=auudo508lr0ZUw7TGg0T04WmxL1OiIaQoYMavP8aSX3Uo1xX54LrMVXQLcG38RyrLYYDV2NB0h4P0vCdoQvCVdL28KP0RzWi1/Mxvqmrfe3TCCeZvdmgix+bifa8PK7NheMCTZZTGzyfXAxCpZgXDuYpWkkI5Q55H0X3AmVFECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727138; c=relaxed/simple;
	bh=0qQ/sc8ONfKMIFEbDmEeKbk7hGENEC1CjPvuVVbodHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDVL+KEhkZDK8QYPbwQzqP1faqReSO6nlfe/jV3lcU+QH6y60zR3LBNLNSq36Z/ljARnL24asx+DT/s/fYRIJsd2hZoMPJr81Ild5Pw4TGEe2mX1WOWsw8fDnIIwa04yyuRmWC5t63smsPV6NxNq2JW09/nBIl+r51LH5DSEfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cehaMXCZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cehaMXCZ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f082d92864so13832515ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 14 May 2024 15:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715727137; x=1716331937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doHLoOzkV1dAkjUvPPZHC9iFmwa5zDfo9zpyMOeSinc=;
        b=cehaMXCZsoHjkoCKuFRGlwA8Pol2JIcmEEQ5QYIN5sX133TQ7eYmIa4kxehoHZniWG
         /2F7Vdo77mOz666RMRHPSyfwGmyC/mb2qdoGmyo7R7+xdHnANd1Ke8h3h+JOwvZtlyBm
         N7lOz+uxMjMaMTOIQ6e72M5J9Eor8nCs2ec/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715727137; x=1716331937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doHLoOzkV1dAkjUvPPZHC9iFmwa5zDfo9zpyMOeSinc=;
        b=fVKyEiVPNo3DFB7bRu/HL65pnhEVNt/pX2f0fqmwEr8V/YEOgfR6I4Z0HqIJ0sANEs
         jbRM4lQv/kxWfrUYKFHmz4XVI+Whi7BHjV+9Ag+vRJAygn59dgMseEVW763YcjJZWRb+
         l4oOKK1Zce5tAtevEC7EZ8qi69JmvCQNN5QOtBo00H5JEX0m6jTQI8Avd4Z5xtohZXZ5
         VMDkcEXZTBnpnaV8c/47tcg//Z6eCwQ7uy+EikIj+Zv0zDIuabnH/bnpAmudQ/Csiun3
         DHlYj06Sa1ie/tJRyFnlaIfD6REvncQmAyfGvrk5AS7+YoYfjkXP8/ijWAKOuvtsQiZw
         IMCw==
X-Forwarded-Encrypted: i=1; AJvYcCWh+tHULsooTC6esZcJNtiK7ekog5mAWyJdyUIDvTqqiz5Fret1vdGUTN4zINYGiNOQFKs4WOiYXLYTZvGKpOKZN5TBgfZgyfgKp9P/0Qfa4G+J47LC
X-Gm-Message-State: AOJu0Yw0iEZFFwb5LXR3mAXX9zyZNGiaSpKPtmCix/bl0rtO44fEsALr
	n6DCdgS38eG1ObPnPsZkWj97bKmMs8LZQ9Bnb4oJSzvVXaccHso/IZYFARpW/A==
X-Google-Smtp-Source: AGHT+IHWpFc8GRFfiX7fNqiCpm4+31CydC2UjP1SeqwBmoKCvpRAbRtb3mlF4Yocsg9frEgmjAbqMA==
X-Received: by 2002:a17:902:8f94:b0:1e3:c610:597d with SMTP id d9443c01a7336-1ef44057ca0mr125104875ad.60.1715727136930;
        Tue, 14 May 2024 15:52:16 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad886csm103974935ad.70.2024.05.14.15.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 15:52:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Stephen Boyd <swboyd@chromium.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] loadpin: Prevent SECURITY_LOADPIN_ENFORCE=y without module decompression
Date: Tue, 14 May 2024 15:52:13 -0700
Message-Id: <171572713190.2793228.3146950773342970247.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514224839.2526112-1-swboyd@chromium.org>
References: <20240514224839.2526112-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 May 2024 15:48:38 -0700, Stephen Boyd wrote:
> If modules are built compressed, and LoadPin is enforcing by default, we
> must have in-kernel module decompression enabled (MODULE_DECOMPRESS).
> Modules will fail to load without decompression built into the kernel
> because they'll be blocked by LoadPin. Add a depends on clause to
> prevent this combination.
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] loadpin: Prevent SECURITY_LOADPIN_ENFORCE=y without module decompression
      https://git.kernel.org/kees/c/bc9316c14441

Take care,

-- 
Kees Cook


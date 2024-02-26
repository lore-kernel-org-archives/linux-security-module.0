Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F413540B
	for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974256; cv=none; b=knOnW7D5J0mbsAnouiFKGZQuQchMTD/oLagHD9LfSFFqWwoAw5swM4h88maWg6p+HOK5PHBn+qyMn05WC5drHvhJleHu1GO1Jii27w9L83mElg4qkGoQpl3A3fkNkH4g5HgiwVYfvUaUSd2pPrOTA7vfRibXtoSUcPXhprrDFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974256; c=relaxed/simple;
	bh=JIqIxUB3Ayzkf/mD0blka6O8DKfFWgrE9WEYSScIHy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBU199Gd8TSC25p/FzS27G0xfChg56Sec2NOzvt/u3Sg+nTgb3Ek0AgnqxthmV2vm1Bd2nk2dcsWZw+AQy/jMTvpj2oOQ6kngRyQZOB3XtlYDGGzRy4WCDOaOvNJ2CAH6CJ7kOU2XhA5c3rM3cc9KMxe+U/07IxTSLkclQj/E3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B3XZR+6t; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B3XZR+6t"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc0e5b223eso28578845ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 11:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708974253; x=1709579053; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rqEaslcv+csbSpF6YQBGR7kuM3sWH8YoMpbM5vrlm2I=;
        b=B3XZR+6tYaiLmvO0ormzojOJS7q2VNS3VFHyapT0mYeCoLK0DxsW42E/Fyoss/kqcp
         mLiKMAOlbl9wyTCPu5nS79QgEgum9zDXpFi3SNMTipdU+yE37Q/xZySU6Z2PWb7019Hi
         5m35Vb5iqfIONp2TiVTpVr5BtosabOcNFViMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708974253; x=1709579053;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqEaslcv+csbSpF6YQBGR7kuM3sWH8YoMpbM5vrlm2I=;
        b=MWAxzNQ0Lzn6Mt7KJkWqSMgr2SZKvAGt5J/6hkMQCj34rl0keGBTuI8VWz0GjzQslW
         F4Mfl+VtTuuwbijTw8hmQFO93Nz02FSRSvrf7LRkXCSYs38ynQ4jtnlNuLIeBkaZyQeW
         NZdmOk2qtqjrlxbq8rhEOT3wOpqv3tSVbCbPQmFNL12htN8LuJavwtfaDWoJttdBKnkg
         DL3oXsPYX9WEJcicq/8XSQ0mKeuYg3fsMho+96inKP5qpgRpdORCOh3q+wB9B2pLHHE+
         UuOHu0HUjBmyExBMbN0HB44T1sLG/nUM3z5mRA1yGMvyHqIwJ2TycUXa2wXDMglQIuWd
         sBCg==
X-Forwarded-Encrypted: i=1; AJvYcCUk98RQJBO1zHcjnbwjn4YqZVXSqSY3QkUrLa6KOGz1MsSOrGvl8pY+5JjsIjQO0nLR5XaiNW/zkl375rMkosbdYBMh6K2IPebI2tBTmGgx34MYaWmU
X-Gm-Message-State: AOJu0Yz+lFE57bO1Z0uCTV5I8qv+ahfy2VliHDH1+YqmQQcQRUsY8mkd
	SR9eJVY0eZui/TvCyG39EJxmYCTdsJF3+Hjf/KTJm/NSf3+Fm2rwu3ItjET8Kw==
X-Google-Smtp-Source: AGHT+IGFFetjjHPW/ivkyZlW9eIrIhfwZbvoWRltu7/bfVEDnv3KZmmFg2wZd+UfH3HTAx1gx80+dA==
X-Received: by 2002:a17:902:d2cc:b0:1d9:7095:7e3c with SMTP id n12-20020a170902d2cc00b001d970957e3cmr8949703plc.57.1708974253283;
        Mon, 26 Feb 2024 11:04:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902b28600b001d8aadaa7easm31822plr.96.2024.02.26.11.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:04:12 -0800 (PST)
Date: Mon, 26 Feb 2024 11:04:12 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	davem@davemloft.net,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>, edumazet@google.com,
	jakub@cloudflare.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/harness: Merge TEST_F_FORK() into TEST_F()
Message-ID: <202402261102.3BE03F08DF@keescook>
References: <20240223160259.22c61d1e@kernel.org>
 <20240226162335.3532920-1-mic@digikod.net>
 <20240226162335.3532920-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226162335.3532920-3-mic@digikod.net>

On Mon, Feb 26, 2024 at 05:23:35PM +0100, Mickaël Salaün wrote:
> Remplace Landlock-specific TEST_F_FORK() with an improved TEST_F() which
> brings four related changes:
> 
> Run TEST_F()'s tests in a grandchild process to make it possible to
> drop privileges and delegate teardown to the parent.
> 
> Compared to TEST_F_FORK(), simplify handling of the test grandchild
> process thanks to vfork(2), and makes it generic (e.g. no explicit
> conversion between exit code and _metadata).
> 
> Compared to TEST_F_FORK(), run teardown even when tests failed with an
> assert thanks to commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN
> for ASSERT failures").
> 
> Simplify the test harness code by removing the no_print and step fields
> which are not used.  I added this feature just after I made
> kselftest_harness.h more broadly available but this step counter
> remained even though it wasn't needed after all. See commit 369130b63178
> ("selftests: Enhance kselftest_harness.h to print which assert failed").

I'm personally fine dropping the step counter. (I do wonder if that
removal should be split from the grandchild launching.)

> Replace spaces with tabs in one line of __TEST_F_IMPL().
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Will Drewry <wad@chromium.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

One typo below, but otherwise seems good to me:

Reviewed-by: Kees Cook <keescook@chromium.org>


> [...]
>  			_metadata->setup_completed = true; \
> -			fixture_name##_##test_name(_metadata, &self, variant->data); \
> +			/* Use the same _metadata. */ \
> +			child = vfork(); \
> +			if (child == 0) { \
> +				fixture_name##_##test_name(_metadata, &self, variant->data); \
> +				_exit(0); \
> +			} \
> +			if (child < 0) { \
> +				ksft_print_msg("ERROR SPAWNING TEST GANDCHILD\n"); \

typo: GAND -> GRAND

-- 
Kees Cook

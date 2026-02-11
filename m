Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92D350A00
	for <linux-security-module@vger.kernel.org>; Wed, 11 Feb 2026 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798440; cv=none; b=TCD4qmnN4OSL4+y69MNuBbuxbv6G5T4eoDm0E6a4QaM8wieb64hzLCjjTnPQUqxnoga2Co5NCo6X9LgSPSVKMqJyc5LxNU2nQHJ9G9hDvpntCC/9C6OfJJZPmnLD9/D5BuCyZzWGhaom4dgxNrJ3BQri23ZSaa3C6TXxqG4LpDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798440; c=relaxed/simple;
	bh=wauK2dZHL/Swu0Aa78B2CWtSK0cPu04/2gZCSFMWTl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD5QSackcj31K6vD7XfOxgSSRN6maPmbupkVl/YGaY3awIIHXWggtPAlTwFMxQmR7Jxk0e0d1YnyHgZrma85IDKFn+iwM+WUO9gAzvqX0SIAiLtMtw0TV93x3BVLtYbJWzmLl4mTL2g7pPpmKTwROcndHgeEXTgARRR3AJf6V4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4/p2mOa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4/p2mOa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso56261245e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Feb 2026 00:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770798437; x=1771403237; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wauK2dZHL/Swu0Aa78B2CWtSK0cPu04/2gZCSFMWTl8=;
        b=d4/p2mOaS8LXWyP6DYymEjdAiQdkcF84551CY5hu+c7i4drttavdF2v78g78OdAcXG
         5W7Lh3ZDURXMwWpUIQQM2v0s6cRmJHpmOrAE2v9B4TyF3rItQ5aXKsu3eEP4pWDHZUiQ
         NaLG2SpDuEBNR6LKqoeO2bO8US0qj2snDeiHFa0ulC+JdcPwwXoh2/qxy3yyqGMe1TwM
         ykoQFNyGa0gqCSBgHIH1/gdyB4EEMlGZ1NR+snNDAm1iuUQe2p5bRYsKjKj9/68FHxzq
         vmSyn3mQ+jURLClcmbU5YvZsUeqZyjFLGyml4myQL2V2MsxoioxBEui6mZ4JW8vOlT64
         IbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770798437; x=1771403237;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wauK2dZHL/Swu0Aa78B2CWtSK0cPu04/2gZCSFMWTl8=;
        b=sk1AeCsxlveydWQ66NoQr/9devlYQNBqL+eJTPU6ITiypmmw7KKEVtqmjvF2cY94br
         w8h4k+fBbhMQrCPKr3rYz4dm/IBS2CYeojqybwjEd1bYnqt90/EOvY6KEFMtImsR79Tf
         CwPWUMYNOtMg9xUrPvPnTXj2JnejscqDR+RaOJYYzP8Dznpo0FaYztQsIHf6dVg93P17
         bkrgWuwizHLk1zLEfGh6qB8sPNPxNMhR0KHGGpX/YgJmWVO2I7lesyAi5Wr2a93E5UcG
         XiDw8r2VLtzTd//lbh/oVupqeVLcsS+0ykSjpm8ZO15EMuZqtLZqxUX6k/MkeZhYxjTx
         QXyA==
X-Forwarded-Encrypted: i=1; AJvYcCX6T89l9eSa8GVwgTtSWXT6y0LtjvgB0FPHM7Qnhf7nzz4MTPphkADvEPD7jOMF7718ClOWDw0PagvPKILuN5ln+LKofMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCiLLbqK8YHfj8kuI8/Gxn5CoQA1ZQ8KG2mnQwoHhUo5+rg4me
	vvjsJAGZLTwVrMXOi9WqreiL++uDMWPNlGaw8GVrLIuaghgyl0mFT2ug
X-Gm-Gg: AZuq6aJrm5gGAojzlXZDw5yvvA5bDrzEkNlrlK/8hbiHE/8i74rzBGKyBfrr6EP6ps0
	dQNNaeX4zbD6LbdENJteL4HZGePD04yPIZmHHkD1H9SSUN9/8TZWN8Lp8ff26Km2fRMHt0mcQPu
	ZsytQ8hhhDNmTD1YpKJ38r1avkzRDUSGcmq2tAnG01dcPuEsSxzvcq0xBeJfS0XC/jdcPAC/qPx
	6o8ck1U6rVwg2lRk5BhHvIhTShsZVVTerL2hDy2PZudg/KwXSHqj/u5BshL8bmUG+S1c6K0yBwJ
	i7Q8iWCknSIixooD5WRFzYKdNwrCSmz2aauAjK7UoZbMrzDJQdgYiJziUd8aL60qUw1q2WMUTby
	mRbHUJBQK1w2KPesS4t9LQR3o464yWInNnLP33l8Qeg3km+o2+gShAi4GFgUnEX0SIA+0tJo8Id
	T7wPqi366wMHb1I/xLLG3nnxC0YRnfsRNVAPd34p9enVg5hzS8Po0hFlrIWL8=
X-Received: by 2002:a05:600c:3f16:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-4835ebecc4cmr10013935e9.3.1770798436993;
        Wed, 11 Feb 2026 00:27:16 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835ba69160sm12599365e9.8.2026.02.11.00.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 00:27:16 -0800 (PST)
Date: Wed, 11 Feb 2026 09:27:04 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: mic@digikod.net, gnoack@google.com, shuah@kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: Remove duplicate include of stdio.h
Message-ID: <20260211.71676f77cada@gnoack.org>
References: <20260211062122.2975127-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260211062122.2975127-1-nichen@iscas.ac.cn>

On Wed, Feb 11, 2026 at 02:21:22PM +0800, Chen Ni wrote:
> Remove duplicate inclusion of stdio.h in fs_bench.c to clean up
> redundant code.

Thanks, well spotted!

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

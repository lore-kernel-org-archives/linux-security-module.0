Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CFC21BAF9
	for <linux-security-module@vger.kernel.org>; Fri,  4 Oct 2024 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065180; cv=none; b=d0CK1vptuYLwe1asPyN7KaC010mVpVu+00eM7ocoXKf6whZZibAkRKZ/KdatOodImamh/5ltSi7VGAbOQhHURz/zXZ37jpmhYSCobg8fkqofRX9epnzaNfbyHPkv1xTjBRsXaSJLrDNQO5bMnJVm2oAIlSyNc5tEeiHBB2YaPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065180; c=relaxed/simple;
	bh=hRdZaT5GinwnU8qjZomu298iKt33CUjQLjpFL6FC3Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCakv3tVBKmBaeTCzFkDeItzC9QH2wXd8qAQlA3gg6m61RehrTGds4ksVF6TpTqZOPCGgTYR+4L6pnL8E9ezb9hdzQDtjPCMuEm2E2XjViKQiYvKZWlNRVxz4ePOxqXeXTZnKsbn2BBDAJNBw/6k5XBIwslFkeyN8a0Gx2OqN1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU1Qllp9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU1Qllp9"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso15166785e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 04 Oct 2024 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728065177; x=1728669977; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gzwHMKR/E/uJ27BpGectV3Z/wuJHgFUfq0zSouTA1+8=;
        b=DU1Qllp9ioMf3y0hiXX6sUAOb3jukjuDxFz35MpRKvHH9AcaJyN07IUIzKsvurGRiC
         hJbbtrD5Jht91u2Bp0ymnV36AuooaBc/2hM3vIE8/fXkHiBDlzgqJnCdBMNedZFj1ki5
         LcZJIv+544U5bx0zHpqXEwhblLWa/Jod4uO0vx9pUAqTRiM0FndpFkufPQQYDZ+LcKQT
         eg/hE4E8N4iSgYrl/yMra/UyaWaEUrI++xs0cvtvujgfHzWTYQzv5Kx/HvycuEcH0vNo
         F9zLxvtChYKgQcnxTZLImrvelcuqYegfqS+InnzNJWTkJ1ODpjpFIIJVMhziA9yAsABq
         DLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728065177; x=1728669977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzwHMKR/E/uJ27BpGectV3Z/wuJHgFUfq0zSouTA1+8=;
        b=XU0cY6g7OycP1EUv6jQBAhZFUigx2EmvDOixXSlR56oUR1l8TN+4mMUhrijrNWgV66
         IKgtSiYE5xoQ24rD2FPIbUyaa5WqINIHLHx8+zslhnCevvUVgGUZY5gJ0TycY9oW9Dy6
         x2CaTzGo1t+kz63Zre2ccls5eZOLYmx0nnhWfKumhsZsVjsZ0fe6E7xZOhXON2V2abx0
         awYoFdlaFgfHb/Yf8YWtXH7rTPTZ4eS3BG8tLBLWgg/FI/klPvSkR2ywcjx4I/s2jpVv
         tx/rXsSg2K9gJj16BV5X32ifuFTif6b2sVcTyTS3HLe9Nak0rirVhyFoIv1uwqC4N4s9
         l+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHUBVtT4xfxFHz/Y+JRbd0SIFWzXmuhZW45nhnssIM5e+hqbWWy35ZXQU39S1FcXZfUXphiErwrMbEIbbmYniP0ERS7xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWTZvz6eRE+p0odyXLRF8BVmG/UUzG1bzQHCeuu0O5Wpnhky/h
	CxRVUa47k89Xh0KxJ4nU53UC6cg8/OK8GaEtlqIXU3WNV8+xPivqax4+wA==
X-Google-Smtp-Source: AGHT+IEwvjpUWUnSVkYbTIRBq1bs8Kl/gZpummeBEZ5eKKbxG0xcKogSyaeuK0v7wdfFYzI2wweYDA==
X-Received: by 2002:a05:600c:4f02:b0:42c:b332:1619 with SMTP id 5b1f17b1804b1-42f7df113e9mr46809885e9.2.1728065176543;
        Fri, 04 Oct 2024 11:06:16 -0700 (PDT)
Received: from localhost ([2a02:168:59f0:1:b0ab:dd5e:5c82:86b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1696f921sm157497f8f.91.2024.10.04.11.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 11:06:16 -0700 (PDT)
Date: Fri, 4 Oct 2024 20:05:55 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v1] landlock: Improve documentation of previous
 limitations
Message-ID: <20241004.9475ed3e46a5@gnoack.org>
References: <20241004153122.501775-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004153122.501775-1-mic@digikod.net>

On Fri, Oct 04, 2024 at 05:31:20PM +0200, Mickaël Salaün wrote:
> Improve consistency of previous limitations' subsection titles, and
> expand a bit the IOCTL section.
> 
> This changes some HTML anchors and may break some external links though.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Tahera Fahimi <fahimitahera@gmail.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Thanks, good improvements!

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

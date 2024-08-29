Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC25189F41
	for <linux-security-module@vger.kernel.org>; Thu, 29 Aug 2024 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944335; cv=none; b=NeQPQCg3x6AFgdvaa5vtz48zn5HCjYmaPNBwg3WWNbqE70m5SdS6rG/1pXfWo0R85eSUp/SxONQcxukgYY0guW2dv7n4N015oO6geznuHZ7rKF1QR10rAb/Zc3Agji8TLYhIiYaUlx7R2v2Xju6dFPhaVmHCr0WKwFC1oXGEY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944335; c=relaxed/simple;
	bh=/Yp+bwk44R3Zd4P6GSVxI+KdePMTZmk/iFeGqi7nHY8=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=P8vkf75Rb/lRxrCoDif9qhrOnR7kRRHKXjWg72PoCZ3z6zOMbR3ftQotXWVN5TJO8uiXpNgoOzTdkBR/aFxNT8H2Pos/z+fHDEugyX94EitJZoGPjJ3qB0VZ9QvLnFkRtPEmBxrSEdd8x2+xxLZPUOK/y2lR9OIRP/e4X/laIag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GuqUtLH7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GuqUtLH7"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45654a915c3so4212901cf.1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Aug 2024 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724944333; x=1725549133; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cbvpryYGeiuR6tYhqF1TKuD/yK44f6YMqpze+p/SGoE=;
        b=GuqUtLH7nwY8yG/8f3mVov6tldNu2IxVheu+LA2yQIRJC7gunR863QrrNefoddL/3c
         gziXgwsUH9Q6O9KUgkhauwJTlcETQ8ouX0q34Olm5N4YKBOWzaHbifs/C2N78AnlI/aq
         nuH9t9rOT3DbfIieuksyC74qPQVgEqrp0UmcfVZ7AtY4b5kEwDX3bcILWdoGvLnnt+M1
         K1dOjAowdNI4N8WCdM3N0mZeGpSQ6j6XIgpkhtFhGhBp8p87FdxD/NV0ZG8HWv1GN6GG
         ZZ5d3DcyX6N8ksCo9VJeMupn6bLWLcBQ+gGrPLpRk/pquUi8YCJxIkxpbN344xdwCUON
         huzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944333; x=1725549133;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbvpryYGeiuR6tYhqF1TKuD/yK44f6YMqpze+p/SGoE=;
        b=O6GwxumJ1Y1Tl52MoMyHallr79Tz2hcwfLpyVZTpqIpA734D87xa9pCIHI9SnfzeXi
         c7pB7iXBSDQOMvFFJ7FgA+Pvcyx6gD/3OJ961docriKh/gmg8rhP5feEovQUCh4ypLtx
         F8QCYMNpg4wQriKhmD68xn0QuPbxpZUfJa4/315fjH+soJnEpJ86k2ia71FAyvjbXFiy
         cGTkVuu9aZVYWQD0FYz4nPxhx6azYmZsXkI5Y0Oiv9efBKQPaqzggWuZu9HIrlak8IQ9
         yK9lOSIuDHLR0thEoeN8QTo3UEBsv+5hOvm2xbbnZ7cktszUoewlEiEPnP3FIFokOiP/
         vnqw==
X-Gm-Message-State: AOJu0Yydaq8dOoF2vRyeY86dDqFq78B0eJdbLvkLuzQU5oKKwxrIMynZ
	vvIehRHKePbBMWHCgYolT5SOqvnIWjE1y4yPxDckUGq2Aw45pCsddyWcw3oHcw==
X-Google-Smtp-Source: AGHT+IEFjLGATfyJ0GhsYZoW469t+2OHMx+ZcSN+6Xc4Bb3aj9Zae6odMfcLhU5M5YEVkzI6A3q70A==
X-Received: by 2002:a05:622a:4a8c:b0:453:6cb2:c8c6 with SMTP id d75a77b69052e-4567f6e8b2fmr39316511cf.47.1724944332864;
        Thu, 29 Aug 2024 08:12:12 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682d66c9dsm5565071cf.76.2024.08.29.08.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:12:12 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:12:12 -0400
Message-ID: <33a963ec7be7aeab15397e2f2c4a1d05@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Hongbo Li <lihongbo22@huawei.com>, <jmorris@namei.org>, <serge@hallyn.com>
Cc: <linux-security-module@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: Re: [PATCH] lsm: Use IS_ERR_OR_NULL() helper function
References: <20240828122450.3697314-1-lihongbo22@huawei.com>
In-Reply-To: <20240828122450.3697314-1-lihongbo22@huawei.com>

On Aug 28, 2024 Hongbo Li <lihongbo22@huawei.com> wrote:
> 
> Use the IS_ERR_OR_NULL() helper instead of open-coding a
> NULL and an error pointer checks to simplify the code and
> improve readability.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  security/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/dev, thanks.

--
paul-moore.com

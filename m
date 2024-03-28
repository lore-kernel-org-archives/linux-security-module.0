Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995F713CC63
	for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663605; cv=none; b=n9LVwF3h9oZUPh94Alw4QKmK7nKMvmRD6t7Bmhvwv04q+S1Oqr0ImvRX0d+tebn+aed47WGt6H4wA5B2k/A6m0zg6naAV6g/glxtvEnPDLEYb5O2vCXbyI/38Wy+OfsbXpOLqyaRgUO8ubXfEfJH4sFcz6kmqEV5LBU4UBAv5Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663605; c=relaxed/simple;
	bh=uoxE7PhxoFrPFSaL6qMa4cEt83/6H2mJrsOoFabR0CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3HLc1/xMfOD099iP2p0DWO2+8OLHOkVKyMxXRJSQtYIeAMdP7nU/zw+Uro7+6ep0tfE+TBTrLI31EYumIjC2ZuFbWVs8DMmENViNF0GoXU2O+tzeJ/7qcguRB4RT4UzlsJ/ADgTXJnxB8zfLBZDtci/plNPDrXESxyWYW46jTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HVKRRefZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HVKRRefZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0edd0340fso13722325ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711663604; x=1712268404; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6KiZxiesCbvSLPbFTMf3kTBinr8ev0hUdvWiChdToEs=;
        b=HVKRRefZfPSOBroy3yc3vb0+K/40eX4J+0P91V5SZjVq12/7siepkeFYrUDZnmfdOq
         sWJ1zAuKZyQG4LgXnvBU26IUpY9QpxFwgA/8Gv6bSPJrdscHJFzWbHpGJWaiCK/BFbtt
         FgmZFOC418H2xuhq87Qm5YdC2VTR+BxaFEzjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663604; x=1712268404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KiZxiesCbvSLPbFTMf3kTBinr8ev0hUdvWiChdToEs=;
        b=neUNj4/9hsZ4PQNhiAz8nocalkroA2icGlPHrnDKXTlWpd7RM0U5fp82NFh/8jh8/6
         1i57DzRW6UpUr0lKKWK6Uwtoq1p6Ju4XfDjvNUwZNBUgQSeEYJe8/1Ewbeuh+cw+aF4+
         14zHN4FYZLvm4V+hxIT5skEc/pG/iIY3BdqJLArfsh0O5iQW24NhsUWQaBywcMWE8yOz
         TVa1GIK6DHYOFJSEJvXbnGfxVGVHZt0op3yM+eht5ucC/v+zaYXGkEQ49fLLgjxpZrIw
         Ie1QpnIJmNbUb158yivOQRFQgyaAYN3LvEOaeg0WzOdFnq+7bBgD4MxFLe6shI/d/8sz
         rW8w==
X-Gm-Message-State: AOJu0YwWLYX0baUJoamAz6iK7pQGDUG1K7EZWv+dhFxSHd04V1C64QwK
	iOA14WFUSOsreW10gN+qvWkjyWtnrbdGNC9pRxM92R3eCR3JsVViye2T2coXhg==
X-Google-Smtp-Source: AGHT+IF0ahQIhXtH0Mm5HvMCxO2IHtnyeHGy61YZR+rY3O0P7+1ImCbuQoPl7zqjcO0b7rQIv2AfXQ==
X-Received: by 2002:a17:903:24c:b0:1e2:573:eef7 with SMTP id j12-20020a170903024c00b001e20573eef7mr1030952plh.0.1711663603977;
        Thu, 28 Mar 2024 15:06:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a170903230900b001e14807c7dfsm2142788plh.86.2024.03.28.15.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:06:43 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:06:43 -0700
From: Kees Cook <keescook@chromium.org>
To: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] yama: document function parameter
Message-ID: <202403281506.46D9C5BEEA@keescook>
References: <20240315125418.273104-1-cgzones@googlemail.com>
 <20240315125418.273104-2-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315125418.273104-2-cgzones@googlemail.com>

On Fri, Mar 15, 2024 at 01:54:10PM +0100, Christian Göttsche wrote:
> Document the unused function parameter of yama_relation_cleanup() to
> please kernel doc warnings.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

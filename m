Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25D13E6DD
	for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663614; cv=none; b=ADVSvWeEw9H+oyVttF78mpNg7OfDOI6nKvYwbnCQodp1oSl7Ana+jTVdR4MJO71NfLNvFPsWeiW3CtTFFBKC7NGcq4t8aTJMK3bc/roS/k6Y8yVCEqtr0Gf7MDJNjxt6/51WvpEaVOdY9wBRIH5skorHUoL0qy20QYeVEwNchH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663614; c=relaxed/simple;
	bh=5AJMO6myigFkuoAXfMA9V6C/wHc4aj530blLJIkgPVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKO+wsSEn6G2JgUwvFVozb3BndtDnLSto7qFSdcTKaFWE7sVc1R0/FpmGADHg/tUd+N1Msf8YqmXtVBio+p/ZfttXy9fIROicQFyzxICBNOZLhvMze83H/9n5ptqECjx8EC6C/LL0qggBtzVVi+cUPzpNryJG6uevVCDlTMdhNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SnG/rCdZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SnG/rCdZ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6b729669bso1305568b3a.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711663612; x=1712268412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FawcQ0+/Re5CGM1VyfGak6NYsr/nN1VT9V2EvlsawhQ=;
        b=SnG/rCdZPSYTqZXyx7kblvvq01NvD8lYu7FQ4biSzbMUZVoZwxV/4dbs0dbEHlxf0r
         AmC3eDqWf+L4ZjF0wRj3RmCxciZGBB9n++5TpUtz7NjT3TqWa7FK5QejboAeu6R4I8+o
         A7sEc8xRGVH8CIgdv25hACaKysz3iLmKQs8oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663612; x=1712268412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FawcQ0+/Re5CGM1VyfGak6NYsr/nN1VT9V2EvlsawhQ=;
        b=vpDGLtPll7/dJxLFVNVdv3MQ9k/fdDSVWJtGuqep5UAMhJinewwDvXYuaW4uQsc2J4
         u1ofbrp1iNOZ2lZJSvZOMcO6Y2luqIti5pUlHq49ItSaZEsXOOrQ08TSdz9oyAVPco1K
         BE1/wjzCfHiF3fVCLuxw7uOJcLo3ePN5n5o3y3HNJ3/YUGAPM6PF+o1VsiH8BwZo5zz7
         NUEE7D0NSGRIe5pHa4C0q3RGo6L41+vaA63uJVUV/K0gxA0m01KBJ+Z47p1onsikvV4n
         arWWNKmhG2UrouHqzY5VHLxqRAyxcqUldBL05rtu+vqKU4/Xnd/mKxjMRg0+htrJTN02
         aByA==
X-Gm-Message-State: AOJu0YxqlhXbp0KEDWzWzXDRCnXqs7qLVn8eAN0Jv7chx2/tuyqSWqXS
	UBeunTBzwhmqj516WXpp2GbbiJqEGmAsCa66RBSePRvCdNtLQUDExTI8A5gX3A==
X-Google-Smtp-Source: AGHT+IG28FKoAE9GwUDPDbAhJpDSQvO83TTQaELwCTDF264wtxqHJW3X538E+oFBl7uIp2mx5xeCig==
X-Received: by 2002:a05:6a00:2d11:b0:6ea:749c:7849 with SMTP id fa17-20020a056a002d1100b006ea749c7849mr707745pfb.13.1711663612175;
        Thu, 28 Mar 2024 15:06:52 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78755000000b006e71aec34a8sm1870864pfo.167.2024.03.28.15.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:06:51 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:06:51 -0700
From: Kees Cook <keescook@chromium.org>
To: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] apparmor: fix typo in kernel doc
Message-ID: <202403281506.6E7F782@keescook>
References: <20240315125418.273104-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315125418.273104-1-cgzones@googlemail.com>

On Fri, Mar 15, 2024 at 01:54:09PM +0100, Christian Göttsche wrote:
> Fix the typo in the function documentation to please kernel doc
> warnings.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

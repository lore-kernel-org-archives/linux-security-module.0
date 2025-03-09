Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773981537A7;
	Sun,  9 Mar 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741518768; cv=none; b=dw8vVuLw0RdgggPwc65vBA4Oq76Fei2OnUbVKXuWyxM2bXEpxIhJQbWYAmBhlFQnFSdlVLWS62Eiispp63hIXO/biNgqCp/08hS+KEbNuKnu2cVQjYMMXmmB90bQSJE+UeKoUILuTmXxolpurlYCBr+0tciyrCAFF7RhyZxNOnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741518768; c=relaxed/simple;
	bh=R1/ra110SempN8LYaPUNnLAkhoOs41pIzMor/3d07BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpzagQZ4q1fl8g6QL/Y5wI7Tx2zeyylH0HMvB4/O5rFIBGOF/RuRAjkaZpMhRJELKR1bZkuR01b7LFb1KUOeLVH6gDX3JDHg2TA3quBfYo+3yATvJil8DWCn9huow4xG6cBjKwn2FxiCwfQT2O9Z3RqwlKDY5m3y/VXa8893sTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4+RH5HL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4+RH5HL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so746035e9.1;
        Sun, 09 Mar 2025 04:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741518765; x=1742123565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pLoLQv1oy3J8TFf2ZoD9HQxdL8JjlROz1Fj/a+R3JZU=;
        b=Y4+RH5HL1EMOsWbU7+Fnnn0jpgZNU87rNUbvI5XKl2mFha6Pgkf/CDTJMF8S8eR2wX
         6Bb8WpvNNQJxC2jH5TwSD//7OH+PndPocL4tyVTR29KavvHye0UHMTD8N+Vpjy1pqO7D
         s3//uNkr1CPcRshuzUp0ZJ3+U094lcoH5Io51hXr3Ej7SgEHrGpHT9LjE5NA5Ip2nOiT
         L3gBJmrVE1ZIeNuZIICkk94ORql7634Wv47PXrRX2u9Sj/7nlSdQBewq4xJC3cV9a46I
         tP4JmfaoqoAFNAgFuNL1Uy9iCq4rfBLabQv56rJcvsKy3PZmqFbcNUGxi06IO653U13j
         pzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741518765; x=1742123565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLoLQv1oy3J8TFf2ZoD9HQxdL8JjlROz1Fj/a+R3JZU=;
        b=CG5jAJi6kO4QP/iUMteSIeu880khnRoCdy7wyz/o8p4tt5QfWRBACsT57KThMOUtMm
         Nhgg/tOZbkmRZzBsqf2OJjXkQKkBSAV5D1H+57vB6uPjsMzlxWPMrybYuUw32LmyjTLQ
         yCy+KKcm/zvm2UH54jwyTNOF+xORHGmkRGngqKFvCdVIi1m/ZdUJhU4QZn8sqrgBG27Q
         sYfxH93g67JnMTCuGLjlmzJRgMxBSkfGrY+f86Yi+qDEJq+r/js6QR647LzEkwZc8rrh
         MU4CurWVP/CRZltTzMFtPugzgIS+q6KT5Yrba0oejSGQft8UbUqAp4eJqORAtqQ5l9KX
         OvOw==
X-Forwarded-Encrypted: i=1; AJvYcCVv/ncGfgZCN7KJt0IieOCCgYe62QC9buRH97Df8jg/kxd0yBKKW8bFJZ7dFAdmCSDBrthe8ZNotYGZwh50g/GJYGxbBsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbHCVWrQReGiBF7GtI2Ah1Pd8c+OhPokxRSCgkdFCuLHyFCCmU
	POJpwF4ZUkZMG8z5IuhzjdhFwutY0s9fw6IZhRptnormdiAnuRhwMh6Muw==
X-Gm-Gg: ASbGncu0NFiCwmnWUEUc/H82z8SRRL64fgYtAMMKE61zPZSZKUN5Szc0YJ7TPDgokJA
	kWc9uWfRl4FkxjI9FL0FwDj72FpmesMZwe2dDFbQZTREfeU9ugT+vOFAlACQPKsqSQfw+rE5dOl
	w06BoFZNrEc9Z1izO7dq2W7VlZsGUSwoEt4VWW0xf4PHHjwQASK+ERm8TN+UwgOahnEChBJIcT4
	Q03FdsdmV4gjN+dxUACkklPOxznqPbXlRG+yEsUSubZxuxe6dCF8TGavVW156NgR/M8RONC5eed
	oZBlUW7lkh2G6fJFBbfabqvW7g04ud5L0PIqI24XMQ==
X-Google-Smtp-Source: AGHT+IG3/C8RXlmkY2CUPmeYDdxB6zY0IIjtYLFX1U9txnudgTJDegFVLenHDSK9U88TwDD2wtedcw==
X-Received: by 2002:a05:600c:354b:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-43ce4ab02eamr36510695e9.3.1741518764241;
        Sun, 09 Mar 2025 04:12:44 -0700 (PDT)
Received: from localhost ([2a02:168:59f0:1:b0ab:dd5e:5c82:86b0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43ceaac390bsm44649605e9.35.2025.03.09.04.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 04:12:43 -0700 (PDT)
Date: Sun, 9 Mar 2025 12:12:39 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] MAINTAINERS: add an explicit credentials entry
Message-ID: <20250309.5ddca2aac3f6@gnoack.org>
References: <20250304222304.214704-2-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304222304.214704-2-paul@paul-moore.com>

Hello Paul and Serge!

On Tue, Mar 04, 2025 at 05:23:05PM -0500, Paul Moore wrote:
> The lack of an explicit credential (kernel/cred.c) entry has caused
> confusion in the past among new, and not-so-new developers, about where
> to send credential patches for discussion and merging.  Those patches
> that are sent can often rot on the mailing lists for months as there
> is no clear maintainer tasked with reviewing and merging patches.
> 
> I'm volunteering for the cred maintainer role to try and reduce the
> confusion and help cred patches find their way up to Linus' tree.  As
> there generally aren't a lot of cred patches I'll start with simply
> folding them into the LSM tree, but if this changes I'll setup a
> dedicated cred tree.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..68e4656c15ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6139,6 +6139,14 @@ L:	linux-input@vger.kernel.org
>  S:	Maintained
>  F:	drivers/hid/hid-creative-sb0540.c
>  
> +CREDENTIALS
> +M:	Paul Moore <paul@paul-moore.com>
> +L:	linux-security-module@vger.kernel.org
> +S:	Supported
> +T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
> +F:	include/linux/cred.h
> +F:	kernel/cred.c

Maybe also add the documentation:

+F:	Documentation/security/credentials.rst

This documents the prepare_creds()/commit_creds()/abort_creds()
"transactional" API that tasks should use to change credentials.

> +
>  INTEL CRPS COMMON REDUNDANT PSU DRIVER
>  M:	Ninad Palsule <ninad@linux.ibm.com>
>  L:	linux-hwmon@vger.kernel.org
> -- 
> 2.48.1
> 

Acked-by: Günther Noack <gnoack3000@gmail.com>

Thank you both for stepping up to establish a clearer ownership for
credentials!  There is a need for authoritative decisions in that
area, and it has been difficult to find the right contacts for
credentials on earlier patches as well, such as:

https://lore.kernel.org/all/20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com/
(patch by Jann Horn: "get rid of cred_transfer")

https://lore.kernel.org/all/20250221184417.27954-2-gnoack3000@gmail.com/
(patch by me, multithreaded Landlock enablement)

Thanks,
–Günther

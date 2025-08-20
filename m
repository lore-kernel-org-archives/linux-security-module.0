Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3672D8762
	for <linux-security-module@vger.kernel.org>; Wed, 20 Aug 2025 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678538; cv=none; b=HJraOGGZntw4EbhAa4jjg9Gbs/y09IZL/3nBhBh8x20oaULR7UFPSabgPbhkYoVLshssyxHBU4bHod38e914bz8WP3yugBD2puI7svDwOkfHZLMUc7nBLLiet8ak/UIvTd5mpIOrUlh9Wh+f6GmPkAv/K8ePquvEWcbxW7LM67E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678538; c=relaxed/simple;
	bh=zF0KJzDGb4FVwJYN7hE92OHSrRFWAOyPof8nv4wkan0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mf29VERDEe7tPUIeTPZA27pmOOMzJegUyMTAifwPJXaNmrOQSDN8KOloBZikA//0Chkyt+KZs/th4L1QVF2DFE59O6oAnpqc7c8gOTYx9ydD+zUR+QhKY1jGcBCXDBM50zEo6Qsku3b6Rm7wZGWJ1SYsIDM0zNevYdI1mCFZMoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdUab7eR; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdUab7eR"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9e41475edso4379594f8f.2
        for <linux-security-module@vger.kernel.org>; Wed, 20 Aug 2025 01:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755678533; x=1756283333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xc1tKyYSTPJPxeU53+y1RcwFkYkWpuTBa3RAA51ynQg=;
        b=fdUab7eRZrBgOuepxSVALOxiDozd3rsCAUwlR6Tr8Oh3+cWlB2Qa6rjlOmxExNZnh0
         37iQay8ASNrTqd2X6Qg5TY8aBr55JA057jlWROUztQ+yuQ5wWBD1xUAOaTjy+UB/gaRs
         41RJg5vofWpOA5G+1jvmW74gLQ7p3YjbP9smNI7WpGlpJ/cjz42aU06wxndr0t/6dQKi
         DXGbJKz1uDPabg8eHmpf6m4+CR+ODIrc98ZFfkbqOL+r0wkEWEuqw6g5B+D4/HnyBFA5
         0vO3SDbY7DsTrBG5NTWoN87KhhjuKSAzEAxF+pQEQSzFq0yY7uwGZPfCWDrb/bSQUNmw
         nFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678533; x=1756283333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xc1tKyYSTPJPxeU53+y1RcwFkYkWpuTBa3RAA51ynQg=;
        b=L0Go38H+4SUlc1YRK2U2aBitFGPuAAQ3NWae5aGv2HEAJ+VW7vc+yAnMnoAPP4SVfL
         rL35gab063CfKnicYbKjkIUxIU7CLLK8AiTBMUcllupWsvg7djSdFyt22oBXdHU4aEeE
         kKCDG10t5M9Rre8SUA0RJzvdgf/jjrrKwE06JGefgk72/KciaLopTuROAFPK8FSd6UGi
         YHF9BXgB53KHqiWNv8lLSvZs6pcqk0l4pXStZk9ciA/+QLNjjTxxbKrOQm++WH7re4cv
         +xJiaElWiCZ/QRnWIsQR7ej8UCAKWUJlTbHJtpb7RRLF+AIiDByhqJiaZzM2aJUSMYrO
         +DNg==
X-Gm-Message-State: AOJu0YyxoWeIaaY9J6V/wDVT7JAOHgkjTtqwDO04I9lao1f8UfgJsCbd
	XpJZsAQHiQHRrzlhJWAfv3T4/ypamOGIe9uSYWj6kC+r8QOf+Jynm25DWAyS01tS65znVGjA9bz
	XYd4qIp20plH3KytYPQ==
X-Google-Smtp-Source: AGHT+IFAyzNnBS6IDJSFSMEJ/UC4rW4CUjOyxVXmLmSBHEX87SDM2/8LeBdUjyimto1XFzjeWwzfcrQ1TRzdQh4=
X-Received: from wrs12.prod.google.com ([2002:a05:6000:64c:b0:3b8:e341:aea3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f8b:0:b0:3b4:9721:2b13 with SMTP id ffacd0b85a97d-3c32ca06babmr1467563f8f.14.1755678533695;
 Wed, 20 Aug 2025 01:28:53 -0700 (PDT)
Date: Wed, 20 Aug 2025 08:28:52 +0000
In-Reply-To: <20250819195841.238246-2-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819195841.238246-2-paul@paul-moore.com>
Message-ID: <aKWHRADe-EmKumGJ@google.com>
Subject: Re: [PATCH] MAINTAINERS: add the associated Rust helper to the
 CREDENTIALS section
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 19, 2025 at 03:58:42PM -0400, Paul Moore wrote:
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---

Acked-by: Alice Ryhl <aliceryhl@google.com>

>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d61f7246e5bf..0ee0098f2df8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6484,6 +6484,7 @@ S:	Supported
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
>  F:	include/linux/cred.h
>  F:	kernel/cred.c
> +F:	rust/kernel/cred.rs
>  F:	Documentation/security/credentials.rst
>  
>  INTEL CRPS COMMON REDUNDANT PSU DRIVER
> -- 
> 2.50.1
> 

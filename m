Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440BB1AAE28
	for <linux-security-module@vger.kernel.org>; Fri,  5 Dec 2025 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764897632; cv=none; b=WX0b6Frv82ka0JzVt8TbvIGzDTL+PH5k7KQJSgaxRoL8d3lDIeQs1J7BzUpps7IIMaeB1e2CoQAIS58E5GO72ruNi+NvNBPzn5UudkI8nPIUfXRXibw99klC7UT3RDZeDSgsQQHSs2G/h6J5aF3RtIm3ChsvC0zzbcykZriR+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764897632; c=relaxed/simple;
	bh=jxRKL5iNa/Bl/jAuSX0CBvZ7/LtchJWuDyicXG4TiTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYfRlutJIeRKhQt2Oitu/SwUQ2PHleJqOTvsSmwDr4R/mInh2jeN8CnmumClDsz+JmTn5dm4iVBVs5WzQ1fzM9JkKlQ04P7ugdziHJs69Qu11UXPi3Q3VYFb+5bGCXx86jBvtsocmm36awhpRWKBMk9YQlLsravSMHy6Ofsoz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Eh7Re/M1; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Eh7Re/M1"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-641e942242cso1896358d50.1
        for <linux-security-module@vger.kernel.org>; Thu, 04 Dec 2025 17:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764897629; x=1765502429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkeIzlBlx1PkGvr8HsFk7SRPkXdn8mV1aMxoyk9bkQA=;
        b=Eh7Re/M1E6FnFuwEdJI+XQ0rHRFPLW/2ccOhJTYE+/FBJJzTVq0NtTzbd3/w6iDdfw
         ATq66Pye4Ifkb56IhE8G12phP4Qzi9QnumNya9MuShxMlkasAl1OERlyuAQhNSVQWvIb
         5D8l0ntIObb+v60eZSAoUwbHryNRe8/bbiYtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764897629; x=1765502429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qkeIzlBlx1PkGvr8HsFk7SRPkXdn8mV1aMxoyk9bkQA=;
        b=gENMER2DBl4yPkhNx6DoS3vTXpRFkImy7GC0qavD7qT9qHhGpZnOYk+pN41/h4RmWD
         2lNbIE5+Mkd0zcGU681gY+W96y3WcXAHezwurYL8njPpP8W8t60vd+IWXEhep6cjhSpw
         EGCG1ubHKyNmrww+VSG2ciDYj3xUAzCc/vYKq/SHjYOIn/m0tLjSizh1h178kO3hOvaS
         FgEe18rSE3botgkTujT6f3bcMnhrQRZsf8eoYvNcHUiyl2pptkvDPWFYAehKhNCCKre0
         xUWwUgS3r1zVt7Et0SurT+tR8aF/sgFcp5o/broxLLbIKgnicKsKSkLhd7S2WQO5Hs5y
         zW0Q==
X-Gm-Message-State: AOJu0Yzg4LZV9j0Fuke2XI2oAPZ2Eg3aQY1vgx/YxKKGMT501aRhGDt9
	ZuBe8J7L4gX3QZ6BW2XqLuoMKsENFj4Kuv3Y4rLBJeSSwObOpA4Ez/+TGRbMIvMY1D8JG+0Gpgd
	aU1G3FGQ/MySc3UAkPefzjUXU2WokVl4QwYFWdrxMWQ==
X-Gm-Gg: ASbGnctcgM8hPO8ghl6ETw3KT1KmOCPLDoqjaE8D263Ea996csCVdRLIrQg7vbY08sP
	Z6N+AnZW//yzVBNNxFoejt7ytXALm92lrdFQQu0W1ZeMha/nxUQejrriPmCrWt0leVRWcZLDe1h
	joFD748bplDT6hX34msREXrAXym1pC850W6J5I1QaKZ65H6qHFWmhgQNCzzHJhbVZC+wuUEMsv0
	hNZZ0thIwZ9F1zHvcAi8XZ6Jvb7qTimeJojU42hOvF+yGQ4NPjo+wDqQ4kqpFYBAzXK5u+Qap2W
	U9PL9iRUegRj0gijF6Wip8utjs4=
X-Google-Smtp-Source: AGHT+IFtXt/3CKXhoVB140Nxu18hWVM9jY21CjdtWaE2XCY6qJsgBiem5pKePjkDed9d7And52yFZMzuIkxdpIHO7zU=
X-Received: by 2002:a05:690e:dc1:b0:642:1d3:ade0 with SMTP id
 956f58d0204a3-64437065cb1mr6635486d50.62.1764897629161; Thu, 04 Dec 2025
 17:20:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aTIm6grHZUhRncFH@mail.hallyn.com>
In-Reply-To: <aTIm6grHZUhRncFH@mail.hallyn.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Dec 2025 17:20:18 -0800
X-Gm-Features: AWmQ_bmloJ2WAVddd3G12Kqs7knwLxVTo20FonJFN0YM85RV7bLQG1zxaOBr4PU
Message-ID: <CAADWXX_rO42NznU6c+rjqzaUuTLMp_DXSf_mn8rVDCe+1AMUTQ@mail.gmail.com>
Subject: Re: [GIT PULL] capabilities update for v6.19
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 4:27=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> w=
rote:
>
> This contains the capabilities changes for 6.19.

This email was in my spam folder.

The reason appears to be due to it being marked as "DMARC: FAIL".

I think it's simply because your mail domain doesn't have a dmarc
policy at all, and gmail has been getting more strict about having
both dkim and dmarc set up.

Anyway, I obviously found the email, but I thought I'd mention it,
because while I check my spam folder fairly religiously, it's still
mostly a pretty quick scan for possible emails. There's no guarantee I
always notice...

           Linus

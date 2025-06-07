Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F054C2F3E
	for <linux-security-module@vger.kernel.org>; Sat,  7 Jun 2025 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749262294; cv=none; b=GzLtYIAORpHGGfB8odJDRwjbMXHLtZehVon3NHX5NlO2nB5y1+BWCVk8clVHQzCnHsyv6UABxt6LXkCwcYHuuBoh3syd/W0MfE5IQVlCLhKllrOUCfwTdHCXyKZv/xlxSz6sb5HyCkPZPCO8aYkmuEaoQxpb0qs8Lts/J5Q9pHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749262294; c=relaxed/simple;
	bh=8JobdySAj7NyQOrZMHha5tjOwyaZDtWYrb6Ptu+QoWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcgbPaH15RqcZnT0rKjTGF0MjWCaCU9izPMTbN/4lfjuvSShdEsxMgsGAaH1u0GdekcZIxMZvr4Mm+nDPmBKtbnkHN8Jl06tbb/MeGfch+conp5Iiys2X7ckOeL977rOS5bhz2aN+rxGRNzB6AmbmnFNf1LLIFHx7rjNocfEptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ctzw15s3; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ctzw15s3"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e78e04e48so21906857b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 06 Jun 2025 19:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749262292; x=1749867092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae9qjvvLktKsuEKe3HrkRH66a+y38Zr/irTKMRVsz5U=;
        b=Ctzw15s3q1wFHa1y57JsyKGw/XlpjqhSRdqQ14QqocHXK5TTmmK8VB1bGZyfdQL506
         qn231RCgHEv/42frOy5pbGP0BIwbUEG0IT3UQjErihJtISHcu1X266cwnqnoPusP04oE
         S2G7mFSOmKtrXrIg+SL8jpcyPxC0HNyrX6MyjWbAjj5UIW6DjG0lemdXesTNu2Ha4A82
         66UDa6pjuEcXz2NPxjYrjQXLeO0Ucz83Q6wPK4xFs3ntAet5BXC4xpiP3RA1M5uWnwO0
         mW9nubElyc1qqXKRGPa7ln7/TW2C93QW8pT0J0We3kRb5zPVjgcWc9VGE8pPsCbX3XFx
         6e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749262292; x=1749867092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae9qjvvLktKsuEKe3HrkRH66a+y38Zr/irTKMRVsz5U=;
        b=nazEe4FGEj+CfEWZlu5emePSYSOTgShwYTlnkt4grdj/ISqHtHryoKa2W+btoGaCVt
         FsBPrOz4EulkkcfH/dhSeQZFElT68meCB8THo6lYR4ABNrwnDUMnKYNhSnwe/BHly/Wc
         /Gtb91vvw45Bbkq1nurSKl29aool4ihn87im1rg8VdkiwTK8VQW7j5Jfjhz7dtunMfbQ
         YCWyiQ51/XpE6lVlNtsZ8SWEnpj4IlfKmGsDJLgKA+u5gqouOLW7Uge50CALIiEhLt4F
         ft7UfyS3ol6DbSFv+MbKRTKmmw42BAZjPuRfVredzcAuieqZr3tf6W5cVfbUTnizv8ih
         hAgw==
X-Gm-Message-State: AOJu0YwOsD3atlJfQ1XYnhWXxOjwUAariMSedQcH+o59AwRR9Tx6I6Vu
	BnLeovV0VIZOHLP8e8iHH2fRMC++12CpOzK9LWyjR0M0SSvE0omAp+wkyEYbMeT0UUT4bXdZ6tO
	1fVCMtIgk4y3Esgu5GAZxfMZG7ktNtcFRBYxhvYS7G8HWumKtQLA=
X-Gm-Gg: ASbGncvzWXQb996xgX1HF0ZnzfVxRWPdKJJkWGbEENd39xOUCNp5RzHsHo7kRaS1Dz8
	Sw2mEygoE+sKMr3bWisinF67++cHZBur/NJgIoVjfpAQZifb9HVSBT0ipEkGTZG3KLlJCARlxBW
	AX1Le5zZTSekhohTqkFyf2h86j0gel9NQXio19Cl/E7IbQofSOgmmU1Q==
X-Google-Smtp-Source: AGHT+IGsyY27uZ5/de9/D6FZoyXIrQb1N4wyx+aBXtXPTFLrj1NivqVs1lHYXJkNs1j54tWfwH0pOf10ih2LhkD1HB8=
X-Received: by 2002:a05:690c:6d0b:b0:70d:ed5d:b4d2 with SMTP id
 00721157ae682-710f76949femr88623127b3.16.1749262291905; Fri, 06 Jun 2025
 19:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA25o9TqH3LNWy8F2tXO7P6AdQk0x+boWiPhy+CKL=wDouKODw@mail.gmail.com>
In-Reply-To: <CAA25o9TqH3LNWy8F2tXO7P6AdQk0x+boWiPhy+CKL=wDouKODw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Jun 2025 22:11:21 -0400
X-Gm-Features: AX0GCFsRn3wViYMT3jpH1x_9F41xbaD03H3XnTaLpxqbEI8YmSyu1utJ_4PO-ZE
Message-ID: <CAHC9VhT-UKWRbmsuJfkWO6BK_Mon4KUMB8DU5py1gDBJgYwJDw@mail.gmail.com>
Subject: Re: adding CAP_RESERVED_# bits
To: Luigi Semenzato <semenzato@google.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 1:58=E2=80=AFPM Luigi Semenzato <semenzato@google.co=
m> wrote:
>
> Recently I inquired about the decision process for adding a CAP_DRM
> bit to capability.h (to become DRM master).  It occurred to me that
> the process for adding ANY bit would be fraught with controversies (to
> say the least).
>
> So I looked into maintaining a patch in our own kernel sources, but
> that was surprisingly messy due to the build-time dependencies of
> capability.h and the way we maintain and share sources internally for
> multiple kernel versions.  This would have been quite simple if there
> were a few reserved bits, such as CAP_RESERVED_0, ..,
> CAP_RESERVED_<N-1> with, say, N=3D3.
>
> Would this also be controversial?

Yes, and likely rejected too.  The upstream Linux kernel generally
doesn't make any sacrifices to support out-of-tree kernel code, and
giving up precious capability bitmap space would definitely be
considered a sacrifice.

--=20
paul-moore.com

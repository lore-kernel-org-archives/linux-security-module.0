Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C03CF1FD
	for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2026 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950464; cv=pass; b=i8DQCR6dWDxiT3Dc1shNeZlYk4Pjd5c1MYR9R65UvvUEgZWRuMxFKS6bIIgBpTi8g8XZK06sjwcB8prKUKOA9I6C+08U7VMDDe0BCVhxzQifED/NS6oAKTGsMHt2iX9+8pCA1R67MWrSCjnR7FT5XYawKYE+6KaMdMYgiagiblA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950464; c=relaxed/simple;
	bh=f+1hgjoLe+9OAau5GDXmSyjb/F1lcu3rz3NObPtffwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T32vmRCrDLJV6WaRHZwdc5gEuUlsp1GWuwo0WMWgdP/FT+sZXd/2e1Zk82aMxv8W7fpXeMzoyoKjYAEwa79kYANlthfkTFmvG3lDptpF8QJGw+ae64Tt/dyPaBbahi4g8Xq4VnlG+4DaUDAp2uhYuOGr9sGlemjsvxPTyjefPso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT1xHc2x; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT1xHc2x"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc8311c6ddso1672295ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2026 10:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785950460; cv=none;
        d=google.com; s=arc-20260327;
        b=kO2Bi6/xEnQZ3g4N6ThOtU6vSdriajMC4q4Gr/SR+6uPR61lQJKcdkI5rvDBCz2a2p
         86/CuEtF8HK5p8AbV2q/H+vv+xvXRvaV7tq3y4dz8D62wti1T0BcANSsg9n3ma7zSQaw
         6yLKMkkAbuZFOH40yQUU5aS56MYewQkCD2juJgV3RbQn6ZSttIynJMeJdjl4DIj6Z4t+
         4yxCTUuji84YFxBtfenXdDj8XTFvEowO4qG+uhzvF9jINXwx45mEIg1+fi/A8LOsbYam
         6l2AIZsEPlSUcH+pG3xVp1HZmtDV76kZ56Bexgr+ckpenBeyY9y+Xqd6RttLamZPI+Xf
         A+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        fh=URaDGCUCyQXjRsopEJw9hWZQ36hswg/a++4e0ZrM5QQ=;
        b=Cfm7gXm2SjFBwDYjHt96MUIb78OXWiIDR0Ws3iQAPt3gHL/rDLoF1Eywd40bWZErh+
         pYCKLJZ/OtixZmi+UTHyOmZeFR9RcB3le9bkA4BKuMZ1qlBpKFLAD+yViW/2TYZZ5wEq
         hgIwcAsToJ/V+POaRpQeX+NBx0dUlL2+fKNFjNzuX090POHbJKorI7mvLBFeeTzHcV85
         K6eGJAWtjSWbkguc7c/YYIZS7sEvNhNLwVKicrUJNbtPGoZJF02rDLl02nYRf0iTo45m
         KXfDdz+dTPDR5HIvI1l42QDpXxdiNMK0wB0gg45TQD3cG40KThmWAqPm34OcT94sAeVp
         hMhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785950460; x=1786555260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        b=ZT1xHc2xyP9XYk8PUPnDAntsicElF5elLjXJHYxK/dTIRxhOXP4BYmKyaAm7D4myJe
         FXySCyN7nRIDJjvQu9UXCW9eDvMXBTKWNXVzmoLwbtoeTkM+2avemvUwcCdFVmdxcM5y
         HMcojfHT74MtjHUYX3FGuPiSQu6CG9RcMZN10Jij5DCneHFtm2g+5oKnouFZiqpXEehp
         s6g/qW8DnpBdkqN4RMvOha0mJmzKRXFYxdpGFxxrgKrHq8SOqH3+XjNo42K8aYfHQQpY
         ieaRXp6TarxQO7iZdwat5LWdNaE6ED/8Ui2j8nc1nYOEyzIfdGs6la8xuL4tQi7opQXq
         gWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785950460; x=1786555260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        b=qekLgU828MWsPNakBbgPGXuz0tVpaaApUCzCWnOokwQJPen4vJdvVTrJ072s6GbrNE
         HqnUWdpgkPrDbq1N4Yh4onpnAURLcoaal7WFgmGXKB4Ho3Dq2VuPXs04ak2HPqD7UgqN
         E+Qrzffi6BrrpKQQ3TE/cif2xQ7BHHrxL9pqjrUF3ThEYVVS6cn8E+av4c5cfHH9SIeZ
         5gy8Vvn6UjI74KpVZsRHhapKryTYeqHnzu8mla0IANNk55yoCpyQAXD05OtrPGhuXlU2
         IPZsemuv2oywCtDVYeDGISEYEAHNSz1CO3tY+vHdH1ruLRMj/ArR01ZhRJl4XTlNtp/y
         rUOw==
X-Forwarded-Encrypted: i=1; AHgh+RqZDfw0byLYJsOvq2RT/GfDAGc/tZ4vCydXYieGtd85giKUSyrLf0ZZxXGgl7DGfoEqThda2eTVcqnvM486XSlN/hApQKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGIBWhvscKVUV/CU2nOEIMsOqkfbCgvL9FWKZQG19atcBBfuI
	qKM0tK+rpSyRH5zMdj3d5JbN6EZ0U3d0OYZDZWFod7EQ52pkW/N20FZqC82daWShZ9rV26Pv4if
	CDnBzYZuV7XsilFCzHDYLsoq2mnCitfQ=
X-Gm-Gg: AR+sD11OgJ7KxhR/3wm30o3xjb/OWh+5q7WQRgORpvuNFih8poyGrPlurJm5Zny4X13
	VNrVxKcNZAClmPUN56+uobQI38WYM5eFnJsPQc1M6NflabO4WeDHSpSvbKNhiu2uWXgLQ1gJENa
	ohTK+k5e4wcw0dhichXZ5D5EFYiGRypkUmWYDpAhrafINd6GwUpuvEmTjkzzptw1OXu1TKtJvU3
	40KSbUhO/Jqicl2T2PlGOSxPvF5LUzigJ+XWxj3SPxuRgDRKBguXUYGnJZ2XVkIjdeExNDkDWTT
	qbgbXqCEqo5pb0ywfkk0UAewyZ++rkPBTt7kZUF1XrfiUFbsV4lGCCcd0jzj72Z/rc4vpC+jN9/
	I/+QkSMzPFHgxln+0fdrXMB5y8lx+4v+uEUW8zti1+MsASSWogTTQcpRwfVZl
X-Received: by 2002:a17:902:ec8a:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2d0ca1658f2mr73522915ad.0.1785950460122; Wed, 05 Aug 2026
 10:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0CoR7Z5B4-PH8GYYbWlZysVJpMnNLTFzTO0tBlOpJQNFiQ2CPrhdjyD4-4jQs4n0J_1QqovCd_EaYpclyigEKw==@protonmail.internalid>
 <20260628095132.47753-1-trev@trevrosa.dev> <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Aug 2026 19:20:45 +0200
X-Gm-Features: AUfX_mwN2wRwvmcNPuq0EpEyS5qgayFtXbsdflDPhbgmFxUJf-YMOIqJTLTJEvs
Message-ID: <CANiq72=wo4LOfa3hrJhTFr8UzkchW4QQtUespCTq7qRJvrr6CA@mail.gmail.com>
Subject: Re: [PATCH v6] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Trevor Chan <trev@trevrosa.dev>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	airlied@gmail.com, simona@ffwll.ch, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, igor.korotin@linux.dev, vireshk@kernel.org, nm@ti.com, 
	sboyd@kernel.org, m.wilczynski@samsung.com, boqun@kernel.org, 
	gary@garyguo.net, axboe@kernel.dk, daniel.almeida@collabora.com, 
	shankari.ak0208@gmail.com, lyude@redhat.com, j@jananu.net, lossin@kernel.org, 
	acourbot@nvidia.com, markus.probst@posteo.de, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, david.m.ertman@intel.com, iweiny@kernel.org, 
	leon@kernel.org, bjorn3_gh@protonmail.com, tmgross@umich.edu, 
	tamird@kernel.org, work@onurozkan.dev, sergeh@kernel.org, 
	matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, jack@suse.cz, 
	ljs@kernel.org, liam@infradead.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, ptikhomirov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:26=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

In case it helps, there was a v7 of this one:

  https://lore.kernel.org/rust-for-linux/20260628100731.64885-1-trev@trevro=
sa.dev/#r

Cheers,
Miguel

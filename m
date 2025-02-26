Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A052755E7
	for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601171; cv=none; b=O9SbOIoVg5HIw39FNP8lDmZqgNs0D4EEPknTPjKIY80YSgx8OWUbwkCkvFIOeNvv3+Ahs23UO+cF64lTQNPyNHoi4oZp9OrKOp3Ow9lJNeV0gRZJGKCDEg3acaBKxz2WD7gtKK9cvZ2COnKFUUO8r9VqPnDvZtZ9RgolBoM9QpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601171; c=relaxed/simple;
	bh=pRMgXJFWpAts+pU5cfw2qJI3yKgdhqxFVB1HP3y8nVc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=LkyvgA9VacKG+seaiFIYuxDnev6ZVf7KUhEf80ZwlSQN6CaApNwjrNl4LFT7TAm05uoXiTlrzHpWXX3cCB5HYwE25PaYJq03cGlKaYjJw+AU0Oy0ymFt/oWK5+NTAlk7D+u3zZr17G9i+dVGn/pd6l3D+AHm95ikjhXvISryYm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dveIoudK; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dveIoudK"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4720a115d15so11620541cf.1
        for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 12:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740601169; x=1741205969; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghoD3ag/pzPbCtjFY/jPNaeLEDXXel6+TW59rVHfjfk=;
        b=dveIoudKzKxKugANPB5GGsZegCwMrqDZcYGyKaEojssEcxYPTMjaP6BNUAButblbPy
         zbS5usrttUNCBSCnB3ybRBs8awJI2cASsu1AEF+JS+RJS3rFCxP3v78pWBlXIgUc33lY
         6FvP23ZUb7XMbgD86DpwYk3IpYZGNHAnO6yAsuGpixq2myYv0kfg/1voWZ1QGHRC3ytc
         fglXNgv6NNvGAiRh7rugpzBbWn2iogvJZ8Aa5BCQflLaQP0t+4QVBSz9o62UXeX9RDg8
         eoYLKcIeaLBnQEO/hfAvUPW1Bw8Firq21NSMkhtvcqEa1xImEcpcz/GumpEqCTKo7Gkh
         g+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601169; x=1741205969;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ghoD3ag/pzPbCtjFY/jPNaeLEDXXel6+TW59rVHfjfk=;
        b=T+Vqb8N7CgZAABbauinMF88DPfrCRU4I1wwQd4M5OcdwS4+b6NVX+6cn2MMbvlFcvc
         mNiJQD6RyRfpxLyLKN7+COznkOKS9Mfnw1ifjtl72LKLBCLpiWktHH7+GHOfKvedE36+
         s0Bs87sdO1hLsZZVYMRSE55pWHrZ44XoYhNQ4ZVzA7ltE0gUPjPdG6UjxsX2alBoRp6Z
         kAK+VnZrmUB93TOK0lYfajoii0oqFl7MPj0VyPoVBXhgUjCyLYlUuNuoiDxoBLYaXHwh
         1ze7+BZw06dlYsDTzsHqtuNKiiNDcsxV0AdoV6hdRjV//KNw0WCQN8y3pYvjtkarYGol
         /tvA==
X-Forwarded-Encrypted: i=1; AJvYcCWljaf5FpJ37L4ysS/k0FydQlFj2vvAWE65hkrxSQS7a0rcJfFhNQAE62mLDfLrfEvuxBDJBwi42D1UwBH08IzbMHfda1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGGtFUcc69QXGCZhaVcZIPREWnwF6GuvvyWubCDhvksBaX9aY
	OGLyOoykNjMqKx+nF0fw/BCum0QiJ36wU7p6YFjU4OJ3KM23baTSiHBTRxVnrA==
X-Gm-Gg: ASbGncvwoK3zx7KPd6jEggkkpkAwufT8gD8kz1SjQeL1Zz7hSFX1JMKm6IzuN0Rcxlb
	+0EqAlVBPq1xM6oydsMPZ9VblL/i8xQkA4JkK0ek2S0d3z/ETgrVRaAKoClY7qQXuMVYKg0FXan
	j4Bj8v60PsztRobR0twLHt1U5EfBCjAAIndY64wqrAveOcS46az5Wnlngf7XsNsA9w5StXDDqUi
	YOEkRh8SmCMtUGcYsGl040yozen45IGcOJauURGaHMjE0nJAGWY+wOF3EO7B7Flw8GGDfXf9b8B
	Dp+eXpGhLHc7jsFYRdjLbXtrM8GdyEuwisvXfU4gc7YRWptm139n5YDgnxZWzeaPglfdpn0=
X-Google-Smtp-Source: AGHT+IHlD52Lc+Tn+8mhSVeF3cbMWb5L2ojc8igqm9bfmEeYLdqG9MAA2o2DdRWX5V2W073wALgrfQ==
X-Received: by 2002:ac8:59d0:0:b0:472:521:871a with SMTP id d75a77b69052e-473e55a7432mr13431481cf.23.1740601169160;
        Wed, 26 Feb 2025 12:19:29 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-474691a45d3sm357351cf.8.2025.02.26.12.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:19:28 -0800 (PST)
Date: Wed, 26 Feb 2025 15:19:28 -0500
Message-ID: <4a98d88878a18dd02b3df5822030617a@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250226_1339/pstg-lib:20250226_1339/pstg-pwork:20250226_1339
From: Paul Moore <paul@paul-moore.com>
To: Miklos Szeredi <mszeredi@redhat.com>, selinux@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] selinux: add FILE__WATCH_MOUNTNS
References: <20250224154836.958915-1-mszeredi@redhat.com>
In-Reply-To: <20250224154836.958915-1-mszeredi@redhat.com>

On Feb 24, 2025 Miklos Szeredi <mszeredi@redhat.com> wrote:
> 
> Watching mount namespaces for changes (mount, umount, move mount) was added
> by previous patches.
> 
> This patch adds the file/watch_mountns permission that can be applied to
> nsfs files (/proc/$$/ns/mnt), making it possible to allow or deny watching
> a particular namespace for changes.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Link: https://lore.kernel.org/all/CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com/
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  security/selinux/hooks.c            | 3 +++
>  security/selinux/include/classmap.h | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Thanks Miklos, this looks good to me.  VFS folks / Christian, can you
merge this into the associated FSNOTIFY_OBJ_TYPE_MNTNS branch you are
targeting for linux-next?

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

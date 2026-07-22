Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D7335E1D4
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733286; cv=none; b=cIl68bMNQkOAp6JRVqq8k8U+cAaoSKajJSFtWAIEwR+MoU96wcOLa+I6igWeU0GLwwKj2fFv4wL3uzvyycs9WDgf4rHsT4rZpnVyNTEkdUKhHGXXRBUdN4gF8mdZZBLZAkS2c8zt7/4KrgR33RlXpCdqz2szOpkWl1uVynfRrhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733286; c=relaxed/simple;
	bh=uWVSmITDaDOGcqPPhpjJGoP4+QNUe0r27fajCJAPzQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAdcPv+Dno0o4T2SyopFGN/W/iQdILksEe+Su8M+eQ/jF5mJ/nYr/Vg7Za8FolAMMsyap+66hd7EPt/PZUpp0a7xTqOUC0ZSDVAIdQd/R5XRCW0jyZNUT7BRirsJuX8O6/LoXSyY3GLRTJ8Yr0nJyqLIkQ+ISb9xgpQGCTt8IaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fxCdzZoW; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fxCdzZoW"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15f020a223so1654433466b.1
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784733283; x=1785338083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FpirftYM/AXiBsGItonV7B2bYW2GExd8EOWH3f0NLiA=;
        b=fxCdzZoWdUG4G57Mofnwi9oNAOSmdSX7mjpIsvC8qNemRAHmy4YW20SeqrYsfbTlVn
         x4JfzTbBcpzC799PkZDPK4/q0dZBf/0K7kaCQeCS40SAzZLeqF14HgnZMtLujbkEk8+w
         /TN2ewClaeGbZ4soujvs10Qnxa3rOE4zBHAkOGn5M6iBY0hlnzFyUjC7+ruV1oy7S+3T
         4whOdLxWknQR3mQi6DfeoXNYeMXfFewPnLR0MOZItyYvItG14B9EZPQ5irfpaChzMyIO
         wLsV4dMQkRxcJqpL++i8DZ7ctvZ9sYZ1rP9vfyPSIrPRiB/ztgw+MVidncag3AeeOBHK
         rBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784733283; x=1785338083;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FpirftYM/AXiBsGItonV7B2bYW2GExd8EOWH3f0NLiA=;
        b=E5k9jK6ikoBOdNiIZbLZhvjlBZwOY6WEtiGQNf44m/fBaFAKJsFX70YPw/ad6dWzqd
         aV0Dim16tPoPw3PSI28KILzvG0kenoYP1wqvPSDBIS9PFkn1kc99e6HVPVZr/dlc33XK
         uU7dUVlKezCUkugMg5BbO8unC2X5EpxyhoKc3kOv5jLMl4FChZwDBtn+Kj4tjviZAtEt
         2kDH5Uk/WwpvZYBoLZsvI9i0pIEaS3d5KNl/RY+MnJAgBr1qhJNSFW1AV5QSAUzJ/aRX
         YNdLC3+rStBBQoeYcKrUx2SSRo4+gA9UgTJTqzN/kn3CJL8setenQ13eHM87OX5/lrW2
         YxOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrdvx3/dJHOiD5I7bnX+MW07sHSvPHF0tA7z8xrdgAuYWoifz3FGA0MsZD/h2e/eGmAWPa9vxHJGVTiokCxtK3EM/CBV4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SlqXTfO4OpSs2AY4OtsVVDKSsQ94axe/C0q+EUtfHCHn233R
	AL3x3y77ZMdKWWvvI2d7+yrKuJZOSXEXxkfWYjBO6snXR31U3hgaWlGjPIfz0unoPzU=
X-Gm-Gg: AR+sD10DM5TrEH2QnP0HjUQVwzcGzmJvocH3Yt5sqqMvpR4hqnh7lyxP4pbIVpN9TU4
	iiL7QpJGgaO8ruVWLuexfK82ENsZVcV0Ktmwk3FRjATVQ3FZ6UOKdulupr6JAfRtgs/ds45MxIp
	BmwbGGmasdh+6X0g8y8E5FLy3Glpob8LYufr9noWkJZ3LYCqqK7twuqTkBFwiwDIHdue+Sxf3Tz
	V/7kzHgKdqNK4dEh2Kqre06LlpLz/4B7bNjDnKDS4EwYFisOqBvW2iHKfn1z1jYFJGUbEigTlhM
	vL1rMKI2qWF8yO2pITx8kIL/23KuUk5XKhHvSyNKSJYxKW0PwqMZpIEnfwFwpGv1XuFK3MjzxZd
	ZwpXJzQ78E6mA67RIrFfBf7r1twng1PGB+josEnFoTmWprzKJz8GWuyeGmOWu6qk=
X-Received: by 2002:a17:907:3e05:b0:c16:1655:309d with SMTP id a640c23a62f3a-c16b4868dd9mr1149194566b.56.1784733282760;
        Wed, 22 Jul 2026 08:14:42 -0700 (PDT)
Received: from DW927H4LGF ([2a09:bac6:37e6:1e5a::306:4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32f11af2sm122985066b.57.2026.07.22.08.14.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jul 2026 08:14:42 -0700 (PDT)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: gnoack@google.com
Cc: landlock@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	oxana@cloudflare.com,
	paul@paul-moore.com,
	serge@hallyn.com,
	wangyan01@kylinos.cn,
	webprosto@gmail.com
Subject: Re: [PATCH 1/6] ipc: Move mqueue fs magic to uapi magic header
Date: Wed, 22 Jul 2026 16:14:23 +0100
Message-ID: <20260722151440.51298-1-oxana@cloudflare.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <amC69LnwcgG7xo-5@google.com>
References: <amC69LnwcgG7xo-5@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Jul 22, 2026 at 1:43 PM Günther Noack <gnoack@google.com> wrote:
>
> Should this live in include/linux/ipc_namespace.h instead?  Or even be
> exposed as a helper function that lets you check whether an inode is
> referring to an mqueue?
>
> —Günther

Hi Günther,

Thanks for the feedback. Agree, better to move it. I'll check how to do it
better and include in v2.


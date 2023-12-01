Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIEyAoja"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A03171B
	for <linux-security-module@vger.kernel.org>; Fri,  1 Dec 2023 06:06:05 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5caf61210e3so32294107b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 01 Dec 2023 06:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701439565; x=1702044365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3RcVkJFEYiHUgvCHqc9Nf39XOlniymidgmq8tmdHJk=;
        b=cIEyAojaDqv2qYsKX4g1rtA7HWufo67D6KbbpPfj2FbxTvF/vv7mGHKCIW1um1JYNU
         n+zPFsMqgEj8eDS+4WYS1sIIK8IM54la7chYxC2IxNDfO6AzwxxS2dyTfrZCK6c6fXPz
         gjAj7b2CDXvcn2ib5muDGO58YudJC2jRjllMGu6QzP5loEX1+NItO+GX7VMGIzx0UydY
         L/WBv2lGvfCu8a3Uod8bbsnrnasdfVaa5/zZVjAfLzw0zNukxhkQ+dZN0Wu+FJiwXpwo
         8ubGtMUQysTGUn/9Uxb6ysttgRco2opHliDfsclk52xDcahEiAQ/fb8+CuzZh5pcNx8o
         A3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701439565; x=1702044365;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s3RcVkJFEYiHUgvCHqc9Nf39XOlniymidgmq8tmdHJk=;
        b=Fo3Ei8EWE7KYVq8Wvf9vNfdVC0Cn7uh3bTudOB5d/vG9QGqzSX4rEG7Fc0nKzM8D76
         RWBwg/rK9fkkc6y6MrVvjXPvn8InYYvSLv2YnvwTbFeztDzhkunum0tZUHQqnZ2OQvJu
         ptHjaVBZmhL/WQ+dMa+YDAmJBhyjZXYjiCu9K6/benPhyqVNbR9ShVUIqIZdFButaQGU
         xvS5S6e2OVcCB8swmDPlvb6k51H/xOE7F47lFcSNkSIP9p45NdZ6zscApGRowuJpu0cO
         i11pcQz3ExGScBA0unARLDA67yinvVWELfcuvH5LnCtL74t7ZVT8/Js80xTPVdMW5wOb
         JAWg==
X-Gm-Message-State: AOJu0YyWDZ4J7c9PX4TDMbr1OqBiCQuLfDXGxs+BRALJTpPFA5NMT7o7
	x1drfw4Y5CqJKdbK7GJEvcgVB/54X9s=
X-Google-Smtp-Source: AGHT+IE9zUTAo7d77zYYleJDgkfQBYLq6ddaqe6gq0/VCKtXXQu99lt1BiEAbdkwSXgfbuavqfdlH717tXM=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:fab0:4182:b9df:bfec])
 (user=gnoack job=sendgmr) by 2002:a81:af28:0:b0:5d3:70a6:dd3 with SMTP id
 n40-20020a81af28000000b005d370a60dd3mr176963ywh.3.1701439564836; Fri, 01 Dec
 2023 06:06:04 -0800 (PST)
Date: Fri, 1 Dec 2023 15:05:56 +0100
In-Reply-To: <20231130.beetuo4Chuso@digikod.net>
Message-Id: <ZWnoREHBbcrF35PI@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231124173026.3257122-1-gnoack@google.com> <20231124173026.3257122-2-gnoack@google.com>
 <20231130.beetuo4Chuso@digikod.net>
Subject: Re: [PATCH v6 1/9] landlock: Remove remaining "inline" modifiers in
 .c files
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 10:27:18AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
>=20
> Thanks for this cleanup. Maybe add a (one-line) explanation?

Done.

=E2=80=94G=C3=BCnther

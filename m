Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364692C84F
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jan 2024 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OJsT9ASm"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbdc7ff087fso842765276.2
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jan 2024 13:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704405442; x=1705010242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOJx/D9I9BlgipBiGrZNajpa/ePe9te5wdZDi1lFh90=;
        b=OJsT9ASmpGirYEw4TGqMr+KVofWzbsOeL6SYKql9K46FsSa4+i/jyAP40vWeheVxdC
         dDfHHtZ30kE6QpxrGxV08BOrPcp2eurL++weU93Du9J/IE0EHD/eNyyQfQFff0+5DsQj
         3cvcPT9tAxpRUc76KM1jrdQ8XWazi5Lll2mvk23yHOEIc8yrNVI/NTHPfCiDigWqy43w
         f+Od6mVQDAGTWVySaUAxR7UV5g1yS4U7t9sS8X/FhpI7nJwYzi6VCFrmytp+nJ8iF61W
         GDddIpx7Q8AC/CW77JEBTcd1QIdlmixiyp3D+a2N7w7hnGCMYY3RjpbBfxsSTWpUa2f4
         LETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704405442; x=1705010242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOJx/D9I9BlgipBiGrZNajpa/ePe9te5wdZDi1lFh90=;
        b=Vx6w139QwKf0sSsLz4YiVm00miN2uNpSQaIy9k8r7MdqB7zu9pUUreeRTSn7UGmqxt
         jT35ddTvOmZh2X/qeFraPyWyPIB2Bndsz0WG5OsmdYFbv5OnDbLBywL7GSliPFh72o1t
         DQNz7uA0iz6+vzAiRSsOAGvOclEqPeYWyVPlVih8528x0TPmq+VncSDcDJTh2RNV9rZr
         rQuoqax0fAkJmkbqxgHQfR0tmWZbW6F8Te2YgYl+RFkzX7UZKnotHqo9SiKqULTkvT0Q
         bX7lwLyaFeRp1+FuwTBkmUzdSZBxbfFWEWdlmNJ/ETmQ7Mx+KK4J84EfUWz52nR2qghx
         UxLQ==
X-Gm-Message-State: AOJu0YyaJbl35ci151iVkkjIU0jPz6TfQkdJ+/ltk3uTwIpp9T/lNZXp
	7FNFqCQ/NhD2ZXVtoIEwcNlbNPDtJ6qGrHx0GXfMzmDFL33R
X-Google-Smtp-Source: AGHT+IFMqTHSuBBDvogO6c+qL9/Xs36u3YbBdlpQcFxg3Wk04M3wPGZW4zqxbNLq2zbL016aJ0gEnXkJYDvDC/8Ee54=
X-Received: by 2002:a5b:f4b:0:b0:dbe:7c4c:3307 with SMTP id
 y11-20020a5b0f4b000000b00dbe7c4c3307mr1014785ybr.17.1704405442111; Thu, 04
 Jan 2024 13:57:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103163415.304358-1-mic@digikod.net> <d4a31d87-0fa3-4ae7-a1be-37d3ad060603@collabora.com>
In-Reply-To: <d4a31d87-0fa3-4ae7-a1be-37d3ad060603@collabora.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Jan 2024 16:57:11 -0500
Message-ID: <CAHC9VhSkg6=Y5OgUmdkBA2MBrkQT3idZ7NWG2msqdsFZL03TyA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: Fix error priority for bind with AF_UNSPEC on
 PF_INET6 socket
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Eric Paris <eparis@parisplace.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 6:40=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 1/3/24 9:34 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> > The IPv6 network stack first checks the sockaddr length (-EINVAL error)
> > before checking the family (-EAFNOSUPPORT error).
> >
> > This was discovered thanks to commit a549d055a22e ("selftests/landlock:
> > Add network tests").
> >
> > Cc: Eric Paris <eparis@parisplace.org>
> > Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > Closes: https://lore.kernel.org/r/0584f91c-537c-4188-9e4f-04f192565667@=
collabora.com
> > Fixes: 0f8db8cc73df ("selinux: add AF_UNSPEC and INADDR_ANY checks to s=
elinux_socket_bind()")
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Thank you Micka=C3=ABl for the patch. Tested patch on v6.7-rc8.
>
> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

This looks good to me, and since it is rather trivial I'm going to go
ahead and merge this into selinux/next so it should go up to Linus
during the upcoming merge window.

Thanks everyone!

--=20
paul-moore.com

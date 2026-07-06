Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76A3B6354
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jul 2026 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783315510; cv=none; b=sczOc/zffldrYTUyacE8f45Qxp6iUbA29Ts0J1dbfckvCngoIgrVeFikzzwZZAic8s60YtV1VKY1M2J66MEi65XkZHbq0cjGEH/p7W2NYQxc0/e9/MewWzqNnh6hd61ZnxqAtoFJ8BdxztwFFBh1RgHYTq/jzxaOp+RzHITgrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783315510; c=relaxed/simple;
	bh=4Bx46F9CMmH/tEqR+Xt/BDS0JGlFcMoeBe/M3xKFzqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BO1NXCpUtTifb+5qI1QiruvBw+2HPte48pxIORtgVQfGba9RfewCCAXprKd79Bowy7smyaIjI+qk3ggLPUGlDsRqvU8HKc0zWUui5jeOQVfOa/cLkTl8hLc/9Ww3DVQCbTwjo1gLGj/DqqYkKgGVZyEPK4x0q9wJmYtHgNnItj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I76f3DA7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I76f3DA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4661F00ACA
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jul 2026 05:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783315509;
	bh=4Bx46F9CMmH/tEqR+Xt/BDS0JGlFcMoeBe/M3xKFzqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I76f3DA7a6JU83Z+ueDSptdAyF+BAylqa4KEc6o2VY11K2iO3W2E/Jr2W5OfgtLBT
	 h1MdE4C94N2uWfx2Q72dcE2/+ixCxJf2vkM42bqJuCBRszyD0Gh3z0wungtn9QVSLf
	 R4wQYnUsZhkR/pz6pHDp4AOhFo7J6nZuUdt5akoIt/LXcuwcY2vDhlmH5MeW7tbElU
	 yLiw5jLHhU9VwiQ3hXsrE51lsJ7+vgB2rt8y39S+Gh/3QG5a4tYxEfyvLFLnKxyVit
	 lJ5jRij3JPZGskZ8QcnA1UNC5rtWFBhsyGDrBn2Uyy8lG4cUK9d24pBTmU37yA5l5D
	 BtUpmxVjthVgg==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1212817a91.3
        for <linux-security-module@vger.kernel.org>; Sun, 05 Jul 2026 22:25:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqwGT5V2v/VmRb50/3KSKBgL+nyw/CllvnsoCzd83S47+zZyvCqJO9J9frvLqyXf0eHNjKDYHQe3Ow7llgssKbvLi5mBpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3wB6o2F3ciH6QREdDylvStsAU0qyj1EyRxb+pDG/PucVwDx1D
	2u6q/IrOuoacxCdFC0sECYwZKS5Oui61jAT9EJf1Bi0hoJOsK2EvBh/ywpljnXwM0wReB7UQj97
	VpBUXFXrKqA63BCmggfSlRKgcf8IkOA4=
X-Received: by 2002:a05:6a21:6e48:b0:3bf:6c04:a816 with SMTP id
 adf61e73a8af0-3c03e4da45cmr8933016637.55.1783315508805; Sun, 05 Jul 2026
 22:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702192209.211102-2-manuelebner@mailbox.org>
In-Reply-To: <20260702192209.211102-2-manuelebner@mailbox.org>
From: Fan Wu <wufan@kernel.org>
Date: Sun, 5 Jul 2026 22:25:03 -0700
X-Gmail-Original-Message-ID: <CAKtyLkEmOJYnA6bGJcS_LhCXguu_Qb9c8wSTu7FLwMkOmOeoDw@mail.gmail.com>
X-Gm-Features: AVVi8CevOdtBvIT4J_ZFQWBBCI0WSEViDlR3dK9MMuKMvpsrGDOPD4aafDDVWrQ
Message-ID: <CAKtyLkEmOJYnA6bGJcS_LhCXguu_Qb9c8wSTu7FLwMkOmOeoDw@mail.gmail.com>
Subject: Re: [PATCH] ipe: fix bracket
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Fan Wu <wufan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 12:23=E2=80=AFPM Manuel Ebner <manuelebner@mailbox.o=
rg> wrote:
>
> Replace nonsensical ')' with '0'.
>
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> ---
This patch is correct, however, please add a more descriptive commit
message and a Fixes: tag.

-Fan

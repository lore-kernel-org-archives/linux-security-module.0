Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0D4A8A16
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362428; cv=none; b=KxSMgbImLc5RlSS2fSXMrRn9NhaAu9DAzUiZBjxQzLSx7OSydRYcxmZ+TQgAmiwa1bouWpIxQIMubVFREg+mZhKZ2t7sbKpxs1p29gb44TvyqBZCZqeuJ1Wu80TQX/HxDnZ4mC13QDg5DdTddNWUsOPTlZhSTRy1+m3NdXAAOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362428; c=relaxed/simple;
	bh=qXON5Y/0Hhn8zg9epAannR6ouX1AMPvp99VlLkQP9SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V94G+5R4XIicD4F3D8gSi/smbGh94RrA7JWe3zMO2/eRv9K6kUlFlzn/YvtP1hzA0U2jLC8Sit2fwywztkB38i2xhoMsMdQzz1zecIa6a0GnVJoqkOmDiTskVU7yPnOJhNE4l3zs3GAn2fWIGWU6a2kI1g+P9bR76OJ0xYTr/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilymUxbf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilymUxbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366861F000E9
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788362426;
	bh=qXON5Y/0Hhn8zg9epAannR6ouX1AMPvp99VlLkQP9SY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ilymUxbfhs/5+QYLl+NJ5k7tiYWBa9HVGa1EkKZkVoq3GDCha6ckwM8bFNrP9aTAl
	 FsjJy238KRA4W3HxRjq88Qm7hQ65bKXFSLgxhj7phJaSEdnaO9vp/ROrIUcqAsGoyV
	 ebRJnA3dk7mWuwbm0WnJTE4i5MEdWkVrJJG6iCpeUhUC7v43ofyDCDL602VxBiJ6TZ
	 Dl4pCcqsqv4dPBRR2tZ1Xjr32aFROpFQex8UADBUi7sPrtOD6jokI0n+eHhK6+AE+t
	 CEjfWM/obJdODIW2ScYsNjKh6PoXjB1kbFxrHpUjhDPNIbz9XAHpZ+3CwQzp2Z//zC
	 HLnJhvxMjfNBA==
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1cbb64a1fso1353415a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 02 Sep 2026 08:20:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwfnbsZLpkzG76mlyy5+p0jeg/26cqlugGEeqDCXg5q4WvVJZcmWxx5T64k0Sm9hMnX0faHeKofXTR1H/fV5VmSFAZFM5I=@vger.kernel.org
X-Gm-Message-State: AFuF++lIL06bBBu7vDN4ohDsD2R/4voAZRqXU8HWXuoM7BZRm/gNctxj
	vGSb9r/e659SGVH8O49c4voYDCJ2O3HZlQN364sYAJBvEh9i0OMEOZjTwZ35hYMxDhmyIQKIuz4
	Zt5++sU5v+2fp+AZ5MAcv3O8tgnDn4xU=
X-Received: by 2002:a17:90b:17cd:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-39aededf539mr7563027a91.6.1788362425805; Wed, 02 Sep 2026
 08:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902124623.695928-3-manuelebnerli@mailbox.org>
In-Reply-To: <20260902124623.695928-3-manuelebnerli@mailbox.org>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 2 Sep 2026 08:20:15 -0700
X-Gmail-Original-Message-ID: <CAKtyLkHDr7D026T+7A-4LODAPbZez11wn=BdiEx5OH-7y5kUew@mail.gmail.com>
X-Gm-Features: AcwNN1W8-eogi-AuHPYaha560R07dGwK9m0uGleXMnnx_g43weDtAmNjbvAWmyU
Message-ID: <CAKtyLkHDr7D026T+7A-4LODAPbZez11wn=BdiEx5OH-7y5kUew@mail.gmail.com>
Subject: Re: [Resend PATCH v2] ipe: fix typo
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Fan Wu <wufan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Deven Bowers <deven.desai@linux.microsoft.com>, 
	Paul Moore <paul@paul-moore.com>, Manuel Ebner <manuelebner@mailbox.org>, 
	Fan Wu <wufan@linux.microsoft.com>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 5:48=E2=80=AFAM Manuel Ebner <manuelebnerli@mailbox.=
org> wrote:
>
> From: Manuel Ebner <manuelebner@mailbox.org>
>
> Correct Set Group ID from 'sgid=3D)' to 'sgid=3D0'
>
> Fixes: ac6731870ed9 ("documentation: add IPE documentation")
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> ---

...

As requested in v1, please make the commit message more descriptive.
The keyboard-layout speculation is not useful and won't be included in
the commit history.

For example:

ipe: fix invalid sgid value in audit event documentation

The audit event example in the IPE documentation contains sgid=3D),
which is not a valid Set Group ID value. Fix it to use sgid=3D0.

Please update the commit message accordingly.

-Fan

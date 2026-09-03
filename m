Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E04E66DE
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456453; cv=none; b=cOmftnvRmaL2srv4v3Z/oZSvMJAd+VMT2XqMEIjvmRhgqLlGDnNNcG4tikwJq6ihxEDaCdzytLv1/ok0CVFMxQ/7GnaPTXkW2VaVuIMUI7k5z/9uOQ7NuU5nf+0m1Vy0XLI4UQQ0/4ul7qOqwbkL0X0Kk4cDw7WwYBmLFId0Fi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456453; c=relaxed/simple;
	bh=NzyHlj+F1WnazB4+oa+9hqNquIJnPs2apGJceu268FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNsmdBOjEWKGYSufejf/cq1tOI9Mbv3PRXCOhDX91BqUjOnoX5mXKqmakI10Mb5YDn+dC87Wu/hIzcQahTzfQiqyFfZ+FH0L+B08el3kl0AlpJoM1WsTTYyKLXltlUNpqrGlmQKWwXmiLNsic8lenCCwgcR+DUBSVWaPe4x7krg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1sShHkt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1sShHkt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9221F00A3D
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 17:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788456452;
	bh=NzyHlj+F1WnazB4+oa+9hqNquIJnPs2apGJceu268FA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P1sShHktbqhsfw0j4yS7W94i3+Z5MRKBa+5D521CJePm3D4TRKWHXYoDwXJQdLnBr
	 scrSJr8cEYnn52WBoh9kSFo6KGaX8zgiBJUjOk3WI1CCZ5tHvpdyyIBaUJnG08vmDH
	 kAlplH5liFKaOJSOS3wt9B/8Ni/DM8QKrEpxKyHGs2BnXrdDSbn/gEBZfl2gCc48j+
	 Lxz6BigoGEyHDvXUdQeqagEEgk9FFYtpdIumaC3pWxHHwBYG+kVQ2KdmtkA59pGF8H
	 Bxlqh2/a4dIiNv/3gSVbz/JxX4ej3i99lOL3fjo429Qqpkq66DSXU9Yn3yhqYj91IS
	 xE5wMSP99sMNQ==
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-39266382df6so23398a91.3
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 10:27:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzrTi1OlGnWudWz4nyIxQEdIIb4CMoE1IK8aoSTjt8xTkHgsbjrmMYA4PyLMNnFxBuLNmXy4DT+6ns1Yb/R9sGudNOaym0=@vger.kernel.org
X-Gm-Message-State: AFuF++lgmymBTi1k4rZIvrdIcZZUUPUFlHijBGs/SjGdpaRabbITpC0l
	VrSCxfjNMYcJx2HR7xBusXTqdJmY4s164uoxHwhH6ppGGcCwtbRGPsb9C8kt8OhMXQ1EHGCHfRN
	HVCYDeqnaGUhrNH2nfm8QGp06+/UZ/w4=
X-Received: by 2002:a17:90b:5310:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-39b26272b59mr4877a91.14.1788456451651; Thu, 03 Sep 2026
 10:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902152910.708743-3-manuelebnerli@mailbox.org> <a4f81c75-bd83-499d-9dc7-b891ec9cd922@infradead.org>
In-Reply-To: <a4f81c75-bd83-499d-9dc7-b891ec9cd922@infradead.org>
From: Fan Wu <wufan@kernel.org>
Date: Thu, 3 Sep 2026 10:27:19 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGDab8y4gLCxB8it0R7pJEYk6SF2YDRuhxGwRnoPJCVsw@mail.gmail.com>
X-Gm-Features: AcwNN1UzhA_lKFHBKz39dW7UfnttRnAH9rsChsJlzbrbWgm9FM8-99pn-OxwtcM
Message-ID: <CAKtyLkGDab8y4gLCxB8it0R7pJEYk6SF2YDRuhxGwRnoPJCVsw@mail.gmail.com>
Subject: Re: [PATCH v3] ipe: fix invalid sgid value in audit event documentation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, Fan Wu <wufan@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Deven Bowers <deven.desai@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	Manuel Ebner <manuelebner@mailbox.org>, Fan Wu <wufan@linux.microsoft.com>, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 10:21=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 9/2/26 8:29 AM, Manuel Ebner wrote:
> > From: Manuel Ebner <manuelebner@mailbox.org>
> >
> > The audit event example in the IPE documentation contains 'sgid=3D)',
> > which is not a valid Set Group ID value. Fix it to use 'sgid=3D0'.
> >
> > Fixes: ac6731870ed9 ("documentation: add IPE documentation")
> > Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Thanks.
>

It's now in ipe/next.

-Fan

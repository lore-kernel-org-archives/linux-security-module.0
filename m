Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53188374C4
	for <linux-security-module@vger.kernel.org>; Thu,  4 Sep 2025 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949331; cv=none; b=abNi0qrXPbZoYQR1DoSp1DJnb0k8TQQyPgnSWoKK7FF6XrueLTDTIggCndjASi0jqa2qedfMqN1jYfoI5JIgGxtOWvGyuaiW5h+9QmGbBMpC7FSoklXJxTMYQ/WWw7FAk4r4dFBKYKzFc3t9yDtjCCFic0fMHbfcbMvnmgTQSDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949331; c=relaxed/simple;
	bh=IaQ5uwK4QwBnH+gS9G1h8dmnPscMOmuMdmvaxqjSAxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIxSVldjgZdAfJ1VgOz7PSfb+FH317kh+SGYqXpfp+qo/mbjRiQT7ezE5OXts7Pffqlq+ldmSHtUHfhHqBNRKY0YwKjVuaTgiRlDtW7d7OGx5NYcPTGXun35vbbkGNgn08fMhmW77K+O5r3Ah5ta/O13BlJfkGqNX2Jkt7hyIOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I+mNVC5p; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I+mNVC5p"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-329b760080fso471790a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 03 Sep 2025 18:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756949328; x=1757554128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIOfyHMtIuoJpOd+VlEFA0bHfp6Gtl4PKzs6FIPewXA=;
        b=I+mNVC5p8jsB4c5LGhX+j4MhdLjPXQIPnp5qzLJTPHAE+z6X0j1+aVElLhqIReksk/
         NIq6qDy1eSTdVSYa/aC+dSpTOEt2ghoFtQMkh1LvmN9b+f0X6PyP0bzjaO3mSZ3bwZEi
         XUVNbl+Zvp2RgvzrOyP3H1LtuhJYsTBSdTNxbBvFJciS2pl0CB0DXR0caH26a1/gysKW
         SPiUf1gI1pylraX6ni8iSvfhv0G+SfRAvO2BwqO66EaknX2B35yHPt54GZ9Dg5HnMOyN
         2tbNxR0D6umhQUS7lK6hSQIu7KyUnIZWt+KfkmMDk0e0SFFGjQMG9jIHi/4QW0tE+j3Y
         vj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949328; x=1757554128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIOfyHMtIuoJpOd+VlEFA0bHfp6Gtl4PKzs6FIPewXA=;
        b=THg+b6bKHLpqSi5N9ihzufDyyMRsr1U7dXHHaxRbkKUCMoq0HVT0ZEyVxlrGnYeuxb
         GrYPqhVfjJgsIXjt+5L2PITN9dvh8yihM2NN2mMw1voa0iEAodNSUA87MxgNqXEGdTye
         191w9X789gy03lit/ySAb/ollZq81h+jIPa1JG81BQlFO6P+iWuZZDNnHtNAnX/O6YDr
         xfyv5d8HOsSrEvEX5td/B5Sz1beIIuKAEAg8aITD9rIva6O0s6ZGZ+UqU1yZhZiv8r9Y
         3BHpLgkq+jT/1ogJi6NLU0RzelMipUOfZB0ER5EyLMv5RudNQ/RU6pqeqW8NJbyR8bWA
         FSkg==
X-Forwarded-Encrypted: i=1; AJvYcCWgLzwvQ+JX030XoscgzOao63feBXUAUkagkLkQdb8ctyrDuYoxMnjli78fvsuCF99i9ump4S1VFLHre6cX383LAsvQsd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybdX7Imv8wO+/BhpnL7j/fjmO4AuHLxPH09DKAPfcfkY2nLrfn
	bJ0yi00uqPjcXbmVl+FrC2OLG1ZWzPpg7tozLPq0s8MFsYOl/iWCxwWTK73+VRjKEZL6E7o6MvV
	eeJVbeA7yLImFiNQ8pHnZ1Tdnj6cLStgNsYAbHQqk
X-Gm-Gg: ASbGncs26l6WSCaDsWmeHSlP0jqbYjM5+jXcAShQoRe87D9wvfiAQ/aOeMAKGfQRIhd
	HEhey55SaCfCxd7f+8Gne0qZZRxxHK95JqPB/u1lxhqOPFUsDiAggzXI73EJ//eQVd9PwS7sTuH
	TE1L/pAhpzOjIYWfIqhDMUeAhlIQfxfCnka0hwndl0NVInL3Hsj74GAZ4TprWVYI95CSMmdOVNa
	V4MS9u0NxLmNrvferpOK3pwWgFX
X-Google-Smtp-Source: AGHT+IFBKmXhFkhlf3AO3YklhmlQlkknPiNAGzAs3/NGtNx5EdCIX4CD+Vo4Pco6SEL0557kGd49fhJOqXjMoxsF0Cw=
X-Received: by 2002:a17:90b:3fcc:b0:329:f630:6c3 with SMTP id
 98e67ed59e1d1-329f630078dmr9758647a91.20.1756949328511; Wed, 03 Sep 2025
 18:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-65-paul@paul-moore.com>
 <CAHC9VhRwHLaWP-qUCEVC7-6hEWf0K1H9DwbxWMW9c3a5uUF94w@mail.gmail.com> <1932305e-c6df-42c6-906b-d57364652242@canonical.com>
In-Reply-To: <1932305e-c6df-42c6-906b-d57364652242@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 21:28:35 -0400
X-Gm-Features: Ac12FXwM_owd8hqAIDRgoryFAGYaav8zfNn8ISHgZWw1QPDHSomawRHnM-NiHCQ
Message-ID: <CAHC9VhQbRp7i6dP_Z1W41ykeG6N2Dp_fGzE6sh8xXo_pxPSfWw@mail.gmail.com>
Subject: Re: [PATCH v3 29/34] apparmor: move initcalls to the LSM framework
To: John Johansen <john.johansen@canonical.com>
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 7:15=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 9/3/25 13:34, Paul Moore wrote:
> > On Thu, Aug 14, 2025 at 6:54=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >>
> >> Reviewed-by: Kees Cook <kees@kernel.org>
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>   security/apparmor/apparmorfs.c         | 4 +---
> >>   security/apparmor/crypto.c             | 3 +--
> >>   security/apparmor/include/apparmorfs.h | 2 ++
> >>   security/apparmor/include/crypto.h     | 1 +
> >>   security/apparmor/lsm.c                | 9 ++++++++-
> >>   5 files changed, 13 insertions(+), 6 deletions(-)
> >
> > Thanks for reviewing all the other patches John.  Assuming you are
> > okay with this patch, can I get an ACK?
>
> I'm working on it. I managed to get down to I think 3 patches remaining t=
o review/ack, and I wanted to get some testing on this one before acking. H=
opefully will get that done today

No worries, I just wanted to make sure it wasn't an oversight.  Thanks
again for reviewing everything.

--=20
paul-moore.com

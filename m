Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321192550D8
	for <linux-security-module@vger.kernel.org>; Thu, 29 May 2025 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562573; cv=none; b=iF3Yuaw9fPXYKuBJQGtQTJNYYgplUgX7wrHuNDIF6vsp//vPt7hS5rhWtKRmrB+ZUo0c/CJuvsR+6CTwftzjvKofoJvKc8vAPJHOi3YYIHl8HV1hVDvaBmkCnHRJPj1Hr6Quj906N7UzPsDg1V9zgASWQdkRCv4oKry4EcUAees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562573; c=relaxed/simple;
	bh=njDQ8Lhj+rbQY91bCgJ2J/LI6phcjK0rry9e5UVMEYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SldgiCuV9e4xOuhWXlxTReXJeMynPihQqB3ucdMpMM78VLhQQGgC6QWPrFbjHFmPUJcUutHwt/WAm65fs9/z8mNWVFdASn4F393Y+552rBeN/I3J27z7l5jaIbVV3z+UYU1hw38AVP8hoqmsuvBstyGXUcdduKxYkMtYTeBNjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ma1HFYxb; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ma1HFYxb"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7d9d480e6cso1146348276.2
        for <linux-security-module@vger.kernel.org>; Thu, 29 May 2025 16:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1748562570; x=1749167370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzrpMWMfPR3T2gCVNz/ykn1poKsGqIWx4fYMabbDEoU=;
        b=Ma1HFYxbpQWiO5QgZg/176AE28nFmcx4LGBbFEj2ed6gW7KquDE8lkkFg5lYuS5nrp
         ZnVR9EMCcTIn8swlEw8SwbYF+P5CIMZKly1ju8Ciuxn3F/YPKAeyrOKzYF3VzU8XbFts
         xzFAGS5MLLhuTxE41HqMT34c+xEYvWg+D3Vo4Kl7kQRR5jQLjYCpDtTekHmJl6Sq9jH1
         2eNjbNxi6fFmbourM8UwjWyiLUR5V1md3o6lM/AkUKkTxv8DiFoRnC0IAcAW48YBYtCh
         gf9f84AH8h1OHq3Ao5j5Kedgi+GurI7XFxavKxOymPXg1zJA2bMm8RF625x2tb9mwA3e
         DghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562570; x=1749167370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzrpMWMfPR3T2gCVNz/ykn1poKsGqIWx4fYMabbDEoU=;
        b=d4EvN6qb3gfpTKGBJpEYVxYGGxLqzpFVUlMJu2PSi7O5wUeSbCAtCIp4PdfjE2l1Dp
         wlG0YBXo5pjri5rAcI6kztYklNSjigj2eXiKPZe/+RAaSuzX6zSakv3u8qoCQ72wJ2dK
         OoE/Ewwhl+sOscIwGVvP+bhmSLVw5YqglHiyChJqSOHPDYScaCGQIuRAFxMy86WD6Q0s
         xXEHH9meu4QLEDppATC11ToWYGdBqAeTT7pv+UAj7gMvPOd0Q7dF1kN2qzYOIXta9TGo
         VOZBSayFm/8kvzVx0ajwajsPcxfVw++HvWyGiGoJdUr4SptG46sdkYRgK16g7RptOsm6
         9FFA==
X-Gm-Message-State: AOJu0YwxANxTugYGRNOuWAkM1LcCv8ueU0Vdigw2xlQ5IBcgZNemL16S
	reFUHCyOJQEuI5qasEXWJovb3/x7DoGsccOxWFRbsqHphkwKesIODDnDAe/0f5TFuAbkjz+BNuX
	RIfzbLVvhmQzxC+TqCkTVuGVAWei6fHlfc1ciWze/
X-Gm-Gg: ASbGncuTgAvTvuqe4is+MP9kwov/al19IYRT+1pvIoXM3kAmsDyYicDhdwe8iCxUiRG
	ud4jYEFYLZMbnpcDANIeTJBjeAFzfWdg57Nt6f/zmpl5zqiQcSb2evMcETgRs9nc4HAhq+CkqXJ
	UmddtCCi+0PbsKeABzR668vWQ6CY+ReFfV
X-Google-Smtp-Source: AGHT+IGhztxCAK3YTRu6P4h6gxYqvuSLD7WfoNzyStJqIFYGaHOmc7yQwpS7nzoIzkVnhQPYk9/qIXwf6pJLAlBDxC0=
X-Received: by 2002:a05:6902:330b:b0:e7d:6a68:f572 with SMTP id
 3f1490d57ef6-e7f81bb773dmr2259538276.10.1748562570009; Thu, 29 May 2025
 16:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521140121.591482-1-git@nightmared.fr> <20250521140121.591482-10-git@nightmared.fr>
 <CAHC9VhR-80zxgo+q07Aw8HqK+qiPdnuXC0axONGac0e9JxXvmw@mail.gmail.com> <4939d8ab-3911-4759-b8d6-cb57ff9f9cda@nightmared.fr>
In-Reply-To: <4939d8ab-3911-4759-b8d6-cb57ff9f9cda@nightmared.fr>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 May 2025 19:49:19 -0400
X-Gm-Features: AX0GCFt-dubQ8zjyvLFIAb7yxjUrHx2vekSE7cPMRUm7dhYCysWfX-kgOpwdxLI
Message-ID: <CAHC9VhT5JrhzGhRnJ4VNo6e941o-xdAG-FC-Q6wDbSZhgSUWOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] Loadpol LSM: add a minimal documentation
To: Simon Thoby <git@nightmared.fr>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 5:23=E2=80=AFAM Simon Thoby <git@nightmared.fr> wro=
te:
> On 5/21/25 23:31, Paul Moore wrote:
> > On Wed, May 21, 2025 at 10:03=E2=80=AFAM Simon THOBY <git@nightmared.fr=
> wrote:
> >>
> >> Introduce a minimal documentation for Loadpol, presenting the policy
> >> format and the two user interfaces: the securityfs policy file and the
> >> sysctl.
> >>
> >> Signed-off-by: Simon THOBY <git@nightmared.fr>
> >> ---
> >>  Documentation/admin-guide/LSM/Loadpol.rst | 81 ++++++++++++++++++++++=
+
> >>  Documentation/admin-guide/LSM/index.rst   |  1 +
> >>  2 files changed, 82 insertions(+)
> >>  create mode 100644 Documentation/admin-guide/LSM/Loadpol.rst
> >>
> >> diff --git a/Documentation/admin-guide/LSM/Loadpol.rst b/Documentation=
/admin-guide/LSM/Loadpol.rst
> >> new file mode 100644
> >> index 000000000000..0aa24a8d393c
> >> --- /dev/null
> >> +++ b/Documentation/admin-guide/LSM/Loadpol.rst
> >> @@ -0,0 +1,81 @@
> >> +.. SPDX-License-Identifier: GPL-2.0
> >> +
> >> +=3D=3D=3D=3D=3D=3D=3D
> >> +Loadpol
> >> +=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +Loadpol is a Linux Security Module that enforces a user-provided poli=
cy
> >> +when decided whether a dynamic module can be loaded or not.
> >
> > Considering the relatively small scope of Loadpol, I have to ask if
> > you've considered augmenting other LSMs to meet your needs?  While
> > LoadPin is different from what you are proposing here, it does
> > similarly limit its scope to kernel module load operations, and given
> > the current simplicity of LoadPin I imagine one could find a creative
> > way to extend it to support what you are trying to do.
>
> I indeed felt a bit ridiculous introducing a new LSM for a limited featur=
e
> like that!

Please don't feel bad about it, often simply doing "something" is what
makes things happen, even if that original "something" turns out not
to be the final "thing" :)

> What's more, I don't see it being extended much in the future - we could
> always imagine things like signed policy updates, but other than that it'=
s
> probably "feature-complete", as the feature itself is fairly small.
> The difficulty with LoadPin is that it rely relies on the notion of
> filesystem (which is coupled with the origin of the kernel modules) to en=
sure
> that modules are valid. On a general-purpose distributions, the modules
> would be stored on the same (non-integrity-verified) filesystem, so
> segregating the modules by filesystem is not really possible there.
> Extending LoadPin to provide the same features is probably possible, but =
I
> fear this would add complexity to loading by trying to make it do two
> slightly different jobs at once.

My thinking around possible augmentation of LoadPin is that both
LoadPin and Loadpol share a similar, limited focus of controlling
access to kernel module loading and Loadpol has support for a basic
loadable policy, a policy that could likely be extended to support a
LoadPin-esque construct that limit module loading based on filesystem
pinning.  It probably makes more sense to think of adding LoadPin
support to Loadpol, rather than augmenting LoadPin to support the
Loadpol concepts, but for consistency with upstream we probably need
to speak in terms of the latter.

> CC-ing Kees Cook as he is the maintainer of the LoadPin module, he may ha=
ve
> opinions on what features may or may not fit inside LoadPin.

Of course, the combination, or not, of LoadPin and Loadpol is really
up to the two of you.

> As for other LSMs, I don't really see one that tries to provide similar
> features, but I someone is open to extending an existing LSM for that, I
> would be happy to help.

I think LoadPin is the obvious choice.

--=20
paul-moore.com

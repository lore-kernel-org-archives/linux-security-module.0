Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6C154425
	for <linux-security-module@vger.kernel.org>; Fri, 20 Sep 2024 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837336; cv=none; b=pliQ+F/hp4MjyUXkz9MV76wfyEPLyapu6cLZz0LfeZP2574P4FOOnniTOZr9gNkJ3WJ57aU1gQheAJgfxL/gEhq15+pf7wipw14BpBl1BkLshpmC4u0K0LmLyOtFKU3KK6WLfRhsVyFPx4YmYdq9yC3WoYk97xyqIMlOQe9VA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837336; c=relaxed/simple;
	bh=VNs2/LV5lSJa91PWHSWfZ1yY6E/bluzT/vlfcXMsZMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEfW7eHrrMtsL9hdtopQZMwtnRMknBVKASN99i/Y0jH7lYAdy3JH7rKA2CqwLzMd36RDDA5FBAh5ZUcLlvh/sfvlMUs8+CZZLdV2gsKFHdTaIOfcB4ccGRv0vpJBxDbq6jWKIJDNMiCEULMysXWBj/UVhREYO4ZW/ksP/pGjMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 9112F7E6; Fri, 20 Sep 2024 08:02:05 -0500 (CDT)
Date: Fri, 20 Sep 2024 08:02:05 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, wufan@linux.microsoft.com,
	paul@paul-moore.com
Subject: Re: [PATCH v2] ipe: allow secondary and platform keyrings to
 install/update policies
Message-ID: <20240920130205.GB532438@mail.hallyn.com>
References: <20240913234840.1318655-1-luca.boccassi@gmail.com>
 <20240915091119.1916049-1-luca.boccassi@gmail.com>
 <20240920020217.GA528455@mail.hallyn.com>
 <CAMw=ZnTWHkOnz5ZHg69WAfygkvpiHkSsUyHVu2fbqJ_E9inNUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnTWHkOnz5ZHg69WAfygkvpiHkSsUyHVu2fbqJ_E9inNUw@mail.gmail.com>

On Fri, Sep 20, 2024 at 09:54:06AM +0200, Luca Boccassi wrote:
> On Fri, 20 Sept 2024 at 04:02, Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Sun, Sep 15, 2024 at 11:11:19AM +0200, luca.boccassi@gmail.com wrote:
> > > From: Luca Boccassi <bluca@debian.org>
> > >
> > > The current policy management makes it impossible to use IPE
> > > in a general purpose distribution. In such cases the users are not
> > > building the kernel, the distribution is, and access to the private
> > > key included in the trusted keyring is, for obvious reason, not
> > > available.
> > > This means that users have no way to enable IPE, since there will
> > > be no built-in generic policy, and no access to the key to sign
> > > updates validated by the trusted keyring.
> > >
> > > Just as we do for dm-verity, kernel modules and more, allow the
> > > secondary and platform keyrings to also validate policies. This
> > > allows users enrolling their own keys in UEFI db or MOK to also
> > > sign policies, and enroll them. This makes it sensible to enable
> > > IPE in general purpose distributions, as it becomes usable by
> > > any user wishing to do so. Keys in these keyrings can already
> > > load kernels and kernel modules, so there is no security
> > > downgrade.
> > >
> > > Add a kconfig each, like dm-verity does, but default to enabled if
> > > the dependencies are available.
> > >
> > > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > > ---
> > > v2: add Kconfig entries following the dm-verity model
> > >     update documentation
> > >
> > >  Documentation/admin-guide/LSM/ipe.rst |  5 ++++-
> > >  security/ipe/Kconfig                  | 19 +++++++++++++++++++
> > >  security/ipe/policy.c                 | 14 +++++++++++++-
> > >  3 files changed, 36 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> > > index d8e7db857a2e..bf5aa97911e1 100644
> > > --- a/security/ipe/policy.c
> > > +++ b/security/ipe/policy.c
> > > @@ -169,9 +169,21 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
> > >                       goto err;
> > >               }
> > >
> > > -             rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len, NULL,
> > > +             rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
> > > +#ifdef CONFIG_IPE_POLICY_SIG_SECONDARY_KEYRING
> > > +                                         VERIFY_USE_SECONDARY_KEYRING,
> > > +#else
> > > +                                         NULL,
> > > +#endif
> > >                                           VERIFYING_UNSPECIFIED_SIGNATURE,
> > >                                           set_pkcs7_data, new);
> > > +#ifdef CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING
> > > +             if (rc == -ENOKEY)
> >
> > If the secondary key *is* there, but returns -EKEYREJECTED,
> > do you want to fall back to trying the platform keyring, or not?
> 
> I like the idea in principle, however for ease of use personally I'd
> prefer if the behaviour was the same as dm-verity, given the close
> relationship - maybe we can start with this version, then I can
> propose the same change in a single series for both components later,
> so that we either change it in both or neither. Would that work?

Sounds good, thanks.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

-serge

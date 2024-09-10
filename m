Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BA41F951;
	Tue, 10 Sep 2024 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002354; cv=none; b=rmA/7nxM6eEp77UTSao8XI2tG1g0Yv/xEApTqg6AiIm4z+UtZ0dVMKVJ5JqZ2Yowchp4IqaNX/DPqd3z3nYEj+bP0idFRQQGUiXV75LaJxPXi42m1wtMN3ADvBKsKuHIkJ9WVvV3z0Uze3zvqRlB+/otruS9P+X6WMFzTASmj5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002354; c=relaxed/simple;
	bh=OMHnu8aQPOtR0cyNILRJoVgVHNfpmU47wWmXw5mum3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9sy60z6vTVnCuGH+38EdpFmBFhD+zKcnt29DCzyM4JijVBEbXZ6Hi877dCYnGoHik+/JhadwV6+vKP3IKXeXiAnncb4AZYSbPyVJ4zIjqpKxbsesV55v152+MUmM+S24WPtp4CVR5hJljW672Iq8oxE16nIrD5LkTm0E2l8UBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 6C88F45D; Tue, 10 Sep 2024 15:57:44 -0500 (CDT)
Date: Tue, 10 Sep 2024 15:57:44 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: John Johansen <john.johansen@canonical.com>
Cc: Shen Lichuan <shenlichuan@vivo.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] security/apparmor: remove duplicate unpacking in
 unpack_perm function
Message-ID: <20240910205744.GA314978@mail.hallyn.com>
References: <20240821072238.3028-1-shenlichuan@vivo.com>
 <46fc455c-385c-44fb-b194-0fd046f6d21c@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46fc455c-385c-44fb-b194-0fd046f6d21c@canonical.com>

On Mon, Sep 09, 2024 at 11:57:05PM -0700, John Johansen wrote:
> On 8/21/24 00:22, Shen Lichuan wrote:
> > The code was unpacking the 'allow' parameter twice.
> > This change removes the duplicate part.
> > 
> > Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> 
> NAK, this would break the unpack. The first entry is actually a reserved
> value and is just being thrown away atm. Instead of double unpacking to
> perms->allow we could unpack it to a temp variable that just gets discarded

Heh, I recon this should probably be documented in a comment? :)
> 
> 
> > ---
> >   security/apparmor/policy_unpack.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> > index 5a570235427d..4ec1e1251012 100644
> > --- a/security/apparmor/policy_unpack.c
> > +++ b/security/apparmor/policy_unpack.c
> > @@ -649,7 +649,6 @@ static bool unpack_perm(struct aa_ext *e, u32 version, struct aa_perms *perm)
> >   		return false;
> >   	return	aa_unpack_u32(e, &perm->allow, NULL) &&
> > -		aa_unpack_u32(e, &perm->allow, NULL) &&
> >   		aa_unpack_u32(e, &perm->deny, NULL) &&
> >   		aa_unpack_u32(e, &perm->subtree, NULL) &&
> >   		aa_unpack_u32(e, &perm->cond, NULL) &&
> 

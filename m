Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075234DA13
	for <linux-security-module@vger.kernel.org>; Fri, 13 Sep 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240050; cv=none; b=OBIlIaF+OYAgSoD4tKarm+pVbqLPLxk5P0TeG8HqlyIhQDKbhRhR2o3BcVl1JrNYKrW8EfPITfYNZTAXe55LXdEftKAJwHoc8OBLWv433XsMXeMnyNw/c+NaPMxJIdLVHoe1AybkZefUIKQQ2SvUU4n++Hs3tuj9oOTkTcbYIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240050; c=relaxed/simple;
	bh=cmyPrDrB5sBoyGmhjgq4CBow66NRpnyNWQxaQDbcWuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu2ToxCykhMFHPMPmJJ6CnAEqtpVRf4WbmhUXKP7NZ0mqKekUgkRBkOBxQTO64tbPMW5QyP7l1BV3+Sb45vnlwAGtx5RJUHbw53SOz6rf/wAhc77yp1V5Y3Ktty0XjGSBaX8AFMA2U/fXZUBiGcPyKih+nmZ4nxfaWkbOspCOdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=n41gkKPK; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="n41gkKPK"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X4yMw18YkzZ2q;
	Fri, 13 Sep 2024 17:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1726240044;
	bh=yJEYA81fFdrITrRQC81yl3Svf42k+hGWlzN8CZnSJ7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n41gkKPKsPRtzPxlw4+jdKDFD+RdlNFs8nY5ApDPu0wfjAZLV4XXXGntH5uHg+Jnr
	 qx7w+sYf2M0Xeem/ah5zfGxd84rA7dPzFMymfTxLQvpw23SawBrnnr2JjG3iLAfUI7
	 l6yTxYTHw6oDCvpy/tVlSZ08T4T4aBMEflkV0t5s=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4X4yMv4Nq7zZQm;
	Fri, 13 Sep 2024 17:07:23 +0200 (CEST)
Date: Fri, 13 Sep 2024 17:07:16 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 6/6] landlock: Document LANDLOCK_SCOPED_SIGNAL
Message-ID: <20240913.Peiy9EighahZ@digikod.net>
References: <cover.1725657727.git.fahimitahera@gmail.com>
 <dae0dbe1a78be2ce5506b90fc4ffd12c82fa1061.1725657728.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dae0dbe1a78be2ce5506b90fc4ffd12c82fa1061.1725657728.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Sep 06, 2024 at 03:30:08PM -0600, Tahera Fahimi wrote:
> Improving Landlock ABI version 6 to support signal scoping with
> LANDLOCK_SCOPED_SIGNAL.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
> v3:
> - update date
> ---
>  Documentation/userspace-api/landlock.rst | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index c3b87755e98d..c694e9fe36fc 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -82,7 +82,8 @@ to be explicit about the denied-by-default access rights.
>              LANDLOCK_ACCESS_NET_BIND_TCP |
>              LANDLOCK_ACCESS_NET_CONNECT_TCP,
>          .scoped =
> -            LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
> +            LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET |
> +            LANDLOCK_SCOPED_SIGNAL,
>      };
>  
>  Because we may not know on which kernel version an application will be
> @@ -123,7 +124,8 @@ version, and only use the available subset of access rights:
>          ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
>      case 5:
>          /* Removes LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET for ABI < 6 */
> -        ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
> +        ruleset_attr.scoped &= ~(LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET |
> +                                 LANDLOCK_SCOPED_SIGNAL);
>      }
>  
>  This enables to create an inclusive ruleset that will contain our rules.
> @@ -320,11 +322,15 @@ explicitly scoped for a set of actions by specifying it on a ruleset.
>  For example, if a sandboxed process should not be able to
>  :manpage:`connect(2)` to a non-sandboxed process through abstract
>  :manpage:`unix(7)` sockets, we can specify such restriction with
> -``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``.
> +``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``. Moreover, if a sandboxed
> +process should not be able to send a signal to a non-sandboxed process,
> +we can specify this restriction with ``LANDLOCK_SCOPED_SIGNAL``.
>  
>  A sandboxed process can connect to a non-sandboxed process when its
>  domain is not scoped. If a process's domain is scoped, it can only
>  connect to sockets created by processes in the same scoped domain.
> +Moreover, If a process is scoped to send signal to a non-scoped process,
> +it can only send signals to processes in the same scoped domain.
>  
>  A connected datagram socket behaves like a stream socket when its domain
>  is scoped, meaning if the domain is scoped after the socket is connected
> @@ -575,12 +581,14 @@ earlier ABI.
>  Starting with the Landlock ABI version 5, it is possible to restrict the use of
>  :manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right.
>  
> -Abstract UNIX sockets Restriction  (ABI < 6)
> ---------------------------------------------
> +Abstract Unix sockets and Signal Restriction  (ABI < 6)
> +-------------------------------------------------------

I created a dedicated section instead of merging both.

>  
> +<<<<<<< current

I fixed that.

>  With ABI version 6, it is possible to restrict connection to an abstract
> -Unix socket through ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``, thanks to
> -the ``scoped`` ruleset attribute.
> +:manpage:`unix(7)` socket through
> +``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET`` and sending signal through
> +``LANDLOCK_SCOPED_SIGNAL``, thanks to the ``scoped`` ruleset attribute.

I cleaned up this fix that should be part of the other series.

>  
>  .. _kernel_support:
>  
> -- 
> 2.34.1
> 
> 

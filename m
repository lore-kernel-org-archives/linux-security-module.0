Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA5288C20
	for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766528569; cv=none; b=AL/4ZIngvBMw8LyTFtzSd4IHna7+exTyPABK9eYaaUaSJgjjbqlyibzNwUKlKdbOVkkzkBXqSMVuWlIg5RP1zioD0qbMBl+GN/vSzkScFL8Rx37GjMO8pOTGzM6PTTlIpDEOtNpAW0ZxCglpKXN0QCiy3MeQk7haRiiuBvnU4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766528569; c=relaxed/simple;
	bh=5ChQaMmlLX9hovDQcQS7g7uNbKQo9JZDx5A4s1IgkMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGnd0AT3y8Z2xGwVepAif3yIVtN/0aSjTHE2WcOX+yayMA/23KUrg38DqoZNLcP5eOJpPtkp56lHee3UDVAKPYLdbKSWKHcdK+V3n6pm2+/OcgbyCxFcMn+dyjMCQq/imgmZaGiD2ke/a6tZ0yjko+DIX/lWWU99rgpnRm7mBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+mClDG6; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+mClDG6"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64b7b737eddso6392483a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 14:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766528566; x=1767133366; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iBMOlYcIyEYU1W9+lfG5Pu7Sgvidu33OsXznw6P67hw=;
        b=c+mClDG6BgnA5HJhpxDXNDRLUriy4UPs+XOeTgc4JfFL4hsvlvsQH4T+uq6BccX1a+
         xlp5UTqF4F7wIdscS3ced5D8X3w3ZUKe3L9puRYqR+NOJK7mAaB46FcRV5+Vb2S58+YM
         hf1ZIUz3KonOi31oCvcSj8daERapBJ5hyyv2xmSMJUQypNTV2f4Cl849gGJGTfs5u05/
         d3TWQxzWqWxbSFLpfsRyFG7Rs1v2HKMM4CiXkwyuxsATFzipK/0WA0XTzniKjdI2l+xv
         kcdjX+xNhSPiyn8N7XwgqqGnwO6iqlEQs6ETy/eMjthDmZeEeGwS/0kb+vz0UjaYvS2C
         7Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766528566; x=1767133366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBMOlYcIyEYU1W9+lfG5Pu7Sgvidu33OsXznw6P67hw=;
        b=VjNtFwdTklUEV/Pb02CUqoDgmvGlHXtg4dVBX8oR/b/soM4H4s6FkRtWr7W9vv6FjF
         QcHsGKHMuaqZSvlDnhXEomSosnMQKqn7NE2d8Lg7in2FbwhRKPq7d5M/PCoJqh+ONH/a
         DqsGVgU4jPGsfr5CXFLGkrz+11U1LjLUQlYxIT91IL7uKAUH+tTttuIHvQfdlHcZakLy
         GsEe9rWPt6AJfwc+DR59H/LpRv7drj+NLNMdneTgaNqN1wRvHQOonobvURQbjnf4FVQO
         ScjAvMlU/nrl3TFoQolVvyZSRMPiWcd1Onof12kmyhWvFk+rDL2Yv62vZt1T0lp2TiDh
         4hAg==
X-Forwarded-Encrypted: i=1; AJvYcCXqJNQTJMw7QTUkPm6n3eVVQCYJvW4RzAvsybuWIWau3OvPlWvKIxbe7nAeH+z1wXKHkglUN1bvN4oWI3owpKpFhEcC7NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzktt5+LGgf6Oxq6OhND73qZELkjjGEOppw6kNjK2eSzu4PZcem
	jhxSRhCYQo2DcCKL5zLnbvggyWkN6t3izKDhrSCfKC7xX3aplozk6tzVFdKLvas3
X-Gm-Gg: AY/fxX7Lzy4szEU96bhOETdMAoOE+SUdiHMb/s6gEadZKrvTE+4SZFROrUVklMGce/Q
	ybyQWK0F+bcvQpAXOkJAU/xOIA/2VAMwqEqtAMbqAZcXFUfcSkR6wPMNVNGikbBJFP7kIOfRuv6
	zT5WZ0Y9vQ1xq62AazUpydr/kRW7EU2stiFfOPzFEooHMX3GYzZb1rNcqVGaRSIqzqqoo3YbcA6
	1ILlUU8JyeyZwA7Dvd1KwO46UcO2W9nJk2f2evm52dsVP10KJwgVMzODzg/fmFj8Y/+Z/rSJRf3
	rDcBRLTSFIVDxniZzmn88xhQCcYHWSlC9C4N3aH4sAMA5Ybcrip/wNEBPOjvsA5elOfxbq6CbBy
	UvRDXYpdclxBgIHrbV05V4WlDJki28W2CBgGwVVdsqoOM+0BExL2LY8lYyK6/QF0HDH3MGM2GZ4
	d2ub0IbOzune1jHhqYq5WSAkQyRckFHfgfEwVVfSv1mPuXV6U=
X-Google-Smtp-Source: AGHT+IGDTgKeYbah8CnZhxEa5ijteR0IOBgOtlvgWqYeilAtsx0/MuuxhMjQU3xAGfGN1O1cNLclBg==
X-Received: by 2002:a17:906:5a6c:b0:b80:4158:d9c2 with SMTP id a640c23a62f3a-b804158e0f4mr916256266b.1.1766528565609;
        Tue, 23 Dec 2025 14:22:45 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de004fsm1563497566b.45.2025.12.23.14.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 14:22:45 -0800 (PST)
Date: Tue, 23 Dec 2025 23:22:36 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: mic@digikod.net, gnoack@google.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] landlock: Add missing ABI 7 case in documentation
 example
Message-ID: <20251223.69fdc8e48fce@gnoack.org>
References: <20251216210248.4150777-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251216210248.4150777-1-samasth.norway.ananda@oracle.com>

Hello!

On Tue, Dec 16, 2025 at 01:02:42PM -0800, Samasth Norway Ananda wrote:
> Add the missing case 6 and case 7 handling in the ABI version
> compatibility example to properly handle LANDLOCK_RESTRICT_SELF_LOG_*
> flags for kernels with ABI < 7.
> 
> This introduces the supported_restrict_flags variable which is
> initialized with LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON, removed
> in case 6 for ABI < 7, and passed to landlock_restrict_self() to
> enable logging on supported kernels.
> 
> Also fix misleading description of the /usr rule which incorrectly
> stated it "only allow[s] reading" when the code actually allows both
> reading and executing (LANDLOCK_ACCESS_FS_EXECUTE is included in
> allowed_access).
> 
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

Thank you for sending a patch, much appreciated!

You are right to point this out - the logging aspect is a bit hard to
spot when reading the current documentation starting from the code
example.


> ---
>  Documentation/userspace-api/landlock.rst | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 1d0c2c15c22e..b8caac299056 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -97,6 +97,8 @@ version, and only use the available subset of access rights:
>  .. code-block:: c
>  
>      int abi;
> +    /* Tracks which landlock_restrict_self() flags are supported */
> +    int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;

This might be confusing, as there are actually more supported flags:
ABI v7 does not only introduce LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON,
but also LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF and
LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF.

I am unconvinced whether it is a good idea to set these flags in the
first example that we have in the documentation, especially if we
don't discuss what these flags do there.  If we suggest the wrong
default flags in the example, people might use them in their
production code without realizing what they do.  The way that the
logging flags are designed, the assumption was that most users should
be able to pass 0 as flags to landlock_restrict_self() and still get
the relevant parts of the audit logging.

But you are right that an implementation that *does pass* logging
flags will want check the ABI and not pass them on older kernels.

To throw in a constructive suggestion: we could also have "backwards
compatibility for restrict flags" section between the existing case
analysis and the landlock_restrict_self() call?  It could then say
something like

    When passing a non-zero `flags` argument to
    landlock_restrict_self(), the following backwards compatibility
    check needs to be taken into account:

      /*
       * Desired restriction flags, see section suchandsuch.
       * This value is only an example and differs by use case.
       */
      int restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
      if (abi < 7) {
        /* clear the necessary bits */
        restrict_flags &= ~...;
      }

Readers who do not need to pass any flags could then skip over that
section (I assume these are most readers).  The readers who *do* want
to pass flags could merge that logic into the bigger case analysis
themselves, but for the sake of explaining it we would not mix up that
explanation with the access right discussion that much.

WDYT?

>      abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
>      if (abi < 0) {
> @@ -127,6 +129,17 @@ version, and only use the available subset of access rights:
>          /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
>          ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>                                   LANDLOCK_SCOPE_SIGNAL);
> +        __attribute__((fallthrough));
> +    case 6:
> +        /*
> +         * Removes LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON for ABI < 7.
> +         * Note: This modifies supported_restrict_flags, not ruleset_attr,
> +         * because logging flags are passed to landlock_restrict_self().
> +         */
> +        supported_restrict_flags &= ~LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;

If this should be a generic example, we would have to clear the other
two flags here as well.

> +        __attribute__((fallthrough));
> +    case 7:
> +        break;
>      }

Thanks,
–Günther

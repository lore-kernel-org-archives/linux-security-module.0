Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17584404
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620958; cv=none; b=QpMbJaunxPTcETjxbH2sZinR880aexg215fFIjzRxgkmb4yDD8/eE0fMW16JM21LqyfhIuHxXAo/3WZKIWgGB0xTZrX5vkoMZiZ65T85gwidEWl5++dPBBzv4TZBoxe2Xu0xq+hTuXo2M/w9QI7wXUmtXFBB1IjGUwCICnBmBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620958; c=relaxed/simple;
	bh=Cx08lAs8hI47vY+6JdEcUHp2W4EF/jxRJShIf/c5jEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SifNrZk+HYB8XJ2ipgGbPi5ioPiU9lSIvcTXlFheaSUgaTBaG9aw6RetxzycDOrLGu7kKx9L7uQvnNnTaJ51erUn3qqdMoJWL3N4lzhBCaPkbSN56XbKCSScxhb8uApmroqRkEnl3CAq93J3yDqkJfZWEF9owPccbAks6O1ZUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=gjdxIx6M; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gjdxIx6M"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WK0JS0zxmzq9p;
	Wed, 10 Jul 2024 16:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720620952;
	bh=1Ja4Ry3s/1uPbtAKCRTvijqwopMM9i9J+iYBmJTuX98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjdxIx6Mw03JmhBCaNxvYn/HKI4msSGlzdOPgOPVD8npr5/atK8+Fj75oj0RpEq0Q
	 nzhmTjo6Wl/+a8iofkP6mKxefZZUpN/qtTUOAMMvmf2PxKv0JY1fO4d6l2wQdXGSXI
	 plwBVN9PQoMNPGvkTlHs31ubj2b+Pw3f6b5Vxsvs=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WK0JR1qvtzbjF;
	Wed, 10 Jul 2024 16:15:51 +0200 (CEST)
Date: Wed, 10 Jul 2024 16:15:47 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	Matt Bobrowski <repnop@google.com>, Alejandro Colomar <alx@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH] landlock: Clarify documentation for struct
 landlock_ruleset_attr
Message-ID: <20240710.te8ceiPhav6e@digikod.net>
References: <20240710120134.1926158-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710120134.1926158-1-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 10, 2024 at 12:01:34PM +0000, Günther Noack wrote:
> The explanation for @handled_access_fs and @handled_access_net has
> significant overlap and is better explained together.  I tried to clarify
> the wording and break up longer sentences as well.  I am putting emphasis
> on the word "handled" to make it clearer that "handled" is a term with
> special meaning in the context of Landlock.
> 
> I'd like to transfer this wording into the man pages as well.

Thanks for working on this.

> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> Cc: Alejandro Colomar <alx@kernel.org>
> Cc: Mickaël Salaün <mic@digikod.net>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: linux-security-module@vger.kernel.org
> ---
>  include/uapi/linux/landlock.h | 42 ++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 68625e728f43..6f1b05c6995b 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -12,30 +12,32 @@
>  #include <linux/types.h>
>  
>  /**
> - * struct landlock_ruleset_attr - Ruleset definition
> + * struct landlock_ruleset_attr - Ruleset definition.
>   *
> - * Argument of sys_landlock_create_ruleset().  This structure can grow in
> - * future versions.
> + * @handled_access_fs: Bitmask of handled filesystem actions (cf. `Filesystem flags`_)
> + * @handled_access_net: Bitmask of handled network actions (cf. `Network flags`_)

These @handled_* lines should be kept close the the related fields to
ease maintenance and consistency.  It looks like the Sphinx rendering
would be the same.

> + *
> + * Argument of sys_landlock_create_ruleset().
> + *
> + * This struct defines a set of *handled access rights*, a set of actions on
> + * different object types, which should be denied by default when the ruleset is

> + * enacted.  Vice versa, access rights that are not specifically listed here are
> + * going to be allowed when the ruleset is enacted.

They could still be denied because of other access controls or parent
Landlock domains.

> + *
> + * One exception is the %LANDLOCK_ACCESS_FS_REFER access right, which is always
> + * implicitly *handled*, even when its bit is not set in @handled_access_fs.

I wrote this sentence but I now think it might be confusing.
LANDLOCK_ACCESS_FS_REFER couldn't be handled before it was introduced
(with Linux 5.19).  I couldn't find a better way to explain it though.

> + * However, in order to add new rules with this access right, the bit must still
> + * be set explicitly.
> + *
> + * The explicit listing of *handled access rights* is required for backwards
> + * compatibility reasons.  In most use cases, processes that use Landlock will
> + * *handle* a wide range or all access rights that they know about at build
> + * time.

...and that they tested with a kernel supporting all of them.

> + *
> + * This structure can grow in future Landlock versions.
>   */
>  struct landlock_ruleset_attr {
> -	/**
> -	 * @handled_access_fs: Bitmask of actions (cf. `Filesystem flags`_)
> -	 * that is handled by this ruleset and should then be forbidden if no
> -	 * rule explicitly allow them: it is a deny-by-default list that should
> -	 * contain as much Landlock access rights as possible. Indeed, all
> -	 * Landlock filesystem access rights that are not part of
> -	 * handled_access_fs are allowed.  This is needed for backward
> -	 * compatibility reasons.  One exception is the
> -	 * %LANDLOCK_ACCESS_FS_REFER access right, which is always implicitly
> -	 * handled, but must still be explicitly handled to add new rules with
> -	 * this access right.
> -	 */
>  	__u64 handled_access_fs;
> -	/**
> -	 * @handled_access_net: Bitmask of actions (cf. `Network flags`_)
> -	 * that is handled by this ruleset and should then be forbidden if no
> -	 * rule explicitly allow them.
> -	 */
>  	__u64 handled_access_net;
>  };
>  
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 
> 

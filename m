Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0753C1D62
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506768; cv=none; b=eyHW6pPn4j032uhmR2ezOa168qKkJGpQfxQEKISxkYGplq4k7mLNZcS+A7IojBKGFZP8+w4uJrW3cwKVuO+SG+XMy2O/4OSPUHw1cvhiUa2dBH7dEP9zBKeBiq9tQ7a1Z3dSr4F1X+mMsWfCLTzNtyMtxqPVW45kjDNmpJfE8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506768; c=relaxed/simple;
	bh=pebaoiBiCd33GUlPvHrLOPVR4lgaG05Z1buSB4jp1pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhvJ77yQQdEmlmdYUTgyUM0B2hO9LoVEJtIRmYTyRYrZR8aEMLZecqyLKlIUNuGjenyeE1HJkrp1AzOGm0Bn1QgTUoqHu5VlnlZNi9F676fqXTaXwZenyP5wyVZXMyCkt8OwQ6AozfpVpzdJXvCfAXgGsqXFMHKASckBJTUzWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wNmTqM/g; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wNmTqM/g"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1c4db7ca93so132172766b.2
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785506765; x=1786111565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cvTAQkXD8rzCP5UeO5VRYWhOmmqEa4G5VYy1rQGI2wo=;
        b=wNmTqM/gW6Qlmzvj3BYJ4Cfks9OAOe20AP+3QATZvBvhJoBKufP8aHa1zb++JcoldH
         NHTC3QTDvY5cwZdi5UUZXkUvQNsBBX/5VQrHarf2Lc17ipY6H3f9C4O6YTDcY3BLyx1P
         tWLRE3nTINTz67O5kOqRcUMHCSXo65ddgWFlILDsya6JNbvkpHQrVYBXY2RbwOKwNVJf
         zIsyBnCNts+GQEgU5UpQO+e3LTxooqE9UJC0mzCq/jHAmMpwBosemGcyuqY3WZikUSAL
         bemZqC8F6j+8HxyxWyrXmthZG48oRrlf0fGp6kuw2y5WP1Crv2ngqFl1quD4HkF4DV65
         DEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785506765; x=1786111565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cvTAQkXD8rzCP5UeO5VRYWhOmmqEa4G5VYy1rQGI2wo=;
        b=AMzSegHoQ26I8rHC5XlTQ794AeT6JkU5qtdT/hR/fPtH256oV08+9C87WpPFK4m0cG
         2BS/GoHdmHnoJmphPHLCY1jfhl3in7DBV04vu+3Y3dPa25J9XMuOPYYMAYZ8KoVt661e
         P6jN7dxFAgV9wQgloj1y6/DINA5o1A0IOaVEEJZKURsVtEJSQiOY8M5vP7XjRTpLJvrM
         /bA7THoHxiUTCiBEl6FjW3MPOkF4VR+WUrel4fFZtIz9XNn649hh4+MrGD61Vm56T273
         S15a5KboHH9s2grrCI7TaIAw6NC+y9Uk8G4kQZjXkc6UyL4q0AdtaQVtPREW0lR344JL
         I0og==
X-Forwarded-Encrypted: i=1; AHgh+Rra5Ot/lVsZU3qGUTifpZApzFq3C0ZaYJWEhFg6wzAz2CtjfzxIX5GZ9WsvMClTvZFevJCFAH+zoNfBjneHbhvX7p+baYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7iokbObK6NcdWnAblTFlzcDkbbS/zJ3T0CEvGjzRCi+U6/uW0
	FBYEacfM48Ler8oD5aH/wu955UaYwNOwABn8WV+0pWOC+J6DJOqk1saJKEI+OaOD0g==
X-Gm-Gg: AR+sD12VKVZOlRvfxQgIOlF/QpcioDMQ2dAPmzSolRShYErNvoNpVSsEoWW6lvpphX2
	I8tqqYd84A145cQhz3FDjNB6ZLaOtCy4NTE5zU9NU8tIZptemCMRwQSPRpzPPXGp/YgSN8Rytoc
	sSKlLEhonpfk+zo4pOjMnFc9E+d4W4gsL8PfDPmZ8gQQm6IfyX3Uyd3IvD7k+fi5Q26gcBF30gZ
	ZBUg0Sjvtb7ZqCea5kTIVWGEH6CcC5wFcwH9VDAOolMkFXWP7qQMZl9fEXwT7BkIoVFuyz1e2ro
	IY/+id+J0LuL2Ra+csygCl+9VWnaNWTWz4J0I/1iA0YLnO6+G2qZAfhS0Rgpdwi/D1/QMoEXB8T
	Fk/+cdGsOGLxfhjdc7GNtoogK+2ZwBX0JjM+xIMGr4Fh5ZEmMBz1nQek5zWp/d4Ll4vGk9HCNd/
	xsM67i7FJjoiatpGRvAUhFSmiVKohkAybvR4GX7QqOy5D41hKIlJWZ4+LA+T5KPEjTTyQ5qWvvT
	6Ln+9G6RhbDjwuTFS8=
X-Received: by 2002:a17:907:c305:b0:c1c:22d4:3a9b with SMTP id a640c23a62f3a-c1fd22fb661mr135911266b.43.1785506763877;
        Fri, 31 Jul 2026 07:06:03 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:3ba9:7454:5ca0:a791])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3cc3b64sm154431066b.27.2026.07.31.07.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:06:03 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:05:57 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 2/5] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
 whiteout creation
Message-ID: <amyrxQmn9mTdkhQg@google.com>
References: <20260724161004.2360749-1-gnoack@google.com>
 <20260724161004.2360749-3-gnoack@google.com>
 <20260731.xieh7eiR8ooD@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731.xieh7eiR8ooD@digikod.net>

On Fri, Jul 31, 2026 at 03:13:24PM +0200, Mickaël Salaün wrote:
> On Fri, Jul 24, 2026 at 06:10:01PM +0200, Günther Noack wrote:
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Suggested-by: Mickaël Salaün <mic@digikod.net>
> 
> Cc: stable@vger.kernel.org
> 
> > Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
> 
> Depends-on: 49c9e09d9610 ("landlock: Fix handling of disconnected directories")
> Depends-on: fe72ce6710cb ("landlock: Add errata documentation section")
> 
> > Signed-off-by: Günther Noack <gnoack@google.com>
> > ---
> >  include/uapi/linux/landlock.h    |  1 +
> >  security/landlock/errata/abi-1.h | 26 ++++++++++++++++++++++++++
> >  security/landlock/fs.c           | 31 ++++++++++++++++++++++++-------
> >  3 files changed, 51 insertions(+), 7 deletions(-)

Thanks, applying this to the next version.

—Günther

From: joe@perches.com (Joe Perches)
Date: Wed, 13 Jun 2018 16:49:47 -0700
Subject: [-next PATCH] security: use octal not symbolic permissions
In-Reply-To: <20180613151921.GA27375@mail.hallyn.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
	<20180613151921.GA27375@mail.hallyn.com>
Message-ID: <85d6e86b7829b42e69feab8e8dbe93a30b5fa4f1.camel@perches.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-06-13 at 10:19 -0500, Serge E. Hallyn wrote:
> Using octal and not symbolic permissions is preferred by many as more
> > readable.
> > 
> > see: https://lkml.org/lkml/2016/8/2/1945
> 
> Heh, well see also https://lkml.org/lkml/2016/8/2/2062 .

We all love Al.

I did reply then too.

cheers, Joe

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

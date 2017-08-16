From: ebiggers3@gmail.com (Eric Biggers)
Date: Tue, 15 Aug 2017 19:52:44 -0700
Subject: [PATCH] KEYS: remove CONFIG_KEYS_COMPAT
In-Reply-To: <7704.1498555674@warthog.procyon.org.uk>
References: <20170613060925.17121-1-ebiggers3@gmail.com>
	<7704.1498555674@warthog.procyon.org.uk>
Message-ID: <20170816025244.GA1417@zzz.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 27, 2017 at 10:27:54AM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> > index a7a23b5541f8..f5d96996baa6 100644
> > --- a/security/keys/Kconfig
> > +++ b/security/keys/Kconfig
> > @@ -20,10 +20,6 @@ config KEYS
> >  
> >  	  If you are unsure as to whether this is required, answer N.
> >  
> > -config KEYS_COMPAT
> > -	def_bool y
> > -	depends on COMPAT && KEYS
> > -
> >  config PERSISTENT_KEYRINGS
> >  	bool "Enable register of persistent per-UID keyrings"
> >  	depends on KEYS
> 
> Hmmm...  This is in linus/master, but not in security/next.  I'll hold your
> patch till later in the merge window or just after -rc1.
> 
> David

Hi David, are you still planning to apply this patch?

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

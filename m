From: ebiggers3@gmail.com (Eric Biggers)
Date: Fri, 24 Nov 2017 12:37:50 -0800
Subject: [PATCH] KEYS: remove unnecessary get/put of explicit dest_keyring
In-Reply-To: <23022.1511538725@warthog.procyon.org.uk>
References: <20171120225757.96498-1-ebiggers3@gmail.com>
	<23022.1511538725@warthog.procyon.org.uk>
Message-ID: <20171124203750.GA559@zzz.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Nov 24, 2017 at 03:52:05PM +0000, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > -			construct_get_dest_keyring(&dest_keyring);
> 
> This will break.  construct_get_dest_keyring() does other things than just
> getting a ref on whatever dest_keyring points to.
> 

Not if dest_keyring is non-NULL (i.e. explicitly specified), which it is in this
case.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

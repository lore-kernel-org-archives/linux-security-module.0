From: dhowells@redhat.com (David Howells)
Date: Fri, 24 Nov 2017 21:18:16 +0000
Subject: [PATCH] KEYS: remove unnecessary get/put of explicit dest_keyring
In-Reply-To: <20171124203750.GA559@zzz.localdomain>
References: <20171124203750.GA559@zzz.localdomain>
	<20171120225757.96498-1-ebiggers3@gmail.com>
	<23022.1511538725@warthog.procyon.org.uk>
Message-ID: <5478.1511558296@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> > > -			construct_get_dest_keyring(&dest_keyring);
> > 
> > This will break.  construct_get_dest_keyring() does other things than just
> > getting a ref on whatever dest_keyring points to.
> > 
> 
> Not if dest_keyring is non-NULL (i.e. explicitly specified), which it is in
> this case.

Actually, you're right.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

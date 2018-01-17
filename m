From: tytso@mit.edu (Theodore Ts'o)
Date: Wed, 17 Jan 2018 13:05:37 -0500
Subject: [PATCH 3/3] encrypted-keys: document new fscrypt key format
In-Reply-To: <1516199939.28972.101.camel@andred.net>
References: <20180110124418.24385-1-git@andred.net>
	<20180110124418.24385-3-git@andred.net>
	<20180111044801.GB943@zzz.localdomain>
	<1516199939.28972.101.camel@andred.net>
Message-ID: <20180117180537.GB6948@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jan 17, 2018 at 02:38:59PM +0000, Andr? Draszik wrote:
> > > [...]
> > 
> > Please be very clear about exactly what security properties are achieved
> > by
> > using encrypted-keys.
> 
> I've left out all of this in the updated documentation, as any such
> information should probably be in Documentation/security/keys/trusted-
> encrypted.rst in the first place.

Where is this document going to be found / when will it be written?
It seems really odd to be requesting a do code review when the
specifications aren't available and/or haven't been written yet.  I
prefer to review the *design* first, as opposed to trying to both
review the code and try to guess at the design and review my guess of
the design at the same time....

					- Ted
				
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

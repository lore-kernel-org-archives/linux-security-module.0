From: tytso@mit.edu (Theodore Ts'o)
Date: Tue, 31 Oct 2017 13:47:36 -0400
Subject: [PATCH v2] fscrypt: fix dereference of NULL user_key_payload
In-Reply-To: <20171029163246.GA566@zzz.localdomain>
References: <20171009194618.67494-1-ebiggers3@gmail.com>
	<20171029102305.4ifapjehlrgwsqmu@thunk.org>
	<20171029163246.GA566@zzz.localdomain>
Message-ID: <20171031174736.q5meeukzbrtcugp2@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Oct 29, 2017 at 09:32:46AM -0700, Eric Biggers wrote:
> 
> Hi Ted, you should drop this one, since it's already in mainline; David Howells
> ended up taking the original series via the keyrings tree.

Ah, I see it landed in v4.14-rc6.  I'll drop it from the fscrypt tree.

      	     	       		   	     - Ted
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

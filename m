From: dhowells@redhat.com (David Howells)
Date: Fri, 24 Nov 2017 21:24:30 +0000
Subject: [PATCH] KEYS: remove unnecessary get/put of explicit dest_keyring
In-Reply-To: <20171120225757.96498-1-ebiggers3@gmail.com>
References: <20171120225757.96498-1-ebiggers3@gmail.com>
Message-ID: <5687.1511558670@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

>  		if (dest_keyring) {
> -			construct_get_dest_keyring(&dest_keyring);

Actually, I think I have the order of these lines inverted.
construct_get_dest_keyring() can actually return without setting dest_keyring
to anything.  This didn't used to be the case, but now that the user-session
keyring is made lazily, there's no guaranteed fallback.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

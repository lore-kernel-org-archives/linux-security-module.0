From: dhowells@redhat.com (David Howells)
Date: Wed, 04 Oct 2017 15:34:30 +0100
Subject: [PATCH v3 1/7] KEYS: don't let add_key() update an uninstantiated
	key
In-Reply-To: <20170927195047.122358-2-ebiggers3@gmail.com>
References: <20170927195047.122358-2-ebiggers3@gmail.com>
	<20170927195047.122358-1-ebiggers3@gmail.com>
Message-ID: <3019.1507127670@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> +	if ((key->flags & ((1 << KEY_FLAG_INVALIDATED) |
> +			   (1 << KEY_FLAG_REVOKED) |
> +			   (1 << KEY_FLAG_INSTANTIATED))) !=
> +	    (1 << KEY_FLAG_INSTANTIATED)) {

Does this need READ_ONCE(), I wonder?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

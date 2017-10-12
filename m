From: dhowells@redhat.com (David Howells)
Date: Thu, 12 Oct 2017 16:27:07 +0100
Subject: [PATCH v3 1/7] KEYS: don't let add_key() update an uninstantiated
	key
In-Reply-To: <20170927195047.122358-2-ebiggers3@gmail.com>
References: <20170927195047.122358-2-ebiggers3@gmail.com>
	<20170927195047.122358-1-ebiggers3@gmail.com>
Message-ID: <22673.1507822027@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> Therefore, change find_key_to_update() to return NULL if the found key
> is uninstantiated, so that add_key() replaces the key rather than
> instantiating it.  This seems to be better than fixing __key_update() to
> call __key_instantiate_and_link(), since given all the bugs noted above
> as well as that the existing behavior was undocumented and
> keyctl_instantiate() is supposed to be used instead, I doubt anyone was
> relying on the existing behavior.

keyctl_instantiate() can only be called from an upcall.  It can't be called in
the same context as keyctl_update().

I would be okay with making key_update() wait for completion of construction
in this case.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: dhowells@redhat.com (David Howells)
Date: Mon, 08 May 2017 23:00:56 +0100
Subject: [PATCH] key: Convert big_key payload.data to struct
In-Reply-To: <20170508214324.GA124468@beast>
References: <20170508214324.GA124468@beast>
Message-ID: <10235.1494280856@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:

> There is a lot of needless casting happening in the big_key data payload.
> This is harder to trivially verify by static analysis and specifically
> the randstruct GCC plugin (which was unhappy about casting a struct
> path across two entries of a void * array). This converts the payload to
> the actually used structures (one pointer, one embedded struct, and one
> size_t).

I'd really rather not do this as this moves the definition of an individual
key type into the general structure (I know I've done this for the keyring
type, but that's a special part of the keyring code).  That's the start of the
slippery slope into moving all of them in there.

I'd rather you defined, say:

	struct big_key_payload {
		u8		*key_data;
		struct path	key_path;
		size_t		key_len;
	};

in big_key.c and cast &key->payload to it.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

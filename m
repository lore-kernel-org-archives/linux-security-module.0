From: keescook@chromium.org (Kees Cook)
Date: Mon, 8 May 2017 15:26:01 -0700
Subject: [PATCH] key: Convert big_key payload.data to struct
In-Reply-To: <10235.1494280856@warthog.procyon.org.uk>
References: <20170508214324.GA124468@beast>
	<10235.1494280856@warthog.procyon.org.uk>
Message-ID: <CAGXu5jLYLeYWm9GKMm2_5iT4PjaXCi5qsGnZQ2JqFT0DVvmYog@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, May 8, 2017 at 3:00 PM, David Howells <dhowells@redhat.com> wrote:
> Kees Cook <keescook@chromium.org> wrote:
>
>> There is a lot of needless casting happening in the big_key data payload.
>> This is harder to trivially verify by static analysis and specifically
>> the randstruct GCC plugin (which was unhappy about casting a struct
>> path across two entries of a void * array). This converts the payload to
>> the actually used structures (one pointer, one embedded struct, and one
>> size_t).
>
> I'd really rather not do this as this moves the definition of an individual
> key type into the general structure (I know I've done this for the keyring
> type, but that's a special part of the keyring code).  That's the start of the
> slippery slope into moving all of them in there.
>
> I'd rather you defined, say:
>
>         struct big_key_payload {
>                 u8              *key_data;
>                 struct path     key_path;
>                 size_t          key_len;
>         };
>
> in big_key.c and cast &key->payload to it.

This doesn't protect you against changes in struct path size,
though... the existing code (and this proposal) will break if that
ever happens...

What's the problem with defining the types at the top level? That
seems like a nice place to see them all at once.

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

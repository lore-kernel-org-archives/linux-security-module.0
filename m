From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Mon, 25 Sep 2017 18:38:13 +0200
Subject: [PATCH v7 2/2] security/keys: rewrite all of big_key crypto
In-Reply-To: <32200.1506350639@warthog.procyon.org.uk>
References: <20170920145839.27511-1-Jason@zx2c4.com>
	<20170920145839.27511-2-Jason@zx2c4.com>
	<32200.1506350639@warthog.procyon.org.uk>
Message-ID: <CAHmME9qUnYHYvgExmscQ91D-hsQApSk6FzmBG0cSUraLbQNYRQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 25, 2017 at 4:43 PM, David Howells <dhowells@redhat.com> wrote:
> Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
>> +     /* no ->update(); don't add it without changing big_key_crypt() nonce */
>
> Should update be a problem.  It's should be a complete payload replacement -
> kind of like unlink and add, but keeping the same key ID and description.

Not sure I parsed your message correctly, but that comment there was a
suggestion from Eric several months ago when I first posted it. The
idea is that the key shouldn't be reused with the same nonce, so in
case somebody ambitious comes along and tries to add an .update
function, they'll be reminded to take this into account. Alternatively
they might choose to just generate a new key, which is fine too.
Either way, it's a useful warning to have in place.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

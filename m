From: dhowells@redhat.com (David Howells)
Date: Tue, 19 Sep 2017 16:38:25 +0100
Subject: [PATCH v6] security/keys: rewrite all of big_key crypto
In-Reply-To: <20170917115217.15805-1-Jason@zx2c4.com>
References: <20170917115217.15805-1-Jason@zx2c4.com>
	<CAHmME9rjrz2Pn39ay3myApBeBtQAPNt0C+NvmFoV28NeT4_zLg@mail.gmail.com>
Message-ID: <27444.1505835505@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> And, some error paths forgot to zero out sensitive
> material, so this patch changes a kfree into a kzfree.

Can you split that out into a separate preparatory patch?

Also, I recommend limiting the lines in your patch description to 75 chars
lest you get people who run checkpatch on everything pestering you ;-)

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

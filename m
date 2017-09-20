From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Wed, 20 Sep 2017 16:56:06 +0200
Subject: [PATCH v6] security/keys: rewrite all of big_key crypto
In-Reply-To: <27444.1505835505@warthog.procyon.org.uk>
References: <CAHmME9rjrz2Pn39ay3myApBeBtQAPNt0C+NvmFoV28NeT4_zLg@mail.gmail.com>
	<20170917115217.15805-1-Jason@zx2c4.com>
	<27444.1505835505@warthog.procyon.org.uk>
Message-ID: <CAHmME9pSfXZC6QGsGs6Qax9q8QeKxGJSJonA8gXyYDqjvTRY=A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 19, 2017 at 5:38 PM, David Howells <dhowells@redhat.com> wrote:
> Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
>> And, some error paths forgot to zero out sensitive
>> material, so this patch changes a kfree into a kzfree.
>
> Can you split that out into a separate preparatory patch?
>
> Also, I recommend limiting the lines in your patch description to 75 chars
> lest you get people who run checkpatch on everything pestering you ;-)

No problem. Will split that out, then fix the description, and
resubmit as v7. Coming your way shortly.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

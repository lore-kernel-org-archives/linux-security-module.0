From: dhowells@redhat.com (David Howells)
Date: Tue, 19 Sep 2017 17:22:28 +0100
Subject: [PATCH] KEYS: fix race between updating and finding negative key
In-Reply-To: <20170918204808.119855-1-ebiggers3@gmail.com>
References: <20170918204808.119855-1-ebiggers3@gmail.com>
Message-ID: <31182.1505838148@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> Fix the bug by moving ->reject_error out of the union with ->payload,
> then using nonzero ->reject_error to mean that the key is negative.
> 
> This eliminates the need for KEY_FLAG_NEGATIVE, which we remove as well
> so that we don't have to handle memory ordering between
> KEY_FLAG_NEGATIVE and ->reject_error.  We *do* still need to handle
> memory ordering between KEY_FLAG_INSTANTIATED and ->reject_error, but
> that was needed before (and for KEY_FLAG_NEGATIVE as well --- though it
> wasn't done correctly, which was another bug).

Hmmm...  My only objection is that it extends struct key still further, but
you do have a point.

If we're going to do this, can we eliminate KEY_FLAG_INSTANTIATED also and
make ->reject_error into ->status?

	0	-> uninstantiated
	1	-> instantiated
	<0	-> negatively instantiated/rejected

Also, can we make it a short int please?

Also, can setting this field be done with a release barrier rather than a
write barrier?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

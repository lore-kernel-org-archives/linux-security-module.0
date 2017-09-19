From: dhowells@redhat.com (David Howells)
Date: Tue, 19 Sep 2017 16:46:08 +0100
Subject: [PATCH] KEYS: fix cred refcount leak in request_key_auth_new()
In-Reply-To: <20170918183331.113261-1-ebiggers3@gmail.com>
References: <20170918183331.113261-1-ebiggers3@gmail.com>
Message-ID: <28352.1505835968@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> In request_key_auth_new(), if alloc_key() or key_instantiate_and_link()
> were to fail, we would leak a reference to the 'struct cred'.  Currently
> this can only happen if alloc_key() fails to to allocate memory.  But it
> still should be fixed, as it is a more severe bug waiting to happen.

It might be better to combine request_key_auth_destroy() and the error path
that you're altering in request_key_auth_new() by pulling it into a separate
function.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: ebiggers3@gmail.com (Eric Biggers)
Date: Thu, 21 Sep 2017 13:37:43 -0700
Subject: [PATCH] KEYS: fix cred refcount leak in request_key_auth_new()
In-Reply-To: <28352.1505835968@warthog.procyon.org.uk>
References: <20170918183331.113261-1-ebiggers3@gmail.com>
	<28352.1505835968@warthog.procyon.org.uk>
Message-ID: <20170921203743.GA89627@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 19, 2017 at 04:46:08PM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > In request_key_auth_new(), if alloc_key() or key_instantiate_and_link()
> > were to fail, we would leak a reference to the 'struct cred'.  Currently
> > this can only happen if alloc_key() fails to to allocate memory.  But it
> > still should be fixed, as it is a more severe bug waiting to happen.
> 
> It might be better to combine request_key_auth_destroy() and the error path
> that you're altering in request_key_auth_new() by pulling it into a separate
> function.
> 
> David

Agreed, I'll do that.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

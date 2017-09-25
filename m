From: dhowells@redhat.com (David Howells)
Date: Mon, 25 Sep 2017 15:18:57 +0100
Subject: [PATCH v2 1/3] KEYS: fix cred refcount leak in
	request_key_auth_new()
In-Reply-To: <20170921205742.144596-2-ebiggers3@gmail.com>
References: <20170921205742.144596-2-ebiggers3@gmail.com>
	<20170921205742.144596-1-ebiggers3@gmail.com>
Message-ID: <30852.1506349137@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> +	rka = kzalloc(sizeof(*rka), GFP_KERNEL);
> +	if (!rka)
> +		goto error_free_rka;

But you haven't allocated an rka if you're in the error path.  I'll fix that
to jump over the release.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: dhowells@redhat.com (David Howells)
Date: Fri, 02 Jun 2017 16:34:44 +0100
Subject: [PATCH 1/5] KEYS: sanitize add_key() and keyctl() key payloads
In-Reply-To: <20170421083037.12746-2-ebiggers3@gmail.com>
References: <20170421083037.12746-2-ebiggers3@gmail.com>
	<20170421083037.12746-1-ebiggers3@gmail.com>
Message-ID: <5744.1496417684@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

>  error2:
> +	memzero_explicit(payload, plen);

Isn't that wrong?  payload can be NULL.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

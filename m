From: dhowells@redhat.com (David Howells)
Date: Mon, 24 Apr 2017 15:14:54 +0100
Subject: [PATCH 3/5] KEYS: encrypted: sanitize all key material
In-Reply-To: <20170421182418.GA12755@gmail.com>
References: <20170421182418.GA12755@gmail.com>
	<20170421083037.12746-4-ebiggers3@gmail.com>
	<20170421083037.12746-1-ebiggers3@gmail.com>
	<28373.1492785068@warthog.procyon.org.uk>
Message-ID: <28151.1493043294@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> It's not actually needed because it's impossible for the compiler to optimize
> away the memset().  memzero_explicit() is only needed on stack data.

Okay, also reasonable.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

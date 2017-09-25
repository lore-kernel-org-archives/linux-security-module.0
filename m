From: dhowells@redhat.com (David Howells)
Date: Mon, 25 Sep 2017 15:43:59 +0100
Subject: [PATCH v7 2/2] security/keys: rewrite all of big_key crypto
In-Reply-To: <20170920145839.27511-2-Jason@zx2c4.com>
References: <20170920145839.27511-2-Jason@zx2c4.com>
	<20170920145839.27511-1-Jason@zx2c4.com>
Message-ID: <32200.1506350639@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> +	/* no ->update(); don't add it without changing big_key_crypt() nonce */

Should update be a problem.  It's should be a complete payload replacement -
kind of like unlink and add, but keeping the same key ID and description.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

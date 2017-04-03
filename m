From: dhowells@redhat.com (David Howells)
Date: Mon, 03 Apr 2017 16:46:42 +0100
Subject: [PATCH] KEYS: fix dereferencing NULL payload with nonzero length
In-Reply-To: <20170401213428.17097-1-ebiggers3@gmail.com>
References: <20170401213428.17097-1-ebiggers3@gmail.com>
Message-ID: <3451.1491234402@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> -	if (_payload) {
> +	if (plen) {

"if (_payload && plen)" would be better.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

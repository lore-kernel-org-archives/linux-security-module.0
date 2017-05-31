From: ebiggers3@gmail.com (Eric Biggers)
Date: Wed, 31 May 2017 12:07:42 -0700
Subject: [PATCH] KEYS: fix freeing uninitialized memory in key_update()
In-Reply-To: <3742.1491234534@warthog.procyon.org.uk>
References: <20170401223645.29528-1-ebiggers3@gmail.com>
	<3742.1491234534@warthog.procyon.org.uk>
Message-ID: <20170531190742.GA72735@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Apr 03, 2017 at 04:48:54PM +0100, David Howells wrote:
> Pulled.

David, where was this pulled to?  It's not in keys-next at
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git.  Nor did
it show up in v4.12-rc1.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

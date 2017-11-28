From: dhowells@redhat.com (David Howells)
Date: Tue, 28 Nov 2017 10:13:01 +0000
Subject: [PATCH] KEYS: add missing permission check for request_key()
	destination
In-Reply-To: <20171120225830.96642-1-ebiggers3@gmail.com>
References: <20171120225830.96642-1-ebiggers3@gmail.com>
Message-ID: <7849.1511863981@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> +		if (do_perm_check) {
> +			ret = key_permission(make_key_ref(dest_keyring, 1),
> +					     KEY_NEED_WRITE);

dest_keyring may be NULL at this point as alloc_uid() doesn't automatically
create keyrings.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

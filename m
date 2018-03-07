From: dhowells@redhat.com (David Howells)
Date: Wed, 07 Mar 2018 16:03:18 +0000
Subject: [PATCH 1/3] certs: define a trusted platform keyring
In-Reply-To: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
References: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
Message-ID: <31489.1520438598@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Nayna Jain <nayna@linux.vnet.ibm.com> wrote:

> +		key = key_create_or_update(make_key_ref(keyring, 1),
> +				"asymmetric",
> +				NULL,
> +				p,
> +				plen,
> +				((KEY_POS_ALL & ~KEY_POS_SETATTR) |
> +				 KEY_USR_VIEW | KEY_USR_READ),
> +				KEY_ALLOC_NOT_IN_QUOTA |
> +				KEY_ALLOC_BUILT_IN |
> +				KEY_ALLOC_BYPASS_RESTRICTION);

There's no need to reindent here.  Please line up all the arguments: either
push the first argument over onto the next line if you need to or line them
all up with the char after the opening bracket.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

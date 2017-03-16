From: dhowells@redhat.com (David Howells)
Date: Thu, 16 Mar 2017 10:09:19 +0000
Subject: [PATCH v12 05/10] KEYS: Add an optional lookup_restriction hook
	to key_type
In-Reply-To: <20170309202315.15361-6-mathew.j.martineau@linux.intel.com>
References: <20170309202315.15361-6-mathew.j.martineau@linux.intel.com>
	<20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
Message-ID: <23549.1489658959@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:

> +	/* Look up a keyring access restriction (optional)
> +	 *
> +	 * - The caller must hold a read lock on the key type's semaphore
> +	 * - NULL is a valid return value (meaning the requested restriction
> +	 *   is known but will never block addition of a key)
> +	 * - should return -EINVAL if the restriction is unknown
> +	 */
> +	struct key_restriction *(*lookup_restriction)(const char *params);

I wonder if this can be improved in future to using the rcu read lock instead
of a semaphore.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

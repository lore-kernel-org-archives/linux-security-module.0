From: dhowells@redhat.com (David Howells)
Date: Thu, 16 Mar 2017 10:00:26 +0000
Subject: [PATCH v12 02/10] KEYS: Split role of the keyring pointer for
	keyring restrict functions
In-Reply-To: <20170309202315.15361-3-mathew.j.martineau@linux.intel.com>
References: <20170309202315.15361-3-mathew.j.martineau@linux.intel.com>
	<20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
Message-ID: <23396.1489658426@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:

> +			       void *data)
>  {
>  	const struct public_key_signature *sig;
>  	struct key *key;
>  	int ret;
> +	struct key *trust_keyring = (struct key *) data;

The cast is unnecessary, but let that pass unless the patches get respun
again.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

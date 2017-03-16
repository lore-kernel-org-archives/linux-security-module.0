From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Thu, 16 Mar 2017 16:02:07 -0700 (PDT)
Subject: [PATCH v12 05/10] KEYS: Add an optional lookup_restriction hook
	to key_type
In-Reply-To: <23549.1489658959@warthog.procyon.org.uk>
References: <20170309202315.15361-6-mathew.j.martineau@linux.intel.com>
	<20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
	<23549.1489658959@warthog.procyon.org.uk>
Message-ID: <alpine.OSX.2.20.1703161542010.36452@suhwanki-mobl.amr.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


On Thu, 16 Mar 2017, David Howells wrote:

> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
>
>> +	/* Look up a keyring access restriction (optional)
>> +	 *
>> +	 * - The caller must hold a read lock on the key type's semaphore
>> +	 * - NULL is a valid return value (meaning the requested restriction
>> +	 *   is known but will never block addition of a key)
>> +	 * - should return -EINVAL if the restriction is unknown
>> +	 */
>> +	struct key_restriction *(*lookup_restriction)(const char *params);
>
> I wonder if this can be improved in future to using the rcu read lock instead
> of a semaphore.

I'll update this comment to remove the read lock line, since the patch 
adding the key type semaphore has been dropped. The comment here was not 
really needed anyway, it should be obvious that the key type can't go away 
while you're calling in to it.

--
Mat Martineau
Intel OTC
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

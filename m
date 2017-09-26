From: ebiggers3@gmail.com (Eric Biggers)
Date: Tue, 26 Sep 2017 13:39:09 -0700
Subject: [PATCH v2 1/6] KEYS: fix race between updating and finding
	negative key
In-Reply-To: <20170926201105.126166-2-ebiggers3@gmail.com>
References: <20170926201105.126166-1-ebiggers3@gmail.com>
	<20170926201105.126166-2-ebiggers3@gmail.com>
Message-ID: <20170926203909.GA126069@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 26, 2017 at 01:11:00PM -0700, Eric Biggers wrote:
> +static void mark_key_instantiated(struct key *key, unsigned int reject_error)
> +{
> +	unsigned long old, new;
> +
> +	do {
> +		old = READ_ONCE(key->flags);
> +		new = (old & ~(KEY_FLAG_NEGATIVE |
> +			       KEY_FLAGS_REJECT_ERROR_MASK)) |
> +		      KEY_FLAG_INSTANTIATED |
> +		      (reject_error ? KEY_FLAG_NEGATIVE : 0) |
> +		      (reject_error << KEY_FLAGS_REJECT_ERROR_SHIFT);
> +	} while (cmpxchg_release(&key->flags, old, new) != old);
> +}

Sorry, I realized I screwed this up --- the flags like KEY_FLAG_NEGATIVE need to
be (1 << KEY_FLAG_NEGATIVE).  I'll send another version which will be better
tested...

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

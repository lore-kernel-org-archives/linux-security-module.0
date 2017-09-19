From: dhowells@redhat.com (David Howells)
Date: Tue, 19 Sep 2017 17:09:02 +0100
Subject: [PATCH] KEYS: prevent KEYCTL_READ on negative key
In-Reply-To: <20170918183723.114253-1-ebiggers3@gmail.com>
References: <20170918183723.114253-1-ebiggers3@gmail.com>
Message-ID: <30124.1505837342@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> +	if (test_bit(KEY_FLAG_NEGATIVE, &key->flags)) {
> +		ret = -ENOKEY;
> +		goto error2;
> +	}

It might be better to do this check in key_validate().  Also, it should
perhaps take the error from key->reject_error.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

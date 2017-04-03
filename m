From: dhowells@redhat.com (David Howells)
Date: Mon, 03 Apr 2017 16:52:02 +0100
Subject: [PATCH] KEYS: fix keyctl_set_reqkey_keyring() to not leak thread
	keyrings
In-Reply-To: <20170401233908.20786-1-ebiggers3@gmail.com>
References: <20170401233908.20786-1-ebiggers3@gmail.com>
Message-ID: <3785.1491234722@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> @@ -135,6 +135,9 @@ int install_thread_keyring_to_cred(struct cred *new)
>  {
>  	struct key *keyring;
>  
> +	if (new->thread_keyring)
> +		return -EEXIST;
> +
>  	keyring = keyring_alloc("_tid", new->uid, new->gid, new,
>  				KEY_POS_ALL | KEY_USR_VIEW,
>  				KEY_ALLOC_QUOTA_OVERRUN,

It would probably be better just to return 0 and change the comment on the
function to say that it sets a thread keyring if there isn't one already.
Same for the process keyring.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

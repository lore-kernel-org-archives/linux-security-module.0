From: why2jjj.linux@gmail.com (J Freyensee)
Date: Wed, 30 May 2018 14:22:40 -0700
Subject: [PATCH V3 3/5 selinux-next] selinux: sidtab_clone switch to use
	rwlock.
In-Reply-To: <20180530141104.28569-4-peter.enderborg@sony.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
	<20180530141104.28569-4-peter.enderborg@sony.com>
Message-ID: <c41e327f-9bf8-a2f1-bf6f-326357d5ed8b@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


>   
> +int sidtab_clone(struct sidtab *s, struct sidtab *d)
> +{
> +	int i, rc = 0;
If s or d are NULL (see if() below), why would we want rc, the return 
value, to be 0?? How about defaulting rc to an error value (-EINVAL)?
> +	struct sidtab_node *cur;
> +
> +	if (!s || !d)
> +		goto errout;
> +
> +	read_lock(&s->lock);
> +	for (i = 0; i < SIDTAB_SIZE; i++) {
> +		cur = s->htable[i];
> +		while (cur) {
> +			if (cur->sid > SECINITSID_NUM)
> +				rc =  sidtab_insert(d, cur->sid, &cur->context);
> +			if (rc)
> +				goto out;
> +			cur = cur->next;
> +		}
> +	}
> +out:
> +	read_unlock(&s->lock);
> +errout:
> +	return rc;
> +}
>
Thanks,
Jay
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: kent.overstreet@gmail.com (Kent Overstreet)
Date: Sat, 26 May 2018 01:56:01 -0400
Subject: [PATCH 1/6] Generic radix trees
In-Reply-To: <CANQeFDCLc56thuuGYBMdb_qvw_O=t7sLkJiP-LNYfKwgz74H_w@mail.gmail.com>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
	<CANQeFDCLc56thuuGYBMdb_qvw_O=t7sLkJiP-LNYfKwgz74H_w@mail.gmail.com>
Message-ID: <20180526055601.GA26155@kmo-pixel>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, May 26, 2018 at 11:16:42AM +0800, Liu Bo wrote:
> > +/*
> > + * Returns pointer to the specified byte @offset within @radix, allocating it if
> > + * necessary - newly allocated slots are always zeroed out:
> > + */
> > +void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
> > +                          gfp_t gfp_mask)
> > +{
> > +       struct genradix_node **n;
> 
> Any reason that " struct genradix_node ** " is used here instead of "
> struct genradix_node * "?
> 
> Looks like this function only manipulates *n, am I missing something?

It stores to *n, when it has to allocate a node (including the root)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

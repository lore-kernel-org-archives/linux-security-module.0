From: obuil.liubo@gmail.com (Liu Bo)
Date: Tue, 29 May 2018 09:48:20 +0800
Subject: [PATCH 1/6] Generic radix trees
In-Reply-To: <20180526055601.GA26155@kmo-pixel>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
	<CANQeFDCLc56thuuGYBMdb_qvw_O=t7sLkJiP-LNYfKwgz74H_w@mail.gmail.com>
	<20180526055601.GA26155@kmo-pixel>
Message-ID: <CANQeFDBGzxF0r-+dxp5jcRnOCe8NgEzRgmc-84bGRBqiYg5KhA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, May 26, 2018 at 1:56 PM, Kent Overstreet
<kent.overstreet@gmail.com> wrote:
> On Sat, May 26, 2018 at 11:16:42AM +0800, Liu Bo wrote:
>> > +/*
>> > + * Returns pointer to the specified byte @offset within @radix, allocating it if
>> > + * necessary - newly allocated slots are always zeroed out:
>> > + */
>> > +void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
>> > +                          gfp_t gfp_mask)
>> > +{
>> > +       struct genradix_node **n;
>>
>> Any reason that " struct genradix_node ** " is used here instead of "
>> struct genradix_node * "?
>>
>> Looks like this function only manipulates *n, am I missing something?
>
> It stores to *n, when it has to allocate a node (including the root)

I see, thanks for the explanation.

thanks,
liubo
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

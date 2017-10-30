From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 30 Oct 2017 13:00:27 -0400
Subject: [RFC PATCH] ima: require secure_boot rules in lockdown mode
In-Reply-To: <750.1509378910@warthog.procyon.org.uk>
References: <1508774387.3639.128.camel@linux.vnet.ibm.com>
	<750.1509378910@warthog.procyon.org.uk>
Message-ID: <1509382827.3583.143.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-10-30 at 15:55 +0000, David Howells wrote:
> I've added this into my series as the third patch, but:
> 
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > +			ima_use_appraise_tcb = TRUE;
> 
> Did you mean "true" rather than "TRUE"?

Yes, of course. ?Commit 9f4b6a254d7a "ima: Fix bool
initialization/comparison" already addresses it. ?Please remove it
from this patch.

> 
> > +			entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> > +			if (entry) {
> > +				memcpy(entry, &secure_boot_rules[i],
> > +				       sizeof(*entry));
> 
> kmemdup()?

Probably

> 
> I guess also that oopsing is okay if the allocation fails.  We've run out of
> memory during early boot, after all.

If the memory allocation fails, the "secure_boot" policy will not be
enabled for custom policies, but how is that "oopsing". ?If it fails,
there needs to be some indication of the failure, which there
currently isn't. ?Perhaps also prevent loading a custom policy.

> 
> > +				INIT_LIST_HEAD(&entry->list);
> > +				list_add_tail(&entry->list, &ima_policy_rules);
> 
> Isn't the init redundant, given the following line?

ok

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

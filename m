From: dhowells@redhat.com (David Howells)
Date: Mon, 30 Oct 2017 15:55:10 +0000
Subject: [RFC PATCH] ima: require secure_boot rules in lockdown mode
In-Reply-To: <1508774387.3639.128.camel@linux.vnet.ibm.com>
References: <1508774387.3639.128.camel@linux.vnet.ibm.com>
Message-ID: <750.1509378910@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I've added this into my series as the third patch, but:

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> +			ima_use_appraise_tcb = TRUE;

Did you mean "true" rather than "TRUE"?

> +			entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +			if (entry) {
> +				memcpy(entry, &secure_boot_rules[i],
> +				       sizeof(*entry));

kmemdup()?

I guess also that oopsing is okay if the allocation fails.  We've run out of
memory during early boot, after all.

> +				INIT_LIST_HEAD(&entry->list);
> +				list_add_tail(&entry->list, &ima_policy_rules);

Isn't the init redundant, given the following line?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

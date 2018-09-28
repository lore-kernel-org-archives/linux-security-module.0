From: zohar@linux.ibm.com (Mimi Zohar)
Date: Thu, 27 Sep 2018 20:51:38 -0400
Subject: [PATCH v4 3/6] ima: refactor ima_init_policy()
In-Reply-To: <20180926122210.14642-4-nayna@linux.vnet.ibm.com>
References: <20180926122210.14642-1-nayna@linux.vnet.ibm.com>
	<20180926122210.14642-4-nayna@linux.vnet.ibm.com>
Message-ID: <1538095898.3459.140.camel@linux.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Nayna,

On Wed, 2018-09-26 at 17:52 +0530, Nayna Jain wrote:

> +static void add_rules(struct ima_rule_entry *entries, int count,
> +		      enum policy_rule_list file)

Using "file" to refer to the policy_rule_list enumeration is unusual.
?Please change the variable name to something more appropriate.

Mimi

> +{
> +	int i = 0;
> +
> +	for (i = 0; i < count; i++) {
> +		struct ima_rule_entry *entry;
> +
> +		if (file & IMA_DEFAULT_POLICY)
> +			list_add_tail(&entries[i].list, &ima_default_rules);
> +
> +		if (file & IMA_CUSTOM_POLICY) {
> +			entry = kmemdup(&entries[i], sizeof(*entry),
> +					GFP_KERNEL);
> +			if (!entry)
> +				continue;
> +
> +			INIT_LIST_HEAD(&entry->list);
> +			list_add_tail(&entry->list, &ima_policy_rules);
> +		}
> +		if (entries[i].action == APPRAISE)
> +			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
> +		if (entries[i].func == POLICY_CHECK)
> +			temp_ima_appraise |= IMA_APPRAISE_POLICY;
> +	}
> +}
> +
